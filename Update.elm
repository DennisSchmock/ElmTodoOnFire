module Update exposing (..)

import Model exposing (..)
import Types exposing (..)
import Encoders exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Add ->
      let
        newModel =
          {model
            | todos = model.todo :: model.todos
            ,todo = {newTodo | identifier = model.nextIdentifier}
            , nextIdentifier = model.nextIdentifier + 1}
      in
        (newModel,sendToStorage newModel)
    Complete todo ->
      let
        updateTodo thisTodo =
          if thisTodo.identifier == todo.identifier then
            {todo | completed = True}
          else
            thisTodo
        newModel =
          { model |todos = List.map updateTodo model.todos }
      in
        (newModel
        , sendToStorage newModel)

    Delete todo ->
      let
        newModel =
          {model
            | todos = List.filter (\mappedTodo -> todo.identifier /= mappedTodo.identifier) model.todos}
      in
        (newModel, sendToStorage newModel)



    UpdateField str ->
      let
        todo = model.todo
        updatedTodo = { todo | title = str}
        newModel = { model | todo = updatedTodo}
      in
        (newModel, Cmd.none)
    Filter filterState ->
      let
        newModel =
        {model | filter = filterState}
      in (newModel , sendToStorage newModel)

    Clear ->
      let newModel =
        {model
          | todos = List.filter (\todo -> todo.completed == False) model.todos}
      in
        ( newModel, sendToStorage newModel)

    SetModel newModel ->
      (newModel, Cmd.none)

    NoOp ->
      (model, Cmd.none)
