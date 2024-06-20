#VIEW
-- 1
CREATE VIEW view_room_type AS
SELECT * FROM room_type

SELECT * FROM view_room_type

-- 2
CREATE VIEW view_room_roomtype AS
SELECT * FROM room NATURAL JOIN room_type WHERE deleteStatus = 0

SELECT * FROM view_room_roomtype

-- 3
CREATE VIEW view_shift AS
SELECT * FROM shift

SELECT * FROM view_shift

-- 4
CREATE VIEW view_id_card_type AS
SELECT * FROM id_card_type

SELECT * FROM view_id_card_type

-- 5
CREATE VIEW view_complaint AS
SELECT * FROM complaint

SELECT * FROM view_complaint

-- 6
CREATE VIEW view_staff_type AS
SELECT * FROM staff_type

SELECT * FROM view_staff_type

-- 7
CREATE VIEW view_log_room AS
SELECT * FROM log_room

SELECT * FROM view_log_room


#JOIN
-- 1
SELECT * FROM staff  NATURAL JOIN staff_type NATURAL JOIN shift

-- 2
SELECT * FROM room NATURAL JOIN room_type WHERE room_id = '$get_room_id'

-- 3`log_room`
SELECT * FROM booking NATURAL JOIN customer NATURAL JOIN room WHERE booking.payment_status = 1


#LOOPING
DELIMITER $$
CREATE PROCEDURE totalpendapatan()
BEGIN
    -- deklarasi variabel yang akan digunakan
    DECLARE total_masuk INT DEFAULT 0;
    DECLARE current_id INT DEFAULT 0;
    DECLARE max_id INT;
    
    -- untuk mendapatkan banyak data di dalam tabel booking
    SELECT MAX(booking_id) INTO max_id FROM booking;
    
    WHILE current_id <= max_id DO
        SET current_id = current_id + 1;

        -- menambahkan total harga jika payment_status = 1
        IF (SELECT payment_status FROM booking WHERE booking_id = current_id) = 1 THEN
            SET total_masuk = total_masuk + (SELECT total_price FROM booking WHERE booking_id = current_id);
        END IF;
    END WHILE;
    
    -- Menampilkan total pendapatan
    SELECT total_masuk AS total_pendapatan;
END$$
DELIMITER ;

CALL totalpendapatan();
DROP PROCEDURE totalpendapatan;

#STORED PROCEDURE
#ROOM MANAGEMENT
-- 1
DELIMITER //
CREATE PROCEDURE insert_room(
    IN room_type_input INT(5),
    IN room_no_input VARCHAR(20)
)
BEGIN
    INSERT INTO room (room_type_id, room_no)
    VALUES (room_type_input, room_no_input);
END//
DELIMITER ;

CALL insert_room(1, 'E-101');
SELECT * FROM room;
DROP PROCEDURE insert_room;

-- 2
DELIMITER //
CREATE PROCEDURE update_room(
    IN room_id_input INT(5),
    IN room_type_input INT(5),
    IN room_no_input VARCHAR(20)
)
BEGIN
    UPDATE room
    SET room_type_id = room_type_input, room_no = room_no_input
    WHERE room_id = room_id_input;
END//
DELIMITER ;

CALL update_room(16, 2, 'E-102');
SELECT * FROM room;
DROP PROCEDURE update_room;

-- 3
DELIMITER //
CREATE PROCEDURE delete_room(
    IN room_id_input INT
)
BEGIN
    DELETE FROM room WHERE room_id = room_id_input;
END//
DELIMITER ;

CALL delete_room(17);
SELECT * FROM room;
DROP PROCEDURE delete_room;

#STAFF MANAGEMENT
-- 4
DELIMITER //
CREATE PROCEDURE insert_staff(
    IN name_input VARCHAR(100),
    IN staff_type_input INT,
    IN shift_input INT,
    IN id_card_input INT,
    IN id_card_no_input VARCHAR(20),
    IN address_input VARCHAR(100),
    IN contact_input VARCHAR(20),
    IN salary_input BIGINT(20)
)
BEGIN
    INSERT INTO staff (emp_name, staff_type_id, shift_id, id_card_type, id_card_no, address, contact_no, salary)
    VALUES (name_input, staff_type_input, shift_input, id_card_input, id_card_no_input, address_input, contact_input, salary_input);
END//
DELIMITER ;

CALL insert_staff("Raka An", 1, 1, 1, 12345678901234, "Jakarta", "084284824711", 1000000);
SELECT * FROM staff;
DROP PROCEDURE insert_staff;

-- 5
DELIMITER //
CREATE PROCEDURE update_staff(
    IN emp_id_input INT,
    IN name_input VARCHAR(100),
    IN staff_type_input INT,
    IN shift_input INT,
    IN id_card_input INT,
    IN id_card_no_input VARCHAR(20),
    IN address_input VARCHAR(100),
    IN contact_input VARCHAR(20),
    IN salary_input BIGINT(20)
)
BEGIN
    UPDATE staff
    SET emp_name = name_input, staff_type_id = staff_type_input, shift_id = shift_input, id_card_type = id_card_input, id_card_no = id_card_no_input, address = address_input, contact_no = contact_input, salary = salary_input
    WHERE emp_id = emp_id_input;
END//
DELIMITER ;

CALL update_staff(13, "Raksa Harsa", 2, 2, 2, 21234567890123, "Jakarta Barat", "084284824711", 1200000);
SELECT * FROM staff;
DROP PROCEDURE update_staff;

-- 6
DELIMITER //
CREATE PROCEDURE delete_staff(
    IN emp_id_input INT
)
BEGIN
    DELETE FROM staff WHERE emp_id = emp_id_input;
END//
DELIMITER ;

CALL delete_staff(13);
SELECT * FROM staff;
DROP PROCEDURE delete_staff;


#TRIGGER
-- insert
DELIMITER //
CREATE TRIGGER insert_room_new AFTER INSERT ON room FOR EACH ROW
BEGIN
	INSERT INTO log_room SET
	aktivitas = "INSERT",
	old_room_type = "-",
	old_room_no = "-",
	new_room_type = new.room_type_id,
	new_room_no = new.room_no;
END//
DELIMITER ;

DROP TRIGGER insert_room_new;

-- update
DELIMITER //
CREATE TRIGGER update_room_new AFTER UPDATE ON room FOR EACH ROW
BEGIN
	INSERT INTO log_room SET
	aktivitas = "UPDATE",
	old_room_type = old.room_type_id,
	old_room_no = old.room_no,
	new_room_type = new.room_type_id,
	new_room_no = new.room_no;
END//
DELIMITER ;

DROP TRIGGER update_room_new;

-- delete
DELIMITER //
CREATE TRIGGER delete_room_new AFTER DELETE ON room FOR EACH ROW
BEGIN
	INSERT INTO log_room SET
	aktivitas = "DELETE",
	old_room_type = old.room_type_id,
	old_room_no = old.room_no,
	new_room_type = "-",
	new_room_no = "-";
END//
DELIMITER ;

DROP TRIGGER delete_room_new;