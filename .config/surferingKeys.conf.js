// Use `gruvbox light` color theme: https://github.com/morhetz/gruvbox
const skColors = {
  bg: {
    normal: '#fbf1c7',
    highContrast: '#f9f5d7',
    normal0: '#fbf1c7',
    normal1: '#ebdbb2',
    red: '#cc241d',
    green: '#98971a',
    yellow: '#d79921',
    blue: '#455888',
    purple: '#b16286',
    aqua: '#689d6a',
    gray: '#7c6f64',
  },
  fg: {
    gray: '#928374',
    red: '#9d0006',
    green: '#79740e',
    yellow: '#b67614',
    blue: '#076678',
    purple: '#8f3f71',
    aqua: '#427b58',
    normal: '#3c3836',
  },
};

// make sure this config is loaded
mapkey('<Ctrl-p>', 'Hello, world!', function() {
  console.log('hellooooo');
});

// emulate <Ctrl-[>
map('<Ctrl-[>', '<Esc>');

// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
  Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
// map('gt', 'T');

// an example to remove mapkey `Ctrl-i`
// unmap('<Ctrl-i>');

// set theme
settings.theme = `
.sk_theme {
  background: ${skColors.bg.normal};
  color: ${skColors.fg.normal};
}
.sk_theme tbody {
  color: ${skColors.fg.normal};
}
.sk_theme input {
  color: ${skColors.fg.normal};
  font-size: 2em;
  padding-bottom: 10px;
}
.sk_theme .url {
  color: ${skColors.fg.blue};
}
.sk_theme .annotation {
  color: ${skColors.fg.gray};
}
.sk_theme .omnibar_highlight {
  color: ${skColors.fg.red};
}
.sk_theme ul>li:nth-child(odd) {
  background: ${skColors.bg.normal1};
}
.sk_theme ul>li.focused {
  background: ${skColors.bg.gray};
}
#sk_status input {
  color: ${skColors.fg.normal};
  font-size: 1em;
}
#sk_hints>div {
  background: ${skColors.bg.normal};
  color: ${skColors.fg.normal};
}`;
// click `Save` button to make above settings to take effect.
