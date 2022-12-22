# Websocket resource for MTA:SA

With this resource, you can create connection to websocket!

# Usage

Creating websocket.

Returns, id of created websocket for rest functions like closing websocket or false if something went wrong.

```lua
number createWebsocket( string url, [ element resource=root ] )
```

Closing websocket.

```lua
bool closeSocket( number id, [ number code=1000 ] )
```

Sending message for webscoket.

```lua
bool sendSocketMessage( number id, string message )
```

# **EVENTS**

# onSocketMessage 

Parameters
> number id, string data

# onSocketClosed 

Parameters
> number id, table data

# onSocketError 

Parameters
> number id, string data

# onSocketConnected

Parameters
> number id