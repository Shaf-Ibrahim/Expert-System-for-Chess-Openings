/*
* Shafieen Ibrahim
* 11/12/18
* 
* This file contains the rules for the different openings that this system
* knows and can offer to the user. The openings include openings for both
* white and black, e4 openings, d4 openings, and c4 openings. Openings
* are categorized by different traits, such as the level of opening
* knowledge required to play them, the tactics level required, the type
* of opening it is (passive/aggressive), etc.
*
* This file contains several magic numbers which are acting as indicators
* of skill for certain categories (playstyle, tactics, openingTheory, etc).
* These numbers are only used within these opening rules to determine where
* the skill level needed for certain openings and when a player's skill level
* for a certain category exceeds that opening. The magic numbers are commented
* as to why they were used. The single digit magic numbers are on a scale from 
* 1 - 10, indicating a certain degree in an area (ie: 7 on a scale of 1-10 about
* playstyle would indicate an aggressive player), and the magic numbers in the hundreds
* or thousands are USCF rating cutoffs that divide players into different skill categories.
*
* Each opening rule contains a block comment explaining why the magic numbers were used. It
* explains the opening's requirements for the user and what those requirements entail on the chess
* board.
*/

/************************************************************************************************************************
* These are rules that describe the different types of e4 openings for white and black.
/************************************************************************************************************************

/*
* The Fried Liver Opening is an excellent option for aggressive players
* who like fast-paced games with a lot of tactics involved and want an
* explosive opening as White.
*
* This opening is great for casual players who are starting out that want
* an aggressive opening.
*
* This opening also suits competitive players who don't have too much experience
* with opening theory and prefer an aggressive opening that has a lot of traps
* for the opponent. Their tactics should be decent as there is a lot of tactical
* play in this opening, but they do not need to have incredibly good tactics
* to have success with this opening.
*/
(defrule friedLiver "This rule offers the Fried Liver opening"
   (not (openingFound yes))

   /*
   * Playstyle > 6 -> this is an aggressive attack that aims to pressure the king
   * Rating < 1300 -> this opening is meant for beginners; it is easily refuted at higher elos
   * Tactics >= 3 -> this opening has a lot of tactics that can backfire if the player is weak in tactical play
   * 1 <= Opening Theory <= 3 -> this opening has minimal theory behind it and shouldn't be played by players
   * with a lot of theoretical knowledge, as there are better alternatives suited for them
   */
   (or (and (USCF no) (white yes) (playstyle ?p & :(> ?p 6))) 
       (and (white yes) (rating ?r & :(< ?r 1300)) (playstyle ?p & :(> ?p 6)) (tactics ?t & :(>= ?t 3))
            (openingTheory ?o & :(and (<= ?o 3) (>= ?o 1)))))
=>
   (newLine)

   (assert (opening "Fried Liver Attack"))
   (assert (openingMoves "1. e4 e5 2. Nf3 Nc6 3. Bc4 Nf6 4. Ng5"))
)

/*
* The Danish Gambit is an aggressive opening that sacrifices pawns in
* the early game in compensation for an aggressive kingside attack that
* could prove rewarding. This is a good option for White if the player
* wants to gamble material for a strong attack.
*
* This opening is good for casual players who are starting out, because
* there aren't many tactics involved. However, it is a gambit, so the player
* is taking a calculated risk when playing this opening.
*
* This opening also suits competitive players who want an aggressive opening
* and an early attack, but it does require some knowledge on opening theory
* as the player is making a sacrifice and can quickly lose their compensation
* if they do not know how to play aggressively or coordinate an attack.
*/
(defrule danishGambit "This rule offers the Danish Gambit"
   (not (openingFound yes))

   /*
   * Playstyle > 6 -> this is an aggressive gambit that sacrifices pawns in exchange for an attack
   * Rating < 1300 -> this opening is meant for beginners; higher rated players can counter this easily
   * Tactics >= 3 -> this is an aggressive, tactical opening that relies on the player's ability to find tactics during the attack
   * Opening Theory > 3 -> like all gambits, this one requires some knowledge of how to coordinate an attack given the sacrifice
   */
   (or (and (USCF no) (white yes) (playstyle ?p & :(> ?p 6))) 
       (and (white yes) (rating ?r & :(< ?r 1300)) (playstyle ?p & :(> ?p 6)) (tactics ?t & :(>= ?t 3))
            (openingTheory ?o & :(> ?o 3))))
=>
   (newLine)

   (assert (opening "Danish Gambit"))
   (assert (openingMoves "1. e4 e5 2. d4 exd4 3. c3"))
)

