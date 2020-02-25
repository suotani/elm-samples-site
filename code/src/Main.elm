module Code exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http

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

init : String -> (Model, Cmd Msg)
init codePath =
  ("Loading..."
  , Http.get
      { url = codePath
      , expect = Http.expectString GotCode
      }
  )

-- UPDATE
type Msg = GotCode (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotCode result ->
      case result of
        Ok code ->
          (code , Cmd.none)
        
        Err _ ->
          (model, Cmd.none)

-- VIEW

view : Model -> Html Msg
view code = 
  div [ ]
    [ div [class "code"] [ pre [] [text code] ]]
