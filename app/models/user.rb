class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :project_ownerships
  # Alert: when adding new parameters to this model, they should also be added to registrations_controller

  def projects
    #raise project_ownerships.inspect
    project_ownerships.map { |project_ownership| project_ownership.project }
  end
end
