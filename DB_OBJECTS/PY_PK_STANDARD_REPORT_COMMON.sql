create or replace PACKAGE                             "PY_PK_STANDARD_REPORT_COMMON" IS
 TYPE REC IS REF CURSOR;

 TYPE arrTyp_Batch_Id IS TABLE OF VARCHAR2(25) INDEX BY PLS_INTEGER;

 FUNCTION GET_CONDITION(pMasterType VARCHAR2,pMultisheetCondition VARCHAR2) RETURN VARCHAR2;

 PROCEDURE GET_REPORT_DTL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pReportID VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pComp_Name OUT VARCHAR2,pReport_Name OUT VARCHAR2);
 
 FUNCTION GET_GROUP_BY_COLS(pMasterType VARCHAR2,pShowAlias CHAR) RETURN VARCHAR2;

 FUNCTION GET_ORDER_BY_COLS(pMasterType VARCHAR2) RETURN VARCHAR2;

 FUNCTION GET_SELECT_COLS(pMasterType VARCHAR2,pShowAlias CHAR) RETURN VARCHAR2;

 PROCEDURE GET_MULTISHEET_CONDITION(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE
 ,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,
 pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, Return_Recordset OUT REC);

 PROCEDURE GET_EXCEL_FORMATTING(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2
 ,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,Return_Recordset OUT REC);

 --Fill the list of reports name in data grid
 PROCEDURE FILL_REPORTS_LIST_GRID(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pFrom_Date DATE,pTo_Date DATE,Return_Recordset OUT REC);

 --Fill the list of Period type in dropdown name in data grid
 PROCEDURE FILL_PERIOD_COMBO(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,Return_Recordset OUT REC);

 --Fill the batch list for the particular period according to From Date and To Date
 PROCEDURE FILL_BATCH_LIST_GRID(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE INSERT_REPORT_UPLOAD_LOG(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2, pReport_ID VARCHAR2,pStatus VARCHAR2);

 --Fill the list of reports name in data grid as per serch criteria
 PROCEDURE FILL_REPORT_LIST(P_SEARCH_COLUMN VARCHAR2,P_SEARCH_VALUE VARCHAR2,pFrom_Date DATE,pTo_Date DATE,Return_Recordset OUT REC);

 --Reurns Data Set, Data Tables null procedures
 PROCEDURE FILL_REPORT_DATASET(pREPORT_ID VARCHAR2,pRPT_DATASET_ID VARCHAR2,Return_Recordset OUT REC);

 --Fill Batch List
 PROCEDURE FILL_BATCH_LIST(pComp_Aid VARCHAR2,pFrom_Date DATE,pTo_Date DATE,P_SEARCH_COLUMN VARCHAR2,P_SEARCH_VALUE VARCHAR2,Return_Recordset OUT REC);

 --Insert the selected batch data in temporary table
 PROCEDURE INSERT_BATCH_DATA_TEMPORARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportID VARCHAR2,pBatch_Id arrTyp_Batch_Id);

 --Insert the selected batch data in temporary table
 PROCEDURE INSERT_BATCH_DATA_TEMPORARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pBatch_Id arrTyp_Batch_Id,pFilterID VARCHAR2);

 --Insert the Emp List as per Filter data in temporary table
 PROCEDURE INSERT_FILTER_DATA_TEMPORARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsMultipleSheet VARCHAR2,pFilterID VARCHAR2);

 --Return Company Name null Month
 --PROCEDURE RETURN_COMPANY_NAME_PAY_MONTH(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pBatch_Id arrTyp_Batch_Id,pFilterId VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE RETURN_COMPANY_NAME_PAY_MONTH(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
 pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,
 pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);


END PY_PK_STANDARD_REPORT_COMMON;



/


create or replace PACKAGE BODY  "PY_PK_STANDARD_REPORT_COMMON" IS
           
      FUNCTION GET_CONDITION(
          pMasterType          VARCHAR2,
          pMultisheetCondition VARCHAR2)
        RETURN VARCHAR2
      IS
      TYPE CUR
      IS
        REF
        CURSOR;
          TEMP_RS CUR;
          vCondition VARCHAR2(4000);
        BEGIN
          OPEN TEMP_RS FOR
          SELECT 'NVL(HD.'||MASTER_COL_NAME||',''OTHERS'') = DECODE(''ALL'','''||
          pMultisheetCondition||''',NVL(HD.'||MASTER_COL_NAME||',''OTHERS''),'''||
          pMultisheetCondition||''' )'
          FROM PY_GM_MASTER_COL_NAME
          WHERE MASTER_TYPE = pMasterType;
          FETCH TEMP_RS INTO vCondition;
        CLOSE TEMP_RS;
      
      
        RETURN vCondition;
      END;
      FUNCTION GET_ORDER_BY_COLS
        (
          pMasterType VARCHAR2
        )
        RETURN VARCHAR2
      IS
      TYPE CUR
      IS
        REF
        CURSOR;
          TEMP_RS CUR;
          vOrderByCols VARCHAR2
          (
            4000
          )
          ;
        BEGIN
          OPEN TEMP_RS FOR
          --            SELECT MASTER_COL_MID||DECODE(pShowAlias,'Y',' AS "'||
          -- MASTER_COL_MID_DISP||'"','')||','||MASTER_COL_DESC||DECODE(pShowAlias,'Y
          -- ',' AS "'||MASTER_COL_DESC_DISP||'"','')
          SELECT '"'||MASTER_COL_DESC_DISP||'"'
          FROM PY_GM_MASTER_COL_NAME
          WHERE MASTER_TYPE = pMasterType;
          FETCH
            TEMP_RS
          INTO
            vOrderByCols;
        CLOSE TEMP_RS;
        vOrderByCols:=NVL(vOrderByCols,'"CODE"');
        RETURN vOrderByCols;
      END;
      FUNCTION GET_GROUP_BY_COLS(
          pMasterType VARCHAR2,
          pShowAlias  CHAR)
        RETURN VARCHAR2
      IS
      TYPE CUR
      IS
        REF
        CURSOR;
          TEMP_RS CUR;
          vGroupByCols VARCHAR2(4000);
        BEGIN
          OPEN TEMP_RS FOR
          SELECT MASTER_COL_DESC||DECODE(pShowAlias,'Y',' AS "'||MASTER_COL_MID_DISP
          ||'"','')
          --            SELECT '"'||MASTER_COL_DESC_DISP||'"',MASTER_COL_MID||DECODE(
          -- pShowAlias,'Y',' AS "'||MASTER_COL_DESC_DISP||'"','')
          FROM PY_GM_MASTER_COL_NAME
          WHERE MASTER_TYPE = pMasterType;
          FETCH
            TEMP_RS
          INTO
            vGroupByCols;
        CLOSE TEMP_RS;
        --        vGroupByCols:=NVL(vGroupByCols,'EMP_MID,EMP_NAME');
        vGroupByCols:=NVL(vGroupByCols,'COMP_ID');
        RETURN vGroupByCols;
      END;
      FUNCTION GET_SELECT_COLS(
          pMasterType VARCHAR2,
          pShowAlias  CHAR)
        RETURN VARCHAR2
      IS
      TYPE CUR
      IS
        REF
        CURSOR;
          TEMP_RS CUR;
          vAlise       VARCHAR2(4000);
          vCol         VARCHAR2(4000);
          vSelectQuery VARCHAR2(4000);
          vCount       NUMBER(12,2);
          vFor         VARCHAR2(2000);
        BEGIN
          OPEN TEMP_RS FOR
          SELECT MASTER_COL_DESC_DISP ,
          MASTER_COL_DESC||DECODE(pShowAlias,'Y',' AS "'||MASTER_COL_DESC_DISP||'"',
          '')
          FROM PY_GM_MASTER_COL_NAME
          WHERE trim(MASTER_TYPE) = trim(pMasterType);
          FETCH
            TEMP_RS
          INTO
            vCol,
            vAlise;
        CLOSE TEMP_RS;
        vCol  :=NVL(vCol,'CODE');
        vAlise:=NVL(vAlise,'NULL AS "CODE"');
        DECLARE
        type array_t IS varray(14) OF VARCHAR2(2000);
        array array_t := array_t('CODE','EMPLOYEE NAME','JOINING DATE','QUIT DATE',
        'ARREAR DAYS', 'DEPARTMENT' , 'DESIGNATION', 'GRADE', 'LOCATION',
        'Cost Center','Band', 'SAVING ACCOUNT' ,'BANK NAME','PAN NUMBER');
      BEGIN
        FOR i IN 1..array.count
        LOOP
          IF vCol        =array(i) THEN
            vSelectQuery:= vSelectQuery||','||vAlise;
          ELSE
            IF i           =array.count THEN
              vSelectQuery:= vSelectQuery||','||'''TOTAL'' AS "'||array(i)||'"';
            ELSE
              vSelectQuery:= vSelectQuery||','||'NULL AS "'||array(i)||'"';
            END IF;
          END IF;
        END LOOP;
      END;
      vSelectQuery:=SUBSTR(vSelectQuery,2,LENGTH(vSelectQuery));
      RETURN vSelectQuery;
      END;
--      PROCEDURE GET_MULTISHEET_CONDITION(
--          pComp_Aid  VARCHAR2,
--          pAcc_Year  VARCHAR2,
--          pPay_Month VARCHAR2,
--          pFrom_Date DATE,
--          pTo_Date   DATE
--          ,
--          pUser_Aid        VARCHAR2,
--          pSessionId       VARCHAR2,
--          pReportType      VARCHAR2,
--          pReportID        VARCHAR2,
--          pIsMultipleSheet VARCHAR2,
--          pMasterType      VARCHAR2,
--          Return_Recordset OUT REC)
--      IS
--      TYPE CUR
--      IS
--        REF
--        CURSOR;
--          TEMP_RS CUR;
--          vUsedMasterAid VARCHAR2(4000);
--          vStrQuery LONG;
--        BEGIN
--          OPEN TEMP_RS FOR
--          -- SELECT 'SELECT DISTINCT NVL('||MASTER_COL_NAME||',''OTHERS'') FROM
--          -- PY_PT_SAL_HD WHERE COMP_AID = '''||pComp_Aid||''' AND TO_DATE(01||
--          -- PAY_MONTH) BETWEEN TO_DATE('''||pFrom_Date||''') AND TO_DATE('''||
--          -- pTo_Date||''')'
--          SELECT 'SELECT DISTINCT NVL('||MASTER_COL_NAME||
--          ',''OTHERS'') FROM PY_GM_EMPMAST WHERE COMP_AID = '''||pComp_Aid||''''
--          FROM PY_GM_MASTER_COL_NAME
--          WHERE MASTER_TYPE = pMasterType;
--          FETCH
--            TEMP_RS
--          INTO
--            vUsedMasterAid;
--        CLOSE TEMP_RS;
--        vStrQuery :=
--        'SELECT DISTINCT SUBSTR(TRANSLATE(MASTER_DESC,'':/?\*[]'''''','' ''),1,30) EXCEL_SHEET_NAME,NVL('''
--        ||pIsMultipleSheet||
--        ''',''N'') ISMULTISHEET ,MASTER_TYPE , MASTER_AID MASTER_CONDITION_VALUE
--      --FROM PY_GM_GENERAL_MASTER
--      FROM PY_VW_GM_GENERAL_MASTER
--      WHERE  TRIM(MASTER_TYPE) = TRIM('''
--        ||pMasterType||''') AND NVL('''||pIsMultipleSheet||
--        ''',''N'') = ''Y'' AND DECODE(COMP_AID,''CM000000'','''||pComp_Aid||
--        ''', COMP_AID)= '''||pComp_Aid||'''';
--        IF(pIsMultipleSheet = 'Y') THEN
--          vStrQuery        :=vStrQuery ||' AND MASTER_AID IN ('||vUsedMasterAid||')';
--        END IF;
--        IF pReportID IN ('RP00000007','RP00000004','RP00000062') THEN
--          vStrQuery :=vStrQuery ||' UNION ALL
--      SELECT DISTINCT '''||
--          pReportID||''' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||pMasterType||
--          ''' MASTER_TYPE , ''ALL'' MASTER_CONDITION_VALUE FROM DUAL
--      UNION ALL
--      SELECT DISTINCT '''
--          ||pReportID||'_SUMMARY'' EXCEL_SHEET_NAME, ''Y'' ISMULTISHEET, '''||
--          pMasterType||
--          ''' MASTER_TYPE , ''SUMMARY'' MASTER_CONDITION_VALUE FROM DUAL';
--       ELSIF pReportID IN ('RP00000101','RP00000105') THEN
--          vStrQuery :=vStrQuery ||' UNION ALL
--      SELECT DISTINCT ''BOTH'' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||pMasterType||
--          ''' MASTER_TYPE , ''BOTH'' MASTER_CONDITION_VALUE FROM DUAL
--      UNION ALL
--      SELECT DISTINCT ''SALARY'' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||
--          pMasterType||
--          ''' MASTER_TYPE , ''SALARY'' MASTER_CONDITION_VALUE FROM DUAL
--          UNION ALL
--      SELECT DISTINCT ''FNF'' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||
--          pMasterType||
--          ''' MASTER_TYPE , ''FNF'' MASTER_CONDITION_VALUE FROM DUAL';     
--        ELSE
--          vStrQuery :=vStrQuery ||' UNION ALL
--      SELECT DISTINCT '''||
--          pReportID||''' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||pMasterType||
--          ''' MASTER_TYPE , ''ALL'' MASTER_CONDITION_VALUE FROM DUAL';
--        END IF;
--        vStrQuery :=vStrQuery||' ORDER BY 2 DESC';
--       COMMIT;           
--        OPEN Return_Recordset FOR vStrQuery;
--        
--        delete from VAI;
--        commit;
--        insert into VAI values(vStrQuery);
--        commit;
--      END;
    
     PROCEDURE GET_MULTISHEET_CONDITION(
          pComp_Aid  VARCHAR2,
          pAcc_Year  VARCHAR2,
          pPay_Month VARCHAR2,
          pFrom_Date DATE,
          pTo_Date   DATE
          ,
          pUser_Aid        VARCHAR2,
          pSessionId       VARCHAR2,
          pReportType      VARCHAR2,
          pReportID        VARCHAR2,
          pIsMultipleSheet VARCHAR2,
          pMasterType      VARCHAR2,
          Return_Recordset OUT REC)
      IS
      TYPE CUR
      IS
        REF
        CURSOR;
          TEMP_RS CUR;
          vUsedMasterAid VARCHAR2(4000);
          vStrQuery LONG;
          vCounMultisheetRow number;
        BEGIN
          OPEN TEMP_RS FOR
            SELECT 'SELECT DISTINCT NVL('||MASTER_COL_NAME||',''OTHERS'') FROM PY_GM_EMPMAST WHERE COMP_AID = '''||pComp_Aid||''''
              FROM PY_GM_MASTER_COL_NAME
                WHERE MASTER_TYPE = pMasterType;
            FETCH
              TEMP_RS
            INTO
              vUsedMasterAid;
        CLOSE TEMP_RS;
        vStrQuery :='SELECT DISTINCT SUBSTR(TRANSLATE(MASTER_DESC,'':/?\*[]'''''','' ''),1,30) EXCEL_SHEET_NAME,NVL('''||pIsMultipleSheet||''',''N'') ISMULTISHEET ,MASTER_TYPE , MASTER_AID MASTER_CONDITION_VALUE FROM PY_VW_GM_GENERAL_MASTER WHERE  TRIM(MASTER_TYPE) = TRIM(''' ||pMasterType||''') AND NVL('''||pIsMultipleSheet|| ''',''N'') = ''Y'' AND DECODE(COMP_AID,''CM000000'','''||pComp_Aid||''', COMP_AID)= '''||pComp_Aid||'''';

        IF(pIsMultipleSheet = 'Y') THEN
          vStrQuery        :=vStrQuery ||' AND MASTER_AID IN ('||vUsedMasterAid||')';
        END IF;
        VCOUNMULTISHEETROW:=0;
        Select count(REPORT_ID) INTO vCounMultisheetRow FROM PY_GM_MULTISHEETDetails where REPORT_ID=pReportID;
        IF(vCounMultisheetRow > 0) THEN
            vStrQuery :=vStrQuery ||' UNION ALL Select EXCEL_SHEET_NAME,ISMULTISHEET,MASTER_TYPE ,MASTER_CONDITION_VALUE FROM PY_GM_MULTISHEETDetails where REPORT_ID ='''|| pReportID ||'''';
        ELSE
            vStrQuery :=vStrQuery ||' UNION ALL SELECT DISTINCT '''||pReportID||''' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||pMasterType||''' MASTER_TYPE , ''ALL'' MASTER_CONDITION_VALUE FROM DUAL';
        END IF;

        VSTRQUERY :=VSTRQUERY||' ORDER BY 2 DESC';

       

    
        OPEN Return_Recordset FOR vStrQuery;
        delete from vai;
        commit;
        INSERT INTO VAI VALUES(vStrQuery);
        commit;
      END;
    
     PROCEDURE GET_REPORT_DTL
  (
    pComp_Aid        VARCHAR2,
    pAcc_Year        VARCHAR2,
    pReportID        VARCHAR2,
    pPay_Month       VARCHAR2,
    pFrom_Date       DATE,
    pTo_Date         DATE,
    pComp_Name OUT   VARCHAR2,
    pReport_Name OUT VARCHAR2
  )
IS
TYPE REC
IS
  REF
  CURSOR;
    Temp_Rec REC;
    strRpt_Name PY_GM_REPORT_MASTER.REPORT_NAME%TYPE;
  BEGIN
    --GET THE COMPANY NAME
    OPEN Temp_Rec FOR
    SELECT TRIM
    (
      COMP_NAME
    )
    FROM PY_GM_COMP WHERE COMP_ID=pComp_Aid;
    FETCH
      Temp_Rec
    INTO
      pComp_Name;
  CLOSE Temp_Rec;
  --GET THE REPORT NAME
  OPEN Temp_Rec FOR
  SELECT TRIM(REPORT_NAME) FROM PY_GM_REPORT_MASTER WHERE REPORT_ID=pReportID ;
  FETCH
    Temp_Rec
  INTO
    strRpt_Name;
  CLOSE Temp_Rec;
  IF pPay_Month IN ('QUARTERLY I','QUARTERLY II','QUARTERLY III','QUARTERLY IV'
    ,'YEARLY','DATE WISE REPORT') THEN
    pReport_Name:= strRpt_Name||' For '||pPay_Month||CHR(13)||'From : '||
    TO_CHAR(pFrom_Date,'DD-MON-YYYY')||' To : '||TO_CHAR(pTo_Date,'DD-MON-YYYY'
    )||
    '                                                                     Date '
    ||TO_CHAR(SYSDATE,'DD-MON-YYYY');
    IF pPay_Month  ='YEARLY' THEN
      pReport_Name:=strRpt_Name|| ' For The Year '||SUBSTR(pAcc_Year,3,LENGTH(
      pAcc_Year)-4)||'-'||SUBSTR(pAcc_Year,7,2)||
      '                                                                     Date '
      ||TO_CHAR(SYSDATE,'DD-MON-YYYY');
    END IF;
  ELSE
    pReport_Name:= strRpt_Name||' For The Month Of '||pPay_Month||
    '                                                                     Date '
    ||TO_CHAR(SYSDATE,'DD-MON-YYYY');
  END IF;
  --            pReport_Name:= strRpt_Name||' FOR THE MONTH OF ' || pPay_Month|
  -- |'
  -- Date '||TO_CHAR(SYSDATE,'DD-MON-YYYY');
END;
      
      PROCEDURE GET_EXCEL_FORMATTING
        (
          pComp_Aid  VARCHAR2,
          pAcc_Year  VARCHAR2,
          pPay_Month VARCHAR2
          ,
          pUser_Aid   VARCHAR2,
          pSessionId  VARCHAR2,
          pReportType VARCHAR2,
          pReportID   VARCHAR2,
          Return_Recordset OUT REC
        )
      IS
      BEGIN
        OPEN Return_Recordset FOR
        SELECT 'REPORT_SECTION' REPORT_SECTION,12 FONT_SIZE,'1' FONT_BOLD,'Arial' FONT_STYLE,
                49407 COLOR,0 MERGE_FLAG,0 FREEZEROW, 3 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL
        UNION ALL
        SELECT 'RH' REPORT_SECTION,12 FONT_SIZE,'1' FONT_BOLD,'Arial' FONT_STYLE,
                16777215 COLOR,1 MERGE_FLAG,0 FREEZEROW, 3 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL
        UNION ALL
        SELECT 'DH' report_section, 10 FONT, '1' FONT_BOLD, 'Arial' FONT_STYLE,
                49407 COLOR, 0 merge_flag, 1 FREEZEROW, 1 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL
        UNION ALL
        SELECT 'RF' report_section, 12 FONT, '1' FONT_BOLD, 'Arial' FONT_STYLE,
                49500 COLOR, 0 merge_flag, 0 FREEZEROW, 1 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL
        UNION ALL
        SELECT 'XYZ-ST-XYZ' report_section, 10 FONT, '1' FONT_BOLD, 'Arial' FONT_STYLE,
                16777215 COLOR , 0 merge_flag, 0 FREEZEROW, 1 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL
        UNION ALL
        SELECT 'XYZ-XYZ-XYZ' REPORT_SECTION, 10 FONT_SIZE, '1' FONT_BOLD, 'Arial' FONT_STYLE,
                16777215 COLOR, 1 MERGE_FLAG, 0 FREEZEROW, 1 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL
        UNION ALL
        SELECT 'OXO' REPORT_SECTION, 10 FONT_SIZE, '1' FONT_BOLD, 'Arial' FONT_STYLE,
                49407 COLOR, 0 MERGE_FLAG, 0 FREEZEROW, 1 HOR_ALIGN,3 VER_ALIGN
        FROM DUAL;
        END;
      --Fill the list of reports name in data grid
      PROCEDURE FILL_REPORTS_LIST_GRID(
          pComp_Aid  VARCHAR2,
          pAcc_Year  VARCHAR2,
          pUser_Aid  VARCHAR2,
          pSessionId VARCHAR2,
          pFrom_Date DATE,
          pTo_Date   DATE,
          Return_Recordset OUT REC)
      IS
        V_QUERY VARCHAR2(4000);
      BEGIN
        --        OPEN Return_Recordset FOR
        --            SELECT REPORT_ID,REPORT_NAME,REPORT_FILE_NAME,REPORT_SHEET_NAME
        -- ,REPORT_HEADER_NAME,SCHEMA_OBJECT_NAMES,DISPLAY_ORDER
        --                FROM PY_GM_REPORT_MASTER
        --                WHERE  IS_ACTIVE='Y'
        --                ORDER BY DISPLAY_ORDER ;
        --,A.IS_FORMATTEDREPORT
        V_QUERY :=
        ' SELECT A.REPORT_ID,A.REPORT_NAME,A.REPORT_FILE_NAME,A.REPORT_SHEET_NAME,A.REPORT_HEADER_NAME,A.SCHEMA_OBJECT_NAMES,A.DISPLAY_ORDER,B.REPORT_PATH,B.RPT_DATASET_ID
      ,A.VIEW_FLAG,A.EXCEL_FLAG,A.PDF_FLAG,A.CRYSTAL_FLAG,A.TEXT_FLAG,A.IS_FORMATTEDREPORT,A.ISHEADERFIELD
      FROM PY_GM_REPORT_MASTER A, PY_GM_REPORT_PATH B
      WHERE A.REPORT_ID=B.REPORT_ID(+)
      AND A.IS_ACTIVE=''Y'' AND B.ACTIVE(+)=''Y''
      AND GREATEST(B.EFF_DATE_FR(+),'''
        ||pFrom_Date||''') <='''||pFrom_Date||
        '''
      AND NVL(B.EFF_DATE_TO(+),'''||pTo_Date||''') >= '''||pTo_Date
        ||'''';
        V_QUERY := V_QUERY || ' ORDER BY A.REPORT_ID, DISPLAY_ORDER ' ;
      
        OPEN Return_Recordset FOR V_QUERY;
      END FILL_REPORTS_LIST_GRID;
      --Fill the list of Period type in dropdown name in data grid
      PROCEDURE FILL_PERIOD_COMBO(
          pComp_Aid VARCHAR2,
          pAcc_Year VARCHAR2,
          pUser_Aid VARCHAR2,
          Return_Recordset OUT REC)
      IS
      BEGIN
        OPEN Return_Recordset FOR
        SELECT REPORT_PERIOD DISPLAY_REPORT_PERIOD,
        TO_CHAR(EFF_FR_DATE,'DD-Mon-YYYY')||'|'||TO_CHAR(EFF_TO_DATE,'DD-Mon-YYYY')||
        '|'||ENABLE_DATE_WISE VALUE_REPORT_PERIOD FROM
        (
          SELECT
            1 DISP_ORDER,
            '--Select--' REPORT_PERIOD,
            NULL EFF_FR_DATE,
            NULL EFF_TO_DATE,
            'N' ENABLE_DATE_WISE
          FROM
            DUAL
          UNION ALL
          SELECT
            2 DISP_ORDER,
            PY_NUM_TO_MONTH(LEVEL,pAcc_Year) REPORT_PERIOD,
            TO_DATE(01
            ||PY_NUM_TO_MONTH(LEVEL,pAcc_Year)) EFF_FR_DATE,
            LAST_DAY(TO_DATE(01
            ||PY_NUM_TO_MONTH(LEVEL,pAcc_Year))) EFF_TO_DATE,
            'N' ENABLE_DATE_WISE
          FROM
            DUAL CONNECT BY LEVEL<=12
          UNION ALL
          SELECT
            3 DISP_ORDER,
            DECODE(SR_NO,'1','QUATERLY I','4','QUATERLY II','7','QUATERLY III','10',
            'QUATERLY IV') REPORT_PERIOD,
            EFF_FR_DATE,
            EFF_TO_DATE,
            'N' ENABLE_DATE_WISE
          FROM
            (
              SELECT
                LEVEL SR_NO ,
                PY_NUM_TO_MONTH(LEVEL,pAcc_Year) REPORT_PERIOD,
                TO_DATE(01
                ||PY_NUM_TO_MONTH(LEVEL,pAcc_Year)) EFF_FR_DATE,
                LAST_DAY(ADD_MONTHS(TO_DATE(01
                ||PY_NUM_TO_MONTH(LEVEL,pAcc_Year)),2)) EFF_TO_DATE
              FROM
                DUAL CONNECT BY LEVEL<=12
            )
          WHERE
            SR_NO IN ('1','4','7','10')
          UNION ALL
          SELECT
            4 DISP_ORDER,
            'YEARLY' REPORT_PERIOD,
            TO_DATE(01
            ||PY_NUM_TO_MONTH(1,pAcc_Year)) EFF_FR_DATE,
            LAST_DAY(TO_DATE(01
            ||PY_NUM_TO_MONTH(12,pAcc_Year))) EFF_FR_DATE,
            'N' ENABLE_DATE_WISE
          FROM
            DUAL
          UNION ALL
          SELECT
            5 DISP_ORDER,
            'DATE WISE REPORT' REPORT_PERIOD,
            TO_DATE(01
            ||PY_NUM_TO_MONTH(1,pAcc_Year)) EFF_FR_DATE,
            LAST_DAY(TO_DATE(01
            ||PY_NUM_TO_MONTH(12,pAcc_Year))) EFF_FR_DATE,
            'Y' ENABLE_DATE_WISE
          FROM
            DUAL
        )
        ORDER BY DISP_ORDER,
        EFF_FR_DATE;
      END;
      --Fill the batch list for the particular period according to From Date and To
      -- Date
      PROCEDURE FILL_BATCH_LIST_GRID(
          pComp_Aid  VARCHAR2,
          pAcc_Year  VARCHAR2,
          pPay_Month VARCHAR2,
          pFrom_Date DATE,
          pTo_Date   DATE,
          pUser_Aid  VARCHAR2,
          Return_Recordset OUT REC)
      IS
      BEGIN
        OPEN Return_Recordset FOR
        SELECT PAY_MONTH,
        BATCH_ID FROM PY_PM_MONTH_STATUS
        WHERE COMP_AID = pComp_Aid
        AND TO_DATE(01||PAY_MONTH) BETWEEN pFrom_Date AND pTo_Date;
      END FILL_BATCH_LIST_GRID;
      PROCEDURE FILL_REPORT_LIST(
          P_SEARCH_COLUMN VARCHAR2,
          P_SEARCH_VALUE  VARCHAR2,
          pFrom_Date      DATE,
          pTo_Date        DATE,
          Return_Recordset OUT REC)
      IS
        V_QUERY VARCHAR2(4000);
      BEGIN
        V_QUERY :=
        ' SELECT A.REPORT_ID,A.REPORT_NAME,A.REPORT_FILE_NAME,A.REPORT_SHEET_NAME,A.REPORT_HEADER_NAME,A.SCHEMA_OBJECT_NAMES,A.DISPLAY_ORDER,B.REPORT_PATH,B.RPT_DATASET_ID
      ,A.VIEW_FLAG,A.EXCEL_FLAG,A.PDF_FLAG,A.CRYSTAL_FLAG,A.TEXT_FLAG,A.IS_FORMATTEDREPORT,A.ISHEADERFIELD
      FROM PY_GM_REPORT_MASTER A, PY_GM_REPORT_PATH B
      WHERE A.REPORT_ID=B.REPORT_ID(+)
      AND A.IS_ACTIVE=''Y'' AND B.ACTIVE(+)=''Y''
      AND GREATEST(B.EFF_DATE_FR(+),'''
        ||pFrom_Date||''') <='''||pFrom_Date||
        '''
      AND NVL(B.EFF_DATE_TO(+),'''||pTo_Date||''') >= '''||pTo_Date
        ||'''';
        IF P_SEARCH_COLUMN IS NOT NULL AND P_SEARCH_VALUE IS NOT NULL THEN
          V_QUERY          := V_QUERY || ' AND UPPER(TRIM(A.' || P_SEARCH_COLUMN ||
          ')) LIKE ''%'|| UPPER(TRIM(P_SEARCH_VALUE))||'%''' ;
        END IF ;
        V_QUERY := V_QUERY || ' ORDER BY A.REPORT_ID, DISPLAY_ORDER ' ;
        OPEN Return_Recordset FOR V_QUERY;
      END FILL_REPORT_LIST;
      PROCEDURE FILL_REPORT_DATASET(
          pREPORT_ID      VARCHAR2,
          pRPT_DATASET_ID VARCHAR2,
          Return_Recordset OUT REC)
      IS
      BEGIN
        OPEN Return_Recordset FOR
        SELECT DATA_SET,
        DATA_TABLE,
        PROC_NAME FROM PY_GM_REPORT_DATASET WHERE REPORT_ID=pREPORT_ID AND
        RPT_DATASET_ID                                     =pRPT_DATASET_ID;
      END;
      PROCEDURE FILL_BATCH_LIST(
          pComp_Aid       VARCHAR2,
          pFrom_Date      DATE,
          pTo_Date        DATE,
          P_SEARCH_COLUMN VARCHAR2,
          P_SEARCH_VALUE  VARCHAR2,
          Return_Recordset OUT REC)
      IS
        V_QUERY VARCHAR2(4000);
      BEGIN
        V_QUERY :=
        ' SELECT PAY_MONTH,BATCH_ID FROM PY_PM_MONTH_STATUS
      WHERE COMP_AID ='''
        || UPPER(TRIM(pComp_Aid))||''' AND TO_DATE(01||PAY_MONTH) BETWEEN '''||
        pFrom_Date||''' AND ''' || pTo_Date||'''';
        IF P_SEARCH_COLUMN IS NOT NULL AND P_SEARCH_VALUE IS NOT NULL THEN
          V_QUERY          := V_QUERY || ' AND UPPER(TRIM(' || P_SEARCH_COLUMN ||
          ')) LIKE ''%'|| UPPER(TRIM(P_SEARCH_VALUE))||'%''' ;
        END IF ;
        V_QUERY := V_QUERY || ' ORDER BY BATCH_ID ' ;
        OPEN Return_Recordset FOR V_QUERY;
      EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
      END FILL_BATCH_LIST;
      PROCEDURE INSERT_REPORT_UPLOAD_LOG(
          pComp_Aid   VARCHAR2,
          pAcc_Year   VARCHAR2,
          pPay_Month  VARCHAR2,
          pFrom_Date  DATE,
          pTo_Date    DATE,
          pUser_Aid   VARCHAR2,
          pSessionId  VARCHAR2,
          pReportType VARCHAR2,
          pReport_ID  VARCHAR2,
          pStatus     VARCHAR2)
      IS
      BEGIN
        DELETE
          PY_PT_REPORT_UPLOAD_LOG
        WHERE
          SESSION_ID    = pSessionId
        AND COMP_AID    =pComp_Aid
        AND USER_AID    = pUser_Aid
        AND REPORT_TYPE = pReportType
        AND REPORT_ID   = pReport_ID
        AND PAY_MONTH   = pPay_Month;
        INSERT
        INTO
          PY_PT_REPORT_UPLOAD_LOG
          (
            SESSION_ID,
            COMP_AID,
            USER_AID,
            DATE_CR,
            OPER_TYPE,
            REPORT_TYPE,
            REPORT_ID,
            PAY_MONTH,
            DATE_FROM,
            DATE_TO,
            STATUS
          )
          VALUES
          (
            pSessionId,
            pComp_Aid,
            pUser_Aid,
            SYSDATE,
            'REPORT',
            pReportType,
            pReport_ID,
            pPay_Month,
            pFrom_Date,
            pTo_Date,
            pStatus
          );
        COMMIT;
      END;
      PROCEDURE INSERT_BATCH_DATA_TEMPORARY
        (
          pComp_Aid  VARCHAR2,
          pAcc_Year  VARCHAR2,
          pPay_Month VARCHAR2,
          pUser_Aid  VARCHAR2,
          pSessionId VARCHAR2,
          pReportID  VARCHAR2,
          pBatch_Id arrTyp_Batch_Id
        )
      IS
      BEGIN
        DELETE
        FROM
          PY_GTMP_BATCH_ID
        WHERE
          COMP_AID   = pComp_Aid
        AND USER_AID = pUser_Aid;
        FOR I IN pBatch_Id.FIRST .. pBatch_Id.LAST
        LOOP
          INSERT
          INTO
            PY_GTMP_BATCH_ID
            (
              SESSION_ID,
              COMP_AID,
              BATCH_ID,
              USER_AID
            )
            VALUES
            (
              pSessionId ,
              pComp_Aid ,
              pBatch_Id(I),
              pUser_Aid
            );
        END LOOP;
      END;
      --Insert the selected batch data in temporary table
      PROCEDURE INSERT_BATCH_DATA_TEMPORARY
        (
          pComp_Aid   VARCHAR2,
          pAcc_Year   VARCHAR2,
          pPay_Month  VARCHAR2,
          pFrom_Date  DATE,
          pTo_Date    DATE,
          pUser_Aid   VARCHAR2,
          pSessionId  VARCHAR2,
          pReportType VARCHAR2,
          pReportID   VARCHAR2,
          pBatch_Id arrTyp_Batch_Id,
          pFilterID VARCHAR2
        )
      IS
      BEGIN
        DELETE
        FROM
          PY_GTMP_BATCH_ID
        WHERE
          SESSION_ID = pSessionId
        AND USER_AID = pUser_Aid;
        FOR I IN pBatch_Id.FIRST .. pBatch_Id.LAST
        LOOP
          INSERT
          INTO
            PY_GTMP_BATCH_ID
            (
              SESSION_ID,
              COMP_AID,
              BATCH_ID,
              USER_AID
            )
            VALUES
            (
              pSessionId ,
              pComp_Aid ,
              pBatch_Id(I),
              pUser_Aid
            );
        END LOOP;
      END;
      PROCEDURE INSERT_FILTER_DATA_TEMPORARY
        (
          pComp_Aid        VARCHAR2,
          pAcc_Year        VARCHAR2,
          pPay_Month       VARCHAR2,
          pFrom_Date       DATE,
          pTo_Date         DATE,
          pUser_Aid        VARCHAR2,
          pSessionId       VARCHAR2,
          pReportType      VARCHAR2,
          pReportID        VARCHAR2,
          pIsMultipleSheet VARCHAR2,
          pFilterID        VARCHAR2
        )
      IS
      TYPE CUR
      IS
        REF
        CURSOR;
          TEMP_RS CUR;
          strFilter LONG;
          strSqlQuery LONG;
          strSelect LONG;
        BEGIN
          /*Generating Emp List on the basis of given Filter ID*/
          IF pFilterID IS NOT NULL AND TRIM
            (
              UPPER(pFilterID)
            )
            <>'EMPLOYEE' THEN
            DELETE
            FROM
              PY_GTMP_EMP_LIST
            WHERE
              SESSION_ID  = pSessionId
            AND USER_AID  = pUser_Aid
            AND REPORT_AID=pReportID
            AND COMP_AID  =pComp_Aid;
          OPEN TEMP_RS FOR
          SELECT --REPLACE(WM_CONCAT(FILTER_COL),',AND',' AND') 
            REPLACE(LISTAGG(FILTER_COL,',') WITHIN GROUP (ORDER BY FILTER_COL),',AND',' AND') 
          FROM
          (
            SELECT DISTINCT
              'AND EXISTS (SELECT ''X'' FROM PY_GM_REPORT_FILTER B WHERE A.COMP_AID=B.COMP_AID AND NVL(A.'
              ||MASTER_COL_NAME
              ||',''X'')=B.MASTER_AID AND B.FILTER_AID='''
              ||TRIM(FILTER_AID)
              ||''' AND  B.MASTER_COL_NAME='''
              ||TRIM(MASTER_COL_NAME)
              ||''')' FILTER_COL
            FROM
              PY_GM_REPORT_FILTER
            WHERE
              COMP_AID    =pComp_Aid
            AND FILTER_AID=pFilterID
          )
          ;
          FETCH
            TEMP_RS
          INTO
            strFilter;
          CLOSE TEMP_RS;
          strSqlQuery:=
          'INSERT INTO PY_GTMP_EMP_LIST(SESSION_ID, USER_AID, REPORT_AID, COMP_AID, EMP_AID)'
          ;
          strSelect:='SELECT '''||TRIM(pSessionId)||''','''||TRIM(pUser_Aid)||''','''
          ||TRIM(pReportID)||
          ''',COMP_AID,EMP_AID FROM PY_GM_EMPMAST A WHERE A.COMP_AID='''||pComp_Aid||
          '''';
          strSqlQuery:= strSqlQuery||CHR(13)||strSelect||CHR(13)||strFilter;
          EXECUTE IMMEDIATE strSqlQuery;
        END IF;
      END;
      PROCEDURE RETURN_COMPANY_NAME_PAY_MONTH(
          pComp_Aid            VARCHAR2,
          pAcc_Year            VARCHAR2,
          pPay_Month           VARCHAR2,
          pFrom_Date           DATE,
          pTo_Date             DATE,
          pUser_Aid            VARCHAR2,
          pSessionId           VARCHAR2,
          pReportType          VARCHAR2,
          pReportID            VARCHAR2,
          pIsBatchWiseReport   VARCHAR2,
          pFilterId            VARCHAR2,
          pIsMultipleSheet     VARCHAR2,
          pMasterType          VARCHAR2,
          pMultiSheetCondition VARCHAR2,
          Return_Recordset OUT REC)
        --    PROCEDURE RETURN_COMPANY_NAME_PAY_MONTH(pComp_Aid VARCHAR2,pAcc_Year
        -- VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid
        -- VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,
        -- pIsBatchWiseReport VARCHAR2,pBatch_Id  arrTyp_Batch_Id,pFilterId VARCHAR2,
        -- Return_Recordset OUT REC)
      IS
      BEGIN
        OPEN Return_Recordset FOR
        SELECT COMP_NAME,
        pPay_Month Pay_Month FROM PY_GM_COMP WHERE COMP_ID=pComp_Aid;
      END;
          
          
 END  PY_PK_STANDARD_REPORT_COMMON;