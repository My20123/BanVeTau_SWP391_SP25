
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Form</title>
    <link rel="stylesheet" href="css/edit.css">
</head>
<body>
    <div class="form-container">
        <h2>Edit train</h2>
        <form action="editT" method="post">
            <div class="form-group">
                <label for="id">Train id</label>
                <input type="text" name="id" value="${requestScope.trains.tid}">
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status">
                    <option value="0" ${requestScope.trains.status == 0 ? 'selected' : ''}>Maintenance</option>
                    <option value="1" ${requestScope.trains.status == 1 ? 'selected' : ''}>Available</option>
                </select>
            </div>
            <div class="form-group">
                <label for="seat">Total seat</label>
                <input type="text" name="seat" value="${requestScope.trains.number_seats}">
            </div>
            <div class="form-group">
                <label for="cabin">Total cabin</label>
                <input type="text" name="cabin" value="${requestScope.trains.number_cabins}">
            </div>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>
