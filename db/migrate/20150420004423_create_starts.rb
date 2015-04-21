class CreateStarts < ActiveRecord::Migration
  def change
    create_table :starts do |t|
      t.string :description
      t.belongs_to :session, index: true

      t.timestamps null: false
    end
    add_foreign_key :starts, :sessions
  end
end
