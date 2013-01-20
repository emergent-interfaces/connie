class Assignee < ActiveRecord::Base
  attr_accessible :job_id, :profile_id

  belongs_to :job
  belongs_to :profile

  validates_presence_of :job, :profile
  validates :profile_id, :uniqueness => {:scope => :job_id, :message => 'profile already assigned'}
end
