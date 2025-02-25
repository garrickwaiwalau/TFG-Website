class AirShipment < ApplicationRecord
  validates :tracking_id, :reference_number, presence: true
  validates :reference_number, uniqueness: true
end
