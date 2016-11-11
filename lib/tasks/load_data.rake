require 'csv'

namespace :load_data do

  task :add_people do
    csv_text = File.read('lib/assets/people.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Person.create!(row.to_hash)
    end
  end

  task :add_quotes do
    csv_text = File.read('lib/assets/quotes.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Quote.create!(row.to_hash)
    end
  end

end
