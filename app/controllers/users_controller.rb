class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
    if not signed_in?
      @user = User.new
    else
      flash[:fail] = "You already have an existing account"
      redirect_to users_path
    end
  end

  def show
    if signed_in?
      @user = User.find(params[:id])
    else
      redirect_to(signin_url, notice: "Please sign in.")
    end
  end

  def create
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      #handle update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    if  signed_in?
      @users = User.paginate(page: params[:page])
    else
      redirect_to(signin_url, notice: "Please sign in.")
    end
  end

  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User removed."
      redirect_to users_path
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to(signin_url, notice: "Please sign in.")
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, notice: "Unauthorized to update other users") unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
