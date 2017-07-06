class UsersController < ApplicationController
    before_action :logged_in_user
    skip_before_action :logged_in_user,  only: [:new, :create]
    before_action :correct_user,         only: [:edit, :update]
    before_action :admin,                only: [:index, :destroy]
    before_action :viewing_of_a_profile, only: :show

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the FreeBook!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def this_user
      @user = User.find(params[:id])
    end

    def correct_user
      this_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin
      #unless logged_in_user
        redirect_to(root_url) unless current_user.admin?
      #end
    end

    def viewing_of_a_profile
      this_user
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
end
