class Hero < ApplicationRecord
  validates :recipient_email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
