local get_visual = lua_snip_utils.get_visual
local in_mathzone = lua_snip_utils.in_mathzone
local in_text = lua_snip_utils.in_text

-- Return snippet tables
return
{
  -- LEFT/RIGHT PARENTHESES
  s({trig = "([^%a])lr%(", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\left( <> \\right)",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
  	{condition=in_mathzone}
  ),
    -- LEFT/RIGHT SQUARE BRACES
  s({trig = "([^%a])lr%[", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\left[ <> \\right]",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
  	{condition=in_mathzone}
  ),
  -- LEFT/RIGHT CURLY BRACES
  s({trig = "([^%a])lr%{", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\left\\{ <> \\right\\}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
  	{condition=in_mathzone}
  ),
  -- LEFT/RIGHT ANGLE BRACKETS
  s({
  	trig="([^%a])lr%<",
  	snippetType="autosnippet",
  	dscr="Left and right angle brackets",
  	wordTrig=false,
  	regTrig=true,
  },
  	fmta([[
  	<>\left\langle <> \right\rangle
  	]],
  	{f(function(_, snip) return snip.captures[1] end), d(1, get_visual)}
  	),
  	{condition=in_mathzone}
  ),
    -- LEFT/RIGHT PIPE BRACKETS
  s({
  	trig="([^%a])lr%|",
  	snippetType="autosnippet",
  	dscr="Left and right pipe brackets",
  	wordTrig=false,
  	regTrig=true,
  },
  	fmta([[
  	<>\left| <> \right|
  	]],
  	{f(function(_, snip) return snip.captures[1] end), d(1, get_visual)}
  	),
  	{condition=in_mathzone}
  ),
  -- LEFT/RIGHT NORM BRACKETS
  s({
  	trig="([^%a])lrnorm",
  	snippetType="autosnippet",
  	dscr="Left and right norm brackets",
  	wordTrig=false,
  	regTrig=true,
  },
  	fmta([[
  	<>\left\| <> \right\|
  	]],
  	{f(function(_, snip) return snip.captures[1] end), d(1, get_visual)}
  	),
  	{condition=in_mathzone}
  ),
  -- Ceiling
  s({
  	trig="ceil",
  	snippetType="autosnippet",
  	dscr="Ceiling",
  	wordTrig=true,
  	regTrig=false,
  },
  	fmta([[
  	\left\lceil <> \right\rceil 
  	]],
  	{d(1, get_visual)}
  	),
  	{condition=in_mathzone}
  ),
  -- Floor
  s({
  	trig="floor",
  	snippetType="autosnippet",
  	dscr="Floor parenthesis",
  	wordTrig=true,
  	regTrig=false,
  },
  	fmta([[
  	\left\lfloor <> \right\rfloor 
  	]],
  	{d(1, get_visual)}
  	),
  	{condition=in_mathzone}
  ),
  
}
