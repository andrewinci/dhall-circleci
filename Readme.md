# dhall-circleci

Set of functions to create a circle-ci configuration with dhall.

## Builders

List of available builders.

### Configuration

`Configuration` map to a whole configuration file.

*Example*: see `example/main.dhall`

### Executor

`Executor` map to [CircleCI Executor](https://circleci.com/docs/2.0/configuration-reference/#executors-requires-version-21)

*Builders*:

- `Executor.docker "executor-name" "docker-image"`

```yaml
executor-name:
    docker:
    - image: docker-image
```

- `Executor.machine "executor-name" "machine-image"`

```yaml
executor-name:
    machine:
    image: "machine-image"
```

### Orb

`Orb` map to [CircleCI Orb](https://circleci.com/docs/2.0/configuration-reference/#orbs-requires-version-21)

*Builders*:

- `Orb.orb "orb-name"`

```yaml
"orb-name"
```

### Step

`Step` map to [CircleCI Steps](https://circleci.com/docs/2.0/configuration-reference/#steps)

*Builders*:

- `Step.checkout`

```yaml
- checkout
```

- `Step.attachWorkspaceAt "path"`

``` yaml
- attach_workspace:
    at: path
```

- `Step.storeTestResultsFrom "test-path"`

``` yaml
- store_test_results:
    path: "test-path"
```

- `Step.run
  { command =
      ''
      command here
      ''
  , name = "step name"
  }`

```yaml
- run:
    command: |
      command here
    name: Run sample step
```

- `Step.persistToWorkspace "root" [ "file1.txt", "file2.txt" ]`

```yaml
- persist_to_workspace:
    paths:
    - file1.txt
    - file2.txt
    root: root
```

- `Step.step
  { name = "custom step"
  , parameters = toMap { param1 = "123", param2 = "321" }
  }`

```yaml
- custom step:
    param1: '123'
    param2: '321'
```

### Job

`Job` map to [CircleCI Job](https://circleci.com/docs/2.0/configuration-reference/#jobs)

*Builders*:

```dhall
Job.job "job-name"
    { executor: executor
    , steps=[List of steps]
    }
```

To specify the executor we can use:

- `Job.executorInline`
- `Job.executorReference`
