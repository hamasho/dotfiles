// disable emoji compilation
settings.startToShowEmoji = false;

// make sure this config is loaded
mapkey('<Ctrl-p>', 'Hello, world!', function() {
  console.log('hellooooo');
});

// emulate <Ctrl-[>
map('<Ctrl-[>', '<Esc>');

// Toggle SurferingKeys by Alt-ESC
map('<Alt-Esc>', '<Alt-s>');

// open mermaid
map('<Ctrl-Alt-f>', '<Ctrl-Alt-d>');

// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
  Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});



Hints.style('border: solid 1px #ff79c6; color: #f8f8f2; background: #282a36; background-color: #282a36; font-size: 10pt; font-family: "Fira Code"');
Hints.style('border: solid 8px #ff79c6; padding: 1px; background: #282a36; font-family: "Fira Code"', "text");
// -----------------------------------------------------------------------------------------------------------------------
// Change search marks and cursor
// -----------------------------------------------------------------------------------------------------------------------
Visual.style('marks', 'background-color: #f1fa8c;');
Visual.style('cursor', 'background-color: #6272a4; color: #f8f8f2');

// -----------------------------------------------------------------------------------------------------------------------
// Change theme
// // Change fonts
// // Change colors
// -----------------------------------------------------------------------------------------------------------------------
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #282828;
    color: #ebdbb2;
}
.sk_theme tbody {
    color: #b8bb26;
}
.sk_theme input {
    color: #d9dce0;
}
.sk_theme .url {
    color: #98971a;
}
.sk_theme .annotation {
    color: #b16286;
}
.sk_theme .omnibar_highlight {
    color: #ebdbb2;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #282828;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #d3869b;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;

// click `Save` button to make above settings to take effect.
