-- This script's purpose is to make sure techs get unlocked properly when the mod is added to a game in progress.

local function enable_recipe_if_tech(force, recipe, tech)
	if (force.technologies[tech])
	then
		if (force.technologies[tech].researched)
		then
			force.recipes[recipe].enabled = true
		end
	else
		force.recipes[recipe].enabled = true
	end
end

script.on_init(function(_event)
	for _, force in pairs(game.forces) do
		enable_recipe_if_tech(force, "co_coal-to-crude-oil", "oil-processing")
		enable_recipe_if_tech(force, "co_coal-to-heavy-oil", "advanced-oil-processing")
	end
end)
