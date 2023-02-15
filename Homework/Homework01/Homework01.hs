
-- Question 1
-- Write a multiline comment below.
{-
Hello Haskell,
how are you?
-}

-- Question 2
-- Define a function that takes a value and multiplies it by 3.
multThree x = x * 3

-- Question 3
-- Define a function that calculates the area of a circle.
areaOfCircle diameter = pi * diameter

-- Question 4
-- Define a function that calculates the volume of a cylinder by composing the previous function together with the height of the cylinder. 
volumeOfCircle diameter height = areaOfCircle diameter * height

-- Question 5
-- Define a function that takes the height and radius of a cylinder and checks if the volume is greater than or equal to 42.
check42 diameter height = volumeOfCircle 5 5 > 42

