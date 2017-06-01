ActiveAdmin.register Hour do
  include ActiveAdminHelper
  permit!

  controller do
    def build_new_resource
      record = super
      
      record.date ||= Date.today
      
      record
    end
  end
end
