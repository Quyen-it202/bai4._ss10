create database bai4_ss10;
use bai4_ss10;

create table Pharmacy_Inventory (
	Inventory_ID int auto_increment primary key,
    Drug_Name varchar(255),
    Batch_Number varchar(50),
    Expiry_Date date,
    Quantity int
);

create index index_drug_name on Pharmacy_Inventory(Drug_Name);
create index index_expiry_date on Pharmacy_Inventory(Expiry_Date);

create index index_drug_name_expiry on Pharmacy_Inventory(Drug_Name, Expiry_Date);


explain select * 
from Pharmacy_Inventory
where Drug_Name LIKE '%Paracetamol%'
and Expiry_Date = '2026-12-31';

-- khi sử dụng LIKE '%keyword%' thì sẽ phải quét toàn bộ bảng thay vì sử dụng index. Vì B-Tree index sẽ tìm kiếm từ trái sang phải, khi có dấu % trước keywword thì nó sẽ không biết bắt đầu từ điểm nào --> phải quét toàn bảng

-- Giải pháp: 
-- cách 1: tìm kiếm Full-text Search
ALTER TABLE Pharmacy_Inventory 
ADD FULLTEXT(Drug_Name);
-- dùng để kích hoạt Full-text Search, FULLTEXT INDEX -> dùng cho tìm kiếm văn bản

SELECT *
FROM Pharmacy_Inventory
WHERE MATCH(Drug_Name) AGAINST('Paracetamol');
-- Match() là chỉ cột cần tìm, against('keyword') là từ khóa cần tìm

-- cách 2: tối ưu lại LIKE

select * 
from Pharmacy_Inventory
where Drug_Name LIKE 'Paracetamol%'
and Expiry_Date = '2026-12-31';