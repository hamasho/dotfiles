// disable emoji compilation
settings.startToShowEmoji = false;

// make sure this config is loaded
mapkey('<Ctrl-p>', 'Hello, world!', function() {
  console.log('hellooooo');
});

// Toggle SurferingKeys by Alt-ESC
map('<Alt-Esc>', '<Alt-s>');

// open mermaid
map('<Ctrl-Alt-f>', '<Ctrl-Alt-d>');

// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
  Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// gruvbox dark theme colors
const colors = {
  bg0: '#282828',
  bg1: '#3c3836',
  bg2: '#504945',
  bg3: '#665c54',
  bg4: '#7c6f64',
  fg0: '#fbf1c7',
  fg1: '#ebdbb2',
  fg2: '#d5c4a1',
  fg3: '#bdae93',
  fg4: '#a89984',
  gray0: '#828374',
  gray1: '#928374',
  red0: '#cc241d',
  red1: '#fb4934',
  green0: '#98971a',
  green1: '#b8bb26',
  yellow0: '#d79921',
  yellow1: '#fabd2f',
  blue0: '#458488',
  blue1: '#83a598',
  purple0: '#b16286',
  purple1: '#d3869b',
  aqua0: '#689d6a',
  aqua1: '#8ec07c',
  orange0: '#d65d0e',
  orange1: '#fe8019',
}

Hints.style(`
  border: soid 3px ${colors.fg1};
  border-radius: 6px;
  padding: 3px;
  color: ${colors.fg1};
  background: ${colors.bg2};
  background-color: ${colors.bg2};
  font-size: 12px;
  font-weight: normal;
  font-family: Helvetica, Arial, sans-serif;
`)
Visual.style('marks', 'background-color: #f1fa8c;');
Visual.style('cursor', 'background-color: #6272a4; color: #f8f8f2');


settings.theme = `
.sk_theme {
    font-family: Helvetica, Arial, sans-serif;
    font-size: 12pt;
    background: ${colors.bg2};
    color: ${colors.fg1};
}
.sk_theme tbody {
    color: ${colors.green1};
}
.sk_theme input {
    color: ${colors.fg1};
}
.sk_theme .url {
    color: ${colors.green1};
}
.sk_theme .annotation {
    color: ${colors.purple1};
}
.sk_theme .omnibar_highlight {
    color: ${colors.fg1};
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: ${colors.bg2};
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: ${colors.purple1};
}
#sk_status, #sk_find {
    font-size: 14px;
}`;

// click `Save` button to make above settings to take effect.
