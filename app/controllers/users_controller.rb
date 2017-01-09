class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
      login(@user)
      redirect_to @user
  end

  def show
    @user = User.find_by_id(params[:id])
    @attending = User.find(current_user).events
  end


  def edit
    user_id = current_user.id
    @user = User.find_by_id(user_id)
  end

  def update
    user_id = current_user.id
    @user = User.find_by_id(user_id)

    @user.update_attributes(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    delete_user = User.find_by_id(params[:id])
    User.destroy(delete_user)
    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :city, :rating)
  end

end
