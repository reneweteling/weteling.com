ActiveAdmin.register Client do
  include ActiveAdminHelper
  permit!
    
  filter :name
  

  index do 
    selectable_column
    id_column
    column :name
    actions
  end

end
