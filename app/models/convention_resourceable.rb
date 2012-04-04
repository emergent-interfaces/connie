class ConventionResourceable < ActiveRecord::Base
  belongs_to :convention
  belongs_to :resourceable, :polymorphic => true
end