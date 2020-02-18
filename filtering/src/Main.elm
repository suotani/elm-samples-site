module Filtering exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Debug

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }


-- MODEL
type Status
  = Created
  | Running
  | Finished

type alias Todo =
  { title : String
  , status : Status
  }
type alias Model = 
  { list : List Todo
  , filtered : List Todo
  }

init : () -> (Model, Cmd Msg)
init _ =
  update
    (Filter Nothing)
    (Model
       [ {title="Check Mail", status=Created}
       , {title="Post Letter", status=Created}
       , {title="Coding Project A", status=Running}
       , {title="Wash Dishes", status=Finished}
       , {title="Phone to wife", status=Created}
       , {title="Watch News on TV", status=Running}
       ]
       []
    )

-- UPDATE

type Msg
  = Filter (Maybe Status)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Filter (Just status) ->
      ({ model| filtered = List.filter (\i -> i.status == status) model.list }, Cmd.none)
    Filter Nothing ->
      ({ model| filtered = model.list }, Cmd.none)
--SUBSCRIPTIONS

-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ div [class "filters"]
        [ p [] [text "Filter"]
        , ul []
            [ li [onClick <| Filter (Just Created)] [text "Created"]
            , li [onClick <| Filter (Just Running)] [text "Running"]
            , li [onClick <| Filter (Just Finished)] [text "Finished"]
            , li [onClick <| Filter Nothing] [text "No Filter"]
            ]
        ]
    , div [class "list"]
      [ p [] [text "List"]
      , ul [] (List.map (\todo -> todoList todo) model.filtered)
      ]
    ]

todoList : Todo -> Html Msg
todoList todo =
  li [] [text <| "[" ++ (Debug.toString todo.status) ++ "]" ++ todo.title]