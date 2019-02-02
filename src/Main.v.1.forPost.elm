module Main exposing (main)

import Browser exposing (element)
import Html exposing (..)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)
import Http exposing (Error(..), expectJson, get)
import Json.Decode exposing (field, int, list, map3, string)
import Json.Encode as Encode exposing (encode)


type alias Product =
    { id : Int
    , quantity : Int
    , name : String
    }


type Msg
    = GotProducts (Result Error (List Product))
    | ChangeQuantity Int String


update msg products =
    case msg of
        GotProducts (Ok newProducts) ->
            ( newProducts, Cmd.none )

        GotProducts (Err _) ->
            ( products, Cmd.none )

        ChangeQuantity productId newQuantity ->
            let
                newProducts =
                    List.map
                        (\product ->
                            if product.id == productId then
                                { product
                                    | quantity =
                                        Maybe.withDefault product.quantity <| String.toInt newQuantity
                                }

                            else
                                product
                        )
                        products
            in
            ( newProducts, Cmd.none )


totalProducts products =
    List.foldl (\product acc -> acc + product.quantity) 0 products


view products =
    div [] <|
        List.map
            (\product ->
                div []
                    [ input
                        [ type_ "number"
                        , onInput <| ChangeQuantity product.id
                        , value <| String.fromInt product.quantity
                        ]
                        []
                    , button
                        [ onClick <|
                            ChangeQuantity product.id
                                (String.fromInt (product.quantity + 1))
                        ]
                        [ text "Add 1" ]
                    , text <| " " ++ product.name
                    ]
            )
            products
            ++ [ p [] [ text <| "Total Inventory: " ++ (String.fromInt <| totalProducts products) ]
               , p [] [ text <| "Quantities: " ++ encode 0 (Encode.list Encode.int (List.map .quantity products)) ]
               ]


productsDecoder =
    field "products" <|
        list <|
            map3 Product
                (field "id" int)
                (field "quantity" int)
                (field "name" string)


main : Program { url : String } (List Product) Msg
main =
    element
        { init =
            \flags ->
                ( []
                , get
                    { url = flags.url
                    , expect = expectJson GotProducts productsDecoder
                    }
                )
        , view = view
        , subscriptions = \_ -> Sub.none
        , update = update
        }
