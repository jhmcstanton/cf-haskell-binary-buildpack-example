{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty

main :: IO ()
main = scotty 8080 $ do
  get "/" $ do
    html $ "<h1>Hello there</h1>"
  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
  -- Yikes, stringly typed D:
  get "/health/" $ do
    text "{ \"status\" : \"up\" }"
