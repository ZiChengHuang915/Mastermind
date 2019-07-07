setscreen ("graphics:1000;620")

var fontTitle : int := Font.New ("sans serif:72:bold")
var fontSub1 : int := Font.New ("Palatino:40:bold")
var fontSub2 : int := Font.New ("Palatino:30:bold")
var fontArrow : int := Font.New ("ar destine:40:bold")
var fontEnd1 : int := Font.New ("sans serif:50:bold")
var fontEnd2 : int := Font.New ("sans serif:40:bold")
var fontEnd3 : int := Font.New ("sans serif:30:bold")
var fontGuess : int := Font.New ("sans serif:30:bold")


Font.Draw ("MASTERMIND", 190, 500, fontTitle, 7)
Font.Draw ("RESTART", 400, 320, fontSub2, 7)
Font.Draw ("END GAME", 390, 220, fontSub2, 7)

var x, y, buttonnumber, buttonupdown, buttons : int

loop
    buttonwait ("down", x, y, buttonnumber, buttonupdown)
    put "(", x, ",", y, ")"
end loop
