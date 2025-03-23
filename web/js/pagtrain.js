let currentPage = 1;
const rowsPerPage = 7;

function displayTablePage(page) {
    const table = document.getElementById("trainTable");
    const rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    const totalRows = rows.length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);

    for (let i = 0; i < totalRows; i++) {
        rows[i].style.display = "none";
    }

    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    for (let i = start; i < end && i < totalRows; i++) {
        rows[i].style.display = "";
    }

    document.getElementById("pagination-info").innerText = `Showing ${start + 1} to ${Math.min(end, totalRows)} of ${totalRows} entries`;

    const paginationControls = document.getElementById("pagination-controls");
    const buttons = paginationControls.getElementsByTagName("button");

    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove("active");
    }

    buttons[page].classList.add("active");
}

function prevPage() {
    if (currentPage > 1) {
        currentPage--;
        displayTablePage(currentPage);
    }
}

function nextPage() {
    const table = document.getElementById("trainTable");
    const rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    const totalRows = rows.length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);

    if (currentPage < totalPages) {
        currentPage++;
        displayTablePage(currentPage);
    }
}

function goToPage(page) {
    currentPage = page;
    displayTablePage(currentPage);
}

// Initialize the table display
document.addEventListener("DOMContentLoaded", function() {
    displayTablePage(currentPage);
});