local U = {}

local camel_to_snake = function(word)
  return word:gsub('([a-z])([A-Z])', '%1_%2')
end

local snake_to_camel = function(word)
  return word:gsub('(_)([a-z])', function(_, l)
    return l:upper()
  end)
end

U.converter = function(word, condition)
  if condition == 'snake_case' then
    return camel_to_snake(word):lower()
  elseif condition == 'camelCase' then
    return snake_to_camel(word)
  elseif condition == 'UPPER_SNAKE_CASE' then
    return camel_to_snake(word):upper()
  elseif condition == 'UpperCamelCase' then
    return snake_to_camel(word):gsub('^([a-z])', function(l)
      return l:upper()
    end)
  elseif condition == 'lower-chain-case' then
    return camel_to_snake(word):gsub('([a-z])_([a-z])', '%1-%2')
  end

  vim.notify('cannot convert: "' .. word .. '" by "' .. condition .. '"')
end

return U
