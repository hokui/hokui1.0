require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "registration_confirm" do
    mail = NoticeMailer.registration_confirm
    assert_equal "Registration confirm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
