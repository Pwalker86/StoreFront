# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class GuestTest < ActiveSupport::TestCase
  def setup
    @guest = guests(:guest_one)
  end
  test "email returns an empty string" do
    assert_equal "", @guest.email
  end

  test "display_name" do
    assert "Guest - Not Logged In", @guest.display_name
  end
end
