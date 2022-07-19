class AddNewTableSeatings < ActiveRecord::Migration[6.1]
  def change
    create_table :seatings do |t|
      t.string :given_seats
      t.integer :passengers
      t.timestamps
    end

    add_reference :seatings, :airplane, default: 1, null: false, foreign_key: true
  end
end
