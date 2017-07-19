ActiveAdmin.register Project do
  menu priority: 4
  include ActiveAdminHelper
  permit!

  # filter :client
  filter :name

  index do 
    selectable_column
    id_column
    column :client
    column :name
    column :description
    actions
  end
end
