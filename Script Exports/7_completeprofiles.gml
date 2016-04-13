#define scr_init
// Randomize the game seed
randomize();

// Menu Vars
global.esc_time = 0;
ini_open("moneta_memory_suite_data.ini");
global.user = ini_read_string('MONETA','USER','JackSparrow');
global.togsfx = ini_read_real('SETTINGS','TOGSFX',1);
ini_close();
global.userini = string(string_lower(global.user)) + "_data.ini";

// Test Score Vars
global.attnscore = 0;
global.memscore = 0;
global.spatscore = 0;

// Game Score Vars
global.attngamescore = 0;
global.memgamescore = 0;

// other vars
global.gameover = 0;
global.gosignal = 0;

// Score loggin numbers, numb = numb of previous scores
ini_open(string(global.userini));
global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
global.attngamenumb = ini_read_real('ATTNGAME','NUMB',0);
ini_close();
//not ready yet
global.memgamenumb = 0;
global.spattestnumb = 0;

#define scr_menureturn
// Go back to menu
room_goto(rm_menu);

#define scr_escape
// User needs to hold escape
if (keyboard_check(vk_escape)){
    global.esc_time += 1;
}else{
    global.esc_time = 0;
}

// If escape held for ~1 second
if (global.esc_time >= 40){
    // stop sound and return to menu
    global.esc_time = 0;
    audio_stop_all();
    room_goto(rm_menu);
}

#define scr_startbgmusic
// Start the appropriate background music depending on room

    // Create the appropriate room control object
    if (room == rm_basicattn){
            audio_play_sound(snd_thinking, 0, true);
        }
        
    if (room == rm_basicmem){
            audio_play_sound(snd_entropy, 0, true);
        }
        
    if (room == rm_basicspat){
           // audio_play_sound(snd_thinking, 0, true);
        }
        
    if (room == rm_gameattn){
            audio_play_sound(snd_rush, 0, true);
        }
        
    if (room == rm_gamemem){
           // audio_play_sound(snd_thinking, 0, true);
        }
        
    if (room == rm_progress){
           // audio_play_sound(snd_thinking, 0, true);
        }
        
    if (room == rm_custom){
           // audio_play_sound(snd_thinking, 0, true);
        }
        
    if (room == rm_settings){
           // audio_play_sound(snd_thinking, 0, true);
        }

#define scr_stopbgmusic
// Add all bg music here.
audio_stop_sound(snd_start);
audio_stop_sound(snd_boop);
audio_stop_sound(snd_thinking);
audio_stop_sound(snd_entropy);
audio_stop_sound(snd_hype);
audio_stop_sound(snd_rush);
audio_stop_sound(snd_phonevib);
audio_stop_sound(snd_phonering);
audio_stop_sound(snd_deathwarn);
audio_stop_sound(snd_comingsoon);
audio_stop_sound(snd_settings);
audio_stop_sound(snd_progress);
audio_stop_sound(snd_effon);
audio_stop_sound(snd_effoff);

#define scr_stepcloud
// Regenerate cloud
if (self.x <= -300){
    self.x = 1524;
    self.y = irandom_range(-60,128);
    image_alpha = random_range(0.3,0.7);
}

#define scr_createcloud
image_alpha = random_range(0.3,0.7);
hspeed = -12;

#define scr_creategrass
hspeed = -8;

#define scr_stepgrass
if (self.x == -32){
    self.x = 1024;
}

#define scr_createattngame
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

#define scr_stepattngame
// Attention Game

