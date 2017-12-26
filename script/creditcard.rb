credit_card = ActiveMerchant::Billing::CreditCard.new(
	number: '4111111111111111',
	month: '8',
	year: '2009',
	first_name: 'Sivkov',
	last_name: 'Sergey',
	verification_value: 000)
puts "Действительна ли карта #{credit_card.number}? #{credit_card.valid?}"