class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "congratulation..starts tweeting"
      redirect_to @user
    else
      respond_to do |format|
        format.html { render action: :new }
        format.js { render action: :new  }
      end
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html 
      format.js
    end
  end
end