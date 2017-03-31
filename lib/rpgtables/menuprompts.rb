# menuprompts.rb
#
# Copyright 2017 (c) Scott Isenberg
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module MenuPrompts

  MAINMENU =
"|--------------------------------------------------------|
|                                                        |
|                 Welcome to RPGTables!                  |
|                                                        |
|          Please select a choice from below!            |
|                                                        |
|--------------------------------------------------------|
|                                                        |
|               1. Create a table.                       |
|                                                        |
|               2. View created tables.                  |
|                                                        |
|               3. Exit program.                         |
|                                                        |
|________________________________________________________|"

  INPUTPROMPT = "Please enter a number: "
  INPUTERROR =
"|--------------------------------------------------------|
|                                                        |
|              Not a valid menu selection!               |
|                                                        |
|--------------------------------------------------------|"

  CREATETABLEMENU =
"|--------------------------------------------------------|
|                                                        |
|                     Create A Table                     |
|          Please select a choice from below!            |
|                                                        |
|--------------------------------------------------------|
|                                                        |
|               1. Add dice to the table.                |
|                                                        |
|               2. Add an entry to the table.            |
|                                                        |
|               3. View the table.                       |
|                                                        |
|               4. Test a roll on the table.             |
|                                                        |
|               5. Remove an entry from the table.       |
|                                                        |
|               6. Remove all entries from a die.        |
|                                                        |
|               7. Remove all entries from the table.    |
|                                                        |
|               8. Reset the table.                      |
|                                                        |
|               9. Save table to disk.                   |
|                                                        |
|              10. Go back to main menu.                 |
|                                                        |
|              11. Exit RPGTables.                       |
|                                                        |
|________________________________________________________|"

  ADDDICEPROMPT =
"Please enter either a single die number, or a list of
dice separated by commas. ex. (6,12,20): "

  DICEINPUTERROR =
"Error! Not valid input!
"

  CONTINUE =
"Please press enter to continue..."

end
