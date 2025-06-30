class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :garden

  # Enum pour le statut des réservations
  enum status: { pending: 0, confirmed: 1, cancelled: 2, completed: 3 }

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }

  validate :end_date_after_start_date

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
end
