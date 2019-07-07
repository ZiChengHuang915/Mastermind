const ENTER_INSTRUCTIONS := 1
const ENTER_STARTGAMEONEPLAYER := 2
const ENTER_STARTGAMETWOPLAYER := 3
const ENTER_OPTIONS := 4

const RESTART := 1
const END_GAME := 2

% Procedure for instructions
procedure instructions
    put "Rules of the game: \n"
    put "1 player:"
    put "The computer randomly generates a code, and you have to solve it in a certain number of guesses."
    put "In each guess, enter the numbers that you think is correct, and the computer will give you feedback based on your guess."
    put "It will tell you the number of correct numbers in the right position."
    put "It will also tell you the number of correct numbers in the wrong position."
    put "You win if you guess the correct sequence of the code within the guesses allocated, and you will lose if you don't.\n"
    put "2 players:"
    put "The rules are the same, but the second player will put in his/her sequence instead of randomly generating it."
    put "Player 1 wins if he/she guesses the code within the guesses allocated, and Player 2 wins if he/she doesn't.\n"
    put "Press any key to continue!"
end instructions

% Menu variables
var chars : array char of boolean

var backToMenu : boolean := false
var menuInput : int := 1
var endInput : int := 1
var inputAnyKey : string % This is useless for any of the calculations

var youWin : boolean := false
var endGame : boolean := false

var loadXOne : int := 300
var loadYOne : int := 350
var loadXTwo : int := 301
var loadYTwo : int := 450

% Gameplay variables (Do not reset!)
const MINCOLORNUM := 1
const MAXCOLORNUM := 8

var twoPlayer : boolean := false

var codeLength : int := 4 %User input

var guessNum : int := 1
var guessMaxNum : int := 12 %User input

% Gameplay variables (Reset every guess)
var guessRightSoFar : boolean := true

var correctRightPosNum : int := 0
var correctWrongPosNum : int := 0

% Fonts and graphical
var fontTitle : int
var fontSub1 : int
var fontSub2 : int
var fontArrow : int
var fontEnd1 : int
var fontEnd2 : int
var fontEnd3 : int

fontTitle := Font.New ("sans serif:72:bold")
fontArrow := Font.New ("ar destine:40:bold")
fontSub1 := Font.New ("Palatino:40:bold")
fontSub2 := Font.New ("Palatino:30:bold")
fontEnd1 := Font.New ("sans serif:50:bold")
fontEnd2 := Font.New ("sans serif:40:bold")
fontEnd3 := Font.New ("sans serif:30:bold")

% Procedure for menu screen
procedure menu
    Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
    Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
    Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
    Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
    Font.Draw ("OPTIONS", 400, 100, fontSub2, 7)
end menu

% Procedure for end screen
procedure endScreen
    Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
    Font.Draw ("RESTART", 400, 320, fontSub2, 7)
    Font.Draw ("END GAME", 390, 220, fontSub2, 7)
end endScreen

% Procedure for menu arrow
procedure menuArrow
    if (menuInput = 1) then
	cls
	menu
	Font.Draw (">>>", 150, 400, fontArrow, 7)
    elsif (menuInput = 2) then
	cls
	menu
	Font.Draw (">>>", 150, 300, fontArrow, 7)
    elsif (menuInput = 3) then
	cls
	menu
	Font.Draw (">>>", 150, 200, fontArrow, 7)
    elsif (menuInput = 4) then
	cls
	menu
	Font.Draw (">>>", 150, 100, fontArrow, 7)
    end if
end menuArrow

% Procedure for end arrow
procedure endArrow
    if (endInput = 1) then
	cls
	endScreen
	Font.Draw (">>>", 150, 320, fontArrow, 7)
    elsif (endInput = 2) then
	cls
	endScreen
	Font.Draw (">>>", 150, 220, fontArrow, 7)
    end if
end endArrow

% Ending screen variables
var codeEndX : int := 510
var endBackScreenColor : int
var endTextColor : int

