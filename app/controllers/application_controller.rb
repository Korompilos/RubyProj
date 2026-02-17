class ApplicationController < ActionController::Base
  before_action :set_sidebar_data

  private

  def set_sidebar_data
    if user_signed_in?
      all_rooms = current_user.rooms.includes(:users)
      @my_private_chats = all_rooms.select { |r| r.users.count <= 2 }
      @my_group_chats = all_rooms.select { |r| r.users.count > 2 }
      @friends = current_user.friends 
    end
  end
end
