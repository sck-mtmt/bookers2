class BooksController < ApplicationController

   before_action :authenticate_user!, except: [:index, :show, :edit]

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
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
