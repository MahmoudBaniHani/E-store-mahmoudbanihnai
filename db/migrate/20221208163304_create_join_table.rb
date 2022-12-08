class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :stores, :users do |t|
      # t.index [:store_id, :user_id]
      # t.index [:user_id, :store_id]
    end
  end
end
