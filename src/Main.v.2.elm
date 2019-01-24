module Main exposing (main)

import Browser exposing (element)
import Html exposing (..)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)
import Http exposing (Error(..), expectJson, get)
import Json.Decode exposing (field, int, list, map3, string)


type alias Product =
    { id : Int
    , quantity : Int
    , name : String
    }


type Msg
    = GotProducts (Result Error (List Product))
    | ChangeQuanity Int String


type Model
    = NotRequested
    | Fetching
    | Error Error
    | Success (List Product)


update msg model =
    case msg of
        GotProducts (Ok newProducts) ->
            ( Success newProducts, Cmd.none )

        GotProducts (Err error) ->
            ( Error error, Cmd.none )

        ChangeQuanity productId newQuantity ->
            case model of
                Success products ->
                    let
                        newProducts =
                            List.map
                                (\product ->
                                    if product.id == productId then
                                        let
                                            newQuantityInt =
                                                Maybe.withDefault product.quantity <| String.toInt newQuantity
                                        in
                                        if newQuantity == "" || newQuantityInt < 0 then
                                            { product | quantity = 0 }

                                        else
                                            { product | quantity = newQuantityInt }

                                    else
                                        product
                                )
                                products
                    in
                    ( Success newProducts, Cmd.none )

                _ ->
                    ( model, Cmd.none )


totalProducts products =
    List.foldl (\product acc -> acc + product.quantity) 0 products


view model =
    case model of
        Success products ->
            div []
                [ ul [] <|
                    List.map
                        (\product ->
                            li []
                                [ input
                                    [ type_ "number"
                                    , onInput <| ChangeQuanity product.id
                                    , value <| String.fromInt product.quantity
                                    ]
                                    []
                                , text <|
                                    " "
                                        ++ product.name
                                        ++ (if product.quantity == 0 then
                                                " - OUT OF STOCK "

                                            else
                                                " "
                                           )
                                , button [ onClick <| ChangeQuanity product.id (String.fromInt (product.quantity + 1)) ] [ text "Add" ]
                                ]
                        )
                        products
                , h2 [] [ text <| "Total Inventory: " ++ (String.fromInt <| totalProducts products) ]
                ]

        NotRequested ->
            text "Not Requested"

        Fetching ->
            text "Fetching"

        Error (BadUrl url) ->
            text <| "Bar Url: " ++ url

        Error Timeout ->
            text "Timeout"

        Error NetworkError ->
            text "Network Error "

        Error (BadStatus status) ->
            text <| "Bad Status: " ++ String.fromInt status

        Error (BadBody error) ->
            text <| "Bad Body: " ++ error


productsDecoder =
    field "products" <|
        list <|
            map3 Product
                (field "id" int)
                (field "quantity" int)
                (field "name" string)


main : Program { url : String } Model Msg
main =
    element
        { init =
            \flags ->
                ( NotRequested
                , get
                    { url = flags.url
                    , expect = expectJson GotProducts productsDecoder
                    }
                )
        , view = view
        , subscriptions = \_ -> Sub.none
        , update = update
        }
