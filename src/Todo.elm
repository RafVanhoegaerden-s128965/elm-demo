module Todo exposing (..)

import Browser
import Html exposing (Html, div, ul, li, button, text, form, input, label)
import Html.Attributes exposing (placeholder, type_, value)  -- Add 'value' here
import Html.Events exposing (onClick, onInput)

-- Model
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

init : Model
init =
    { tasks = []
    , newTask = ""
    , filter = "all"
    }

-- Msg
type Msg
    = AddTask
    | MarkAsDone Int
    | DeleteTask Int
    | UpdateNewTask String
    | UpdateFilter String

-- Update
update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            { model | tasks = addTask model.newTask model.tasks, newTask = "" }

        MarkAsDone taskId ->
            { model | tasks = markTaskDone taskId model.tasks }

        DeleteTask taskId ->
            { model | tasks = deleteTask taskId model.tasks }

        UpdateNewTask value ->
            { model | newTask = value }

        UpdateFilter value ->
            { model | filter = value }

addTask : String -> List Task -> List Task
addTask description tasks =
    case tasks of
        [] -> [{ id = 1, description = description, done = False }]
        _ ->
            let
                newId =
                    case List.maximum <| List.map .id tasks of
                        Just maxId -> maxId + 1
                        Nothing -> 1
            in
            { id = newId, description = description, done = False } :: tasks


markTaskDone : Int -> List Task -> List Task
markTaskDone taskId tasks =
    List.map (\task -> if task.id == taskId then { task | done = not task.done } else task) tasks

deleteTask : Int -> List Task -> List Task
deleteTask taskId tasks =
    List.filter (\task -> task.id /= taskId) tasks

-- View
view : Model -> Html Msg
view model =
    div []
        [ form []
            [ label [ placeholder "New Task" ] [ input [ type_ "text", placeholder "New Task", value model.newTask, onInput UpdateNewTask ] [] ]
            , button [ onClick AddTask ] [ text "Add Task" ]
            ]
        , div []
            [ button [ onClick <| UpdateFilter "all" ] [ text "All" ]
            , button [ onClick <| UpdateFilter "done" ] [ text "Done" ]
            , button [ onClick <| UpdateFilter "not done" ] [ text "Not Done" ]
            ]
        , ul []
            (List.map viewTask (filterTasks model.filter model.tasks))
        ]

viewTask : Task -> Html Msg
viewTask task =
    li []
        [ button [ onClick <| MarkAsDone task.id ] [ text (if task.done then "Undo" else "Done") ]
        , button [ onClick <| DeleteTask task.id ] [ text "Delete" ]
        , text task.description
        ]

filterTasks : String -> List Task -> List Task
filterTasks filter tasks =
    case filter of
        "done" -> List.filter .done tasks
        "not done" -> List.filter (\task -> not task.done) tasks
        _ -> tasks

-- Main
main =
    Browser.sandbox { init = init, update = update, view = view }
