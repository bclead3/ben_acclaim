class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name
      t.string :image_url
      t.string :vanity_url
      t.string :vanity_slug
      t.boolean :verified
      t.boolean :viewable

      t.timestamps
    end
  end
end
