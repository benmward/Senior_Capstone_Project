#define scr_init
// Randomize the game seed
randomize();

global.attnscore = 0;

#define scr_menureturn
room_goto(rm_menu);

#define scr_playbgmusic
audio_play_sound(snd_thinking, 0, true);

#define scr_stopbgmusic
audio_stop_sound(snd_thinking);

#define scr_createtimeremain
// Start with 64 seconds of test time - Extra 2 seconds for prep time
testtime = 64;

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
draw_healthbar(352, 8, 672, 38, ((testtime / 64) * 100), c_black, c_blue, c_blue, 0, true, true);
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
if (testtime <= 62 && testtime > 1){
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

#define scr_drawmenu
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_fancy32);
draw_text(24,20,"Moneta Memory Suite");
draw_set_font(ft_basic16);
draw_text(770,520,"Created by Benjamin Ward");

#define scr_drawprogress
// draws progress
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic22);
draw_text(720,4,"Progress Report");
draw_set_font(ft_basic16);
draw_text(720,54,"Previous Attention Score: " + string(global.attnscore) + " / 20");

#define scr_membutt
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic22);
draw_text((obj_membutt.x + 32), (obj_membutt.y + 40), "Begin Memory Test");

#define scr_attnbutt
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic22);
draw_text((obj_attnbutt.x + 24), (obj_attnbutt.y + 40), "Begin Attention Test");

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
    }
}
else{
    image_alpha = 1;
}

#define scr_createcountdown
// countdown number displayed, starts at 5
countdown = 5;
// room step counter
cnt = 0;

// Reset point value for attention test
global.attnscore = 0;

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
    // And then delete this object
    instance_destroy();
}

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

