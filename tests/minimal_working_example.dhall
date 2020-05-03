let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let Orb = dhall-circle.Orb

let Step = dhall-circle.Step

let Job = dhall-circle.Job

let Workflow = dhall-circle.Workflow

let executors = { alpine = Executor.docker "alpine-executor" "alpine" }

let jobs =
      { echo =
          Job.job
            "Hello world job"
            { executor = Job.executorReference executors.alpine
            , steps =
              [ Step.run
                  { command = "echo Hello world", name = "Echo something" }
              ]
            }
      }

let workflows =
      { run =
        [ Workflow.job { job = jobs.echo, requires = Workflow.noRequirements } ]
      }

in  dhall-circle.buildConfiguration
      { orbs = Orb.empty
      , executors = Some (toMap executors)
      , jobs = toMap jobs
      , workflows = toMap workflows
      }
