let map = https://prelude.dhall-lang.org/List/map

let Executor = (./executor.dhall).Executor

let ExecutorData = (./executor.dhall).ExecutorData

let Step = (./step.dhall).Step

let JobExecutor
    : Type
    = < executor : ExecutorData | reference : Text >

let executorInline
    : Executor → JobExecutor
    = λ(executor : Executor) → JobExecutor.executor executor.data

let executorReference
    : Executor → JobExecutor
    = λ(executor : Executor) → JobExecutor.reference executor.name

let JobContent
    : Type
    = < executor : JobExecutor | steps : List Step >

let JobData
    : Type
    = List { mapKey : Text, mapValue : JobContent }

let Job
    : Type
    = { name : Text, data : JobData }

let jobArg
    : Type
    = { executor : JobExecutor, steps : List Step }

let job
    : Text → jobArg → Job
    =   λ(name : Text)
      → λ(arg : jobArg)
      → { name
        , data = toMap
            { executor = JobContent.executor arg.executor
            , steps = JobContent.steps arg.steps
            }
        }

let parseIn
    : Type
    = { mapKey : Text, mapValue : Job }

let parseOut
    : Type
    = { mapKey : Text, mapValue : JobData }

let parseJobs
    : List parseIn → List parseOut
    =   λ(x : List parseIn)
      → map
          parseIn
          parseOut
          (   λ(exec : parseIn)
            → { mapKey = exec.mapValue.name, mapValue = exec.mapValue.data }
          )
          x

let ConfigurationType
    : Type
    = List parseIn

in  { parseJobs
    , ConfigurationType
    , Job
    , executorInline
    , executorReference
    , job
    }
