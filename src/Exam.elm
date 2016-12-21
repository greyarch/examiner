module Exam exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Question


type alias Model =
    List Question.Model


type alias Slug =
    String


model : Model
model =
    [ ( "Q1"
      , Question.Question "**First question**"
            [ Question.Answer "First" True
            , Question.Answer "Second" False
            ]
            []
      )
    , ( "Q2"
      , Question.Question "**Second question**"
            [ Question.Answer "Third" False
            , Question.Answer "Fourth" True
            ]
            []
      )
    ]


type Msg
    = Submit
    | SelectQuestion Slug Question.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Submit ->
            model

        SelectQuestion slug qMsg ->
            let
                qUpdate : Question.Model -> Question.Model
                qUpdate sq =
                    let
                        sl =
                            Tuple.first sq

                        answ =
                            Tuple.second sq
                    in
                        if slug == sl then
                            Question.update qMsg sq
                        else
                            sq
            in
                List.map qUpdate model



-- model


view : Model -> Html Msg
view model =
    let
        _ =
            Debug.log "MODEL" model

        qView : Question.Model -> Html Msg
        qView q =
            Question.view q
                |> Html.map (SelectQuestion <| Tuple.first q)

        questions =
            List.map qView model
    in
        div [] <|
            List.append
                questions
                [ p [] [ button [ onClick Submit ] [ text "Submit" ] ]
                ]
