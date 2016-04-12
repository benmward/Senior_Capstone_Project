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
    // Save the score in the ini file
    if(room == rm_basicattn){
        // open user's save file
        ini_open(string(global.userini));
        // Get the previous number
        global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
        // Increment by 1
        global.attntestnumb = global.attntestnumb + 1;
        // Write new number
        ini_write_real('BASICATTN','NUMB',global.attntestnumb);
        // Write the score
        ini_write_real('BASICATTN',string(global.attntestnumb),(global.attnscore));
        // Get highscore
        var hiattn = ini_read_real('BASICATTN','HIGHSCORE',0);
        // If new score is higher, write new highscore
        if(global.attnscore > hiattn){
            ini_write_real('BASICATTN','HIGHSCORE',(global.attnscore));
        }
        
        // Close ini file
        ini_close();
    }
    else if(room == rm_basicmem){
        ini_open(string(global.userini));
        // Get the previous number
        global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
        // Increment by 1
        global.memtestnumb = global.memtestnumb + 1;
        // Write new number
        ini_write_real('BASICMEM','NUMB',global.memtestnumb);
        // Write the score
        ini_write_real('BASICMEM',string(global.memtestnumb),(global.memscore));
        // Get highscore
        var himem = ini_read_real('BASICMEM','HIGHSCORE',0);
        // If new score is higher, write new highscore
        if(global.memscore > himem){
            ini_write_real('BASICMEM','HIGHSCORE',(global.memscore));
        }
        // Close ini file
        ini_close();
    }

    // Play complete sound and return to the menu
    audio_play_sound(snd_complete, 1, 0);
    scr_menureturn();
}