if (global.gameover == 0){
    // Constantly increment cnt with room steps
    cnt ++;

    // If there has been 1 second of real time
    if (cnt == 30){
        //Increment score
        global.attngamescore += 1;
        // Reset cnt to 0.
        cnt = 0;
    }

    // Set danger to 1 when deathwarn plays
    if(audio_is_playing(snd_deathwarn)){
        danger = 1;
    }
    
    if (diffuse = 1){
        if(diffcount > 0){
            diffcount --;
        }
    }
    
    if(diffcount == 0){
        diffuse = 0;
        diffcount = 20;
    }
    
    // If danger is playing
    if( danger == 1){
        // if space pressed during sound
        if(audio_is_playing(snd_deathwarn)){
            if(keyboard_check(vk_space)){
                danger = 0;
                audio_stop_sound(snd_deathwarn);
                if(!(audio_is_playing(snd_diffuse))){
                    audio_play_sound(snd_diffuse, 1, false);
                    // 10 pnts for bomb diffuse
                    global.attngamescore += 10;
                }
                diffuse = 1;
            }
        }
        
        // if time runs out
        if(!(audio_is_playing(snd_deathwarn)) && (diffuse = 0)){
            instance_create(0,0,obj_explode);
            audio_play_sound(snd_explosion, 1, false);
            //game over
            global.gosignal = 1;
        }
        
    }
    
    // If danger is NOT playing
    if( (danger == 0) && (diffuse == 0) && keyboard_check(vk_space)){
            instance_create(0,0,obj_explode);
            audio_play_sound(snd_explosion, 1, false);
            // game over
            global.gosignal = 1;
        }

    // Generate phone sound randomly if not playing sound
    if (irandom_range(1, 180) == 2){
    
        // Generate death threat
        if (irandom_range(1, 2) == 2){
            if(!(audio_is_playing(snd_phonevib) || audio_is_playing(snd_phonering) || audio_is_playing(snd_deathwarn))){
                audio_play_sound(snd_deathwarn, 1, false);
            }
        }else{
        // Make sure audio currently isn't playing
            if(!(audio_is_playing(snd_phonevib) || audio_is_playing(snd_phonering) || audio_is_playing(snd_deathwarn))){
                scr_phonesound();
            }
        }
    }
    
    
    if(rockcd < 50){
        rockcd++;
    }
    
    // Generate rocks
    if (rockcd == 50){
        if (irandom_range(1,75) == 74){
            // reset rock cd
            rockcd = 0;
            
            //spawn a rock
            instance_create(1170, 364, obj_rock);
        }
    }
    
    if(fallingcd < 15){
        fallingcd++;
    }
    
    // Generate rocks
    if (fallingcd == 15){
        if (irandom_range(1,30) == 29){
            // reset rock cd
            fallingcd = 0;
            
            //spawn a rock
            instance_create(irandom_range(-80,1104), -130, obj_falling);
        }
    }
    
    
}else{
    // If the game is over
    gmovtimer++;
    // Wait a bit then end
    if (gmovtimer >= 60){
        //reset
        global.gameover = 0;
        
        // Save the Attn game score
        ini_open(string(global.userini));
        // Get the previous number
        global.attngamenumb = ini_read_real('ATTNGAME','NUMB',0);
        // Increment by 1
        global.attngamenumb = global.attngamenumb + 1;
        // Write new number
        ini_write_real('ATTNGAME','NUMB',global.attngamenumb);
        // Write the score
        ini_write_real('ATTNGAME',string(global.attngamenumb),(global.attngamescore));
        // Get highscore
        var hiattngame = ini_read_real('ATTNGAME','HIGHSCORE',0);
        // If new score is higher, write new highscore
        if(global.attngamescore > hiattngame){
            ini_write_real('ATTNGAME','HIGHSCORE',(global.attngamescore));
        }
        // Close ini file
        ini_close();
        
        // Play game over sound
        audio_play_sound(snd_gameover, 1, false);
        // Return to menu
        scr_menureturn();
    }
}

#define scr_drawattngame
// Attention Game Draw Script

#define scr_drawattngamescore
// draws progress
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_set_font(ft_basic22);
draw_text(512,8,"Score: " + string(global.attngamescore));

#define scr_createman


#define scr_stepman
if(global.gosignal == 1){
    //reset
    global.gosignal = 0;
    //gameover
    scr_gameover();
}

if place_free(x,y + 1){
    gravity = 1;
}
else {
    gravity = 0;
    vspeed = 0;
}

//Gravity direction
gravity_direction = 270;

// Cap vspeed
if (vspeed > 26){
    vspeed = 26;
}

// Controls
if(self.x < 1008){
    if (keyboard_check(vk_right) && place_free(x + 8,y)){
        x += 8;
        sprite_index = spr_man;
    }
}
if(self.x > 16){
    if (keyboard_check(vk_left) && place_free(x - 8,y)){
        x -= 8;
        sprite_index = spr_manl;
    }
}
if (keyboard_check(vk_up) && !place_free(x,y + 1)){
    vspeed -= 16;
}

if ((vspeed > 0) && (!place_free(x,y + vspeed))){
    move_contact(270);
}

if(keyboard_check_released(vk_left)){
    sprite_index = spr_man;
}

#define scr_stepdeadman
// Make swaying effect
gravity = 0;
dircnt++;

if((dircnt >= 18) && (chngdir == 0)){
    dircnt = 0;
    chngdir = 1;
}

if((dircnt >= 18) && (chngdir == 1)){
    dircnt = 0;
    chngdir = 0;
}

if (chngdir == 0){
    hspeed = 1.5;
}else{
    hspeed = -1.5;
}

#define scr_createdeadman
y = (self.y - 16);
image_alpha = 0.6;
vspeed = -4;
hspeed = 1.5;
// For swaying effect
chngdir = 0;
dircnt = 0;

#define scr_phonesound
// Randomly play phone ring or vibrate
if (irandom_range(1,2) == 1){
    audio_play_sound(snd_phonevib, 1, false);
}else{
    audio_play_sound(snd_phonering, 1, false);
}

#define scr_gameover
// Save score

// Stop the bg music
scr_stopbgmusic();

// Set gameover to 1
global.gameover = 1;

// Change instance of object into dead
instance_create(self.x,self.y,obj_deadman);
instance_destroy();

#define scr_createrock
hspeed = -12;

