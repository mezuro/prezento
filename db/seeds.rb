# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Default mezuro user, the owner of the public kalibro configurations
default_user = FactoryGirl.create(:mezuro_user, password: Devise.friendly_token.first(10))
default_user.save

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
