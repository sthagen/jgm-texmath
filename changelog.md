texmath (0.12.10.3)

  * MathML writer: fix rendering of EScaled (#264, Ewan Davies).
    Use `%` values for `maxwidth` and `minwidth`, and set `stretchy` to
    `true`. Otherwise browsers do not rescale.

  * TeX reader: Support all r/l variants of `\big`, `\bigg`, `\Big` (#266).

  * Require typst-symbols >= 0.1.8.1.

texmath (0.12.10.2)

  * Use texmath-symbols 0.1.8 (supports typst 0.13 symbols).

texmath (0.12.10.1)

  * MathML writer: group function application with operator name (#262).
    This fixes an issue with munder/mover. Previously the mo
    with the U+2061 was being put under the 'lim' operator
    instead of 'n -> oo'. Grouping them ensures that munder/mover
    will work properly.

texmath (0.12.10)

  * texmath-server:

    + Change endpoints: `/convert` to root, and `/convert-batch` to `/batch`.
    + Allow running as CGI if renamed pandoc-server.cgi. In this mode it
      accepts JSON content with POST requests or parameters with GET requests,
      just like pandoc-server itself.

  * TeX reader:

    + Fix parsing bug with comment at beginning of braced (#258).
    + Support negative numbers in `\hspace` (#259).
    + Allow decimals in `\hspace` (#259).
    + Support `\quad` in `\text` (#260).

texmath (0.12.9)

  * Better handling of primes in eqn, typst, and tex writers.
    These writers now render a superscript containing prime
    characters using a sequence of `'` characters, e.g.
    `f''`. This syntax is supported by all three formats.

  * Use Planck constant for italic h in unicodeTable. There is no
    regular italic h in Unicode because this already existed in Planck
    constant.

  * Text.TeXMath.Shared: expose `isRLSequence` and `toPrimes` and
    new function `isUpppercaseGreek` [API change, non-breaking].

  * OMML reader: consolidate adjacent texts with same style.
    This affects EStyled and EText elements. This way we get
    `\mathbf{123abc456}` in LaTeX output instead of
    `\mathbf{123}\mathbf{abc}\mathbf{456}`. See
    https://github.com/jgm/pandoc/discussions/10560 for discussion.

  * OMML writer:

    + Use `m:eqArr` rather than `m:m` for arrays with alternating
      right, left alignments (#209). (In other writers, TeX and MathML,
      we presume that these are aligned equations.)
    + Fix order of `scr` and `sty` elements (#253).
    + Use upright style by default for uppercase Greek.

  * MathML reader: properly handle `mmultiscripts` (#252).

  * MathML writer:

    + Improve formatting of aligned equations (#207).
      An EArray with alternating R,L alignments will be assumed
      to be aligned equations and rendered without padding.
    + Use `mi` for EMathOperator. Also: insert the unicode 0x2061
      "function application" character after a math operator, unless
      it's already there. Ensure that all 0x2061 characters are in
      `mo` rather than `mi`.
    + Use upright style for uppercase Greek by default (#255).
    + Fix invalid `displaystyle` attribute. The attribute goes on
      enclosing mstyle, not directly on `mfrac`.

  * TeX reader:

    + Parse primes as superscripts (#254). This seems to be
      how TeX behaves under the hood: `f'` is equivalent to `f^{\prime}`.
    + Avoid implicit pairing of delimiters (reverts #172).
    + Use `EIdentifier` instead of `ESymbol Alpha` for `\ell`, etc (#256).
    + Use Pun for primes in TeX reader, revise type of `toPrimes`.
      This will ensure that `mo` is used for primes in MathML.

  * test-texmath: allow `mathml` in addition to `mml` to specify mathml.

  * Add `binpath` Makefile target.

texmath (0.12.8.13)

  * Remove special override for `\perp` in Text.TeXMath.Readers.TeX.Commands
    (#247). This caused `\perp` to be read as U+22A5 instead of U+27C2.  This
    addresses the mismatch with the TeX writer (which associates `\bot` with
    U+22A5 and `\perp` with U+27C2).

  * Typst writer:

    + Fix several issues with accents and attachments (#245).
    + Fix handling of some EOver with combining accents (#245).
    + Escape backslash in text context (#245).

texmath (0.12.8.12)

  * TeX writer: render prime and superscripted prime as `'` (#246).

  * TeX reader:

    + Don't crash on array with `\hline` before blank cell (#244).
    + Skip whitespace in array column specifier (#244).

  * OMML writer:

    + Fix order of dPr attributes (#243).

  * Typst writer:

    + Escape commas (#242). Otherwise we can get bad results e.g. in fractions,
      when the commas separate arguments.

  * Require typst-symbols 0.1.7, update tests.

texmath (0.12.8.11)

  * TeX reader: Ignore `@{..}` and `!{..}` in array alignment specifiers (#241).

  * TeX reader: ignore `\color` instead of crashing (#225).

texmath (0.12.8.10)

  * TeX reader: allow `\lVert .. \vVert` to create an EDelimited (#238).

  * Typst writer: improved handling of primes (#239).
    Use `'` instead of e.g. `prime`. Don't put a space before primes.

  * Typst writer: improve rendering of EDelimited (#238).

  * Typst writer: use `mid()` for middle delimiters (#238).

texmath (0.12.8.9)

  * Parse TeX `\mathbf` as both bold and upright (#236).

texmath (0.12.8.8)

  * TeX reader: support unicode-math Greek symbols, e.g. `\Alpha` (#235).
    This includes symbols like `\Alpha` and `\omicron` that weren't
    defined in original TeX.

  * Use typst-symbols 0.1.6

texmath (0.12.8.7)

  * TeX reader: convert Bin symbols to Ord when appropriate (#234).
    E.g. in '-3', we should have an Ord rather than a Bin, so
    the spacing will be appropriate.

  * Pandoc writer: fix spacing inside EDelimited (#234).
    Previously spaces around binary operators were omitted when
    they occurred inside parens or brackets.

  * test-texmath: allow pandoc output.

texmath (0.12.8.6)

  * Typst writer: avoid redundant `lr`s (#233).

texmath (0.12.8.5)

  * Typst writer: use ASCII symbols when possible instead of symbols (#232).
    E.g., `+` instead of `plus`. Add `\` to characters needing escape.
    Enhance list of characters that need escaping.

  * Typst writer: fixed EBoxed output so it includes a border.

  * Handle `\ddot` better in conversion to typst (#231).

  * Use typst-symbols 0.1.5

texmath (0.12.8.4)

  * TeX reader: ignore `\allowbreak` (#230).

  * TeX reader: handle `*{5}{lr}` in array column specifier (#229).

  * OMML reader: allow `m:e` to be missing in `m:nary` (#228).
    Technically this is not allowed, according to the spec, but
    Word and LibreOffice seem to tolerate it.

texmath (0.12.8.3)

  * OMML writer: use "on" and "off" instead of "1" and "0" for
    m:CT_OnOff type.  It is said that "1" and "0" work in Word
    but not Powerpoint.

texmath (0.12.8.2)

  * Typst writer: use binom instead of a fraction (jgm/pandoc#9063).

texmath (0.12.8.1)

  * Typst writer: several fixes (#223, Lleu Yang).

    + Escape quotes (") in inQuotes
    + Accent `\8407` corresponds to `arrow()`
    + Write `#none`'s for matrices with blanks at the beginning of a row

texmath (0.12.8)

  * Expose Text.TeXMath.Shared [API change]

  * Typst writer: Fix bug where 's' turned into 'space' (#219).

  * Typst writer: Fix handling of overline (#214).

  * Typst writer: Fix underbrace (#217).

  * Typst writer: Improve some accents (#216).

  * TeX writer: don't include \\ on last line of matrix.

  * TeX writer: Remove escaping of spaces inside \text{}.
    It isn't needed, and it causes problems in MathJax rendering.

  * TeX reader: allow empty matrices.

  * MathML writer: Fix rendering of vectors (#218).

  * Depend on external typst-symbols package.

texmath (0.12.7.1)

 * Typst writer:

   + Improve under/overbrace/bracket/line.
   + Fix bugs with super/subscript grouping (#212).
   + Fix case where super/subscript is on an empty element,
     by inserting a zws.

texmath (0.12.7)

  * Add typst writer. New module: Text.TeXMath.Writers.Typst.

  * TeX reader: Support multilined environment. Closes #210.

texmath (0.12.6)

  * MathML writer:

    + Use style with CSS as well as columnalign (#205).
      This seems to be needed by browser implementations of MathML.
    + Remove reliance on mstyle (#205). mstyle doesn't seem to be
      supported any more, at least in browser implementations of MathML,
      and the documentation indicates that it is treated like mrow now
      that styles can go directly on child elements. This commit removes
      our use of mstyle. Instead of using mstyle, we change mathvariant
      attributes on descendent elements (and displaystyle attributes on
      direct children, in the case of fractions).
    + Extend our existing use of unicode replacements, since many
      implementations don't properly handle mathvariant. We now get
      variant characters for mo, mn, and all elements that can sensibly
      take them, not just mi and mtext.
    + Omit mathvariant attribute unless we can't find appropriate Unicode.
      When MathML is displayed by ODT, having BOTH a bold math Unicode
      character and a mathvariant="bold" attribute seems to confuse it.
      (Browsers don't care either way.) This gives us more compact and
      readable output, as well.

texmath (0.12.5.5)

  * Allow pandoc-types 1.23.

  * TeX reader: remove false positives for isConvertible (#204).
    "Convertible" symbols are those in which subscripts render
    under the symbol in display environments, and as subscripts
    in inline environments. Previously the TeX parser recognized
    all relation and binary symbols as convertible, which does not
    match TeX's behavior.

  * TeX reader: Support `\enspace` (#203).

texmath (0.12.5.4)

  * OMML reader: fix treatment of `eqArr` (#196).
    This change also includes a change to the TeX writer: any array
    with an alternating sequence of R,L alignments will be rendered
    as an aligned environment (not just a single [R,L] as currently).

  * OOML Writer: Add low line char ("_") to `isBarChar` (#193, Hagb).
    Closes jgm/pandoc#8152.

  * Eqn writer: use `-` for minus, `cdots` for cdots (#200).

texmath (0.12.5.3)

  * Eqn writer: avoid empty `{}` (#198).
    This causes an error, along the lines of
    ```
    eqn:<standard input>:73: error: syntax error
     context is
            } above { >>> } <<<
    ```
    which can be avoided if we use `{""}`.

texmath (0.12.5.2)

  * Fix bug in implementation of `\mspace` (#195).

texmath (0.12.5.1)

  * Compile texmath-server with `-threaded`.
    This should fix the crashes we have experienced.

  * Add apache style logging to web server.

  * Add more strictness in Unicode.ToTeX.

texmath (0.12.5)

  * TeX reader: Improve treatment of `\operatorname` (#147).
    We can now handle spaces, as in `\operatorname{arg\,max}`.
    We also now have a better fallback when the operator name
    contains content that can't be turned into plain text.
    (In this case, we just pass through the contents, since EMathOperator
    takes a text argument.)

  * TeX: Support more `\var...` commands for greek letters (Albert
    Krewinkel). AMSmath defines `\varGamma`, `\varDelta`, `\varTheta`,
    `\varLambda`, `\varXi`, `\varPi`, `\varSigma`, `\varUpsilon`, `\varPhi`,
    `\varPsi`, and `\varOmega`, all of which are now parsed as unicode
    characters *MATHEMATICAL ITALIC CAPITAL ...*.  Also, `\varsigma` is
    now parsed as *MATHEMATICAL SMALL FINAL SIGMA*.

  * OMML writer: better handling for scaled delimeter symbols (#140).
    We now try to represent these using m:d when possible.
    This allows the parentheses to expand with the content;
    previously we'd often get small parentheses with large
    contents.

  * OMML reader:

    + Allow m:pos to be missing or lack an attribute in m:bar (#187).
    + Set the default value of pos to "bot" (Maximilian Meier).
    + Implement support for noBar fractions (#191, Meimax).

  * Add servant-based server with a JSON API.

  * Remove old cgi directory.

  * Improve test suite (#189).  The existing test suite was a complicated
    mess, so that it was hard to add new tests.  (One of the problems
    was that the same files were used as golden files for reader
    tests and as sources for writer tests.) This commit shifts
    the same tests to a new, easier to understand format, so that
    it will be simple to add new tests in the future.  We now use
    the tasty test framework, and we use pretty-show to make the
    native golden tests easier to comprehend.

  * Add regression tests.

texmath (0.12.4)

  * TeX reader: handle hyperref better (#186).  We don't parse it as a link,
    but we pass its contents through rather than failing.

  * Update scripts and data in `lib/` directory. These are not build
    dependencies, but they were used to produce some of the large
    tables in the source code.  Fixed the scripts and Makefile to work
    with recent texmath and cabal.  Removed two very large unicode data
    files that can be downloaded when needed.  (This reduces the size of
    the source tarball considerably.) Remove `lib/toascii` (no longer used).

  * Update MMLDict using latest unicode.xml.

  * TeX reader: support siunitx `\qty`, `\qtyrange`, `\unit` (#185).

  * Remove Text.TeXMath.Compat.  We can now safely require mtl >= 2.2.1.

  * Use symbolMap from ToTeX to shorten the long hardcoded symbols list.
    Now we only hard-code items that differ what what is in symbolMap.
    This reduces the code size by thousands of lines.

  * Unicode.ToTeX: export `symbolMap` [API change].  This uses the data in
  `records` to create a backwards mapping from TeX commands to Exps (ESymbol
      elements).  This can replace most of the hardcoded list in the current
  TeX reader.

  * Split out TeXMath.Readers.TeX.Commands internal module.
    This makes the TeX reader shorter and should help compile times.

  * OMML reader: better handling of m:t nodes (#151).
    Previously we parsed an m:t element as an EIdentifier if it contains a
    single letter, but an EText TextNormal if it contains more than one.  This
    gave bad results in some cases.  It is better to reserve EText for the
    case where the m:nor property is specified for "normal text."

  * Require base >= 4.11.

  * Remove `network-uri` flag from stack.yaml.


texmath (0.12.3.3)

  * OMML writer: use nary only for operators supported by LibreOffice
    (Albert Krewinkel).  LibreOffice (and possibly Word, too) can handle
    only a small set of operators in an `nary` element.

  * TeX writer: use `\xleftarrow`, `\xrightarrow` where sensible
    (Albert Krewinkel).  The commands are generated for expressions over `←`
    or `→`. Besides being more idiomatic, this change also prevents the
    generation of invalid LaTeX, as `\leftarrow` and `\rightarrow` are not
    math operators and hence may not be followed by `\limit`.
    Both commands are part of amsmath.sty.

  * TeX reader:

    + Improve angled-bracket support (Albert Krewinkel).
      The amsmath package allows `\left<` and `\right>` as alternatives to
      `\left\langle` and `\right\rangle`, respectively.
    + Ignore stared version of `\tag` (Albert Krewinkel).
    + Support \dots{c,b,m,i,o} from amsmath (#179).
    + Change symbol returned for \dots{b,i,m} from `…` to `⋯`
      (Albert Krewinkel).

texmath (0.12.3.2)

  * OMML writer: remove m:nor element in math operators (#178).
    This caused the document's main font, rather than the math
    font, to be used in formatting operators, which is undesirable.

texmath (0.12.3.1)

  * MathML reader: don't allow mfenced attributes to inherit (#177).
    When open and close attributes aren't given on an mfenced,
    we should use defaults rather than inheriting these from a
    parent mfenced.

texmath (0.12.3)

  * TeX reader: implement logic to convert a Bin symbol to
    an Op to Op when it occurs at the beginning of a group,
    or after an Open, Pun, or Op symbol. This will give much
    better results for unary `-` (#176).

  * OMML writer: fixed rendering of EDelimited (#173).
    We now properly render "middles" (separators).

texmath (0.12.2)

  * MathML input: support mmultiscripts element (#158, #100).

  * Make MathML tag/attr recognition case-insensitive (#158).

  * Pandoc writer: better handling of styling such as `\mathrm` (#145).
    Previously identifiers were always italic, no matter what
    styling was applied.

  * Ignore `\tag` in TeX input (#162).

  * TeX writer: avoid unneeded `\left` and `\right` for delimited.
    We don't need `\left` and `\right` when the contents are
    "standard height."

  * TeX reader: parse implicit EDelimited sections (#172).
    We now parse `(x)` as EDelimited, even though `\right` and `\left`
    are not used.

texmath (0.12.1.1)

  * Fix compilation with GHC-9.0.1 (#169, Simon Jakobi).
    Background:
    https://gitlab.haskell.org/ghc/ghc/-/wikis/migration/9.0#simplified-subsumption
  * Add eqn to online demo.
  * Improve error messages for unknown control sequences, and restructure
    tex parser to be more efficient (#167).

texmath (0.12.1)

  * OMML writer: explicitly mark symbols as non-italic (#109).
    Otherwise, for some reason, they appear as italic by default.
  * Improve error messages in reading tex arrays.
  * Improve support for `\bmod`, `\mod`, etc. (#165).
    Allow them to take complex arguments like `\left( 1 \right)`.
  * Improve support for `\genfrac` (#164).
  * Ignore `\textstyle`, `\scriptstyle`, `\scriptscriptstyle`,
    as we currently ignore `\displaystyle`.
  * Parse siunitx commands in reading tex (#157).
  * Improve handling of `\not` in reading tex (#161).
    Previously we only handled `\not` in front of certain symbols.
  * Support `\pod` and `\pmod` and clean up spacing and font for
    `\mod` and `\bmod` (#160).

texmath (0.12.0.3)

  * Allow pandoc-types 1.22.

texmath (0.12.0.2)

  * Allow pandoc-types 1.21.
  * Pandoc output: omit empty Emph for sub/superscript without base (#155).
  * tex writer: Use `\overline{\overline{B}}` instead of unicode
    double line accent (#153).

texmath (0.12.0.1)

  * OMML writer: Fix overline and accent rendering (#152).
  * OMML reader: Fix dropped arrows (#153). Add tests.

texmath (0.12)

  * Use Text instead of String in data types and functions
    (Christian Despres) [API change].  Note that there are still a few
    places where we unpack Text to String with a view pattern:
    performance could likely be increased with further rewriting.
  * Avoid use of !! with negative index (jgm/pandoc#5853).

texmath (0.11.3)

  * Use error instead of fail to allow building with ghc 8.8.
  * Test output: remove superfluous spaces after control sequences,
    superfluous groups, and unicode VARIATION SELECTOR 1.
  * renderTeX: add space between control sequence and any non-ASCII
    character.  There are differences in behavior of isAlphaNum between
    different ghc versions that would affect test output otherwise.
  * charToLaTeXString: Ignore 65024 VARIATION SELECTOR 1 to avoid putting
    it literally in the output ; it is used in mathml output and occurs
    in many of the test cases.
  * Add cabal.project.
  * Use actions rather than travis for CI.

texmath (0.11.2.3)

  * OMML reader: properly distinguish normal text from math (#136).
    If `m:nor` or `m:lit` is set in `m:rPr`, we interpret the
    contents as literal text and not as math.
  * TeX reader: use different symbol (`_`) for `\underline` (#142).
    This gets the right accent properties on MathML output, so
    that the underline is not lower than it should be.
  * TeX reader: Treat `\bmod` as a relational symbol rather than
    an operator (#143).  This fixes spacing problems in several
    output formats.

texmath (0.11.2.2)

  * OMML writer: use m:nor for normal text (#135).

texmath (0.11.2.1)

  * OMML reader: Don't collapse `fName` to a string (#133).
    This fixes cases where fName has some complexity, e.g.
    a subscript or limit.

texmath (0.11.2)

  * Improved handling of \mathop etc (#126).  We now allow operators like
    `arg\,min`, converting the space into unicode.
  * Support \hspace (#126).
  * Support \hdots as synonym of \ldots (#126).
  * Support \mathds (#126).
  * In parsing array, ignore `|` in column specs (#127).
    We have no way to represent this in EArray, currently.
    Ignoring them seems better than failing altogether.

texmath (0.11.1.2)

  * Eqn writer: properly escape `{` and `}`.
  * Set more accurate bounds (Herbert Valerio Riedel).

texmath (0.11.1.1)

  * Fix building with ghc-8.6.1 by removing need for now missing
    MonadFail instances (Jonas Scholl).
  * TeX reader: Allow operators like `/` to be scaled (#120).
  * TeX reader: Improved efficiency of basicEnclosure.
  * TeX reader: Handle `\bmod` (#115).

texmath (0.11.1)

  * OMML writer: Use m:acc for accents in OMML (#119).  This fixes
    some spacing issues for e.g. the translation of `\dot{m}`.

texmath (0.11.0.1)

  * OMML writer: use zero-width space to avoid dashed box (#118).
    In Word, a dashed box shows up for empty text runs in
    exponents and bases, or empty exponents and bases.  So
    we use a zero-width space in these contexts.

texmath (0.11)

  * Changed treatment of non-ASCII characters.
    Previously we ensured that the output of conversion to tex
    was pure ASCII.  This meant rendering "ä" as "a", for
    example, and it meant that many characters (e.g. Chinese)
    simply got replaced with an empty string, while others
    got replaced with "[?]".

    This was not a particularly helpful behavior.  Including
    the unicode characters verbatim doesn't interfere with
    latex compilation.  They often won't show up in the generated
    math, but that is no worse than what happened before.

    This change passes through unicode characters unchanged
    when they can't be converted to standard LaTeX commands.

    An important reason for including the unicode characters
    is that pandoc uses TeX to represent math in its AST.
    So, for example, if you convert HTML with mathml to docx,
    you'll currently lose all Chinese characters, since they'll
    disappear in the TeX intermediary, even though a direct
    mathml to ooml conversion would have passed them through.
    With this change, these conversions will work better
    (see jgm/pandoc#4642).

    + Removed Text.TeXMath.Unicode.ToASCII (API change).
    + Removed cbits that were needed for that module.
    + Modified Tex.TeXMath.Unicode.ToTeX to pass through
      unicode characters that can't be converted, rather
      than trying to asciify them or remove them.

  * Render degree symbol in tex as `{^\circ}`.

texmath (0.10.1.2)

  * eqn writer:  use uppercase letters in unicode escapes (jgm/pandoc#4597).

texmath (0.10.1.1)

  * Handle multicharacter operators better in Eqn, TeX, OMML (#109).

  * OMML reader: unwrap `<w:...>` tags immediately under `<m:oMath>`
    (#111, Jesse Rosenthal).

texmath (0.10.1)

  * Expose Text.TeXMath.TeX (TeX rendering functions) (#108).
    This is needed in order to use getTeXMath from Text.TeXMath.Unicode.ToTeX.
  * Pandoc writer: don't insert punctuation space before explicit space
    (#107).  E.g. in `2,\!4`.
  * Fix end-line command ('\\') in AMSmath environments (ARATA Mizuki).
    The end-line command in AMSmath environments does not allow spaces
    before its optional argument.
  * Use `\in` for SMALL ELEMENT OF in "base" (Vaclav Haisman).

texmath (0.10)

  * Use `\ni` in base for U+220D (#103).
  * Improved unicode -> tex symbol lookup.  Previously we had many
    cases where the lookup table would map a unicode character to
    the empty string for the base package, and this would print finding
    a good match in another package in the environment.
  * Added support for `\symbf` (#101).
  * Revert "migrating the lookup structures for Unicode/ToTex.hs to
    use C source files to accelerate builds."  This change gave us somewhat
    faster builds (using less memory), but at a huge cost of
    maintainability.
  * Removed AlignDefault from Alignment (API change, #102).
    AlignDefault doesn't make sense for a converter between
    formats that may have different defaults.  We now properly treat
    centering as the default in MathML and OMML input.

texmath (0.9.4.4)

  * Update tests that should have been updated for 0.9.4.3.

texmath (0.9.4.3)

  * MathML writer: put linethickness attribute directly on mfrac
    element. This fixes binomial rendering.

texmath (0.9.4.2)

  * Pandoc writer: better handle accented characters (jgm/pandoc#3922).

texmath (0.9.4.1)

  * Improved handling of accents and upper/lower delimiters (#98).
  * cgi: use cloudflare cdn for mathjax.

texmath (0.9.4)

  * Added writer for GNU eqn format (used with *roff).

    + New module Text.TeXMath.Writers.Eqn, exporting writeEqn.
    + Moved handleDownup to Shared.
    + Add eqn output option in texmath executable.
    + Add eqn writer tests.

texmath (0.9.3)

  * Expose pMacroDefinition in Text.TeXMath.Readers.TeX.Macros,
    with generalized type.

texmath (0.9.2)

  * Support `\newenvironment` and `\renewenvironment`.

texmath (0.9.1.1)

  * Added program to generate cbits/{key,val}ToASCII.c from a data file.
  * Migrate lookup structures for Unicode/ToTex.hs to use C
    source files to accelerate builds (Carter Tazio Schonwald).
  * Allow \boldsymbol + a token without braces.
    And same for other styling commands. Closes #94.
  * Better ghc-prof-options.

texmath (0.9.1)

  * Pandoc writer:  add thin space after math operators.
  * TeX reader: improve parsing of `\mathop` to allow
    multi-character operator names.
  * Minor optimizations.
  * Added Ord instances to Exp and associated types.

texmath (0.9)

  * OMML writer: Properly handle nary inside delimiters (#92).
    Previously under-overs inside delimiters didn't get
    converted to nary the way they did outside of delimiters.
  * TeX reader: Support bm, mathbold, pmd.
  * OMML reader: Handle w:sym (#65).
  * New module, Text.TeXMath.Unicode.Fonts, for MS font code point
    lookup.  Copied from pandoc Text.Pandoc.Readers.Docx.Fonts,
    which will be changed to import this.  [API change]
  * Fixed typo in test program for round-trip tests.
  * Parse math inside text constructions (#62).  E.g.
    `\text{if $y$ is greater than $0$}` Text and math can nest indefinitely.
  * Modify test suite so tests can be marked as "ought to raise error."
    So far this is only used in mml.  If the test is called foo
    and `readers/mml/foo.error` exists, then the test is expected
    to raise a parse error.
  * MathML reader err: Don't print colon after line number.
  * Restore proper error handling to MathML reader.  Note that the tests
    need to be redone, since they assumed the old behavior of just
    returning empty elements on parse errors.

texmath (0.8.6.7)

  * TeX reader: treat backslash + newline as like backslash + space.
    Previously this case gave an error.  See jgm/pandoc#3189.

texmath (0.8.6.6)

  * Allow pandoc-types 1.17.*.

texmath (0.8.6.5)

  * Fixed transposition of sub/super on operators (jgm/pandoc#3040).

texmath (0.8.6.4)

  * Support 'equation' environment, without the numbering of course.

texmath (0.8.6.3)

  * Use POST instead of GET for texmath-cgi.

texmath (0.8.6.2)

  * Fixed array alignment issues (jgm/pandoc#2864, jgm/pandoc#2310).
  * Use 1 and 0 for _Hide attributes, rather than on and off.
    Officially it seems that either 1/0 or true/false are wanted.
  * Fixed EUnderOver for omml output.  Previously both the under and
    the over part were being placed under (jgm/pandoc#2775).

texmath (0.8.6.1)

  * OMML writer:  Fixed rendering of roots, so that the degree appears
    in the right place.
  * OMML writer:  Don't include empty rPr elements.

texmath (0.8.6)

  * TeX reader: Support hundreds more math symbols (all of those defined in
    Text.TeXMath.Unicode.ToTeX), including `\nwarrow`, `\swarrow`,
    `\nearrow`, `\searrow` (#90).

texmath (0.8.5.1)

  * OMML writer: Fixed order of elements in nary formulas to conform
    to OMML spec (#88, Niko Weh).  `<e>` must follow the `<sup>` and `<sub>`
    parts of `<nary>`. This fixes rendering issues in LibreOffice
    (though Word copes with the incorrect order).
  * Added Paths_texmath to Other-Modules for texmath executable.

texmath (0.8.5)

  * TeX parser: Support limited styling inside \DeclareMathOperator (#85).
  * TeX reader: Correctly parse \mbox.  Its argument is text mode.
  * Updated mathml tests to use mo for operators.
  * TeX reader: support mathopen, mathclose, mathpunct.
  * MathML writer: render EMathOperator as mo, not mi (#86).
  * MathML: handle leading space in EText (#87).
  * Take --version in executable from cabal metadata.
  * Added Paths_texmath to other-modules.

texmath (0.8.4.2)

  * Fixed overbrace, underbrace (#82).  Previously we were using the wrong
    character: U+FE37 instead of U+23DE.  This didn't work in Word.
  * Support \mathop, \mathrel, \mathbin, \mathord
  * MathML - render Symbol Ord as mi, not mo (#83).
  * Handle align environments with > 2 cells per row (#84).

texmath (0.8.4.1)

  * Added stack install instructions.
  * Fixed bold-italic in OMML (#76).  Previously `\mathbfit` didn't work
    properly in OMML output.
  * Ignore `\nonumber` (#79).
  * Allow styling in `\operatorname` e.g. `\operatorname{\mathcal{L}}` (#80).
  * Fixed bug in `supHide` and `subHide` for OMML.  This  led to little
    empty boxes being displayed in integrals with subscripts but no
    superscripts.  See jgm/pandoc#2571.
  * Implemented `\mod` as a math operator (#81).  This doesn't capture all the
    spacing subtleties of the amsmath version, but should be good enough
    for most purposes.
  * Allow pandoc-types < 1.17.

texmath (0.8.4)

  * Improved symbol spacing in Pandoc output (jgm/pandoc#2261).
    This change avoids putting space around binary symbols that
    come at the beginning or end of a group, or appear on their
    own.  It also avoids spacing on a binary symbol that follows
    a Bin, Op, Rel, Open, or Punct atom, in accord with
    TeXBook Appendix G.  We could go farther towards exactly
    matching the TeXBook rules, but this simple change goes some of
    the way.
  * Added stack.yaml.

texmath (0.8.3)

  * Parse uppercase Greek letters as EIdentifier, not ESymbol Op.
    This fixes handling of things like `$Lambda^1$`, particularly in omml.

texmath (0.8.2.2)

  * Handle `.` after number with no following digits.

texmath (0.8.2.1)

  * Handle bare hyphen in `\text{...}`.  Closes jgm/pandoc#2274.
  * Support `\ltimes` and `\rtimes` in the TeX reader (Arata Mizuki).
  * Slightly more efficient number parser.

texmath (0.8.2)

  * Better handling of decimal points. Decimal points are now parsed
    as parts of numbers, not as separate symbols.  E.g. in MathML they
    now appear in `<mn>` elements.  Closes #74.

texmath (0.8.1)

  * OMML: Don't force everything into Roman font by default.
    This change ensures that variables will be italic by
    default in Word.  See jgm/pandoc#2075.

texmath (0.8.0.2)

  * Fixed typo in `defaultEnv` to include `amssymb` (#68).
  * Moved some lookup tables to C, and disabled aggressive
    profiling defaults, to avoid excessive memory usage in
    compiling with clang (#70).
  * Support `\newcommand*` in `parseMacroDefinition` (jgm/pandoc#2005).
  * Fixed order bug for over/under in OMML reader (#66).
  * Support `\boldsymbol` (#67).

texmath (0.8.0.1)

  * Added network-uri flag. This addresses the split of network
    and network-uri packages.
  * OMML reader: change default accent (Jesse Rosenthal).
    The default had previously been set as accute (possibly as a
    placeholder). It appears to be circumflex/hat instead.

texmath (0.8)

  * Added OMML reader (Jesse Rosenthal).
  * Support latex \substack (#57).
  * Added EBoxed and implemented in readers and writers (#58).
  * Handle latex \genfrac.  Use \genfrac for \brace, \brack,
    etc. when amsmath is available.
  * Improvements in handling of space characters.
  * Use ESpace rather than EText when a mathml mtext just contains
    a space.
  * Use \mspace when needed to get latex spaces with odd sizes, rather
    than finding the closest simple command.
  * Use Rational instead of Double in ESpaced, EScaled.
  * Shared: Export getSpaceWidth, getSpaceChars.
  * Shared: Export fixTree, isEmpty, empty (formerly in MathML reader).

texmath (0.7.0.2)

  * TeX reader:  further improvements in error reporting.
    Instead of reporting line and column, a snippet is printed
    with a caret indicating the position of the error.  Also
    fixed bad position information when control sequences are
    followed by a letter.

texmath (0.7.0.1)

  * TeX reader:

    + Improved error reporting.
    + Optimized parser.
    + Treat `\ ` as ESpaced rather than ESymbol.
    + Internal improvements, including using the parsec3 interface
      instead of the older parsec2 compatibility interface.

  * Added tests for phantom.

texmath (0.7)

  * Changes in Exp type:

    + Removed EUp, EDown, EDownup, EUnary, EBinary.
    + Added EFraction (and FractionType), ESqrt, Eroot, EPhantom.
    + Added boolean "convertible" parameter to EUnder, EOver, EUnderover.
    + Changed parameter of EScaled from String to Double.
    + Changed parameter of ESpace from String to Double.
    + Removed EStretchy.
    + Added EStyled, corresponding to mstyle in mathml, and \mathrm,
      \mathcal, etc. in TeX (which can contain arbitrary math content,
      not just text).
    + Changed the type of EDelimited.  The contents of an EDelimited are
      now either Right Exp or Left String (the latter case represents a
      fence in middle position, e.g. \mid| in LaTeX).

  * Module reorganisation:  the exposed interface has been completely
    changed, and modules for reading MathML and writing TeX math
    have been added:

    + All writers now reside in Text.TeXMath.Writers.
        - Text.TeXMath.MathML -> Text.TeXMath.Writers.MathML.
          toMathML and showExp are removed, writeMathML added.
        - Text.TeXMath.OMML -> Text.TeXMath.Writers.OMML.
          toOMML and showExp removed, writeOMML added.
        - Text.TeXMath.Pandoc -> Text.TeXMath.Writers.Pandoc.
          toPandoc removed, writePandoc added.
        - New module Text.TeXMath.Writers.TeX, exporting writeTeX,
          writeTeXWith, addLaTeXEnvironment (the latter giving control
          over which packages are assumed to be available).

    + All readers now reside in Text.TeXMath.Readers.
        - Text.TeXMath.MathMLParser -> Text.TeXMath.Readers.MathML,
	  exporting readMathML.
        - Text.TeXMath.Readers.TeX nows exports readTeX rather than
          parseFormula.

    + New modules for unicode conversion: Text.TeXMath.Unicode.ToASCII,
      Text.TeXMath.Unicode.ToTeX, Text.TeXMath.Unicode.ToUnicode.

    + Two MathML specific modules: Text.TeXMath.Readers.MathML.EntityMap,
      Text.TeXMath.Readers.MathML.MMLDict.

    + In Text.TeXMath, all the XtoY functions have been removed
      in favour of rexporting raw reader and writer functions. The
      data type Exp is now also exported.

  * Bug fixes and improvements.

    + TeX writer: Properly handle accents inside \text{}.
      Use real text environments for EText (\textrm, not \mathrm).
      Improved handling of scalers (\Big etc.).  Use amsmath matrix
      environments when appropriate.  Fixed \varepsilon.
    + MathML writer:  Omit superfluous outer mrows.  Add position
      information to fences.
    + OMML writer:  Handle \phantom.
    + Pandoc writer:  Use unicode characters to support Fraktur and
      other text styles.
    + TeX reader:  Use EUnder/Over for \stackrel, \overset, \underset.
      Improved handling of primes.  Fixed \notin.  Avoid superfluous
      grouping of single elements.  Improved handling of scalers (\Big etc.).
      Handle \choose, \brace, \brack, \bangle (#21).
    + Macros:  Don't raise an error if applying a macro fails to
      resolve to a fixed point; instead, just return the original string.

  * Rewrote test suite as a proper cabal test suite.  Added
    --regenerate-tests and --round-trip options.

  * Updated texmath online demo for bidirectional conversion.

  * Removed cgi and test flags.  Added executable flag to build texmath.

  * Modified texmath so it works like a cgi script when run as
    texmath-cgi (through symlink or renaming).  Removed dependency on
    the cgi package.

texmath (0.6.7)

  * New Module: Text.TeXMath.Unidecode, a module for approximating
    unicode characters in ASCII.
  * New Module: Text.TeXMath.Shared, a module for shared lookup
    tables between the various readers and writers
  * New Module: Text.TeXMath.MathMLParser, exporting readMathML.
  * New Module: Text.TeXMath.EntityMap, exporting getUnicode,
    a conversion table from MathML entities to unicode characters.
  * New Module: Text.TeXMath.UnicodeToLaTeX, exporting getLaTeX,
    converting a string of unicode characters to a string of equivalent LaTeX
    commands.
  * New Module: Text.TeXMath.LaTeX, replacing Text.TeXMath.Parser,
    exporting toTeXMath.
  * New Module: Text.TeXMath.MMLDict, implements a lookup table from
    operators to their default values as defined by the MML dictionary,
    exporting getOperator.
  * New Module: Text.TeXMath.Compat, maintaining compatibility with
    mtl < 2.2.1.
  * Modified Text.TeXMath to export the primitive readers, as well as
    mathMLTo{Writer} for all writers
  * Modified: Text.TeXMath.Types: added additional record types for
    Text.TeXMath.MMLDict and Text.TeXMath.UnicodeToLaTeX.
    New Exports: Operator(..), Record(..).
  * Modified test suite:  use cabal test, added significant number of tests.
  * Added recognition of the LaTeX command \phantom

texmath (0.6.6.3)

  * Use combining tilde accent for \tilde.  Closes pandoc #1324.

texmath (0.6.6.2)

  * Allow \left to be used with ), ], etc.  Ditto with \right.
    Previously only (, [, etc. were allowed with \left.  Closes pandoc #1319.

texmath (0.6.6.1)

  * Support \multline (previously it was mispelled "multiline")
  * Changed data-files to extra-source-files.

texmath (0.6.6)

  * Insert braces around macro expansions to prevent breakage (#7).
  * Support \operatorname and \DeclareMathOperator (rekka) (#17).
  * Support \providecommand (#15).
  * Fixed spacing bugs in pandoc rendering (#24).
  * Ignore \hline at end of array row instead of failing (#19).

