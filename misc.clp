/*
* Shafieen Ibrahim
* 10/7/18
*
* This file contains various useful functions.
*
* println ($?args)
* This function prints out a line containing all the arguments passed.
*
* newLine ()
* This function prints out a new line.
*
* minList (?list)
* This function returns the minimum integer from a list of integers that is passed in.
*
* maxList (?list)
* This function returns the maximum integer from a list of integers that is passed in.
*/

/*
* This function takes in a list of arguments and prints out each one on the same line.
*
* args:
* $?args - the list of arguments to be printed out
*/
(deffunction println ($?args)
   (foreach ?text $?args (printout t ?text))
   (printout t crlf)
   (return)
)

/*
* This function prints a new, empty line.
*/
(deffunction newLine ()
   (println)
   (return)
)

/*
* This function finds and returns the minimum value in a list of integers.
*
* Precondition:
* The list contains only integers.
*
* args:
* ?list - the list of integers passed in
*/
(deffunction minList (?list)
   (bind ?minVal (first$ ?list))

   /*
   * Go through each value in the list and find the minimum value by comparing
   * the current value to the next value in the list.
   */
   (for (bind ?i 1) (< ?i (length$ ?list)) (++ ?i)
      (bind ?temp ?i)
      (bind ?minVal (min (nth$ ?i ?list) (nth$ (++ ?temp) ?list))) ; compare the current value to the next value in the list
   )
   (return ?minVal)
)

/*
* This function finds and returns the maximum value in a list of integers.
*
* Precondition:
* The list contains only integers.
*
* args:
* ?list - the list of integers passed in
*/
(deffunction maxList (?list)
   (bind ?maxVal (first$ ?list))

   /*
   * Go through each value in the list and find the maximum value by comparing
   * the current value to the next value in the list.
   */
   (for (bind ?i 1) (< ?i (length$ ?list)) (++ ?i)
      (bind ?temp ?i)
      (bind ?maxVal (max (nth$ ?i ?list) (nth$ (++ ?temp) ?list))) ; compare the current value to the next value in the list
   )
   (return ?maxVal)
)