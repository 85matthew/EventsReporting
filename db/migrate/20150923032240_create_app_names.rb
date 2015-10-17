class CreateAppNames < ActiveRecord::Migration
  def change
    create_table :app_names do |t|
      t.string :app_name, :null => false, unique: true
      t.integer :business_relevant, :null => false

      t.timestamps null: false
    end
  end
end
