class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:update, :edit]
  before_action :require_same_user, only: [:edit, :update, :destroy]
 
  
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all the associated articles are deleted"
    redirect_to root_path
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update 
    if @user.update(user_params)
      flash[:notice] = "You account deatils are updated sucessfully"
      redirect_to users_path
    else
      render 'edit'
    end

  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to CREW #{@user.username}, you have sucessfully Signed-up"
      redirect_to articles_path
    else
      render 'new'
    end

    
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit your own account"
    end
  end
end