/*
* Four Knights' Game is a simple opening that plays positionally and allows
* for several different positions. It focuses on basic opening principles and
* doesn't follow any crazy, aggressive lines.
*
* This opening is good for competitive players looking for a relatively slow-paced,
* solid opening to start with without many tactics involved. This opening leads
* to several positions that develop pieces and are solid, and leads to positional play
* that isn't reliant on tactical knowledge.
*/
(defrule fourKnights "This rule offers the Four Knights Game"
   (not (openingFound yes))

   /*
   * Rating < 1300 -> this opening is meant for beginners; other positional openings trump this one at higher elos
   * Playstyle <= 6 -> this is a non-aggressive opening that is more reserved rather than aggressive
   * Opening Theory <= 3 -> this is a simple opening that can be played off intuition; not much opening theory is required
   */
   (and (white yes) (rating ?r & :(< ?r 1300)) (playstyle ?p & :(<= ?p 6)) (openingTheory ?o & :(<= ?o 3)))
=>
   (newLine)

   (assert (opening "Four Knights Game"))
   (assert (openingMoves "1. e4 e5 2. Nf3 Nc6 3. Nc3 Nf6 4. "))
)

/*
* The Ruy Lopez is a solid opening that can transpose into aggressive, tactical
* lines or a solid middlegame position for White.
*
* This opening can be good for casual players looking for a non-aggressive opening
* to begin playing chess with, and an opening that they can learn with. The basic
* lines for the Ruy Lopez are not too complicated and can be played by opening
* intuition without much risk.
*
* For competitive play, this is a great opening with a lot of opening theory
* that can lead to interesting middlegame play or an explosive early game.
* This opening is somewhat complicated and requires both tactical knowledge
* and knowledge of opening theory.
*/
(defrule ruyLopez "This rule offers the Ruy Lopez"
   /*
   * Rating < 1300 -> this opening is meant for beginners; only advanced, highly theoretical variations are played at higher elos
   * Playstyle <= 6 -> most variations of the Ruy Lopez are non-aggressive and positional
   * Opening Theory > 3 -> as a positional opening, there is a lot of theory behind the opening; inexperienced players can fall into traps easily
   */
   (or (and (USCF no) (white yes) (playstyle ?p & :(<= ?p 6)))
       (and (white yes) (rating ?r & :(< ?r 1300)) (playstyle ?p & :(<= ?p 6)) (openingTheory ?o & :(> ?o 3))))
=>
   (newLine)

   (assert (opening "Ruy Lopez"))
   (assert (openingMoves "1. e4 e5 2. Nf3 Nc6 3. Bb5"))
   (assert (variations yes))
)

/*
* The Scotch Game is a solid opening for White that develops pieces early
* and challenges the center, leading to a positional game revolving around
* piece development and center play.
*
* This opening is good for competitive players seeking to enter more positional
* play and dynamic play revolving around the center squares. It is an opening
* that requires some knowledge of opening theory, some intuition, and some
* knowledge of positional play, so it should not be played by beginners.
*/
(defrule scotchGame "This rule offers the Scotch Game"
   (not (openingFound yes))

   /*
   * Rating >= 1300 -> this opening is more advanced and meant for intermediates and above
   * Playstyle <= 6 -> this opening is mostly positional that can occassionally lead to kingside attacks
   * Opening Theory > 6 -> there are several ways for the opponent to respond; the White player must know different theoretical lines
   * Intuition > 3 -> White must have some intuition to play positionally in case they don't know the theory
   * Positional Play > 3 -> some variations must be played positionally rather than tactically/aggressively
   */
   (and (white yes) (rating ?r & :(>= ?r 1300)) (playstyle ?p & :(<= ?p 6)) (openingTheory ?o & :(> ?o 6))
        (intuition ?i & :(> ?i 3)) (positionalPlay ?pl & :(> ?pl 3)))
=>
   (newLine)

   (assert (opening "Scotch Game"))
   (assert (openingMoves "1. e4 e5 2. Nf3 Nc6 3. d4"))
)

