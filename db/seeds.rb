# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


puts "Starting to seed db..."

Rake::Task['load_data:add_people'].invoke

puts "Finished seeding db"
