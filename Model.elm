module Model exposing (..)

import Types exposing (..)


initialModel : Model
initialModel =
  { todos = [
  ]
  , todo = {newTodo | identifier = 1}
  , filter = All
  , nextIdentifier = 2
  }

newTodo : Todo
newTodo =
  {title = ""
  , completed = False
  , editing = False
  , identifier = 0}
