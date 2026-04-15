class SplitLegacyProjectDescription < ActiveRecord::Migration[8.0]
  def up
    Project.where.not(description: [nil, ""]).where(
      description_about_the_company: [nil, ""],
      description_my_role: [nil, ""]
    ).find_each do |project|
      text = project.description.strip
      role_marker = /\r?\n(?:\r?\n)+[^\S\n\r]*My role in this project:[^\n]*\r?\n(?:\r?\n)+/i

      if text.match?(role_marker)
        parts = text.split(role_marker, 2)
        project.update_columns(
          description_about_the_company: parts[0].strip,
          description_my_role: parts[1].strip,
          description: nil
        )
      else
        project.update_columns(
          description_about_the_company: text,
          description: nil
        )
      end
    end

    # Clear legacy description for projects that already have the new fields populated
    Project.where.not(description: [nil, ""]).where.not(
      description_about_the_company: [nil, ""]
    ).update_all(description: nil)

    remove_column :projects, :description
  end

  def down
    add_column :projects, :description, :text
  end
end
