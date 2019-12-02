/*
* Shafieen Ibrahim
* 11/12/18
*
* This program will help players choose their openings, for white or black,
* based on their skill level/rating, playing style, knowledge level, and 
* opening experience. Major categories of openings are classified by the
* first move. This expert system covers openings that have the first moves
* 1. e4 or 1. c4. The system uses forward chaining to assert facts
* relating to the player's skill/habits, such as their playstyle, tactical
* knowledge, knowledge of opening theory, strength of intuition, etc.
*
* 1. d4 openings are excluded because there are a lengthy amount and would be too
* ambitious for this single system. Another entire system could be created for white
* and black openings revolving around 1. d4.
*
* To make the most out of this system, answer questions honestly and to the best of
* your ability. This system is designed for users who are familiar with the game of
* chess and have played in some games before. Competitive experience is not required,
* but the user should be familiar with the basics of chess, including how the pieces
* move, how the game ends (check, checkmate, stalemate), and some basic opening rules.
*
* For competitive skill levels, this system is best suited for beginners and intermediate
* players. Advanced players (rating > 1700) find little use in these systems as they are
* already familiar with a variety of openings and variations and don't need help in
* finding new ones. Thus, this system evaluates advanced players the same as it does 
* for intermediate players.
*
* play ()
* Call this function to run the program.
*
* assertValue (?question ?fact ?questionType ?$range)
* This function takes care of the assertions for the different facts
* of the characteristics of the user's playstyle. This function takes
* in a set of parameters at the end in case the system asks the user
* a type of question that involves parameters, such as asking the user
* to input an integer that is within a certain range.
*
* makeAssertion (?fact ?validation)
* This function uses the (assert-str) function to dynamically assert the facts
* about the user's playstyle and tendencies. The user's response after being
* validated are asserted using this function.
*
*/

(batch code/openings.clp)   ; batch in all the openings
(batch code/variations.clp) ; batch in the variations
(batch code/userInput.clp)  ; batch in user input functions
(batch code/validate.clp)   ; batch in validate functions
(batch code/misc.clp)       ; batch in different utility functions

/************************************************************************************************************************
* These are functions that maintain the user interface.
/************************************************************************************************************************

/*
* This function resets before batching in the file so that the file
* only needs to be batched in once. Call this function to run the program
* after batching in for the first time.
*/
(deffunction play ()
   (clear)
   (reset)

   (batch code/chess.clp)

   (run)

   (return)
)

/*
* This function takes care of the actions necessary when asserting a fact.
* It then retrieves the user's validated response to the question and calls 
* a function to assert that fact appropriately, passing in the fact and the user's
* validated response. This function also takes in an integer value, the question
* type, to determine what type of question is being asked. A Yes/No question will be 
* type 1, and type 2 is a question that requires certain integer value within a range.
*
* This function is the first time the magic numbers 1 and 2 are used. These
* numbers are used again when the system asks the user different questions and
* asserts the responses as facts. 1 represents the first question type (Y/N),
* and 2 represents the second question type (integer within a given range).
*
* This system doesn't allow a ? response because the questions are very
* direct and straightforward and require a yes/no response. All the questions
* can be answered with yes or no, or an integer if needed, and every Y/N question
* can be clearly answered with yes or no.
*
* Precondition:
* The type of question (1, 2) must be known in advance and the appropriate
* parameters must be input if the question requires it. The $?range list should
* consist of the lower limit and upper limit for the range. At least 2 integers 
* must be entered, and they cannot equal each other.
*
* args:
* ?question - the question the system will ask the user
* ?fact - the fact to be asserted
* ?questionType - an integer value that determines what type of question is being asked
* 	   1: Yes/No, 2: integer response
* $?range - question type 2 requires a range (2 integers)
*/
(deffunction assertValue (?question ?fact ?questionType $?range)
   (if (= ?questionType "1") then
      (bind ?validation (validateAnswerYN ?question))
   else
      (bind ?lowLimit (minList ?range))   ; extract the lowest integer from the list
      (bind ?upperLimit (maxList ?range)) ; extract the largest integer from the list
      (bind ?validation (validateAnswerInteger ?question ?lowLimit ?upperLimit))
   )

   (makeAssertion ?fact ?validation)

   (return)
)

