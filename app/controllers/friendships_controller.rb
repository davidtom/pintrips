class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id] )
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to users_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    flash[:notice] = "Removed #{User.find(params[:id]).user_name} from friends"
    redirect_to user_path(current_user.id)
  end

end
