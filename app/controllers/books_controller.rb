class BooksController < ApplicationController
  # do the find book action for these actions
  before_action :find_book, only: %i[ show edit update destroy ]

  def index
    # get all books from Book model, order is desc
    @books = Book.all.order("created_at DESC")
  end

  # show a book
  def show
    # find a particular book, write as private method
  end

  def new
    # @book is what we used in view
    @book = Book.new
  end

  def edit

  end

  def update
    # if a book is update successfully, passing book params
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  # Note: it is troy !!
  def destroy
    @book.destroy
    redirect_to root_path
  end

  def create
    @book = Book.new(book_params)
    # if the book instance is saved in Book model, redirect to root path
    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def book_params
    # user fill information in a form
    params.require(:book).permit(:title, :description, :author)
  end

  def find_book
    # find a particular book
    @book = Book.find(params[:id])
  end
end