/*
* This function takes in a fact and the value for the fact and asserts
* it.
*
* args:
* ?fact - the fact to be asserted
* ?validation - this is the parsed response the user has given to the question (yes, no, idk)
*/
(deffunction makeAssertion (?fact ?validation)
   (bind ?assertStr "")
   (bind ?assertStr (str-cat "(" ?assertStr ?fact))

   (assert-string (str-cat ?assertStr " " ?validation ")")) ; assert the fact w/ the user's input (that has been validated)

   (return)
)

/************************************************************************************************************************
* These are rules that explain the instructions for the system.
/************************************************************************************************************************

/*
* The startup rule introduces the user interface and what the system is going to do.
* The types of questions that will be asked pertain to the personailty of the player and how
* it affects their chess games, ie: playstyle, tactical knowledge, opening knowledge, etc. Other questions
* pertain to the player's knowledge, such as intuition strength and positional game sense.
*
* This rule also asks the first main question the system needs, which is whether or not the
* user has an official USCF rating. USCF is the United States Chess Federation, and every
* official chess player that is registered with USCF and has a USCF membership will have
* a rating that numerically represents their skill level relative to all the other USCF players.
* This is the first question as it is an important qualifier that divides the user into
* two distinct categories: competitive players and casual players.
*/

(defrule init "This rule introduces the UI, explains how to use the system, and asks the first question"
=>
   (println "Welcome! If you are here, you want to expand your opening repertoire.")
   (println "This system will ask you questions to find you an opening suited for you.")
   (println "The critera includes your playstyle, your USCF rating (if you have one), your pace, and more.")
   (println "Among different openings, the system will also provide different variations.")
   (newLine)

   (println "Some questions will require a yes or no (Y/N), and other questions may require integer responses.")
   (println "Answer honestly and to the best of your ability to get the most out of this system.")
   (newLine)

   (println "USCF is the United States Chess Federation. Registering with USCF and obtaining")
   (println "an official membership will give you an official USCF rating that numerically")
   (println "represents your skill level relative to other players. If you have played in an")
   (println "official USCF tournament, you will have a USCF rating.")
   (newLine)

   /*
   * Since this is a Y/N question, question type 1 is used here. This is the first instance 1 is used, and it is
   * used numerous times throughout this file whenever the system asks a Y/N question.
   */
   (assertValue "Are you USCF rated" USCF 1) ; players know if they are officially registered with USCF
)



/************************************************************************************************************************
* These are rules that pertain to players (typically beginners) that are not official competitive
* playeres registered with USCF.
/************************************************************************************************************************

/*
* This rule begins the calibration for a non-competitive, beginner chess player. Since they
* don't play competitively, the system must determine whether or not the player is a casual
* player or an absolute beginner who is still learning the basics of chess.
*/
(defrule newPlayer "This rule begins assessing new players that don't have a USCF rating"
   (USCF no)
=>
   (newLine)
   (println "I see you are a new player! Welcome to the world of chess!")
   (println "Before we dive into finding suitable openings, do you know the basics of chess?")
   (newLine)

   (assertValue "Do you know the basic rules of chess (check, checkmate, stalemate)" basicRules 1)
)

