class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.integer :plan_length
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
