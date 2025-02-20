class User < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(uid: user_params[:uid], provider: user_params[:provider]) do |user|
        user.update(user_params)
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        name: auth_hash.info.name,
        email: auth_hash.info.email,
        image: auth_hash.info.image ? auth_hash.info.image : '/images/test_user_icon.jpg',
        provider: auth_hash.provider,
        uid: auth_hash.uid
      }
    end
  end
end
