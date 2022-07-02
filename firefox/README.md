Firefox setup
=============

## Overview

I use Firefox's native account sync functionality to manage most of addons.
But few addons require external configs.

* SurfingKeys
  * Flexible, vim-like key-bindings for browse the internet
  * https://github.com/brookhong/Surfingkeys
  * surfingKeys.conf.js
* Slick-Fox
  * Simple theme. Enable auto-hide URL bar.
  * https://github.com/Etesam913/slick-fox
  * userChrome.css

## Setup

Set up about:config with the following configs.

Key|Value|Memo
--|--|--
`toolkit.legacyUserProfileCustomizations.stylesheets` | `true` | To enable Slick-Fox's theme
`ui.prefersReducedMotion` | `1: number` | To enable Slick-Fox's theme (Create the item if not exists)
`services.sync.prefs.sync.browser.uiCustomization.state` | `true` | To [sync toolbar layout](https://support.mozilla.org/en-US/questions/1292568)

Set up surfing keys by setting the addon's remote config URL by this:

  https://raw.githubusercontent.com/hamasho/dotfiles/main/firefox/surferingKeys.conf.js

Set up Firefox userChrome.css by copy `userChrome.css` to profile's chrome library.

```bash
profile_dir=$(ls "${HOME}/Library/Application Support/Firefox/Profiles" | grep "\.default-release$")
mkdir -p "$profile_dir/chrome"
cp ./firefox/userChrome.css "$profile_dir/chrome/"
```
