class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :name
      t.text :description
      t.integer :brew_temp_f
      t.integer :brew_time_min
      t.integer :brew_time_max

      t.timestamps
    end
  end
end
