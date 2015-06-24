class Admin::UsersController < ApplicationController
  before_filter :require_admin

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    User.destroy(params[:id])
  end

  protected

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
