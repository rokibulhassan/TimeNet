class AddClientIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :client_id, :integer
  end
end
