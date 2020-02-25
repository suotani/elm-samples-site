module Modal exposing (..)
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
type ModalStatus
  = Open
  | Close
type alias Model = ModalStatus

init : () -> (Model, Cmd Msg)
init _ = (Close, Cmd.none)

-- UPDATE
type Msg
  = ModalClose
  | ModalOpen

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ModalClose ->
      (Close, Cmd.none)
    
    ModalOpen ->
      (Open, Cmd.none)



-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ button [type_ "button", onClick ModalOpen] [text "modal open"]
    , if model == Open then 
        div [class "modal"]
            [ div [class "modal-content"]
                [ p [class "modal-title"] [text "This is a modal"]
                , p [class "modal-text"]
                    [text "if [modal open] button clicked then this modal open. And if [close] button clicked then this modal close."]
                , button [type_ "button", onClick ModalClose] [text "close"]
                ]
            ]
      else
        text ""
    ]