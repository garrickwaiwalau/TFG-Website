class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, :subject, :message, presence: true
  validates :reference_number, uniqueness: true
  # No validation for phone, so it can be left blank

  before_create :generate_reference_number

  private

  def generate_reference_number
    loop do
      self.reference_number = "CF#{SecureRandom.random_number(10**8).to_s.rjust(8, '0')}"
      break unless Contact.exists?(reference_number: self.reference_number)
    end
  end
end
