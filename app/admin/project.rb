ActiveAdmin.register Project do
  menu priority: 4
  include ActiveAdminHelper
  permit!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate = false # optional; drag-and-drop across pages is not supported
  sortable

  # Support both ID and slug lookups in admin
  controller do
    def find_resource
      if params[:id] =~ /\A\d+\z/
        scoped_collection.find(params[:id])
      else
        scoped_collection.find_by!(slug: params[:id])
      end
    end
  end

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
    column :start_date
    column :end_date
    actions
  end

  show do
    attributes_table do
      row :client
      row :name
      row :slug
      row :site_active
      row :cv_active
      row :hours_active
      row :position
      row :budget do |p|
        if p.budget?
          parts = [number_to_currency(p.budget)]
          parts << "(#{p.budget_hours.round(2)} uur @ #{number_to_currency(p.default_rate_amount)})" if p.budget_hours
          parts.join(' ')
        end
      end
      row :budget_status do |p|
        if p.budget?
          spent = p.spent_amount
          remaining = p.remaining_amount
          "Besteed: #{number_to_currency(spent)} — Resterend: #{number_to_currency(remaining)}"
        end
      end
      row :title
      row :subtitle
      row :techniques
      row :start_date
      row :end_date
      row(:description_about_the_company) { |p| markdown(p.description_about_the_company).html_safe }
      row(:description_my_role) { |p| markdown(p.description_my_role).html_safe }
      preview_row :image
    end
  end

  form do |f|
    inputs 'Details' do
      input :client
      input :name
      input :slug
      input :site_active
      input :cv_active
      input :hours_active
      input :position
      input :budget, hint: 'Budget in euro\'s (optioneel). Wordt omgerekend naar uren via het default tarief van de client.'
    end

    inputs 'Site' do
      input :title
      input :subtitle
      input :techniques, as: :tags, collection: Tag.all.pluck(:name)
      input :start_date
      input :end_date
      input :description_about_the_company, as: :md
      input :description_my_role, as: :md
      input :image, as: :aafile
    end

    actions
  end
end
