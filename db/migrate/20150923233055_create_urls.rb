class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :domain
      t.string :keyword
      t.integer :business_relevant

      t.timestamps null: false
    end
  end
end
