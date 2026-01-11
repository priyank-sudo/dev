

SET DEFINE OFF;

--        OPEN Cur_Temp FOR
         SELECT

              --   LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
       ----          LISTAGG(CTC_CATE,',') WITHIN GROUP (ORDER BY ROWNUM),
           ---      LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
             ---    LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM),
--               LISTAGG('NULL ' ||'"'||ROW_NUM||'"',',') WITHIN GROUP (ORDER BY ROWNUM)
--  XMLAGG(XMLELEMENT (A,CTC_COLUMNS,',').EXTRACT('//text()') ORDER BY ROWNUM) ,
--  XMLAGG(XMLELEMENT (B,CTC_CATE,',').EXTRACT('//text()') ORDER BY ROWNUM) ,
--  XMLAGG(XMLELEMENT (C,NULL_VAL,',').EXTRACT('//text()') ORDER BY ROWNUM) ,
--  XMLAGG(XMLELEMENT (D,HEADER_COL,',').EXTRACT('//text()') ORDER BY ROWNUM  )     ,           
  REPLACE(  REPLACE(REPLACE(RTRIM( XMLAGG(XMLELEMENT (A,CTC_COLUMNS,',').EXTRACT('//text()') ORDER BY ROWNUM  ).getclobval()
   , ','), '&apos;' , ''''),'&quot;' , '"'), ' &amp; ', ' & '),          
 REPLACE(REPLACE(REPLACE(RTRIM( XMLAGG(XMLELEMENT (B,CTC_CATE,',').EXTRACT('//text()') ORDER BY ROWNUM  ).getclobval()
   , ','), '&apos;' , ''''),'&quot;' , '"'), ' &amp; ', ' & '),
    REPLACE(REPLACE(REPLACE(RTRIM( XMLAGG(XMLELEMENT (C,NULL_VAL,',').EXTRACT('//text()') ORDER BY ROWNUM  ).getclobval()
   , ','), '&apos;' , ''''),'&quot;' , '"'), ' &amp; ', ' & '),
    REPLACE(REPLACE(REPLACE(RTRIM( XMLAGG(XMLELEMENT (D,HEADER_COL,',').EXTRACT('//text()') ORDER BY ROWNUM  ).getclobval()
   , ','), '&apos;' , ''''),'&quot;' , '"'), ' &amp; ', ' & '),
   replace(REPLACE(REPLACE(RTRIM( XMLAGG(XMLELEMENT (E,'NULL ' ||'"'||ROW_NUM||'"',',').EXTRACT('//text()') ORDER BY ROWNUM  ).getclobval()
   , ','), '&apos;' , ''''),'&quot;' , '"'), ' &amp; ', ' & ')           
        FROM
        (
          SELECT CTC_COLUMNS,
                 DECODE(ROW_NUMBER() OVER (PARTITION BY CTC_CATE ORDER BY CTC_CATE) ,1,CTC_CATE,'NULL') CTC_CATE,
                 NULL_VAL,HEADER_COL,ROWNUM ROW_NUM
          FROM
            (
              SELECT DISTINCT B.CTC_MID,
                'SUM(DECODE(TRIM(CTC_MID),'''||B.CTC_MID||''',AMOUNT,0)) "'||SUBSTR(B.CTC_NAME,1,30)||'"' CTC_COLUMNS,
                --DECODE(B.CTC_MID,'VAR',86,B.SORT_ORDER),--B.SORT_ORDER,
                ' '''||C.CTC_CATE_ID_MID||'''' CTC_CATE ,NULL|| ' "'||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')
                ||'"' NULL_VAL,''''
                ||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')||'''' HEADER_COL
              FROM PY_PM_EMPCTCDTL A,PY_CTC_ALLOWANCE_MAST B,PY_VW_PM_ALLWDED C
              WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_aID =B.CTC_CODE
                AND A.EFF_DATE_TO IS NULL
                AND B.COMP_ID = C.COMP_ID  AND B.CTC_CODE = C.CTC_CODE
    --            AND A.COMP_AID=pComp_Aid
              --ORDER BY DECODE(B.CTC_MID,'VAR',86,B.SORT_ORDER),CTC_CATE
              ORDER BY B.CTC_MID ,CTC_CATE
            )
            ORDER BY ROW_NUM
        );
        
        
 
 
--        FETCH Cur_Temp INTO strCTC_COLUMNS,strCTC_CATE,strNULL_VAL,strHEADER_COL,strNULL;
--        CLOSE Cur_Temp;