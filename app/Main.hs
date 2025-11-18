-----------------------------------------------------------------------------
{-# LANGUAGE CPP               #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE MultilineStrings  #-}
{-# LANGUAGE OverloadedStrings #-}
-----------------------------------------------------------------------------
module Main where
-----------------------------------------------------------------------------
import           Miso
import qualified Miso.Html as H
import qualified Miso.Html.Property as P
import qualified Miso.CSS as CSS
-----------------------------------------------------------------------------
import           Language.Javascript.JSaddle
-----------------------------------------------------------------------------
#ifdef WASM
import qualified Language.Javascript.JSaddle.Wasm.TH as JSaddle.Wasm.TH
#else
import           Data.FileEmbed (embedStringFile)
#endif
-----------------------------------------------------------------------------
type Model = ()
-----------------------------------------------------------------------------
data Action = InitChart DOMRef
-----------------------------------------------------------------------------
#ifdef WASM
foreign export javascript "hs_start" main :: IO ()
#endif
-----------------------------------------------------------------------------
main :: IO ()
main = run $ do
#ifdef WASM
  _ <- $(JSaddle.Wasm.TH.evalFile "js/c3.js")
#else
  _ <- eval ($(embedStringFile "js/c3.js") :: MisoString)
#endif
  startApp app
-----------------------------------------------------------------------------
app :: App Model Action
app = (component () updateModel viewModel)
#ifndef WASM
  { styles =
    [ Href "static/styles.css"
    , Href "https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.css"
    ]
  , scripts =
      [ Src "https://cdn.jsdelivr.net/npm/c3.js"
      , Src "https://cdnjs.cloudflare.com/ajax/libs/d3/5.16.0/d3.min.js"
      , Src "https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.js"
      ]
  }
#endif
-----------------------------------------------------------------------------
updateModel :: Action -> Transition Model Action
updateModel = \case
  InitChart domRef ->
    io_ $ do
      _ <- global # ("initChart" :: MisoString) $ [domRef]
      eval ("""
        setTimeout(function() {
            chart.focus(['Product A']);
        }, 1000);
      """ :: MisoString)
-----------------------------------------------------------------------------
githubStar :: View parent action
githubStar = H.iframe_
    [ P.title_ "GitHub"
    , P.height_ "30"
    , P.width_ "170"
    , textProp "scrolling" "0"
    , textProp "frameborder" "0"
    , P.src_
      "https://ghbtns.com/github-btn.html?user=haskell-miso&repo=miso-c3js&type=star&count=true&size=large"
    ]
    []
-----------------------------------------------------------------------------
viewModel :: Model -> View Model Action
viewModel _ = H.div_
    [ P.class_ "chart-container" ]
    [ H.div_
        [ P.class_ "chart-header" ]
        [ H.h1_
            [ P.class_ "chart-title", CSS.style_ [ CSS.fontFamily "monospace" ] ]
            ["🍜 📈 miso-c3js "]
        , H.p_
            [ P.class_ "chart-subtitle" ]
            ["Revenue overview for the current fiscal year"]
        ]
    , H.div_
      [ P.id_ "chart"
      , onCreatedWith InitChart
      ]
      []
    , H.div_
        [ P.class_ "chart-footer"]
        ["Data updated: December 2024"]
    ]
-----------------------------------------------------------------------------
