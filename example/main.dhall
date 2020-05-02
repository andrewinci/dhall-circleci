let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let executors =
      { terraform = Executor.docker "terraform" "hashicorp/terraform"
      , ubuntu = Executor.machine "ubuntu" "ubuntu-1604:201903-01"
      }

in  dhall-circle.Configuration { executors = Some (toMap executors) }
