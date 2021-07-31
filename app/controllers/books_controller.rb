class BooksController < ApplicationController
  # do the find book action for these actions
  before_action :find_book, only: %i[ show edit update destroy ]

  def index
    if params[:category].blank?
      @books = Book.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id)
    end
    # get all books from Book model, order is desc

  end

  # show a book
  def show
    # find a particular book, write as private method
  end

  def new
    # @book is what we used in view
    # build book for current user
    @book = current_user.books.build
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def edit
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def create
    @book = current_user.books.build(book_params)
    # when we create our select_tag for the drop down, options_for_select requires an array
    # of arrays, which provide the text for the drop down (its name) and the value it represents
    # (its id attribute)
    @book.category_id = params[:category_id]
    # if the book instance is saved in Book model, redirect to root path
    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @categories = Category.all.map{|c| [c.name, c.id]}
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

  private
  def book_params
    # user fill information in a form
    params.require(:book).permit(:title, :description, :author, :category_id)
  end

  def find_book
    # find a particular book
    @book = Book.find(params[:id])
  end
end


