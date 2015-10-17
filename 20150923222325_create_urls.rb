class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :domain, :null => false 
      t.string :keyword
      t.integer :business_relevant
      t.string :domain_keywords, :null => false, :uniqueness => true

      t.timestamps null: false
    end
  end
end
