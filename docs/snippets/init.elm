\flags ->
    ( []
    , get
        { url = flags.url
        , expect = expectJson GotProducts productsDecoder
        }
    )
