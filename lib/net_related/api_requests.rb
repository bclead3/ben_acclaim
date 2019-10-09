# NetRelated::ApiRequests.badge_templates('391d224a-b7b1-4617-8527-b192698b0cad')
# NetRelated::ApiRequests.issued_badges('391d224a-b7b1-4617-8527-b192698b0cad')
# NetRelated::ApiRequests.organizations
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
      orgs_h = JSON.parse(response.body)
    end
  end
end
