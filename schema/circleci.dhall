let Executor = ./executor.dhall

let Orb = ./orb.dhall

let Step = ./step.dhall

let ConfigurationType
    : Type
    = { executors : Executor.ConfigurationType, orbs : Orb.ConfigurationType }

let buildConfiguration =
        λ(arg : ConfigurationType)
      → { version = 2.1
        , executors = Executor.parseExecutors arg.executors
        , orbs = arg.orbs
        }

in  { buildConfiguration, Executor, Orb, Step }
