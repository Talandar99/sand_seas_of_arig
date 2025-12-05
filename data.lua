local resource_autoplace = require("resource-autoplace")

-- map resource
data:extend({
	{
		type = "autoplace-control",
		name = "offshore-heavy-oil",
		richness = true,
		can_be_disabled = true,
		order = "a-e-b",
		category = "resource",
		icon = "__base__/graphics/icons/fluid/heavy-oil.png",
		hidden = true,
	},
	{
		type = "resource-category",
		name = "offshore-fluid",
	},
	{
		type = "resource",
		name = "offshore-heavy-oil",
		icon = "__base__/graphics/icons/fluid/heavy-oil.png",
		flags = { "placeable-neutral" },
		category = "offshore-fluid",
		subgroup = "mineable-fluids",
		order = "a-b-a",
		infinite = true,
		highlight = true,
		minimum = 60000,
		normal = 300000,
		infinite_depletion_amount = 25,
		resource_patch_search_radius = 50,
		minable = {
			mining_time = 1,
			results = {
				{
					type = "fluid",
					name = "heavy-oil",
					amount_min = 6, --base is 10
					amount_max = 6, --base is 10
					probability = 1,
				},
			},
		},
		--		minable = {
		--			mining_time = 1,
		--
		--			results = {
		--				{
		--					type = "fluid",
		--					name = "heavy-oil",
		--					amount_min = 10,
		--					amount_max = 10,
		--					probability = 1,
		--				},
		--			},
		--		},
		walking_sound = data.raw.resource["crude-oil"].walking_sound,
		driving_sound = data.raw.resource["crude-oil"].driving_sound,
		collision_mask = { layers = { water_resource = true } },
		protected_from_tile_building = false,
		--collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
		--selection_box = {{-1.0, -1.0}, {1.0, 1.0}},

		collision_box = table.deepcopy(data.raw.resource["crude-oil"].collision_box),
		autoplace = resource_autoplace.resource_autoplace_settings({
			name = "offshore-heavy-oil",
			order = "b",
			--base_density = 10,
			base_density = 1,
			base_spots_per_km2 = 1.8,
			--random_probability = 1 / 400,
			random_probability = 1 / 100,
			random_spot_size_minimum = 1,
			random_spot_size_maximum = 2,
			additional_richness = 250000,
			has_starting_area_placement = false,
			regular_rq_factor_multiplier = 1,
		}),

		--autoplace = resource_autoplace.resource_autoplace_settings({
		--	name = "offshore-heavy-oil",
		--	order = "a",
		--	base_density = 10, -- amount of stuff, on average, to be placed per tile
		--	base_spots_per_km2 = 1.8, -- number of patches per square kilometer near the starting area
		--	random_probability = 1 / 400, -- probability of placement at any given tile within a patch (set low to ensure space between deposits for rigs to be placed)
		--	random_spot_size_minimum = 3,
		--	random_spot_size_maximum = 4,
		--	additional_richness = 350000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
		--	has_starting_area_placement = true,
		--	regular_rq_factor_multiplier = 1, -- rq_factor is the ratio of the radius of a patch to the cube root of its quantity,
		--	-- i.e. radius of a quantity=1 patch; higher values = fatter, shallower patches
		--}),
		selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
		stage_counts = { 0 },
		stages = {
			sheet = {
				filename = "__sand_seas_of_arig__/graphics/heavy-oil-sludge-stain.png",
				priority = "extra-high",
				width = 148,
				height = 120,
				frame_count = 4,
				variation_count = 1,
				shift = util.by_pixel(0, -2),
				scale = 0.7,
			},
		},
		map_color = { 0.4, 0.2, 0.2 },
		map_grid = false,
	},
})

-- increase efficiency of ships to make sure they won't die randomly
local ship = data.raw["locomotive"]["cargo_ship_engine"]
ship.energy_source = ship.energy_source or {}
--ship.energy_source.effectivity = 1
ship.energy_source.effectivity = 1.5
ship.energy_source.fuel_inventory_size = 10

-- remove filter from oil rig in order to allow uranium mining
local generator = data.raw["generator"]["or_power_electric"]
if generator and generator.fluid_box then
	generator.fluid_box.filter = nil
	-- increase effectivity to make sure oil rig won't die randomly while mining uranium sludge
	generator.effectivity = 5000
end

data.raw["technology"]["planetaris-advanced-heavy-oil-cracking"].research_trigger = {
	type = "mine-entity",
	entity = "arig-crash",
}

table.insert(
	data.raw["simple-entity"]["arig-crash"].minable.results,
	{ type = "item", name = "heavy-oil-barrel", amount_min = 2, amount_max = 5 }
)
table.insert(data.raw.technology["planet-discovery-arig"].prerequisites, "deep_sea_oil_extraction")
