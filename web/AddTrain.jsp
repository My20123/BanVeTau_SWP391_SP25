<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Train</title>
    <link rel="stylesheet" href="css/edit.css">
</head>
<body>
    <div class="form-container">
        <h2>Add Train</h2>
        <form action="addT" method="post">
            <div class="form-group">
                <label for="id">Train ID</label>
                <input type="text" name="id" required>
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status" required>
                    <option>Choose status</option>
                    <option value="0">Maintenance</option>
                    <option value="1">Available</option>
                </select>
            </div>
            <div class="form-group">
                <label for="seat">Total Seats</label>
                <input type="text" name="seat" required>
            </div>
            <div class="form-group">
                <label for="cabin">Total Cabins</label>
                <input type="text" name="cabin" required>
            </div>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>