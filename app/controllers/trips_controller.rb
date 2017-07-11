class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only:[:new, :edit, :update, :friends]

  def new
    @events  = [] # DOnt ask.
    @orphan_events = get_orphan_events
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
    @trips = Trip.all.select { |trip| trip.events.any? }
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments

  end

  def edit
    @events = @trip.events
    @orphan_events = get_orphan_events
  end

  def update
    @trip.events = []
    if @trip.update(trip_params)
      flash[:success]= "Trip successfully created"
      redirect_to user_path(current_user)
    else
      flash[:danger]= "Unable to update trip"
      render 'edit'
    end
  end

  def destroy
    @trip.delete
    redirect_to user_path(current_user)
  end

  def friends
    @trips = Trip.all.select { |trip| current_user.friends.include?(trip.user) }
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, event_ids:[])
  end

  def get_orphan_events
    current_user.events.select { |event| event.trip_id == nil }
  end
end
