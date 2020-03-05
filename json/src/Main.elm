module JsonGet exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing(..)
import Http
import Json.Decode exposing (Decoder, Error, int, string, float, list, map3, field)

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }


-- MODEL
type alias User = 
  { name : String
  , age : Int
  , height : Float
  }
type alias Model = List User

init : () -> (Model, Cmd Msg)
init _ = ([], getUsers)

-- UPDATE
type Msg = GotUsers (Result Http.Error Model)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotUsers result ->
      case result of
        Ok users ->
          (users, Cmd.none)
        
        Err _ ->
          ([], Cmd.none)

-- VIEW

view : Model -> Html Msg
view model = 
  div []
    (List.map (\u -> userView u) model)

userView : User -> Html Msg
userView user =
  p []
    [ text 
       <| "name: " ++ user.name 
       ++ "(" ++ (String.fromInt user.age) ++ ") " 
       ++ (String.fromFloat user.height) ++ "cm"
    ]


-- HTTP

getUsers : Cmd Msg
getUsers =
  Http.get
    { url = "/json/users.json"
    , expect = Http.expectJson GotUsers (list userDecoder)
    }


userDecoder : Decoder User
userDecoder =
  map3 User
        (field "name" string)
        (field "age" int)
        (field "height" float)