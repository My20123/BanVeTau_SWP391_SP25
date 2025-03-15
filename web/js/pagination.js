var currentPage = 1;
var rowsPerPage = 10;

function displayPage(page) {
    var table = document.getElementById("accountTable");
    var tr = table.getElementsByTagName("tr");
    var totalRows = tr.length - 1; // excluding the header row
    var totalPages = Math.ceil(totalRows / rowsPerPage);

    if (page < 1) page = 1;
    if (page > totalPages) page = totalPages;

    for (var i = 1; i < tr.length; i++) {
        if (i > (page - 1) * rowsPerPage && i <= page * rowsPerPage) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }

    updatePageNumbers(totalPages);
    document.getElementById("pageNumbers").querySelectorAll("button")[page - 1].classList.add("active");
}

function updatePageNumbers(totalPages) {
    var pageNumbers = document.getElementById("pageNumbers");
    pageNumbers.innerHTML = "";

    for (var i = 1; i <= totalPages; i++) {
        var button = document.createElement("button");
        button.innerText = i;
        button.onclick = (function(page) {
            return function() {
                currentPage = page;
                displayPage(page);
            };
        })(i);
        pageNumbers.appendChild(button);
    }
}

function prevPage() {
    if (currentPage > 1) {
        currentPage--;
        displayPage(currentPage);
    }
}

function nextPage() {
    var table = document.getElementById("accountTable");
    var tr = table.getElementsByTagName("tr");
    var totalRows = tr.length - 1; // excluding the header row
    var totalPages = Math.ceil(totalRows / rowsPerPage);

    if (currentPage < totalPages) {
        currentPage++;
        displayPage(currentPage);
    }
}

// Initialize the first page
displayPage(currentPage);