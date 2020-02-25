module Nav exposing (main)

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
type alias Page = 
  { demo : String
  , codePath : Maybe String
  , code : Maybe String
  }
type alias Model = Page

init : () -> (Model, Cmd Msg)
init _ = (Page "top.html" Nothing Nothing, Cmd.none)

-- UPDATE
type Msg = M

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

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
              [ viewItem "/simple-form/index.html" (Just "simple-form/src/Main.elm") "Simple Form"
              , viewItem "/form/index.html" (Just "form/src/Main.elm") "Form"
              , viewItem "/tab/index.html" (Just "tab/src/Main.elm") "Tab"
              , viewItem "/filtering/index.html" (Just "filtering/src/Main.elm") "Filtering"
              , viewItem "/modal/index.html" (Just "modal/src/Main.elm") "Modal"
              , viewItem "/random/index.html" (Just "random/src/Main.elm") "Random"
              , viewItem "/time/index.html" (Just "time/src/Main.elm") "Current Time"
              ]
            ]

        ]
    ]

viewItem : String -> Maybe String -> String -> Html Msg
viewItem page src title =
  li [ ] [a [href page] [text title] ]