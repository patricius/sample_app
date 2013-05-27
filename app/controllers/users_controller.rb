class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "congratulation, your have successfully signed up....starts tweeting"
      redirect_to @user
    else
      respond_to do |format|
        format.html { render action: :new }
        format.js { render action: :new  }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Your data is updated"
      redirect_to @user
    else
      flash[:error] = "Errors in the form"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User #{@user.name} is destroyed"
    redirect_to users_path
  end

  private

  def signed_in_user 
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in to access this page" 
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, notice: "Please sign in to access this page" unless @user == current_user
  end

  def admin_user
    redirect_to root_path, notice: "you do not have permission to delete user" unless current_user.admin? 
  end

end