class CreateHits < ActiveRecord::Migration[5.0]
  def change
    create_table :hits do |t|
      t.string :ip_address
      t.string :location
      t.belongs_to :link, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
