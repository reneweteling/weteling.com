class BackfillProjectSlugs < ActiveRecord::Migration[8.1]
  def up
    Project.reset_column_information
    Project.where(slug: [nil, '']).find_each do |project|
      base = (project.title.presence || project.name).to_s.parameterize
      base = "project-#{project.id}" if base.blank?

      candidate = base
      i = 2
      while Project.where.not(id: project.id).exists?(slug: candidate)
        candidate = "#{base}-#{i}"
        i += 1
      end

      project.update_column(:slug, candidate)
    end
  end

  def down
    # no-op
  end
end
