class Admin::BooksController < ApplicationController
  load_and_authorize_resource
  before_action :load_books, only: [:edit, :update]
  before_action :load_categories, only: [:edit, :update]

  def new
    @books = Book.new
  end

  def create
    @books = Book.new book_params
    if @book.save
      flash[:success] =
        t "controllers.admin.books.flash.success.create_book"
      redirect_to admin_books_path
    else
      flash[:danger] =
        t "controllers.admin.books.flash.danger.edit_fail"
      render :new
    end
  end

  def index
    @books = Kaminari.paginate_array(Book.order(created_at: :desc)).
      page(params[:page]).per Settings.books.per_page
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "views.admin.books.index.edit_success"
      redirect_to admin_book_path
    else
      render :edit
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "controllers.admin.books.flash.danger.invalid_category"
      redirect_to admin_categories_path
    end
  end

  def load_categories
    @categories = Category.all
  end

  def book_params
    params.require(:book).permit :book_id, :title, :author, :publish_date,
     :pages, :isbn, :description, :picture
  end

  def load_books
    if @book.nil?
      flash[:danger] = "Book not found"
      redirect_to book_path
    end
  end
end
