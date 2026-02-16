class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(friend_id: @friend.id)
    if @friendship.save
      redirect_back(fallback_location: root_path, notice: "Added to your friends!")
    end
  end

  def destroy
    @friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id])
                          .or(Friendship.where(user_id: params[:id], friend_id: current_user.id))
                          .first

    if @friendship
      @friendship.destroy
      flash[:notice] = "Removed from your friends."
    else
      flash[:alert] = "Friendship not found."
    end

    redirect_back(fallback_location: root_path)
  end
end