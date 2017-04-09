module Model exposing (..)

import Material
import Http exposing (Error)
import Dict exposing (Dict)


type alias Model =
    { assemblies : List Assembly
    , jwt : String
    , username : String
    , password : String
    , msg : String
    , db : String
    , mdl : Mdl
    }


type alias Mdl =
    Material.Model


type alias Assembly =
    Dict String String


type Contains
    = None
    | Contains (List Assembly)


type Msg
    = SetUsername String
    | SetPassword String
    | SetDb String
    | Authenticate
    | Authenticated (Result Http.Error String)
    | Logout
    | GetTopAssemblies
    | GetChildAssemblies String
    | SetAssemblies (Result Http.Error (List Assembly))
    | Mdl (Material.Msg Msg)
