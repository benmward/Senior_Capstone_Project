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
        // Play game over sound
        audio_play_sound(snd_gameover, 1, false);
        // Return to menu
        scr_menureturn();
    }
}
