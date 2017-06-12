ActiveAdmin.register Hour do
  menu priority: 2
  
  include ActiveAdminHelper
  permit!

  controller do
    def build_new_resource
      record = super
      record.date ||= Date.today
      record.project ||= Hour.last.project
      record.rate ||= Hour.last.rate
      record
    end
  end

  filter :client
  filter :project
  filter :description
  filter :date

  index do 
    selectable_column
    id_column
    column :project
    column :rate
    column :date
    column :total_hours
    column :total_sno_hours
    column :description
    actions
  end

  show do
    attributes_table do
      row :project
      row :rate
      row :date
      row :total_hours
      row :total_sno_hours
      row :description
    end
  end

  form do |f|
    inputs 'Details' do 
      input :project, input_html: { 'data-rate': Project.all.map{|p| [p.id, p.client.default_rate.id]}.to_h.to_json }
      input :rate
      input :date
      input :total_hours
      input :total_sno_hours
      input :description
    end
    actions
  end

end
