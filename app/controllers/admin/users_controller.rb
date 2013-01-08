class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all(:order => 'email')
  end
  
  def new
    @user = User.new
  end
  
  def create
    admin = params[:user].delete(:admin)
    @user = User.new(params[:user])
    if @user.save && @user.update_attribute("admin", admin == "1")
      flash[:notice] = "User created successfully"
      redirect_to admin_users_path
    else
      flash[:alert] = "User could not be created"
      render :action => 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    admin = params[:user].delete(:admin)
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update_attributes(params[:user]) && @user.update_attribute("admin", admin == "1")
      flash[:notice] = "User updated successfully"
      redirect_to admin_users_path
    else
      flash[:alert] = "User could not be udpated"
      render :action => 'edit'
    end
  end
  
  def destroy
    if @user == current_user
      flash[:alert] = "You can not delete yourself"
    else
      @user.destroy
      flash[:notice] = "User has been deleted"
    end
      redirect_to admin_users_path
  end
  
private
  def find_user
    @user = User.find(params[:id])
  end
  
end
