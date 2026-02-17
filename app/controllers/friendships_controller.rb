class FriendshipsController < ApplicationController
  
  def create
    friend_id = params[:friend_id]
    @friendship = current_user.friendships.build(friend_id: friend_id)
    
    if @friendship.save
      unless Friendship.exists?(user_id: friend_id, friend_id: current_user.id)
        Friendship.create(user_id: friend_id, friend_id: current_user.id)
      end

      flash[:notice] = "Ο χρήστης προστέθηκε στους φίλους σας."
    else
      flash[:alert] = "Δεν ήταν δυνατή η προσθήκη του φίλου."
    end
    
    redirect_back(fallback_location: my_friends_path)
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    friend = @friendship.friend
    
    inverse_friendship = Friendship.find_by(user: friend, friend: current_user)
    
    @friendship.destroy
    inverse_friendship&.destroy 

    flash[:notice] = "Friend removed :(."
    redirect_back(fallback_location: my_friends_path)
  end

end