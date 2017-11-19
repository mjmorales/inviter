class ApplicationRecord < ActiveRecord::Base
  include Inviterable
  self.abstract_class = true
end
