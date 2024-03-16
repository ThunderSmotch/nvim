local get_visual = lua_snip_utils.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local in_mathzone = lua_snip_utils.in_mathzone
local in_text = lua_snip_utils.in_text
local insert_space = lua_snip_utils.create_autocmd_for_char_insert_space

local test = function()
	Print("TESTING")
	return true
end

-- Return snippets table
return {
	-- Generic Environment
	s({
		trig="beg",
		snippetType="autosnippet",
		dscr="Generic environment",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\begin{<>}
			<>	
		\end{<>}

		]],
		{i(1), d(2, get_visual), rep(1)}
		),
		{condition = line_begin}
	),
	-- Inline math
	s({
		trig="fm",
		snippetType="autosnippet",
		dscr="Inline math",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\( <> \)
		]],
		{d(1, get_visual)}
		),
		{
			condition = in_text,
			callbacks = {[-1] = {[events.leave] = insert_space}}
		}
	),
	-- Display math
	s({
		trig="dm",
		snippetType="autosnippet",
		dscr="Display math",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[ 
		
		\[ <> \]

		]],
		{d(1, get_visual)}
		),
		{condition = in_text}
	),
	-- Figure environment	
	s({
		trig="fig",
		snippetType="autosnippet",
		dscr="Figure environment",
		wordTrig=true,
		regTrig=false,
	},
		fmta([[
		\begin{figure}[H]
			\centering
			\includegraphics[width=0.8\textwidth]{<>}
			\caption{<>}
			\label{fig:<>}
		\end{figure}

		]],
		{
			i(1, "file"),
			i(2, "caption"),
			i(3, "label")
		}
		),
		{condition=line_begin}
	),
}
