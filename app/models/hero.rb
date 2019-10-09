class Hero < ApplicationRecord
  validates :recipient_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :plain_text_evidences
  has_many :kv_group_evidences
  has_many :url_evidences

  def kv_group_evidence
    KvGroupEvidence.where(hero_id: id)&.first
  end

  def kv_pair_evidence
    kv_g_id = kv_group_evidence&.id
    KvPairEvidence.where(kv_group_evidence_id: kv_g_id).first
  end

  def plain_text_evidence
    PlainTextEvidence.where(hero_id: id)&.first
  end

  def url_evidence
    UrlEvidence.where(hero_id: id)&.first
  end

  def evidence_json
    return_json = {}
    return_json[:evidence] = []
    if (kvgo = KvGroupEvidence.where(hero_id: self.id)&.first)
      group_json = {}
      group_json[:type] = 'KeyValueGroupEvidence'
      group_json[:name] = kvgo.name
      group_json[:values] = []
      KvPairEvidence.where(kv_group_evidence_id: kvgo.id).each do |kv_pair_obj|
        sub_json = {}
        sub_json[:type] = 'KeyValuePairEvidence'
        sub_json[:key] = kv_pair_obj.key
        sub_json[:value] = kv_pair_obj.value
        sub_json[:url] = kv_pair_obj.url unless kv_pair_obj.url.nil?
        group_json[:values] << sub_json
      end
      return_json[:evidence] << group_json
    end
    if (ptev_o = PlainTextEvidence.where(hero_id: self.id)&.first)
      plain_json = {}
      plain_json[:type] = "PlainTextEvidence"
      plain_json[:title] = ptev_o.title
      plain_json[:description] = ptev_o.description unless ptev_o.description.nil?
      return_json[:evidence] << plain_json
    end
    if (url_ev_o = UrlEvidence.where(hero_id: self.id)&.first)
      url_json = {}
      url_json[:type] = "UrlEvidence"
      url_json[:name] = url_ev_o.name
      url_json[:value] = url_ev_o.value
      url_json[:description] = url_ev_o.description unless url_ev_o.description.nil?
      return_json[:evidence] << url_json
    end
    return_json
  end
end
