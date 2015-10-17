class AppName < ActiveRecord::Base
  include Filterable

  scope :app_name, -> boo { where app_name: boo }


end