#define scr_steprock
if(self.x <= -160){
    instance_destroy();
}

#define scr_ouch
// Play ouch
audio_play_sound(snd_ouch, 1, false);

#define scr_destexplode
instance_destroy();

#define scr_createexplode
image_alpha = 0.7;

#define scr_stepfalling
// fall faster
vspeed += 0.25;

if(self.y >= 744){
    instance_destroy();
}

#define scr_createfalling
vspeed = 1;

#define scr_createtimeremain
if(room == rm_basicattn){
// Start with 64 seconds of test time - Extra 2 seconds for prep time
totaltime = 64;
testtime = 64;
}

if(room == rm_basicmem){
totaltime = 124;
testtime = 124;
}

// Count variable for steps
cnt = 0;



#define scr_steptimeremain
// Creates appropriate object for the room after the countdown is over
// cnt counts the current step
// 30 steps == 1 second

// Constantly increment cnt with room steps
cnt ++;

// If there has been 1 second of real time
if (cnt == 30){
    // Take a second off of the test time
    testtime--;
    // Reset cnt to 0.
    cnt = 0;
}

// If out of time
if (testtime == 0){
    // Save the score in the ini file
    if(room == rm_basicattn){
        // open user's save file
        ini_open(string(global.userini));
        // Get the previous number
        global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
        // Increment by 1
        global.attntestnumb = global.attntestnumb + 1;
        // Write new number
        ini_write_real('BASICATTN','NUMB',global.attntestnumb);
        // Write the score
        ini_write_real('BASICATTN',string(global.attntestnumb),(global.attnscore));
        // Get highscore
        var hiattn = ini_read_real('BASICATTN','HIGHSCORE',0);
        // If new score is higher, write new highscore
        if(global.attnscore > hiattn){
            ini_write_real('BASICATTN','HIGHSCORE',(global.attnscore));
        }
        
        // Close ini file
        ini_close();
    }
    else if(room == rm_basicmem){
        ini_open(string(global.userini));
        // Get the previous number
        global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
        // Increment by 1
        global.memtestnumb = global.memtestnumb + 1;
        // Write new number
        ini_write_real('BASICMEM','NUMB',global.memtestnumb);
        // Write the score
        ini_write_real('BASICMEM',string(global.memtestnumb),(global.memscore));
        // Get highscore
        var himem = ini_read_real('BASICMEM','HIGHSCORE',0);
        // If new score is higher, write new highscore
        if(global.memscore > himem){
            ini_write_real('BASICMEM','HIGHSCORE',(global.memscore));
        }
        // Close ini file
        ini_close();
    }

    // Play complete sound and return to the menu
    audio_play_sound(snd_complete, 1, 0);
    scr_menureturn();
}

#define scr_drawtimeremain
// Draw bar to display remaining time
draw_healthbar(352, 8, 672, 38, ((testtime / totaltime) * 100), c_black, c_blue, c_blue, 0, true, true);
draw_set_halign(fa_left);
draw_set_colour(c_white);
draw_set_font(ft_basic16);
draw_text(440, 10, "Time Remaining");

#define scr_createbasicattn
// Don't recreate testtime and ctr - reserved for time remaining

// Variable to spawn test, set to 90, for 90 / 3 = 3 tests
spawn = 0;

// 30 seconds to answer after the test prompt
answer = 0;

// Variable to track if answer has been given
bubble = true;

// Random variant for sound to play (up, down, left, right)
snd_variant = irandom_range(1,4);

// Random variant for visual to show (up, down, left, right)
vis_variant = irandom_range(1,4);

// Random variant for color of visual (green or red), 1 is red, anything else green
col_variant = irandom_range(1,3);

// Value of the correct answer
correct = 0;

// Is the word visible?
worddisplay = false;

// KEY FOR VALUES
// FOR SOUND AND VISUAL:
// 1: up    2: down     3: left     4: right
// FOR COLOR
// 1: green     2: red

// Rule:
// If the text was green, go with the word. If the text was red, don't answer.

