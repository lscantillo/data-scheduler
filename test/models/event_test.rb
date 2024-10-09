# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  title        :string
#  start_time   :datetime
#  end_time     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  worker_id    :integer
#  user_id      :integer
#  location     :string
#  weather_info :jsonb
#
require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
