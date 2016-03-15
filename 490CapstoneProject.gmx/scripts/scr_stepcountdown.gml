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