#define scr_stepbasicattn
// First, wait 2 seconds (starts at 64 seconds), ignore last 1 sec
if (testtime <= (totaltime - 2) && testtime > 1){
    // Constantly decrement spawn to continue generating new tests
    if (spawn > 0){
        spawn -= 1;
    }
    
    // Begin the test
    
    // If spawn is 0, generate a test
    if (spawn == 0){
    
        // Randomize test values
        // sound to play (up, down, left, right)
        snd_variant = irandom_range(1,4);
        // visual to show (up, down, left, right)
        vis_variant = irandom_range(1,4);
        // color of visual (green or red)
        col_variant = irandom_range(1,4);
    
        // Set the value of the correct answer:
        // if green, go go with sound
        if (col_variant == 1){
            // red, don't press anything
            correct = 0;
        }else{
            // green, press what color is spoken
            correct = snd_variant;
        }
        
        // Play the randomly selected sound
        if(snd_variant = 1){
            // up
            audio_play_sound(snd_up, 10, false);
        }
        if(snd_variant = 2){
            // down
            audio_play_sound(snd_down, 10, false);
        }
        if(snd_variant = 3){
            // left
            audio_play_sound(snd_left, 10, false);
        }
        if(snd_variant = 4){
            // right
            audio_play_sound(snd_right, 10, false);
        }
        
        // Allocate 1 second to answer
        answer = 30;
        
        // Set bubble back to false
        bubble = false;
        
        //Reset spawn to 90
        spawn = 90;
    }
    
    // decrement answer time
    if (answer > 0){
    // word is visible
    worddisplay = true;
            
    // Can answer the question for 1 second
    if (keyboard_check_pressed(vk_up)){
    // Check if correct answer
        if (correct == 1 && bubble == false){
            global.attnscore++;
        }
        bubble = true;
    }
    if (keyboard_check_pressed(vk_down)){
        // Check if correct answer
        if (correct == 2 && bubble == false){
           global.attnscore++;
        }
        bubble = true;
    }
    if (keyboard_check_pressed(vk_left)){
        // Check if correct answer
        if (correct == 3 && bubble == false){
            global.attnscore++;
        }
        bubble = true;
    }
    if (keyboard_check_pressed(vk_right)){
        // Check if correct answer
        if (correct == 4 && bubble == false){
            global.attnscore++;
        }
        bubble = true;
    }
    
    // Decrement answer time
    answer -= 1;
    
    }else{
        // Check if was supposed to be left blank and not answered
        if (correct == 0 && bubble == false){
            global.attnscore++;
        }
        bubble = true;
        // Word not visible
        worddisplay = false;
    }
    
}else{
    // Ensure testing is off
    worddisplay = false;
    bubble = true;
    answer = 0;
    spawn = 90;
}

#define scr_drawbasicattn
var wordhor = 512;
var wordver = 125;

draw_set_font(ft_attn);
draw_set_halign(fa_center);

// If the word is visible
if (worddisplay == true){

// red
if(col_variant == 1){
    draw_set_color(c_red);
    if(vis_variant == 1){
    // up
        draw_text(wordhor, wordver, "Up");
    }
    else if(vis_variant == 2){
    // down
        draw_text(wordhor, wordver, "Down");
    }
    else if(vis_variant == 3){
    // left
        draw_text(wordhor, wordver, "Left");
    }
    else{
    // right
        draw_text(wordhor, wordver, "Right");
    }
}
// green
else
{
    draw_set_color(c_green);
    if(vis_variant == 1){
    // up
        draw_text(wordhor, wordver, "Up");
    }
    else if(vis_variant == 2){
    // down
        draw_text(wordhor, wordver, "Down");
    }
    else if(vis_variant == 3){
    // left
        draw_text(wordhor, wordver, "Left");
    }
    else{
    // right
        draw_text(wordhor, wordver, "Right");
    }
}

}

#define scr_drawattnscore
// draws progress
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(800,8,"Correct Answers: " + string(global.attnscore) + " / 20");

#define scr_createbasicmem
// Don't recreate testtime and cnt - reserved for time remaining

// Time to see problem / answer
answertime = 8;
disptime = 2;
nexttime = 2;

// Answering or displaying?
ansmode = 0;
dispmode = 0;

// Count variable for steps
tick = 0;
nextick = 0;

// Going to 8 after 7
moredif = 0;

// Random string of letters
letters = "";
// Length of random letters, starts at 3
wordlength = 3;
// Current letter
leti = 0;
//Answer from user
entry = "";
// done answering
done = 0;
// if correct or wrong
correct = 0;
// try 
try = 0;

