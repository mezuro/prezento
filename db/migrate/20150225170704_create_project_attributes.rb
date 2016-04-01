class CreateProjectAttributes < ActiveRecord::Migration
  def up
    create_table :project_attributes do |t|
      t.integer :project_id
      t.string :image_url
      t.integer :user_id
      t.boolean :hidden, default: false

      t.timestamps null: false
    end

    ProjectOwnership.all.each do |project_ownership|
      project_image = ProjectImage.find_by_project_id(project_ownership.project_id)
      image_url = project_image.nil? ? "": project_image.url

      begin
        # We want to hides projects prior this date since they probably have a invalid configuration
        if Project.find(project_ownership.project_id).updated_at < DateTime.parse("Mon, 23 Feb 2015")
          hidden = true
        else
          hidden = false
        end

        ProjectAttributes.create(user_id: project_ownership.user_id, project_id: project_ownership.project_id, image_url: image_url, hidden: hidden)
      rescue Likeno::Errors::RecordNotFound
        puts "Could not find project with id #{project_ownership.project_id} owned by user with #{project_ownership.user_id} and image url #{image_url}"
      end
    end

    drop_table :project_ownerships
    drop_table :project_images
  end

  def down
    create_table :project_ownerships do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end

    create_table :project_images do |t|
      t.belongs_to :project
      t.string :url

      t.timestamps
    end

    ProjectAttributes.all.each do |project_attribute|
      ProjectOwnership.create(user_id: project_attribute.user_id, project_id: project_attribute.project_id)
      ProjectImage.create(url: project_attribute.image_url, project_id: project_attribute.project_id)
    end

    drop_table :project_attributes
  end
end
