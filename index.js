// TODO retain user input on the form if the login attempt fails by checking forwarded data
window.onload = function() {
    document.getElementById('login-button').addEventListener("click", doLogin, false);
}

function doLogin() {
    var inputEmail = document.getElementById('email').value;
    var inputPass = document.getElementById('password').value;
    var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if(xhr.readyState === 4 && xhr.status === 200){
            // I think this will print a message to index.html if your email/password are wrong??
            // If your credentials are correct, you will get redirected so you'll never see the message
			var emp = JSON.parse(xhr.responseText);
			document.getElementById("email").value = emp.email;
			document.getElementById("password").value = emp.password;
			document.getElementById("shoe").innerHTML = "Invalid email or password.";
		}
	}
	// send an object named "input" containing the fields email and password to LoginServlet
	xhr.open("POST", "/Login", true);
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send("email="+inputEmail+"&password="+inputPass)
}
