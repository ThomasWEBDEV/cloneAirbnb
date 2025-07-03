class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :gardens, dependent: :destroy
  has_many :bookings, dependent: :destroy

  # Avatar pour les utilisateurs
  has_one_attached :avatar

  # Validations pour les nouveaux champs
  validates :first_name, presence: true
  validates :last_name, presence: true
end
