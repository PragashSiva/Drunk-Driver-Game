%Elisha Ratnarajah
%Pragash Sivasundaram


%June 8th 2012

%The variables (explained in detail at the bottom)
var lane1, lane2, lane3, laneCord1, laneCord2, laneCord3, level : int
var crash, score, delayy, carThrust, carDig : int := 0
var x, y1, buttonX, x2, y2, x3, y3, buttonY, button : int
var chars : array char of boolean
var carCord : int := 210
var probability : int
var yCord : int := 0
var highScore : int := 0

%Variable Explanation
%lane1,lane2,lane3 = they are three random values for the lanes selection.
%laneCord1, laneCord2, laneCord3 = they are the cordinates in which the incoming cars will be randomly put on.
%level = this variable is to first take  the level according to the score and then to outup the delay.
%carCord =  this is the cordinate of the car
%highScore = keeps track of the highest score in one session

%picture of the Green car
setscreen ("offscreenonly")

var pic1 : int := Pic.FileNew ("green.jpg")
if pic1 = 0 then
    put "Unable to load JPEG: ", Error.LastMsg
    return
end if

%The picture of the Red car
var pic2 : int := Pic.FileNew ("red.jpg")
if pic2 = 0 then
    put "Unable to load JPEG: ", Error.LastMsg
    return
end if

%The picture of the road-side tree
var pic3 : int := Pic.FileNew ("tree100.jpg")
if pic3 = 0 then
    put "Unable to load JPEG: ", Error.LastMsg
    return
end if

%The picture of the road sign
var pic4 : int := Pic.FileNew ("sign.jpg")
if pic4 = 0 then
    put "Unable to load JPEG: ", Error.LastMsg
    return
end if

%The picture of the Mainmenu background
var menu : int := Pic.FileNew ("Menu.jpg")
if menu = 0 then
    put "Unable to load JPEG: ", Error.LastMsg
    return
end if



%The Instructions
procedure instructions
    colourback (120)
    colour (0)
    View.Update
    cls
    put "********************************* INSTRUCTIONS ********************************"
    put ""
    put "1. Your car is the red car near the bottom of the screen"
    put ""
    put "2. Use the keys 1, 2 and 3 on your keyboard (in the Number pad) to move the car"
    put "           1 => Moves the car to the far left lane"
    put "           2 => Moves the car to the center lane"
    put "           3 => Moves the car tothe far right lane"
    put ""
    put "3. Avoid the oncoming traffic of green cars"
    put ""
    put "4. BEWARE: The speed of the oncoming cars increase and get more daring the"
    put "    longer you stay on the road without crashing"
    put ""
    put "5. Game will be over once you crash"
    put ""
    put "6. Enjoy the game, and drive safe!"
    View.Update
    delay (2000)
end instructions

%The Credits
procedure credits
    colourback (0)
    colour (7)
    View.Update
    cls
    locatexy (200, 300)
    put "By Elisha and Pragash"
end credits



