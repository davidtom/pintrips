class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update]
  before_action :require_user, only:[:new, :edit, :update]

  def new
    @events = current_user.events
    @trip = Trip.new
  end

  def create
    trip = Trip.new(trip_params)
    trip.user = current_user
    if trip.save
      flash[:success] = "Trip successfully created!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Unable to create trip"
      byebug
      @events = current_user.events
      @trip = Trip.new
      render 'new'
    end
  end

  def index
    @trips = Trip.all
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, event_titles:[])
  end
end
