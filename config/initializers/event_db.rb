class Masterdb < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "events_#{Rails.env}"
end