/*
* The Evans Gambit is a complicated gambit for White, a special continuation of
* the Giuoco Piano that has a lot of positional play along diagonals and can
* lead to complicated middlegame positions.
*
* Competitive players can use this rare opening to surprise their opponents and catch
* them off guard if they aren't prepared for this attack.
*/
(defrule evansGambit "This rule offers the Evans Gambit"
   (not (openingFound yes))

   /*
   * Rating >= 1300 -> this opening is meant for intermediates and higher, as it is highly tactical
   * Playstyle > 6 -> this is an aggressive opening that is full of opening traps and tactics
   * Tactics >= 6 -> there are a lot of tactics involved, so players must be very good at tactics
   * Opening Theory > 3 -> there is some theory involved, but most of it depends on tactical knowledge
   * Intuition > 3 -> the player must have some intuition to play positions that go awry if their opponent declines the gambit
   * Positional Play >= 6 -> the player must be able to play positionally if they lose their attack or if the opponent declines the gambit
   */
   (and (white yes) (rating ?r & :(>= ?r 1300)) (playstyle ?p & :(> ?p 6)) (tactics ?t & :(>= ?t 6))
        (openingTheory ?o & :(> ?o 3)) (intuition ?i & :(> ?i 3)) (positionalPlay ?pl & :(>= ?pl 6)))
=>
   (newLine)

   (assert (opening "Evans Gambit"))
   (assert (openingMoves "1. e4 e5 2. Nf3 Nc6 3. Bc4 Bc5 4. b4"))
)

/*
* The Vienna Game is a fundamentally sound opening for White that follows
* the basic principles of opening play and is flexible for both aggressive
* and non-aggressive players.
*
* Competitive players playing the Vienna Game have a lot of flexibility with their play and can
* choose positional routes that lead to theoretical play or aggressive lines that involve a lot
* of tactics.
*/
(defrule viennaGame "This rule offers the Vienna Game"
   (not (openingFound yes))

   /*
   * Rating >= 1300 -> this opening is meant for intermediates and above, since there is a lot of positional play
   * Playstle <= 6 -> this isn't an aggressive opening and can lead to a lot of positional play that requires opening knowlege
   * Tactics >= 3 -> players must have some tactical knowledge to deal with the aggressive variations when necessary
   * Opening Theory > 3 -> players must have knowledge of some opening theory, as this opening has several different lines 
   * Intuition > 3 -> players must have some intuition to play in positions they are unfamiliar with
   * 1 <= Positional Play < 6 -> some variations require good positional play; however, it is not mandatory to be successful w/ this opening
   */
   (and (white yes) (rating ?r & :(>= ?r 1300)) (playstyle ?p & :(<= ?p 6)) (tactics ?t & :(>= ?t 3))
        (openingTheory ?o & :(> ?o 3)) (intuition ?i & :(> ?i 3)) (positionalPlay ?pl & :(and (>= ?pl 1) (< ?pl 6))))
=>
   (newLine)

   (assert (opening "Vienna Game"))
   (assert (openingMoves "1. e4 e5 2. Nc3"))
)

/*
* The Giuoco Piano is one of the oldest openings and can serve competitive players well
* if they know it. It follows basic fundamental principles and can transpose into aggressive
* lines that put pressure on the kingside. The most popular aggressive variation is the Evans Gambit.
* It can lead to gambits and tactical play, but most variations transpose into positional middlegames 
* that rely on positional play and piece coordination. 
*/
(defrule giuocoPiano "This rule offers the Giuoco Piano"
   (not (openingFound yes))

   /*
   * Rating >= 1300 -> this opening is meant for intermediates and above since there is a lot of theory behind it
   * Playstyle <= 6 -> this opening isn't aggressive, but it still can lead to aggressive lines
   * Tactics >= 3 -> some tactical knowledge is required to play tactical variations successfully
   * Opening Theory > 3 -> some theoretical knowledge is required, but it can be played mostly through positional play
   * Intuition > 3 -> intuition is needed to play unfamiliar positions as this is a very old opening
   * Positional Play >= 6 -> most lines in this opening are positional, so the player must have good positional sense
   */
   (and (white yes) (rating ?r & :(>= ?r 1300)) (playstyle ?p & :(<= ?p 6)) (tactics ?t & :(>= ?t 3))
        (openingTheory ?o & :(> ?o 3)) (intuition ?i & :(> ?i 3)) (positionalPlay ?pl & :(>= ?pl 6)))
=>
   (newLine)

   (assert (opening "Giuoco Piano"))
   (assert (openingMoves "1. e4 e5 2. Nf3 Nc6 3. Bc4 Bc5"))
)

