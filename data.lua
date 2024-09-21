-- Coal -> Oil recipe
local coal_to_crude_recipe = {
	type = "recipe",
	name = "co_coal-to-crude-oil",
	icon = "__base__/graphics/icons/fluid/crude-oil.png",
	icon_size = 64,
	crafting_machine_tint = {
		primary = { 0.1, 0.1, 0.1 },        -- "coal" color
		secondary = { 51, 118, 171 },       -- "dark water" color
		tertiary = { 0.85, 0.85, 0.9, 0.1 }, -- plume edge color
		quaternary = { 0.65, 0.65, 0.7, 0.2 } -- plume core color
	},
	ingredients = {
		{ type = "item",  name = "coal",  amount = 10 },
		{ type = "fluid", name = "water", amount = 50 },
	},
	results = {
		{ type = "fluid", name = "crude-oil", amount = 100 },
	},
	category = "chemistry",
	subgroup = "fluid-recipes",
	energy_required = 10,
	allow_decomposition = false
}

-- Turn coal directly to heavy, no byproducts.
-- > Concept is for lower-throughput lube applications
local coal_to_heavy_recipe = {
	type = "recipe",
	name = "co_coal-to-heavy-oil",
	icon = "__base__/graphics/icons/fluid/heavy-oil.png",
	icon_size = 64,
	crafting_machine_tint = {
		primary = { 0.58, 0.30, 0.12 }, -- heavy oil
		secondary = { 0, 0, 0 },       -- oil
		tertiary = { 0.79, 0.65, 0.56 }, -- plume edge color (heavy oil tint)
		quaternary = { 0.2, 0.2, 0.2 } -- plume core color (oil tint)
	},
	ingredients = {
		{ type = "item",  name = "coal",      amount = 2 },
		{ type = "fluid", name = "crude-oil", amount = 20, fluidbox_index = 1 },
		{ type = "fluid", name = "steam",     amount = 25, fluidbox_index = 2 }
	},
	results = {
		{ type = "fluid", name = "heavy-oil", amount = 20 },
	},
	category = "chemistry",
	subgroup = "fluid-recipes",
	energy_required = 5,
	allow_decomposition = false
}

-- Don't want to change from vanilla by default, BUT...
-- ... offers an upgraded coal liquefaction recipe for the interested.
if (settings.startup["CoalOil-change-liquefaction"].value)
then
	local coal_liquefaction = data.raw["recipe"]["coal-liquefaction"]

	if (coal_liquefaction)
	then
		coal_liquefaction.ingredients = {
			{ type = "item",  name = "coal",          amount = 10 },
			{ type = "fluid", name = "petroleum-gas", amount = 10, fluidbox_index = 2 },
			{ type = "fluid", name = "steam",         amount = 50, fluidbox_index = 1 }
		}
		coal_liquefaction.results = {
			{ type = "fluid", name = "crude-oil", amount = 100, fluidbox_index = 3 },
			{ type = "fluid", name = "heavy-oil", amount = 65,  fluidbox_index = 1 },
			{ type = "fluid", name = "light-oil", amount = 35,  fluidbox_index = 2 }
		}
	end
end


-- Add recipe unlocks
local tech = data.raw["technology"]

if (tech["oil-processing"])
then
	coal_to_crude_recipe.enabled = false
	table.insert(tech["oil-processing"].effects,
		{
			type = "unlock-recipe",
			recipe = "co_coal-to-crude-oil"
		}
	)
end
if (tech["advanced-oil-processing"])
then
	coal_to_heavy_recipe.enabled = false
	table.insert(tech["advanced-oil-processing"].effects,
		{
			type = "unlock-recipe",
			recipe = "co_coal-to-heavy-oil"
		}
	)
end



data:extend { coal_to_crude_recipe }
data:extend { coal_to_heavy_recipe }
