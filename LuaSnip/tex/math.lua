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
		trig="int",
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
	
	-- TODO
	-- Special fraction after parenthesis
	-- Sympy
	-- Operators sin/cos/tan/cot/csc/sec
	-- Operators min max log exp
	-- Vec
	-- Tilde
	-- Star
	-- Dot, Ddot
	-- overline
	-- hat
	-- matrix (pmat, bmat, )

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
		<>\noteq 
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
		trig="\\\\",
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
	
}
--]==]
