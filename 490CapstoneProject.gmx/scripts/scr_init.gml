// Randomize the game seed
randomize();

// Menu Vars
global.esc_time = 0;
ini_open("moneta_memory_suite_data.ini");
global.user = ini_read_string('MONETA','USER','JackSparrow');
global.togsfx = ini_read_real('SETTINGS','TOGSFX',1);
ini_close();
global.userini = string(string_lower(global.user)) + "_data.ini";

// Test Score Vars
global.attnscore = 0;
global.memscore = 0;
global.spatscore = 0;

// Game Score Vars
global.attngamescore = 0;
global.memgamescore = 0;

// other vars
global.gameover = 0;
global.gosignal = 0;

// Score loggin numbers, numb = numb of previous scores
ini_open(string(global.userini));
global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
global.attngamenumb = ini_read_real('ATTNGAME','NUMB',0);
ini_close();
//not ready yet
global.memgamenumb = 0;
global.spattestnumb = 0;
