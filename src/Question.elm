module Question exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown


type alias Slug =
    String


type alias Question =
    { title : String
    , answers : List Answer
    , selected : List Answer
    }


type alias Model =
    ( Slug, Question )


type alias Answer =
    { text : String
    , isCorrect : Bool
    }


viewAnswer : (Slug -> Answer -> msg) -> String -> Answer -> Html msg
viewAnswer msg grp answer =
    div []
        [ label []
            [ input [ type_ "radio", name grp, onClick <| msg grp answer ]
                []
            , text answer.text
            ]
        ]


viewSelected : List Answer -> Html msg
viewSelected selected =
    div []
        (List.map
            (\sel -> text sel.text)
            selected
        )


view : (Slug -> Answer -> msg) -> Model -> Html msg
view msg question =
    let
        ( slug, data ) =
            question

        title =
            Markdown.toHtml [] data.title

        answers =
            fieldset [] <|
                List.map (viewAnswer msg slug) data.answers

        selected =
            viewSelected data.selected
    in
        div []
            [ title
            , answers
            , hr [] []
            , selected
            ]
