class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :garden

  has_many :notifications, dependent: :destroy

  # Enum pour le statut des réservations
  enum status: { pending: 0, confirmed: 1, cancelled: 2, completed: 3 }

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }

  validate :end_date_after_start_date

  after_create :notify_owner

  # Méthode helper pour calculer le prix total
  def total_price
    return 0 unless start_date && end_date && price_per_day

    (end_date - start_date).to_i * price_per_day
  end

  private

  def end_date_after_start_date
    return unless start_date && end_date

    errors.add(:end_date, "must be after start date") if end_date < start_date
  end

  def notify_owner
    Notification.create(
      user: garden.user,
      booking: self,
      message: "#{user.first_name} #{user.last_name} booked your garden: #{garden.title} from #{start_date} to #{end_date}",
      read: false
    )
  end

end
