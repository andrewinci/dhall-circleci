let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let Orb = dhall-circle.Orb

let Step = dhall-circle.Step

let Job = dhall-circle.Job

let Workflow = dhall-circle.Workflow

let dhall-yaml-release =
      "https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-yaml-1.0.3-x86_64-linux.tar.bz2"

let dhall-release =
      "https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-1.31.1-x86_64-linux.tar.bz2"

let executors = { alpine = Executor.docker "alpine" "alpine" }

let jobs =
      { dependencies =
          Job.job
            "Make"
            { executor = Job.executorReference executors.alpine
            , steps =
              [ Step.run
                  { command =
                      ''
                      apk add jq curl make git openssh
                      ''
                  , name = "Install dependencies"
                  }
              , Step.run
                  { command =
                      ''
                      cd /
                      curl -L -O ${dhall-yaml-release}
                      tar xvf dhall*.tar.bz2
                      rm -rf dhall-*.tar.bz2
                      curl -L -O ${dhall-release}
                      tar xvf dhall*.tar.bz2
                      ''
                  , name = "Install dhall-yaml"
                  }
              , Step.checkout
              , Step.run { command = "make", name = "Test" }
              ]
            }
      }

let workflows =
      { test =
        [ Workflow.job
            { job = jobs.dependencies, requires = Workflow.noRequirements }
        ]
      }

in  dhall-circle.buildConfiguration
      { orbs = Orb.empty
      , executors = Some (toMap executors)
      , jobs = toMap jobs
      , workflows = toMap workflows
      }