%The game
procedure game

    %Loop for the replay
    loop
	Music.PlayFile ("carstart.wav")
	Music.PlayFileLoop ("bgmusic.mp3")
	score := 0
	delayy := 0
	crash := 0

	%Loop for the immediate game
	loop


	    randomize
	    randint (lane1, 1, 3)
	    randint (lane2, 1, 3)
	    randint (lane3, 1, 3)


	    case lane1 of
		label 1 :
		    laneCord1 := 210
		label 2 :
		    laneCord1 := 260
		label 3 :
		    laneCord1 := 310
	    end case
	    case lane2 of
		label 1 :
		    laneCord2 := 210
		label 2 :
		    laneCord2 := 260
		label 3 :
		    laneCord2 := 310
	    end case
	    case lane3 of
		label 1 :
		    laneCord3 := 210
		label 2 :
		    laneCord3 := 260
		label 3 :
		    laneCord3 := 310
	    end case

	    if laneCord1 not= laneCord2 and laneCord2 not= laneCord3 then
		laneCord1 := 210
		laneCord2 := 210
		laneCord3 := 210
	    end if

	    randomize
	    randint (probability, 0, 1)

	    for decreasing y : 450 .. -10


		colourback (2)
		colour (0)


		score := score + 1
		put ""
		put "  Score:", score


		%Level Up  Speed Increase
		if score >= 0 then
		    delayy := 6
		    level := 1
		end if
		if score >= 2000 then
		    delayy := 5
		    level := 2
		end if
		if score >= 4000 then
		    delayy := 4
		    level := 3
		end if
		if score >= 6000 then
		    delayy := 3
		    level := 4
		end if
		if score >= 10000 then
		    delayy := 2
		    level := 5
		end if
		if score >= 17000 then
		    delayy := 1
		    level := 6
		end if

		put "  Level: ", level
		delay (delayy)

		%Draws partial white
		drawfillbox (200, 350, 350, 400, 0)

		Pic.Draw (pic2, carCord - 7, 20, picCopy)

		%Draws the road
		drawfillbox (195, 0, 200, 500, 7)
		drawfillbox (249, 0, 251, 500, 7)
		drawfillbox (299, 0, 301, 500, 7)
		drawfillbox (350, 0, 355, 500, 7)

		%draws trees

		if probability = 1 then
		    if laneCord1 = 210 then
			Pic.Draw (pic3, 100, y - 100, picCopy)
		    end if
		    if laneCord3 = 310 then
			Pic.Draw (pic3, 400, y - 100, picCopy)
		    end if
		end if

		%draws signs
		if probability = 1 then
		    if laneCord1 = 260 then
			Pic.Draw (pic4, 400, y - 100, picCopy)
		    end if
		end if


		%Draws the incomming cars
		Pic.Draw (pic1, laneCord1 - 6, y - 80, picCopy)
		Pic.Draw (pic1, laneCord2 - 6, y - 80, picCopy)
		Pic.Draw (pic1, laneCord3 - 6, y - 80, picCopy)


		View.Update
		cls

		%bg of the road
		drawfillbox (200, 0, 350, 500, 0)


		%Controller 4 button
		Input.KeyDown (chars)

		if chars ('1') then
		    carDig := 0
		elsif chars ('2') then
		    carDig := 1
		elsif chars ('3') then
		    carDig := 2
		end if


		case carDig of
		    label 0 :
			carCord := 210
		    label 1 :
			carCord := 260
		    label 2 :
			carCord := 310
		    label :
			carCord := carCord
		end case
		if carCord = laneCord1 and y < 180 and y > 50 or carCord = laneCord2 and y < 180 and y > 50 or carCord = laneCord3 and y < 180 and y > 50 then
		    crash := 1
		    exit when true
		end if

	    end for
	    exit when crash = 1
	end loop


	%When charshed, the crash screen
	drawfillbox (0, 0, 700, 400, 2)
	put "**************************** YOU HAVE CRASHED *********************************"
	put ""
	put "   CURRENT PLAYER"
	put "   Your score was: ", score
	put "   Your level was: ", level


	%Displays the highscore and saves it
	if highScore < score then
	    highScore := score
	end if
	put "   The temperarory highscore is: ", highScore

	locate (20, 2)

	put ""
	put ""
	put "                    REPLAY                      MENU"
	drawbox (125, 35, 250, 75, 7)
	drawbox (340, 35, 465, 75, 7)
	View.Update

	%Submenu inside the game to avoid escaping the procedure 'game'
	%Gives the same options as the beginning mainmenu
	loop
	    Mouse.Where (x2, y2, button)
	    if x2 > 125 and y2 > 20 and x2 < 250 and y2 < 60 and button = 1 then
		game
		exit when button = 1
	    elsif button = 1 and x2 > 340 and y2 > 20 and x < 465 and y2 < 60 then
		buttonX := 1
		exit when true
	    end if
	end loop
	exit when buttonX = 1
    end loop

    loop
	Pic.Draw (menu, 0, 0, picCopy)
	Mouse.Where (x, y1, button)
	View.Update
	Music.PlayFileStop
	if x > 10 and y1 > 130 and x < 220 and y1 < 200 and button = 1 then
	    game
	    exit when true
	end if

	if x > 10 and y1 > 100 and x < 220 and y1 < 130 and button = 1 then
	    instructions


	    exit when true
	end if

	if x > 10 and y1 > 50 and x < 220 and y1 < 90 and button = 1 then
	    credits

	    exit when true

	end if
    end loop
end game


%The beginning Mainmenu to start off the game
%Declared at the very end as the procedures 'game,' 'instructions,' and 'credits' need to be declared above
loop
    Pic.Draw (menu, 0, 0, picCopy)
    Mouse.Where (x, y1, button)
    View.Update


    if x > 10 and y1 > 130 and x < 220 and y1 < 200 and button = 1 then
	game
	exit when true
    end if

    if x > 10 and y1 > 90 and x < 220 and y1 < 130 and button = 1 then
	instructions
	exit when true
    end if

    if x > 10 and y1 > 50 and x < 220 and y1 < 90 and button = 1 then
	credits
	exit when true
    end if
end loop



