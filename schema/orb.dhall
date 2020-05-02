let Orb
    : Type
    = Text

let orb
    : Text → Orb
    = λ(value : Text) → value

let ConfigurationType
    : Type
    = Optional (List { mapKey : Text, mapValue : Text })

let empty
    : ConfigurationType
    = None (List { mapKey : Text, mapValue : Text })

in  { empty, ConfigurationType, Orb, orb }
