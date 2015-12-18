class Day < ActiveRecord::Base
  validates_presence_of :the_date
  validates_numericality_of :hours, less_than_or_equal_to: 8.0, greater_than: 2.0
  belongs_to :holiday
end
