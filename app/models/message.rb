class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_append_to room, target: "messages", locals: { session_user_id: nil } }
  
  after_destroy_commit { broadcast_remove_to room }
end