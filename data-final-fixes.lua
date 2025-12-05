-- Definicja helpera
function table.filterKey(t, keyToRemove)
	local new_table = {}
	for k, v in pairs(t) do
		if k ~= keyToRemove then
			new_table[k] = v
		end
	end
	return new_table
end

if settings.startup["generate-oil-only-on-water"].value then
	data.raw["planet"]["arig"].map_gen_settings.autoplace_controls =
		table.filterKey(data.raw["planet"]["arig"].map_gen_settings.autoplace_controls, "heavy-oil-geyser")
	data.raw["planet"]["arig"].map_gen_settings.autoplace_settings.entity.settings = table.filterKey(
		data.raw["planet"]["arig"].map_gen_settings.autoplace_settings.entity.settings,
		"heavy-oil-geyser"
	)
end

local planet = data.raw.planet and data.raw.planet["arig"]
local mgs = planet.map_gen_settings or {}
mgs.autoplace_controls = mgs.autoplace_controls or {}
mgs.autoplace_controls["offshore-heavy-oil"] = mgs.autoplace_controls["offshore-heavy-oil"]
	or {
		frequency = 3,
		size = 1.2,
		richness = 2,
		starting_area = false,
	}

mgs.autoplace_settings = mgs.autoplace_settings or {}
mgs.autoplace_settings["entity"] = mgs.autoplace_settings["entity"] or { settings = {} }
mgs.autoplace_settings["entity"].settings["offshore-heavy-oil"] = mgs.autoplace_settings["entity"].settings["offshore-heavy-oil"]
	or {}

planet.map_gen_settings = mgs
