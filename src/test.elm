module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html
import Html.Attributes exposing (class)



-- MAIN


main =
    layout [ width fill, height fill, Font.family [ Font.typeface "Open Sans", Font.sansSerif ], Background.color (rgb255 248 249 250) ] <|
        column
            [ centerX
            , centerY
            , width (maximum 500 fill)
            , height (maximum 850 fill)
            , paddingEach { left = 10, right = 10, top = 10, bottom = 10 }
            , Border.color (rgb255 219 219 219)
            , Border.shadow { blur = 20, color = rgba 0 0 0 0.1, offset = ( 0, 0 ), size = 1 }
            , Background.color (rgb255 255 255 255)
            ]
            [ column [ centerX, centerY ]
                [ image [ centerX, htmlAttribute <| class "headshot", paddingEach { edges | bottom = 35 } ] { src = "https://cdn.dribbble.com/users/1242303/screenshots/3764594/day35.png", description = "Jeffrey Huang" }
                , column [ spacing 10, centerX ]
                    [ el [ Region.heading 1, Font.size 48, Font.center, centerX ] <| text "Jeffrey Huang"
                    , el [ Region.heading 2, Font.size 18, Font.center, centerX, Font.light, Font.italic, Font.color <| rgb255 170 170 170 ] <| text "Ideas start here..."
                    , textColumn [ Font.light, Font.center, width fill, paddingEach { left = 20, right = 20, top = 20, bottom = 10 }, Font.size 15, centerX ]
                        [ paragraph [ spacing 15 ] [ text "Hey! I'm a computer engineering student at the University of Waterloo. I love all things tech, and I also love travelling, snowboarding and trying new food." ]
                        ]
                    ]
                , viewSocialIcons
                , row [ Font.light, Font.color <| rgb255 0 0 139, centerX, spacing 45 ]
                    [ newTabLink [ mouseOver [ Font.color <| rgb255 0 0 205 ] ] { url = "https://medium.com/@jzxhuang", label = text "Blog" }
                    , newTabLink [ mouseOver [ Font.color <| rgb255 0 0 205 ] ] { url = "resume/resume_jhuang.pdf", label = text "Resume" }
                    ]
                ]
            , paragraph [ Region.footer, height (px 24), Font.color (rgb255 170 170 170), Font.light, centerX, Font.center, Font.size 12, width fill ]
                [ text "© 2019 Jeffrey Huang | Made with ♥ and Elm - "
                , newTabLink [ htmlAttribute <| class "footer-link" ] { url = "https://github.com/jzxhuang/jzxhuang.github.io", label = text "see source code" }
                ]
            ]


viewSocialIcons : Element msg
viewSocialIcons =
    row [ spacing 25, centerX, paddingXY 0 35 ]
        [ newTabLink [] { url = "https://medium.com/@jzxhuang", label = faIcon "fab fa-medium-m" }
        , newTabLink [] { url = "https://instagram.com/jzxhuang/", label = faIcon "fab fa-instagram" }
        , newTabLink [] { url = "https://github.com/jzxhuang", label = faIcon "fab fa-github" }
        , newTabLink [] { url = "mailto:jzxhuang@edu.uwaterloo.ca", label = faIcon "far fa-envelope" }
        , newTabLink [] { url = "https://linkedin.com/in/jzxhuang", label = faIcon "fab fa-linkedin-in" }
        ]


faIcon : String -> Element msg
faIcon icon =
    html <| Html.i [ class icon ] [ Html.text "" ]


edges =
    { left = 0, right = 0, top = 0, bottom = 0 }
