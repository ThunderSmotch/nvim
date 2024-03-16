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
		{condition=lua_snip_utils.in_mathzone}
	)
	)
end

return snips
