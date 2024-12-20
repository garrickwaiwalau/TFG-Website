class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, :subject, :message, presence: true
  # No validation for phone, so it can be left blank
end
