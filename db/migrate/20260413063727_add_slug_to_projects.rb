class AddSlugToProjects < ActiveRecord::Migration[8.0]
  def up
    add_column :projects, :slug, :string
    add_index :projects, :slug, unique: true

    Project.find_each do |project|
      slug = (project.title.presence || project.name).parameterize
      # Ensure uniqueness
      base_slug = slug
      counter = 1
      while Project.where(slug: slug).where.not(id: project.id).exists?
        slug = "#{base_slug}-#{counter}"
        counter += 1
      end
      project.update_column(:slug, slug)
    end
  end

  def down
    remove_column :projects, :slug
  end
end
