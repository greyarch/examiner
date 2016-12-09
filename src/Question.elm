module Question exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown


type alias Slug =
    String


type alias Model =
    { slug : Slug
    , title : String
    , answers : List Answer
    , selected : List Answer
    }


type alias Answer =
    { text : String
    , isCorrect : Bool
    }


type Msg
    = Select Slug Answer


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select slug answer ->
            if slug == model.slug then
                { model | selected = [ answer ] }
            else
                model


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
        title =
            Markdown.toHtml [] question.title

        answers =
            fieldset [] <|
                List.map (viewAnswer question.slug) question.answers

        selected =
            viewSelected question.selected
    in
        div []
            [ title
            , answers
            , hr [] []
            , selected
            ]
