// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,14,"Moneta Memory Suite");

draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic20);

draw_text((obj_backbutt.x + 58), (obj_backbutt.y + 36), "Back To Menu");
draw_text((obj_togsfxbutt.x + 58), (obj_togsfxbutt.y + 36), "Toggle Effects");

draw_set_color(c_navy);
draw_set_font(ft_b48);
draw_text(8, 58, "Profile Change");
// Allow user to change username
draw_set_font(ft_italic24);
draw_set_color(c_white);
draw_text(8, 120, "Type a new profile name to create a#new user profile, or type the name of an#existing profile to switch to that profile...");
if(blinktext == 1){
draw_set_color(c_black);
}else{
draw_set_color(c_ltgray);
}
draw_set_font(ft_memwrong);
draw_set_halign(fa_left);
draw_text(16, 290, entuser);
