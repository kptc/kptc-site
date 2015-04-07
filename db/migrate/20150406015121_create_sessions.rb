class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :session_type
      t.references :gender
      t.string :name
      t.string :day_of_week
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time, null: true

      t.timestamps null: false
    end
  end
end
