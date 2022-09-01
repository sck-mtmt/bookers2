class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :edit]


  def show
    @user=User.find(params[:id])
    @books=@user.books
  end

  def edit
    @user=User.find(params[:id])

  end

  def index
    @user=current_user
    @users=User.all
    @book=Book.new
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       flash[:notice]="succesfully"
       redirect_to user_path(@user.id)
    else
       flash.now[:alert]="error"
       render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
