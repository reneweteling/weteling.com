ActiveAdmin.register Project do
  menu priority: 4
  include ActiveAdminHelper
  permit!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported
  sortable

  # filter :client
  filter :name
  filter :show
  filter :cv_active

  index do
    sortable_handle_column 
    selectable_column
    id_column
    column :position
    column :client
    column :name
    column :description do |row|
      markdown(row.description).html_safe
    end
    # column :description_cv do |row|
    #   markdown(row.description).html_safe
    # end
    column :show
    column :cv_active
    actions
  end

  form do |f|
    inputs 'Details' do
      input :client
      input :name
    end

    inputs 'Site' do
      input :title
      input :subtitle
      input :description, as: :md
      # input :description_cv, as: :md
      input :start_date
      input :end_date
      input :show
      input :cv_active
      input :image, as: :aafile
      input :position
    end
    actions
  end

end
