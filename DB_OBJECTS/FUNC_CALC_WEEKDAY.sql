create or replace FUNCTION                 "FUNC_CALC_WEEKDAY" 
 (PFROM_DATE DATE ,PTO_DATE DATE, LOC_ID VARCHAR2) RETURN NUMBER IS
  WEEKDAY NUMBER (10):=0;
  V_FRDATE DATE :=TO_DATE(PFROM_DATE, 'DD/MON/YY');
  V_TODATE DATE :=TO_DATE(PTO_DATE, 'DD/MON/YY');

  BEGIN

 SELECT
  (SELECT COUNT(*)  FROM (SELECT ROWNUM r   From ALL_OBJECTS
        WHERE ROWNUM <= TRUNC(V_TODATE -  V_FRDATE+1))
        WHERE TRIM(TO_CHAR( V_FRDATE + (r-1) , 'Day')) NOT IN ('Sunday','Saturday'))
        -
        (select count(*)   from GM_HOLIDAYS  where LOCATION_ID = LOC_ID
        AND holiday_date >= V_FRDATE
        and holiday_date <= V_TODATE
        and TRIM(TO_CHAR(holiday_date,'Day')) NOT IN ('Sunday','Saturday') ) INTO WEEKDAY FROM  DUAL;



    --WEEKPUB:=WEEKPUB * 8;
    --dbms_output.put_line(WEEKDAY);

      RETURN     WEEKDAY;

    END FUNC_CALC_WEEKDAY; 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 