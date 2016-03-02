// Don't recreate testtime and ctr - reserved for time remaining

// Variable to spawn test, set to 90, for 90 / 3 = 3 tests
spawn = 0;

// 30 seconds to answer after the test prompt
answer = 0;

// Variable to track if answer has been given
bubble = true;

// Random variant for sound to play (up, down, left, right)
snd_variant = irandom_range(1,4);

// Random variant for visual to show (up, down, left, right)
vis_variant = irandom_range(1,4);

// Random variant for color of visual (green or red), 1 is red, anything else green
col_variant = irandom_range(1,3);

// Value of the correct answer
correct = 0;

// Is the word visible?
worddisplay = false;

// KEY FOR VALUES
// FOR SOUND AND VISUAL:
// 1: up    2: down     3: left     4: right
// FOR COLOR
// 1: green     2: red

// Rule:
// If the text was green, go with the word. If the text was red, don't answer.
