class ChangeStatusToIntegerInBookings < ActiveRecord::Migration[7.1]
  def up
    # Supprimer la colonne string
    remove_column :bookings, :status

    # Recréer la colonne en integer avec default
    add_column :bookings, :status, :integer, default: 0, null: false
  end

  def down
    remove_column :bookings, :status
    add_column :bookings, :status, :string
  end
end
