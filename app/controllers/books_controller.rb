class BooksController < ApplicationController
  def index
    @book=Book.new
    @books=Book.all
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @users=@book.user
  end

  def update
    @books=Book.all
    @book=Book.find(params[:id])
    if book.update(book_params)
      flash[:notice]="succesfully"
    redirect_to book_path(book.id)
    else
    flash.now[:alert]="error"
    render :show
    end
  end

  def destroy
    @book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book=Book.find(params[:id])
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="successfully"
      redirect_to books_path
    else
      flash.now[:alert]="error"
      rebder :show
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
