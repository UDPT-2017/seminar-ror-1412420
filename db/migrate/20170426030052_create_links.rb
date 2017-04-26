class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :full_link, null: false
      t.string :short_link, null: false
      t.string :domain
      t.integer :hits_count
      t.belongs_to :user, foreign_key: true, null: true
      t.timestamps
    end
  end
end
