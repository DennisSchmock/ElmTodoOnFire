module Model exposing (..)

import Types exposing (..)


initialModel : Model
initialModel =
  { todos = [{ title = "The first todo"
    , completed = False
    , editing = False
    , identifier = 1
    }
  ]
  , todo = {newTodo | identifier = 2}
  , filter = All
  , nextIdentifier = 3
  }

newTodo : Todo
newTodo =
  {title = ""
  , completed = False
  , editing = False
  , identifier = 0}
