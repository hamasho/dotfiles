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

// work related
mapkey('gws', '#1Open Slack', function() {
  tabOpenLink('https://c-chan.slack.com/messages/G43U479LN/');
});
mapkey('gwc', '#1Open Calendar', function() {
  tabOpenLink('https://calendar.google.com/calendar/b/1/r');
});
mapkey('gwm', '#1Open E-Mail', function() {
  tabOpenLink('https://mail.google.com/mail/u/1/#inbox');
});
mapkey('gwl', '#1Open Levtech', function() {
  tabOpenLink('https://platform.levtech.jp/p/workreport/');
});

mapkey('gwgg', '#2Open Github CChan Home', function() {
  tabOpenLink('https://github.com/CChannel');
});
mapkey('gwgw', '#2Open Github CChan Web (Python)', function() {
  tabOpenLink('https://github.com/CChannel/cchan_web_python/tree/alpha');
});
mapkey('gwga', '#2Open Github CChan API', function() {
  tabOpenLink('https://github.com/CChannel/cchan_api/tree/alpha');
});
mapkey('gwgo', '#2Open Github CChan Web (PHP)', function() {
  tabOpenLink('https://github.com/CChannel/cchan-web/tree/alpha');
});
mapkey('gwgm', '#2Open Github Mama-Web', function() {
  tabOpenLink('https://github.com/CChannel/mama-web/tree/alpha');
});
mapkey('gwge', '#2Open Github CChan ETC', function() {
  tabOpenLink('https://github.com/CChannel/cchan-etc');
});

function _changeCchanUrl(toEnv, toRegion, inplace) {
  const proto = toEnv ? (toEnv === 'local' ? 'http:' : 'https:') : window.location.protocol;
  const loc = window.location;
  const host = loc.host;
  const first = host.split('.')[0];
  const parts = first.split('-');
  const env = parts.length == 1 ? 'release' : parts[0];
  const region = env == 'release' ? parts[0] : parts[1];
  toEnv = toEnv || env;
  toRegion = toRegion || region;
  let toHostSub = `${toEnv}-${toRegion}`;
  if (toEnv == 'release') {
    toHostSub = toRegion;
  }
  let toHost = `${toHostSub}.cchan.tv`;
  if (toEnv == 'local') {
    toHost = `${toHost}:8080`;
  }

  const toUrl = `${proto}//${toHost}${loc.pathname}${loc.search}${loc.hash}`;

  console.log('[SK] SWITCH TO: ' + toUrl);
  if (inplace) {
    window.location.href = toUrl;
  } else {
    tabOpenLink(toUrl);
  }
}

mapkey(',cel', '#1Change CChan URL to local and open in new tab', function() {
  _changeCchanUrl('local', null, false);
});
mapkey(',cea', '#1Change CChan URL to alpha and open in new tab', function() {
  _changeCchanUrl('alpha', null, false);
});
mapkey(',ceb', '#1Change CChan URL to beta and open in new tab', function() {
  _changeCchanUrl('beta', null, false);
});
mapkey(',cer', '#1Change CChan URL to release and open in new tab', function() {
  _changeCchanUrl('release', null, false);
});

mapkey(',iel', '#1Change CChan URL to local in current tab', function() {
  _changeCchanUrl('local', null, true);
});
mapkey(',iea', '#1Change CChan URL to alpha in current tab', function() {
  _changeCchanUrl('alpha', null, true);
});
mapkey(',ieb', '#1Change CChan URL to beta in current tab', function() {
  _changeCchanUrl('beta', null, true);
});
mapkey(',ier', '#1Change CChan URL to release in current tab', function() {
  _changeCchanUrl('release', null, true);
});

mapkey(',irj', '#1Change CChan URL to region jp', function() {
  _changeCchanUrl(null, 'www', true);
});
mapkey(',ire', '#1Change CChan URL to region en', function() {
  _changeCchanUrl(null, 'en', true);
});
mapkey(',irz', '#1Change CChan URL to region zh', function() {
  _changeCchanUrl(null, 'zh', true);
});
mapkey(',iri', '#1Change CChan URL to region id', function() {
  _changeCchanUrl(null, 'id', true);
});
mapkey(',irt', '#1Change CChan URL to region th', function() {
  _changeCchanUrl(null, 'th', true);
});

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
