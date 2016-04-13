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
