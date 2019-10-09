class KvGroupEvidence < ApplicationRecord
  belongs_to :hero

  has_many :k_v_pair_evidences
end
