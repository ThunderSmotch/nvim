local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

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

-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
{

	-- Superscript math
	s({
		trig="([%w%)%}])%^",
		snippetType="autosnippet",
		dscr="Superscript math",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>^{<>}
		]],
		{f( function(_, snip) return snip.captures[1] end ), d(1, get_visual)}
		),
		{condition=tex.in_mathzone}
	),
	-- Subscript math
	s({
		trig="([%w%)%}])_",
		snippetType="autosnippet",
		dscr="Subscript math",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>_{<>}
		]],
		{f( function(_, snip) return snip.captures[1] end ), d(1, get_visual)}
		),
		{condition=tex.in_mathzone}
	),
	-- Fraction
	s({
		trig="//",
		snippetType="autosnippet",
		dscr="Insert fraction",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\frac{<>}{<>} 
		]],
		{d(1, get_visual), i(2, "")}
		),
		{condition=tex.in_mathzone}
	),
	-- Square root
	s({
		trig="sq",
		snippetType="autosnippet",
		dscr="Square root",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\sqrt{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=tex.in_mathzone}
	),
	-- Partial derivative
	s({
		trig="part",
		snippetType="autosnippet",
		dscr="Fraction with partial derivatives",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\frac{\partial <>}{\partial <>}
		]],
		{d(1, get_visual), i(2, 't')}
		),
		{condition=tex.in_mathzone}
	),
	-- Integral
	s({
		trig="dint",
		snippetType="autosnippet",
		dscr="Integral",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\int_{<>}^{<>} 
		]],
		{i(1, "-\\infty"), i(2, "+\\infty")}
		),
		{condition=tex.in_mathzone}
	),
	-- Auto subscript
	s({
		trig="([a-zA-z])(%d)",
		snippetType="autosnippet",
		dscr="Auto subscript with single digit index",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>_{<>}
		]],
		{f( function(_, snip) return snip.captures[1] end ), 
		f( function(_, snip) return snip.captures[2] end )}
		),
		{condition=tex_in_mathzone}
	),
	-- Special Fraction code
	s({
		trig="(.*)%)%/",
		snippetType="autosnippet",
		dscr="Auto fraction when parenthesis closes",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>{<>} 
		]],
		{d(1, get_fraction), i(2, "")}
		),
		{condition=tex.in_mathzone}
	),
	-- Fraction after text until next space	
	s({
		trig="%s([^%s]+)/",
		snippetType="autosnippet",
		dscr="Auto fraction with one element",
		wordTrig=false,
		regTrig=true,
	},
		fmta(" "..[[
		<>\frac{<>}{<>}
		]],
		{t(" "), f(function(_, snip) return snip.captures[1] end), i(1, "")}
		),
		{condition=tex.in_mathzone}
	),
	-- Star in superscript
	s({
		trig="([%a%)%]%}])%*%*",
		snippetType="autosnippet",
		dscr="Star in superscript",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>^{*}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="sum",
		snippetType="snippet",
		dscr="Sum operator with sub and superscript",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\sum_{<>}^{<>} 
		]],
		{i(1, "i = 0"), i(2, "N")}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="([^%a%\\])bnn",
		snippetType="autosnippet",
		dscr="Binomial",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\binom{<>}{<>} 
		]],
		{f(function(_, snip) return snip.captures[1] end), i(1), i(2)}
		),
		{condition=tex.in_mathzone}
	),
	-- Limit operator
	s({
		trig="lim",
		snippetType="snippet",
		dscr="Limit",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\lim_{<> \to <>}
		]],
		{i(1, "n"), i(2, "+ \\infty")}
		),
		{condition=tex.in_mathzone}
	),
	-- Product operator
	s({
		trig="prod",
		snippetType="snippet",
		dscr="Product",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\prod_{<>}^{<>} 
		]],
		{i(1, "n = 1"), i(2, "+\\infty")}
		),
		{condition=tex.in_mathzone}
	),
	-- Partial derivative
	s({
		trig="part",
		snippetType="snippet",
		dscr="Partial derivative",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\frac{\partial <>}{\partial <>} 
		]],
		{i(1), i(2)}
		),
		{condition=tex.in_mathzone}
	),
	-- Overline
	s({
		trig="([a-zA-Z])bar",
		snippetType="autosnippet",
		dscr="Overline letter",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		\overline{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	-- Overline
	s({
		trig="bar",
		snippetType="autosnippet",
		dscr="Overline command",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\overline{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=tex.in_mathzone}
	),
	-- Hat
	s({
		trig="([a-zA-Z])hat",
		snippetType="autosnippet",
		dscr="Hat over letter",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		\hat{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	-- Hat
	s({
		trig="hat",
		snippetType="autosnippet",
		dscr="Hat command",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\hat{<>}
		]],
		{d(1, get_visual)}
		),
		{condition=tex.in_mathzone}
	),
	-- Dot with letter behind
	s({
		trig="([a-zA-Z])dot",
		snippetType="autosnippet",
		dscr="Dot with letter behind",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		\dot{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end)}
		),
		{condition=tex.in_mathzone}
	),	
	-- DDot with letter behind
	s({
		trig="([a-zA-Z])ddot",
		snippetType="autosnippet",
		dscr="DDot with letter behind",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		\ddot{<>}
		]],
		{f(function(_, snip) return snip.captures[1] end)}
		),
		{condition=tex.in_mathzone}
	),
	-- TODO
	-- Maybe spaces around operators
	-- Sympy
	-- Tilde:
	-- Vec
	-- matrix (pmat, bmat, )
	-- cases


	-- Static snippets
	s({
		trig="=>",
		snippetType="autosnippet",
		dscr="Implies",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\implies 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="=<",
		snippetType="autosnippet",
		dscr="Implied by",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\impliedby
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="([^%a\\])iff",
		snippetType="autosnippet",
		dscr="If and only if",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\iff 
		]],
		{f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="([^%a\\])in",
		snippetType="autosnippet",
		dscr="Element of",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\in 
		]],
		{f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="([^%a\\])notin",
		snippetType="autosnippet",
		dscr="Not element of",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\notin 
		]],
		{f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="([^%a\\])neq",
		snippetType="autosnippet",
		dscr="Not equal",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\neq 
		]],
		{ f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="~=",
		snippetType="autosnippet",
		dscr="Approximately",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\approx 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="~~",
		snippetType="autosnippet",
		dscr="Similar to",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\sim 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig=">=",
		snippetType="autosnippet",
		dscr="Greater or equal to",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\geq 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="<=",
		snippetType="autosnippet",
		dscr="Less or equal to",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\leq 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig=">>",
		snippetType="autosnippet",
		dscr="Much bigger than",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\gg 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="<<",
		snippetType="autosnippet",
		dscr="Much lesser than",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\ll 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="xx",
		snippetType="autosnippet",
		dscr="Operator times",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\times 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="**",
		snippetType="autosnippet",
		dscr="Operator cdot",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\cdot 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="([^%a\\])to",
		snippetType="autosnippet",
		dscr="Arrow to",
		wordTrig=false,
		regTrig=true,
	},
		fmta([[
		<>\to 
		]],
		{ f( function(_, snip) return snip.captures[1] end )}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="\\\\\\",
		snippetType="autosnippet",
		dscr="Setminus",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\setminus 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="EE",
		snippetType="autosnippet",
		dscr="There exists",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\exists 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="AA",
		snippetType="autosnippet",
		dscr="For all",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\forall 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="+-",
		snippetType="autosnippet",
		dscr="Plus or minus",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\pm 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="-+",
		snippetType="autosnippet",
		dscr="Minus or plus",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\mp 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	-- Equiv (left-right-arrow)
	s({
		trig="equiv",
		snippetType="autosnippet",
		dscr="Equivalent to (left and right arrow version)",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\leftrightarrow 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="uu",
		snippetType="autosnippet",
		dscr="Union of two sets",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\cup 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="nn",
		snippetType="autosnippet",
		dscr="Intersection of two sets",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\cap 
		]],
		{ }
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="UU",
		snippetType="autosnippet",
		dscr="Big union of sets",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\bigcup_{<>}  
		]],
		{i(1, "a \\in A")}
		),
		{condition=tex.in_mathzone}
	),
	s({
		trig="NN",
		snippetType="autosnippet",
		dscr="Big intersection of sets",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\bigcap_{<>}  
		]],
		{i(1, "a \\in A")}
		),
		{condition=tex.in_mathzone}
	),
}
--]==]
