let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let Orb = dhall-circle.Orb

let Step = dhall-circle.Step

let Job = dhall-circle.Job

let Workflow = dhall-circle.Workflow

let executors = { alpine = Executor.docker "alpine-executor" "alpine" }

let jobs =
      { hello =
          Job.job
            "Hello"
            { executor = Job.executorReference executors.alpine
            , steps =
              [ Step.run { command = "echo Hello", name = "Echo Hello" } ]
            }
      , world =
          Job.job
            "World"
            { executor = Job.executorReference executors.alpine
            , steps =
              [ Step.run { command = "echo Hello", name = "Echo World" } ]
            }
      }

let hello =
      Workflow.job { job = jobs.hello, requires = Workflow.noRequirements }

let workflows =
      { a_workflow =
        [ hello, Workflow.job { job = jobs.world, requires = [ hello ] } ]
      , another_workflow =
        [ hello
        , Workflow.job { job = jobs.world, requires = Workflow.noRequirements }
        ]
      }

in  dhall-circle.buildConfiguration
      { orbs = Orb.empty
      , executors = Some (toMap executors)
      , jobs = toMap jobs
      , workflows = toMap workflows
      }
