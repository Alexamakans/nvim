module.exports = grammar({
  name: 'xpath',

  conflicts: $ => [
    [$.expression, $.node_test],
  ],

  rules: {
    xpath: $ => $.expression,

    expression: $ => choice(
      $.binary_expression,
      $.path_expression,
      $.function_call,
      $.string_literal,
      $.number,
      $.variable_reference,
      $.attribute,
    ),

    binary_expression: $ => prec.left(1, seq(
      $.expression,
      choice('=', '!=', '<', '>', '<=', '>=', 'and', 'or', '+', '-', '*', 'div', 'mod'),
      $.expression,
    )),

    path_expression: $ => seq(
      optional(choice('.//', './', '//', '/')),
      $.step,
      repeat(seq(choice('//', '/'), $.step))
    ),

    step: $ => seq(
      optional(seq($.axis_name, '::')),
      $.node_test,
      repeat($.predicate),
    ),

    axis_name: $ => choice(
      'child', 'descendant', 'parent', 'ancestor',
      'following-sibling', 'preceding-sibling',
      'following', 'preceding', 'self',
      'descendant-or-self', 'ancestor-or-self',
      'attribute', 'namespace',
    ),

    node_test: $ => choice(
      $.name_test,
      $.attribute,
      seq('node', '(', ')'),
      seq('text', '(', ')'),
      seq('comment', '(', ')'),
    ),

    name_test: $ => choice(
      '*',
      seq($.identifier, ':', '*'),
      seq($.identifier, ':', $.identifier),
      $.identifier,
    ),

    predicate: $ => seq('[', $.expression, ']'),

    function_call: $ => seq(
      $.identifier,
      '(',
      optional(seq($.expression, repeat(seq(',', $.expression)))),
      ')'
    ),

    attribute: $ => seq('@', choice('*', $.identifier)),

    variable_reference: $ => seq('$', $.identifier),

    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_\-]*/,
    string_literal: $ => choice(/"[^"]*"/, /'[^']*'/),
    number: $ => /[0-9]+(\.[0-9]*)?/,
  }
});
