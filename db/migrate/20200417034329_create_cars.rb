class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.belongs_to :car_model
      t.string :license_plate
      t.string :color
      t.integer :mileage

      t.timestamps
    end
  end
end
