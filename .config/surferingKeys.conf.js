api.map('h', '<Ctrl-Tab>');
api.map('l', '<Shift-Ctrl-Tab>');


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

api.Hints.style(`
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
api.Visual.style('marks', `background-color: ${colors.bg3};`);
api.Visual.style('cursor', 'background-color: #6272a4; color: #f8f8f2');

settings.theme = `
:root {
    --theme-ace-bg:#282828ab; /*Note the fourth channel, this adds transparency*/
    --theme-ace-bg-accent:#3c3836;
    --theme-ace-fg:#ebdbb2;
    --theme-ace-fg-accent:#7c6f64;
    --theme-ace-cursor:#928374;
    --theme-ace-select:#458588;
}

.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #282828;
    color: #ebdbb2;
}
.sk_theme tbody {
    color: ${colors.fg4};
}
.sk_theme input {
    color: #d9dce0;
}
.sk_theme .url {
    color: ${colors.green0};
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
    background: ${colors.bg2};
}
#sk_status, #sk_find {
    font-size: 12pt;
}

#sk_editor {
    border-radius: 8px;
    height: 50% !important; /*Remove this to restore the default editor size*/
    background: var(--theme-ace-bg) !important;
}
.ace_dialog-bottom {
    border-top: 1px solid var(--theme-ace-bg) !important;
}
.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog{
    background: var(--theme-ace-bg-accent) !important;
}
.ace-chrome{
    color: var(--theme-ace-fg) !important;
}
.ace_cursor{
    color: var(--theme-ace-cursor) !important;
}
.normal-mode .ace_cursor{
    background-color: var(--theme-ace-cursor) !important;
    border: var(--theme-ace-cursor) !important;
}
.ace_marker-layer .ace_selection {
    background: var(--theme-ace-select) !important;
}
`;
