/*NativeBridge.call("getModel", ["arg1", "arg2"], function(response) {
                  
    // Native log
    NativeBridge.call("log", [response])
                  
    // Set the model to the screen
    document.querySelector("#name").innerHTML="model: " + response;
});*/

document.querySelector("#name").innerHTML=Adaptive.callSync("test");

