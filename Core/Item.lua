---@class ham
local ham = select(2,...)
---@class Item
---@field id number Item ID
---@field name string Item Name
ham.Item = {}
-- Constructor for creating a new Item object
function ham.Item:new(id, name)
	local obj = setmetatable({}, { __index = ham.Item })
	obj.id = id -- Assign the item ID
	obj.name = name -- Assign the item name
	return obj
end
---sets the name of the item
function ham.Item:setName()
    local itemInfoName = C_Item.GetItemInfo(self.id)
    if itemInfoName ~= nil then
      self.name = itemInfoName
    end
  end
---@return number self.id Unique identifier for the item
function ham.Item:getId()
	return self.id
end
---@return number|string self.count Number of items in the player's inventory
function ham.Item:getCount()
	return C_Item.GetItemCount(self.id, false, false)
end


