class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users 
  
  validates :name, presence: true, uniqueness: true
  
  validate :validate_user_count

  private

  def validate_user_count
    if users.size > 4
      errors.add(:base, "Το group chat δεν μπορεί να έχει πάνω από 4 άτομα")
    end
  end
end