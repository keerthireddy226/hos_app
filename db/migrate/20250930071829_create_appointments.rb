class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :hospital, null: false, foreign_key: true
      t.datetime :date
      t.string :status

      t.timestamps
    end
  end
end

