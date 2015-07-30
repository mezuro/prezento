# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Default mezuro user, the owner of the public kalibro configurations
password = Devise.friendly_token
default_user = FactoryGirl.create(:mezuro_user, password: password)

puts "-- Default user created:"
puts "   Email:    #{default_user.email}"
puts "   Password: #{password}"

# The database should have only the default public
# configurations when this file is executed
kalibro_configurations = KalibroConfiguration.all
kalibro_configurations.each do |configuration|
  attributes = KalibroConfigurationAttributes.new
  attributes.kalibro_configuration_id = configuration.id
  attributes.public = true
  attributes.user_id = default_user.id
  attributes.save
end
