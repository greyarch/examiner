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


type Msg
    = Select Slug Answer


update : Msg -> Model -> Model
update msg ( slug, data ) =
    case msg of
        Select slug_ answer ->
            let
                newData =
                    { data | selected = [ answer ] }
            in
                ( slug, newData )


viewAnswer : String -> Answer -> Html Msg
viewAnswer grp answer =
    div []
        [ label []
            [ input [ type_ "radio", name grp, onClick <| Select grp answer ]
                []
            , text answer.text
            ]
        ]


viewSelected : List Answer -> Html Msg
viewSelected selected =
    div []
        (List.map
            (\sel -> text sel.text)
            selected
        )


view : Model -> Html Msg
view question =
    let
        ( slug, data ) =
            question

        title =
            Markdown.toHtml [] data.title

        answers =
            fieldset [] <|
                List.map (viewAnswer slug) data.answers

        selected =
            viewSelected data.selected
    in
        div []
            [ title
            , answers
            , hr [] []
            , selected
            ]
