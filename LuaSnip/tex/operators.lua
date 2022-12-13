local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end


local operators = {"sin", "cos", "arccot", "cot", "csc", "ln", "log", "exp", "arcsin", "arccos", "arctan", "arccot", "arcsec", "pi", "min", "max", "det"}

local snips = {}

for i, operator in ipairs(operators) do
	table.insert(snips, s({
		trig="([^%a%\\])"..operator,
		snippetType="autosnippet",
		dscr="Operator "..operator,
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\<>
		]],
		{f(function (_, snip) return snip.captures[1] end), t(operator)}
		),
		{condition=tex.in_mathzone}
	)
	)
end


return snips
