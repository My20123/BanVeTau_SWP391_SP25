var currentPage = 1;
var rowsPerPage = 7;

window.onload = function () {
    displayPage(currentPage);
};

function displayPage(page) {
    var table = document.getElementById("accountTable");
    var tbody = table.getElementsByTagName("tbody")[0];
    var rows = tbody.getElementsByTagName("tr");
    var visibleRows = [];
    
    // Get only visible rows
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].style.display !== "none") {
            visibleRows.push(rows[i]);
        }
    }
    
    // Calculate total pages based on visible rows
    var totalPages = Math.ceil(visibleRows.length / rowsPerPage);
    
    // Validate current page
    if (page < 1) page = 1;
    if (page > totalPages) page = totalPages;
    currentPage = page;

    // Hide all rows first
    for (var i = 0; i < rows.length; i++) {
        rows[i].style.display = "none";
    }

    // Show rows for current page
    var startIndex = (page - 1) * rowsPerPage;
    var endIndex = Math.min(startIndex + rowsPerPage, visibleRows.length);
    
    for (var i = startIndex; i < endIndex; i++) {
        visibleRows[i].style.display = "";
    }

    updatePagination(totalPages);
}

function updatePagination(totalPages) {
    var pageNumbers = document.getElementById("pageNumbers");
    pageNumbers.innerHTML = "";

    // Previous button
    document.getElementById("prevPage").disabled = currentPage === 1;

    // First page
    if (totalPages > 0) {
        addPageButton(1);
    }

    // Ellipsis after first page
    if (currentPage > 3) {
        addEllipsis();
    }

    // Pages around current page
    for (var i = Math.max(2, currentPage - 1); i <= Math.min(totalPages - 1, currentPage + 1); i++) {
        addPageButton(i);
    }

    // Ellipsis before last page
    if (currentPage < totalPages - 2) {
        addEllipsis();
    }

    // Last page
    if (totalPages > 1) {
        addPageButton(totalPages);
    }

    // Next button
    document.getElementById("nextPage").disabled = currentPage === totalPages;
}

function addPageButton(page) {
    var pageNumbers = document.getElementById("pageNumbers");
    var button = document.createElement("button");
    button.textContent = page;
    button.onclick = function() {
        currentPage = page;
        displayPage(page);
    };
    
    if (page === currentPage) {
        button.classList.add("active");
    }
    
    pageNumbers.appendChild(button);
}

function addEllipsis() {
    var pageNumbers = document.getElementById("pageNumbers");
    var span = document.createElement("span");
    span.textContent = "...";
    span.className = "ellipsis";
    pageNumbers.appendChild(span);
}

function prevPage() {
    if (currentPage > 1) {
        displayPage(currentPage - 1);
    }
}

function nextPage() {
    var table = document.getElementById("accountTable");
    var tbody = table.getElementsByTagName("tbody")[0];
    var rows = tbody.getElementsByTagName("tr");
    var visibleRows = [];
    
    // Get only visible rows
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].style.display !== "none") {
            visibleRows.push(rows[i]);
        }
    }
    
    var totalPages = Math.ceil(visibleRows.length / rowsPerPage);
    
    if (currentPage < totalPages) {
        displayPage(currentPage + 1);
    }
}