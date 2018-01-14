module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Either (Either(..))
import LAGalbi (type (/), Param, S, parseUrl, writeUrl)
import Test.Unit (failure, suite, test)
import Test.Unit.Assert (assert)
import Test.Unit.Main (runTest)
import Type.Prelude (Proxy(..))

type MyRoute = S "hello" / S "world" / Param "id" Int / Param "name" String

myRouteP :: Proxy MyRoute
myRouteP = Proxy

testUrl :: String
testUrl = "/hello/world/1/joe"

main :: Eff _ Unit
main = runTest do
  suite "LA Galbi" do
    test "parseUrl works" do
      case parseUrl myRouteP testUrl of
        Left e -> failure $ "oops: " <> show e
        Right result ->
          assert "says hi joe #1" $
            "hi " <> result.name <> " #" <> show result.id == "hi joe #1"
    test "writeUrl works" do
      assert "writes out /hello/world/1/joe" $
        writeUrl myRouteP { name: "joe", id: 1 } == "/hello/world/1/joe"
