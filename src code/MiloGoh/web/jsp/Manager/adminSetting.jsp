<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>${companyName} | Settings</title>
    <style>
*{
    transition: all 0.2s linear;
}

body{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

div{
    display: flex;
    flex-direction: column;
    align-items: center;
}

.button{
    width: 50px;
    height: 20px;
    padding: 5px;
    background: black;
    border-radius: 20px;
    position: relative;
    transition: all 0.2s linear;
    cursor: pointer;
}
.circle{
    position: absolute;
    height: 20px;
    width: 20px;
    background: white;
    border-radius: 20px;
    left: 5px;
    transition: all 0.2s linear;
}
    </style>
</head>
<body>
    <div>
        <!-- Manage Account Row -->
        <div class="row">
            <h2>Manage Your Account</h2>
            <!-- Your account management options go here -->
        </div>

<!--         Light/Dark Mode Row 
        <div class="row">
            <h2>Light Mode / Dark Mode</h2>
            <button id="toggleMode" class="button">Toggle Dark Mode</button>
        </div>-->
<span>test</span>
        <div class="button" id="switch">
            
            <div class="circle" id="circle"></div>
        </div>
    </div>

    <!-- JavaScript for toggling dark mode -->
    <script>
const button = document.getElementById('switch');
const circle = document.getElementById('circle');
const body = document.body;
var darkMode = localStorage.getItem('darkMode');
if (darkMode !== null) {
    if (darkMode === 'true'){
        circle.style.left = 'calc(100% - 25px)';
        circle.style.background = 'black';
        button.style.background = 'white';
        body.style.background = 'black';
        body.style.color = 'white';
    }
}

button.addEventListener('click', ()=>{
    if(circle.style.left === '5px'){
        circle.style.left = 'calc(100% - 25px)';
        circle.style.background = 'black';
        button.style.background = 'white';
        
        body.style.background = 'black';
        body.style.color = 'white';
        
        // Add the 'dark-mode' class to the body element
        document.body.classList.add('dark-mode');

        // Save the dark mode preference in local storage
        localStorage.setItem('darkMode', true);
        console.log('Dark mode enabled. Value in localStorage:', localStorage.getItem('darkMode'));

    } else{
        circle.style.left = '5px';
        circle.style.background = 'white';
        button.style.background = 'black';
        
        body.style.background = 'white';
        body.style.color = 'black';
        
        // Remove the 'dark-mode' class from the body element
        document.body.classList.remove('dark-mode');

        // Save the dark mode preference in local storage
        localStorage.setItem('darkMode', false);
        console.log('Dark mode disabled. Value in localStorage:', localStorage.getItem('darkMode'));
    }
    
//    var script = document.createElement('script');
//        script.src = '../../js/adminDarkMode.js';
//        document.body.appendChild(script);

});

</script>
</body>
</html>
