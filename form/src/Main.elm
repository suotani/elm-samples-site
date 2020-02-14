module Form exposing (main)

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
type alias User =
    { name : String
    , age : Maybe Int
    , password : String
    , passwordConfirm : String
    }
type alias Model = User

init : () -> (Model, Cmd Msg)
init _ =
  (User "" Nothing "" "", Cmd.none)
-- UPDATE
type Msg
  = InputName String
  | InputAge String
  | InputPassword String
  | InputPasswordConfirm String
  | Submit

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    InputName name ->
      ({model | name = name}, Cmd.none)
    
    InputAge age ->
      ({model | age = String.toInt age}, Cmd.none)
    
    InputPassword pw ->
      ({model | password = pw}, Cmd.none)
    
    InputPasswordConfirm pwc ->
      ({model | passwordConfirm = pwc}, Cmd.none)
    
    Submit ->
      (model, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ div []
        [ input [ type_ "text", placeholder "Name", value model.name, onInput InputName ] []
        , input [ type_ "number", placeholder "Age", value <| String.fromInt <| Maybe.withDefault 0 model.age, onInput InputAge ] []
        , input [ type_ "password", placeholder "Password", value model.password, onInput InputPassword ] []
        , input [ type_ "password", placeholder "Password Confirm", value model.passwordConfirm, onInput InputPasswordConfirm ] []
        , button [ onClick Submit ] [ text "Submit" ]
        ]
    ]

  