-- Return the first index with the given value (or nil if not found).
function IndexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return 99
end

-- Define list of terms that need translation.
function FbN_GetSpellNameById(spellId)
	if (spellId == nil) then
		return nil
	end
	local spellName, rank, _, _, _, _, _, _, _ = GetSpellInfo(spellId)
	if rank == nil then
		return spellName
	elseif string.len(rank) > 1 then
		return spellName .. "(" .. rank .. ")"
	end
	return spellName
end

--GUID Parser
function ParseGUID(guid)
	if guid == nil then
		FeralbyNight.currentTarget.id = 0000;
		if (FeralbyNight.DevMode) then print("No target, ID #",FeralbyNight.currentTarget.id) end
		return
	end

	local first3 = tonumber("0x" .. strsub(guid, 3, 5))
	local unitType = bit.band(first3, 0x00f)
	FeralbyNight.currentTarget.unitType = unitType;
	if (unitType == 0x000) then
		if (FeralbyNight.DevMode) then  print("Player, ID #", strsub(guid,6)) end
	elseif (unitType == 0x003) then
		local creatureID = tonumber("0x" .. strsub(guid, 9, 12))
		FeralbyNight.currentTarget.id = creatureID;
		local spawnCounter = tonumber("0x" .. strsub(guid, 13))
	elseif (unitType == 0x004) then
		local petID = tonumber("0x" .. strsub(guid, 6, 12))
		local spawnCounter = tonumber("0x" .. strsub(guid, 13))
		if (FeralbyNight.DevMode) then print("Pet, ID #",petID,"spawn #",spawnCounter) end
	elseif (unitType == 0x005) then
		local creatureID = tonumber("0x" .. strsub(guid, 9, 12))
		local spawnCounter = tonumber("0x" .. strsub(guid, 13))
		if (FeralbyNight.DevMode) then print("Vehicle, ID #",creatureID,"spawn #",spawnCounter) end
	end
end