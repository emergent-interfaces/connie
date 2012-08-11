class Map < ActiveRecord::Base
  attr_accessible :space_id, :image

  belongs_to :space

  has_attached_file :image,
                    :styles => { :thumb => "260x180#"}
  validates_attachment_presence :image
end
