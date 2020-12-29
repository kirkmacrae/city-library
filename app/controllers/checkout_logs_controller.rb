class CheckoutLogsController < ApplicationController
  before_action :set_checkout_log, only: [:show, :edit, :update, :destroy]

  # GET /checkout_logs
  # GET /checkout_logs.json
  def index
    @checkout_logs = CheckoutLog.all
  end

  # GET /checkout_logs/1
  # GET /checkout_logs/1.json
  def show
  end

  # GET /checkout_logs/new
  def new
    @checkout_log = CheckoutLog.new
  end

  # GET /checkout_logs/1/edit
  def edit
  end

  # POST /checkout_logs
  # POST /checkout_logs.json
  def create
    @checkout_log = CheckoutLog.new(checkout_log_params)

    respond_to do |format|
      if @checkout_log.save
        format.html { redirect_to @checkout_log, notice: 'Checkout log was successfully created.' }
        format.json { render :show, status: :created, location: @checkout_log }
      else
        format.html { render :new }
        format.json { render json: @checkout_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkout_logs/1
  # PATCH/PUT /checkout_logs/1.json
  def update
    respond_to do |format|
      if @checkout_log.update(checkout_log_params)
        format.html { redirect_to @checkout_log, notice: 'Checkout log was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout_log }
      else
        format.html { render :edit }
        format.json { render json: @checkout_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkout_logs/1
  # DELETE /checkout_logs/1.json
  def destroy
    @checkout_log.destroy
    respond_to do |format|
      format.html { redirect_to checkout_logs_url, notice: 'Checkout log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout_log
      @checkout_log = CheckoutLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checkout_log_params
      params.require(:checkout_log).permit(:CheckoutDate, :DueDate, :ReturnedDate, :user_id, :book_id)
    end
end
