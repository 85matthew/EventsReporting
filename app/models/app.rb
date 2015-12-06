class App < ActiveRecord::Base
  include Filterable
  self.primary_key = "app_name"
  has_many :events, foreign_key: "app_name", class_name: "Event"

  scope :app_name, -> boo { where app_name: boo }


end
