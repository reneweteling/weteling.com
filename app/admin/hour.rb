# frozen_string_literal: true

ActiveAdmin.register Hour do
  menu priority: 2

  include ActiveAdminHelper
  permit!

  controller do
    def scoped_collection
      super.includes :rate, :client, project: [:client]
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
    link_to "New hour", new_admin_hour_path
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
    column :total_sno_hours
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
      row :total_sno_hours
      row :description do |row|
        simple_format row.description
      end
    end
  end

  form do |_f|
    projects = (Project.for_hours.all + [resource.project]).uniq

    budget_data = projects.each_with_object({}) do |p, h|
      next unless p.budget?
      spent = p.spent_amount
      h[p.id] = {
        budget: ActiveSupport::NumberHelper.number_to_currency(p.budget),
        spent: ActiveSupport::NumberHelper.number_to_currency(spent),
        remaining: ActiveSupport::NumberHelper.number_to_currency(p.budget - spent),
        budget_hours: p.budget_hours&.round(2),
        remaining_hours: p.remaining_hours&.round(2),
      }
    end

    inputs "Details" do
      input :project, input_html: {
                  'data-rate': projects.map do |p|
                    [p.id, p.client.default_rate.id]
                  end.to_h.to_json,
                  'data-budget': budget_data.to_json,
                }, collection: projects
      input :rate
      input :date
      input :repeat_date, as: :datepicker
      input :total_hours
      input :total_sno_hours
      input :description
    end

    div id: 'project-budget-info', style: 'margin: 1em 0; padding: 1em; background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 6px; display: none;' do
      h4 'Projectbudget', style: 'margin-top: 0;'
      div id: 'project-budget-info-body'
    end

    script type: 'text/javascript' do
      raw <<~JS
        (function() {
          function init() {
            var select = document.querySelector('#hour_project_id');
            if (!select) return;
            var data = JSON.parse(select.getAttribute('data-budget') || '{}');
            var box = document.getElementById('project-budget-info');
            var body = document.getElementById('project-budget-info-body');
            if (!box || !body) return;
            function render() {
              var info = data[select.value];
              if (!info) { box.style.display = 'none'; return; }
              box.style.display = 'block';
              body.innerHTML =
                '<div>Budget: <strong>' + info.budget + '</strong>' +
                (info.budget_hours ? ' (' + info.budget_hours + ' uur)' : '') + '</div>' +
                '<div>Besteed: <strong>' + info.spent + '</strong></div>' +
                '<div>Resterend: <strong>' + info.remaining + '</strong>' +
                (info.remaining_hours != null ? ' (' + info.remaining_hours + ' uur)' : '') + '</div>';
            }
            select.addEventListener('change', render);
            render();
          }
          if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', init);
          } else {
            init();
          }
        })();
      JS
    end

    actions
  end
end