/*
* This rule fires if the user doesn't know the basic rules of chess, such as check, checkmate
* or stalemate. This rule will explain those rules in a few sentences and assert the askBasics
* fact to signal to the system to continue asking the user questions about the basics of chess
* to assess their knowledge of the game.
*/
(defrule teachBasicRules "This rule teaches the player the basic rules of chess"
   (basicRules no)
=>
   (newLine)
   (println "When a piece attacks the enemy king, it is called \"check.\"")
   (println "To block a check, a player can block it, capture the piece, or move the king out of danger.")
   (println "If a player cannot stop a check using those 3 methods, it is called checkmate and the player loses.")
   (println "If a player cannot move any pieces legally on their turn and they are not in check, it is stalemate")
   (println "and the game ends in a draw.")
   (newLine)

   (assert (askBasics)) ; asserting this fact will continue to ask the user basic questions about chess
)

/*
* This rule fires if the user indicates that they do know the basics of chess (check, checkmate, stalemate).
* This rule will assert the askBasics fact to signal to the system to continue asking the user questions about
* the basics of chess to assess their knowledge of the game.
*/
(defrule knowsBasicRules "This rule asserts the askBasics fact if the user knows the basic rules"
   (basicRules yes)
=>
   (assert (askBasics))
)

/*
* This rule checks if the user has answered previous question about the basic rules (check, checkmate, stalemate)
* and fires if the user has answered yes or no.
*/
(defrule askNotation "This rule asks the player if they know how chess notation works"
   (basicRules ?x)    ; has the user responded to the previous question
   ?f1 <- (askBasics)
=>
   (retract ?f1) ; retract the fact so that the other question rules don't fire immediately

   (assertValue "Do you know what chess notation is (e4, Nxc6, etc)" notation 1) ; continue with the next question
)

/*
* This rule fires if the user doesn't know what chess notation is. This rule will explain chess
* notation in a few sentences and assert the askBasics fact to signal to the system to continue
* asking the user questions about the basics of chess to assess their knowledge of the game.
*/
(defrule teachNotation "This rule teaches the player about chess notation"
   (notation no)
=>
   (newLine)
   (println "Notation is how moves are written down in chess. Notation like e4 represents the square e4 on the board.")
   (println "If the notation only consists of the square, it means a pawn has moved to that square. If there is another")
   (println "letter in front, such as Qe4, that represents a different piece moving to the square e4. Q represents queen, ")
   (println "K represents king, R represents rook, N represents knight, and B represents bishop. If there is notation like")
   (println "dxe4, that means that piece, a pawn, has captured whatever piece was on e4. Qxc6 means the queen captured a piece")
   (println "on the c6 square.")
   (newLine)

   (assert (askBasics))
)

/*
* This rule fires if the user indicates that they do know chess notation. This rule will assert
* the askBasics fact to signal to the system to continue asking the user questions about the basics
* of chess to assess their knowledge of the game.
*/
(defrule knowsNotation "This rule asserts the askBasics fact if the user knows notation"
   (notation yes)
=>
   (assert (askBasics))
)

/*
* This rule checks if the user has answered previous question about chess notation and fires if
* the user has answered yes or no.
*/
(defrule askOpenings "This rule asks the player if they know about chess openings"
   (notation ?x)
   ?f1 <- (askBasics)
=>
   (retract ?f1)

   (assertValue "Do you you know what openings are" knowOpenings 1)
)

/*
* This rule fires if the user doesn't know what openings are. This rule will explain chess openings
* in a few sentences and assert the askBasics fact to complete (assert (askBasics complete)) to signal
* to the system that it is done asking the user questions about the basic rules of chess and how the game
* works.
*/
(defrule teachOpening "This rule teaches the players the ideas about openings"
   (knowOpenings no)
=>
   (newLine)
   (println "Openings typically constitute the first 5-10 moves of the game.")
   (println "Openings, for white or black, can be passive or aggressive. A good opening can give a player the")
   (println "advantage going into the middlegame and endgame.")
   (println "Openings may have traps, tactics, and gambits to give an early advantage.")
   (println "Openings also develop pieces and create a solid position to transition into the middlegame.")

  (assert (askBasics complete))
)

