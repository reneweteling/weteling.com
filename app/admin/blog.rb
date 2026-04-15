ActiveAdmin.register Blog do
  menu priority: 5
  include ActiveAdminHelper
  permit!


  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :date
    column(:content) { |row| markdown(row.content&.truncate(150)).html_safe }
    preview_column :image
    actions
  end

  show do
    attributes_table do
      row :name
      row :slug
      row :date
      row :published
      row(:content) { |b| markdown(b.content).html_safe }
      preview_row :image
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    
    f.inputs do
      f.input :name
      f.input :slug
      f.input :date, as: :date_time_picker
      f.input :content, as: :md
      f.input :published, as: :select
      f.input :image, as: :aafile
      f.input :tag_tags, as: :tags
    end


    f.actions
  end

end
