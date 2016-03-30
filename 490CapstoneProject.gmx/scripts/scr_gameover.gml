// Save score

// Stop the bg music
scr_stopbgmusic();

// Set gameover to 1
global.gameover = 1;

// Change instance of object into dead
instance_create(self.x,self.y,obj_deadman);
instance_destroy();
