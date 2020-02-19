module CurrentTime exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing(..)
import Task
import Time

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }


-- MODEL
type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0), setTime )


-- UPDATE
type Msg = SetTime (Time.Zone, Time.Posix)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetTime (zone, time) ->
      ({model|zone = zone, time = time}, Cmd.none)

setTime : Cmd Msg
setTime =
  Task.perform SetTime <| Task.map2 Tuple.pair Time.here Time.now

-- VIEW

view : Model -> Html Msg
view model = 
  let
    year = String.fromInt <| Time.toYear model.zone model.time
    month = Debug.toString <| Time.toMonth model.zone model.time
    day = String.fromInt <| Time.toDay model.zone model.time
    hour = String.fromInt <| Time.toHour model.zone model.time
    minute = String.fromInt <| Time.toMinute model.zone model.time
    second = String.fromInt <| Time.toSecond model.zone model.time
  in
  div []
    [text <| day ++ " " ++ month ++ " " ++ year ++ " " ++ hour ++ ":" ++ minute ++ ":" ++ second]