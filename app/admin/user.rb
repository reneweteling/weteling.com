ActiveAdmin.register User do
  include ActiveAdminHelper
  permit!

  filter :name
  filter :email

  index do 
    selectable_column
    id_column
    column :name
    column :first_name
    column :last_name
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :first_name
      row :last_name
      row :department
      row :address
      row :postalcode
      row :city
      row :country
      row :email
      row :iban
      row :bic
      row :iban_name
      row :coc_no
      row :tax_no
    end
  end

  form do |f|
    inputs 'Details' do 
      input :name
      input :first_name
      input :last_name
      input :department
      input :address
      input :postalcode
      input :city
      input :country
      input :iban
      input :bic
      input :iban_name
      input :coc_no
      input :tax_no
    end
    inputs 'Credentials' do
      input :email
      input :password
      input :password_confirmation
    end
    actions
  end

    
  
end
