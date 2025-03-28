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
</head>
<body>
    <div class="form-container">
        <h2>Edit Seat</h2>
        <form action="updateS" method="post">
            <div class="form-group">
                <label for="id">Seat ID</label>
                <input type="text" name="id" id="id" value="${requestScope.seat.id}" readonly>
                <div class="error-message" id="idError"></div>
            </div>
                <div class="form-group">
                <label for="id">Seat ID</label>
                <input type="text" name="seatNo" id="id" value="${requestScope.seat.seatNo}" readonly>
                <div class="error-message" id="idError"></div>
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status" id="status" required>
                    <option value="0" ${requestScope.seat.status == 0 ? 'selected' : ''}>Available</option>
                    <option value="1" ${requestScope.seat.status == 1 ? 'selected' : ''}>Unavailable</option>                    
                </select>
            </div>
                <div class="form-group">
                <label for="id">Price</label>
                <input type="text" name="price" id="id" value="${requestScope.seat.price}" >
                <div class="error-message" id="idError"></div>
            </div>
                <div class="form-group">
                <label for="id">Cabin id</label>
                <input type="text" name="cbid" id="id" value="${requestScope.seat.cabinid}" readonly>
                <div class="error-message" id="idError"></div>
            </div>
            <input type="submit" value="Update Seat">
        </form>
    </div>
</body>
</html>