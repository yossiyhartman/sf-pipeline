CREATE OR REPLACE TASK LANDING.LOAD_ALL_TASK
WAREHOUSE = &{warehouse}
SCHEDULE = 'USING CRON 0 6 * * * UTC'
COMMENT = 'Loads every Northwind source from the landing stage. Created suspended; enable explicitly once ready to run on schedule.'
AS
CALL LANDING.LOAD_ALL();
