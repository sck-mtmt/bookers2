class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user=User.find(params[:id])
    @books=@user.books
  end

  def edit
    @user=User.find(params[:id])
    @user.save
    redirect_to users_path
  end

  def index
    @user=current_user
    @users=User.all
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       flashflash[:notice]="succesfully"
       redirect_to user_path(@user.id)
    else
       flash.now[:alert]="error"
       render :show
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
