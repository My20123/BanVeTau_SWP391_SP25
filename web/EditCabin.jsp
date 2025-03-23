<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Cabin</title>
        <link rel="stylesheet" href="css/edit.css">
        <style>
            .form-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .form-group input:focus, .form-group select:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
            }

            input[type="submit"] {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .error-message {
                color: #dc3545;
                font-size: 14px;
                margin-top: 5px;
            }
        </style>
        <script>
            function validateForm() {
                var numberSeat = document.getElementById("nseat").value;
                var availableSeat = document.getElementById("aseat").value;
                var errorMessage = document.getElementById("seatError");

                if (parseInt(availableSeat) > parseInt(numberSeat)) {
                    errorMessage.style.display = "block";
                    errorMessage.innerText = "Available seats cannot be greater than number of seats.";
                    return false;
                } else {
                    errorMessage.style.display = "none";
                    return true;
                }
            }
        </script>
    </head>
    <body>
        <div class="form-container">
            <h2>Edit Cabin</h2>
            <form action="editC" method="post" onsubmit="return validateForm()">
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                <div class="form-group">
                    <label for="id">Cabin ID</label>
                    <input type="text" name="id" id="id" value="${requestScope.cabins.id}" readonly>
                    <div class="error-message" id="idError"></div>
                </div>
                <div class="form-group">
                    <label for="nseat">Number Seat</label>
                    <input type="number" name="nseat" id="nseat" value="${requestScope.cabins.number_seats}" required>
                </div>
                <div class="form-group">
                    <label for="status">Status</label>
                    <select name="status" id="status" required>
                        <option value="0" ${requestScope.cabins.status == 0 ? 'selected' : ''}>Full</option>
                        <option value="1" ${requestScope.cabins.status == 1 ? 'selected' : ''}>Available</option>
                        <option value="2" ${requestScope.cabins.status == 2 ? 'selected' : ''}>Sold Out</option>
                    </select>
                    <div class="error-message" id="statusError"></div>
                </div>

                <div class="form-group">
                    <label for="aseat">Available Seat</label>
                    <input type="number" name="aseat" id="aseat" value="${requestScope.cabins.avail_seats}" min="0" required>
                    <div class="error-message" id="seatError"></div>
                </div>
                <div class="form-group">
                    <label for="tid">Train ID</label>
                    <input type="text" name="tid" id="tid" value="${requestScope.cabins.trid}" readonly>
                </div>

                <div class="form-group">
                    <label for="ctype">Cabin Type</label>
                    <input type="text" name="ctype" id="ctype" value="${requestScope.cabins.ctype}" required>
                    <div class="error-message" id="ctypeError"></div>
                </div>
                <div class="form-group">
                    <label for="sid">Schedule ID</label>
                    <input type="number" name="sid" id="sid" value="${requestScope.cabins.sid}" min="0" required>
                    <div class="error-message" id="sidError"></div>
                </div>

                <input type="submit" value="Update Cabin">
            </form>
        </div>
    </body>
</html>