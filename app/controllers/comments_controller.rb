class CommentsController <ApplicationController

def create
  new_comment = Comment.new(comment_params)
  new_comment.user = current_user
  byebug
  if current_page?(controller: 'trip')
    Trip.find(params[:id]).comments << new_comment
  end
  if current_page?(controller: 'event')
    Event.find(params[:id]).events << new_comment
  end
  redirect_to '#'
end

def update

end

def delete

end

private

def comment_params
  params.require(:comment).permit(:content)
end


end
