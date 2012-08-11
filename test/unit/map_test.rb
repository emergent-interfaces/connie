require 'test_helper'

class MapTest < ActiveSupport::TestCase
  should belong_to :space
  should have_attached_file :image
  should validate_attachment_presence :image
  should validate_attachment_content_type(:image).allowing('image/png','image/jpg','image.gif')
end
