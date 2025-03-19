<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Train</title>
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
            display: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Train</h2>
        <form action="editT" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="id">Train ID</label>
                <input type="text" name="id" id="id" value="${requestScope.trains.tid}" readonly>
                <div class="error-message" id="idError"></div>
            </div>
            
            <div class="form-group">
                <label for="type">Train Type</label>
                <select name="type" id="type" required>
                    <option value="Tàu thường" ${requestScope.trains.train_type == 'Tàu thường' ? 'selected' : ''}>Tàu thường</option>
                    <option value="Tàu nhanh" ${requestScope.trains.train_type == 'Tàu nhanh' ? 'selected' : ''}>Tàu nhanh</option>
                    <option value="Tàu cao cấp" ${requestScope.trains.train_type == 'Tàu cao cấp' ? 'selected' : ''}>Tàu cao cấp</option>
                </select>
                <div class="error-message" id="typeError"></div>
            </div>
            
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status" id="status" required>
                    <option value="0" ${requestScope.trains.status == 0 ? 'selected' : ''}>Maintenance</option>
                    <option value="1" ${requestScope.trains.status == 1 ? 'selected' : ''}>Available</option>
                </select>
                <div class="error-message" id="statusError"></div>
            </div>
            
            <div class="form-group">
                <label for="seat">Total Seats</label>
                <input type="number" name="seat" id="seat" value="${requestScope.trains.total_seats}" min="1" required>
                <div class="error-message" id="seatError"></div>
            </div>
            
            <div class="form-group">
                <label for="cabin">Total Cabins</label>
                <input type="number" name="cabin" id="cabin" value="${requestScope.trains.number_cabins}" min="1" required>
                <div class="error-message" id="cabinError"></div>
            </div>
            
            <div class="form-group">
                <label for="ava_seat">Available Seats</label>
                <input type="number" name="ava_seat" id="ava_seat" value="${requestScope.trains.available_seats}" min="0" required>
                <div class="error-message" id="avaSeatError"></div>
            </div>
            
            <input type="submit" value="Update Train">
        </form>
    </div>

    <script>
        function validateForm() {
            let isValid = true;
            
            // Reset error messages
            document.querySelectorAll('.error-message').forEach(elem => {
                elem.style.display = 'none';
            });
            
            // Validate total seats
            const totalSeats = parseInt(document.getElementById('seat').value);
            if (totalSeats < 1) {
                document.getElementById('seatError').textContent = 'Total seats must be greater than 0';
                document.getElementById('seatError').style.display = 'block';
                isValid = false;
            }
            
            // Validate total cabins
            const totalCabins = parseInt(document.getElementById('cabin').value);
            if (totalCabins < 1) {
                document.getElementById('cabinError').textContent = 'Total cabins must be greater than 0';
                document.getElementById('cabinError').style.display = 'block';
                isValid = false;
            }
            
            // Validate available seats
            const availableSeats = parseInt(document.getElementById('ava_seat').value);
            if (availableSeats < 0) {
                document.getElementById('avaSeatError').textContent = 'Available seats cannot be negative';
                document.getElementById('avaSeatError').style.display = 'block';
                isValid = false;
            }
            
            if (availableSeats > totalSeats) {
                document.getElementById('avaSeatError').textContent = 'Available seats cannot be greater than total seats';
                document.getElementById('avaSeatError').style.display = 'block';
                isValid = false;
            }
            
            return isValid;
        }
    </script>
</body>
</html>
