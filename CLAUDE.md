# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for macOS. There is no application to build or test — changes are configuration files that take effect when the corresponding tool is launched (or reloaded). "Working" is verified by launching the tool, not by a test suite.

Target tools (per `README.md`): tmux, zsh (oh-my-zsh), neovim, starship.

## Layout model

The repo is laid out as if it were `$HOME`: tracked files sit at the paths where they are consumed (`.zshrc`, `.vimrc`, `.tmux.conf`, `.config/nvim/init.vim`, `.config/starship.toml`, `.ipython/profile_default/...`). The `.gitignore` uses anchored `/.name` patterns that ignore almost everything else at the home-directory root, so the working tree is intentionally noisy when the repo is checked out into `$HOME`.

Two consumption models are supported and both are in use:

- Clone directly into `$HOME` — files are consumed in place.
- Clone elsewhere and symlink — the `Makefile` does this for `.tmux.conf` (`tmux` target). Use the same pattern if adding install logic for other dotfiles; do not copy.

`Bin/` is a plain scripts directory added to `PATH` via `.zshrc` (`add_path ${HOME}/Bin`). Scripts referenced from other configs use `${HOME}/Bin/...` (see `.tmux.conf` status-right).

## Common commands

```bash
make help           # list targets (parses '## ' comments)
make install_core   # brew install the CORE_PACKAGES list
make tmux           # clone nord-tmux theme + symlink .tmux.conf into $HOME
```

Reloading after edits (no build step):

```bash
tmux source-file ~/.tmux.conf     # or press <prefix> r (prefix is C-q)
source ~/.zshrc
# nvim: :source ~/.vimrc  (BufWritePost on .vimrc also auto-sources it)
```

The `install_core` target depends on a `brew` target that is not defined in the `Makefile`; running it on a fresh machine will fail at that step. Don't "fix" this by guessing — treat it as an existing gap and ask before adding.

## Editor architecture (neovim)

`.config/nvim/init.vim` is a three-line shim that points `runtimepath`/`packpath` at `~/.vim` and then `source ~/.vimrc`. **All editor configuration lives in `.vimrc`** — edit there, not in `init.vim`.

- Plugin manager: `vim-plug` (`call plug#begin()` … `call plug#end()`).
- LSP/completion stack: `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig` + `nvim-cmp` (+ `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `LuaSnip`). Configured inside the single `lua << EOF … EOF` block in `.vimrc`.
- A stale `coc-settings.json` remains in `.config/nvim/` from the prior coc.nvim setup; the active LSP path is Mason, not coc. Don't wire new settings through coc.
- Leader is `,`. Folding uses treesitter (`foldexpr=nvim_treesitter#foldexpr()`).

## Shell architecture (zsh)

- Framework: oh-my-zsh at `$ZSH` (default `~/.oh-my-zsh`). Plugins are appended conditionally — `zsh-autosuggestions` and `zsh-syntax-highlighting` are only added if their custom-plugin directories exist, and print install hints when missing. Preserve this pattern; don't make plugins unconditional.
- Prompt: starship (initialized only if `starship` is on `PATH`).
- Vi mode is on (`bindkey -v`) with a large set of emacs keybinds re-added in insert mode. When changing keybindings, check both the `bindkey` block and the per-mode `cnoremap`/`inoremap` blocks in `.vimrc` so the two stay consistent.
- Local-only overrides go in `~/.zshrc.local` (sourced at the end of `.zshrc`, not tracked).
- Global aliases (`alias -g`) are used heavily (`C`, `J`, `L`, `BR`, `CMT`, `MF`, …). These expand anywhere on the command line, so new ones can collide with arbitrary arguments — pick uppercase/unusual tokens.

## Tmux

Prefix is `C-q` (not `C-b`). Splits use `v`/`s` and inherit `pane_current_path`. The status-right is produced by `Bin/tmux-status-right` (zsh script); if you add new status segments, extend that script rather than inlining shell in `.tmux.conf`. Theme is nord-tmux, cloned into `~/.tmux/themes/nord-tmux` by `make tmux`.

## Other tools

- `.ipython/profile_default/ipython_config.py` — vi editing + autoreload. `startup/00-init.py` re-adds emacs-style motions inside vi insert mode via `prompt_toolkit` key bindings; mirror the `.zshrc` keymap if you change one.
- `firefox/` — SurfingKeys JS config and a userChrome.css theme. `firefox/README.md` documents required `about:config` flags and the remote SurfingKeys URL (`raw.githubusercontent.com/hamasho/dotfiles/main/firefox/surferingKeys.conf.js`); keep that filename/path in sync if renaming.
- `iTerm2/Default.json` and `iTerm2/com.googlecode.iterm2.plist` are exported iTerm2 settings — regenerate by re-exporting from iTerm2 rather than hand-editing.

## Conventions

- Commit messages are short and scoped: `area: short description` (e.g. `zsh: Add o=docker alias`, `iTerm2: Update wallpaper`, `neovim: Use lualine.nvim instead of lightline`). Bare `update` is also common for small tweaks. Match the existing style.
- Nord is the shared color theme across tmux, neovim, starship, SurfingKeys, and Firefox userChrome. When adding color, pull from the Nord palette already referenced in those files rather than introducing a new scheme.
- Paths assume macOS with Homebrew at `/opt/homebrew` (Apple Silicon). Linux fallbacks exist in a few places (`/usr/share/fzf`, `/usr/bin/firefox`); preserve both branches when touching those blocks.
