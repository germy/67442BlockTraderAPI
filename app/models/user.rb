class User < ActiveRecord::Base

  validates_presence_of :email, :on => :create    
  
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
    
  
  def self.authenticate(login_name)
    user = self.where("email =?", login_name).first
  end   
    
  def to_json(options={})
    options[:except] ||= [:id, :created_at, :updated_at]
    super(options)
  end    
end