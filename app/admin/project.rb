ActiveAdmin.register Project do
  menu priority: 4
  include ActiveAdminHelper
  permit!
  config.sort_order = 'position_desc' # assumes you are using 'position' for your acts_as_list column
  config.paginate = false # optional; drag-and-drop across pages is not supported
  sortable

  # filter :client
  filter :name
  filter :show
  filter :cv_active
  filter :active

  index do
    sortable_handle_column
    selectable_column
    id_column
    column :position
    column :client
    column :name
    column :description_about_the_company do |row|
      markdown(row.description_about_the_company&.truncate(100)).html_safe
    end
    column :description_my_role do |row|
      markdown(row.description_my_role&.truncate(100)).html_safe
    end
    column :site_active
    column :cv_active
    column :hours_active
    actions
  end

  form do |f|
    inputs 'Details' do
      input :client
      input :name
      input :site_active
      input :cv_active
      input :hours_active
      input :position
    end

    inputs 'Site' do
      input :title
      input :subtitle
      input :techniques, as: :tags, collection: Tag.all.pluck(:name)
      input :start_date
      input :end_date
      input :description_about_the_company
      input :description_my_role
      input :image, as: :aafile
    end
    actions
  end
end
