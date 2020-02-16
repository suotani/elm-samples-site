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
  div [class "main"]
    [ div [class "input-area"]
        [ div [class "input"]
            [ inputView "text" "Name" model.name InputName ]
        , div [class "input"]
            [ inputView "number" "Age" (String.fromInt <| Maybe.withDefault 0 model.age) InputAge ]
        , div [class "input"]
            [ inputView "password" "Password" model.password InputPassword ]
        , div [class "input"]
            [ inputView "password" "Password Confirm" model.passwordConfirm InputPasswordConfirm ]
        , div [class "input"]
            [ button [ onClick Submit ] [ text "Submit" ] ]
        ]
    , div [class "output-area"]
        [ div [class "output"] [text model.name]
        , div [class "output"]
            [ case model.age of
                Just age ->
                  text <| String.fromInt age
                
                Nothing ->
                  text ""
            ]
        , div [class "output"] [text model.password]
        , div [class "output"] [text model.passwordConfirm]

        ]
    ]

inputView : String -> String -> String -> (String -> Msg) -> Html Msg
inputView t p v msg =
  input [ type_ t, placeholder p, value v, onInput msg ] []