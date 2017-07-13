class ImagesController < ApplicationController

before_action :set_image, only: [:show, :edit, :update, :destroy]

  def new
    @image = Image.new
    @user_events = current_user.events
    @user_trips = current_user.trips
    # @user = current_user
  end

  def create
    new_image = Image.new(image_params)
    new_image.user = current_user
    if trip_params
      new_image.assign_attributes(trip_params)
    end
    if event_params
      new_image.assign_attributes(event_params)
    end

    if new_image.save
      flash[:success] = "Photo successfully added!"
      redirect_to user_path(current_user) #change this later
    else
      flash[:danger] = new_image.errors.full_messages[0]
      @image = Image.new
      @user_events = current_user.events
      @user_trips = current_user.trips
      render 'new'
    end
  end

  def show
    #set_image is called for show, edit, update, destroy
  end

  def edit

  end

  def update
    @image.assign_attributes(image_params)
    if params[:trip]
      @image.assign_attributes(trip_params)
    end
    if params[:event]
      @image.assign_attributes(event_params)
    end

    if @image.save
      flash[:success] = "Photo successfully updated!"
      redirect_to image_path(@image)
    else
      flash[:danger] = @image.errors.full_messages[0]

      @user_events = current_user.events
      @user_trips = current_user.trips
      redirect_to image_edit_path(@image)
    end

  end

  def destroy
  end


  private

  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:url, :user_id, :title, :caption, :featured)
  end

  def trip_params
    params.require(:trip).permit(:trip_id)
  end

  def event_params
    params.require(:event).permit(:event_id)
  end




end
