class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id] )
    if @friendship.save
      flash[:success] = "You are now friends with #{User.find(params[:friend_id]).user_name}"
      redirect_to request.referer
    else
      flash[:danger] = @friendship.errors.full_messages[0]
      redirect_to request.referer
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    flash[:warning] = "Removed #{User.find(params[:id]).user_name} from friends"
    redirect_to user_path(current_user.id)
  end

end
