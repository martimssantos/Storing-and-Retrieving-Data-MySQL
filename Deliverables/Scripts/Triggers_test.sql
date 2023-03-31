-- Triggers Test --
use novaup;

-- #1 LOG
-- Change customers phone number:
UPDATE customer
SET phone_number = 912345678
WHERE id_customer = 1;

UPDATE customer
SET phone_number = 912345670
WHERE id_customer = 6;

-- Show log table and check changes
SELECT *
FROM phone_changes;


-- #2 UPDATES
-- Show original 
SELECT * 
FROM classes;

-- Change openings
INSERT INTO classes_attendences (id_classes, id_customer) VALUES('B01', 1);

-- Show table again and check changes
SELECT *
FROM classes