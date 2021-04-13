let button = document.querySelector("button"),
output = document.querySelector("#output"),
textarea = document.querySelector("textarea"),
// wsUri = "ws://echo.websocket.org/",
wsUri = "ws://127.0.0.1/",
websocket = new WebSocket(wsUri);

button.addEventListener("click", onClickButton);

websocket.onopen = function (e) {
    writeToScreen("CONNECTED");
    doSend("WebSocket rocks");
};

websocket.onclose = function (e) {
    writeToScreen("DISCONNECTED");
};

websocket.onmessage = function (e) {
    console.log('answer: ', e);
    writeToScreen("<span>RESPONSE: " + e.data + "</span>");
};

websocket.onerror = function (e) {
    writeToScreen("<span class=error>ERROR:</span> " + e.data);
};

function doSend(message) {
    writeToScreen("SENT: " + message);
    websocket.send(message);
}

function writeToScreen(message) {
    output.insertAdjacentHTML("afterbegin", "<p>" + message + "</p>");
}

function onClickButton() {
    var text = textarea.value;

    text && doSend(text);
    textarea.value = "";
    textarea.focus();
}