/*
* Shafieen Ibrahim
* 9/13/18
*
* This is a toolbox for various user input functions.
*
* prompt (?prompt ?ending)
* This function prompts the user with a statement and stores the input.
*
* (askQuestion ?question)
* This function asks the user the question that is passed into the program.
* 
*/

/*
* This function prompts the user with a statement and ends
* with the chosen punctuation (?, !, :, etc) and stores the input.
*
* args:
* ?prompt - the user gives a question to be asked
* ?ending - the punctuation at the end of the prompt, such as ?, !, :, ., etc
*/
(deffunction prompt (?prompt ?ending)
   (printout t ?prompt ?ending)       ; print out the prompt with the punctuation
   (bind ?response (read))            ; stores the user's input into a variable
   (return ?response)
)

/*
* This function will prompt the user with a question.
*
* args:
* ?question - the question the system will ask the user
*
* returns the YES/NO answer to the question
*/
(deffunction askQuestion (?question)
   (bind ?answer (prompt ?question "? "))
   (return ?answer)
)