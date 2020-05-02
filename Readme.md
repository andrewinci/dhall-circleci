# dhall-circleci

Schema to create circle-ci configuration with dhall.

## Types

List of available types

### Executors

`Executor` map to [CircleCI Executor](https://circleci.com/docs/2.0/configuration-reference/#executors-requires-version-21)

*Syntax*:

- `Executor.docker executor-name docker-image`
- `Executor.machine executor-name machine-image`

Example:

```dhall
let dhall-circle = <repo-url>

-- import Executor package
let Executor = dhall-circle.Executor

--  docker executor

let terraform = Executor.docker "terraform" "hashicorp/terraform"

-- machine executor

ubuntu = Executor.machine "ubuntu" "ubuntu-1604:201903-01"
```
