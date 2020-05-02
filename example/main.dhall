let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let Orb = dhall-circle.Orb

let orbs =
      { slack = Orb.orb "circleci/slack@3.4.1"
      , aws-cli = Orb.orb "circleci/aws-cli@1.0.0"
      , expiration = Orb.orb "azihsoyn/job-expiration@0.1.0"
      }

let executors =
      { terraform = Executor.docker "terraform" "hashicorp/terraform"
      , ubuntu = Executor.machine "ubuntu" "ubuntu-1604:201903-01"
      }

in  { configSample1 =
        dhall-circle.buildConfiguration
          { executors = Some (toMap executors), orbs = Some (toMap orbs) }
    , configSample2 =
        dhall-circle.buildConfiguration
          { executors = Executor.empty, orbs = Orb.empty }
    }
