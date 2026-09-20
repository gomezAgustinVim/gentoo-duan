---@diagnostic disable: undefined-global

return {
	s(
		{ trig = "fig", snippetType = "autosnippet", dscr = "Puts figures" },
		fmta(
			[[
        \begin{figure}[H]
        \centering
        \includegraphics[width=0.95\linewidth]{<>}
        \caption{
            \textbf{<>}
            <>
        }
        \label{fig:<>}
        \end{figure}
        ]],
			{ i(1, "filename"), i(2, "captionBold"), i(3, "captionText"), i(4, "figureLabel") }
		)
	),
	s(
		{ trig = "beg", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}
            <>
        \end{<>}
        ]],
			{ i(1, "document"), i(2), rep(1) }
		)
	),
	s(
		{ trig = "item" },
		fmta(
			[[
        \begin{<>}
            \item <>
        \end{<>}
        ]],
			{ i(1, "itemize"), i(2), rep(1) }
		)
	),

	s(
		{ trig = "bold", snippetType = "autosnippet" },
		fmta(
			[[
        \textbf{<>}
        ]],
			{ i(1) }
		)
	),

	-- math modes
	s(
		{ trig = "ml", snippetType = "autosnippet" },
		fmta(
			[[
            $<>$
        ]],
			{ i(1) }
		)
	),
	s(
		{ trig = "mb", snippetType = "autosnippet" },
		fmta(
			[[
            \[
                <>
            \]
        ]],
			{ i(1) }
		)
	),
	s(
		{ trig = "frac", snippetType = "autosnippet" },
		fmta(
			[[
        \frac{<>}{<>}
        ]],
			{ i(1), i(2) }
		)
	),

	-- sub super scripts
	s(
		{ trig = "(%a)(%d)", regTrig = true, name = "auto subscript" },
		f(function(_, snip)
			return snip.captures[1] .. "_" .. snip.captures[2]
		end, { condition = math })
	),
	s(
		{ trig = "(%a)(%d%d)", regTrig = true, name = "auto subscript 2", dscr = "auto subscript for 2+ digits" },
		fmt([[<>_{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}, { delimiters = "<>", condition = math })
	),
}
