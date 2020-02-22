module RandomInt exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing(..)
import Random
-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }


-- MODEL
type alias Model = Int

init : () -> (Model, Cmd Msg)
init _ = (1, Cmd.none)

-- UPDATE
type Msg
  = Shuffle
  | SetRandom Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Shuffle ->
      (model, Random.generate SetRandom (Random.int 1 100))
    
    SetRandom r ->
      (r, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ text <| String.fromInt model
    , button [onClick Shuffle] [text "shuffle"]
    ]