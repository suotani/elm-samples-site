module Main exposing (main)

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
type alias Page = 
  { demo : String
  , codePath : Maybe String
  , code : Maybe String
  }
type alias Model = Page

init : () -> (Model, Cmd Msg)
init _ = (Page "top.html" Nothing Nothing, Cmd.none)

-- UPDATE
type Msg
  = ChangePage String (Maybe String)
  | GotCode (Result Http.Error String)
  | ClearCode

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangePage demo codePath ->
      case codePath of
        Just pagePath -> 
          ( {model | demo = demo, codePath = codePath}
          , Http.get
              { url = pagePath
              , expect = Http.expectString GotCode
              }
          )
          
        Nothing ->
          ( {model | demo = demo, codePath = codePath, code = Nothing}, Cmd.none)
  
    GotCode result ->
      case result of
        Ok text ->
          ({model | code = Just text}, Cmd.none)
        
        Err _ ->
          (model, Cmd.none)
    
    ClearCode ->
      ({model | code = Nothing}, Cmd.none)

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
              [ li [ onClick <| ChangePage "form/index.html" (Just "form/src/Main.elm") ] [text "form"]
              , li [ onClick <| ChangePage "form/index.html" Nothing ] [text "form"]
              ]
            ]

        ]

    , div [ class "right" ]
      [ div [class "demo"] [iframe [src model.demo] [] ]
      , case model.code of
          Just code ->
            div [class "code"] [ pre [] [text code] ]
          
          Nothing ->
            text ""
      ]
    ]
