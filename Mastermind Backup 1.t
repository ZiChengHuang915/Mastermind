const ENTER_INSTRUCTIONS := 1
const ENTER_STARTGAMEONEPLAYER := 2
const ENTER_STARTGAMETWOPLAYER := 3

% Menu variables
var chars : array char of boolean

var menuInput : int := 1
var goToInstructions : boolean := false
var goToStartGame : boolean := false
var inputAnyKey : string % This is useless for any of the calculations

var youWin : boolean := false
var endGame : boolean := false

% Gameplay variables (Do not reset!)
const MINCOLORNUM := 1
const MAXCOLORNUM := 8

var twoPlayer : boolean := false

var guessNum : int := 1
var guessMaxNum : int

var answer1 : int
var answer2 : int
var answer3 : int
var answer4 : int

% Gameplay variables (Reset every guess)
var guess1 : int
var guess2 : int
var guess3 : int
var guess4 : int

% Gameplay variables (Reset every guess)
var answer1Taken : boolean := false
var answer2Taken : boolean := false
var answer3Taken : boolean := false
var answer4Taken : boolean := false
var guess1Taken : boolean := false
var guess2Taken : boolean := false
var guess3Taken : boolean := false
var guess4Taken : boolean := false


% Gameplay variables (Reset every guess)
var correctRightPosNum : int := 0
var correctWrongPosNum : int := 0

% Fonts and graphical
var fontTitle : int
var fontSub1 : int
var fontSub2 : int
var fontArrow : int

fontTitle := Font.New ("ar destine:72:bold")
fontArrow := Font.New ("ar destine:40:bold")
fontSub1 := Font.New ("Palatino:40:bold")
fontSub2 := Font.New ("Palatino:30:bold")

