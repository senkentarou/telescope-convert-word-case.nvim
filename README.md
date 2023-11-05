# telescope-convert-word-case
* This is an integration plugin with [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* This plugin can convert word case by lsp rename or just cword with preview.

## Installation
* vim-plug
```
Plug 'nvim-telescope/telescope.nvim'
Plug 'senkentarou/telescope-convert-word-case.nvim'
```

## Setup
* Please setup as telescope extension on `init.lua` as below:
```
local telescope = require("telescope")

telescope.setup {
  ...
}

telescope.load_extension("convert_word_case")
```

## Commands
* example:
```
:lua require('telescope').extensions.convert_word_case.convert_word_case()
```

## For development
* Load under development plugin files on root repository.
* `nvim --cmd "set rtp+=."`

## Special thanks
* this extension is very inspired by [johmsalas/text-case.nvim](https://github.com/johmsalas/text-case.nvim)
