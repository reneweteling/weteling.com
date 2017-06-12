ActiveAdmin.register Rate do
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
