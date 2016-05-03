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
draw_text(512, 72, "Basic Attention Game Instructions");

draw_set_halign(fa_left);
// Instructions
draw_set_font(ft_italic24);
draw_set_color(c_white);
draw_text(24, 120, "Use the left and right arrows keys to run forward and backward#and dodge falling rocks. Use the up arrow key to jump over#rocks on the ground. If a nuclear missile arming sound plays,#quickly PRESS SPACEBAR ONCE. If any other sound plays (or no#sound at all) DO NOT PRESS SPACEBAR, as pressing spacebar will#end the game when there is no missile.");
