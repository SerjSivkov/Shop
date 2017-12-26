# создание 100 заказов






Order.transaction do
	(1..100).each do |i|
		Order.create(name: "Клиент #{i}", address: "#{i} улица",
			email: "клиент-#{i}@google.com", pay_type: "Наложенный платеж")
	end
end