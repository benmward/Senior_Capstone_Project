draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_italic24);

// Headers
draw_text((obj_gameattnbutt.x + 24), (obj_gameattnbutt.y - 58), "Training Games");
draw_text((obj_attnbutt.x + 70), (obj_attnbutt.y - 54), "Skill Tests");
draw_text((obj_progressbutt.x + 30), (obj_progressbutt.y - 54), "Other Features");

draw_set_font(ft_basic20);

// Game Buttons
draw_text((obj_gameattnbutt.x + 7), (obj_gameattnbutt.y + 36), "Basic Attention Game");
draw_text((obj_gamemembutt.x + 18), (obj_gamemembutt.y + 36), "Basic Memory Game");

// Test Buttons
draw_text((obj_attnbutt.x + 19), (obj_attnbutt.y + 36), "Basic Attention Test");
draw_text((obj_membutt.x + 26), (obj_membutt.y + 36), "Basic Memory Test");
draw_text((obj_spatbutt.x + 12), (obj_spatbutt.y + 36), "Spatial Memory Test");

// Other Buttons
draw_text((obj_progressbutt.x + 86), (obj_progressbutt.y + 36), "Progress");
draw_text((obj_custombutt.x + 58), (obj_custombutt.y + 36), "Custom Tests");
draw_text((obj_settingsbutt.x + 92), (obj_settingsbutt.y + 36), "Settings");
