//Filter Account
function filterAcc() {
    var inputA = document.getElementById("search_acc").value.toLowerCase();
    var filterCriteria = document.getElementById("filterCriteria").value;
    var tableA = document.querySelector("table tbody");
    var trA = tableA.getElementsByTagName("tr");

    for (var i = 0; i < trA.length; i++) {
        var tdId = trA[i].getElementsByTagName("td")[0];
        var tdUsername = trA[i].getElementsByTagName("td")[2];
        var tdEmail = trA[i].getElementsByTagName("td")[3];
        var tdPhone = trA[i].getElementsByTagName("td")[4];
        var tdCCCD = trA[i].getElementsByTagName("td")[5];
        var tdRole = trA[i].getElementsByTagName("td")[6];
        var tdStatus = trA[i].getElementsByTagName("td")[7];

        if (tdId && tdUsername && tdEmail && tdPhone && tdCCCD && tdRole && tdStatus) {
            var idValue = tdId.textContent || tdId.innerText;
            var usernameValue = tdUsername.textContent || tdUsername.innerText;
            var emailValue = tdEmail.textContent || tdEmail.innerText;
            var phoneValue = tdPhone.textContent || tdPhone.innerText;
            var cccdValue = tdCCCD.textContent || tdCCCD.innerText;
            var roleValue = tdRole.textContent || tdRole.innerText;
            var statusValue = tdStatus.textContent || tdStatus.innerText;
            var display = false;

            if (filterCriteria === "all") {
                display = idValue.toLowerCase().indexOf(inputA) > -1 ||
                          usernameValue.toLowerCase().indexOf(inputA) > -1 ||
                          emailValue.toLowerCase().indexOf(inputA) > -1 ||
                          phoneValue.toLowerCase().indexOf(inputA) > -1 ||
                          cccdValue.toLowerCase().indexOf(inputA) > -1 ||
                          roleValue.toLowerCase().indexOf(inputA) > -1 ||
                          statusValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "id") {
                display = idValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "username") {
                display = usernameValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "email") {
                display = emailValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "phone") {
                display = phoneValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "cccd") {
                display = cccdValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "role") {
                display = roleValue.toLowerCase().indexOf(inputA) > -1;
            } else if (filterCriteria === "status") {
                display = statusValue.toLowerCase().indexOf(inputA) > -1;
            }

            trA[i].style.display = display ? "" : "none";
        }
    }
}
//  Filter train
        function Train() {
    var inputT = document.getElementById("search").value.toLowerCase();
    var filterTrain = document.getElementById("filterTrain").value;
    var tableT = document.getElementById("trainTable");
    var trT = tableT.getElementsByTagName("tr");

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