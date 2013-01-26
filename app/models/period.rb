class Period < ActiveRecord::Base
  attr_accessible :convention_id, :name, :period_type, :time_span_attributes, :special

  has_one :time_span, :as => :time_spanable
  accepts_nested_attributes_for :time_span
  validates_presence_of :time_span

  belongs_to :convention

  validates_presence_of :name

  SPECIAL_PERIODS = ["planning", "production", "open", "wrap-up"]
end
