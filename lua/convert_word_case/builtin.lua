local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local config = require('telescope.config').values

local convert_word_case_finders = require('convert_word_case.finders')
local convert_word_case_previewers = require('convert_word_case.previewers')
local convert_word_case_actions = require('convert_word_case.actions')

local B = {}

B.convert_word_case = function(opts)
  opts = opts or {}
  opts.bufnr = vim.fn.bufnr()
  opts.current_line = vim.fn.line('.')
  opts.current_word = vim.fn.expand("<cword>")

  if not opts.current_word:find('[a-zA-Z_]') then
    vim.notify('no convert case: ' .. opts.current_word)
    return
  end

  pickers.new(opts, {
    prompt_title = 'case "' .. opts.current_word .. '"',
    results_title = 'convert actions',
    finder = convert_word_case_finders.finder(opts),
    previewer = convert_word_case_previewers.previewer(opts),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<C-r>", convert_word_case_actions.convert)
      map("n", "r", convert_word_case_actions.convert)
      -- <CR> action
      actions.select_default:replace(convert_word_case_actions.convert_by_lsp)

      return true
    end,
  }):find()
end

return B
