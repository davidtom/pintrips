class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only:[:new, :edit, :update, :friends]

  def new
    @events  = [] # DOnt ask.
    @orphan_events = current_user.orphan_events
    @trip = Trip.new
  end

  def create
    trip = Trip.new(trip_params)
    current_user.trips << trip
    if trip.save
      flash[:success] = "Trip successfully created!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Unable to create trip"
      @events = current_user.events
      @trip = Trip.new
      render 'new'
    end
  end

  def index
    @trips = Trip.all.select { |trip| trip.events.any? }
    @trips = Kaminari.paginate_array(@trips).page(params[:page]).per(10)
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments
    @featured_image_url = @trip.featured_image_url

  end

  def edit
    if !user_match?
      flash[:danger] = "You can only edit your own trips."
      redirect_to request.referer
    else
      @events = @trip.events
      @orphan_events = current_user.orphan_events
      #store previous page so it can be linked back to after update
      session[:return_to] ||= request.referer
      end
  end

  def update
    @trip.events = []
    if @trip.update(trip_params)
      flash[:success]= "Trip successfully updated."
      # redirect_to session.delete(:return_to)
      redirect_to user_path(current_user)
    else
      # flash[:danger]= "Unable to update trip."
      flash[:danger]= @trip.errors.full_messages[0]
      redirect_to request.referer
    end
  end

  def destroy
    if !user_match?
      flash[:danger] = "You can only delete your own trips."
      redirect_to request.referer
    else
      @trip.destroy
      flash[:success] = "Trip successfully deleted."
      redirect_to request.referer
    end
  end

  def friends
    @trips = current_user.friend_trips
    if @trips.size == 0 || !@trips
      flash[:info]= "Your friends have no trips yet. Go on an adventure together!"
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, event_ids:[])
  end

  def user_match?
    current_user && @trip.user.is?(current_user)
  end

end
