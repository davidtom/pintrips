class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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

  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def show
    @orphan_events = @user.events.select {|event| event.is_orphan? }
    @trips = @user.trips
    # @trips = Trip.all.select { |trip| trip.user == @user }

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :first_name, :last_name)
  end

end
