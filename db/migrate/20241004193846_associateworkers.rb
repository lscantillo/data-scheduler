class Associateworkers < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :worker_id, :integer
    add_column :events, :user_id, :integer
    add_column :events, :location, :string
    add_column :events, :weather_info, :jsonb

    add_index :events, :worker_id
    add_index :events, :user_id
  end
end