#define scr_stepbasicmem
// First, wait 2 seconds (starts at 104 seconds), ignore last 1 sec
if (testtime <= (totaltime - 2) && testtime > 1){

// Get ready for next question
if (ansmode == 0 && dispmode == 0){
    // Reset letters and tick
    letters = "";
    tick = 0;
    nextick ++;
    if(nextick == 30 * nexttime){
        // Turn on display mode and reset
        dispmode = 1;
        nextick = 0;
        // Play memorize
        audio_play_sound(snd_memorize, 10, false);
    }  
}

//If displaying or answersing
if (ansmode == 1 || dispmode == 1){
// Constantly increment tick with room steps
tick ++;

if(dispmode == 1){
// Display Question
    while (leti < wordlength){
        // Build random word
        letters = letters + chr(65 + floor(random(26)));
        leti++;
    }

    if (tick == 30 * disptime){
        // Clear strings
        entry = "";
        keyboard_string = "";
        done = 0;
        // Switch to answer mode
        dispmode = 0;
        ansmode = 1;
        leti = 0;
        tick = 0;
        // play repeat
        audio_play_sound(snd_repeat, 10, false);
    }
}

if(ansmode == 1){
// Answer prompt

    if (done == 0){
        // If string is less than 8 characters
        if(string_length(keyboard_string) < 9){
            entry = string_upper(keyboard_string);
        }else{
            if (keyboard_check_pressed(vk_backspace)){
                // Set keyboard string back one.
                keyboard_string = string_copy(entry, 1, 7);
                entry = string_upper(keyboard_string);
            }
        }
    }

    if (keyboard_check_pressed(vk_enter)){
        done = 1;
        // Check if correct
        if (entry == letters){
            correct = 1;
        }else{
            correct = 0;
        }
    }
    
    if (tick == 30 * answertime){
        done = 1;
        // Add to score if was correct
        if (correct == 1){
            // 
            try = 0;
            // Increment score by wordlength
            // score = (x^2) * 0.22
            global.memscore += floor(power(wordlength, 2) * 0.22);
        }else{
            // Remission
            if ((wordlength == 3)){
                wordlength = wordlength - 1;
            }
            else if ((wordlength == 8)){
                wordlength = 7;
                moredif = 0;
            }
            else if ((wordlength > 3) && (try == 0)){
                wordlength = wordlength - 1;
                try = 1;
            }
            else if ((wordlength > 3) && (try == 1)){
                wordlength = wordlength - 2;
                try = 0;
            }
            
            if (wordlength == 7){
                moredif = moredif - 2;
            }
        }
        // Set both to 0
        dispmode = 0;
        ansmode = 0;
        tick = 0;
        correct = 0;
        if (wordlength < 7){
            wordlength++;
        }
        // For 8 on last
        if (wordlength == 7 && moredif < 5){
            moredif++;
        }
        if (wordlength == 7 && moredif == 5){
            // Go to length 8
            wordlength++;
        }
    }
}

}
}

#define scr_drawbasicmem
var wordhor = 512;
var wordver = 200;

// Display Word
if (dispmode == 1){
draw_set_font(ft_mem);
draw_set_halign(fa_center);
draw_set_color(c_white);

draw_text(wordhor, wordver, letters);
}

if (ansmode == 1){
draw_set_font(ft_mem);
draw_set_halign(fa_center);
if (done == 0){
    draw_set_color(c_red);
}
if (done == 1 && correct = 0){
    draw_set_color(c_ltgray);
}
if (done == 1 && correct = 1){
    draw_set_color(c_green);
}

draw_text(wordhor, wordver, entry);

// Draw correct if wrong
if (done == 1 && correct = 0){
    draw_set_color(c_dkgray);
    draw_set_font(ft_memwrong);
    draw_text(wordhor, (wordver + 120), letters);
}

}

// Drawing time bars
if (ansmode == 1 || dispmode == 1){
    if (ansmode == 1){
        draw_healthbar(372, 120, 652, 160, ((tick / (answertime * 30)) * 100), c_navy, c_teal, c_teal, 0, true, true);
        draw_set_halign(fa_left);
        draw_set_colour(c_white);
        draw_set_font(ft_basic16);
        draw_text(440, 128, "Time to Answer");
    }
    
    if (dispmode == 1){
        draw_healthbar(372, 120, 652, 160, ((tick / (disptime * 30)) * 100), c_navy, c_teal, c_teal, 0, true, true);
        draw_set_halign(fa_left);
        draw_set_colour(c_white);
        draw_set_font(ft_basic16);
        draw_text(452, 128, "Time to View");
    }
}

#define scr_drawmemscore
// draws progress
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(836,8,"Memory Score: " + string(global.memscore));

#define scr_createlogin


#define scr_steplogin


#define scr_buttonhover
// Changes button trans if hovered over

if position_meeting(mouse_x, mouse_y, self){
    image_alpha = 0.7;
    if (mouse_check_button_pressed(mb_left)){
    
        //If the button has been clicked, go to the correct room.    
    
        if (instance_position(mouse_x, mouse_y, obj_attnbutt)){
            audio_play_sound(snd_basicattn, 1, false);
            room_goto(rm_basicattn);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_membutt)){
            audio_play_sound(snd_basicmem, 1, false);
            room_goto(rm_basicmem);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_spatbutt)){
            audio_play_sound(snd_comingsoon, 1, false);
            // audio_play_sound(snd_basicspat, 1, false);
            // room_goto(rm_basicspat);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_gameattnbutt)){
            audio_play_sound(snd_attngame, 1, false);
            room_goto(rm_gameattn);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_gamemembutt)){
            audio_play_sound(snd_comingsoon, 1, false);
            // audio_play_sound(snd_gamemem, 1, false);
            // room_goto(rm_gamemem);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_progressbutt)){
            audio_play_sound(snd_progress, 1, false);
            room_goto(rm_progress);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_custombutt)){
            audio_play_sound(snd_comingsoon, 1, false);
            // audio_play_sound(snd_custom, 1, false);
            // room_goto(rm_custom);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_settingsbutt)){
            audio_play_sound(snd_settings, 1, false);
            room_goto(rm_settings);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_backbutt)){
            scr_stopbgmusic();
            audio_play_sound(snd_mainmenu, 1, false);
            room_goto(rm_menu);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_togsfxbutt)){
            if(global.togsfx == 1){
                audio_play_sound(snd_effoff, 1, false);
                global.togsfx = 0;
                // Write settings to ini
                ini_open("moneta_memory_suite_data.ini");
                ini_write_real('SETTINGS','TOGSFX',0);
                ini_close();
            }else{
                audio_play_sound(snd_effon, 1, false);
                global.togsfx = 1;
                // Write settings to ini
                ini_open("moneta_memory_suite_data.ini");
                ini_write_real('SETTINGS','TOGSFX',1);
                ini_close();
            }
        }
    }
}
else{
    image_alpha = 1;
}

