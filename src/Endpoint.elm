module Endpoint exposing (..)

import Model exposing (Model)


protocol =
    "http"


host =
    "localhost"


portNb =
    "8529"


baseUrl : String
baseUrl =
    String.concat
        [ protocol
        , "://"
        , host
        , ":"
        , portNb
        ]


queryUrl : Model -> String
queryUrl model =
    String.concat
        [ baseUrl
        , "/_db/"
        , model.db
        , "/_api/cursor/"
        ]


authUrl : String
authUrl =
    String.concat
        [ baseUrl
        , "/_open/auth"
        ]
