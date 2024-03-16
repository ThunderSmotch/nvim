local get_visual = lua_snip_utils.get_visual

-- Example: expanding a snippet on a new line only.
-- In a snippet file, first require the line_begin condition...
-- Move this somewhere else
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- TODO
-- Find a way to delete paired parenthesis
-- Maybe swap to nvim auto pairs

return {
	-- Paired parenthesis
	s({
		trig="(",
		snippetType="autosnippet",
		dscr="Paired parenthesis",
		wordTrig=false,
		regTrig=false,
		trigEngine="plain",
	},
		fmta([[
		(<>)
		]],
		{d(1, get_visual)}
		),
		{ }
	),
	-- Paired curly braces
	s({
		trig="{",
		snippetType="autosnippet",
		dscr="Paired curly braces",
		wordTrig=false,
		regTrig=false,
		trigEngine="plain",
	},
		fmta([[
		{<>}
		]],
		{d(1, get_visual)}
		),
		{ }
	),
	-- Paired squared braces
	s({
		trig="[",
		snippetType="autosnippet",
		dscr="Paired squared braces",
		wordTrig=false,
		regTrig=false,
		trigEngine="plain",
	},
		fmta([[
		[<>]
		]],
		{d(1, get_visual)}
		),
		{ }
	),
	-- Paired double quotes
	s({
		trig='([ `=%(%{%[])"',
		snippetType="autosnippet",
		dscr="Paired double quotes",
		wordTrig=false,
		regTrig=true,
		trigEngine="pattern",
	},
		fmta([[
		<>"<>"
		]],
		{f(function(_, snip) return snip.captures[1] end), d(1, get_visual)}
		),
		{options}
	),
	-- Paired single quotes
	s({
		trig="([ `=%(%{%[])'",
		snippetType="autosnippet",
		dscr="Paired single quotes",
		wordTrig=false,
		regTrig=true,
		trigEngine="pattern",
	},
		fmta([[
		<>'<>'
		]],
		{f(function(_, snip) return snip.captures[1] end), d(1, get_visual)}
		),
		{options}
	),

	
  -- Example: italic font implementing visual selection
s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
  fmta("\\textit{<>}",
	{
	  d(1, get_visual),
	}
  )
), 
}
