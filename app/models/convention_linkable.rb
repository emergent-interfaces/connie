class ConventionLinkable < ActiveRecord::Base
  belongs_to :convention
  belongs_to :linkable, :polymorphic => true
end