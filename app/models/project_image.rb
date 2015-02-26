#FIXME: remove this after the migration has been done and modify the migration accordingly
class ProjectImage < ActiveRecord::Base
  belongs_to :project
end
