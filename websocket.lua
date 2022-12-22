-- setDevelopmentMode(true,true)

id = 0

sockets = {}

function createSocket(url,rot)
	if url then
		id = id + 1
		brw = createBrowser(1,1,true,true)
		sockets[id] = {browser=brw,res=rot or root}
		addEventHandler("onClientBrowserCreated",sockets[id].browser,function()
			toggleBrowserDevTools(sockets[id].browser,true)
			loadBrowserURL(sockets[id].browser,"http://mta/local/assets/index.html")
			setTimer(function()
				executeBrowserJavascript(sockets[id].browser,"newSocket('"..url.."','"..id.."')")
			end,50,1)
		end)
		return id
	end
	return false
end

addEvent("onSocketConnected",true)
addEvent("onConnected",true)
addEventHandler("onConnected",resourceRoot,function(id)
	triggerEvent("onSocketConnected",sockets[tonumber(id)].res,id)
end)

addEvent("onSocketError",true)
addEvent("onError",true)
addEventHandler("onError",resourceRoot,function(id,data)
	triggerEvent("onSocketError",sockets[tonumber(id)].res,id,fromJSON(data))
end)

addEvent("onSocketClosed",true)
addEvent("onClose",true)
addEventHandler("onClose",resourceRoot,function(id,data)
	triggerEvent("onSocketClosed",sockets[tonumber(id)].res,id,data)
end)

addEvent("onSocketMessage",true)
addEvent("onMessage",true)
addEventHandler("onMessage",resourceRoot,function(id,mes)
	triggerEvent("onSocketMessage",sockets[tonumber(id)].res,id,fromJSON(mes))
end)

function sendSocketMessage(id,mes)
	if sockets[tonumber(id)] then
		executeBrowserJavascript(sockets[tonumber(id)].browser,"sendMessage(`"..mes.."`)")
		return true
	end
	return false
end

function closeSocket(id,code)
	if sockets[tonumber(id)] then
		executeBrowserJavascript(sockets[tonumber(id)].browser,"closeSocket('"..(code or 1000).."')")
		if isElement(sockets[tonumber(id)].browser) then
			destroyElement(sockets[tonumber(id)].browser)
		end
		triggerEvent("onSocketClose",sockets[tonumber(id)].res,id,"Closed connection")
		sockets[tonumber(id)] = nil
		return true
	end
	return false
end