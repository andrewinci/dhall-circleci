let map = https://prelude.dhall-lang.org/List/map

let Job = ./job.dhall

let WorkflowContent
    : Type
    = { requires : List Text }

let WorkflowJob
    : Type
    = { name : Text, data : WorkflowContent }

let job
    : { job : Job.Job, requires : List WorkflowJob } → WorkflowJob
    =   λ(arg : { job : Job.Job, requires : List WorkflowJob })
      → { name = arg.job.name
        , data.requires =
            map WorkflowJob Text (λ(w : WorkflowJob) → w.name) arg.requires
        }

let noRequirements = [] : List WorkflowJob

let parseIn
    : Type
    = { mapKey : Text, mapValue : List WorkflowJob }

let parseOut
    : Type
    = { mapKey : Text
      , mapValue : List (List { mapKey : Text, mapValue : WorkflowContent })
      }

let mapWorkflowJob
    :   List WorkflowJob
      → List (List { mapKey : Text, mapValue : WorkflowContent })
    =   λ(arg : List WorkflowJob)
      → map
          WorkflowJob
          (List { mapKey : Text, mapValue : WorkflowContent })
          (λ(x : WorkflowJob) → [ { mapKey = x.name, mapValue = x.data } ])
          arg

let parseWorkflows
    : List parseIn → List parseOut
    =   λ(arg : List parseIn)
      → map
          parseIn
          parseOut
          (   λ(x : parseIn)
            → { mapKey = x.mapKey, mapValue = mapWorkflowJob x.mapValue }
          )
          arg

let ConfigurationType
    : Type
    = List parseIn

in  { job, noRequirements, ConfigurationType, parseWorkflows }
