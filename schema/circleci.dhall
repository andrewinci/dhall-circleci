let Executor = ./executor.dhall

let ConfigurationType
    : Type
    = { executors : Executor.ConfigurationType }

let Configuration =
        λ(arg : ConfigurationType)
      → { version = 2.1, executors = Executor.parseExecutors arg.executors }

in  { Configuration, Executor }
