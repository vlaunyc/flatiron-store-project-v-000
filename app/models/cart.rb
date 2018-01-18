
class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    @total = 0
    self.line_items.each do |li|
      @total += li.item.price * li.quantity
    end
    @total
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id) #find line item
    if line_item #if item is already in cart, increment by 1
      line_item.quantity += 1
    else #otherwise add
      line_item = self.line_items.build(item_id: item_id)
    end
    line_item
  end

end
