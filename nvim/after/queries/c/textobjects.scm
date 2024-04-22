;;extends
(declaration
  type: (_) @type)

(parameter_declaration
  type: (_) @type)

(function_definition
  type: (_) @type)

(_ (compound_statement) @block.inner) @block.outer
