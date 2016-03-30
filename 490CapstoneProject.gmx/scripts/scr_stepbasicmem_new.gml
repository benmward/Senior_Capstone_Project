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
