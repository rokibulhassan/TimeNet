class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :business_name
      t.string :billing_address
      t.string :street_address
      t.string :suit_unit
      t.string :city
      t.string :zip_code
      t.integer :country_id
      t.integer :state_id
      t.string :phone
      t.string :website
      t.integer :contact_id

      t.timestamps
    end
  end
end
