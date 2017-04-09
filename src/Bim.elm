module Bim exposing (..)

import Html
import Material
import View exposing (view)
import Model exposing (Model, Mdl, Msg(..))
import Rest exposing (..)
import Auth exposing (authenticate)


model : Model
model =
    { assemblies = []
    , username = "root"
    , password = "arango"
    , db = "test"
    , msg = ""
    , jwt = ""
    , mdl = Material.model
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername username ->
            { model | username = username } ! []

        SetPassword password ->
            { model | password = password } ! []

        SetDb db ->
            { model | db = db } ! []

        Authenticate ->
            let
                e =
                    Debug.log "authenticate" model.username
            in
                { model | msg = "" } ! [ authenticate model ]

        Authenticated (Ok jwt) ->
            let
                e =
                    Debug.log "authenticated" model.username
            in
                { model | jwt = jwt } ! []

        Authenticated (Err error) ->
            let
                e =
                    Debug.log "error" error
            in
                { model | msg = "Authentication problem" } ! []

        Logout ->
            { model | jwt = "" } ! []

        GetTopAssemblies ->
            model ! [ getTopAssemblies model ]

        GetChildAssemblies id ->
            model ! [ getChildAssemblies model id ]

        SetAssemblies (Ok assies) ->
            { model | assemblies = assies } ! []

        SetAssemblies (Err error) ->
            let
                e =
                    Debug.log "error" error
            in
                { model | msg = "Error fetching assemblies. Check the console" } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
