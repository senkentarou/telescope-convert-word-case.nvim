local finders = require('telescope.finders')

local utils = require('convert_word_case.utilities')

local F = {}

F.finder = function(opts)
  opts = opts or {}

  return finders.new_table({
    results = {
      {
        'convert to snake_case',
        'snake_case',
      },
      {
        'convert to camelCase',
        'camelCase',
      },
      {
        'convert to UPPER_SNAKE_CASE',
        'UPPER_SNAKE_CASE',
      },
      {
        'convert to UpperCamelCase',
        'UpperCamelCase',
      },
      {
        'convert to lower-chain-case',
        'lower-chain-case',
      },
    },
    entry_maker = function(entry)
      local display = entry[1]
      local condition = entry[2]

      -- unshow result when converted_word is not converted
      local converted_word = utils.converter(opts.current_word, condition)
      if opts.current_word == converted_word then
        return
      end

      return {
        value = entry,
        display = display,
        ordinal = display,
        opts = {
          condition = condition,
          current_line = opts.current_line,
          current_word = opts.current_word,
          converted_word = converted_word,
        },
      }
    end,
  })
end

return F
