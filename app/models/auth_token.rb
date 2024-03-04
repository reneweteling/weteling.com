class AuthToken < ApplicationRecord
  belongs_to :user

  def expired?
    expires_at < Time.zone.now
  end
end
