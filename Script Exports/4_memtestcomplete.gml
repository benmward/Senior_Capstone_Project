#define scr_init
// Randomize the game seed
randomize();

// Menu Vars
global.esc_time = 0;
global.user = "Jack Sparrow";

// Score Vars
global.attnscore = 0;
global.memscore = 0;
global.spatscore = 0;

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
           // audio_play_sound(snd_thinking, 0, true);
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
    // Play complete sound and return to the menu
    audio_play_sound(snd_complete, 1, 0);
    scr_menureturn();
}

// At some point, add code to save scores into files / database here
// TODO

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
        col_variant = irandom_range(1,3);
    
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
draw_set_color(c_black);
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
            global.memscore++;
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
        if (wordlength == 7 && moredif < 6){
            moredif++;
        }
        if (wordlength == 7 && moredif == 6){
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
        draw_text(440, 128, "Time to View");
    }
}

#define scr_drawmemscore
// draws progress
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic16);
draw_text(800,8,"Correct Answers: " + string(global.memscore) + " / 10");

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
            // audio_play_sound(snd_basicspat, 1, false);
            room_goto(rm_basicspat);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_gameattnbutt)){
            // audio_play_sound(snd_gameattn, 1, false);
            room_goto(rm_gameattn);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_gamemembutt)){
            // audio_play_sound(snd_gamemem, 1, false);
            room_goto(rm_gamemem);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_progressbutt)){
            // audio_play_sound(snd_progress, 1, false);
            room_goto(rm_progress);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_custombutt)){
            // audio_play_sound(snd_custom, 1, false);
            room_goto(rm_custom);
        }
        
        if (instance_position(mouse_x, mouse_y, obj_settingsbutt)){
            // audio_play_sound(snd_settings, 1, false);
            room_goto(rm_settings);
        }
    }
}
else{
    image_alpha = 1;
}

#define scr_drawmenu
draw_set_halign(fa_left);

// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,36,"Moneta Memory Suite");

// Draw Welcome
draw_set_color(c_silver);
draw_set_font(ft_basic18);
draw_text(32,90,"Welcome " + global.user + ".");
draw_set_font(ft_basic16);
draw_text(32,132,"Please make a selection...");

// Footer
draw_set_color(c_black);
draw_set_font(ft_basic16);
draw_text(770,518,"Created by Benjamin Ward");

#define scr_drawprogress
// draws progress
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(ft_basic22);
draw_text(720,4,"Progress Report");
draw_set_font(ft_basic16);
draw_text(720,54,"Previous Attention Score: " + string(global.attnscore) + " / 20");

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

#define scr_createcountdown
// countdown number displayed, starts at 5
countdown = 5;
// room step counter
cnt = 0;

// Reset point value for test
global.attnscore = 0;
global.memscore = 0;

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
// Varience
image_alpha = .4;
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
sfx = 95;

#define scr_gensfx
sfx += 1;

// If sfx is 100, generate sfx
if (sfx == 100){
    // Create sfx in room at bottom randomly
    instance_create(irandom_range(0, room_width),room_height,obj_sfx);
    sfx = 0;
}

#define scr_sfxspawn
wig = irandom_range(-8, 8);

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

