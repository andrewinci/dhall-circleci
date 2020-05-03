let dhall-circle = ../schema/circleci.dhall

let Executor = dhall-circle.Executor

let Orb = dhall-circle.Orb

let Step = dhall-circle.Step

let Job = dhall-circle.Job

let Workflow = dhall-circle.Workflow

let orbs = { terraform = Orb.orb "ovotech/terraform@1.6.6" }

let executors = { alpine = Executor.docker "alpine-executor" "alpine" }

let jobs =
      { job1 =
          Job.job
            "job-name"
            { executor = Job.executorReference executors.alpine
            , steps =
              [ Step.checkout
              , Step.attachWorkspaceAt "/"
              , Step.storeTestResultsFrom "./test-result.xml"
              , Step.run
                  { command =
                      ''
                      command here
                      ''
                  , name = "Run sample step"
                  }
              , Step.persistToWorkspace "/" [ "file1.txt", "file2.txt" ]
              , Step.step
                  { name = "terraform/plan", parameters = toMap { path = "/" } }
              ]
            }
      }

let workflows =
      { run =
        [ Workflow.job { job = jobs.job1, requires = Workflow.noRequirements } ]
      }

in  dhall-circle.buildConfiguration
      { orbs = Some (toMap orbs)
      , executors = Some (toMap executors)
      , jobs = toMap jobs
      , workflows = toMap workflows
      }
