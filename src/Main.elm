module Main exposing (..)

import Browser
import Html exposing (Html, div, input, button, text, ul, li, h1)
import Html.Attributes exposing (placeholder, value, style, class)
import Html.Events exposing (onClick, onInput)

-- MODEL
type alias Model =
    { todos : List Todo
    , newTodo : String
    , title : String
    }

type alias Todo =
    { text : String
    , done : Bool
    }

-- INITIALIZE
init : Model
init =
    { todos = []
    , newTodo = ""
    , title = "My To-Do List"
    }

-- MESSAGE
type Msg
    = AddTodo
    | ToggleTodo Int
    | UpdateNewTodo String

-- UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo ->
            if model.newTodo /= "" then
                { model | todos = { text = model.newTodo, done = False } :: model.todos, newTodo = "" }
            else
                model

        ToggleTodo index ->
            { model | todos = List.indexedMap (\i todo -> if i == index then { todo | done = not todo.done } else todo) model.todos }

        UpdateNewTodo newText ->
            { model | newTodo = newText }

-- VIEW
view : Model -> Html Msg
view model =
    div [style "margin" "30px"]
        [ h1 [style "font-family" "Arial", style "font-size" "24px"] [text model.title]
        , input [placeholder "New Todo", value model.newTodo, onInput UpdateNewTodo] []
        , button [onClick AddTodo, style "margin-left" "10px"] [text "Add Todo"]
        , ul [] (List.indexedMap viewTodo model.todos)
        ]

viewTodo : Int -> Todo -> Html Msg
viewTodo index todo =
    li [class "todo-items",style "font-family" "Arial", style "font-size" "16px", style "text-decoration" (if todo.done then "line-through" else "none")]
        [ text todo.text
        , button [onClick (ToggleTodo index), style "margin-left" "10px"]
            [text (if todo.done then "Undone" else "Done")]
        ]

main =
    Browser.sandbox { init = init, update = update, view = view }
