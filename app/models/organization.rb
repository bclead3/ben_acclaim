class Organization < ApplicationRecord
  has_many :badge_templates, dependent: :destroy
end
