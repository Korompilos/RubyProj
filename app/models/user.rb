class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  has_many :posts, dependent: :destroy

  has_many :friendships, dependent: :destroy
  
  has_many :friends, through: :friendships, source: :friend

  def friends_with?(user)
    friends.include?(user)
  end

  def self.from_omniauth(auth)
  # Πρώτα ψάχνουμε αν υπάρχει χρήστης με αυτό το email
  user = User.find_by(email: auth.info.email)

  if user
    user.update(provider: auth.provider, uid: auth.uid)
    user
  else
    where(provider: auth.provider, uid: auth.uid).first_or_create do |new_user|
      new_user.email = auth.info.email
      new_user.password = Devise.friendly_token[0, 20]
    end
  end
end
end