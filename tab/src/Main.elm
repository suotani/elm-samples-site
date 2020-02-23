module Tab exposing (..)
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
type alias Tab =
  { head : String
  , body : String
  }
type alias Model =
  { tabs : List Tab
  , currentTab : Tab 
  }

init : () -> (Model, Cmd Msg)
init _ =
  let
    tabs = 
      [ Tab "H1" "This is view h1 tab"
      , Tab "H2" "This is view h2 tab"
      , Tab "H3" "This is view h3 tab"
      , Tab "H4" "This is view h4 tab"
      ]
    firstTab = Maybe.withDefault (Tab "" "") (List.head tabs)
  in
  ( Model tabs firstTab, Cmd.none)


-- UPDATE

type Msg
  = ChangeTab Tab

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeTab tab ->
      ({model | currentTab = tab}, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ viewTabs model
    , viewTabBody model.currentTab
    ]

viewTabs : Model -> Html Msg
viewTabs model =
  let
    tabList =
      List.map
        ( \t ->
            if model.currentTab == t then
              li [onClick (ChangeTab t), class "current"] [text t.head]
            else
              li [onClick (ChangeTab t), class ""] [text t.head]
        )
        model.tabs
  in
  div [class "tab"] [ ul [] tabList ]


viewTabBody : Tab -> Html Msg
viewTabBody tab =
  div [class "tab-body"]
    [ h2 [] [text tab.head]
    , p [] [text tab.body]
    ]