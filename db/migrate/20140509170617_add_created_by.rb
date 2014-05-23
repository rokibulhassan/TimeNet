class AddCreatedBy < ActiveRecord::Migration
  def change
    add_column :customers, :created_by, :integer
    add_column :contacts, :created_by, :integer
    add_column :projects, :created_by, :integer
  end
end
