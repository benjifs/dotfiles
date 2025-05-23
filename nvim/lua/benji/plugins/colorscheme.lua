return {
	'tjdevries/colorbuddy.nvim',
	config = function()
		require('colorbuddy').setup()
		local Color = require('colorbuddy').Color
		local Group = require('colorbuddy').Group
		local g = require('colorbuddy.group').groups
		local c = require('colorbuddy.color').colors
		local s = require('colorbuddy.style').styles
		local b = s.bold
		local i = s.italic
		local n = s.inverse
		local uc = s.undercurl
		local ul = s.underline
		local r = s.reverse
		local sto = s.standout
		local no = s.NONE
		local v = vim.g

		v.colors_name = 'sylveon'

		local palette = {
			background = "#131415",
			foreground = "#ffffff",
			comment = "#666666",
			cyan = "#56c7f5",
			green = "#6ef596",
			pink = "#f27b92",
			purple = "#71a8fe",
			red = "#f55678",
			yellow = "#f7f086",
		}

		-- initialize all colors from palette
		for key, value in pairs(palette) do
			Color.new(key, value)
		end


		Group.new('Normal', c.foreground, c.none, no)
		Group.new('String', c.green, c.none, no)
		Group.new('Comment', c.comment, c.none, i)
		Group.new('SpecialComment', c.foreground, c.purple, i)
		Group.new("Warnings", c.yellow, c.none, no)
		Group.new('Error', c.red, c.none, no)
		Group.new('Todo', c.cyan, c.none, no)
		Group.new('Special', c.foreground, c.none, no)
		Group.new('Identifier', c.foreground, c.none, no)
		Group.new('Label', c.purple, c.none, no)
		Group.new('LineNr', c.comment, c.none, no)
		Group.new('Typedef', c.purple, c.none, no)
		Group.new('Conditional', c.pink, c.none, no)
		Group.new('Function', c.cyan, c.none, no)
		Group.new('Statement', c.red, c.none, no)
		Group.new('Include', c.yellow, c.none, no)
		Group.new('Operator', c.purple, c.none, no)
		Group.new('MatchParen', c.background, c.pink, no)
		Group.new('Constant', c.yellow, c.none, b)
		Group.new('Boolean', c.purple, c.none, no)
		Group.new('Number', c.pink, c.none, no)
		Group.new('Structure', c.purple, c.none, no)
		Group.new('Cursor', c.foreground, c.purple, no)

		-- LSP: this one seems to do the trick on nightly
		Group.new('DiagnosticError', c.red, c.none, i)
		Group.new('DiagnosticWarn', c.yellow, c.none, i)
		Group.new('DiagnosticHint', c.green, c.none, i)
		Group.new('DiagnosticInfo', c.yellow, c.none, i)

		-- diff
		Group.new('diffAdded', c.green, c.none, no)
		Group.new('diffRemoved', c.red, c.none, no)
		Group.new('diffChanged', c.pink, c.none, no)

		-- status line of current window
		Group.new('StatusLine', c.none, c.comment, no)
	end,
}