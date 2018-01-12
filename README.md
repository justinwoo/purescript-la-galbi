# PureScript-LA Galbi

A simple library to parse a url string to a record of the parameters, defined by using a nested tuple with simple type aliases.

Named for delicious LA Galbi, where the short rib bones line the top of each cut to make meat segments.

![](https://i.imgur.com/OJOnYqt.jpg)

## Example

From the tests:

```hs
type MyRoute = S "hello" / S "world" / Param "id" Int / Param "name" String

myRouteP :: Proxy MyRoute
myRouteP = Proxy

testUrl :: String
testUrl = "/hello/world/1/joe"

-- ...
      case parseUrl myRouteP testUrl of
        Left e -> failure $ "oops: " <> show e
        Right result ->
          assert "says hi joe #1" $
            "hi " <> result.name <> " #" <> show result.id == "hi joe #1"
```
