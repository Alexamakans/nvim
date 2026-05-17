; extends

; XPath string injection
(string
  (string_content) @injection.content
  (#match? @injection.content "^(\\(?\\.\\.?//)|(^\\(?\\.\\.?/)|(^\\(?//)|(^\\(?/)|(normalize-space)")
  (#set! injection.language "xpath")
  (#set! injection.include-children true))
