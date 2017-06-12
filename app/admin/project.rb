ActiveAdmin.register Project do
  include ActiveAdminHelper
  permit!

  filter :client
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
