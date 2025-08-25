  const lists = document.querySelectorAll(".list");

  lists.forEach(function(list) {
    list.addEventListener("click", function(event) {
        if (!this.classList.contains("nav-link")) {
            event.preventDefault(); //prevent default behavior only for elements other than links
        }
      const contentId = this.getAttribute("data-content");

      // Highlight the clicked list item and display the corresponding content section
      lists.forEach(function(item) {
        item.classList.remove("active");
      });
      this.classList.add("active");

    });
  });