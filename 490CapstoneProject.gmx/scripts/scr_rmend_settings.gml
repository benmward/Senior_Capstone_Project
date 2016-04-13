// On leave room

if(string_length(entuser) > 0){
// Set the username to the current entry
global.user = entuser;
global.userini = string(string_lower(global.user)) + "_data.ini";
// Write to file
ini_open("moneta_memory_suite_data.ini");
ini_write_string('MONETA','USER',string(global.user));
ini_close();
}else{
// Otherwise default Jack Sparrow
global.user = 'JackSparrow';
global.userini = string(string_lower(global.user)) + "_data.ini";
// Write to file
ini_open("moneta_memory_suite_data.ini");
ini_write_string('MONETA','USER','JackSparrow');
ini_close();
}
