class CreateBadgeTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :badge_templates, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name
      t.boolean :allow_duplicates
      t.string :description
      t.string :state
      t.boolean :public
      t.string :vanity_slug
      t.string :image_url
      t.string :badge_url
      t.integer :deployed
      t.string :organization_id

      t.timestamps
    end
  end
end