/*
* This rule fires if the user indicates that they do know about chess openings. This rule will assert
* the (askBasics complete) fact to signal to the system that it is done asking the user questions about
* the basic rule sof chess and how the game works.
*/
(defrule knowOpenings "This rule asserts the (askBasics complete) fact if the user knows about openings"
   (knowOpenings yes)
=>
   (assert (askBasics complete))
)

/*
* This rule fires once the basics of chess has been covered. For casual players, they should start at the
* beginning with the easiest opening. Only 2 questions are asked to determine what color opening the user wants
* and how aggressive their playstyle is. The system recommends a basic opening for them based off their answers
* to these two questions.
*/
(defrule beginnerCasual "This rule calibrates casual players"
   (askBasics complete)
=>
   (newLine)
   (println "Okay! You know enough about chess to go and play your first game (if you haven't before).")
   (println "Finding an opening you like and mastering it is crucial to your success on the chess board.")
   (println "Famous chess player Bobby Fischer once said \"e4 is best by test.\" For new players, it is")
   (println "best to start with 1. e4.")
   (newLine)

   (assertValue "Are you looking for a white opening" white 1)

   /*
   * Since this question requires an integer on a scale from 1 - 10, question type 2 is used. This is the first
   * instance 2 is used and it is used numerous times throughout this file for questions that require an integer
   * response between a range of 2 integers. 1 and 10 represent the bounds of the user's response - they cannot go
   * lower than 1 or higher than 10.
   */
   (assertValue "How aggressive is your playstyle (1 is very passive, and 10 is very aggressive)" playstyle 2 1 10)
)

/*
* In this rule, the user is asked about their USCF rating so that the system
* guage the player's competitive skill level. 
* 
* Two magic numbers, 100 and 2800, are used here to represent the bounds for 
* competitive chess ratings. 100 is the lowest threshold for a competitive player 
* who has never won a game. 2800 represents the grandmaster level; while it's possible 
* for a player to have a rating higher than 2800, it is unlikely that they would use 
* this system since they would be at the level of a world champion.
*/
(defrule playerRating "This rule asks for the user's USCF rating and determines their skill level"
   (USCF yes)
=>
   (newLine)
   (println "I see you are a competitive chess player! I hope I can provide you with an advantage in your future games.")
   (println "To guage your knowledge and experience, I need to ask a few more questions.")
   (newLine)
   (assertValue "What is your USCF rating (100 - 2800)" rating 2 100 2800) ; only instance 100 and 2800 are used
)

/************************************************************************************************************************
* These are rules that pertain to competitive players that are officially registered with USCF.
/************************************************************************************************************************

/*
* This rule is designed for beginner competitive players and asks them a series of questions
* to gauge their playstyle and habits. This rule asks the player questions about
*
* Playstyle, knowledge of tactics, knowledge of opening theory
*/
(defrule beginner "This rule is for beginners (rating < 1300)"
   (rating ?r & : (< ?r 1300))
=>
   (newLine)
   (println "I see you are a beginner. Welcome!")
   (println "I will ask you a few questions about your playstyle and tendencies to recommend a suitable opening.")
   (newLine)

   /*
   * These rules ask the user their strengths in certain aspects of chess on a range from 1 - 10.
   * These two numbers represent the limits for the user's answer, with 1 being the lowest and 10
   * being the highest.
   */
   (assertValue "Are you looking for a white opening" white 1)
   (assertValue "How aggressive is your playstyle (1 is very passive, and 10 is very aggressive)" playstyle 2 1 10)
   (assertValue "How strong are your tactics (1 is very weak, and 10 is very strong)" tactics 2 1 10)
   (assertValue "How familiar are you with opening theory (1 is very unfamiliar, 10 is very familiar)" openingTheory 2 1 10)
)

