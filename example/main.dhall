let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let Orb = dhall-circle.Orb

let Step = dhall-circle.Step

let orbs =
      { slack = Orb.orb "circleci/slack@3.4.1"
      , aws-cli = Orb.orb "circleci/aws-cli@1.0.0"
      , expiration = Orb.orb "azihsoyn/job-expiration@0.1.0"
      }

let executors =
      { terraform = Executor.docker "terraform" "hashicorp/terraform"
      , ubuntu = Executor.machine "ubuntu" "ubuntu-1604:201903-01"
      }

let steps =
      [ Step.checkout
      , Step.attachWorkspaceAt "/"
      , Step.storeTestResultsFrom "./test-result.xml"
      , Step.run
          { command =
              ''
              command here
              ''
          , name = "Run sample step"
          }
      , Step.persistToWorkspace "/" [ "file1.txt", "file2.txt" ]
      , Step.step
          { name = "custom step"
          , parameters = toMap { param1 = "123", param2 = "321" }
          }
      ]

in  { configSample1 =
        dhall-circle.buildConfiguration
          { executors = Some (toMap executors), orbs = Some (toMap orbs) }
    , configSample2 =
        dhall-circle.buildConfiguration
          { executors = Executor.empty, orbs = Orb.empty }
    , steps
    }
