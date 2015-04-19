class CreateSubPreferences < ActiveRecord::Migration
  def change
    create_table :sub_preferences do |t|
      t.references :player, index: true
      t.references :session, index: true

      t.timestamps null: false
    end
    add_foreign_key :sub_preferences, :players
    add_foreign_key :sub_preferences, :sessions
  end
end
