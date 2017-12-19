require 'test_helper'

class OrderNotifierMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifierMailer.received(orders(:one))
    assert_equal "Подтверждение заказа в Shop Online", mail.subject
    assert_equal ["serjsivkov@gmail.com"], mail.to
    assert_equal ["serjsivkov@gmail.com"], mail.from
    assert_match "Привет", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifierMailer.shipped(orders(:one))
    assert_equal "Заказ из Shop Online отправлен", mail.subject
    assert_equal ["serjsivkov@gmail.com"], mail.to
    assert_equal ["serjsivkov@gmail.com"], mail.from
    assert_match "&times;", mail.body.encoded
  end

end
