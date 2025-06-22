CREATE database hospital;
USE hospital;
CREATE TABLE hospital_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique row ID
    provider_id VARCHAR(10),
    hospital_name VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(10),
    measure_name VARCHAR(255),
    compared_to_national VARCHAR(50),
    denominator INT,
    score FLOAT,
    measure_start_date DATE,
    measure_end_date DATE,
    location VARCHAR(100)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/final_cleaned_healthcare_data.csv'
INTO TABLE hospital_performance
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(provider_id, hospital_name, city, state, measure_name, compared_to_national, denominator, score, measure_start_date, measure_end_date, location);

SELECT 
    state, 
    ROUND(AVG(score), 2) AS avg_score
FROM hospital_performance
GROUP BY state
ORDER BY avg_score DESC;

   SELECT
   hospital_name, 
    city, 
    state, 
    ROUND(AVG(score), 2) AS avg_score
FROM hospital_performance
WHERE score > 0
GROUP BY hospital_name, city, state
ORDER BY avg_score ASC
LIMIT 10;

SELECT 
    measure_name, 
    COUNT(*) AS total_records, 
    ROUND(AVG(score), 2) AS avg_score
FROM hospital_performance
WHERE score > 0
GROUP BY measure_name
ORDER BY avg_score ASC;

SELECT 
    YEAR(measure_start_date) AS year, 
    ROUND(AVG(score), 2) AS avg_score
FROM hospital_performance
GROUP BY YEAR(measure_start_date)
ORDER BY year;

SELECT 
    compared_to_national, 
    COUNT(*) AS hospital_count
FROM hospital_performance
GROUP BY compared_to_national;


