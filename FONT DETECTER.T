%Screen is set to large because then you can scroll. 
var fontName : string 
var y : int := 0 
var font : int 
var winID : int := Window.Open ("graphics:1280;1280") 
Font.StartName 
loop 
    fontName := Font.GetName 
    exit when fontName = "" 
    font := Font.New (fontName + ":12") 
    y += 20 
    Font.Draw (fontName, 100, 10 + y, font, black) 
end loop 
