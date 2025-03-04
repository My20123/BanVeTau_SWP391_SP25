<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit account</title>
        <link rel="stylesheet" href="css/editacc.css">
        <!-- Fontawesome CDN Link For Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    </head>
    <body>
        <form action="editAcc" method="post">
            <h2>Edit account</h2>
            <div class="form-group ID">
                <label for="id">ID</label>
                <input type="text" name="id" value="${requestScope.userss.id}" readonly>
            </div>
            <div class="form-group avatar">
                <label for="avatar">Avatar</label>
                <input type="text" name="avatar" value="${requestScope.userss.avatar}" >
            </div>
            <div class="form-group username">
                <label for="uname">Username</label>
                <input type="text" name="uname" value="${requestScope.userss.uname}">
            </div>
            <div class="form-group email">
                <label for="email">Email</label>
                <input type="email" name="umail" value="${requestScope.userss.umail}">
            </div>
            <div class="form-group phone">
                <label for="phone">Phone number</label>
                <input type="phone" minlength="10" maxlength="10" name="uphone" value="${requestScope.userss.uphone}">
            </div>
            <div class="form-group cccd">
                <label for="cccd">CCCD</label>
                <input type="text" pattern="[0-9]{12}" title="Minimun length for identity number is 12 and not contain letters" name="cccd" value="${requestScope.userss.cccd}">
            </div>
            <div class="form-group role">
                <label for="role">Role</label>
                <select name="role">
                    <option value="0" ${requestScope.userss.isAdmin == 0 && requestScope.userss.isStaff == 0 ? 'selected' : ''}>User</option>
                    <option value="1" ${requestScope.userss.isAdmin == 1 ? 'selected' : ''}>Admin</option>
                    <option value="2" ${requestScope.userss.isStaff == 1 ? 'selected' : ''}>Staff</option>
                </select>
            </div>
            <div class="form-group submit-btn">
                <input type="submit" value="Submit">
            </div>
        </form>

        <script src="script.js"></script>
    </body>
</html>
