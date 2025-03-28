<%-- 
    Document   : newjsp
    Created on : Mar 25, 2025, 9:42:56 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Auto Fill Example</title>
    <script>
        function extractNumber() {
            const typeValue = document.getElementById("type").value;
            const numberMatch = typeValue.match(/\d+/); // Lấy số từ chuỗi
            const number = numberMatch ? numberMatch[0] : ""; // Nếu tìm thấy số, lấy số đó
            document.getElementById("availableSeat").value = number;
            document.getElementById("numberSeat").value = number;
        }
    </script>
</head>
<body>
    <form>
        <label for="type">Type:</label>
        <input type="text" id="type" name="type" oninput="extractNumber()">
        <br><br>
        <label for="availableSeat">Available Seat:</label>
        <input type="text" id="availableSeat" name="availableSeat" readonly>
        <br><br>
        <label for="numberSeat">Number Seat:</label>
        <input type="text" id="numberSeat" name="numberSeat" readonly>
    </form>
</body>
</html>
