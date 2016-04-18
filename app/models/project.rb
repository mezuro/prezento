class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord

  attr_writer :attributes

  def self.public_or_owned_by_user(user = nil)
    project_attributes = ProjectAttributes.where(public: true)
    project_attributes += ProjectAttributes.where(user_id: user.id, public: false) if user

    project_attributes.map do |attribute|
      begin
        self.find(attribute.project_id)
      rescue Likeno::Errors::RecordNotFound
        nil
      end
    end.compact
  end

  def self.latest(count = 1)
    all.sort { |one, another| another.id <=> one.id }.select { |project|
      attributes = project.attributes
      attributes && attributes.public
    }.first(count)
  end

  def attributes
    @attributes ||= ProjectAttributes.find_by_project_id(@id)
  end

  def destroy
    self.attributes.destroy unless self.attributes.nil?
    @attributes = nil
    super
  end
end
