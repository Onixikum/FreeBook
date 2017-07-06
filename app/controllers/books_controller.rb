class BooksController < ApplicationController

  def index
    @books = Book.paginate(page: params[:page], per_page: 15)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "The book has been successfully added"
      redirect_to (books_path)
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Book updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Book deleted"
    redirect_to root_url
  end

  private

    def book_params
      params.require(:book).permit(:name, :author, :description)
    end
end
