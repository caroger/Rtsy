json.extract! cart_item,  :user_id, :product_id, :quantity, :id
json.product cart_item.product
json.imageUrl url_for(cart_item.product.photos.first)
