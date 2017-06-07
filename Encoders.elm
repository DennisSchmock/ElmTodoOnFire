port module Encoders exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Decode as Decode
import Json.Encode
import Types exposing (..)

import Json.Decode.Pipeline exposing (decode, required)
import Json.Decode as Decode
import Json.Encode

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  storageInput mapStorageInput

--Encoders
encodeJson : Model -> Json.Encode.Value
encodeJson model =
  Json.Encode.object
  [("todos", Json.Encode.list (List.map encodeTodo model.todos))
  ,("todo", encodeTodo model.todo)
  ,("filter", encodeFilterState model.filter)
  ,("nextIdentifier", Json.Encode.int model.nextIdentifier)
  ]

encodeTodo : Todo -> Json.Encode.Value
encodeTodo todo =
  Json.Encode.object
    [("title", Json.Encode.string todo.title)
    ,("completed", Json.Encode.bool todo.completed)
    ,("editing", Json.Encode.bool todo.editing)
    ,("identifier",Json.Encode.int todo.identifier)]

encodeFilterState : FilterState -> Json.Encode.Value
encodeFilterState filterState =
  Json.Encode.string (toString filterState)


mapStorageInput : Decode.Value -> Msg
mapStorageInput modelJson =
  case (decodeModel modelJson) of
    Ok model ->
      SetModel model
    Err errorMessage ->
      let
        _ = Debug.log "Error in mapStorageInput" errorMessage
      in
        NoOp

-- Decoders
decodeModel : Decode.Value -> Result String Model
decodeModel modelJson =
  Decode.decodeValue modelDecoder modelJson

modelDecoder : Decode.Decoder Model
modelDecoder =
  decode Model
    |> required "todos" (Decode.list todoDecoder)
    |> required "todo" todoDecoder
    |> required "filter" (Decode.string |> Decode.map filterStateDecoder)
    |> required "nextIdentifier" Decode.int


todoDecoder : Decode.Decoder Todo
todoDecoder =
  decode Todo
    |> required "title" Decode.string
    |> required "completed" Decode.bool
    |> required "editing" Decode.bool
    |> required "identifier" Decode.int


filterStateDecoder : String -> FilterState
filterStateDecoder string =
  case string of
    "All" -> All
    "Active" -> Active
    "Completed" -> Completed
    _->
      let
        _ = Debug.log "filterStateDecoder" <|
          "Couldn't decode value " ++ string ++
          " so defaulting to All"
      in
        All

sendToStorage : Model -> Cmd Msg
sendToStorage model =
  encodeJson model |> storage

-- INPUT PORTS
port storageInput : (Decode.Value -> msg) -> Sub msg

--OUTPUT PORTS
port storage : Json.Encode.Value -> Cmd msg
