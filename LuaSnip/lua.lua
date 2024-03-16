return {
	s({trig="snip", snippetType="snippet"},
		fmta(
		[=[
		s({
			trig="<>",
			snippetType=<>,
			desc="<>",
			wordTrig=<>,
			regTrig=<>,
			trigEngine=<>,
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
			c(6, {t("plain"), t("pattern")}),
			i(7, "expression"),
			i(8, "nodes"),
			i(9, "options")
		}), 
		{}
	),

}

