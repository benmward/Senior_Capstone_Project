// create the person
instance_create(128,392,obj_man);

// time for 30 steps
cnt = 0;

//game over timer
gmovtimer = 0;

//if game is over, this is 1
global.gameover = 0;
global.gosignal = 0;

//rock cooldown
rockcd = 0;

//falling cooldown
fallingcd = 0;

// danger variable for sounds
danger = 0;

// diffuse var
diffuse = 0;
diffcount = 20;
