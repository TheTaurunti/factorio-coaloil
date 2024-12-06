-- This script's purpose is to make sure techs get unlocked properly when the mod is added to a game in progress.

local function enable_recipe_if_tech(force, recipe, tech)
  if (not force.recipes[recipe]) then return end

  if (force.technologies[tech])
  then
    if (force.technologies[tech].researched)
    then
      force.recipes[recipe].enabled = true
    end
  else
    -- This is a safeguard: If tech doesn't exist, give recipe outright.
    force.recipes[recipe].enabled = true
  end
end

script.on_init(function(_event)
  for _, force in pairs(game.forces) do
    enable_recipe_if_tech(force, "chemical-plant", "oil-gathering")
    enable_recipe_if_tech(force, "co_coal-to-crude-oil", "oil-gathering")
    enable_recipe_if_tech(force, "co_coal-to-heavy-oil", "advanced-oil-processing")
    enable_recipe_if_tech(force, "co_coal-liquefaction", "coal-liquefaction")
  end
end)
