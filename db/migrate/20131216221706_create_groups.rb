class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.string :url
      t.integer :group_id

      t.timestamps
    end
  end
end
