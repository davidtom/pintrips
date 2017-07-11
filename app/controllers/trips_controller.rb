class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update]
  before_action :require_user, only:[:new, :edit, :update]

  def new
    @events = current_user.events
    @trip = trip.new
  end

  def create

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
    params.require(:trip).permit(:events)
  end
end
