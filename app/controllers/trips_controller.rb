class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :copy, :destroy]
  before_action :require_user, only:[:new, :edit, :update, :friends]

  def new
    @events  = [] # DOnt ask.
    @addable_events = current_user.orphan_events + current_user.wish_list_events
    @trip = Trip.new
  end

  def create
    trip = Trip.new(trip_params)
    current_user.trips << trip
    if params[:image]
      new_image = Image.new(image_params)
      new_image.trip = trip
      new_image.user = current_user
      new_image.featured = true
      new_image.save
    end
    #Set start date and end date dynamically based on events
    byebug

    trip.start_date = trip.events.order(:date).first.date
    trip.end_date = trip.events.order(:date).last.date
    if trip.save
      flash[:success] = "Trip successfully created!"
      redirect_to trip_path(trip)
    else
      flash[:danger] = "Unable to create trip"
      @events = current_user.events
      @trip = Trip.new
      render 'new'
    end
  end

  def index
    @trips = Trip.all_with_events.order(created_at: :desc)
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
      @addable_events = current_user.orphan_events + current_user.wish_list_events
      #store previous page so it can be linked back to after update
      session[:return_to] ||= request.referer
      end
  end

  def update
    @trip.events = []
    if @trip.update(trip_params)
      if params[:image]
        new_image = Image.new(image_params)
        new_image.trip = @trip
        new_image.user = current_user
        new_image.save
      end
      flash[:success]= "Trip successfully updated."

      # redirect_to session.delete(:return_to)
      redirect_to trip_path(@trip)
    else
      # flash[:danger]= "Unable to update trip."
      flash[:danger]= @trip.errors.full_messages[0]
      redirect_to request.referer
    end
  end

  def copy
    @new_trip = @trip.copy
    @new_trip.images.clear
    current_user.trips << @new_trip
    if @new_trip.save
      #copy events from original trip to the new trip (must do after save so there is a trip_id)
      @trip.copy_events(current_user, @new_trip)
      flash[:success] = "Trip successfully copied to wishlist"
      redirect_to user_path(current_user)
    else
      flash[:danger] = @new_event.errors.full_messages[0] + " Trip was unable to be created, please try again."
    end
  end

  def destroy
    if !user_match?
      flash[:danger] = "You can only delete your own trips."
      redirect_to request.referer
    else
      @trip.destroy
      flash[:success] = "Trip successfully deleted."
      redirect_to user_path(current_user)
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
    params.require(:trip).permit(:name, :on_wish_list, event_ids:[])
  end

  def image_params
    params.require(:image).permit(:url, :title, :caption)
  end

  def user_match?
    current_user && @trip.user == current_user
  end

end
