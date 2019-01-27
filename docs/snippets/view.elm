[ ul [] <|
    List.map
        (\product ->
            li []
                [ input
                    [ type_ "number"
                    , onInput <| ChangeQuantity product.id
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
                , button
                    [ onClick <|
                        ChangeQuantity product.id
                            (String.fromInt (product.quantity + 1))
                    ]
                    [ text "Add" ]
                ]
        )
        products
, h2 []
    [ text <|
        "Total Inventory: "
            ++ (String.fromInt <| totalProducts products)
    ]
]
