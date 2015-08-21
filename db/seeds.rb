# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Default mezuro user, the owner of the public kalibro configurations
password = Devise.friendly_token
default_user = User.create(name: "Mezuro Default user", email: "mezuro@librelist.com", password: password)

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

# The same restrictions apply to the default reading group
reading_groups = ReadingGroup.all
reading_groups.each do |reading_group|
  attributes = ReadingGroupAttributes.new
  attributes.reading_group_id = reading_group.id
  attributes.user_id = default_user.id
  attributes.public = true
  attributes.save
end
