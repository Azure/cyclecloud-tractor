name "tractor_blade_role"
description "Tractor Blade Role"
run_list("recipe[cshared::client]",
  "recipe[cuser]",
  "recipe[tractor::blade]",
  "recipe[cganglia::client]")


