json.extract! hero, :id, :recipient_email, :first_name, :last_name, :badge_template_id, :issued_at, :issuer_earner_id, :locale, :suppress_badge_notification_email, :expires_at, :country_name, :state_or_province, :created_at, :updated_at
json.url hero_url(hero, format: :json)
