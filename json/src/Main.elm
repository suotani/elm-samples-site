module JsonGet exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing(..)

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }


-- MODEL
type alias Model = {}

init : () -> (Model, Cmd Msg)

-- UPDATE
type Msg

update : Msg -> Model -> (Model, Cmd Msg)

-- VIEW

view : Model -> Html Msg
view model = 
  div []
    []