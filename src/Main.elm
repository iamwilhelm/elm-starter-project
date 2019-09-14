import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Array exposing (Array)
import Debug exposing (toString, log)

import Datalog


-- MAIN


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }


-- MODEL

type alias Field a =
  { name: String
  , values: Array a
  }


type Column = ColumnInt (Field Int)
  | ColumnString (Field String)


name : Column -> String
name column =
  case column of
  ColumnInt field -> field.name
  ColumnString field  -> field.name

value : Column -> Int -> String
value column rowIndex =
  case column of
  ColumnInt field ->
    Array.get rowIndex field.values
    |> Maybe.withDefault 0
    |> toString
  ColumnString field ->
    Array.get rowIndex field.values
    |> Maybe.withDefault "-"

collength : Column -> Int
collength column =
  case column of
  ColumnInt field -> Array.length field.values
  ColumnString field -> Array.length field.values

numberOfRows : Database -> Int
numberOfRows database =
  List.head database
  |> Maybe.map (\column -> collength column)
  |> Maybe.withDefault 0

type alias Database = List Column

type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , database : Database
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Model key url [
    ColumnString {
      name = "Name"
    , values = Array.fromList [
        "Elenor Shellstrop" , "Chidi Anagonye" , "Tahani Al-Jamil"
      , "Janet Computer" , "Jason Mendoza" , "Michael Demon"
      ]
    }
  , ColumnInt {
      name = "Age"
    , values = Array.fromList [ 36 , 36 , 30 , 100 , 29 , 200 ]
    }
  , ColumnString {
      name = "Gender"
    , values = Array.fromList [ "female" , "male" , "female" , "female" , "male" , "male" ]
    }
  , ColumnString {
      name = "Eyes"
    , values = Array.fromList [
        "blue" , "dark brown" , "dark brown"
      , "dark brown" ,  "dark brown", "grey"
      ]
    }
  , ColumnString {
      name = "Hair"
    , values = Array.fromList [ "blonde" , "black" , "black" , "brown", "black", "silver" ]
    }
  ], Cmd.none )


-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }
      , Cmd.none
      )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- VIEW


view : Model -> Browser.Document Msg
view model =
  { title = "Collaboration App"
  , body =
      [ viewContainer model
      ]
  }


viewContainer : Model -> Html msg
viewContainer model =
  div [ class "container-fluid" ] [
    div [ class "row" ] [
      div [ class "col-6" ] [
        h3 [] [ text "database" ]
      , div [ id "eve-wrapper" ] []
      -- , viewDatabase model.database
      ],
      div [class "col-6"] [
        h3 [] [ text "code" ],
        div [id "code-block"] []
      ]
    ]
  ]


viewDatabase : Database -> Html msg
viewDatabase database =
  let
    x = log "range" <| List.range 0 (numberOfRows database)
  in
    
    table [ class "table table-striped" ] [
      thead [] [
        tr [] <| List.map viewDatabaseHeading database
      ]
    , tbody []
      <| List.map (viewDatabaseRow database)
      <| List.range 0 <| (numberOfRows database) - 1
    ]


viewDatabaseHeading : Column -> Html msg
viewDatabaseHeading column =
  th [ scope "col" ] [ (text << name) column ]


viewDatabaseRow : Database -> Int -> Html msg
viewDatabaseRow database rowIndex =
  tr [] <| List.map (viewDatabaseCell rowIndex) database


viewDatabaseCell : Int -> Column -> Html msg
viewDatabaseCell rowIndex column =
  td [] [ text <| value column rowIndex ]


viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]