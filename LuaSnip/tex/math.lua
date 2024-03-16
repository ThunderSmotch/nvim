local get_visual = lua_snip_utils.get_visual
local in_mathzone = lua_snip_utils.in_mathzone
local in_text = lua_snip_utils.in_text

local get_fraction = function(args, parent)
	local count = 1

	local cap = parent.snippet.captures[1]

	for i = #cap,1,-1 do
		local ch = cap:sub(i,i)

		if ch == ")" then count = count + 1
		elseif ch == "(" then count = count - 1 
		end

		if count == 0 then 
			local prev_text = cap:sub(1,i-1)
			local inside_text = cap:sub(i+1,#cap)
			return sn(nil, {t(prev_text), t(" \\frac{"..inside_text.."}")})
		end
	end
	return sn(nil, t("ERROR OCCURRED IN SNIPPET"))
end

-- Return snippet tables
return
{
		-- Superscript math
	s({
		trig="([%w%)%}%]%>])%^",
		snippetType="autosnippet",
		dscr="Superscript math",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>^{<>}
		]],
		{f( function(_, snip) return snip.captures[1] end ), d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- Subscript math
	s({
		trig="([%w%)%}%]%>])_",
		snippetType="autosnippet",
		dscr="Subscript math",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>_{<>}
		]],
		{f( function(_, snip) return snip.captures[1] end ), d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- Fraction
	s({
		trig="//",
		snippetType="autosnippet",
		dscr="Insert fraction",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\frac{<>}{<>} 
		]],
		{d(1, get_visual), i(2, "")}
		),
		{condition=in_mathzone}
	),
	-- Square root
	s({
		trig="sq",
		snippetType="autosnippet",
		dscr="Square root",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\sqrt{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- Partial derivative
	s({
		trig="%spart",
		snippetType="autosnippet",
		dscr="Fraction with partial derivatives",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\frac{\partial <>}{\partial <>}
		]],
		{d(1, get_visual), i(2, 't')}
		),
		{condition=in_mathzone}
	),
	-- Integral
	s({
		trig="dint",
		snippetType="autosnippet",
		dscr="Integral",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\int_{<>}^{<>} 
		]],
		{i(1, "-\\infty"), i(2, "+\\infty")}
		),
		{condition=in_mathzone}
	),
	-- Auto subscript
	s({
		trig="([a-zA-z])(%d)",
		snippetType="autosnippet",
		dscr="Auto subscript with single digit index",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>_{<>}
		]],
		{f( function(_, snip) return snip.captures[1] end ), 
		f( function(_, snip) return snip.captures[2] end )}
		),
		{condition=in_mathzone}
	),
	-- Special Fraction code
	s({
		trig="(.*)%)%/",
		snippetType="autosnippet",
		dscr="Auto fraction when parenthesis closes",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>{<>} 
		]],
		{d(1, get_fraction), i(2, "")}
		),
		{condition=in_mathzone}
	),
	-- Fraction after text until next space	
	s({
		trig="%s([^%s]+)/",
		snippetType="autosnippet",
		dscr="Auto fraction with one element",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta(" "..[[
		<>\frac{<>}{<>}
		]],
		{t(" "), f(function(_, snip) return snip.captures[1] end), i(1, "")}
		),
		{condition=in_mathzone}
	),
	-- Star in superscript
	s({
		trig="([%a%)%]%}%>])%*%*",
		snippetType="autosnippet",
		dscr="Star in superscript",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>^{*}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	s({
		trig="sum",
		snippetType="snippet",
		dscr="Sum operator with sub and superscript",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\sum_{<>}^{<>} 
		]],
		{i(1, "i = 0"), i(2, "N")}
		),
		{condition=in_mathzone}
	),
	s({
		trig="([^%a%\\])bnn",
		snippetType="autosnippet",
		dscr="Binomial",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>\binom{<>}{<>} 
		]],
		{f(function(_, snip) return snip.captures[1] end), i(1), i(2)}
		),
		{condition=in_mathzone}
	),
	-- Limit operator
	s({
		trig="lim",
		snippetType="snippet",
		dscr="Limit",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\lim_{<> \to <>}
		]],
		{i(1, "n"), i(2, "+ \\infty")}
		),
		{condition=in_mathzone}
	),
	-- Product operator
	s({
		trig="prod",
		snippetType="snippet",
		dscr="Product",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\prod_{<>}^{<>} 
		]],
		{i(1, "n = 1"), i(2, "+\\infty")}
		),
		{condition=in_mathzone}
	),
	-- Partial derivative
	s({
		trig="part",
		snippetType="snippet",
		dscr="Partial derivative",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\frac{\partial <>}{\partial <>} 
		]],
		{i(1), i(2)}
		),
		{condition=in_mathzone}
	),	
	-- Tilde
	s({
		trig="([a-zA-Z])%~",
		snippetType="autosnippet",
		dscr="Tilde letter",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\tilde{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	-- Vector
	s({
		trig="([a-zA-Z])vec",
		snippetType="autosnippet",
		dscr="Vector letter",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\vec{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	-- Vector
	s({
		trig="vec",
		snippetType="autosnippet",
		dscr="Overline command",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\vec{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- Overline
	s({
		trig="([a-zA-Z])bar",
		snippetType="autosnippet",
		dscr="Overline letter",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\overline{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	-- Overline
	s({
		trig="bar",
		snippetType="autosnippet",
		dscr="Overline command",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\overline{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- Hat
	s({
		trig="([a-zA-Z])hat",
		snippetType="autosnippet",
		dscr="Hat over letter",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\hat{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	-- Hat
	s({
		trig="hat",
		snippetType="autosnippet",
		dscr="Hat command",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\hat{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- Dot with letter behind
	s({
		trig="([a-zA-Z])dot",
		snippetType="autosnippet",
		dscr="Dot with letter behind",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\dot{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end)}
		),
		{condition=in_mathzone}
	),	
	-- DDot with letter behind
	s({
		trig="([a-zA-Z])ddot",
		snippetType="autosnippet",
		dscr="DDot with letter behind",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		\ddot{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end)}
		),
		{condition=in_mathzone}
	),
	s({
		trig="",
		snippetType="autosnippet",
		dscr="Bold Mode",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\bm{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=in_mathzone}
	),
	-- TODO
	-- Maybe spaces around operators
	-- Sympy
	-- matrix (pmat, bmat, )
	-- cases


	-- Static snippets
	s({
		trig="=>",
		snippetType="autosnippet",
		dscr="Implies",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\implies 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="=<",
		snippetType="autosnippet",
		dscr="Implied by",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\impliedby 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="([^%a\\])iff",
		snippetType="autosnippet",
		dscr="If and only if",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>\iff 
		]],
		{f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	s({
		trig="([^%a\\])in",
		snippetType="autosnippet",
		dscr="Element of",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>\in 
		]],
		{f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	s({
		trig="([^%a\\])nin",
		snippetType="autosnippet",
		dscr="Not element of",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>\notin 
		]],
		{f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	s({
		trig="([^%a\\])neq",
		snippetType="autosnippet",
		dscr="Not equal",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>\neq 
		]],
		{ f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	s({
		trig="~=",
		snippetType="autosnippet",
		dscr="Approximately",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\approx 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="~~",
		snippetType="autosnippet",
		dscr="Similar to",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\sim 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig=">=",
		snippetType="autosnippet",
		dscr="Greater or equal to",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\geq 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="<=",
		snippetType="autosnippet",
		dscr="Less or equal to",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\leq 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig=">>",
		snippetType="autosnippet",
		dscr="Much bigger than",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\gg 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="<<",
		snippetType="autosnippet",
		dscr="Much lesser than",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\ll 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="xx",
		snippetType="autosnippet",
		dscr="Operator times",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\times 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="**",
		snippetType="autosnippet",
		dscr="Operator cdot",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\cdot 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="([^%a\\])to",
		snippetType="autosnippet",
		dscr="Arrow to",
		wordTrig=false,
		regTrig=true,
		trigEngine = "pattern",
	},
		fmta([[
		<>\to 
		]],
		{ f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=in_mathzone}
	),
	s({
		trig="\\\\\\",
		snippetType="autosnippet",
		dscr="Setminus",
		wordTrig=true,
		regTrig=false,
		trigEngine = "pattern",
	},
		fmta([[
		\setminus 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="EE",
		snippetType="autosnippet",
		dscr="There exists",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\exists 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="AA",
		snippetType="autosnippet",
		dscr="For all",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\forall 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="+-",
		snippetType="autosnippet",
		dscr="Plus or minus",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\pm 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="-+",
		snippetType="autosnippet",
		dscr="Minus or plus",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\mp 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	-- Equiv (left-right-arrow)
	s({
		trig="equiv",
		snippetType="autosnippet",
		dscr="Equivalent to (left and right arrow version)",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\leftrightarrow 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="uu",
		snippetType="autosnippet",
		dscr="Union of two sets",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\cup 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="nn",
		snippetType="autosnippet",
		dscr="Intersection of two sets",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\cap 
		]],
		{ }
		),
		{condition=in_mathzone}
	),
	s({
		trig="UU",
		snippetType="autosnippet",
		dscr="Big union of sets",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\bigcup_{<>}  
		]],
		{i(1, "a \\in A")}
		),
		{condition=in_mathzone}
	),
	s({
		trig="NN",
		snippetType="autosnippet",
		dscr="Big intersection of sets",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\bigcap_{<>}  
		]],
		{i(1, "a \\in A")}
		),
		{condition=in_mathzone}
	),
	s({
		trig="oo",
		snippetType="autosnippet",
		dscr="Infinity",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\infty
		]],
		{}
		),
		{condition=in_mathzone}
	),
	s({
		trig=":=",
		snippetType="autosnippet",
		dscr="Defined as",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\coloneq 
		]],
		{}
		),
		{condition=in_mathzone}
	),
	s({
		trig="=:",
		snippetType="autosnippet",
		dscr="Defined as",
		wordTrig=true,
		regTrig=false,
		trigEngine = "plain",
	},
		fmta([[
		\coloneq 
		]],
		{}
		),
		{condition=in_mathzone}
	),
}
 
