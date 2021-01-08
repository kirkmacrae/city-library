class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_copy]

  # GET /books
  # GET /books.json
  def index    
    @books = Book.all
  end

  # a list of all unique books
  # GET /books/listing
  def listing
    #TODO: substract number of books that haven't been returned yet from 'copies' to get number of available books
    @books = Book.select(
      [
        :title, :author, :genre, :subgenre, :pages, :publisher, :book_number, Book.arel_table[:book_number].count.as('copies')
      ]
    ).group(
      :book_number, :title, :author, :genre, :subgenre, :pages, :publisher
    )
  end

  #list books for current user that are borrowed
  def my_books
    #join books and checkoutlogs, where user_id = current_user.id and returned_date = null
    @checkoutlogs = CheckoutLog.joins(:book).where(checkout_logs: {user_id: current_user.id, returned_date: nil})    
  end

  # GET /books/1
  # GET /books/1.json
  def show
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
    @next_book_number = (Book.maximum(:book_number)) + 1
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
  #TODO: ensure book_number is correct after edit/update
  def update
    respond_to do |format|
      if @book.update(book_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :genre, :subgenre, :pages, :publisher,:book_number)
    end
end
