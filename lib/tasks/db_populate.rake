namespace :db_populate do
  desc "inserts an organization into a local table"
  task populate_organization: :environment do
    org_h = NetRelated::ApiRequests.organizations
    org_sub_h = org_h['data'].first
    create_h = {
        id: org_sub_h['id'],
        name: org_sub_h['name'],
        image_url: org_sub_h['photo_url'],
        vanity_url: org_sub_h['vanity_url'],
        vanity_slug: org_sub_h['vanity_slug'],
        verified: org_sub_h['verified'],
        viewable: true
    }

    org = Organization.create(create_h)
    puts "Created organization #{org.inspect}"
  end

  desc "inserts badge templates into a local table"
  task populate_badge_templates: :environment do
    badge_templage_hash = NetRelated::ApiRequests.badge_templates
    badge_templage_hash['data'].each do |sub_hash|
      create_h = {
          id: sub_hash['id'],
          allow_duplicates: sub_hash['allow_duplicate_badges'],
          description: sub_hash['description'],
          name: sub_hash['name'],
          state: sub_hash['state'],
          public: sub_hash['public'],
          vanity_slug: sub_hash['vanity_slug'],
          image_url: sub_hash['image_url'],
          badge_url: sub_hash['url'],
          deployed: sub_hash['badges_count'],
          organization_id: sub_hash['owner']['id']
      }
      b_template = BadgeTemplate.create(create_h)
      puts "Created badge template #{b_template.inspect}"
    end
  end

end
