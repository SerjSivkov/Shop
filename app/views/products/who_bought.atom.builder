atom_feed do |feed|
	feed.title "Кто купил #{@product.title}"
	feed.updated @latest_order.try(:updated_at)
	@product.orders.each do |order|
		feed.entry(order) do |entry|
			entry.title "Заказ #{order.id}"
			entry.summary type: 'xhtml' do |xhtml|
				xhtml.p "Отправить #{order.address}"
				xhtml.table do
					xhtml.tr do
						xhtml.th 'Продукт'
						xhtml.th 'Количество'
						xhtml.th 'Конечная цена'
					end
					order.line_items.each do |item|
						xhtml.tr do
							xhtml.td item.product.title
							xhtml.td item.quantity
							xhtml.td number_to_currency item.total_price
						end
					end
					xhtml.tr do
						xhtml.th 'total', colspan: 2
						xhtml.th number_to_currency order.line_items.map(&:total_price).sum
					end
				end
				xhtml.p "Оплачено #{order.pay_type}"
			end
			entry.author do |author|
				author.name order.name
				author.email order.email
			end
		end
	end
end