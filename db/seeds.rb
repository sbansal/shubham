# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Add default baskets
["Action Item", "Reference", "Back Burner"].each do |basket|
  Basket.find_or_create_by_name(basket)
end

# 30.downto(1).each do |i|
#   @date = i.days.ago.beginning_of_day
#   @trace = Trace.new(:habit_id => '1', :trace_date => @date, :trace_complete => true)
#   @trace.save
# end