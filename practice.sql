use practice;
CREATE TABLE Electricity(
    cid   int,
    cname  varchar(40),
    consumption  int,
    price  Real
    );
INSERT INTO Electricity VALUES 
(1001, 'C1', 340, 16.0),
(1002, 'C2', 250, 18.0),
(1003, 'C3', 190, 20.0),
(1004, 'C4', 380, 24.0),
(1005, 'C5', 310, 26.0);
SELECT * from Electricity where consumption<380 AND consumption>=190;
alter table Electricity add bill Float;
update Electricity set bill=consumption*(price/100);
select * from Electricity where bill>40
Order By consumption DESC;
ALTER TABLE Electricity ADD INDEX idx_cid (cid);
CREATE TABLE Application(
aid INT NOT NULL,
cid INT NOT NULL,
income DECIMAL(10,2),
PRIMARY KEY(aid),
FOREIGN KEY(cid) REFERENCES Electricity(cid));
INSERT INTO Application VALUES
(1, 1001, 1000),
(2, 1004, 3000),
(3, 1005, 1500);
select e.cid,e.bill,a.income*0.05 
from Electricity AS e INNER JOIN Application AS a
ON e.cid=a.cid;
SELECT E.cid, E.bill, 0.05*A.income
FROM Electricity as E, Application as A
WHERE E.cid = A.cid;
alter table Application add  approvalORnot INT;
UPDATE Application as A
SET approvalORnot = (
  SELECT IIF(e.bill > 0.005*a.income , 1, 0)
  FROM Electricity as e
  WHERE e.cid=a.cid);
select * from Electricity;
select * from Application;