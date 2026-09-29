ActiveAdmin.register App do
  menu priority: 4, label: 'Apps'
  include ActiveAdminHelper
  permit!
  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  filter :name
  filter :active

  index do
    sortable_handle_column
    selectable_column
    id_column
    column :name
    column :platform
    column :url do |row|
      link_to row.url, row.url, target: '_blank'
    end
    column :tagline_nl
    column :active
    actions
  end

  show do
    attributes_table do
      row :name
      row :url
      row :platform
      row :active
      row :position
      row :tagline_nl
      row :tagline_en
      row(:description_nl) { |a| markdown(a.description_nl).html_safe }
      row(:description_en) { |a| markdown(a.description_en).html_safe }
      preview_row :image
    end
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :url
      input :platform, hint: 'Bijv. "iOS app", "Web app", "macOS"'
      input :active
      input :position
      input :image, as: :aafile, hint: 'Screenshot, liefst 16:10 (1440x900)'
    end

    inputs 'Nederlands' do
      input :tagline_nl
      input :description_nl, as: :md
    end

    inputs 'English' do
      input :tagline_en
      input :description_en, as: :md
    end

    actions
  end
end
