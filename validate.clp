/*
* Shafieen Ibrahim
* 9/13/18
*
* This is a toolbox for various validate functions.
*
* validateStr (?token)
* This function validates if the parameter is a token.
*
* validateStrLength (?token ?length)
* This function validates if the given token's length is equal to 
* the number in the second parameter.
*
* validateLengthLimit (?token ?maxLength)
* This function verifies if the length of the passed in token
* is within the maxLength limit that is passed in as the second
* parameter.
*
* validateAnswer (?input)
* This function validates the user's response to see if the first
* character corresponds to acceptable responses of "y", "n", or "?".
*
* validateAnswerYN (?input)
* This function validates the user's response to see if the first
* character corresponds to acceptable responses of "y" or "n".
*
* validateAnswerInteger (?input)
* This function validates the user's response to see if the first
* character corresponds to acceptable responses of an integer within
* the given range.
*
* validateResponse (?input)
* This function parses the user's response and returns
* whether or not it parses to an acceptable response of "y",
* "n", or "?".
*
* validateResponseYN (?input)
* This function parses the user's response and returns
* whether or not it parses to an acceptable response of "y"
* or "n".
*
* validateResponseInteger (?input ?lowLimit ?upperLimit)
* This function parses the user's response and returns
* whether or not it parses to an acceptable response of an
* integer within the given range.
*
*/


/*
* This function verifies if the parameter is a token or not.
*
* args:
* ?token - the value the user has input
*
* returns TRUE if the user input is a token or FALSE if the user input is not a token
*/
(deffunction validateStr (?token)
   return (stringp ?token)
)

/*
* This function verifies whether the token length is equal to the length
* passed in the second parameter.
*
* args:
* ?token - the token the user has input
* ?length - the length of the token to be checked
*
* Precondition: ?token is a token and ?length is an integer
*
* returns TRUE if the length of ?token equal to ?length or FALSE if the length of ?token is not equal to ?length
*/
(deffunction validateStrLength (?token ?length)
   return (= (str-length ?token) ?length)

)

/*
* This function verifies whether the token length is longer than
* the length passed in the second parameter.
*
* args:
* ?token - the token the user has input
* ?maxLength - the limit that the token length should not exceed
*
* Precondition: ?token is a token and ?maxLength is an integer
*
* returns TRUE if the length of ?token does not exceed ?maxLength and FALSE if otherwise
*/
(deffunction validateLengthLimit (?token ?maxLength)
   (return (<= (str-length ?token) ?maxLength))
)

/*
* This function validates the user's input to a question asked. If the user has
* input a value that doesn't parse to a "y", "n", or "?", the function will prompt
* the user to give a valid input.
*
* args:
* ?question - the question the system will ask the user
*
* returns yes if the answer is yes, no if the answer is no, and idk if the user is unsure of the answer.
*/
(deffunction validateAnswer (?question)
   (bind ?response "a")                            ; start with an invalid input
   (bind ?wrongInputs 0)                           ; counter to keep track of how many wrong inputs the user has input
   (bind ?validation (validateResponse ?response)) ; determine the current validation of the user's input (yes, no, idk, or none of the above)  

   /*
   * If the user's response is still invalid, the program will continuously
   * prompt the user with the question until a valid response is given.
   */
   (while (eq ?validation "invalid")
      (if (> ?wrongInputs 0) then
         (println "Invalid input. Your response must start with y, n, or ?.")
      )

      (++ ?wrongInputs)

      (bind ?response (askQuestion ?question))        ; retrieve the user's next input
      (bind ?validation (validateResponse ?response)) ; determine if the user has input a valid response
   )

   (return ?validation)
)

/*
* This function validates the user's input to a question asked. If the user has
* input a value that doesn't parse to a "y" or "n", the function will prompt
* the user to give a valid input. This function is identical to the
* validateAnswer function, but this function is to be used only for questions
* that require a Yes/No response and cannot accept an "I don't know" response.
*
* args:
* ?question - the question the system will ask the user
*
* returns yes if the answer is yes and no if the answer is no.
*/
(deffunction validateAnswerYN (?question)
   (bind ?response "a")                              ; start with an invalid input
   (bind ?wrongInputs 0)                             ; counter to keep track of how many wrong inputs the user has input
   (bind ?validation (validateResponseYN ?response)) ; determine the current validation of the user's input (yes, no, idk, or none of the above)  

   /*
   * If the user's response is still invalid, the program will continuously
   * prompt the user with the question until a valid response is given.
   */
   (while (eq ?validation "invalid")
      (if (> ?wrongInputs 0) then
         (println "Invalid input. Your response must start with y or n.")
      )

      (++ ?wrongInputs)

      (bind ?response (askQuestion ?question))          ; retrieve the user's next input
      (bind ?validation (validateResponseYN ?response)) ; determine if the user has input a valid response
   )

   (return ?validation)
)

