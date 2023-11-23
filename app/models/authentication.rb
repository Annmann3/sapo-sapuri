class Authentication < ApplicationRecord
  belongs_to :user

  validates :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.find_from_auth(auth)
    Authentication.where(
      provider: auth['provider'],
      uid: auth['uid']
    ).first_or_initialize
  end
end