/*
* The French Defense is a solid opening for black that counters White's
* presence in the center.
*
* This opening is good for casual players as there are several different lines
* the player can choose from, some of which lead to aggressive encounters and others
* which lead to positional play.
*
* This opening is good at all competitive levels, as different variations require
* different levels of knowledge. Some opening theory knowledge is required because
* a mishap can lead to an early blunder if the player isn't familiar with the opening.
*/
(defrule frenchDefense "This rule offers the French Defense"
   (not (openingFound yes))

   /*
   * Playstyle <= 3 -> this opening is non-aggressive
   * Opening Thoery > 3 -> some theoretical knowledge is required, but several variations can be played off intuition
   */
   (or (and (USCF no) (white no) (playstyle ?p & :(<= ?p 3)))
       (and (white no) (playstyle ?p & :(<= ?p 3)) (openingTheory ?o & :(> ?o 3))))
=>
   (newLine)

   (assert (opening "French Defense"))
   (assert (openingMoves "1. e4 e6"))
   (assert (variations yes))
)

/*
* The Sicilian Defense is the most popular black opening in response to 1. e4.
* It is played at all competitive levels, and can be the perfect opening for a 
* beginning casual player.
*
* For the casual player, the Sicilian Defense can lead to aggressive early games
* with a strong queenside attack, or positional games that develop pieces and transition
* to a solid middlegame.
*
* For competitive players, this opening is used at every level. Aggressive variations
* appeal to players who like tactical play and set opening traps that pressure
* the queenside. Other variations lead to more passive play that lead to positional middlegames
* revolving around a few pivotal squares in the center. This opening is great for players of all
* skills and can suit all playstyles, thus making it the most popular black opening.
*/
(defrule sicilianDefense "This rule offers the Sicilian Defense"
   (not (openingFound yes))

   /*
   * Playstyle > 3 -> this opening isn't passive or aggressive - several variations can lead to both possibilites
   * Tactics > 3 -> this opening has several tactics in different variations, so Black must be prepared
   * Opening Theory -> this opening has a lot of theory in certain variations, so Black must know some theory to be successful
   */
   (or (and (USCF no) (white no) (playstyle ?p & :(> ?p 3)))
       (and (white no) (playstyle ?p & :(> ?p 3)) (tactics ?t & :(> ?t 3))
            (openingTheory ?o & :(> ?o 3))))
=>
   (newLine)

   (assert (opening "Sicilian Defense"))
   (assert (openingMoves "1. e4 c5"))
   (assert (variations yes))
)

/*
* The Scandinavian Defense is a solid opening for black that counters the center.
* It is good at different skill levels for competitive players looking for a non-aggressive
* opening that may surprise their opponents.
*/
(defrule scandinavianDefense "This rule offers the Scandinavian Defense"
   (not (openingFound yes))

   /*
   * Playstyle <= 6 -> the Scandinavian Defense is a non-aggressive opening, but can lead to dynamic queenside play
   * Tactics >= 3 -> there are some tactics involved that can lead to early advantages for Black
   * 1 <= Opening Theory <= 3 -> there isn't much opening theory involved, but Black needs to be familiar with the basics to avoid blunders
   */
   (and (white no) (playstyle ?p & :(<= ?p 6)) (tactics ?t & :(>= ?t 3)) (openingTheory ?o & :(and (>= ?o 1) (<= ?o 3))))
=>
   (newLine)

   (assert (opening "Scandinavian Defense"))
   (assert (openingMoves "1. e4 d5"))
)

/*
* The Caro Kann is a robust black opening that has several different lines. It is known
* for transitioning into the end game and providing the Black with a solid chance for drawing
* or winning the positional endgame. It is an advanced opening (and one of my personal favorites)
* that requires positional knowledge, good intuition, and good tactical knowledge. Some variations
* can catch Black off guard if they are unfamiliar with it.
*/
(defrule caroKann "This rule offers the Caro Kann"
   (not (openingFound yes))

   /*
   * Rating >= 1300 -> this opening is meant for intermediates and above as there is a lot of positional play
   * Playstyle <= 6 -> this is a non-aggressive opening, but it can lead to some tactical play
   * Tactics >= 3 -> tactical knowledge can help Black secure an early advantage if the opponent blunders
   * Opening Theory > 3 -> opening theory knowledge is important for Black's success
   * Intuition > 3 -> some intuition is necessary to play into the middlegame
   * Positional Play > 3 -> some positional play is required if the opening transitions into a drawish middlegame
   */
   (and (white no) (rating ?r & :(>= ?r 1300)) (playstyle ?p & :(<= ?p 6)) (tactics ?t & :(>= ?t 3))
        (openingTheory ?o & :(> ?o 3)) (intuition ?i & :(> ?i 3)) (positionalPlay ?pl & :(> ?pl 3)))
=>
   (newLine)

   (assert (opening "Caro Kann"))
   (assert (openingMoves "1. e4 c6 2. d4 d5"))
   (assert (variations yes))
)








