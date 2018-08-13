local function lt(command)
	minetest.send_chat_message("//lt "..command)
end

-- This gets reused
local match_func = "function string:matches(input) if input:find(\":\") then return self == input else return self:match(input) end end"

minetest.register_chatcommand("grass", {
	params = "<chance> (higher = less likely)",
	description = "Populate with grass.",
	func = function(param)
		local chance = "10"
		if param ~= "" then
			if not tonumber(param) then
				return false, "Invalid usage. <chance> must be a number."
			end
			if tonumber(param) < 1 then
				return false, "Chance must be greater than 0."
			end
			chance = param
		end
		lt("local chance = math.random(1,"..chance..") local size = math.random(1,5) if minetest.get_node(pos).name == \"air\" then if minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name:find(\"dirt_with_grass\") then if chance > "..tostring(tonumber(chance)-1).." then minetest.set_node(pos, {name=\"default:grass_\"..tostring(size)}) end end end")
	end,
})

minetest.register_chatcommand("rs", {
	params = "<node to replace>, <node to replace 2>, <...> | <node to replace with>",
	description = "Smart //replace.",
	func = function(param)
		local params = param:split(" ")
		if #params < 2 then
			return false, "Invalid usage (need more than one parameter)."
		end
		local terms = ""
		for i = 1,#params-1 do
			terms = terms..", \""..params[i].."\""
		end
		terms = terms:sub(3)
		lt("local terms = {"..terms.."} local rnode = \""..tostring(params[#params]).."\" local node = minetest.get_node(pos).name "..match_func.." for _, name in pairs(terms) do if node:matches(name) then minetest.set_node(pos, {name=rnode}) end end")
	end,
})

minetest.register_chatcommand("stk", {
	params = "<node to stack>, <node to stack 2>, <...> | <axis> <amount>",
	description = "Smart //stack.",
	func = function(param)
		local params = param:split(" ")
		if #params < 3 then
			return false, "Invalid usage (need at least 3 parameters)."
		end
		local axis = params[#params-1]
		local amount = params[#params]
		local function is_axis(input)
			local valid_axis = {"x", "y", "z"}
			for i = 1, #valid_axis do
				if valid_axis[i] == input then
					return true
				end
			end
		end
		if not is_axis(axis) then
			return false, "Invalid usage: <axis> must be 'x', 'y', or 'z'."
		end
		if not tonumber(amount) then
			return false, "Invalid usage: <amount> must be a number."
		end
		local terms = ""
		for i = 1,#params-2 do
			terms = terms..", \""..params[i].."\""
		end
		terms = terms:sub(3)
		local dir = "+"
		if tonumber(amount) < 0 then
			dir = "-"
		end
		lt("local posoff = 0 local terms = {"..terms.."} local node = minetest.get_node(pos).name "..match_func.." for _, name in pairs (terms) do if node:matches(name) then for i = 1, "..amount:gsub("-", "").." do local ix, iy, iz = 0, 0, 0 i"..axis.." = i local newpos = {x=pos.x"..dir.."ix,y=pos.y"..dir.."iy,z=pos.z"..dir.."iz} minetest.set_node(newpos,{name=node}) posoff = posoff + i end end end")
	end,
})
