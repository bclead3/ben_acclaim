class CreateHeroes < ActiveRecord::Migration[5.2]
  def change
    create_table :heroes, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :recipient_email,  null: false
      t.string :first_name,       null: false
      t.string :last_name,        null: false
      t.string :badge_template_id,null: false
      t.datetime :issued_at,     null: false
      t.string :issuer_earner_id
      t.string :locale
      t.boolean :suppress_badge_notification_email
      t.datetime :expires_at
      t.string :country_name
      t.string :state_or_province

      t.timestamps
    end
  end
end
