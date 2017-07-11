class CommentsController <ApplicationController

  def create
    new_comment = Comment.new(comment_params)
    new_comment.user = current_user
    new_comment.save
    if params[:trip_id]
      trip_id = params[:trip_id].keys[0].to_i  #  params given to us by hidden_field.  ugghh
      Trip.find(trip_id).comments << new_comment
      redirect_to trip_path(trip_id)
    end
    if params[:event_id]
      event_id = params[:event_id].keys[0].to_i
      Event.find(event_id).comments << new_comment
      redirect_to event_path(event_id)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    #store previous page so it can be linked back to after update
    session[:return_to] ||= request.referer
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to session.delete(:return_to)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #"reload" current page
    redirect_to request.referer
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end


end
