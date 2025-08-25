document.addEventListener("DOMContentLoaded", function() {
    var darkMode = localStorage.getItem('darkMode');
    if (darkMode !== null) {
        if (darkMode === 'true') {
            document.body.classList.add('dark-mode');
        
            var elementsToAddDarkMode = document.querySelectorAll('nav, nav .sidebar, .logo .logo-name, #staffEditProfilePage, #addCustForm, #addCustCardBody, #addCustContainer, #addStaffForm, #addCustCardBody, #editStaffForm, #regStaffSuccessBox, #addItemForm, #addItemCardBody, #addItemContainer, #itemProfileForm, #itemProfileCardBody, #itemProfileContainer');
            elementsToAddDarkMode.forEach(function(element) {
                element.classList.add('dark-mode');
            });
            
            var elementToAddWhiteWord = document.querySelectorAll('.nav-link .link, .nav-link .icon');
            elementToAddWhiteWord.forEach(function(element) {
                element.classList.add('white-word');
            });
            
            //TABLE
            // Add border styles when dark mode is true
            var nav = document.querySelector('nav');
            nav.style.borderBottom = '2px solid darkgray';
            var sidebar = document.querySelector('nav .sidebar');
            sidebar.style.borderRight = '2px solid darkgray';

            // Modify the CSS selector for thead td in dark mode
            var tableHeaderCells = document.querySelectorAll('table, body, #addStaffPage');
            tableHeaderCells.forEach(function(cell) {
                cell.classList.add('dark-mode');
            });
        }
        else{
            document.body.classList.remove('dark-mode');
            
            var elementsToAddDarkMode = document.querySelectorAll('nav, nav .sidebar, .logo .logo-name, #staffEditProfilePage, #addCustForm, #addCustCardBody, #addCustContainer, #addStaffForm, #addCustCardBody, #editStaffForm, #regStaffSuccessBox, #addItemForm, #addItemCardBody, #addItemContainer, #itemProfileForm, #itemProfileCardBody, #itemProfileContainer');
            elementsToAddDarkMode.forEach(function(element) {
                element.classList.remove('dark-mode');
            });
            
            var elementToAddWhiteWord = document.querySelectorAll('.nav-link .link, .nav-link .icon');
            elementToAddWhiteWord.forEach(function(element) {
                element.classList.remove('white-word');
            });
            
            //TABLE
            // Remove border styles when dark mode is false
            var nav = document.querySelector('nav');
            nav.style.borderBottom = '';
            var sidebar = document.querySelector('nav .sidebar');
            sidebar.style.borderRight = '';
            
            // Modify the CSS selector for thead td in dark mode
            var tableHeaderCells = document.querySelectorAll('table, body, #addStaffPage');
            tableHeaderCells.forEach(function(cell) {
                cell.classList.remove('dark-mode');
            });
        }
    }
});