function filterAcc() {
    // Lấy giá trị từ ô tìm kiếm và dropdown
    var input = document.getElementById("search_acc").value.toLowerCase();
    var filterCriteria = document.getElementById("filterCriteria").value;
    var table = document.getElementById("accountTable");
    var tbody = table.getElementsByTagName("tbody")[0];
    var rows = tbody.getElementsByTagName("tr");

    // Hiển thị tất cả các hàng trước khi tìm kiếm
    for (var i = 0; i < rows.length; i++) {
        rows[i].style.display = "";
    }

    // Lặp qua từng hàng trong bảng
    for (var i = 0; i < rows.length; i++) {
        var cells = rows[i].getElementsByTagName("td");
        var show = false;

        // Kiểm tra tiêu chí lọc
        switch (filterCriteria) {
            case "id":
                show = cells[0] && cells[0].innerText.toLowerCase().indexOf(input) > -1;
                break;
            case "username":
                show = cells[2] && cells[2].innerText.toLowerCase().indexOf(input) > -1;
                break;
            case "email":
                show = cells[3] && cells[3].innerText.toLowerCase().indexOf(input) > -1;
                break;
            case "phone":
                show = cells[4] && cells[4].innerText.toLowerCase().indexOf(input) > -1;
                break;
            case "cccd":
                show = cells[5] && cells[5].innerText.toLowerCase().indexOf(input) > -1;
                break;
            case "role":
                show = cells[6] && cells[6].innerText.toLowerCase().indexOf(input) > -1;
                break;
            case "status":
                show = cells[7] && cells[7].innerText.toLowerCase().indexOf(input) > -1;
                break;
            default: // "all"
                for (var j = 0; j < cells.length; j++) {
                    if (cells[j] && cells[j].innerText.toLowerCase().indexOf(input) > -1) {
                        show = true;
                        break;
                    }
                }
                break;
        }

        // Hiển thị hoặc ẩn hàng dựa trên kết quả lọc
        rows[i].style.display = show ? "" : "none";
    }
}