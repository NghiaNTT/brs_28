class Admin::BooksController < ApplicationController
  load_and_authorize_resource

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
      render :new
    end
  end

  def index
    @search = Book.ransack params[:q]
    @books = @search.result.order(updated_at: :desc).page(params[:page])
      .per Settings.per_page
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "controllers.admin.books.flash.danger.invalid_category"
      redirect_to admin_categories_path
    end
  end

  def book_params
    params.require(:book).permit :book_id, :title, :author, :publish_date,
     :pages, :isbn, :description, :picture
  end
end
