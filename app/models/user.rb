class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :profile_id, :admin

  validates_presence_of :username

  belongs_to :profile

  def permissions
    auth_requirements_satisfied = []

    cons_involved_in = profile.roles.collect {|role| role.convention}
    cons_involved_in.each do |con|
      con.auth_requirements.each do |ar|
        auth_requirements_satisfied << ar if ar.met_by_any_of(profile.roles)
      end
    end

    auth_requirements_satisfied
  end
end
