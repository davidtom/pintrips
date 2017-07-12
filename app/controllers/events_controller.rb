class EventsController < ApplicationController
  ## todo list for events.
  #  make nicer views, specifically make dates look nicer
  #  figure out where we want to redirect_to

  before_action :set_event, only: [:show, :edit, :update, :destroy, :copy]

  def new
    @event = Event.new
    #store previous page so it can be linked back to after create
    ## removed ||= here because adding an event when editing a trip was returning
    ## back to user show page, not the edit trip form
    session[:return_to] = request.referer
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save #TODO REFACTOR this code everywhere it appears, if possible
      flash[:success] = "Event was successfully created."
      # redirect_to user_path(current_user)
      redirect_to session.delete(:return_to)
    else
      if current_user == nil
        flash[:danger] = "You must be logged in to create an event."
      else
        flash[:danger] = @event.errors.full_messages[0] + "  Event was unable to be created, please try again."
      end
      render 'new'
    end
  end

  def index
    @events = Event.all
    @events = Kaminari.paginate_array(@events).page(params[:page]).per(25)
  end

  def show
    @comment = Comment.new
    @comments = @event.comments.order('created_at desc')

  end

  def edit
    if !user_match?
      flash[:danger]= "You can only edit your own events."
      redirect_to request.referer
    else
      #store previous page so it can be linked back to after update
      ## removed ||= here because updating an event was sending back to edit event form
      session[:return_to] = request.referer
    end
  end

  def update
    @event.update(event_params)
    flash[:success]= "Event successfully updated."
    redirect_to session.delete(:return_to)
  end

  def copy
    @new_event = Event.new(title: @event.title, location: @event.location, type: @event.type, on_wish_list: true)
    current_user.events << @new_event
    if @new_event.save
      flash[:success] = "Event successfully copied to wishlist"
      redirect_to user_path(current_user)
    else
      flash[:danger] = @new_event.errors.full_messages[0] + " Event was unable to be created, please try again."
    end
  end

  def destroy
    if !user_match?
      flash[:danger]= "You can only delete your own events."
      redirect_to request.referer

    else
      @event.delete
      flash[:success]= "Event was successfully deleted."
      redirect_to user_path(current_user)
    end

  end


  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:review, :rating, :date, :type_name, :title, :location_name)
  end

  def user_match?
    current_user && @event.user.is?(current_user)
  end
end
