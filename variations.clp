/*
* Shafieen Ibrahim
* 11/12/18
*
* This file contains the variations for some of the openings in the openings.clp file.
* Not all the variations for the openings are listed - only the common ones that have
* seen a lot of competitive play at various skill levels and can be played by players
* of all skill levels.
*/

/*
* The Exchange Variation is a non-aggressive variation that leads to positional play.
* The Marshall Attack is a dynamic, aggressive option that can lead to center play or a kingside attack.
*/
(defrule ruyLopezVariations "This rule lists out the variations for the Ruy Lopez"
   (variations yes) (openingFound yes) (opening "Ruy Lopez")
=>
   (newLine)
   (println "Variations for the Ruy Lopez include:")
   (println "Exchange Variation: 1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 4. Bxc6")
   (println "Marshall Attack: 1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 4. Ba4 Nf6 5. O-O Be7 6. Re1")
)

/*
* The Najdorf Defense is the most popular system, and it pressures the queenside and builds Black's queenside attack.
* The Dragon Variation is a positional variation that develops Black's bishop on the kingside and prepares to challenge the center.
* The Classical Variation is a direct counter to White's center control and develop pieces at the same time.
*/
(defrule sicilianVariations "This rule lists out the variations for the Sicilian Defense"
   (variations yes) (openingFound yes) (opening "Sicilian Defense")
=>
   (newLine)
   (println "Variations for the Sicilian Defense include:")
   (println "Najdorf Defense: 1. e4 c5 2. Nf3 d6 3. d4 cxd4 4. Nxd4 Nf6 5. Nc3 a6")
   (println "Dragon Variation: 1. e4 c5 2. Nf3 d6 3. d4 cxd4 4. Nxd4 Nf6 5. Nc3 g6")
   (println "Classical Variation: 1. e4 c5 2. Nf3 d6 3. d4 cxd4 4. Nxd4 Nf6 5. Nc3 Nc6")
)

/*
* The Winawer Variation is an aggressive variation that plays along diagonals on the kingside.
* The Classical Variation is a dynamic variation that can lead to positional play focused on gaining control of the center.
* The Rubenstein Variation is an aggressive variation that blows the center open and creates open lines and diagonals that can be exploited.
*/
(defrule frenchVariations "This rule lists out the variations for the French Defense"
   (variations yes) (openingFound yes) (opening "French Defense")
=>
   (newLine)
   (println "Variations for the French Defense include:")
   (println "Winawer Variation: 1. e4 e6 2. d4 d5 3. Nc3 Bb4")
   (println "Classical Variation 1. e4 e6 2. d4 d5 3. Nc3 Nf6")
   (println "Rubenstein Variation: 1. e4 e6 2. d4 d5 3. Nc3 dxe4")
)

/*
* The Classical Variation is a positional variation that relies on piece coordination.
* The Exchange Variation is a dynamic variation that opens up diagonals and can lead to some tactical play.
* The Advance Variation is a closed variation that relies on piece development to prevent any weaknesses for Black.
*/
(defrule caroKannVariations "This rule lists out the variations for the Caro Kann"
   (variations yes) (openingFound yes) (opening "Caro Kann")
=>
   (newLine)
   (println "Variations for the Caro Kann include:")
   (println "Classical Variation: 1. e4 c6 2. d4 d5 3. Nc3 dxe4 4. Nxe4 Bf5")
   (println "Exchange Variation: 1. e4 c6 2. d4 d5 3. exd5 cxd5")
   (println "Advance Variation: 1. e4 c6 2. d4 d5 3. e5 Bf5")
)