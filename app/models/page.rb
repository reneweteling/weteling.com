class Page < ApplicationRecord
  enum :pagetype, { default: 0, cv: 1 }
end
