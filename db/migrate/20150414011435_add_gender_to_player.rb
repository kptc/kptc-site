class AddGenderToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :gender, :string
    remove_column :players, :gender_id, :string
    
    add_column :sessions, :gender, :string
    add_column :sessions, :allow_both_genders, :boolean, default: false
    remove_column :sessions, :gender_id, :string
    
    drop_table :genders
  end
end
