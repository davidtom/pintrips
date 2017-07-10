class EventsController < ApplicationController
  ## todo list for events.
  #  make nicer views, specifically make dates look nicer
  #  figure out where we want to redirect_to

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      flash[:success] = "Event was successfully created."
      redirect_to user_path(current_user)
    else
      if current_user == nil
        flash[:alert] = "You must be logged in to create an event."
      else
        flash[:alert] = @event.errors.full_messages[0] + "  Event was unable to be created, please try again."
      end
      render 'new'
    end
  end

  def index
    @events = Event.all
  end

  def show

  end

  def edit
    if !user_match?
      flash[:alert]= "You can only edit your own events."
      redirect_to user_path(current_user)
    end
  end

  def update
    @event.update(event_params)
    redirect_to user_path(current_user)
  end

  def destroy
    if !user_match?
      flash[:alert]= "You can only delete your own events."
      redirect_to user_path(current_user)

    else
      @event.delete
      flash[:alert]= "Event was successfully deleted."
      redirect_to user_path(current_user)
    end

  end


  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:review, :rating, :date, :type)
  end

  def user_match?
    current_user && current_user.id == @event.user_id
  end
end
