module Auth exposing (..)

import Model exposing (..)
import Http exposing (..)
import Jwt exposing (authenticate)
import Json.Decode exposing (list, string, field)
import Json.Encode as Encode exposing (Value)
import Endpoint as Endpoint exposing (authUrl)


authenticate : Model -> Cmd Msg
authenticate model =
    let
        url =
            Endpoint.authUrl
                |> Debug.log ("url")

        body =
            Http.jsonBody (credentials model)

        request =
            Http.post url body string
    in
        credentials model
            |> Jwt.authenticate url tokenStringDecoder
            |> Http.send Authenticated


credentials : Model -> Encode.Value
credentials model =
    Encode.object
        [ ( "username", Encode.string model.username )
        , ( "password", Encode.string model.password )
        ]


tokenStringDecoder =
    field "jwt" string
