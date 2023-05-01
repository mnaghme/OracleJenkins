CREATE TABLE rank_demo (
	col VARCHAR(10) NOT NULL
);

INSERT ALL 
INTO rank_demo(col) VALUES('A')
INTO rank_demo(col) VALUES('A')
INTO rank_demo(col) VALUES('B')
INTO rank_demo(col) VALUES('C')
INTO rank_demo(col) VALUES('C')
INTO rank_demo(col) VALUES('C')
INTO rank_demo(col) VALUES('D')
SELECT 1 FROM dual; 


SELECT 
	col, 
	RANK() OVER (ORDER BY col) my_rank
FROM 
	rank_demo;
    
    
    