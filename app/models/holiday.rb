class Holiday < ActiveRecord::Base

  belongs_to :user

  has_many :days, dependent: :destroy
  accepts_nested_attributes_for :days, reject_if: proc{|attributes| attributes['the_date'].blank?},
                                allow_destroy: true

  validates_presence_of :reason, :description

  HOLIDAY_TYPES = ["Casual", "Sick Leave"]
end
