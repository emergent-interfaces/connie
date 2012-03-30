class ConventionEvent < ActiveRecord::Base
  belongs_to :convention
  belongs_to :event
end