# NetRelated::ApiRequests.new(ENV['ACCLAIM_ORG_ID']).badge_templates
# NetRelated::ApiRequests.new(ENV['ACCLAIM_ORG_ID']).issued_badges
# NetRelated::ApiRequests.new(ENV['ACCLAIM_ORG_ID']).build_badge_parameters("tiger@example.com", "b9e0f88d-4e78-4cee-adcc-0d3edaeff716")
# NetRelated::ApiRequests.new(ENV['ACCLAIM_ORG_ID']).issue_badge("tiger@example.com", "b9e0f88d-4e78-4cee-adcc-0d3edaeff716")
# NetRelated::ApiRequests.new(nil).organizations
module NetRelated

  BASE_URL = 'https://sandbox-api.youracclaim.com'
  API_VERSION = 'v1'
  USER_TOKEN = ENV['ACCLAIM_USER_TOKEN']
  ORG_ID = ENV['ACCLAIM_ORG_ID']

  class ApiRequests
    attr_reader :org_id

    def initialize(org_id = ORG_ID)
      @org_id = org_id
    end

    def badge_templates
      badge_url_string = "#{BASE_URL}/#{API_VERSION}/organizations/#{@org_id}/badge_templates"
      response = RestClient::Request.execute(method: :get, url: badge_url_string, user: USER_TOKEN, password: '')
      badge_templates_h = JSON.parse(response.body)
    end

    def issued_badges
      issued_badges_url_string = "#{BASE_URL}/#{API_VERSION}/organizations/#{@org_id}/badges"
      response = RestClient::Request.execute(method: :get, url: issued_badges_url_string, user: USER_TOKEN, password: '')
      badges_h = JSON.parse(response.body)
    end

    def organizations
      org_url_string = "#{BASE_URL}/#{API_VERSION}/organizations"
      response = RestClient::Request.execute(method: :get, url: org_url_string, user: USER_TOKEN, password: '')
      JSON.parse(response.body)
    end

    def badge_template_id_array
      BadgeTemplate.all.map{|x| x.id}
    end

    def build_badge_parameters(recipient_email, badge_template_id)
      upload_params = {}
      if badge_template_id_array.member?(badge_template_id)
        if (hero_obj = Hero.where(recipient_email: recipient_email, badge_template_id: badge_template_id)&.first)
          upload_params = {
              recipient_email: hero_obj.recipient_email,
              badge_template_id: hero_obj.badge_template_id,
              issued_at: hero_obj.issued_at.to_s,
              issued_to_first_name: hero_obj.first_name,
              issued_to_last_name: hero_obj.last_name
          }
          if hero_obj.expires_at
            upload_params.merge(expires_at: hero_obj.expires_at)
          end
          if hero_obj.issuer_earner_id
            upload_params.merge(issuer_earner_id: hero_obj.issuer_earner_id)
          end
          if hero_obj.locale
            upload_params.merge(locale: hero_obj.locale)
          end
          unless hero_obj.suppress_badge_notification_email.nil?
            upload_params.merge(suppres_badge_notification_email: hero_obj.suppress_badge_notification_email)
          end

          # if hero_obj.kv_pair_evidence ||
          #     hero_obj.plain_text_evidence ||
          #     hero_obj.url_evidence
          #   upload_params.merge( hero_obj.evidence_json )
          # end
        end
      end
    end

    def issue_badge(recipient_email, badge_template_id)
      response_hash = {}
      if badge_template_id_array.member?(badge_template_id)
        badge_url_string = "#{BASE_URL}/#{API_VERSION}/organizations/#{@org_id}/badges"
        if (hero_obj = Hero.where(recipient_email: recipient_email, badge_template_id: badge_template_id)&.first)
          upload_params = build_badge_parameters(recipient_email, badge_template_id)
          puts "about to issue badge with the following parameters:#{upload_params}"
          response = RestClient::Request.execute(method: :post, url: badge_url_string, user: USER_TOKEN, password: '', payload: upload_params)
          JSON.parse(response.body)
        end
      else
        response_hash[:reason] = "badge_template_id:#{badge_template_id} not found in local database"
      end
    end
  end
end
