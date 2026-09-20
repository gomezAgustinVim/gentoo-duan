---@diagnostic disable: undefined-global

-- setting the initial snippets for typst.
-- this is just because i want to have something going for typst so that i can avoid using friendly snippets
-- copied this from sylvan franklin

return {
	-- math modes
	s({ trig = "mt", snippetType = "autosnippet" }, fmta("$<>$ ", { i(1) })),

	s(
		{ trig = "(%d+)", regTrig = true },
		fmta(
			[[
#for i in range(<>) {
	<>
}]],
			{
				f(function(_, s)
					return s.captures[1]
				end),
				i(1),
			}
		)
	),

	s(
		{ trig = "([^%s]+)t", regTrig = true }, -- capture any text and make a superscript or subscript when expanded with ctrl e
		fmta("<>^(<>) ", {
			f(function(_, s)
				return s.captures[1]
			end),
			i(1),
		})
	),

	s(
		{ trig = "([^%s]+)s", regTrig = true }, -- capture any text and make a superscript or subscript when expanded with ctrl e
		fmta("<>_(<>) ", {
			f(function(_, s)
				return s.captures[1]
			end),
			i(1),
		})
	),

	s({ trig = "mmt", snippetType = "autosnippet" }, fmta("$ <> $ ", { i(1) })),

	s({ trig = "cen" }, fmta("#align(center)[<>]", { i(1) })),

	s(
		{ trig = "mla" },
		fmta(
			[[
#set page(header: context align(right)[<> #counter(page).get().first()])

Agustín Gómez

#datetime.today().display("[day] [month repr:long] [year]")
<>

<>
		]],
			{ i(1), i(2), i(3) }
		)
	),

	s(
		{ trig = "fig" },
		fmta(
			[[
#figure(
  image("<>", width: <>%),
  caption: [
  <>
  ],
)
    ]],
			{ i(1), i(2), i(3) }
		)
	),

	s({ trig = "sph" }, fmta("$(rho, theta, phi)$", {})),
}
