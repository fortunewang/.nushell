# Nushell Environment Config File

alias ln = coreutils ln
alias cat = open -r

def pwd [] {
  $env.PWD
}

def create_left_prompt [] {
  let home = ('~' | path expand)
  let curr = ($env.PWD | path expand)
  let curr = if ($curr == $home) {
    '~'
  } else {
    $env.PWD
  }
  $"(ansi blue_bold)($curr)(ansi reset)"
}

def create_right_prompt [] {
  (date now | date format '%Y-%m-%d %H:%M:%S')
}

def create_prompt_indicator [] {
  if (is-admin) {
    $" (ansi red_bold)('#')(ansi reset) "
  } else {
    $" (ansi blue_bold)('$')(ansi reset) "
  }
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { create_prompt_indicator }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "> " }
let-env PROMPT_MULTILINE_INDICATOR = { "... " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "PATHEXT": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'modules'),
  ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
  ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