/*
* This function validates the user's input to a question asked. If the user has
* input a value that doesn't equate to an integer that is wihtin the range, the
* function will prompt the user to give a valid integer within the range. Also,
* if the user doesn't input an integer, the function will prompt the user to 
* give a valid integer within the range.
*
* args:
* ?question - the question the system will ask the user
* ?lowLimit - the lower limit
* ?upperLimit - the upper limit
*
* returns yes if the answer is yes and no if the answer is no.
*/
(deffunction validateAnswerInteger (?question ?lowLimit ?upperLimit)
   (bind ?response "a")
   (bind ?wrongInputs 0)
   (bind ?validation (validateResponseInteger ?response ?lowLimit ?upperLimit))

   /*
   * If the user's response is still invalid, the program will continuously
   * prompt the user with the question until a valid response is given.
   */
   (while (eq ?validation "invalid")
      (if (> ?wrongInputs 0) then
         (println "Invalid input. Your response must be a valid integer within the range.")
      )

      (++ ?wrongInputs)

      (bind ?response (askQuestion ?question))                                     ; retrieve the user's next input
      (bind ?validation (validateResponseInteger ?response ?lowLimit ?upperLimit)) ; determine if input is valid
   )
   

   (return ?validation)
)

/*
* This function validates the user's response by checking if the first
* letter starts with "Y", "N", or "?". Only these three responses are 
* acceptable responses for the system.
*
* args:
* ?input - the answer the user has input
*
* returns yes if the answer begins with "Y", no if the answer begins with "N", and
* idk if the answer begins with "?"
*/
(deffunction validateResponse (?input)
   (bind ?input (lowcase ?input))              ; turn the entire input into lowercase letters to make it case-insensitive
   (bind ?firstLetter (sub-string 1 1 ?input)) ; retrieve the first letter of the user's answer
   (bind ?validation "")

   (if (eq ?firstLetter "y") then
      (bind ?validation yes)
   else
      (if (eq ?firstLetter "n") then
         (bind ?validation no)
      else
         (if (eq ?firstLetter "?") then
            (bind ?validation idk)
         else
            (bind ?validation "invalid")
         )
      )
   )

   (return ?validation)
)

/*
* This function validates the user's response by checking if the first
* letter starts with "Y" or "N". Only these two responses are 
* acceptable responses for this question type. This function is identical to the
* validateResponse function, but this function is to be used only for questions
* that require a Yes/No response and cannot accept an "I don't know" response.
*
* args:
* ?input - the answer the user has input
*
* returns yes if the answer begins with "Y" and no if the answer begins with "N"
*/
(deffunction validateResponseYN (?input)
   (bind ?input (lowcase ?input))              ; turn the entire input into lowercase letters to make it case-insensitive
   (bind ?firstLetter (sub-string 1 1 ?input)) ; retrieve the first letter of the user's answer
   (bind ?validation "")

   (if (eq ?firstLetter "y") then
      (bind ?validation yes)
   else
      (if (eq ?firstLetter "n") then
         (bind ?validation no)
      else
         (bind ?validation "invalid")
      )
   )

   (return ?validation)
)

/*
* This function validates the user's response by if the user's input
* is an integer that is within the range given by the two parameters.
*
* args:
* ?input - the answer the user has input
* ?lowLimit - the lower limit the input must be greater than or equal to
* ?upperLimit - the upper limit the input must be less than or equal to
*
* returns the integer if the input is valid; otherwise, returns "invalid"
*/
(deffunction validateResponseInteger (?input ?lowLimit ?upperLimit)
   (bind ?validation "invalid")

   (if (integerp ?input) then
      (if (and (>= ?input ?lowLimit) (<= ?input ?upperLimit)) then
         (bind ?validation ?input)
      )
   )

   (return ?validation)
)



