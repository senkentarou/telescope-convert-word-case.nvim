local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local utils = require('convert_word_case.utilities')

local A = {}

A.convert = function(bufnr)
  actions.close(bufnr)

  local selection = action_state.get_selected_entry()
  local opts = selection.opts

  local converted_word = utils.converter(opts.current_word, opts.condition)
  if opts.current_word == converted_word then
    return
  end

  -- search word only current line
  -- https://vimhelp.org/builtin.txt.html#searchpos%28%29
  local row_pos, col_pos = unpack(vim.fn.searchpos(opts.current_word, 'bcn', opts.current_line))

  if row_pos == 0 or col_pos == 0 then
    return
  end

  -- replace word
  vim.api.nvim_buf_set_text(0, row_pos - 1, col_pos - 1, row_pos - 1, col_pos - 1 + #opts.current_word, {
    converted_word,
  })
end

A.convert_by_lsp = function(bufnr)
  actions.close(bufnr)

  local selection = action_state.get_selected_entry()
  local converted_word = utils.converter(selection.opts.current_word, selection.opts.condition)

  if selection.opts.current_word == converted_word then
    return
  end

  -- replace by vim.lsp
  local params = vim.lsp.util.make_position_params()
  params.newName = converted_word
  vim.lsp.buf_request(0, 'textDocument/rename', params)
end

return A
