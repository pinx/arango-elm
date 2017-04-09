module Rest exposing (..)

import Http exposing (send)
import Jwt exposing (post)
import Task exposing (Task)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Json.Encode as Encode exposing (encode, object, list, string)
import Model exposing (..)
import Endpoint as Endpoint exposing (queryUrl)


getTopAssemblies : Model -> Cmd Msg
getTopAssemblies model =
    let
        url =
            Endpoint.queryUrl model

        request =
            Jwt.post model.jwt url topQuery assembliesDecoder
    in
        Http.send SetAssemblies request


getChildAssemblies : Model -> String -> Cmd Msg
getChildAssemblies model parent_id =
    let
        url =
            Endpoint.queryUrl model

        request =
            Jwt.post model.jwt url (childQuery parent_id) assembliesDecoder
    in
        Http.send SetAssemblies request


assembliesDecoder =
    map
        (\result -> result)
        (field "result" (Decode.list (Decode.dict Decode.string)))


topQuery : Http.Body
topQuery =
    Encode.object
        [ ( "query", Encode.string "FOR assy IN assemblies FILTER assy.parent_id == NULL LIMIT 100 RETURN assy" )
        , ( "batchSize", Encode.int 100 )
        ]
        |> Http.jsonBody


childQuery : String -> Http.Body
childQuery key =
    Encode.object
        [ ( "query", Encode.string ("FOR assy, e IN 1..1 OUTBOUND '" ++ key ++ "' contains RETURN assy") )
        , ( "batchSize", Encode.int 10000 )
        ]
        |> Http.jsonBody

