class OceanShipment < ApplicationRecord
  validates :shipment_type, :tracking_id, :reference_number, presence: true
  validates :reference_number, uniqueness: true
end
