# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

puts "Importing countries..."
CSV.foreach(Rails.root.join("countries.csv"), headers: true) do |row|
  Country.create! do |country|
    country.id = row[0]
    country.name = row[1]
  end
end

puts "Importing states..."
CSV.foreach(Rails.root.join("states.csv"), headers: true) do |row|
  State.create! do |state|
    state.name = row[0]
    state.country_id = row[2]
  end
end

puts "Creating admin user..."
admin=User.new(first_name: 'kyle', last_name: 'Covell', title: "Site Admin", roles_mask: 1, "email" => "siteadmin@kylecovel.com", password: '1234567', password_confirmation: '1234567')
admin.save(validate: false)
admin2=User.new(first_name: 'Rakib', last_name: 'Hasan', title: "Site Admin", roles_mask: 1, "email" => "rakib063049@gmail.com", password: '1234567', password_confirmation: '1234567')
admin2.save(validate: false)