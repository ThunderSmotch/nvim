return {
	s({trig="snip", snippetType="snippet"},
		fmta(
		[=[
		s({
			trig="<>",
			snippetType=<>,
			dscr="<>",
			wordTrig=<>,
			regTrig=<>,
		},
			fmta([[
			<>
			]],
			{<>}
			),
			{<>}
		),

		]=],
		{
			i(1, "trigger"),
			c(2, {t('"snippet"'), t('"autosnippet"')}),
			i(3, "description"),
			c(4, {t("true"), t("false")}),
			c(5, {t("false"), t("true")}),
			i(6, "expression"),
			i(7, "nodes"),
			i(8, "options")
		}), 
		{}
	),

}

