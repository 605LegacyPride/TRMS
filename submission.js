// The JavaScript that will process the form data and render the button functions
// We can use this code to send the JSON string to Appian which might end up being what we use it for instead

// [!!!] REMEBER TO CHANGE ELEMENT ID NAMES when we make our HTML site [!!!]

window.onload = function() {
    document.getElementById('new-request-form').addEventListener("click", enableInputOtherEvent, false);
    document.getElementById('new-request-form').addEventListener("click", enableInputOtherFormat, false);

    document.getElementById('submit-new-request').addEventListener("click", sendNewRequestForm, false);
}

/**
 * Toggles some fields on or off depending on the radio button selected
 */
function enableInputOtherEvent() {
    var otherTypeRadio = document.getElementById('otherEventTypeRadio');
    var inputOtherType = document.getElementById("inputIfOtherType");

    if (otherTypeRadio.checked) {
        inputOtherType.disabled = false;
    } else if (!otherTypeRadio.checked) {
        inputOtherType.disabled = true;
    }
}

/**
 * Toggles some fields on or off depending on the radio button selected
 */
function enableInputOtherFormat() {
    var otherFormatRadio = document.getElementById('otherGradingFormatRadio');
    var inputOtherGrade = document.getElementById("inputIfOtherGrade");
    var inputOtherPassing = document.getElementById("inputIfOtherPassing");

    if (otherFormatRadio.checked) {
        inputOtherGrade.disabled = false;
        inputOtherPassing.disabled = false;
    } else if (!otherFormatRadio.checked) {
        inputOtherGrade.disabled = true;
        inputOtherPassing.disabled = true;
    }
}

/**
 * Gets all the form fields and sticks it into a json object. Worry about the order later
 */
function sendNewRequestForm() {
    var elements = document.getElementById("new-request-form").elements;
    var obj = {};
    for(var i = 0; i < elements.length; i++){
        var item = elements.item(i);
        obj[item.name] = item.value;
    }
    alert(JSON.stringify(obj));

    /** CONSIDER: Store user uploaded files locally instead of on database to speed up
     * the presentation. Then store the url or path to that file on server instead.
     */
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        console.log(xhr.readyState);
        if (xhr.readyState === 4 && xhr.status === 200) { 
            console.log(xhr.responseText);
            // if we're back here, it means our form was invalid
            document.getElementById('new-request-form').classList.add('was-validated');
        }
    };
	// make sure to change URL to our servlet
    // http method, url-pattern to send to, asynchronous or not - should always be true
    xhr.open("POST", "Request", true); 
    xhr.send(JSON.stringify(obj)); // the thing to send
}
