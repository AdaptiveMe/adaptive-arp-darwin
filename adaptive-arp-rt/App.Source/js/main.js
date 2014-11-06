


/* SYNC */
var syncResponse = Adaptive.callSync("ILogging", "log", ["Hello from Javascript", true, 3]);
document.querySelector("#content").innerHTML = syncResponse;




/* CALLBACK */
Adaptive.callAsyncCallback("ILogging", "log", ["Hello from Javascript"], function(response) {
    document.querySelector("#content").innerHTML = response;
});

