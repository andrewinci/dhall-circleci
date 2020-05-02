let map = https://prelude.dhall-lang.org/List/map

let fold = https://prelude.dhall-lang.org/Optional/fold

let Docker
    : Type
    = { docker : List { image : Text } }

let Machine
    : Type
    = { machine : { image : Text } }

let ExecutorData
    : Type
    = < docker : Docker | machine : Machine >

let Executor
    : Type
    = { name : Text, data : ExecutorData }

let docker
    : Text → Text → Executor
    =   λ(name : Text)
      → λ(image : Text)
      → { name, data = ExecutorData.docker { docker = [ { image } ] } }

let machine
    : Text → Text → Executor
    =   λ(name : Text)
      → λ(image : Text)
      → { name, data = ExecutorData.machine { machine.image = image } }

let parseIn
    : Type
    = { mapKey : Text, mapValue : Executor }

let parseOut
    : Type
    = { mapKey : Text, mapValue : ExecutorData }

let parseExecutors
    : Optional (List parseIn) → List parseOut
    =   λ(x : Optional (List parseIn))
      → map
          parseIn
          parseOut
          (   λ(exec : parseIn)
            → { mapKey = exec.mapKey, mapValue = exec.mapValue.data }
          )
          ( fold
              (List parseIn)
              x
              (List parseIn)
              (λ(t : List parseIn) → t)
              ([] : List parseIn)
          )

let ConfigurationType
    : Type
    = Optional (List parseIn)

let empty
    : Optional (List parseIn)
    = None (List parseIn)

in  { ConfigurationType, empty, parseExecutors, Executor, docker, machine }
