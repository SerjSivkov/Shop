require 'test_helper'
class ProductTest < ActiveSupport::TestCase
    fixtures :products
  test "свойства товара не должны оставаться пустыми" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "цена товара должна оставаться положительной" do
    product = Product.new(title: 'Мультиметр', description: 'Автоматический мультиметр фирмы UTI-T',
      image_url:'unit.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["должна быть больше или равна 0.01"],
          product.errors[:price]
    product.price = 0

    assert product.invalid?
    assert_equal ["должна быть больше или равна 0.01"],
          product.errors[:price]
    product.price = 1
    assert product.valid?
  end
  #def new_product(image_url)
  #   Product.new(title: 'Мультиметр',
  #               description: 'Автоматический мультиметр фирмы UTI-T',
  #               price: 1,
  #               image_url:image_url)
  #end
   #test "url изображения"
   # ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
   #         http://a.b.c/x/y/z/fred.gif }
   # bad = %w{ fred.doc fred.gif/more fred.gif.more}
   # ok.each do |name|
   #     assert new_product(name).valid?, "#{name} не должно быть неприемлемым"
   # end
   # bad.each do |name|
   #     assert new_product(name).invalid?, "#{name} не должно быть приемлемым"
   # end
  test "у товара не уникальное название - i18n" do
    product = Product.new(title: products(:flyus).title,
                 description: products(:flyus).description,
                 price: products(:flyus).price,
                 image_url: products(:flyus).image_url)
    assert product.invalid?
    assert_equal [I18n.translate('activerecord.errors.messages.taken')],
        product.errors[:title]

  end
end
