# frozen_string_literal: true

ActiveAdmin.register Hour do
  menu priority: 2

  include ActiveAdminHelper
  permit!

  controller do
    def scoped_collection
      super.includes :rate, project: [:client]
    end

    def build_new_resource
      record = super
      record.date ||= Date.today
      record.project ||= Hour.last.project
      record.rate ||= Hour.last.rate
      record
    end
  end

  action_item :new_hour, only: :show do
    link_to 'New hour', new_admin_hour_path
  end

  filter :client
  filter :project
  filter :description
  filter :date

  scope :all, default: true
  scope(:today) { |scope| scope.where(date: Date.today) }

  index do
    selectable_column
    id_column
    column :project
    column :rate
    column :date
    column :total_hours
    # column :total_sno_hours
    column :description do |row|
      simple_format row.description
    end
    actions
  end

  show do
    attributes_table do
      row :project
      row :rate
      row :date
      row :total_hours
      #   row :total_sno_hours
      row :description do |row|
        simple_format row.description
      end
    end
  end

  form do |_f|
    projects = (Project.for_hours.all + [resource.project]).uniq

    inputs 'Details' do
      input :project, input_html: {
        'data-rate': projects.map do |p|
                       [p.id, p.client.default_rate.id]
                     end.to_h.to_json
      }, collection: projects
      input :rate
      input :date
      input :repeat_date, as: :datepicker
      input :total_hours
      #   input :total_sno_hours
      input :description
    end
    actions
  end
end
