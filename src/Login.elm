module Login exposing (view)

import Html exposing (..)
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Textfield as Textfield
import Material.Options as Options exposing (onInput, onClick, css)
import Model exposing (Model, Msg(Mdl, SetUsername, SetPassword, Authenticate))


view : Model -> Html Msg
view model =
    Card.view []
        [ Card.title []
            [ Card.head [] [ text "Login" ] ]
        , Card.text []
            [ Textfield.render Mdl
                [ 1 ]
                model.mdl
                [ Options.onInput SetUsername
                , Textfield.label "username"
                , Textfield.value model.username
                ]
                []
            ]
        , Card.text []
            [ Textfield.render Mdl
                [ 2 ]
                model.mdl
                [ Options.onInput SetPassword
                , Textfield.password
                , Textfield.label "password"
                , Textfield.value model.password
                ]
                []
            ]
        , Card.actions []
            [ Button.render Mdl
                [ 3 ]
                model.mdl
                [ Options.onClick Authenticate ]
                [ text "Login" ]
            ]
        , Card.text []
            [ text model.msg ]
        ]
