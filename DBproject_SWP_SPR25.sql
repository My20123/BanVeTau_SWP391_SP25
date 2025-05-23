USE prj_train;

-- drop database prj_train
-- create database prj_train
-- Create the Accounts table
CREATE TABLE Accounts (
	uID int   AUTO_INCREMENT PRIMARY KEY,
	uname varchar(255) NULL,
    umail varchar(255) NULL,
    pass varchar(255) NULL,
    uphone varchar(15) NULL,
	isStaff int NULL,
	isAdmin int NULL,
	cccd varchar(15) NULL,
    avatar varchar(50) Null,
    status boolean Null
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- drop table Order_details;
-- drop table Refund;
-- drop table Accounts
-- drop table Tickets
-- drop table Seats
-- drop table Cabins
-- drop table Schedules
-- drop table Trains
-- drop table Routes_data
-- drop table Routes

-- Create the Route table 
CREATE TABLE Routes(
 id int AUTO_INCREMENT PRIMARY KEY,
 from_station varchar(200) NULL,
 to_station varchar(200) NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- drop table Routes_data
CREATE TABLE Routes_data (
    id INT,
    route_key varchar(100),
    value int,
    FOREIGN KEY (id) REFERENCES Routes(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Train table with foreign key to Route table
CREATE TABLE Trains(
id varchar(5) PRIMARY KEY,
train_type VARCHAR(100) NOT NULL,
status int  NULL, -- 1 là available, 0 là not available
number_seat int NULL,
number_cabin int NULL,
avail_seats int NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Schedules table
CREATE TABLE Schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rid INT,
    trid VARCHAR(5), -- Đổi thành VARCHAR(5) để khớp với Trains.id
    from_time DATETIME,
    to_time DATETIME,
    FOREIGN KEY (trid) REFERENCES Trains(id), -- Giờ sẽ khớp với Trains.id (VARCHAR)
    FOREIGN KEY (rid) REFERENCES Routes(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- --drop table schedules

-- Create the Cabins table 
CREATE TABLE Cabins(
id varchar(10) PRIMARY KEY,
number_seat int NUll,
status int NULL,
avail_seat int NUll,
trid varchar(5),
ctype varchar(100),
sid int NULL,
FOREIGN KEY (sid) REFERENCES Schedules(id),
FOREIGN KEY (trid) REFERENCES Trains(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Seats table
CREATE TABLE Seats(
  id int  AUTO_INCREMENT PRIMARY KEY,
  seatNo int NULL,
  status int NULL,
  price int NULL,
  cbid varchar(10) ,
  FOREIGN KEY (cbid) REFERENCES Cabins(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Tickets table
CREATE TABLE Tickets(
 id int  AUTO_INCREMENT PRIMARY KEY,
 from_station varchar(200) NULL,
 to_station varchar(200) NULL,
 from_date datetime NULL,
 to_date datetime NULL,
 ttype int NULL,
 -- 1 là 1 chiều, 2 là khứ hồi
 trid varchar(5),
 sid int,
 rid int,
 cbid varchar(10),
 FOREIGN KEY (cbid) REFERENCES Cabins(id),
 FOREIGN KEY (trid) REFERENCES Trains(id),
 FOREIGN KEY (sid) REFERENCES Seats(id),
 FOREIGN KEY (rid) REFERENCES Routes(id)
 )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Create the Order_details table with foreign keys to Products and Orders table
CREATE TABLE Order_details (
  id int  AUTO_INCREMENT PRIMARY KEY,
  tid int ,
  cid int ,
  status int  NULL,
  total_price int  NULL,
  payment_type int  NULL,
  payment_date  DATE,
  FOREIGN KEY (cid) REFERENCES Accounts(uid),
  FOREIGN KEY (tid) REFERENCES Tickets(id)
);


-- Create Refund table 
CREATE TABLE Refund (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderid INT NOT NULL,
    accountid1 INT NOT NULL,
    accountid2 INT NOT NULL,
    refunddate DATETIME DEFAULT NULL,
    totalAmount int NOT NULL,
    requestdate DATETIME NOT NULL,
    status varchar(10) not null,
    FOREIGN KEY (orderid) REFERENCES Order_details(id),
    FOREIGN KEY (accountid1) REFERENCES Accounts(uid),
    FOREIGN KEY (accountid2) REFERENCES Accounts(uid)
);

CREATE TABLE Feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    rate INT CHECK (rate BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(uID)
);


USE prj_train;
-- Insert into the Accounts table
INSERT INTO Accounts ( uname, umail, pass, uphone , isStaff, isAdmin, cccd,avatar, status) VALUES ( 'Admin','admin1@gmail.com', '123456', '0912525769', 0,1,0,'avt/avt1.jpg',TRUE),
('Trình', 'trinh@gmail.com', '123456', '0384572193', 1, 0,0,'avt/avt2.jpg',true),
('Long', 'long@gmail.com', '123456', '12345678',0, 1,0,'avt/avt1.jpg',true),
('Khánh', 'khanh@gmail.com', '123456', '12345678', 1, 1,0,'avt/avt1.jpg',true),
('My', 'my@gmail.com', '123456', '12345678',0, 0,0,'avt/avt1.jpg',true),
('Huyền', 'huyenltthe181265@fpt.edu.vn', '123456', '12345678', 1, 0,0,'avt/avt1.jpg',true),
('Customer1', 'customer1@gmail.com', '123456', '12345678', 0, 0,0,'avt/avt2.jpg',true),
('Customer2', 'customer2@gmail.com', '123456', '12345678', 0, 0,0,'avt/avt2.jpg',true),
('Customer3', 'customer3@gmail.com', '123456', '12345678', 0, 0,0,'avt/avt2.jpg',false),
('Customer4', 'customer4@gmail.com', '123456', '12345678', 0, 0,0,'avt/avt2.jpg',false),
('Customer5', 'customer5@gmail.com', '123456', '12345678', 0, 0,0,'avt/avt1.jpg',false)
;

-- Insert into the Routes table

INSERT INTO Routes ( from_station, to_station) VALUES ('Hà Nội','Sài Gòn'),
('Hà Nội','Đà Nẵng'),
('Hà Nội','Vinh'),
('Hà Nội','Hải Phòng'),
('Hà Nội','Lào Cai'),
('Sài Gòn','Hà Nội'),
('Sài Gòn','Đà Nẵng'),
('Sài Gòn','Nha Trang'),
('Sài Gòn','Phan Thiết'),
('Sài Gòn','Quy Nhơn'),
('Gia Lâm','Nam Ninh'),
('Gia Lâm','Đồng Đăng'),
('Gia Lâm','Bắc Kinh Tây'),
('Yên Viên','Hạ Long'),
('Đà Lạt','Trại Mát'),
('Vũng Áng','Mụ Giạ'),
('Biên Hòa','Vũng Tàu'),
('Đà Nẵng','Quy Nhơn')
;

-- Create data for Routes
INSERT INTO Routes_data (id, route_key, value) VALUES 
(1, 'Hà Nội', 0), (1, 'Phủ Lý', 60), (1, 'Nam Định',105),(1, 'Ninh Bình',145),(1, 'Thanh Hóa',210),(1, 'Vinh',345),(1, 'Hương Phố',425),(1, 'Đồng Hới',585),(1, 'Đông Hà',690),(1, 'Huế',765),(1, 'Đà Nẵng',915),(1, 'Tam Kỳ',1015),(1, 'Quảng Ngãi',1085),(1, 'Diêu Trì',1255),(1, 'Tuy Hòa',1365),(1, 'Nha Trang',1490),(1, 'Bình Thuận',1725),(1, 'Biên Hòa',1885),(1, 'Dĩ An',1905),(1, 'Sài Gòn',1950),
(2, 'Hà Nội',0),(2, 'Nam Định',100),(2, 'Ninh Bình',140),(2, 'Thanh Hóa',210),(2, 'Vinh',365),(2, 'Đồng Hới',605),(2, 'Đông Hà',730),(2, 'Huế',805),(2, 'Đà Nẵng',980),
(4,'Hà Nội',0),(4,'Gia Lâm',15),(4,'Cẩm Giàng',60),(4,'Hải Dương',85),(4,'Phú Thái',115),(4,'Thượng Lý',145),(4,'Hải Phòng',160),
(5,'Hà Nội',0),(5,'Gia Lâm',15),(5,'Yên Viên',30),(5,'Đông Anh',55),(5,'Vĩnh Yên',95),(5,'Yên Bái',240),(5,'Trái Hút',310),(5,'Lang Khay',340),(5,'Bảo Hà',375),(5,'Phố Lu',420),(5,'Lào Cai',485),
(6,'Sài Gòn',0),(6,'Biên Hòa',35),(6,'Bình Thuận',190),(6,'Tháp Chàm',320),(6,'Nha Trang',410),(6,'Tuy Hòa',530),(6,'Diêu Trì',630),(6,'Quảng Ngãi',790),(6,'Tam Kỳ',855),(6,'Đà Nẵng',930),(6,'Huế',1080),(6,'Đông Hà',1155),(6,'Đồng Hới',1260),(6,'Đồng Lê',1360),(6,'Hương Phố',1425),(6,'Vinh',1505),(6,'Thanh Hóa',1660),(6,'Ninh Bình',1725),(6,'Nam Định',1760),(6,'Phủ Lý',1795),(6,'Hà Nội',1865)

;
INSERT INTO Routes_data (id, route_key, value) VALUES 
(3, 'Hà Nội', 0), (3, 'Nam Định', 90), (3, 'Ninh Bình', 130), (3, 'Thanh Hóa', 195), (3, 'Vinh', 320), 
(7, 'Sài Gòn', 0), (7, 'Biên Hòa', 35), (7, 'Bình Thuận', 180), (7, 'Nha Trang', 400), (7, 'Quy Nhơn', 650), (7, 'Đà Nẵng', 920),
(8, 'Sài Gòn', 0), (8, 'Biên Hòa', 35), (8, 'Bình Thuận', 190), (8, 'Nha Trang', 400),
(9, 'Sài Gòn', 0), (9, 'Biên Hòa', 35), (9, 'Bình Thuận', 190), (9, 'Phan Thiết', 250),
(10, 'Sài Gòn', 0), (10, 'Biên Hòa', 35), (10, 'Bình Thuận', 190), (10, 'Quy Nhơn', 750),
(11, 'Gia Lâm', 0), (11, 'Đồng Đăng', 130), (11, 'Nam Ninh', 380),
(12, 'Gia Lâm', 0), (12, 'Đồng Đăng', 130),
(13, 'Gia Lâm', 0), (13, 'Đồng Đăng', 130), (13, 'Nam Ninh', 380), (13, 'Bắc Kinh Tây', 2500),
(14, 'Yên Viên', 0), (14, 'Bắc Ninh', 40), (14, 'Cẩm Phả', 150), (14, 'Hạ Long', 170),
(15, 'Đà Lạt', 0), (15, 'Trại Mát', 7),
(16, 'Vũng Áng', 0), (16, 'Khe Nét', 45), (16, 'Mụ Giạ', 90),
(17, 'Biên Hòa', 0), (17, 'Bình Dương', 25), (17, 'Bà Rịa', 60), (17, 'Vũng Tàu', 80),
(18, 'Đà Nẵng', 0), (18, 'Tam Kỳ', 75), (18, 'Quảng Ngãi', 150), (18, 'Quy Nhơn', 400);
-- drop table Routes_data;
-- drop table Trains

-- Insert into the Trains table
INSERT INTO Trains (id, status, number_seat, number_cabin, train_type,avail_seats) VALUES 
('SE1',  1, 374, 10, 'Tàu nhanh',374), 
('SE2',  1, 360, 10, 'Tàu nhanh',360), 
('SE3',  1, 464, 11, 'Tàu thường',464),
('SE4',  1, 464, 11, 'Tàu thường',464), 
('SE5',  1, 360, 10, 'Tàu nhanh',360), 
('SE6',  1, 360, 10, 'Tàu nhanh',360), 
('SE7',  1, 408, 11, 'Tàu thường',408), 
('SE8',  1, 464, 11, 'Tàu thường',464), 
('SE9',  1, 472, 11, 'Tàu thường',472),
('SE10', 1, 472, 11, 'Tàu thường',472),
('SE12', 1, 464, 11, 'Tàu thường',464),
('SE19', 1, 280, 10, 'Tàu cao cấp',280),
('SE23', 0, 210, 10, 'Tàu nhanh',0), -- tàu hỏng, mất khoang
('SE24', 1, 376, 10, 'Tàu nhanh',376),
('HP1',  1, 760, 12, 'Tàu thường',760),
('SP3',  1, 282, 11, 'Tàu cao cấp',282),
('SP7',  1, 268, 11, 'Tàu cao cấp',268);


-- Insert into the Schedules table
INSERT INTO Schedules (rid, trid, from_time, to_time) VALUES 
-- Tuyến Hà Nội - Sài Gòn
(1, 'SE1', '2025-03-09 06:00:00', '2025-03-10 16:00:00'), -- Tàu nhanh (~34h)
(1, 'SE3', '2025-03-09 14:00:00', '2025-03-10 22:00:00'), -- Tàu thường (~32h)
(1, 'SE5', '2025-03-09 06:00:00', '2025-03-10 20:00:00'), -- Tàu nhanh (~38h)

-- Tuyến Hà Nội - Đà Nẵng
(2, 'SE7', '2025-03-01 07:30:00', '2025-03-01 21:00:00'), -- Tàu thường (~13h30)
(2, 'SE9', '2025-03-02 20:00:00', '2025-03-03 11:30:00'), -- Tàu thường (~15h30)

-- Tuyến Hà Nội - Vinh
(3, 'SE19', '2025-03-01 09:00:00', '2025-03-01 13:30:00'), -- Tàu cao cấp (~4h30)
(3, 'SE23', '2025-03-02 16:30:00', '2025-03-02 23:00:00'), -- Tàu nhanh (~6h30)

-- Tuyến Hà Nội - Hải Phòng
(4, 'HP1', '2025-03-01 08:00:00', '2025-03-01 10:00:00'), -- Tàu thường (~2h)
(4, 'SE24', '2025-03-01 12:00:00', '2025-03-01 15:00:00'), -- Tàu nhanh (~3h)

-- Tuyến Hà Nội - Lào Cai
(5, 'SP3', '2025-03-01 21:00:00', '2025-03-02 03:30:00'), -- Tàu cao cấp (~6h30)
(5, 'SP7', '2025-03-02 22:00:00', '2025-03-03 06:00:00'), -- Tàu cao cấp (~8h)

-- Tuyến Sài Gòn - Nha Trang
(8, 'SE4', '2025-03-01 12:00:00', '2025-03-01 20:00:00'), -- Tàu thường (~8h)
(8, 'SE6', '2025-03-02 10:00:00', '2025-03-02 21:00:00'), -- Tàu nhanh (~11h)

-- Tuyến Sài Gòn - Phan Thiết
(9, 'SE2', '2025-03-01 07:00:00', '2025-03-01 09:30:00'), -- Tàu nhanh (~2h30)
(9, 'SE8', '2025-03-02 10:00:00', '2025-03-02 13:00:00'), -- Tàu thường (~3h)

-- Tuyến Gia Lâm - Nam Ninh
(11, 'SE12', '2025-03-01 20:00:00', '2025-03-02 06:00:00'), -- Tàu thường (~10h)

-- Tuyến Gia Lâm - Bắc Kinh Tây
(13, 'SE10', '2025-03-01 18:00:00', '2025-03-03 12:00:00'), -- Tàu thường (~42h)

-- Tuyến Đà Lạt - Trại Mát
(15, 'SE19', '2025-03-01 09:00:00', '2025-03-01 09:30:00'), -- Tàu cao cấp (~30 phút)

-- Tuyến Biên Hòa - Vũng Tàu
(17, 'SE7', '2025-03-01 08:00:00', '2025-03-01 10:00:00'), -- Tàu thường (~2h)

-- Tuyến Đà Nẵng - Quy Nhơn
(18, 'SE5', '2025-03-01 13:00:00', '2025-03-01 17:30:00'); -- Tàu nhanh (~4h30)






-- SELECT
--    s.id AS schedule_id,
 --   rd.route_key AS station,
--    ADDTIME(s.departure_time, CONCAT(rd.value, ' MINUTE')) AS arrival_time
-- FROM
--    Schedules s
-- INNER JOIN Routes_data rd ON s.rid = rd.id
-- WHERE
--    s.id = 1;  -- Thay 1 bằng ID của lịch trình bạn muốn xem

-- Insert into the Cabins table
INSERT INTO Cabins(id, number_seat, status,avail_seat, trid, ctype,sid) value
('SE1/1',56,1,56,'SE1','A56LV',1),('SE1/2',56,1,56,'SE1','A56LV',1),('SE1/3',42,1,42,'SE1','Bn42L',1),('SE1/4',42,1,42,'SE1','Bn42L',1),('SE1/5',28,1,28,'SE1','An28LV',1),('SE1/6',28,1,28,'SE1','An28LV',1),('SE1/7',28,1,28,'SE1','An28LV',1),('SE1/8',28,1,28,'SE1','An28LV',1),('SE1/9',28,1,28,'SE1','An28LV',1),('SE1/10',28,1,28,'SE1','An28LV',1),
('SE3/1',64,1,64,'SE3','A64LV',2),('SE3/2',64,1,64,'SE3','A64LV',2),('SE3/3',56,1,56,'SE3','A56LV',2),('SE3/4',42,1,42,'SE3','Bn42L',2),('SE3/5',42,1,42,'SE3','Bn42L',2),('SE3/6',42,1,42,'SE3','Bn42L',2),('SE3/7',42,1,42,'SE3','Bn42L',2),('SE3/8',28,1,28,'SE3','An28LV',2),('SE3/9',28,1,28,'SE3','An28LV',2),('SE3/10',28,1,28,'SE3','An28LV',2),('SE3/11',28,1,28,'SE3','An28LV',2),
('SE5/1',56,1,56,'SE5','A56LV',3),('SE5/2',56,1,56,'SE5','A56LV',3),('SE5/3',42,1,42,'SE5','Bn42L',3),('SE5/4',42,1,42,'SE5','Bn42L',3),('SE5/5',28,1,28,'SE5','An28LV',3),('SE5/6',28,1,28,'SE5','An28LV',3),('SE5/7',28,1,28,'SE5','An28LV',3),('SE5/8',28,1,28,'SE5','An28LV',3),('SE5/9',28,1,28,'SE5','An28LV',3),('SE5/10',42,1,42,'SE5','Bn42L',3)
;

-- Insert into the Seats table
INSERT INTO Seats (seatNo,status, price, cbid) VALUE (1,0,1022000,'SE1/1'),(2,0,1022000,'SE1/1'),(3,0,1022000,'SE1/1'),(4,0,1022000,'SE1/1'),(5,0,1022000,'SE1/1'),(6,0,1022000,'SE1/1'),(7,0,1022000,'SE1/1'),(8,0,1022000,'SE1/1'),(9,0,1022000,'SE1/1'),(10,0,1022000,'SE1/1'),(11,0,1022000,'SE1/1'),(12,0,1022000,'SE1/1'),(13,0,1022000,'SE1/1'),(14,0,1022000,'SE1/1'),(15,0,1022000,'SE1/1'),(16,0,1022000,'SE1/1'),(17,0,1022000,'SE1/1'),(18,0,1022000,'SE1/1'),(19,0,1022000,'SE1/1'),(20,0,1022000,'SE1/1'),(21,0,1022000,'SE1/1'),(22,0,1022000,'SE1/1'),(23,0,1022000,'SE1/1')
;

-- Insert into the Tickets table
INSERT INTO Tickets (from_station, to_station, from_date, to_date, ttype, trid,sid,rid,cbid) VALUE ('Hà Nội','Sài Gòn','2025-02-22 10:30:00','2025-02-22 10:30:00',1,'SE1',1,1,'SE1/1'),
 ('Hà Nội','Sài Gòn','2025-02-22 10:30:00','2025-02-22 10:30:00',1,'SE1',1,1,'SE1/1');

-- Insert into the Order_details table
INSERT INTO Order_details (tid,cid,status,total_price,payment_type,payment_date) VALUE (1,5,1,1022000,1,'2025-02-21'),
(2,5,1,1022000,1,'2025-02-21');

-- Insert into the Refund table
INSERT INTO Refund(orderid, accountid1, accountid2, refunddate, totalAmount, requestdate,status) value( 1,5,2,'2025-02-21',1022000,'2025-02-21',0);

INSERT INTO Feedback (account_id, rate, comment) 
VALUES (1, 5, 'Dịch vụ rất tốt!');
-- SELECT * FROM Cabins where trid = 'SE1' and sid=1;
-- select * from Schedules where id=1;
-- SELECT ABS((SELECT value FROM Routes_data WHERE route_key = 'Huế' AND id = 1) -
-- (SELECT value FROM Routes_data WHERE route_key = 'Vinh' AND id = 1)) AS distance
-- SELECT * FROM Cabins WHERE trid ='SE1'
-- SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time 
-- FROM schedules s INNER JOIN routes r ON s.rid = r.id 
-- INNER JOIN trains t ON s.trid = t.id 
-- WHERE r.from_station = 'Hà Nội' AND r.to_station = 'Sài Gòn'
-- AND DATE(s.from_time) = '2025-03-09'
-- SELECT * FROM Seats where cbid = 'SE1/1' and seatNo=1
select * from  routes;
INSERT INTO Schedules (rid, trid, from_time, to_time) VALUES 
-- Tuyến Hà Nội - Sài Gòn
(1, 'SE1', '2025-03-10 06:00:00', '2025-03-11 16:00:00'), -- Tàu nhanh (~34h)
(1, 'SE3', '2025-03-10 14:00:00', '2025-03-11 22:00:00'), -- Tàu thường (~32h)
(1, 'SE5', '2025-03-10 06:00:00', '2025-03-11 20:00:00'); -- Tàu nhanh (~38h)
INSERT INTO Schedules (rid, trid, from_time, to_time) VALUES 
-- Tuyến Sài Gòn-Hà Nội 
(6, 'SE2', '2025-03-11 06:00:00', '2025-03-12 16:00:00'), -- Tàu nhanh (~34h)
(6, 'SE4', '2025-03-11 14:00:00', '2025-03-12 22:00:00'), -- Tàu thường (~32h)
(6, 'SE6', '2025-03-11 06:00:00', '2025-03-12 20:00:00'); -- Tàu nhanh (~38h)

INSERT INTO Schedules (rid, trid, from_time, to_time) VALUES 
-- Tuyến Hà Nội - Sài Gòn
(1, 'SE1', '2025-03-11 06:00:00', '2025-03-12 16:00:00'), -- Tàu nhanh (~34h)
(1, 'SE3', '2025-03-11 14:00:00', '2025-03-12 22:00:00'), -- Tàu thường (~32h)
(1, 'SE5', '2025-03-11 06:00:00', '2025-03-12 20:00:00'); -- Tàu nhanh (~38h)
INSERT INTO Schedules (rid, trid, from_time, to_time) VALUES 
-- Tuyến Sài Gòn-Hà Nội 
(6, 'SE2', '2025-03-12 06:00:00', '2025-03-13 16:00:00'), -- Tàu nhanh (~34h)
(6, 'SE4', '2025-03-12 14:00:00', '2025-03-13 22:00:00'), -- Tàu thường (~32h)
(6, 'SE6', '2025-03-12 06:00:00', '2025-03-13 20:00:00'); -- Tàu nhanh (~38h)
SELECT * FROM Cabins;
INSERT INTO Schedules (rid, trid, from_time, to_time) VALUES 
-- Tuyến Hà Nội - Sài Gòn
(1, 'SE1', '2025-03-22 06:00:00', '2025-03-23 16:00:00'), -- Tàu nhanh (~34h)
(1, 'SE3', '2025-03-22 14:00:00', '2025-03-23 22:00:00'), -- Tàu thường (~32h)
(1, 'SE5', '2025-03-22 06:00:00', '2025-03-23 20:00:00'); -- Tàu nhanh (~38h)

DELETE FROM refund WHERE id BETWEEN 2 AND 9;


SELECT r.id, r.orderid, a.uname, r.requestdate, r.totalAmount, r.status FROM Refund r JOIN Order_Details od ON r.orderid = od.id JOIN Accounts a ON r.accountid1 = a.uid;

INSERT INTO Refund (orderid, accountid1, accountid2, totalAmount, requestdate,status) VALUES (2, 5, 2, 1022000,'2025-02-21','PENDING');
select * from order_details;
select * from refund;
update refund set status='REJECTED' where orderid=2
SELECT r.id, r.orderid, a.uname, r.requestdate, r.totalAmount, r.status FROM Refund r JOIN Order_Details od ON r.orderid = od.id JOIN Accounts a ON r.accountid1 = a.uid where r.status='APPROVED'