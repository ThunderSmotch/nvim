local greek_letters = {
	{"a", "alpha"},
	{"b", "beta"},
	{"g", "gamma"}, {"G", "Gamma"},
	{"d", "delta"}, {"D", "Delta"},
	{"e", "epsilon"}, {"ve", "varepsilon"},
	{"z", "zeta"},
	{"h", "eta"},
	{"o", "theta"}, {"O", "Theta"}, {"vo", "vartheta"},
	{"i", "iota"},
	{"k", "kappa"}, {"vk", "varkappa"},
	{"l", "lambda"}, {"L", "Lambda"},
	{"m", "mu"}, {"n", "nu"},
	{"x", "xi"}, {"X", "Xi"},
	{"p", "pi"}, {"P", "Pi"}, {"vp", "varpi"},
	{"r", "rho"}, {"vr", "varrho"},
	{"s", "sigma"}, {"S", "Sigma"}, {"vs", "varsigma"},
	{"t", "tau"}, 
	{"u", "upsilon"}, {"U", "Upsilon"},
	{"f", "phi"}, {"F", "Phi"}, {"vf", "varphi"},
	{"c", "chi"}, 
	{"y", "psi"}, {"Y", "Psi"},
	{"w", "omega"}, {"W", "Omega"},
}

local snips = {}
for _, pair in ipairs(greek_letters) do
	table.insert(snips, 
		s({
			trig=";"..pair[1],
			snippetType="autosnippet",
			dscr=""..pair[1],
			},
			t("\\"..pair[2]),
			{condition=lua_snip_utils.in_mathzone}
		)
	)
end
return snips
