class CommentsController <ApplicationController

  before_action :set_comment, only: [:edit, :update, :destroy]

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
    if !user_match?
      flash[:danger] = "You can only edit your own comments."
      redirect_to request.referer
    else
    #store previous page so it can be linked back to after update
    session[:return_to] ||= request.referer
    end
  end

  def update
    @comment.update(comment_params)
    flash[:success]= "Comment successfully updated."
    redirect_to session.delete(:return_to)
  end

  def destroy
    if !user_match?
      flash[:danger] = "You can only delete your own comments."
      redirect_to request.referer

    else
      @comment.destroy
      flash[:success]= "Comment successfully deleted."
      redirect_to request.referer
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def user_match?
      current_user && @comment.user == current_user
    end

end
