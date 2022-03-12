{-# LANGUAGE OverloadedStrings #-}
{-
Copyright (C) 2009-2022 John MacFarlane <jgm@berkeley.edu>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-}

{- | Lookup tables for TeX commands.
-}

module Text.TeXMath.Readers.TeX.Commands
  ( styleOps
  , textOps
  , enclosures
  , operators
  , symbols
  , siUnitMap
  )
where

import qualified Data.Map as M
import Text.TeXMath.Types
import Text.TeXMath.Unicode.ToTeX (symbolMap)
import Data.Text (Text)
import Data.Ratio ((%))

-- Note: cal and scr are treated the same way, as unicode is lacking such two different sets for those.
styleOps :: M.Map Text ([Exp] -> Exp)
styleOps = M.fromList
          [ ("\\mathrm",     EStyled TextNormal)
          , ("\\mathup",     EStyled TextNormal)
          , ("\\mathbf",     EStyled TextBold)
          , ("\\boldsymbol", EStyled TextBold)
          , ("\\bm",         EStyled TextBold)
          , ("\\symbf",      EStyled TextBold)
          , ("\\mathbold",   EStyled TextBold)
          , ("\\pmb",        EStyled TextBold)
          , ("\\mathbfup",   EStyled TextBold)
          , ("\\mathit",     EStyled TextItalic)
          , ("\\mathtt",     EStyled TextMonospace)
          , ("\\texttt",     EStyled TextMonospace)
          , ("\\mathsf",     EStyled TextSansSerif)
          , ("\\mathsfup",   EStyled TextSansSerif)
          , ("\\mathbb",     EStyled TextDoubleStruck)
          , ("\\mathds",     EStyled TextDoubleStruck) -- mathds package
          , ("\\mathcal",    EStyled TextScript)
          , ("\\mathscr",    EStyled TextScript)
          , ("\\mathfrak",   EStyled TextFraktur)
          , ("\\mathbfit",   EStyled TextBoldItalic)
          , ("\\mathbfsfup", EStyled TextSansSerifBold)
          , ("\\mathbfsfit", EStyled TextSansSerifBoldItalic)
          , ("\\mathbfscr",  EStyled TextBoldScript)
          , ("\\mathbffrak", EStyled TextBoldFraktur)
          , ("\\mathbfcal",  EStyled TextBoldScript)
          , ("\\mathsfit",   EStyled TextSansSerifItalic)
          ]

textOps :: M.Map Text (Text -> Exp)
textOps = M.fromList
          [ ("\\textrm", (EText TextNormal))
          , ("\\text",   (EText TextNormal))
          , ("\\textbf", (EText TextBold))
          , ("\\textit", (EText TextItalic))
          , ("\\texttt", (EText TextMonospace))
          , ("\\textsf", (EText TextSansSerif))
          , ("\\mbox",   (EText TextNormal))
          ]

enclosures :: M.Map Text Exp
enclosures = M.fromList
  [ ("(", ESymbol Open "(")
  , (")", ESymbol Close ")")
  , ("[", ESymbol Open "[")
  , ("]", ESymbol Close "]")
  , ("\\{", ESymbol Open "{")
  , ("\\}", ESymbol Close "}")
  , ("\\lbrack", ESymbol Open "[")
  , ("\\lbrace", ESymbol Open "{")
  , ("\\rbrack", ESymbol Close "]")
  , ("\\rbrace", ESymbol Close "}")
  , ("\\llbracket", ESymbol Open "\x27E6")
  , ("\\rrbracket", ESymbol Close "\x27E7")
  , ("\\langle", ESymbol Open "\x27E8")
  , ("\\rangle", ESymbol Close "\x27E9")
  , ("\\lfloor", ESymbol Open "\x230A")
  , ("\\rfloor", ESymbol Close "\x230B")
  , ("\\lceil", ESymbol Open "\x2308")
  , ("\\rceil", ESymbol Close "\x2309")
  , ("|", ESymbol Close "|")
  , ("|", ESymbol Open "|")
  , ("\\|", ESymbol Open "\x2225")
  , ("\\|", ESymbol Close "\x2225")
  , ("\\lvert", ESymbol Open "\x7C")
  , ("\\rvert", ESymbol Close "\x7C")
  , ("\\vert", ESymbol Close "\x7C")
  , ("\\lVert", ESymbol Open "\x2225")
  , ("\\rVert", ESymbol Close "\x2225")
  , ("\\Vert", ESymbol Close "\x2016")
  , ("\\ulcorner", ESymbol Open "\x231C")
  , ("\\urcorner", ESymbol Close "\x231D")
  ]

operators :: M.Map Text Exp
operators = M.fromList [
             ("+", ESymbol Bin "+")
           , ("-", ESymbol Bin "\x2212")
           , ("*", ESymbol Bin "*")
           , ("@", ESymbol Ord "@")
           , (",", ESymbol Pun ",")
           , (".", ESymbol Ord ".")
           , (";", ESymbol Pun ";")
           , (":", ESymbol Rel ":")
           , ("?", ESymbol Ord "?")
           , (">", ESymbol Rel ">")
           , ("<", ESymbol Rel "<")
           , ("!", ESymbol Ord "!")
           , ("'", ESymbol Ord "\x2032")
           , ("''", ESymbol Ord "\x2033")
           , ("'''", ESymbol Ord "\x2034")
           , ("''''", ESymbol Ord "\x2057")
           , ("=", ESymbol Rel "=")
           , (":=", ESymbol Rel ":=")
           , ("/", ESymbol Ord "/")
           , ("~", ESpace (4/18)) ]

symbols :: M.Map Text Exp
symbols = symbolMapOverrides <> symbolMap

-- These are the cases where texmath historically diverged
-- from symbolMap.  We may want to remove some of these overrides,
-- but for now we keep them so behavior doesn't change.
symbolMapOverrides ::  M.Map Text Exp
symbolMapOverrides = M.fromList
  [ ("\\\n",ESpace (2 % 9))
  , ("\\ ",ESpace (2 % 9))
  , ("\\!",ESpace ((-1) % 6))
  , ("\\,",ESpace (1 % 6))
  , ("\\:",ESpace (2 % 9))
  , ("\\;",ESpace (5 % 18))
  , ("\\>",ESpace (2 % 9))
  , ("\\AC",ESymbol Ord "\9190")
  , ("\\Box",ESymbol Op "\9633")
  , ("\\Delta",EIdentifier "\916")
  , ("\\Diamond",ESymbol Op "\9671")
  , ("\\Gamma",EIdentifier "\915")
  , ("\\Im",ESymbol Ord "\8465")
  , ("\\Join",ESymbol Rel "\8904")
  , ("\\Lambda",EIdentifier "\923")
  , ("\\Lbrbrak",ESymbol Open "\12312")
  , ("\\Longleftarrow",ESymbol Rel "\8656")
  , ("\\Longleftrightarrow",ESymbol Rel "\8660")
  , ("\\Longrightarrow",ESymbol Rel "\8658")
  , ("\\Omega",EIdentifier "\937")
  , ("\\Phi",EIdentifier "\934")
  , ("\\Pi",EIdentifier "\928")
  , ("\\Pr",EMathOperator "Pr")
  , ("\\Psi",EIdentifier "\936")
  , ("\\Rbrbrak",ESymbol Close "\12313")
  , ("\\Re",ESymbol Ord "\8476")
  , ("\\Sigma",EIdentifier "\931")
  , ("\\Theta",EIdentifier "\920")
  , ("\\Upsilon",EIdentifier "\933")
  , ("\\Xi",EIdentifier "\926")
  , ("\\^",ESymbol Ord "^")
  , ("\\alpha",EIdentifier "\945")
  , ("\\amalg",ESymbol Bin "\8720")
  , ("\\arccos",EMathOperator "arccos")
  , ("\\arcsin",EMathOperator "arcsin")
  , ("\\arctan",EMathOperator "arctan")
  , ("\\arg",EMathOperator "arg")
  , ("\\ast",ESymbol Bin "*")
  , ("\\backslash",ESymbol Bin "\8726")
  , ("\\bar",ESymbol Accent "\8254")
  , ("\\barwedge",ESymbol Bin "\8965")
  , ("\\beta",EIdentifier "\946")
  , ("\\bigcirc",ESymbol Bin "\9675")
  , ("\\blacklozenge",ESymbol Ord "\11047")
  , ("\\blacksquare",ESymbol Ord "\9724")
  , ("\\blacktriangleleft",ESymbol Bin "\9666")
  , ("\\blacktriangleright",ESymbol Bin "\9656")
  , ("\\cdot",ESymbol Bin "\8901")
  , ("\\chi",EIdentifier "\967")
  , ("\\cos",EMathOperator "cos")
  , ("\\cosh",EMathOperator "cosh")
  , ("\\cot",EMathOperator "cot")
  , ("\\coth",EMathOperator "coth")
  , ("\\csc",EMathOperator "csc")
  , ("\\dag",ESymbol Bin "\8224")
  , ("\\ddag",ESymbol Bin "\8225")
  , ("\\deg",EMathOperator "deg")
  , ("\\delta",EIdentifier "\948")
  , ("\\det",EMathOperator "det")
  , ("\\diamond",ESymbol Op "\8900")
  , ("\\digamma",ESymbol Alpha "\989")
  , ("\\dim",EMathOperator "dim")
  , ("\\dots",ESymbol Ord "\8230")
  , ("\\dotsb",ESymbol Ord "\8943")
  , ("\\dotsc",ESymbol Ord "\8230")
  , ("\\dotsi",ESymbol Ord "\8943")
  , ("\\dotsm",ESymbol Ord "\8943")
  , ("\\dotso",ESymbol Ord "\8230")
  , ("\\emptyset",ESymbol Ord "\8709")
  , ("\\epsilon",EIdentifier "\1013")
  , ("\\eqcolon",ESymbol Rel "\8789")
  , ("\\eta",EIdentifier "\951")
  , ("\\exists",ESymbol Op "\8707")
  , ("\\exp",EMathOperator "exp")
  , ("\\forall",ESymbol Op "\8704")
  , ("\\gamma",EIdentifier "\947")
  , ("\\gcd",EMathOperator "gcd")
  , ("\\geqslant",ESymbol Rel "\8805")
  , ("\\gt",ESymbol Rel ">")
  , ("\\hbar",ESymbol Ord "\8463")
  , ("\\hdots",ESymbol Ord "\8230")
  , ("\\hom",EMathOperator "hom")
  , ("\\iff",ESymbol Rel "\8660")
  , ("\\inf",EMathOperator "inf")
  , ("\\iota",EIdentifier "\953")
  , ("\\kappa",EIdentifier "\954")
  , ("\\ker",EMathOperator "ker")
  , ("\\lambda",EIdentifier "\955")
  , ("\\lbrbrak",ESymbol Open "\12308")
  , ("\\leqslant",ESymbol Rel "\8804")
  , ("\\lg",EMathOperator "lg")
  , ("\\lhd",ESymbol Bin "\8882")
  , ("\\lim",EMathOperator "lim")
  , ("\\liminf",EMathOperator "liminf")
  , ("\\limsup",EMathOperator "limsup")
  , ("\\llbracket",ESymbol Open "\12314")
  , ("\\ln",EMathOperator "ln")
  , ("\\log",EMathOperator "log")
  , ("\\longleftarrow",ESymbol Rel "\8592")
  , ("\\longleftrightarrow",ESymbol Rel "\8596")
  , ("\\longmapsto",ESymbol Rel "\8614")
  , ("\\longrightarrow",ESymbol Rel "\8594")
  , ("\\lozenge",ESymbol Op "\9674")
  , ("\\lt",ESymbol Rel "<")
  , ("\\max",EMathOperator "max")
  , ("\\mid",ESymbol Bin "\8739")
  , ("\\min",EMathOperator "min")
  , ("\\models",ESymbol Rel "\8872")
  , ("\\mu",EIdentifier "\956")
  , ("\\neg",ESymbol Op "\172")
  , ("\\nu",EIdentifier "\957")
  , ("\\omega",EIdentifier "\969")
  , ("\\overbar",ESymbol Accent "\175")
  , ("\\overline",ESymbol TOver "\175")
  , ("\\overrightarrow",ESymbol Accent "\8407")
  , ("\\perp",ESymbol Rel "\8869")
  , ("\\phi",EIdentifier "\981")
  , ("\\pi",EIdentifier "\960")
  , ("\\preceq",ESymbol Rel "\8828")
  , ("\\psi",EIdentifier "\968")
  , ("\\qquad",ESpace (2 % 1))
  , ("\\quad",ESpace (1 % 1))
  , ("\\rbrbrak",ESymbol Close "\12309")
  , ("\\rhd",ESymbol Bin "\8883")
  , ("\\rho",EIdentifier "\961")
  , ("\\rrbracket",ESymbol Close "\12315")
  , ("\\sec",EMathOperator "sec")
  , ("\\setminus",ESymbol Bin "\\")
  , ("\\sigma",EIdentifier "\963")
  , ("\\sim",ESymbol Rel "\8764")
  , ("\\sin",EMathOperator "sin")
  , ("\\sinh",EMathOperator "sinh")
  , ("\\square",ESymbol Ord "\9643")
  , ("\\succeq",ESymbol Rel "\8829")
  , ("\\sup",EMathOperator "sup")
  , ("\\tan",EMathOperator "tan")
  , ("\\tanh",EMathOperator "tanh")
  , ("\\tau",EIdentifier "\964")
  , ("\\therefore",ESymbol Pun "\8756")
  , ("\\theta",EIdentifier "\952")
  , ("\\triangle",ESymbol Ord "\9651")
  , ("\\triangleleft",ESymbol Bin "\8882")
  , ("\\triangleright",ESymbol Bin "\8883")
  , ("\\underbar",ESymbol TUnder "\817")
  , ("\\underline",ESymbol TUnder "_")
  , ("\\unlhd",ESymbol Bin "\8884")
  , ("\\unrhd",ESymbol Bin "\8885")
  , ("\\upUpsilon",ESymbol Alpha "\978")
  , ("\\upsilon",EIdentifier "\965")
  , ("\\varDelta",EIdentifier "\120549")
  , ("\\varGamma",EIdentifier "\120548")
  , ("\\varLambda",EIdentifier "\120556")
  , ("\\varOmega",EIdentifier "\120570")
  , ("\\varPhi",EIdentifier "\120567")
  , ("\\varPi",EIdentifier "\120561")
  , ("\\varPsi",EIdentifier "\120569")
  , ("\\varSigma",EIdentifier "\120564")
  , ("\\varTheta",EIdentifier "\120553")
  , ("\\varUpsilon",EIdentifier "\120566")
  , ("\\varXi",EIdentifier "\120559")
  , ("\\varepsilon",EIdentifier "\949")
  , ("\\varnothing",ESymbol Ord "\8960")
  , ("\\varphi",EIdentifier "\966")
  , ("\\varrho",ESymbol Alpha "\120602")
  , ("\\varsigma",ESymbol Alpha "\120589")
  , ("\\vartheta",EIdentifier "\977")
  , ("\\vdots",ESymbol Ord "\8942")
  , ("\\vec",ESymbol Accent "\8407")
  , ("\\wp",ESymbol Ord "\8472")
  , ("\\wr",ESymbol Ord "\8768")
  , ("\\xi",EIdentifier "\958")
  , ("\\zeta",EIdentifier "\950")
  ]

siUnitMap :: M.Map Text Exp
siUnitMap = M.fromList
  [ ("fg", str "fg")
  , ("pg", str "pg")
  , ("ng", str "ng")
  , ("ug", str "μg")
  , ("mg", str "mg")
  , ("g", str "g")
  , ("kg", str "kg")
  , ("amu", str "u")
  , ("pm", str "pm")
  , ("nm", str "nm")
  , ("um", str "μm")
  , ("mm", str "mm")
  , ("cm", str "cm")
  , ("dm", str "dm")
  , ("m", str "m")
  , ("km", str "km")
  , ("as", str "as")
  , ("fs", str "fs")
  , ("ps", str "ps")
  , ("ns", str "ns")
  , ("us", str "μs")
  , ("ms", str "ms")
  , ("s", str "s")
  , ("fmol", str "fmol")
  , ("pmol", str "pmol")
  , ("nmol", str "nmol")
  , ("umol", str "μmol")
  , ("mmol", str "mmol")
  , ("mol", str "mol")
  , ("kmol", str "kmol")
  , ("pA", str "pA")
  , ("nA", str "nA")
  , ("uA", str "μA")
  , ("mA", str "mA")
  , ("A", str "A")
  , ("kA", str "kA")
  , ("ul", str "μl")
  , ("ml", str "ml")
  , ("l", str "l")
  , ("hl", str "hl")
  , ("uL", str "μL")
  , ("mL", str "mL")
  , ("L", str "L")
  , ("hL", str "hL")
  , ("mHz", str "mHz")
  , ("Hz", str "Hz")
  , ("kHz", str "kHz")
  , ("MHz", str "MHz")
  , ("GHz", str "GHz")
  , ("THz", str "THz")
  , ("mN", str "mN")
  , ("N", str "N")
  , ("kN", str "kN")
  , ("MN", str "MN")
  , ("Pa", str "Pa")
  , ("kPa", str "kPa")
  , ("MPa", str "MPa")
  , ("GPa", str "GPa")
  , ("mohm", str "mΩ")
  , ("kohm", str "kΩ")
  , ("Mohm", str "MΩ")
  , ("pV", str "pV")
  , ("nV", str "nV")
  , ("uV", str "μV")
  , ("mV", str "mV")
  , ("V", str "V")
  , ("kV", str "kV")
  , ("W", str "W")
  , ("uW", str "μW")
  , ("mW", str "mW")
  , ("kW", str "kW")
  , ("MW", str "MW")
  , ("GW", str "GW")
  , ("J", str "J")
  , ("uJ", str "μJ")
  , ("mJ", str "mJ")
  , ("kJ", str "kJ")
  , ("eV", str "eV")
  , ("meV", str "meV")
  , ("keV", str "keV")
  , ("MeV", str "MeV")
  , ("GeV", str "GeV")
  , ("TeV", str "TeV")
  , ("kWh", str "kWh")
  , ("F", str "F")
  , ("fF", str "fF")
  , ("pF", str "pF")
  , ("K", str "K")
  , ("dB", str "dB")
  , ("ampere", str "A")
  , ("angstrom", str "Å")
  , ("arcmin", str "′")
  , ("arcminute", str "′")
  , ("arcsecond", str "″")
  , ("astronomicalunit", str "ua")
  , ("atomicmassunit", str "u")
  , ("atto", str "a")
  , ("bar", str "bar")
  , ("barn", str "b")
  , ("becquerel", str "Bq")
  , ("bel", str "B")
  , ("bohr", ESuper (EText TextItalic "a") (ENumber "0"))
  , ("candela", str "cd")
  , ("celsius", str "°C")
  , ("centi", str "c")
  , ("clight", ESuper (EText TextItalic "c") (ENumber "0"))
  , ("coulomb", str "C")
  , ("dalton", str "Da")
  , ("day", str "d")
  , ("deca", str "d")
  , ("deci", str "d")
  , ("decibel", str "db")
  , ("degreeCelsius",str "°C")
  , ("degree", str "°")
  , ("deka", str "d")
  , ("electronmass", ESuper (EText TextItalic "m") (EText TextItalic "e"))
  , ("electronvolt", str "eV")
  , ("elementarycharge", EText TextItalic "e")
  , ("exa", str "E")
  , ("farad", str "F")
  , ("femto", str "f")
  , ("giga", str "G")
  , ("gram", str "g")
  , ("gray", str "Gy")
  , ("hartree", ESuper (EText TextItalic "E") (EText TextItalic "h"))
  , ("hectare", str "ha")
  , ("hecto", str "h")
  , ("henry", str "H")
  , ("hertz", str "Hz")
  , ("hour", str "h")
  , ("joule", str "J")
  , ("katal", str "kat")
  , ("kelvin", str "K")
  , ("kilo", str "k")
  , ("kilogram", str "kg")
  , ("knot", str "kn")
  , ("liter", str "L")
  , ("litre", str "l")
  , ("lumen", str "lm")
  , ("lux", str "lx")
  , ("mega", str "M")
  , ("meter", str "m")
  , ("metre", str "m")
  , ("micro", str "μ")
  , ("milli", str "m")
  , ("minute", str "min")
  , ("mmHg", str "mmHg")
  , ("mole", str "mol")
  , ("nano", str "n")
  , ("nauticalmile", str "M")
  , ("neper", str "Np")
  , ("newton", str "N")
  , ("ohm", str "Ω")
  , ("Pa", str "Pa")
  , ("pascal", str "Pa")
  , ("percent", str "%")
  , ("per", str "/")
  , ("peta", str "P")
  , ("pico", str "p")
  , ("planckbar", EText TextItalic "\x210f")
  , ("radian", str "rad")
  , ("second", str "s")
  , ("siemens", str "S")
  , ("sievert", str "Sv")
  , ("steradian", str "sr")
  , ("tera", str "T")
  , ("tesla", str "T")
  , ("tonne", str "t")
  , ("volt", str "V")
  , ("watt", str "W")
  , ("weber", str "Wb")
  , ("yocto", str "y")
  , ("yotta", str "Y")
  , ("zepto", str "z")
  , ("zetta", str "Z")
  ]
 where
  str = EText TextNormal
