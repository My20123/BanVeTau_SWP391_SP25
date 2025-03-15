/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let cabinPatterns = {}; // Object lưu pattern layout của cabin

function saveCabinPatterns() {
    document.querySelectorAll(".et-car-block").forEach(cabin => {
        let cabinId = cabin.querySelector(".et-car-icon").getAttribute("data-cabin-id");
        let rows = parseInt(cabin.getAttribute("data-rows"), 10) || 4; // Lấy số hàng (default 4)
        let cols = parseInt(cabin.getAttribute("data-columns"), 10) || 2; // Lấy số cột (default 2)

        // Giả định mỗi cabin có danh sách ghế cố định
        let seats = [];
        for (let i = 0; i < rows; i++) {
            let rowSeats = [];
            for (let j = 0; j < cols; j++) {
                rowSeats.push(`${String.fromCharCode(65 + i)}${j + 1}`);
            }
            seats.push(rowSeats);
        }

        // Lưu pattern vào object
        cabinPatterns[cabinId] = { rows, columns: cols, seats };
    });

    console.log("Cabin Patterns Saved:", cabinPatterns);
}

// Gọi hàm khi trang load
document.addEventListener("DOMContentLoaded", saveCabinPatterns);
function saveCabinPatternsToLocalStorage() {
    let cabinData = {};

    document.querySelectorAll(".et-car-block").forEach(cabin => {
        let cabinId = cabin.querySelector(".et-car-icon").getAttribute("data-cabin-id");
        let rows = parseInt(cabin.getAttribute("data-rows"), 10) || 4;
        let cols = parseInt(cabin.getAttribute("data-columns"), 10) || 2;

        let seats = [];
        for (let i = 0; i < rows; i++) {
            let rowSeats = [];
            for (let j = 0; j < cols; j++) {
                rowSeats.push(`${String.fromCharCode(65 + i)}${j + 1}`);
            }
            seats.push(rowSeats);
        }

        cabinData[cabinId] = { rows, columns: cols, seats };
    });

    localStorage.setItem("cabinPatterns", JSON.stringify(cabinData)); // Lưu vào localStorage
    console.log("Cabin Patterns saved to localStorage:", cabinData);
}

// Gọi hàm khi trang load
document.addEventListener("DOMContentLoaded", saveCabinPatternsToLocalStorage);
function loadCabinPatternsFromLocalStorage() {
    let storedCabins = JSON.parse(localStorage.getItem("cabinPatterns")) || {};
    console.log("Loaded Cabin Patterns:", storedCabins);

    Object.keys(storedCabins).forEach(cabinId => {
        console.log(`Pattern for Cabin ${cabinId}:`, storedCabins[cabinId]);
    });
}

// Gọi hàm khôi phục cabin sau khi trang load lại
document.addEventListener("DOMContentLoaded", loadCabinPatternsFromLocalStorage);
