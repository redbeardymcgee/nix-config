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
    unmatch_fg = "#a6adc8",
    match_str_fg = "#cba6f7",
    match_str_bg = "#7f849c",
    lable_bg = "#6c7086",
    lable_fg = "#000000",
    only_current = false, -- only search the current window
    show_search_in_statusbar = true,
    auto_exit_when_unmatch = true,
    search_patterns = {}  -- demo:{"%.e%d+","s%d+e%d+"}
}

require("yamb"):setup {}

require("full-border"):setup()
