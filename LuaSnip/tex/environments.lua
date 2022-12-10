local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end
--- Below two functions are necessary functions to insert space if the next press is a char
local if_char_insert_space = function()
	print("RUN FUNC")
	if string.find(vim.v.char, "%a") then
		vim.v.char = " "..vim.v.char
		return true
	end
end

local create_autocmd_for_char_insert_space = function() vim.api.nvim_create_autocmd("InsertCharPre", {
			callback = if_char_insert_space
		})
		end

-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

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
			condition = tex.in_text,
			callbacks = {[-1] = {[events.leave] = 	create_autocmd_for_char_insert_space}}
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
		{condition = tex.in_text}
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