/*
* This rule is designed for intermediate competitive players and asks them a series of
* questions to gauge their playstyle and habits. This rule asks the player questions about:
*
* Playstyle, knowledge of tactics, knowledge of opening theory, intuition strength, strength at positional play
*/
(defrule intermediate "This rule is for intermediates (1300 <= rating < 1700)"
   (rating ?r & : (and (>= ?r 1300) (< ?r 1700)))
=>
   (newLine)
   (println "I see you are an intermediate player. Welcome!")
   (println "I will ask you a few questions about your playstyle and tendencies to recommend a suitable opening.")
   (newLine)

   /*
   * These rules ask the user their strengths in certain aspects of chess on a range from 1 - 10.
   * These two numbers represent the limits for the user's answer, with 1 being the lowest and 10
   * being the highest.
   */
   (assertValue "Are you looking for a white opening" white 1)
   (assertValue "How aggressive is your playstyle (1 is very passive, and 10 is very aggressive)" playstyle 2 1 10)
   (assertValue "How strong are your tactics (1 is very weak, and 10 is very strong)" tactics 2 1 10)
   (assertValue "How familiar are you with opening theory (1 is very unfamiliar, 10 is very familiar)" openingTheory 2 1 10)
   (assertValue "How strong is your intuition (1 is very weak, 10 is very strong)" intuition 2 1 10)
   (assertValue "How strong are you at positional play (1 is very weak, 10 is very strong)" positionalPlay 2 1 10)
)

/*
* This rule evaluates advanced players (rating >= 1700) the same way it does for intermediate
* players. Advanced players will find little benefit using this system as they are already
* predisposed to a number of white and black openings and have familiarity and experience with
* several openings. Thus, this system will attempt to recommend a suitable opening for the advanced
* player based off his/her answers to the questions, but the system may not accurately or reliably advise
* the advanced player on which opening to choose, as there are a considerable number of factors to consider
* such as competitive experience, openings played, ELO, and more.
*/
(defrule advanced "This rule is for advanced players (rating >= 1800)"
   (rating ?r & : (>= ?r 1700))
=>
   (println "I see you are an advanced player! Maybe you can teach me a thing or two?")
   (println "Because your knowledge most likely exceeds mine, I probably won't be of much use for you.")
   (println "I will ask you the same questions as I would to an intermediate player to find a ")
   (println "suitable opening, because I am not designed for such high caliber players.")
   (newLine)

   /*
   * These rules ask the user their strengths in certain aspects of chess on a range from 1 - 10.
   * These two numbers represent the limits for the user's answer, with 1 being the lowest and 10
   * being the highest.
   */
   (assertValue "Are you looking for a white opening" white 1)
   (assertValue "How aggressive is your playstyle (1 is very passive, and 10 is very aggressive)" playstyle 2 1 10)
   (assertValue "How strong are your tactics (1 is very weak, and 10 is very strong)" tactics 2 1 10)
   (assertValue "How familiar are you with opening theory (1 is very unfamiliar, 10 is very familiar)" openingTheory 2 1 10)
   (assertValue "How strong is your intuition (1 is very weak, 10 is very strong" intuition 2 1 10)
   (assertValue "How strong are you at positional play (1 is very weak, 10 is very strong)" positionalPlay 2 1 10)
)

/*
* These next to rules handle the case when the opening is found and asserted, or if the system
* could not find a suitable opening for the player based off his/her answers to the questions asked.
*/
(defrule openingFound "This rule describes the opening that the system has prescribed for the player"
   (opening ?o) (openingMoves ?m)
=>
   (println "The opening I have found for you is the " ?o ".")
   (newLine)
   (println ?m)
   (assert (openingFound yes))
)

/*
* The salience is declared to -100 so that the rule is put on the agenda
* but it fires when no other rules are left to fire. It then checks if no
* opening has been asserted yet and prints the appropriate concluding message.
*/
(defrule noOpeningFound "This rule fires when the user's evaluation cannot lead to an opening"
   (declare (salience -100))
   (not (opening ?o))
=>
   (newLine)
   (println "Based off your criteria and evaluation, I could not find a suitable opening.")
   (println "Please try again and slightly adjust your answers, or go out and practice some more!")
   (halt)
)


