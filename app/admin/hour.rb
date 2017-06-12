ActiveAdmin.register Hour do
  include ActiveAdminHelper
  permit!

  controller do
    def build_new_resource
      record = super
      
      record.date ||= Date.today
      
      record
    end
  end

  filter :client
  filter :project
  filter :description

  index do 
    selectable_column
    id_column
    column :project
    column :rate
    column :date
    column :hours
    column :sno_hours
    column :description
    actions
  end

  show do
    attributes_table do
      row :project
      row :rate
      row :date
      row :hours
      row :sno_hours
      row :description
    end
  end

  form do |f|
    inputs 'Details' do 
      input :project
      input :rate
      input :date
      input :hours
      input :sno_hours
      input :description
    end
    actions
  end

end
