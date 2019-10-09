class CreateEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :kv_group_evidences do |t|
      t.string :hero_id, null: false
      t.string :name, null: false
    end

    create_table :kv_pair_evidences do |t|
      t.string :kv_group_evidence_id, null: false
      t.string :key,     null: false
      t.string :value,   null: false
      t.string :url
    end

    create_table :plain_text_evidences do |t|
      t.string :hero_id, null: false
      t.string :title,   null: false
      t.string :description
    end

    create_table :url_evidences do |t|
      t.string :hero_id, null: false
      t.string :name,    null: false
      t.string :value,   null: false
      t.string :description
    end
  end
end