#define scr_coming_soon
image_alpha = 0.9;

#define scr_drawmenu
draw_set_halign(fa_left);

// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,36,"Moneta Memory Suite");

// Draw Welcome
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(32,90,"Welcome " + string(global.user) + ".");
draw_set_color(c_silver);
draw_set_font(ft_basic16);
draw_text(32,132,"Please make a selection...");

// Footer
draw_set_color(c_black);
draw_set_font(ft_basic16);
draw_text(770,518,"Created by Benjamin Ward");

#define scr_drawprogress
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic20);

// buttons
draw_text((obj_backbutt.x + 58), (obj_backbutt.y + 36), "Back To Menu");


// Load all of the game data from the user's profile
        // open user's save file
        ini_open(string(global.userini));
        // Get the previous number for all scores
        global.attngamenumb = ini_read_real('ATTNGAME','NUMB',0);
        global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
        global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
        
        // Get most recent scores
        global.attngamescore = ini_read_real('ATTNGAME',string(global.attngamenumb),0);
        global.attnscore = ini_read_real('BASICATTN',string(global.attntestnumb),0);
        global.memscore = ini_read_real('BASICMEM',string(global.memtestnumb),0);
        
        // Get the highscores
        var hiattngame = ini_read_real('ATTNGAME','HIGHSCORE',0);
        var himemgame = 0;
        var hiattntest = ini_read_real('BASICATTN','HIGHSCORE',0);
        var himemtest = ini_read_real('BASICMEM','HIGHSCORE',0);
        var hispattest = 0;
        
        


var i = 0;
var starti = 0;
var k = 0;
        
// All previous scores
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_italic24);
draw_text(300,64,"Previous Scores...");



