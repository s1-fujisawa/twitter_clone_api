class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|

      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :follow_user, foreign_key: { to_table: :users }, null: false
      
      t.timestamps
    end
  end
end
