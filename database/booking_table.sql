-- Create Booking table
CREATE TABLE Booking (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    schedule_id VARCHAR(50) NOT NULL,
    cabin_id VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    contact_name NVARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    booking_time DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Accounts(uID),
    FOREIGN KEY (schedule_id) REFERENCES Schedules(id),
    FOREIGN KEY (cabin_id) REFERENCES Cabins(id)
);

-- Create index for faster lookups
CREATE INDEX IX_Booking_UserId ON Booking(user_id);
CREATE INDEX IX_Booking_ScheduleId ON Booking(schedule_id);
CREATE INDEX IX_Booking_CabinId ON Booking(cabin_id);
CREATE INDEX IX_Booking_Status ON Booking(status);
