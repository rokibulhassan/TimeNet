class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :number
      t.integer :customer_id
      t.integer :contact_id
      t.datetime :start_date
      t.datetime :end_date
      t.text :notes

      t.timestamps
    end
  end
end
