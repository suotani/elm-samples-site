module SimpleForm exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }


-- MODEL

type alias Model = String

init : () -> (Model, Cmd Msg)
init _ =
  ("", Cmd.none)

-- UPDATE

type Msg
  = Input String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Input name ->
      (name, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model = 
  div [class "main"]
    [ div [class "input-area"]
        [ div [class "input"]
            [ input [ type_ "text", placeholder "Name", value model, onInput Input ] [] ]
        ]
    , div [class "output-area"]
        [ div [class "output"] 
            [text model]
        ]
    ]