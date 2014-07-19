class CreateShorteners < ActiveRecord::Migration
  def change
    create_table :shorteners do |t|
      t.string :target_url
      t.integer :code

      t.timestamps
    end
  end
end
