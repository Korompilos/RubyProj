class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users 
  
  validates_uniqueness_of :name
  
  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name)
    users.each { |user| single_room.users << user }
    single_room
  end
end