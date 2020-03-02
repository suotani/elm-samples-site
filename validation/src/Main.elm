module Validation exposing (..)
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
type alias Model =
  { name : String
  , nameErrors : List String
  }

init : () -> (Model, Cmd Msg)
init _ = (Model "" [], Cmd.none)

-- UPDATE
type Msg
  = InputName String
  | Submit

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    InputName name ->
      ({model | name = name}, Cmd.none)
    
    Submit ->
      ({model | nameErrors = (validName model.name)}, Cmd.none)

validName : String -> List String
validName name =
  maxLength 7 name []
  |> minLength 3 name
  |> onlyAlphabet name

maxLength : Int -> String -> List String -> List String
maxLength n str errors =
  if n < (String.length str) then
    ("Too Long max " ++ (String.fromInt n) ++ "length") :: errors
  else
    errors

minLength : Int -> String -> List String -> List String
minLength n str errors =
  if n > (String.length str) then
    ("Too Short min " ++ (String.fromInt n) ++ "length") :: errors
  else
    errors

onlyAlphabet : String -> List String -> List String
onlyAlphabet str errors =
  if (List.all (\s -> Char.isAlpha s) <| String.toList str) then
    errors
  else
    "Only Alphabet" :: errors

-- VIEW

view : Model -> Html Msg
view model = 
  div [class "main-form"]
    [ div [class "input-area"]
        [ div [class "input"]
            [ input [type_ "text", value model.name, onInput InputName] []
            , div [] (List.map (\e -> p [] [text e]) model.nameErrors)
            ]
        , div [class "input"]
            [ button [ onClick Submit ] [ text "Submit" ] ]
        , div []
            [ h3 [] [text "Rule"]
            , p [] [text "Max langth 7"]
            , p [] [text "Min length 3"]
            , p [] [text "Only alphabet"]
            ] 
        ]
    ]