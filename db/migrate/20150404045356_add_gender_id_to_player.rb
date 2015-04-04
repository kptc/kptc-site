class AddGenderIdToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :gender_id, :integer
  end
end
