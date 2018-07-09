class SellBook
  def initialize(stock, copies)
    @stock = stock
    @copies = copies
  end

  def call
    validate_stock
    update_stock
  end

  def validate_stock
    raise SellBookError, 'Number of copies is incorrect' unless @copies&.is_a?(Integer)
    raise SellBookError, 'Out of stock' if @copies > @stock.in_stock
  end

  def update_stock
    @stock.update_attributes(
      in_stock: @stock.in_stock - @copies,
      sold: @stock.sold + @copies
    )
  end

  class SellBookError < StandardError; end
end