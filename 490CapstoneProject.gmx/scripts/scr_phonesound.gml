// Randomly play phone ring or vibrate
if (irandom_range(1,2) == 1){
    audio_play_sound(snd_phonevib, 1, false);
}else{
    audio_play_sound(snd_phonering, 1, false);
}
