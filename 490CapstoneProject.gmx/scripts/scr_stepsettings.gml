keyboard_string = string_letters(keyboard_string);

// If string is less than 8 characters
if(string_length(keyboard_string) < 15){
    entuser = keyboard_string;
}else{
    if (keyboard_check_pressed(vk_backspace)){
        // Set keyboard string back one.
        keyboard_string = string_copy(entuser, 1, 13);
        entuser = keyboard_string;
    }
}

if(blinktext == 1){
boff++;
if(boff == 40){
    boff = 0;
    blinktext = 0;
}
}else{
boff++;
if(boff == 5){
    bon = 0;
    blinktext = 1;
}
}
