module View exposing (view)

import Dict exposing (Dict, get)
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Layout as Layout
import Material.Grid as Grid exposing (grid, cell, size, Device(..))
import Material.Card as Card
import Material.Icon as Icon
import Material.Scheme exposing (top)
import Material.Button as Button
import Material.Textfield as Textfield
import Material.Options as Options exposing (onInput, onClick, css)
import Model exposing (..)
import Login exposing (view)
import Assembly exposing (view)


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.scrolling
        ]
        { header = header model
        , drawer = drawer
        , tabs = ( [], [] )
        , main = [ mainView model ]
        }


header : Model -> List (Html Msg)
header model =
    [ Layout.row
        [ css "transition" "height 333ms ease-in-out 0s"
        ]
        [ Layout.title [] [ text "Arango Elm" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Options.onClick Logout ]
                [ Icon.i "power_settings_new" ]
            ]
        ]
    ]


drawer : List (Html Msg)
drawer =
    [ Layout.title [] [ text "Menu" ]
    , Layout.navigation
        []
        [ Layout.link
            [ Layout.href "#cards"
            , Options.onClick (Layout.toggleDrawer Mdl)
            ]
            [ text "Cards" ]
        ]
    ]


mainView : Model -> Html Msg
mainView model =
    if model.jwt == "" then
        Login.view model
    else
        Assembly.view model
