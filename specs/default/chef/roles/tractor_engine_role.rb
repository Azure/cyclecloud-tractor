name "tractor_engine_role"
description "Tractor Engine Role"
run_list("role[scheduler]",
  "recipe[cshared::directories]",
  "recipe[cuser]",
  "recipe[cshared::server]",
  "recipe[tractor::engine]",
  "recipe[cganglia::server]")

default_attributes "cyclecloud" => { "discoverable" => true }
