class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(friend_id: @friend.id)
    if @friendship.save
      redirect_back(fallback_location: root_path, notice: "Added to your friends!")
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path, notice: "Removed from your friends.")
  end
end