draw_set_halign(fa_left);

// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,36,"Moneta Memory Suite");

// Draw Welcome
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,90,"Welcome " + string(global.user) + ".");
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(8,132,"Right click an activity for instructions.");
draw_text(8,154,"Left click to make a selection...");

// Footer
draw_set_color(c_black);
draw_set_font(ft_basic16);
draw_text(770,518,"Created by Benjamin Ward");
