class Product < ApplicationRecord
  belongs_to :quote

  # Validations
  # validates :product_name, presence: true
end
