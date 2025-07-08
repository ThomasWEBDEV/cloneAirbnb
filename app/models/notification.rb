class Notification < ApplicationRecord
  belongs_to :user # recipient
  belongs_to :booking, optional: true

  scope :unread, -> { where(read: false) }
end
