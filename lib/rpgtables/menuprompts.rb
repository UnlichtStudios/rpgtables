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

  TABLENAMEPROMPT =
"Please enter a name for your table. Do not use '/ or '\\0'
in the title name: "

  def display_menu(title)
    puts "|--------------------------------------------------------|
|                                                        |
|" + "#{title} A Table.".center(56) + "|
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
|               7. Remove die from table.                |
|                                                        |
|               8. Remove all entries from the table.    |
|                                                        |
|               9. Reset the table.                      |
|                                                        |
|              10. Save table to disk.                   |
|                                                        |
|              11. Go back to main menu.                 |
|                                                        |
|              12. Exit RPGTables.                       |
|                                                        |
|________________________________________________________|"
end

  ADDDICEPROMPT =
"Please enter either a single die number, or a list of
dice separated by commas. ex. (6,12,20). Please note that
adding larger amounts of dice increases the calculation
time of the percentage curve. Its recommended to keep it
under 4 dice: "

  PROMPTERROR =
"Error! Not valid input!"

  CONTINUE =
"Please press enter to continue..."

  ADDENTRYPROMPT =
"Would you like to add an entry to the end of the table?
Or do you wish to insert an entry at a specific spot on
the table?

1) Add Entry
2) Insert Entry

Please enter a number: "

  POPENTRYPROMPT =
"Please type in the entry you wish to add: "

  TABLEERROR =
"Please add another die to the table before adding an entry."

  INSERTENTRYPOSPROMPT =
"Please enter the position on the table you wish to
insert your entry: "

  REMOVEENTRYPROMPT =
"Would you like to remove the last entry on the table? Or
would you like to remove an entry by number?

1) Remove Last Entry
2) Remove Entry by Index

Please enter a number: "

  ENTRYREMOVALPROMPT =
"Please input the entry number of the item you wish to remove: "

  REMOVEDIEENTRIESPROMPT =
"Please select a die to remove its entries:"

  REMOVEDIEPROMPT =
"Would you like to remove the last die from the table? Or
would you like to remove a specific die? WARNING! All
entries on the die will be removed! :

1) Remove Last Die
2) Remove Die by Index"

  SELECTDIETOREMOVEPROMPT =
"Please select a die to remove from the list: "

  RESETTABLEPROMPT =
"This will clear all entries from the table, but leave the dice.
Do you wish to do this?

1) Yes
2) No"

  CLEARTABLEPROMPT =
"This will completely erase the table, including all dice and
entries. Do you wish to do this?

1) Yes
2) No"

  SAVETABLEPROMPT =
"Please enter a name for the table: "

  VIEWTABLE =
"|------------------------------------------------------|
|                                                      |
|                    View Table Menu                   |
|                                                      |
|------------------------------------------------------|"

  VIEWTABLEMENU =
"|------------------------------------------------------|
|                                                      |
|               Select a choice from below!            |
|                                                      |
|------------------------------------------------------|
|                                                      |
|                    1) View Table                     |
|                                                      |
|                    2) Edit Table                     |
|                                                      |
|                    3) Delete Table                   |
|                                                      |
|                    4) Roll on a Table                |
|                                                      |
|                    5) Export Table                   |
|                                                      |
|                    6) Return to Main Menu            |
|                                                      |
|                    7) Exit Program                   |
|                                                      |
|------------------------------------------------------|"

  VIEWTABLEPROMPT =
"Please enter the number of the table you wish to view: "

  EDITTABLEPROMPT =
"Please enter the number of table you wish to edit: "

  DESTROYTABLEPROMPT =
"Please enter the number of the table you wish to delete: "

  ROLLTABLEPROMPT =
"Please enter the number of the table you wish to roll on: "

  EXPORTTABLEPROMPT =
"Please enter the number of the table you wish to print: "

end
