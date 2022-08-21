class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @books=@user.books.id(params[:id])
  end

  def edit
  end
end
