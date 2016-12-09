module Main exposing (..)

import Html exposing (..)
import Exam


main : Program Never Exam.Model Exam.Msg
main =
    Html.beginnerProgram
        { model = Exam.model
        , update = Exam.update
        , view = Exam.view
        }
