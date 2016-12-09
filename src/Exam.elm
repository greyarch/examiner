module Exam exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Question


type alias SingleQuestion =
    ( Slug, Question.Model )


type alias Model =
    List SingleQuestion


type alias Slug =
    String


model : Model
model =
    [ ( "Q1"
      , Question.Model "Q1"
            "**First question**"
            [ Question.Answer "First" True
            , Question.Answer "Second" False
            ]
            []
      )
    , ( "Q2"
      , Question.Model "Q2"
            "**Second question**"
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
                qUpdate : SingleQuestion -> SingleQuestion
                qUpdate sq =
                    let
                        sl =
                            Tuple.first sq

                        answ =
                            Tuple.second sq
                    in
                        if slug == sl then
                            ( sl, Question.update qMsg answ )
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

        qView : ( Slug, Question.Model ) -> Html Msg
        qView ( slug, q ) =
            Question.view q
                |> Html.map (SelectQuestion slug)

        questions =
            List.map qView model
    in
        div [] <|
            List.append
                questions
                [ p [] [ button [ onClick Submit ] [ text "Submit" ] ]
                ]
