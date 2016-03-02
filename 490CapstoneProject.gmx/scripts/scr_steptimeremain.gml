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
