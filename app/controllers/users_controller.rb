class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def new
    if current_user
      redirect_to user_path(current_user)
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:url]
      @image = Image.new(image_params)
      @user.profile_image = @image
      @image.save
    end
    if @user.save
      flash[:success] = "Welcome to PinTrips #{@user.user_name}!"
      session[:user_id] = @user.id
      #Maybe hange this path once we have a better page to redirect them to?
      redirect_to user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages[0]
      render 'new'
    end
  end

  def edit
    @image = Image.new(image_params)
    @user.profile_image = @image
    @image.save
    byebug
  end

  def update
    if params[:url]
      @image = Image.new(image_params)
      @user.profile_image = @image
      @image.save
    end
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def show
    @trips = @user.completed_trips
    @orphan_events = @user.orphan_events
    @wish_list_trips = @user.wish_list_trips
    @wish_list_events = @user.wish_list_events
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :first_name, :last_name)
  end

  def image_params
    params.permit(:url, :title, :caption)
  end
end