% Loop for the entire program (With restart)
loop

    setscreen ("graphics:1000;620")

    % Loading screen
    cls
    Font.Draw ("LOADING", 300, 250, fontTitle, 7)

    Draw.ThickLine (300, 350, 300, 450, 5, black)
    Draw.ThickLine (300, 350, 730, 350, 5, black)
    Draw.ThickLine (300, 450, 730, 450, 5, black)
    Draw.ThickLine (730, 350, 730, 450, 5, black)

    loop
	Draw.FillBox (loadXOne, loadYOne, loadXTwo, loadYTwo, black)
	loadXOne := loadXTwo
	loadXTwo := loadXTwo + 1
	delay (3)

	exit when loadXTwo >= 730
    end loop

    %Resetting variables
    loadXOne := 300
    loadXTwo := 301

    cls

    % Menu
    menu

    % Current option is 1
    Font.Draw (">>>", 150, 400, fontArrow, 7)

    menuInput := 1
    % Finding out the player option
    loop

	% Getting input from keyboard
	Input.KeyDown (chars)

	% Going up
	if chars (KEY_UP_ARROW) then
	    if (menuInput = 1) then
	    else
		menuInput := menuInput - 1
	    end if
	    menuArrow
	    delay (100)
	end if

	% Going down
	if chars (KEY_DOWN_ARROW) then
	    if (menuInput = 4) then
	    else
		menuInput := menuInput + 1
	    end if
	    menuArrow
	    delay (100)
	end if

	exit when chars (KEY_ENTER)
    end loop

    loop
	if (menuInput = ENTER_INSTRUCTIONS) then
	    % Goes to instructions then back to menu
	    cls
	    instructions

	    get inputAnyKey
	    cls
	    backToMenu := true
	elsif (menuInput = ENTER_STARTGAMEONEPLAYER) then
	    % Does not need to go to instructions, will continue to game
	    twoPlayer := false
	    backToMenu := false
	elsif (menuInput = ENTER_STARTGAMETWOPLAYER) then
	    % Does not need to go to instructions, will continue to game
	    twoPlayer := true
	    backToMenu := false
	elsif (menuInput = ENTER_OPTIONS) then
	    % Goes to options then back to menu
	    cls

	    % Set the number of guesses allowed
	    put "Set the number of guesses! " ..
	    get guessMaxNum

	    % Set the code length
	    cls
	    put "Set the code length! " ..
	    get codeLength

	    backToMenu := true
	end if

	exit when (backToMenu or backToMenu = false)
    end loop

    if (backToMenu = false) then

	var answer : array 1 .. codeLength of int
	var answerTaken : array 1 .. codeLength of boolean
	var guessTaken : array 1 .. codeLength of boolean
	var guess : array 1 .. codeLength of int

	% Resets variables
	for i : 1 .. codeLength
	    guess (i) := 0
	    answerTaken (i) := false
	    guessTaken (i) := false
	end for

	cls % To start game (Game starts here)

	% Random code generation
	if (twoPlayer = false) then
	    for i : 1 .. codeLength
		randint (answer (i), MINCOLORNUM, MAXCOLORNUM)
	    end for
	else
	    put "Player 2 please enter the code: "

	    for i : 1 .. codeLength
		loop
		    put "Enter number ", i, ": " ..
		    get answer (i)
		    exit when (answer (i) >= MINCOLORNUM and answer (i) <= MAXCOLORNUM)
		    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
		end loop
	    end for

	end if

	%Debug (Erase later)
	for i : 1 .. codeLength
	    put answer (i), "" ..
	end for

	% Initializes the variables so that they have a value
	for i : 1 .. codeLength
	    answerTaken (i) := false
	    guessTaken (i) := false
	end for

	loop

	    put "\nThis is guess #", guessNum, ":"
	    put "*****************************"

	    % Takes in guesses and checks for invalid input
	    for i : 1 .. codeLength
		loop
		    put "Guess number ", i, ": " ..
		    get guess (i)

		    exit when (guess (i) >= MINCOLORNUM and guess (i) <= MAXCOLORNUM)
		    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
		end loop
	    end for

	    % Loops and checks if all answers are right so far
	    for i : 1 .. codeLength
		if (guess (i) = answer (i)) then
		    guessRightSoFar := true
		else
		    guessRightSoFar := false
		    exit
		end if
	    end for

	    % If all answers are right, win. Else, continue with guessing and responding
	    if (guessRightSoFar) then
		youWin := true
		guessNum := guessMaxNum
	    else
		youWin := false
	    end if

	    if (youWin = false) then

		% Correct number correct position
		for i : 1 .. codeLength
		    if (answer (i) = guess (i)) then
			correctRightPosNum := correctRightPosNum + 1
			answerTaken (i) := true
			guessTaken (i) := true
		    end if
		end for

		% Correct number wrong position
		for i : 1 .. codeLength
		    if (guessTaken (i) = false) then
			for j : 1 .. codeLength
			    if (answerTaken (j) = false) then
				if (j not= i) then
				    if (guess (i) = answer (j)) then
					if (guessTaken (i) = false and answerTaken (j) = false) then
					    correctWrongPosNum := correctWrongPosNum + 1
					    answerTaken (j) := true
					    guessTaken (i) := true
					end if
				    end if
				end if
			    end if
			end for
		    end if
		end for

		put "The number of correct numbers in the right position: ", correctRightPosNum
		put "The number of correct numbers in the wrong position: ", correctWrongPosNum, " \n"

	    end if

	    guessNum := guessNum + 1

	    % Resetting the variables
	    for i : 1 .. codeLength
		guess (i) := 0
		answerTaken (i) := false
		guessTaken (i) := false
	    end for

	    correctRightPosNum := 0
	    correctWrongPosNum := 0

	    exit when guessNum > guessMaxNum
	end loop

	% Ending screen
	for decreasing i : 31 .. 16
	    endBackScreenColor := i
	    drawfillbox (0, 0, maxx, maxy, endBackScreenColor)
	    delay (50)
	end for

	if (youWin) then
	    if (twoPlayer = false) then
		for i : 16 .. 31
		    endTextColor := i
		    Font.Draw ("YOU WIN", 345, 310, fontEnd1, endTextColor)
		    delay (50)
		end for
	    else
		for i : 16 .. 31
		    endTextColor := i
		    Font.Draw ("PLAYER 1 WIN", 260, 310, fontEnd1, endTextColor)
		    delay (50)
		end for
	    end if
	else
	    if (twoPlayer = false) then
		for i : 16 .. 31
		    endTextColor := i
		    Font.Draw ("YOU LOSE: ALL GUESSES USED", 80, 400, fontEnd2, endTextColor)
		    delay (50)
		end for
	    else
		for i : 16 .. 31
		    endTextColor := i
		    Font.Draw ("PLAYER 2 WIN", 260, 400, fontEnd1, endTextColor)
		    delay (50)
		end for
	    end if
	    delay (1000)

	    for i : 16 .. 31
		endTextColor := i
		Font.Draw ("CODE: ", 330, 300, fontEnd3, endTextColor)
		delay (50)
	    end for

	    for i : 1 .. codeLength
		var answerTemp : string
		answerTemp := intstr (answer (i))
		Font.Draw (answerTemp, codeEndX, 300, fontEnd3, white)
		codeEndX := codeEndX + 50
		delay (500)
	    end for
	end if

	delay (2000)

	for i : 16 .. 31
	    endBackScreenColor := i
	    drawfillbox (0, 0, maxx, maxy, endBackScreenColor)
	    delay (50)
	end for

	% Restart or end game
	endScreen
	Font.Draw (">>>", 150, 320, fontArrow, 7)

	% Finding out the player option
	loop

	    % Getting input from keyboard
	    Input.KeyDown (chars)

	    % Going up
	    if chars (KEY_UP_ARROW) then
		if (endInput = 1) then
		else
		    endInput := endInput - 1
		end if
		endArrow
		delay (100)
	    end if

	    % Going down
	    if chars (KEY_DOWN_ARROW) then
		if (endInput = 2) then
		else
		    endInput := endInput + 1
		end if
		endArrow
		delay (100)
	    end if

	    exit when chars (KEY_ENTER)
	end loop

	if (endInput = 1) then
	    endGame := false
	    cls
	else
	    endGame := true
	end if

	% Resetting variables
	menuInput := 1
	codeEndX := 510
	endInput := 1

    end if
    exit when endGame
end loop

cls
