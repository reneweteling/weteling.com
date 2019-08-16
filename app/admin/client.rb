# frozen_string_literal: true

ActiveAdmin.register Client do
  menu priority: 3
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
