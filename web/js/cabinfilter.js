function filterTable() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("search");
    filter = input.value.toUpperCase();
    table = document.getElementById("trainTable");
    tr = table.getElementsByTagName("tr");
    var select = document.getElementById("filterCabin");
    var filterValue = select.value;

    for (i = 1; i < tr.length; i++) {
        tr[i].style.display = "none";
        td = tr[i].getElementsByTagName("td");
        for (var j = 0; j < td.length; j++) {
            if (td[j]) {
                txtValue = td[j].textContent || td[j].innerText;
                if (filterValue === "all" || td[j].getAttribute("data-column") === filterValue) {
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        break;
                    }
                }
            }
        }
    }
    
}

var currentPage = 1;
var rowsPerPage = 10;

function goToPage(page) {
    var table, tr, i;
    table = document.getElementById("trainTable");
    tr = table.getElementsByTagName("tr");
    var totalRows = tr.length - 1;
    var totalPages = Math.ceil(totalRows / rowsPerPage);

    if (page < 1) page = 1;
    if (page > totalPages) page = totalPages;

    for (i = 1; i < tr.length; i++) {
        tr[i].style.display = "none";
    }

    for (i = (page - 1) * rowsPerPage + 1; i <= page * rowsPerPage && i < tr.length; i++) {
        tr[i].style.display = "";
    }

    currentPage = page;
    updatePagination(totalPages);
}

function prevPage() {
    if (currentPage > 1) {
        goToPage(currentPage - 1);
    }
}

function nextPage() {
    var table, tr;
    table = document.getElementById("trainTable");
    tr = table.getElementsByTagName("tr");
    var totalRows = tr.length - 1;
    var totalPages = Math.ceil(totalRows / rowsPerPage);

    if (currentPage < totalPages) {
        goToPage(currentPage + 1);
    }
}

function updatePagination(totalPages) {
    var pagination = document.querySelector(".pagination div");
    pagination.innerHTML = '<button onclick="prevPage()">&lt;</button>';
    for (var i = 1; i <= totalPages; i++) {
        pagination.innerHTML += '<button onclick="goToPage(' + i + ')">' + i + '</button>';
    }
    pagination.innerHTML += '<button onclick="nextPage()">&gt;</button>';
}

window.onload = function() {
    goToPage(1);
};