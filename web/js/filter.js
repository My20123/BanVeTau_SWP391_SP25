//Filter Account
function filterAcc() {
    var input = document.getElementById("search_acc");
    var filter = input.value.toLowerCase();
    var table = document.getElementById("accountTable");
    var tbody = table.getElementsByTagName("tbody")[0];
    var tr = tbody.getElementsByTagName("tr");
    var checkedCriteria = getCheckedCriteria();

    // Reset all rows to visible first
    for (var i = 0; i < tr.length; i++) {
        tr[i].style.display = "";
    }

    // Apply filters
    for (var i = 0; i < tr.length; i++) {
        var td = tr[i].getElementsByTagName("td");
        var show = true;

        if (filter) {
            show = false;
            for (var j = 0; j < td.length; j++) {
                var cell = td[j];
                if (checkedCriteria.length === 0 || checkedCriteria.includes(j)) {
                    if (cell) {
                        var text = cell.textContent || cell.innerText;
                        if (text.toLowerCase().indexOf(filter) > -1) {
                            show = true;
                            break;
                        }
                    }
                }
            }
        }

        tr[i].style.display = show ? "" : "none";
    }

    // Reset pagination to first page and update display
    currentPage = 1;
    displayPage(1);
}

function getCheckedCriteria() {
    var checkboxes = document.getElementsByName("filterCriteria");
    var checked = [];
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            switch (checkboxes[i].value) {
                case "id":
                    checked.push(0);
                    break;
                case "username":
                    checked.push(2);
                    break;
                case "email":
                    checked.push(3);
                    break;
                case "phone":
                    checked.push(4);
                    break;
                case "cccd":
                    checked.push(5);
                    break;
                case "role":
                    checked.push(6);
                    break;
                case "status":
                    checked.push(7);
                    break;
            }
        }
    }
    return checked;
}

//  Filter train
function Train() {
    var inputT = document.getElementById("search").value.toLowerCase();
    var filterTrain = document.getElementById("filterTrain").value;
    var tableT = document.getElementById("trainTable");
    var trT = tableT.getElementsByTagName("tr");

    // Reset all rows to visible first
    for (var i = 1; i < trT.length; i++) {
        trT[i].style.display = "";
    }

    for (var i = 1; i < trT.length; i++) {
        var tdTid = trT[i].getElementsByTagName("td")[0];
        var tdStatus = trT[i].getElementsByTagName("td")[1];
        var tdSeats = trT[i].getElementsByTagName("td")[2];
        var tdCabins = trT[i].getElementsByTagName("td")[3];
        if (tdTid && tdStatus && tdSeats && tdCabins) {
            var tidValue = tdTid.textContent || tdTid.innerText;
            var statusValue = tdStatus.textContent || tdStatus.innerText;
            var seatsValue = tdSeats.textContent || tdSeats.innerText;
            var cabinsValue = tdCabins.textContent || tdCabins.innerText;
            var display = false;

            if (filterTrain === "all") {
                display = tidValue.toLowerCase().indexOf(inputT) > -1 ||
                          statusValue.toLowerCase().indexOf(inputT) > -1 ||
                          seatsValue.toLowerCase().indexOf(inputT) > -1 ||
                          cabinsValue.toLowerCase().indexOf(inputT) > -1;
            } else if (filterTrain === "id") {
                display = tidValue.toLowerCase().indexOf(inputT) > -1;
            } else if (filterTrain === "status") {
                display = statusValue.toLowerCase().indexOf(inputT) > -1;
            } else if (filterTrain === "seats") {
                display = seatsValue.toLowerCase().indexOf(inputT) > -1;
            } else if (filterTrain === "cabins") {
                display = cabinsValue.toLowerCase().indexOf(inputT) > -1;
            }

            trT[i].style.display = display ? "" : "none";
        }
    }
}