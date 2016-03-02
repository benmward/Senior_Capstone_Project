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

#define scr_drawmenu
draw_set_font(ft_fancy32);
draw_text(24,20,"Moneta Memory Suite");
draw_set_font(ft_basic16);
draw_text(764,520,"Created by Benjamin Ward");

#define scr_membutt
draw_set_font(ft_basic22);
draw_text((obj_membutt.x + 32), (obj_membutt.y + 40), "Begin Memory Test");

#define scr_attnbutt
draw_set_font(ft_basic22);
draw_text((obj_attnbutt.x + 24), (obj_attnbutt.y + 40), "Begin Attention Test");

#define scr_createcountdown
// countdown number displayed, starts at 5
countdown = 5;
// room step counter
cnt = 0;

#define scr_drawcountdown
// Get ready text
draw_set_font(ft_ready);
draw_text(390, 120, "Get ready...");
// Draw the timer to the middle of the screen
draw_set_font(ft_countdown);
draw_text(450, 160, countdown);

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

