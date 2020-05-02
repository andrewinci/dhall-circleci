# dhall-circleci

Schema to create circle-ci configuration with dhall.

## Builders

List of available builders.

### Configuration

`Configuration` map to a whole configuration file.

*Example*: see `example/main.dhall`

### Executor

`Executor` map to [CircleCI Executor](https://circleci.com/docs/2.0/configuration-reference/#executors-requires-version-21)

*Syntax*:

- `Executor.docker "executor-name" "docker-image"`
- `Executor.machine "executor-name" "machine-image"`

*Example*:

```dhall
let dhall-circle = <repo-url>

-- import Executor package
let Executor = dhall-circle.Executor

--  docker executor

let terraform = Executor.docker "terraform" "hashicorp/terraform"

-- machine executor

ubuntu = Executor.machine "ubuntu" "ubuntu-1604:201903-01"
```

### Orb

`Orb` map to [CircleCI Orb](https://circleci.com/docs/2.0/configuration-reference/#orbs-requires-version-21)

*Syntax*:

- `Orb.orb "orb-name"`

*Example*:

```dhall
let dhall-circle = <repo-url>

-- import Orb package
let Orb = dhall-circle.Orb

let aws-cli-orb = Orb.orb "circleci/aws-cli@1.0.0"

```
