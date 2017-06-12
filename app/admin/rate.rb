ActiveAdmin.register Rate do
  menu priority: 5
  include ActiveAdminHelper
  permit!

  filter :name
  filter :rate

  index do 
    selectable_column
    id_column
    column :name
    column :description
    column :rate
    actions
  end

end
