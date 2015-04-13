class CreateSessionDates < ActiveRecord::Migration
  def change
    create_table :session_dates do |t|
      t.references :session, index: true
      t.date :dt

      t.timestamps null: false
    end
    add_foreign_key :session_dates, :sessions
  end
end
