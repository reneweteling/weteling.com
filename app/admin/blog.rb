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
    preview_column :image
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    
    f.inputs do
      f.input :name
      f.input :slug
      f.input :date, as: :date_time_picker
      f.input :content, as: :ckeditor
      f.input :published, as: :select
      f.input :image, as: :aafile
      f.input :tag_tags, as: :tags
    end


    f.actions
  end

end
