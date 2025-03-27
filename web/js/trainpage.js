function filterTable() {
    var input = document.getElementById("search").value.toUpperCase();
    var filterType = document.getElementById("filterTrain").value;
    var table = document.getElementById("trainTable");
    var tr = table.getElementsByTagName("tr");

    // Ánh xạ giá trị filter với index cột trong bảng
    var filterMapping = {
        "id": 0,
        "type": 1,
        "status": 2,
        "seats": 3,
        "cabins": 4,
        "seat_ava": 5
    };

    var filteredRows = [];

    for (var i = 1; i < tr.length; i++) {
        var tds = tr[i].getElementsByTagName("td");
        var match = false;

        if (filterType === "all") {
            // Kiểm tra tất cả các cột
            for (var j = 0; j < tds.length; j++) {
                if (tds[j].innerText.toUpperCase().indexOf(input) > -1) {
                    match = true;
                    break;
                }
            }
        } else {
            // Chỉ kiểm tra cột được chọn
            var colIndex = filterMapping[filterType];
            if (tds[colIndex] && tds[colIndex].innerText.toUpperCase().indexOf(input) > -1) {
                match = true;
            }
        }

        if (match) {
            filteredRows.push(tr[i]);
        }
    }

    updateTable(filteredRows);
}


function updateTable(filteredRows) {
    var table = document.getElementById("trainTable");
    var tr = table.getElementsByTagName("tr");

    for (var i = 1; i < tr.length; i++) {
        tr[i].style.display = "none";
    }

    for (var i = 0; i < filteredRows.length; i++) {
        filteredRows[i].style.display = "";
    }

    updatePagination(filteredRows);
}

var currentPage = 1;
var rowsPerPage = 10;

function updatePagination(filteredRows) {
    var pagination = document.querySelector(".pagination div");
    pagination.innerHTML = '<button onclick="prevPage()">&lt;</button>';

    var totalPages = Math.ceil(filteredRows.length / rowsPerPage);
    for (var i = 1; i <= totalPages; i++) {
        pagination.innerHTML += `<button class="${i === currentPage ? 'active' : ''}" onclick="goToPage(${i})">${i}</button>`;
    }
    pagination.innerHTML += '<button onclick="nextPage()">&gt;</button>';

    goToPage(1, filteredRows);
}

function goToPage(page, filteredRows = null) {
    var table = document.getElementById("trainTable");
    var tr = table.getElementsByTagName("tr");

    if (!filteredRows) {
        filteredRows = Array.from(tr).slice(1);
    }

    var totalRows = filteredRows.length;
    var totalPages = Math.ceil(totalRows / rowsPerPage);

    if (page < 1) page = 1;
    if (page > totalPages) page = totalPages;

    for (var i = 0; i < totalRows; i++) {
        filteredRows[i].style.display = "none";
    }

    for (var i = (page - 1) * rowsPerPage; i < page * rowsPerPage && i < totalRows; i++) {
        filteredRows[i].style.display = "";
    }

    currentPage = page;
    updateActivePagination(page);
}

function updateActivePagination(page) {
    var buttons = document.querySelectorAll(".pagination div button");
    buttons.forEach(btn => btn.classList.remove("active"));
    buttons[page].classList.add("active");
}

function prevPage() {
    if (currentPage > 1) {
        goToPage(currentPage - 1);
    }
}

function nextPage() {
    var totalRows = document.querySelectorAll("#trainTable tbody tr:not([style*='display: none'])").length;
    var totalPages = Math.ceil(totalRows / rowsPerPage);
    
    if (currentPage < totalPages) {
        goToPage(currentPage + 1);
    }
}

window.onload = function() {
    var rows = Array.from(document.querySelectorAll("#trainTable tbody tr"));
    updatePagination(rows);
};
