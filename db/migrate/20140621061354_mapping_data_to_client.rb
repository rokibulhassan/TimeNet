class MappingDataToClient < ActiveRecord::Migration
  def change
    add_column :contacts, :client_id, :integer
    add_column :projects, :client_id, :integer
  end
end
