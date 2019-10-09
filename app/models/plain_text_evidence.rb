class PlainTextEvidence < ApplicationRecord
  #has_many :heroes, as: :evidencable
  belongs_to :hero
end
