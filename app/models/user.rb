class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :project_attributes, class_name: 'ProjectAttributes', dependent: :destroy
  has_many :reading_group_attributes, class_name: 'ReadingGroupAttributes', dependent: :destroy
  has_many :repository_attributes, class_name: 'RepositoryAttributes', dependent: :destroy
  has_many :kalibro_configuration_attributes, class_name: 'KalibroConfigurationAttributes', dependent: :destroy
  # Alert: when adding new parameters to this model, they should also be added to registrations_controller

  def projects
    project_attributes.map { |project_attr| project_attr.project }
  end
end
