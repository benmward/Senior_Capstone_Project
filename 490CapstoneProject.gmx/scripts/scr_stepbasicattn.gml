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
