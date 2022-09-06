class BooksController < ApplicationController

   before_action :correct_user, only: [:edit, :update]

  def index
    @book=Book.new
    @books=Book.all
    @user=current_user
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user=@book.user
      @books=Book.all
      flash.now[:alert]="errors prohibited this obj from being saved:"
      render :index
    end
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def update
    @books=Book.all
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      flash.now[:alert]="errors prohibited this obj from being saved:"
      render :edit
    end
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book=Book.find(params[:id])
    @user=@book.user
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
