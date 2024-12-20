--- entry point
--- @class ns
local ns = ...


--- Item.lua
--- Handles WoW item data and caching
---@class Item
---@field private itemId number
---@field private itemName string
local Item = {}
local ItemMetatable = { __index = Item }

-- Local cache of item instances
---@type table<number, Item>
local itemCache = {}

--- Creates a new Item instance
---@param itemId number
---@param initialName? string
---@return Item
function Item:New(itemId, initialName)
    if itemCache[itemId] then
        return itemCache[itemId]
    end

    local instance = setmetatable({
        itemId = itemId,
        itemName = initialName or "",
    }, ItemMetatable)

    itemCache[itemId] = instance
    instance:UpdateName()
    return instance
end

--- Updates the item name from the WoW API
function Item:UpdateName()
    local itemName = C_Item.GetItemInfo(self.itemId)
    if itemName then
        self.itemName = itemName
    end
end

--- Gets the item's ID
---@return number
function Item:GetId()
    return self.itemId
end

--- Gets the item's name
---@return string
function Item:GetName()
    return self.itemName
end

--- Gets the total count of this item in the player's bags
---@return number
function Item:GetCount()
    return C_Item.GetItemCount(self.itemId, false, false)
end

---Export to Shared Namespace
-- Add the Item class to the addon's namespace
ns.Item = Item

-- Example usage:
-- local myItem = NS.Item:New(123) -- itemId 123
-- print(myItem:GetName())
