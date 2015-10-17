class Url < ActiveRecord::Base
  validates :domain_keywords, :uniqueness => true
end
