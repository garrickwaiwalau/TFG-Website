class Quote < ApplicationRecord
  # Allow nested attributes for products
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products, allow_destroy: true

  # # Validations
  # validates :mode_of_transport, presence: true
  #
  # # Shipping Information
  # validates :from_address, presence: true
  # validates :to_address, presence: true
  # validates :from_city, presence: true
  # validates :to_city, presence: true
  # validates :from_state_province, presence: true
  # validates :to_state_province, presence: true
  # validates :from_country, presence: true
  # validates :to_country, presence: true
  # validates :from_zip_postal, presence: true
  # validates :to_zip_postal, presence: true
  #
  # # Contact Information
  # validates :sender_firstname, presence: true
  # validates :sender_lastname, presence: true
  # validates :sender_city, presence: true
  # validates :sender_state_province, presence: true
  # validates :sender_country, presence: true
  # validates :sender_email, presence: true
  #
  # # Others
  # # validates :customs_clearance, presence: true
  # # validates :existing_customer, presence: true
  # # validates :comment, presence: true

  validates :reference_number, uniqueness: true

  before_create :generate_reference_number

  private

  def generate_reference_number
    loop do
      self.reference_number = "QF#{SecureRandom.random_number(10**8).to_s.rjust(8, '0')}"
      break unless Quote.exists?(reference_number: self.reference_number)
    end
  end
end
