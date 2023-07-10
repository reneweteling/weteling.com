ActiveAdmin.register Page do
  menu priority: 4
  include ActiveAdminHelper
  permit!
  
  filter :pagetype

  index do
    id_column
    column :title
    column :pagetype
    actions
  end

  
  show do
    attributes_table do
      row :title
      row :pagetype
      row :content do 
        render partial: 'page'
      end
    end
  

  end

  form do |f|
    f.semantic_errors *f.object.errors
    
    f.inputs do
      f.input :title
      f.input :pagetype
      f.input :content, as: :md
    end

    f.actions
  end


end
