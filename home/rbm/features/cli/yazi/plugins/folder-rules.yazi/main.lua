local function setup()
	ps.sub("cd", function()
		local cwd = cx.active.current.cwd
		if cwd:ends_with("Downloads") or cwd:ends_with("Screenshots") then
			ya.emit("sort", { "mtime", reverse = false, dir_first = false })
		else
			ya.emit("sort", { "alphabetical", reverse = false, dir_first = true })
		end
	end)
end

return { setup = setup }
