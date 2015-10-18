class AppName < ActiveRecord::Base
  include Filterable
  has_many :event

  scope :app_name, -> boo { where app_name: boo }


end
