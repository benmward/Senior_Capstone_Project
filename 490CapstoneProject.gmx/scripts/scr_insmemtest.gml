// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,14,"Moneta Memory Suite");

draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic20);

draw_text((obj_backbutt.x + 58), (obj_backbutt.y + 36), "Back To Menu");

draw_set_color(c_navy);
draw_set_font(ft_b36);
draw_set_halign(fa_center);
draw_text(512, 72, "Basic Memory Test Instructions");

draw_set_halign(fa_left);
// Instructions
draw_set_font(ft_italic24);
draw_set_color(c_white);
draw_text(24, 120, "A sequence of letters will be displayed on a time interval.#Memorize the letters in the given time, and then reenter the#sequence you just viewed exactly as it just appeared. When you#are done typing in your answer, quickly press ENTER to lock your#answer in. When correctly answered the word will turn green,#otherwise the correct answer will be displayed.");
