module Types exposing (..)

type FilterState
  = All
  | Active
  | Completed


type alias Model =
  { todos   : List Todo
  , todo   : Todo
  , filter  : FilterState
  , nextIdentifier: Int}

type alias Todo =
  { title     : String
  , completed : Bool
  , editing   : Bool
  , identifier : Int}

type Msg
    = Add
    | Complete Todo
    | Delete Todo
    | UpdateField String
    | Filter FilterState
    | Clear
    | SetModel Model
    | NoOp