// ATTENTION GAME scores
draw_set_font(ft_basic16);
draw_set_color(c_maroon);
draw_text(300,120,"Basic Attention Game Scores: ");
if(global.attngamenumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.attngamenumb > 11){
    starti = 11;
}else{
    starti = global.attngamenumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 140, string(ini_read_real('ATTNGAME',string(global.attngamenumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 140, string(ini_read_real('ATTNGAME',string(global.attngamenumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}



// MEM GAME scores
draw_set_font(ft_basic16);
draw_set_color(c_maroon);
draw_text(300,170,"Basic Memory Game Scores: ");
if(global.memgamenumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.memgamenumb > 11){
    starti = 11;
}else{
    starti = global.memgamenumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 190, string(ini_read_real('MEMGAME',string(global.memgamenumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 190, string(ini_read_real('MEMGAME',string(global.memgamenumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0
}



// ATTN TEST scores
draw_set_font(ft_basic16);
draw_set_color(c_purple);
draw_text(300,220,"Basic Attention Test Scores: ");
if(global.attntestnumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.attntestnumb > 11){
    starti = 11;
}else{
    starti = global.attntestnumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 240, string(ini_read_real('BASICATTN',string(global.attntestnumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 240, string(ini_read_real('BASICATTN',string(global.attntestnumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}



// MEM TEST scores
draw_set_font(ft_basic16);
draw_set_color(c_purple);
draw_text(300,270,"Basic Memory Test Scores: ");
if(global.memtestnumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.memtestnumb > 11){
    starti = 11;
}else{
    starti = global.memtestnumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 290, string(ini_read_real('BASICMEM',string(global.memtestnumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 290, string(ini_read_real('BASICMEM',string(global.memtestnumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}


// SPAT MEM TEST scores
draw_set_font(ft_basic16);
draw_set_color(c_purple);
draw_text(300,320,"Spatial Memory Test Scores: ");
if(global.spattestnumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.spattestnumb > 11){
    starti = 11;
}else{
    starti = global.spattestnumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 340, string(ini_read_real('SPATMEM',string(global.spattestnumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 340, string(ini_read_real('SPATMEM',string(global.spattestnumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}



// draws progress
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_set_font(ft_italic24);
draw_text(512,8, string(global.user) + "'s Progress Report");

// Recent Scores
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,60,"Most Recent Scores...");
// The recent scores
draw_set_font(ft_basic16);

draw_set_color(c_white);
draw_text(8,106,"Basic Attention Game: ");
draw_set_color(c_lime);
draw_text(220,106,string(global.attngamescore));

draw_set_color(c_white);
draw_text(8,136,"Basic Memory Game: ");
draw_set_color(c_lime);
draw_text(220,136,string(global.memgamescore));

draw_set_color(c_white);
draw_text(8,166,"Basic Attention Test: ");
draw_set_color(c_lime);
draw_text(220,166,string(global.attnscore));

draw_set_color(c_white);
draw_text(8,196,"Basic Memory Test: ");
draw_set_color(c_lime);
draw_text(220,196,string(global.memscore));

draw_set_color(c_white);
draw_text(8,226,"Spatial Memory Test: ");
draw_set_color(c_lime);
draw_text(220,226,string(global.spatscore));

// High Scores
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,266,"Highest Scores...");
// The recent scores
draw_set_font(ft_basic16);

draw_set_color(c_white);
draw_text(8,306,"Basic Attention Game: ");
draw_set_color(c_lime);
draw_text(220,306,string(hiattngame));

draw_set_color(c_white);
draw_text(8,336,"Basic Memory Game: ");
draw_set_color(c_lime);
draw_text(220,336,string(himemgame));

draw_set_color(c_white);
draw_text(8,366,"Basic Attention Test: ");
draw_set_color(c_lime);
draw_text(220,366,string(hiattntest));

draw_set_color(c_white);
draw_text(8,396,"Basic Memory Test: ");
draw_set_color(c_lime);
draw_text(220,396,string(himemtest));

draw_set_color(c_white);
draw_text(8,426,"Spatial Memory Test: ");
draw_set_color(c_lime);
draw_text(220,426,string(hispattest));

// Total Games played
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,466,"Total Games/Tests Completed...");
//Games
draw_set_color(c_maroon);
draw_set_font(ft_basic18);
draw_text(8,500,"Games: ");
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(94,514,"Attn:");
draw_text(184,514,"Mem:");
//#played
draw_set_color(c_lime);
draw_text(144,514,string(global.attngamenumb));
draw_text(238,514,string(global.memgamenumb));
//Tests
draw_set_color(c_purple);
draw_set_font(ft_basic18);
draw_text(280,500,"Tests: ");
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(346,514,"Attn:");
draw_text(436,514,"Mem:");
draw_text(530,514,"Spatial Mem:");
//#played
draw_set_color(c_lime);
draw_text(396,514,string(global.attntestnumb));
draw_text(488,514,string(global.memtestnumb));
draw_text(654,514,string(global.spattestnumb));

// Close ini file
ini_close();

#define scr_drawbuttons
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_italic24);

// Headers
draw_text((obj_gameattnbutt.x + 24), (obj_gameattnbutt.y - 58), "Training Games");
draw_text((obj_attnbutt.x + 70), (obj_attnbutt.y - 54), "Skill Tests");
draw_text((obj_progressbutt.x + 30), (obj_progressbutt.y - 54), "Other Features");

draw_set_font(ft_basic20);

// Game Buttons
draw_text((obj_gameattnbutt.x + 7), (obj_gameattnbutt.y + 36), "Basic Attention Game");
draw_text((obj_gamemembutt.x + 18), (obj_gamemembutt.y + 36), "Basic Memory Game");

// Test Buttons
draw_text((obj_attnbutt.x + 19), (obj_attnbutt.y + 36), "Basic Attention Test");
draw_text((obj_membutt.x + 26), (obj_membutt.y + 36), "Basic Memory Test");
draw_text((obj_spatbutt.x + 12), (obj_spatbutt.y + 36), "Spatial Memory Test");

// Other Buttons
draw_text((obj_progressbutt.x + 86), (obj_progressbutt.y + 36), "Progress");
draw_text((obj_custombutt.x + 58), (obj_custombutt.y + 36), "Custom Tests");
draw_text((obj_settingsbutt.x + 92), (obj_settingsbutt.y + 36), "Settings");

#define scr_drawcustom
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic20);

draw_text((obj_backbutt.x + 58), (obj_backbutt.y + 36), "Back To Menu");

#define scr_createcountdown
// countdown number displayed, starts at 5
countdown = 5;
// room step counter
cnt = 0;

// Reset point value for test
global.attnscore = 0;
global.memscore = 0;
global.spatscore = 0;

// Reset point value for games
global.attngamescore = 0;
global.memgamescore = 0;

// Reset point value for other vars
global.gameover = 0;
global.gosignal = 0;

#define scr_drawcountdown
// Get ready text
draw_set_font(ft_ready);
draw_text(390, 130, "Get ready...");
// Draw the timer to the middle of the screen
draw_set_font(ft_countdown);
draw_text(450, 165, string(countdown));

#define scr_stepcountdown
// Creates appropriate object for the room after the countdown is over
// cnt counts the current step
// 30 steps == 1 second

// Constantly increment cnt with room steps
cnt ++;

// If there has been 1 second of real time
if (cnt == 30){
    // Play boop sound if not last tick
    if (countdown > 1){
        audio_play_sound(snd_boop, 1, 0);
    }
    // Take a second off of the timer
    countdown--;
    // Reset cnt to 0.
    cnt = 0;
}

// If countdown is 0
if (countdown == 0){
    // Play start sound
    audio_play_sound(snd_start, 1, 0);
    // Create the appropriate room control object
    if (room == rm_basicattn){
            instance_create(0,0,obj_basicattn);
        }
        
    if (room == rm_basicmem){
           instance_create(0,0,obj_basicmem);
        }
        
    if (room == rm_basicspat){
           instance_create(0,0,obj_basicspat);
        }
        
    if (room == rm_gameattn){
           instance_create(0,0,obj_gameattn);
        }
        
    if (room == rm_gamemem){
           instance_create(0,0,obj_gamemem);
        }
    // And then delete this object
    instance_destroy();
}

#define scr_stepsfx
// Check if sfx off
if(global.togsfx == 0){
    instance_destroy();
}

// Varience
image_alpha = .2;
vspeed -= (random_range(0.5, 0.8));

if (hspeed > 0 && hspeed < 8){
    hspeed += (irandom_range(3, 5));
}
else if(hspeed >= 8){
    hspeed = (irandom_range(-5, -3));
}
else if (hspeed < 0 && hspeed > -8){
    hspeed += (irandom_range(-5, 3));
}else{
    hspeed = (irandom_range(3, 5));
}

#define scr_destroyself
// Destroy this instance
instance_destroy();

#define scr_createsfx
// to generate
sfx = 30;
ticker = irandom_range(60, 170);

#define scr_gensfx
// Check if SFX are on
if(global.togsfx == 1){
sfx += 1;

    // If sfx is 100, generate sfx
    if (sfx == ticker){
        // Create sfx in room at bottom randomly
        instance_create(irandom_range(0, room_width),room_height,obj_sfx);
        sfx = 0;
        ticker = irandom_range(60, 170);
    }
}

#define scr_sfxspawn
wig = irandom_range(-8, 8);

#define scr_drawsettings
// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,14,"Moneta Memory Suite");

draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic20);

draw_text((obj_backbutt.x + 58), (obj_backbutt.y + 36), "Back To Menu");
draw_text((obj_togsfxbutt.x + 58), (obj_togsfxbutt.y + 36), "Toggle Effects");

draw_set_color(c_navy);
draw_set_font(ft_b48);
draw_text(8, 58, "Profile Change");
// Allow user to change username
draw_set_font(ft_italic24);
draw_set_color(c_white);
draw_text(8, 120, "Type a new profile name to create a#new user profile, or type the name of an#existing profile to switch to that profile...");
if(blinktext == 1){
draw_set_color(c_black);
}else{
draw_set_color(c_ltgray);
}
draw_set_font(ft_memwrong);
draw_set_halign(fa_left);
draw_text(16, 290, entuser);

#define scr_stepsettings
keyboard_string = string_letters(keyboard_string);

// If string is less than 8 characters
if(string_length(keyboard_string) < 15){
    entuser = keyboard_string;
}else{
    if (keyboard_check_pressed(vk_backspace)){
        // Set keyboard string back one.
        keyboard_string = string_copy(entuser, 1, 13);
        entuser = keyboard_string;
    }
}

if(blinktext == 1){
boff++;
if(boff == 40){
    boff = 0;
    blinktext = 0;
}
}else{
boff++;
if(boff == 5){
    bon = 0;
    blinktext = 1;
}
}

#define scr_rmend_settings
// On leave room

if(string_length(entuser) > 0){
// Set the username to the current entry
global.user = entuser;
global.userini = string(string_lower(global.user)) + "_data.ini";
// Write to file
ini_open("moneta_memory_suite_data.ini");
ini_write_string('MONETA','USER',string(global.user));
ini_close();
}else{
// Otherwise default Jack Sparrow
global.user = 'JackSparrow';
global.userini = string(string_lower(global.user)) + "_data.ini";
// Write to file
ini_open("moneta_memory_suite_data.ini");
ini_write_string('MONETA','USER','JackSparrow');
ini_close();
}

#define scr_createsettings
//username from user
keyboard_string = global.user;
entuser = global.user;
blinktext = 0;
boff = 0;
bon = 0;

#define scr_createtest
// timer for position change.
pulse = 0;
trans = 0;
image_alpha = .7;

#define scr_steptest
//Change to random position every 10 steps
pulse++;
if (pulse = 20){
move_random(1,1);
pulse = 0;
}

//Also rotate the test object
image_angle -= 5;

//Swap the transparency.
if (trans == 0){
    image_alpha -= .05;
    if (image_alpha <= .4){
        trans = 1;
    }
}

if (trans == 1){
    image_alpha += .05;
    if (image_alpha >= .7){
        trans = 0;
    }
}

#define scr_outsideroomtest
//If outside, jump to center.
self.x = 448;
self.y = 224;

