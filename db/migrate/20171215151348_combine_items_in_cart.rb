class CombineItemsInCart < ActiveRecord::Migration[5.1]
  def up
    # Замена нескольких записей 1
    Cart.all.each do |cart|
      # Подсчет количества каждого товара в корзине
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # Удаление отдельных записей
          cart.line_items.where(product_id: product_id).delete_all

          # Замена одной записью
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end
  def down
    # Разбиение записей с quantity>1 на несколько записей
    LineItem.where("quantity>1").each do |line_item|
      # жобавление отдельной записи
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end
      # удаление исходной записи
      line_item.destroy
    end
  end
end
