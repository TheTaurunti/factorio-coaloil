-- Thank you @Xorimuth <3
local function allow_recipe_productivity(recipe_name)
	for _, module in pairs(data.raw.module) do
		if module.category == "productivity" and module.limitation then
			table.insert(module.limitation, recipe_name)
		end
	end
end

allow_recipe_productivity("co_coal-to-crude-oil")
allow_recipe_productivity("co_coal-to-heavy-oil")
