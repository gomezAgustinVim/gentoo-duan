---@diagnostic disable: undefined-global

return {
	s(
		{ trig = "ln", snippetType = "autosnippet", dscr = "Puts links" },
		fmta(
			[[
         [<>](<>) ]],
			{ i(1), i(2) }
		)
	),

	s(
		{ trig = "img", snippetType = "autosnippet", dscr = "Puts images" },
		fmta(
			[[
         ![<>](<>)
         ]],
			{ i(1), i(2) }
		)
	),

	s({ trig = "back", dscr = "Inserts backticks" }, fmta("```", {})),

	s(
		{ trig = "3x2", snippetType = "autosnippet", dscr = "Puts 3x2 table" },
		fmta(
			[[
            | <>        | <>        | <>         |
            | --------- | --------- | ---------  |
            | <>        | <>        | <>         |
         ]],
			{ i(1), i(2), i(3), i(4), i(5), i(6) }
		)
	),

	s(
		{ trig = "5x2", snippetType = "autosnippet", dscr = "Puts 5x2 table" },
		fmta(
			[[
            | <>        | <>        | <>         | <>         | <>         |
            | --------- | --------- | ---------  | ---------  | ---------  |
            | <>        | <>        | <>         | <>         | <>         |
         ]],
			{ i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10) }
		)
	),
}
