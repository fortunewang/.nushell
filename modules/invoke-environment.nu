#
# inspired by: https://github.com/nightroman/PowerShelf/blob/main/Invoke-Environment.ps1
#

export def-env main [cmd] {
  (^cmd.exe /C $'"($cmd)"' '>NUL' '2>&1' '&&' 'SET') | lines | reduce -f {} { |line, acc|
    let idx = ($line | str index-of '=')
    if ($idx > 0) {
      let key = ($line | str substring $',($idx)')
      # The environment variable 'FILE_PWD' is set automatically by Nushell
      # and cannot not be set manually
      if ($key == 'FILE_PWD') {
        $acc
      } else {
        let value = ($line | str substring $'($idx + 1),')
        let value = if ($key == "Path") {
          (do $env.ENV_CONVERSIONS.Path.from_string $value)
        } else {
	      $value
        }
        ($acc | upsert $key $value)
      }
    } else {
      $acc
    }
  } | load-env
}
