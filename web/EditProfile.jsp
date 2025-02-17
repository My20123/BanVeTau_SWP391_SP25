<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
        <title>Edit Profile</title>
        <style>
            body {
                font-family: sans-serif;
                background-color: #f4f4f4;
            }
            nav {
                background-color: #333;
                color: white;
                padding: 10px;
            }

            nav a {
                color: white;
                text-decoration: none;
                margin-right: 20px;
            }

            .container {
                display: flex;
                width: 60%;
                margin: 30px auto;
                background-color: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .sidebar {
                width: 200px;
                padding: 20px;
                text-align: center;
                border-right: 1px solid #ddd;
            }

            .sidebar img {
                width: 200px;
                height: 200px;
                border-radius: 50%;
                margin-bottom: 10px;
                object-fit: cover;
            }

            .content {
                flex: 1;
                padding: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                font-weight: bold;
                width: 30%;
            }

            .btn {
                background-color: #007bff;
                text-decoration: none;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
</head>
<body>
    <nav>
        <a href="Home.jsp">Home</a>
    </nav>
    <div class="container">
        <div class="sidebar">
            <img src="img/DefaultAvt.png" id="display" alt="Avatar" accept=".png">
            <input type="file" id="file" hidden="">
            <btn"file">Change avatar</label>
        </div>
        <div class="content">
            <form action="editprofile" method="post">
                <table>
                    <tr>
                        <th>ID</th>
                        <td><input type="text" name="id" value="${requestScope.userss.id}" readonly></td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td><input type="text" name="uname" value="${requestScope.userss.uname}"></td>
                    </tr>
                    <tr>
                        <th>Phone number</th>
                        <td><input type="text" name="uphone" value="${requestScope.userss.uphone}"></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><input type="text" name="umail" value="${requestScope.userss.umail}"></td>
                    </tr>
                    <tr>
                        <th>Role</th>
                        <td><input type="text" name="role" value="${requestScope.userss.isStaff == 1 ? "Staff" : (requestScope.userss.isAdmin == 1 ? "Admin" : "User")}"></td>
                    </tr>
                </table>
                <input type="submit" class="btn" value="Save changes">
            </form>
        </div>
    </div>
    <script>
        const file = document.getElementById('file');
        const display = document.getElementById('display');
        file.addEventListener('change', (e) => {
            if(e.target.files.length){
                const src = URL.createObjectURL(e.target.files[0]);
                display.src = src;
            }
        });
    </script>
</body>
</html>