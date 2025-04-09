class Tweet < ApplicationRecord
  belongs_to :user

  scope :by_user_id, -> (identifier) { where(user: identifier) if identifier.present? }
end
