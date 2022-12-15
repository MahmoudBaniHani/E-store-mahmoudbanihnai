class OrderItemDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id: { source: "OrderItem.id", cond: :eq },
      order_id: { source: "OrderItem.order_id", cond: :like },
      user_email: { source: "OrderItem.user_email", cond: :like },
      product_name: { source: "OrderItem.product_name", cond: :like },
      unit_price: { source: "OrderItem.unit_price", cond: :like },
      quantity: { source: "OrderItem.quantity", cond: :like },
      total: { source: "OrderItem.total", cond: :like },
      store_name: { source: "OrderItem.store_name", cond: :like,searchable: true },
    }
  end

  def data
    records.map do |record|
      record_product = Product.find(record.product_id)
      {
        id: record.id,
        order_id:record.order_id,
        user_email: User.find(Order.find(record.order_id).user_id).email,
        product_name:record_product.product_name,
        unit_price:record.unit_price,
        quantity:record.quantity,
        total: record.total,
        store_name:record_product.store.store_name
      }
    end
  end

  def get_raw_records
      products = Array.new
      options[:current_user].products.each { |product| products.push product.id }
      OrderItem.where(product_id: products)
  end

end
