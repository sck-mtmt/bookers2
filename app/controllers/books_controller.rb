class BooksController < ApplicationController

   before_action :authenticate_user!, except: [:update, :edit]

  def index
    @book=Book.new
    @books=Book.all
    @user=current_user
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="succesfully"
      redirect_to book_path(@book.id)
    else
      @user=@book.user
      @books=Book.all
      flash.now[:alert]="error"
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
    if book.update(book_params)
      flash[:notice]="succesfully"
      redirect_to book_path(book.id)
    else
      flash.now[:alert]="error"
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
    if @book.user == current_user
     render :edit
    else
     redirect_to books_path
    end
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    if currect_user!= @book.user_id
       redirect_to user_path(currect_user)
    end
  end
end
