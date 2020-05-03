let CustomStep
    : Type
    = List { mapKey : Text, mapValue : Text }

let StepValue
    : Type
    = < persist : { root : Text, paths : List Text } | custom : CustomStep >

let Step
    : Type
    = < step : List { mapKey : Text, mapValue : StepValue } | empty : Text >

let step =
        λ ( arg
          : { name : Text
            , parameters : List { mapKey : Text, mapValue : Text }
            }
          )
      → Step.step
          [ { mapKey = arg.name, mapValue = StepValue.custom arg.parameters } ]

let emptyStep
    : Text → Step
    = λ(name : Text) → Step.empty name

let run =
        λ(arg : { name : Text, command : Text })
      → step { name = "run", parameters = toMap arg }

let attachWorkspaceAt
    : Text → Step
    =   λ(at : Text)
      → step { name = "attach_workspace", parameters = toMap { at } }

let storeTestResultsFrom
    : Text → Step
    =   λ(path : Text)
      → step { name = "store_test_results", parameters = toMap { path } }

let persistToWorkspace
    : Text → List Text → Step
    =   λ(root : Text)
      → λ(paths : List Text)
      → Step.step
          [ { mapKey = "persist_to_workspace"
            , mapValue = StepValue.persist { root, paths }
            }
          ]

let checkout = emptyStep "checkout"

in  { Step
    , run
    , attachWorkspaceAt
    , checkout
    , persistToWorkspace
    , storeTestResultsFrom
    , step
    , emptyStep
    }
