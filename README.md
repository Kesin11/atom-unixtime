# atom-unixtime
[![Circle CI](https://circleci.com/gh/Kesin11/atom-unixtime.svg?style=svg&circle-token=a35736e9fd0f6a52065525aeaeb3dbb80bc25675)](https://circleci.com/gh/Kesin11/atom-unixtime)

Convert unitxtime <-> date string

![atom-unixtime.gif](https://raw.githubusercontent.com/Kesin11/image_repository/master/atom-unixtime.gif)

# Features
- Show unixtime(or date string) from selected date string(or unixtime)
- Insert unixtime(or date string) from inputed date string(or unixtime)

# Commands
- `atom-unixtime:show`: show unixtime or date string from selected text with notification popup.
- `atom-unixtime:insert`: insert unixtime or datestring from inputed text.

# Keymap
No default keymaps.

example
```coffeescript
'atom-text-editor':
  'alt-o': 'atom-unixtime:show'
  'alt-O': 'atom-unixtime:insert'
```

# TODO
  - [ ] add config view
  - [ ] add config to choice timezone
  - [ ] add config to using specific output date format
