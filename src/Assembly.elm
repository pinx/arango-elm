module Assembly exposing (view)

import Dict exposing (Dict, get)
import Html exposing (..)
import Material
import Material.Button as Button
import Material.List as Lists
import Material.Options as Options exposing (onInput, onClick, css)
import Model exposing (Model, Assembly, Mdl, Msg(Mdl, GetTopAssemblies, GetChildAssemblies))


view : Model -> Html Msg
view model =
    Lists.ul []
        ([ getButton model ]
            ++ (List.map (\assy -> assemblyView assy model.mdl) model.assemblies)
        )


assemblyView : Assembly -> Mdl -> Html Msg
assemblyView assy mdl =
    let
        name =
            case Dict.get "name" assy of
                Just name ->
                    name

                Nothing ->
                    ""
    in
        Lists.li []
            [ Lists.content []
                [ buttons assy mdl
                , text name
                ]
            ]


getButton : Model -> Html Msg
getButton model =
    Lists.li []
        [ Lists.content []
            [ Button.render Mdl
                [ 2 ]
                model.mdl
                [ Options.onClick GetTopAssemblies ]
                [ text "Get Assemblies" ]
            ]
        ]


buttons : Assembly -> Mdl -> Html Msg
buttons assy mdl =
    let
        key =
            case Dict.get "_key" assy of
                Just key ->
                    case String.toInt key of
                        Ok intKey ->
                            intKey

                        Err _ ->
                            0

                Nothing ->
                    0

        id =
            case Dict.get "_id" assy of
                Just id ->
                    id

                Nothing ->
                    ""
    in
        Button.render Mdl
            [ key ]
            mdl
            [ Options.onClick (GetChildAssemblies id) ]
            [ text "Open" ]
