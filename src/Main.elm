module Main exposing (..)

import Browser
import Html exposing (Html, div, input, button, ul, li, text)
import Html.Attributes exposing (placeholder, value, classList)
import Html.Events exposing (onClick)

type alias Task =
    { id : Int
    , description : String
    , done : Bool
    }

type alias Model =
    { tasks : List Task
    , newTask : String
    , filter : String
    }

-- Initialize
init : Model
init =
    { tasks = []
    , newTask = ""
    , filter = "all"
    }

-- Message
type Msg
    = NoOp

-- Update
update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

-- View
view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "New task", value model.newTask ] []
        , button [ onClick NoOp ] [ text "Add Task" ]
        , viewTasks model.tasks
        ]

viewTasks : List Task -> Html Msg
viewTasks tasks =
    ul [] (List.map viewTask tasks)

viewTask : Task -> Html Msg
viewTask task =
    li [ classList [ ("done", task.done) ] ] [ text task.description ]

-- Main
main =
    Browser.sandbox { init = init, update = update, view = view }
