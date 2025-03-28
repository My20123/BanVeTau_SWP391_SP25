<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Seat</title>
        <link rel="stylesheet" href="css/edit.css">
        <style>
            .error-message {
                color: red;
                font-size: 12px;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Add Seat</h2>
            <form action="addSeat" method="post">
                <div class="form-group">
                    <label for="cabinId">Cabin ID</label>
                    <input type="text" name="cabinId" required>
                </div>
                <div class="form-group">
                    <label for="totalSeats">Total Seats</label>
                    <input type="text" name="totalSeats" min="1" required>
                </div>
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                   if (errorMessage != null) { %>
                    <span class="error-message"><%= errorMessage %></span>
                <% } %>
                <input type="submit" value="Add Seats">
            </form>
        </div>
    </body>
</html>
