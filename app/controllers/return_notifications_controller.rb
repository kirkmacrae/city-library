class ReturnNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin
  before_action :set_return_notification, only: %w[ show edit update destroy ]
  before_action :set_libraries, only: [:new,:edit]

  # GET /return_notifications
  # GET /return_notifications.json
  def index
    @return_notifications = ReturnNotification.all
  end

  # GET /return_notifications/1
  # GET /return_notifications/1.json
  def show
  end

  # GET /return_notifications/new
  def new
    @return_notification = ReturnNotification.new
  end

  # GET /return_notifications/1/edit
  def edit    
  end

  # POST /return_notifications
  # POST /return_notifications.json
  def create
    @return_notification = ReturnNotification.new(return_notification_params)

    respond_to do |format|
      if @return_notification.save
        format.html { redirect_to @return_notification, notice: "Return notification was successfully created." }
        format.json { render :show, status: :created, location: @return_notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @return_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /return_notifications/1
  # PATCH/PUT /return_notifications/1.json
  def update
    respond_to do |format|
      if @return_notification.update(return_notification_params)
        format.html { redirect_to @return_notification, notice: "Return notification was successfully updated." }
        format.json { render :show, status: :ok, location: @return_notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @return_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /return_notifications/1
  # DELETE /return_notifications/1.json
  def destroy
    @return_notification.destroy
    respond_to do |format|
      format.html { redirect_to return_notifications_url, notice: "Return notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_libraries
      @libraries = Library.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_return_notification
      @return_notification = ReturnNotification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def return_notification_params
      params.require(:return_notification).permit(:user_id, :book_number, :library_id)
    end
end
