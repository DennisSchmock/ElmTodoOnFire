port module Main exposing (..)

import Html exposing (..)

import Types exposing (..)
import Model exposing (..)
import View exposing (..)
import Update exposing (..)
import Encoders exposing (..)



main : Program Never Model Msg
main = Html.program
  {init = (initialModel, Cmd.none)
  , update = update
  , view = view
  , subscriptions = subscriptions}
