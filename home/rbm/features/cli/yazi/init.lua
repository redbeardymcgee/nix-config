function Header:host()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Span(ya.user_name() .. " 󰁥 " .. ya.host_name()):fg("blue")
end

function Header:render(area)
	self.area = area

	local right = ui.Line { self:count(), self:tabs() }
	local left = ui.Line { self:host(), self:cwd(math.max(0, area.w - right:width())) }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
	}
end

function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end
	return ui.Span(" " .. h.name)
end

function Status:owner()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line {}
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	}
end

function Status:render(area)
	self.area = area

	local left = ui.Line { self:mode(), self:size(), self:name() }
	local right = ui.Line { self:owner(), self:permissions(), self:percentage(), self:position() }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end

require("starship"):setup()

require("searchjump"):setup {
    unmatch_fg = "#928374",
    match_str_fg = "#000000",
    match_str_bg = "#73AC3A",
    lable_fg = "#EADFC8",
    lable_bg = "#BA603D",
    only_current = false, -- only search the current window
    show_search_in_statusbar = true,
    auto_exit_when_unmatch = true,
    search_patterns = {}  -- demo:{"%.e%d+","s%d+e%d+"}
}

require("yamb"):setup {
  -- Optional, the path ending with path seperator represents folder.
  -- bookmarks = bookmarks,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  -- path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark") or
  --       (os.getenv("HOME") .. "/.config/yazi/bookmark"),
}

require("full-border"):setup()
