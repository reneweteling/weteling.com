ActiveAdmin.register Subscriber do
  menu priority: 7
  include ActiveAdminHelper
  permit!

  filter :first_name
  filter :last_name
  filter :email

  index do 
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    actions
  end

end
