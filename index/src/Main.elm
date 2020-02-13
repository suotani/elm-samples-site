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
type alias PageName = String
type alias Model = PageName

init : () -> (Model, Cmd Msg)
init _ = ("top.html", Cmd.none)

-- UPDATE
type Msg
  = ChangePage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangePage page ->
      (page, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model = 
  div [ class "main" ]
    [ div [ class "left" ] 
        [ div [class "links-head" ]
            [ text "Elm Samples"
            , p [] [text "elm 0.19"]
            ]
        
        , div [class "links"]
            [ ul [] 
              [ li [ onClick <| ChangePage "form/index.html" ] [text "form"]
              , li [ onClick <| ChangePage "form/index.html" ] [text "form"]
              ]
            ]

        ]

    , div [ class "right" ] [ iframe [src model] []]
    ]
