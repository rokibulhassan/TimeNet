class State < ActiveRecord::Base
  scope :by_country, ->(country_id) { where(country_id: country_id) }
end
