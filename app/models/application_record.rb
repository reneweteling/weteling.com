class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def gid
  #   "#{class.name}-#{id}"
  # end
end
