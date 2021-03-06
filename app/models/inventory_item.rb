# Inventory Item model
# Schema:
#   - title   Mandatory   unique   maxLen = 50
#   - price   Optional
#   - remark  Optional
class InventoryItem < ApplicationRecord
  validates :title, uniqueness: true, presence: true, length: { maximum: 50 }

  has_many :records, dependent: :delete_all
  has_many :inventories, through: :records

  def increment(inventory, count = 1)
    record = Record.find_or_create_by(inventory_item_id: id, inventory_id: inventory.id)
    record.quantity += count.to_i
    record.save
  end

  def assign(inventory, initial_count = 0)
    if Record.exists?(inventory_item_id: id, inventory_id: inventory.id)
      return raise StandardError, "This inventory was already added to item"
    end

    increment(inventory_item, initial_count)
  end

  def quantity(inventory)
    record = Record.find_by(inventory_item_id: id, inventory_id: inventory.id)
    record.quantity
  end

  def total_quantity
    total = 0
    records.each do |inventory|
      total += inventory.quantity
    end
    total
  end

  def proportions
    total = total_quantity

    calculated_proportions = {}
    records.each do |record|
      calculated_proportions[record.inventory] = record.quantity / total
    end
    calculated_proportions
  end
end
