let Executor = ./executor.dhall

let Orb = ./orb.dhall

let Step = ./step.dhall

let Job = ./job.dhall

let Workflow = ./workflow.dhall

let ConfigurationType
    : Type
    = { orbs : Orb.ConfigurationType
      , executors : Executor.ConfigurationType
      , jobs : Job.ConfigurationType
      , workflows : Workflow.ConfigurationType
      }

let buildConfiguration =
        λ(arg : ConfigurationType)
      → { version = 2.1
        , orbs = arg.orbs
        , executors = Executor.parseExecutors arg.executors
        , jobs = Job.parseJobs arg.jobs
        , workflows = Workflow.parseWorkflows arg.workflows
        }

in  { buildConfiguration, Executor, Orb, Step, Job, Workflow }
