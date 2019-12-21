class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
  	@users = User.page(params[:page]).reverse_order
  	@user = current_user
  	@book_new = Book.new
  	@books = Book.all
  end
  def show
  	@user = User.find(params[:id])
  	@book_new = Book.new
	  @books = @user.books
  end
  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	 redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
