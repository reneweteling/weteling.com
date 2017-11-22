class Page < ApplicationRecord
  enum pagetype: [:default, :cv]
end
