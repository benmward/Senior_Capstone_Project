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
draw_text(512, 72, "Basic Attention Test Instructions");

draw_set_halign(fa_left);
// Instructions
draw_set_font(ft_italic24);
draw_set_color(c_white);
draw_text(24, 120, "Every few seconds, a direction (left, right, up, down) will#be spoken and a word will be displayed (in green or red text)#simultaneously. If the word is RED, do not press anything. If#the word is GREEN, press the arrow key in the direction of#the SPOKEN VOICE within one second.");
