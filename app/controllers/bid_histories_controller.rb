class BidHistoriesController < ApplicationController
  before_action :set_bid_history, only: [:show, :edit, :update, :destroy]

  # GET /bid_histories
  # GET /bid_histories.json
  def index
    @bid_histories = BidHistory.all
  end

  # GET /bid_histories/1
  # GET /bid_histories/1.json
  def show
  end

  # GET /bid_histories/new
  def new
    @bid_history = BidHistory.new
  end

  # GET /bid_histories/1/edit
  def edit
  end

  # POST /bid_histories
  # POST /bid_histories.json
  def create
    @bid_history = BidHistory.new(bid_history_params)

    respond_to do |format|
      if @bid_history.save
        format.html { redirect_to @bid_history, notice: 'Bid history was successfully created.' }
        format.json { render :show, status: :created, location: @bid_history }
      else
        format.html { render :new }
        format.json { render json: @bid_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bid_histories/1
  # PATCH/PUT /bid_histories/1.json
  def update
    respond_to do |format|
      if @bid_history.update(bid_history_params)
        format.html { redirect_to @bid_history, notice: 'Bid history was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid_history }
      else
        format.html { render :edit }
        format.json { render json: @bid_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bid_histories/1
  # DELETE /bid_histories/1.json
  def destroy
    @bid_history.destroy
    respond_to do |format|
      format.html { redirect_to bid_histories_url, notice: 'Bid history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid_history
      @bid_history = BidHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_history_params
      params.require(:bid_history).permit(:user_id, :order_id, :price)
    end
end
