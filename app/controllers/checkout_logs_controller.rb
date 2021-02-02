class CheckoutLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin, except: [:borrow, :return]
  before_action :get_book, except: [:borrow, :return]
  before_action :set_checkout_log, only: [:show, :edit, :update, :destroy]

  # GET /checkout_logs
  # GET /checkout_logs.json
  def index
    @checkout_logs = @book.checkout_logs.paginate(page: params[:page]).order(:checkout_date)
  end

  # GET /checkout_logs/1
  # GET /checkout_logs/1.json
  def show    
  end

  # GET /checkout_logs/new
  def new
    @checkout_log = @book.checkout_logs.build
  end

  # GET /checkout_logs/1/edit
  def edit
  end

  #borrow book, create new checkout_log with duedate in 1 week
  #refactor create code  
  def borrow
    #take one book that matches book_number and doesn't have a checkout_log record with a null returned_date (ie an available book of book_number)
    @book = Book.where(book_number: params[:book_number], library_id: params[:library_id]).where.not(id: CheckoutLog.where(returned_date: nil).pluck(:book_id)).take 
    
    if @book
      @checkout_log = CheckoutLog.new(:checkout_date => Time.now,
                                    :due_date => Time.now + 1.week,
                                    :returned_date => :null,
                                    :user_id => current_user.id,
                                    :book_id => @book.id)
    else
      redirect_to books_listing_path, notice: 'None of those Books are currently available.' and return   
    end

    respond_to do |format|
      if @checkout_log.save
        format.html { redirect_to books_listing_path, notice: 'Book was successfully borrowed.' }
        format.json { render :show, status: :created, location: @checkout_log }
      else
        format.html { render :new }
        format.json { render json: @checkout_log.errors, status: :unprocessable_entity }
      end
    end    
  end

  #return book, update checkout_log returned_date to current time.  
  def return
    @checkout_log = CheckoutLog.find(params[:checkout_log_id])
    #verify correct user is trying to return this book 
    if @checkout_log.user_id == current_user.id
      #send out all return notifications
      #abort @checkout_log.inspect
      @book = Book.where(id: @checkout_log.book_id).take
      #abort @book.book_number.inspect
      @return_notifications = ReturnNotification.where(book_number: @book.book_number, library_id: @book.library_id)
#abort @return_notifications.inspect
      @return_notifications.find_each do |notification|
        user = User.where(:id => notification.user_id).take
        #abort user.inspect
        @book = Book.where(:book_number => notification.book_number, :library_id => notification.library_id).take        
        #abort @book.inspect
        ReturnNotificationMailer.with(user: user, book: @book).return_notifications.deliver_now
        #destroy returnnotification or flag it (add new column to database table)
      end

      respond_to do |format|
        if @checkout_log.update(:returned_date => Time.now)
          format.html { redirect_to books_my_books_path, notice: 'Book was successfully returned.' }
          format.json { render :show, status: :ok, location: @checkout_log }
        else
          format.html { render :edit }
          format.json { render json: @checkout_log.errors, status: :unprocessable_entity }
        end
      end
    else
      #wrong user trying to return someone elses book
      redirect_to root_path
    end
  end


  # POST /checkout_logs
  # POST /checkout_logs.json
  def create
    @checkout_log = CheckoutLog.new(checkout_log_params)

    respond_to do |format|
      if @checkout_log.save
        format.html { redirect_to book_checkout_logs_path(@book), notice: 'Checkout log was successfully created.' }
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
        format.html { redirect_to book_checkout_logs_path(@book), notice: 'Checkout log was successfully updated.' }
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
      format.html { redirect_to book_checkout_logs_path(@book), notice: 'Checkout log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private    
    #get book associated with this checkout_log
    def get_book
        @book = Book.find(params[:book_id])           
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout_log
      @checkout_log = @book.checkout_logs.find(params[:id])      
    end

    # Only allow a list of trusted parameters through.
    def checkout_log_params
      params.require(:checkout_log).permit(:checkout_date, :due_date, :returned_date, :user_id, :book_id)
    end
end
