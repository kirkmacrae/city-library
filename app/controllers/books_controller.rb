class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:listing]
  before_action :is_admin, except: [:listing, :my_books]
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_copy]
  before_action :set_libraries, only: [:new, :edit]

  # GET /books
  # GET /books.json
  def index    
    @books = Book.paginate(page: params[:page]).order(:title, :library_id)
  end

  # a list of all unique books
  # GET /books/listing
  def listing
    #TODO: find cleaner way to build this
    if current_user&.id
      user_id = current_user.id
    else
      user_id = 0
    end

    sql = "select
    title,
    author,
    genre,
    subgenre,
    pages,
    publisher,
    book.book_number,    
    count(book.book_number) as copies,
    count(log.book_id) as borrowed_copies,
    lib.name,
    book.library_id,
    notify.library_id,
    notify.book_number
    from books as book
    
    left join (
    select distinct
    book_id
    from checkout_logs
    where returned_date is null
    ) as log
    ON book.id = log.book_id

    left join (select * from libraries) lib
    ON lib.id = book.library_id

    left join (select * from return_notifications where user_id = #{ActiveRecord::Base.sanitize_sql(user_id)} ) notify
    ON 
    notify.book_number = book.book_number AND notify.library_id = lib.id
	
    group by 1,2,3,4,5,6,7,10,11,12,13
    ORDER BY book.title"
    @books = ActiveRecord::Base.connection.execute(sql).values
  end

  def details
    #TODO: find cleaner way to build this    
    @book = Book.where(book_number: params[:book_number], library_id: params[:library_id]).take  
    sql = "SELECT DISTINCT ON (books.id)
    books.id, users.email, c.returned_date, c.due_date
    FROM checkout_logs c
    RIGHT JOIN books
    ON c.book_id = books.id
    LEFT JOIN users
    on c.user_id = users.id
    where books.book_number = #{ActiveRecord::Base.sanitize_sql(params[:book_number])} and books.library_id = #{ActiveRecord::Base.sanitize_sql(params[:library_id])}
    ORDER BY books.id, c.returned_date DESC
    " 

    @checkout_logs = ActiveRecord::Base.connection.execute(sql).values
  end

  #list books for current user that are borrowed
  def my_books    
    @checkout_logs = CheckoutLog.joins(:book).where(checkout_logs: {user_id: current_user.id, returned_date: nil})  
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @checkout_logs = CheckoutLog.joins(:book).where(checkout_logs: {book_id: @book.id})
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create    
    @next_book_number = Book.maximum(:book_number).to_i.next
    #initially assign the next available book_number to this book
    @book = Book.new(book_params.merge!(:book_number => @next_book_number))
    @existing_identical_book = Book.where(title: @book.title,
                                          author: @book.author,
                                          genre: @book.genre,
                                          subgenre: @book.subgenre,
                                          pages: @book.pages,
                                          publisher: @book.publisher).take
    #if an existing identical book exists, then make the book_number match before saving the new book to database
    if @existing_identical_book
      @book.book_number = @existing_identical_book.book_number  
    end                                        

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  #add another copy of an existing book
  def add_copy    
    @book_new_copy = @book.dup                       

    respond_to do |format|
      if @book_new_copy.save
        format.html { redirect_to @book_new_copy, notice: 'Copy was successfully created.' }
        format.json { render :show, status: :created, location: @book_new_copy }
      else
        format.html { render :new }
        format.json { render json: @book_new_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json  
  def update    
    @existing_identical_book = Book.where(title: book_params[:title],
                                          author: book_params[:author],
                                          genre: book_params[:genre],
                                          subgenre: book_params[:subgenre],
                                          pages: book_params[:pages],
                                          publisher: book_params[:publisher]
                                        ).take
    #if an existing identical book exists, then make the book_number match otherwise set to a new book_number
    if @existing_identical_book
      params[:book_number] = @existing_identical_book.book_number  
    else
      params[:book_number] = Book.maximum(:book_number).to_i.next
    end

    respond_to do |format|
      if @book.update(book_params.merge!(:book_number => params[:book_number]))
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_libraries
      @libraries = Library.all
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :genre, :subgenre, :pages, :publisher,:book_number, :library_id)
    end
end
