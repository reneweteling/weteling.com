module Exact
  class BaseController < ApplicationController

    private

    def exact
      @@exact ||= Client.new(User.first)
    end
  end
end
