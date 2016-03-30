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
