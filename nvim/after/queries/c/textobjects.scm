;;extends

(declaration
  type: (_) @type)

(parameter_declaration
  type: (_) @type)

(function_definition
  type: (_) @type)

(_
  body: (_
    .
    "{"
    .
    (_) @_start
    (_)? @_end ","? @_end
    .
    "}"
    (#make-range! "block.inner" @_start @_end)))

((_
  body: (_
    "{"
    (_)
    (_)?
    "}" @_end)) @_start ";"? @_end
    (#make-range! "block.outer" @_start @_end)
)
