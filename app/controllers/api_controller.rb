require 'net/http'
require 'json'

class ApiController < ApplicationController  
  #before_filter :check_for_valid_authtoken, :except => [:signin, :get_token]

  def index
    render :html => "congrats"
  end
  
  #this method simply recieves the first and last name, emaili and accesstoken
  #after verifying the accesstoken, it either creates a new account or signs in 
  #an existing user; either case passes back a token
  
  def signin
    puts params
    if request.post?

      if params && params[:email] && params[:accessToken]   
        user = User.where(:email => params[:email]).first           
        if user 
          if User.authenticate(params[:email]) && check_fb_accesstoken(params[:accessToken], params[:fb_id])
            if !user.api_authtoken || (user.api_authtoken && user.authtoken_expiry < Time.now)
              auth_token = rand_string(20)
              auth_expiry = Time.now + (24*60*60)
              user.update_attributes(:api_authtoken => auth_token, :authtoken_expiry => auth_expiry)   
            end 
                                   
            render :json => user.to_json, :status => 200
          else
            e = Error.new(:status => 401, :message => "Wrong Password")
            render :json => e.to_json, :status => 401
          end      
        else
          params[:user] = Hash.new    
          params[:user][:first_name] = params[:name].split(" ").first
          params[:user][:last_name] = params[:name].split(" ").last
          params[:user][:email] = params[:email]
          params[:user][:fb_id] = params[:fb_id]
          if check_fb_accesstoken(params[:accessToken], params[:fb_id]) == false
            e = Error.new(:status => 400, :message => "facebook token cannot be verified")
            render :json => e.to_json, :status => 400
          end
          user = User.new(user_params)
          auth_token = rand_string(20)
          auth_expiry = Time.now + (24*60*60)
          user.update_attributes(:api_authtoken => auth_token, :authtoken_expiry => auth_expiry)  
          render :json => user.to_json, :status => 200
        end
      else
        e = Error.new(:status => 400, :message => "required parameters are missing")
        render :json => e.to_json, :status => 400
      end
    end
  end
  
  def get_token
    if params && params[:email]    
      user = User.where(:email => params[:email]).first
    
      if user 
        if !user.api_authtoken || (user.api_authtoken && user.authtoken_expiry < Time.now)          
          auth_token = rand_string(20)
          auth_expiry = Time.now + (24*60*60)
          
          user.update_attributes(:api_authtoken => auth_token, :authtoken_expiry => auth_expiry)                              
        end        
        
        render :json => user.to_json(:only => [:api_authtoken, :authtoken_expiry])                
      else
        e = Error.new(:status => 400, :message => "No user record found for this email ID")
        render :json => e.to_json, :status => 400
      end
      
    else
      e = Error.new(:status => 400, :message => "required parameters are missing")
      render :json => e.to_json, :status => 400
    end
  end

  def clear_token
    if @user.api_authtoken && @user.authtoken_expiry > Time.now
      @user.update_attributes(:api_authtoken => nil, :authtoken_expiry => nil)
          
      m = Message.new(:status => 200, :message => "Token cleared")          
      render :json => m.to_json, :status => 200  
    else
      e = Error.new(:status => 401, :message => "You don't have permission to do this task")
      render :json => e.to_json, :status => 401
    end 
  end

  private 
  
  def check_fb_accesstoken(token, id)
    url_ = 'https://graph.facebook.com/me?access_token=' + token.to_s
    result = Net::HTTP.get(URI.parse(url_.to_s))
    json = JSON.parse(result)
    if(json["id"].to_s == id.to_s)
      return true
    end
    return false
  end
  
  def check_for_valid_authtoken
    authenticate_or_request_with_http_token do |token, options|     
      @user = User.where(:api_authtoken => token).first      
    end
  end
  
  #send token in header (get request)
  #GET /episodes HTTP/1.1
  #Host: localhost:3000
  #Authorization: Token token=123123123
  
  def rand_string(len)
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    string  =  (0..len).map{ o[rand(o.length)]  }.join

    return string
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :fb_id, :email, :accessToken,
     :api_authtoken, :authtoken_expiry)
  end
 
    
end