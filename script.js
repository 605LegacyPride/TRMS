// on every page
window.onload = function () {
    checkSessionExists();

    var logoutButton1 = document.getElementById('logout-button1');
    var logoutButton1 = document.getElementById('logout-button2');
    logoutButton1.addEventListener("click", doLogout, false);
    logoutButton2.addEventListener("click", doLogout, false);
}

function checkSessionExists() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        console.log(xhr.readyState);
        if (xhr.readyState === 4 && xhr.status === 200) {
            // If session does exist, responseText contains employee info stored in the session as JSON string
            let obj = JSON.parse(xhr.responseText);
            console.log(obj);
        }
    };
	// ask /Emp to see if session exists. If session does not exist, it redirects client to log in
	// IMPORTANT Remember to update server URL param to whatever we name the `Employee` Servlet
	xhr.open("GET", "Employee", true);
    xhr.send()
}

function doLogout() {
    var xhr = new XMLHttpRequest();
	// Invalidates session variable and returns client to log in page, index.html
	xhr.open("GET", "Logout", true);
	xhr.send();
}
