require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test "покупка товара" do
  	LineItem.delete_all
	Order.delete_all
	flyus_order = products(:flyus)
	#пользователь заходит на старницу каталога магазина
	get "/"
	assert_response :success
	assert_template "index"
	#выбор товара и добавление его в карзину
	xml_http_request :post, '/line_items', product_id: flyus_order.id
	assert_response :success
	cart = Cart.find(session[:cart_id])
	assert_equal 1, cart.line_items.size
	assert_equal flyus_order, cart.line_items[0].product
	# оформление заказа
	get "/orders/new"
	assert_response :success
	assert_template "new"

	post_via_redirect "/orders",
		order: {name:    "Иванов Иван",
		        address: "Севастополь, ул. Универстетская, 26",
		        email:   "dave@example.com",
		        pay_type: "Наложенный платеж"}
	assert_response :success
	assert_template "index"
	cart = Cart.find(session[:cart_id])
	assert_equal 0, cart.line_items.size
	# проверка БД с заказом
	orders = Order.all
	assert_equal 1, orders.size
	order = order[0]

	assert_equal "Иванов Иван", order.name
	assert_equal "Севастополь, ул. Универстетская, 26", order.address
	assert_equal "ivanov@mail.ru", order.email
	assert_equal "Наложенный платеж", order.pay_type

	assert_equal 1, order.line_items.size
	line_item = order.line_items[0]
	assert_equal flyus_order, line_item.product
	# отправка письма
	mail = ActionMailer::Base.deliveries.last
	assert_equal ["ivanov@mail.ru"], mail.to
	assert_equal 'Sergey Sivkov <shop@localhost>', mail[:from].value
	assert_equal "Подтверждение заказа в Shop Online", mail.subject
  end
end
