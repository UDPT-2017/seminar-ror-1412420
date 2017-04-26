class CreateHits < ActiveRecord::Migration[5.0]
  def change
    create_table :hits do |t|
      t.string :ip_address, null: false
      t.string :location, null: false
      t.belongs_to :link, foreign_key: true
      t.timestamps
    end
  end
end
