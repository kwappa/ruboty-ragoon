require 'test/unit'
require 'ruboty/ragoon'

class TestRagoonNotification < Test::Unit::TestCase
  setup do
    ENV['GAROON_ENDPOINT'] = 'dummy_endpoint'
    ENV['GAROON_USERNAME'] = 'dummy_username'
    ENV['GAROON_PASSWORD'] = 'dummy_password'

    @notification = ::Ruboty::Ragoon::Notification.new(::Ruboty::Brains::Memory.new)
  end

  test 'notify new notification only once' do
    assert_equal(@notification.not_notified_ids([]), [])
    assert_equal(@notification.not_notified_ids([1, 2, 3]), [1, 2, 3])
    assert_equal(@notification.not_notified_ids([1, 3, 4]), [4])
  end
end
