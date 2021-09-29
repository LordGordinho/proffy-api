class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :week_day
      t.integer :from
      t.integer :to
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