% Loop for the entire program (With restart)
loop

    setscreen ("graphics:1000;620")

    for i : 1 .. 1
	Font.Draw ("LOADING.", 310, 350, fontTitle, 7)
	delay (300)
	cls
	Font.Draw ("LOADING..", 310, 350, fontTitle, 7)
	delay (300)
	cls
	Font.Draw ("LOADING...", 310, 350, fontTitle, 7)
	delay (300)
	cls
    end for

    % Menu items
    Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
    Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
    Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
    Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)

    % Current option is 1
    Font.Draw (">>>", 150, 400, fontArrow, 7)

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

	    if (menuInput = 1) then
		cls
		Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
		Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
		Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
		Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
		Font.Draw (">>>", 150, 400, fontArrow, 7)
	    elsif (menuInput = 2) then
		cls
		Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
		Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
		Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
		Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
		Font.Draw (">>>", 150, 300, fontArrow, 7)
	    else
		cls
		Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
		Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
		Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
		Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
		Font.Draw (">>>", 150, 200, fontArrow, 7)
	    end if
	    delay (100)
	end if

	% Going down
	if chars (KEY_DOWN_ARROW) then
	    if (menuInput = 3) then
	    else
		menuInput := menuInput + 1
	    end if

	    if (menuInput = 1) then
		cls
		Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
		Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
		Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
		Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
		Font.Draw (">>>", 150, 400, fontArrow, 7)
	    elsif (menuInput = 2) then
		cls
		Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
		Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
		Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
		Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
		Font.Draw (">>>", 150, 300, fontArrow, 7)
	    else
		cls
		Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
		Font.Draw ("INSTRUCTIONS", 350, 400, fontSub2, 7)
		Font.Draw ("ONE PLAYER", 370, 300, fontSub2, 7)
		Font.Draw ("TWO PLAYER", 367, 200, fontSub2, 7)
		Font.Draw (">>>", 150, 200, fontArrow, 7)
	    end if
	    delay (100)
	end if

	exit when chars (KEY_ENTER)
    end loop

    loop
	if (menuInput = ENTER_INSTRUCTIONS) then
	    % Goes to instructions first before entering game
	    goToInstructions := true
	elsif (menuInput = ENTER_STARTGAMEONEPLAYER) then
	    % Does not need to go to instructions, will continue to game
	    goToStartGame := true
	elsif (menuInput = ENTER_STARTGAMETWOPLAYER) then
	    % Does not need to go to instructions, will continue to game
	    goToStartGame := true
	    twoPlayer := true
	end if

	exit when (goToInstructions or goToStartGame)
    end loop

    if (goToInstructions = true) then

	cls
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
	put "Press any key to cotinue!"

	get inputAnyKey
	cls
    end if

    % Set the number of guesses allowed
    cls
    put "Set the number of guesses! " ..
    get guessMaxNum

    cls % To start game (Game starts here)

    % Random code generation
    if (twoPlayer = false) then
	randint (answer1, MINCOLORNUM, MAXCOLORNUM)
	randint (answer2, MINCOLORNUM, MAXCOLORNUM)
	randint (answer3, MINCOLORNUM, MAXCOLORNUM)
	randint (answer4, MINCOLORNUM, MAXCOLORNUM)
    else
	put "Player 2 please enter the code: "

	loop
	    put "Enter the first number: " ..
	    get answer1
	    exit when (answer1 >= MINCOLORNUM and answer1 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	loop
	    put "Enter the second number: " ..
	    get answer2
	    exit when (answer2 >= MINCOLORNUM and answer2 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	loop
	    put "Enter the third number: " ..
	    get answer3
	    exit when (answer3 >= MINCOLORNUM and answer3 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	loop
	    put "Enter the fourth number: " ..
	    get answer4
	    exit when (answer4 >= MINCOLORNUM and answer4 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

    end if

    %Debug (Erase later)
    put answer1, answer2, answer3, answer4

    loop

	put "This is guess #", guessNum, ":"
	put "*****************************"

	% Checks for invalid input
	loop
	    put "Guess the first number: " ..
	    get guess1

	    exit when (guess1 >= MINCOLORNUM and guess1 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	loop
	    put "Guess the second number: " ..
	    get guess2

	    exit when (guess2 >= MINCOLORNUM and guess2 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	loop
	    put "Guess the third number: " ..
	    get guess3

	    exit when (guess3 >= MINCOLORNUM and guess3 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	loop
	    put "Guess the fourth number: " ..
	    get guess4

	    exit when (guess4 >= MINCOLORNUM and guess4 <= MAXCOLORNUM)
	    put "Invalid input! Type a number between ", MINCOLORNUM, " and ", MAXCOLORNUM
	end loop

	% Gets the right guess
	if (guess1 = answer1 and guess2 = answer2 and guess3 = answer3 and guess4 = answer4) then
	    youWin := true
	    guessNum := guessMaxNum
	end if

	if (youWin = false) then

	    if (answer1 = guess1) then
		correctRightPosNum := correctRightPosNum + 1
		answer1Taken := true
		guess1Taken := true
	    end if
	    if (answer2 = guess2) then
		correctRightPosNum := correctRightPosNum + 1
		answer2Taken := true
		guess2Taken := true
	    end if
	    if (answer3 = guess3) then
		correctRightPosNum := correctRightPosNum + 1
		answer3Taken := true
		guess3Taken := true
	    end if
	    if (answer4 = guess4) then
		correctRightPosNum := correctRightPosNum + 1
		answer4Taken := true
		guess4Taken := true
	    end if

	    if (answer1Taken = false) then

		if (guess2 = answer1) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess3 = answer1) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess4 = answer1) then
		    correctWrongPosNum := correctWrongPosNum + 1
		end if

	    end if

	    if (answer2Taken = false) then

		if (guess1 = answer2 and guess1Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess3 = answer2 and guess3Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess4 = answer2 and guess4Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		end if

	    end if

	    if (answer3Taken = false and guess3Taken = false) then

		if (guess1 = answer3 and guess1Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess2 = answer3 and guess2Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess4 = answer3 and guess4Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		end if

	    end if

	    if (answer4Taken = false and guess4Taken = false) then

		if (guess1 = answer4 and guess1Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess2 = answer4 and guess2Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		elsif (guess3 = answer4 and guess3Taken = false) then
		    correctWrongPosNum := correctWrongPosNum + 1
		end if

	    end if

	    put "The number of correct numbers in the right position: ", correctRightPosNum
	    put "The number of correct numbers in the wrong position: ", correctWrongPosNum, " \n"

	end if

	guessNum := guessNum + 1

	% Resetting the variables
	guess1 := 0
	guess2 := 0
	guess3 := 0
	guess4 := 0

	answer1Taken := false
	answer2Taken := false
	answer3Taken := false
	answer4Taken := false
	guess1Taken := false
	guess2Taken := false
	guess3Taken := false
	guess4Taken := false

	correctRightPosNum := 0
	correctWrongPosNum := 0

	exit when guessNum > guessMaxNum
    end loop

    if (youWin) then
	cls
	if (twoPlayer = false) then
	    put "You've won!"
	else
	    put "Player 1 has won!"
	end if
    else
	cls
	if (twoPlayer = false) then
	    put "You've lost! You used all your guesses!"
	else
	    put "Player 2 has won!"
	end if
	put "The correct code is: "
	put answer1, answer2, answer3, answer4
    end if

    put "Do you wish to play again?"
    put "Press 1 for restart, 2 for end game!"
    get inputAnyKey

    if (inputAnyKey = "1") then
	endGame := false
	cls
    else
	endGame := true
    end if

    exit when endGame
end loop
