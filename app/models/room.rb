class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants 
  
  validates :name, presence: true, uniqueness: true
  validate :validate_user_count


  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id)
    end
    single_room
  end

  def display_name(current_user)
    if is_private
      other_user = users.where.not(id: current_user.id).first
      other_user ? other_user.email.split('@').first : "Συνομιλία"
    else
      names = users.where.not(id: current_user.id).map { |u| u.email.split('@').first }
      "Group: #{names.join(', ')}".truncate(35)
    end
  end

  private 

  def validate_user_count
    if users.size > 4
      errors.add(:base, "The group chat can't have more than 4 users.")
    end
  end
end