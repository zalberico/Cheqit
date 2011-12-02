class UsersController < ApplicationController
  #User actions and variables to be considered for login
  before_filter :authenticate, :except => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update, :cheqeds]
  before_filter :admin_user,   :only => :destroy

  #Function definitions, understandable by name
  def search
    @users = User.search params[:search]
  end

  def index
    if params[:search]
      @users = User.paginate(:page => params[:page], :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    else
      @title = "all users"
      @users = User.paginate(:page => params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Cheqit!"
      redirect_to @user
    else
      @title = "sign up"
      render 'new'
    end
  end

  def edit
    @title = "edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def cheqeds
    @title = "cheqs"
    @user = User.find(params[:id])
    @users = @user.cheqeds.paginate(:page => params[:page])
    render 'show_cheq'
  end

  #Definitions of user type
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
