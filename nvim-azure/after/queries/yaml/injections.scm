; extends

(block_mapping
  ;; 1) task: ...
  (block_mapping_pair
    key: (flow_node) @task_key
    value: (_))
  (#eq? @task_key "task")
  ;; 2) ...
  ;; 3) then inputs:
  (block_mapping_pair
    key: (flow_node) @inputs_key
    (#eq? @inputs_key "inputs")
    value: (block_node
      (block_mapping
        ;; 4) inside inputs: scriptType: inlineScript
        (block_mapping_pair
          key: (flow_node) @stype_key
          (#eq? @stype_key "scriptType")
          value: (flow_node) @stype_val)
          (#eq? @stype_val "inlineScript")
        ;; 5) later: inline: |  <block>
        (block_mapping_pair
          key: (flow_node) @inline_key
          (#eq? @inline_key "inline")
          value: (block_node
            (block_scalar) @injection.content
            (#set! injection.language "ps1")
            ;; trim off the first character so '|' never reaches ps1
            (#offset! @injection.content 0 1 0 0)))))))

(block_mapping_pair
  key: (flow_node) @key
  (#eq? @key "powershell")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "ps1")
    ;; trim off the first character so '|' never reaches ps1
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @key
  (#eq? @key "bash")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    ;; trim off the first character so '|' never reaches ps1
    (#offset! @injection.content 0 1 0 0)))
