class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]


  def show
    @user=User.find(params[:id])
    @books=@user.books
    @book=Book.new
  end

  def edit
    @user=User.find(params[:id])
    if @user == current_user
     render :edit
    else
     redirect_to users_path
    end
  end

  def index
    @user=current_user
    @users=User.all
    @book=Book.new
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       flash[:notice]="You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       flash.now[:alert]="error prohibited this obj from being saved:"
       render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
     @user = User.find(params[:id])
     if current_user != @user
       redirect_to users_path
     end
  end
end
