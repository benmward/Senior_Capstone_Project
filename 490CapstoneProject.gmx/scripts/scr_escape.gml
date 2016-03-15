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
