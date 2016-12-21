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
    | Select Slug Question.Answer


update : Msg -> Model -> Model
update msg model =
    case msg of
        Submit ->
            model

        Select slug answer ->
            let
                qUpdate : Question.Model -> Question.Model
                qUpdate sq =
                    let
                        ( sl, data ) =
                            sq
                    in
                        if slug == sl then
                            ( sl, { data | selected = [ answer ] } )
                        else
                            sq
            in
                List.map qUpdate model



-- model


view : Model -> Html Msg
view model =
    let
        qView : Question.Model -> Html Msg
        qView q =
            Question.view (Select) q

        questions =
            List.map qView model
    in
        div [] <|
            List.append
                questions
                [ p [] [ button [ onClick Submit ] [ text "Submit" ] ]
                ]
