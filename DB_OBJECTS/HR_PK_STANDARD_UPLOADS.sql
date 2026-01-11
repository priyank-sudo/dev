create or replace PACKAGE                             "HR_PK_STANDARD_UPLOADS" IS
    TYPE REC IS REF CURSOR;
    
    TYPE arrTyp_Batch_Id IS TABLE OF VARCHAR2(25) INDEX BY PLS_INTEGER;   
    
     
    TYPE arrTyp_OpenBracket IS TABLE OF VARCHAR(100) INDEX BY PLS_INTEGER;
    TYPE arrTyp_FieldName IS TABLE OF VARCHAR(200) INDEX BY PLS_INTEGER;
    TYPE arrTyp_Condition IS TABLE OF VARCHAR(200) INDEX BY PLS_INTEGER;
    TYPE arrTyp_FieldValue IS TABLE OF VARCHAR(300) INDEX BY PLS_INTEGER;
    TYPE arrTyp_CloseBracket IS TABLE OF VARCHAR(300) INDEX BY PLS_INTEGER;
    TYPE arrTyp_Conditionoperatior IS TABLE OF VARCHAR(300) INDEX BY PLS_INTEGER;
    TYPE arrTyp_SrNo IS TABLE OF VARCHAR(300) INDEX BY PLS_INTEGER;
    
   --Filling the Search cloumn List in dropdown
   PROCEDURE FILL_SEARCH_COLUMN_DROPDOWN(pDropDownName VARCHAR2,  Return_Recordset OUT REC);
   
       --Filling Upload History
   PROCEDURE FILL_UPLOAD_HISTORY_GRID(pComp_Aid VARCHAR2, pAcc_Year VARCHAR2, pUser_Aid VARCHAR2, pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
        pFromDate VARCHAR2, pToDate VARCHAR2,  pSearchColumn VARCHAR2, pSearchValue VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC,Return_FillDrp OUT REC);
    
   --Searh Data
    PROCEDURE FILL_SEARCH_UPLOAD(P_SEARCH_COLUMN VARCHAR2,P_SEARCH_VALUE VARCHAR2,PGRIDPAGEINDEX VARCHAR2,PGRIDPAGESIZE VARCHAR2,pComp_Aid VARCHAR2,
    Return_FillGrid OUT REC,Return_FillDrp OUT REC);
    
    --Get the Upload Batch Id
    FUNCTION FN_GET_UPLOAD_BATCH_ID (pUpload_Aid VARCHAR2) RETURN VARCHAR2;

    --Fill the list of Uploads name in data grid  
   PROCEDURE FILL_UPLOAD_LIST_GRID(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2
                                    ,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC,Return_FillDrp OUT REC);

    PROCEDURE INSERT_FILTER_DATA(pSession_id VARCHAR2,pUser_id VARCHAR2,pUpload_id VARCHAR2,pOpenBracket arrTyp_OpenBracket,pFieldName arrTyp_FieldName,pCondition arrTyp_Condition,pFieldValue arrTyp_FieldValue,pCloseBracket arrTyp_CloseBracket,pConditionoperatior arrTyp_Conditionoperatior,pSrNo arrTyp_SrNo);
    
    PROCEDURE FILL_FEILD(PViewName VARCHAR2,Return_Recordset OUT REC);
    
    --Fill the list of Uploads Template in data grid  
    PROCEDURE GET_UPLOAD_TEMPLATE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid  VARCHAR2,pTemplateOnlyFlag VARCHAR2,Return_Recordset OUT REC);
    --Fill the upload type
    PROCEDURE GET_UPLOAD_TYPE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid  VARCHAR2,Return_Recordset OUT REC);
    
   --Insert Upload Summary
    PROCEDURE INSERT_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pTrans_Type VARCHAR2,pUploadBatch_Id VARCHAR2);

    --Commit or Rollback the uploaded data    
    PROCEDURE COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pUploadBatch_Id VARCHAR2);
    
    --Fill the uploaded Summary
    PROCEDURE GET_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
            pUploadBatch_id  VARCHAR2, Return_Recordset OUT REC);
    

  PROCEDURE EXPORT_UPLOAD_DETAIL_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
           pStatus VARCHAR2, pUploadBatch_Id VARCHAR2,Return_Recordset OUT REC);
    
    --Fill the uploaded Report    
   PROCEDURE GET_UPLOAD_DETAIL_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
           pStatus VARCHAR2, pUploadBatch_Id VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC,Return_FillDrp OUT REC);
           
    --Upload arrear and adjustment data
    PROCEDURE UPLOAD_GM_GRADE_MSTR(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
     PROCEDURE UPLOAD_GM_DEPTS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)  ;  
     PROCEDURE UPLOAD_GM_DESIGNATIONS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);   
     PROCEDURE UPLOAD_GM_HOLIDAYS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
     PROCEDURE UPLOAD_GM_CITY(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
    PROCEDURE UPLOAD_GM_STATE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  
    PROCEDURE UPLOAD_GM_BRANCH(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);                                                           
    PROCEDURE UPLOAD_GM_EMP(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
    PROCEDURE UPLOAD_GM_BAND(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
    PROCEDURE UPLOAD_GM_COUNTRY(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC) ; 
   PROCEDURE UPLOAD_GM_LOCATIONS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC) ;
   PROCEDURE UPLOAD_PT_EMP_CTC_DEFINE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  
                
   PROCEDURE UPLOAD_GM_BANK(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC) ;   
   PROCEDURE UPLOAD_GM_COST_CENTER(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);                                                                   
--    Procedure PROC_CTC_TEMP_UPLOAD (pSESSION_ID VARCHAR2,pUSER_AID VARCHAR2,pUPLOAD_AID VARCHAR2,pACC_YEAR VARCHAR2,pDataIn In long);
--    Procedure PROC_CTC_FINAL_UPLOAD (pSESSION_ID VARCHAR2,pUSER_AID VARCHAR2,pUPLOAD_AID VARCHAR2,pACC_YEAR VARCHAR2,pDataIn In long);

--    PROCEDURE UPLOAD_BATCH_ID(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
--                pRawXmlData VARCHAR2,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);

    --Uploading Attribute Master 
  PROCEDURE UPLOAD_GM_ATTRIBUTE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
  PROCEDURE UPLOAD_PM_SUB_ATTRIBUTE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
   PROCEDURE UPLOAD_PM_EMP_ATTRIBUTE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  
                          
  PROCEDURE UPLOAD_PT_EMP_OTHER_CTC_DEFINE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  
                                                
     PROCEDURE UPLOAD_FAMILY_MEMBER(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);

--Sub Department upload
    PROCEDURE UPLOAD_SUB_DEPARTMENT(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);
                
    PROCEDURE GET_UPLOAD_FORMAT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid  VARCHAR2,pUpload_Type VARCHAR2,Return_Recordset OUT REC);                                               
                   
END ;

create or replace PACKAGE BODY                                                                                                                                                                       "HR_PK_STANDARD_UPLOADS" IS

    --Filling the Search cloumn List in dropdown
    PROCEDURE FILL_SEARCH_COLUMN_DROPDOWN(pDropDownName VARCHAR2,  Return_Recordset OUT REC)
   IS
   BEGIN

        OPEN Return_Recordset FOR
            SELECT '--Select--'  Search_Column FROM DUAL
            UNION ALL
            SELECT 'Upload Batch Id'  Search_Column FROM DUAL
            UNION ALL
            SELECT 'Upload Type'  Search_Column FROM DUAL
            UNION ALL
            SELECT 'Status'  Search_Column FROM DUAL
            UNION ALL
            SELECT 'Cleanup Status'  Search_Column FROM DUAL;

    END;
    --Filling Upload History
    PROCEDURE FILL_UPLOAD_HISTORY_GRID(pComp_Aid VARCHAR2, pAcc_Year VARCHAR2, pUser_Aid VARCHAR2, pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
        pFromDate VARCHAR2, pToDate VARCHAR2,  pSearchColumn VARCHAR2, pSearchValue VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC,Return_FillDrp OUT REC)
    IS
    vGridPageCount      NUMBER;
    vFillDrp            LONG;
    vStrQuery           LONG;
    vFrom               LONG;
    vSelect             LONG;
    vGridp              NUMBER;
    vStrSql             LONG;
    TYPE refCUR IS REF CURSOR;
    curRec              refCUR;
    BEGIN
    
    
        OPEN curRec FOR
            SELECT COUNT(*) FROM 
               (   
                    SELECT DISTINCT TO_char(A.UPLOAD_DATE,'YYYYMMDDHH24MISS') SORT_DATA,A.UPLOAD_BATCH_ID,  A.TRANS_TYPE,TO_CHAR(A.UPLOAD_DATE,'DD/MM/YYYY HH24:MI:SS') UPLOAD_DATE, A.TOTAL_RECORDS, A.SUCCESS_RECORDS, A.FAILED_RECORDS, A.STATUS, DECODE(NVL(B.UPLOAD_BATCH_ID,'Y'),'Y','CLEANEDUP','PENDING CLEANUP') DATA_CLEAN_STATUS,A.SESSION_ID, A.USER_AID, A.UPLOAD_AID,
                        C.PACKAGE_NAME
                        FROM HR_PM_STANDARD_UPLOAD C,HR_PM_UPLOAD_STATUS_HD A, HR_TEMP_RAW_UPLOAD B
                    WHERE  C.UPLOAD_AID = A.UPLOAD_AID
                            AND A.SESSION_ID = B.SESSION_ID(+) AND A.USER_AID = B. USER_AID(+) AND A.UPLOAD_AID = B.UPLOAD_AID(+) AND A.UPLOAD_BATCH_ID = B.UPLOAD_BATCH_ID(+)
                            AND TRIM(C.UPLOAD_AID) = TRIM(pUpload_Aid)
                            AND A.USER_AID = pUser_Aid
                            AND TO_DATE(A.UPLOAD_DATE) BETWEEN NVL(TO_DATE(pFromDate), SYSDATE-60) AND NVL(TO_DATE(pToDate), SYSDATE)
                            AND CASE
                                WHEN TRIM(pSearchColumn) = 'Upload Batch Id'   THEN UPPER(A.UPLOAD_BATCH_ID)
                                WHEN TRIM(pSearchColumn) = 'Upload Type'   THEN UPPER(A.TRANS_TYPE)
                                WHEN TRIM(pSearchColumn) = 'Status'   THEN UPPER(A.STATUS)
                                WHEN TRIM(pSearchColumn) = 'Cleanup Status'   THEN DECODE(NVL(B.UPLOAD_BATCH_ID,'Y'),'Y','CLEANEDUP','PENDING CLEANUP')
                                ELSE UPPER(A.UPLOAD_BATCH_ID) END LIKE  '%'||UPPER(TRIM(pSearchValue))||'%'
                    ORDER BY SORT_DATA DESC
                );
            FETCH curRec INTO vGridPageCount;
        CLOSE curRec;    
    
        --Return Page Index count
        OPEN Return_FillDrp FOR
             SELECT LEVEL PAGE_INDEX ,LEVEL|| ' of ' ||CEIL((NVL(vGridPageCount,0))/NVL(pGridPageSize,0)) PAGE_COUNT     
                       FROM DUAL WHERE NVL(vGridPageCount,0)>0  CONNECT BY LEVEL <= CEIL((NVL(vGridPageCount, 0))/NVL(pGridPageSize, 0));
                   
        --Retrun Grid Data
         OPEN Return_FillGrid FOR     
                SELECT SORT_DATA,UPLOAD_BATCH_ID,TRANS_TYPE ,UPLOAD_DATE, TOTAL_RECORDS, SUCCESS_RECORDS , FAILED_RECORDS, STATUS, DATA_CLEAN_STATUS ,
                    SESSION_ID, USER_AID, UPLOAD_AID, PACKAGE_NAME 
                   FROM 
                    (
                        SELECT ROWNUM ROW_NO, A.* FROM 
                           (   
                                SELECT DISTINCT TO_CHAR(A.UPLOAD_DATE,'YYYYMMDDHH24MISS') SORT_DATA,A.UPLOAD_BATCH_ID,  A.TRANS_TYPE,TO_CHAR(A.UPLOAD_DATE,'DD/MM/YYYY HH24:MI:SS') UPLOAD_DATE, A.TOTAL_RECORDS, 
                                A.SUCCESS_RECORDS, A.FAILED_RECORDS, A.STATUS, DECODE(NVL(B.UPLOAD_BATCH_ID,'Y'),'Y','CLEANEDUP','PENDING CLEANUP') DATA_CLEAN_STATUS,
                                A.SESSION_ID, A.USER_AID, A.UPLOAD_AID, C.PACKAGE_NAME
                                    FROM HR_PM_STANDARD_UPLOAD C,HR_PM_UPLOAD_STATUS_HD A, HR_TEMP_RAW_UPLOAD B
                                WHERE  C.UPLOAD_AID = A.UPLOAD_AID
                                        AND A.SESSION_ID = B.SESSION_ID(+) AND A.USER_AID = B. USER_AID(+) AND A.UPLOAD_AID = B.UPLOAD_AID(+) AND A.UPLOAD_BATCH_ID = B.UPLOAD_BATCH_ID(+)
                                        AND TRIM(C.UPLOAD_AID) = TRIM(pUpload_Aid)
                                        AND A.USER_AID = pUser_Aid
                                        AND TO_DATE(A.UPLOAD_DATE) BETWEEN NVL(TO_DATE(pFromDate), SYSDATE-60) AND NVL(TO_DATE(pToDate), SYSDATE)
                                        AND CASE
                                            WHEN TRIM(pSearchColumn) = 'Upload Batch Id'   THEN UPPER(A.UPLOAD_BATCH_ID)
                                            WHEN TRIM(pSearchColumn) = 'Upload Type'   THEN UPPER(A.TRANS_TYPE)
                                            WHEN TRIM(pSearchColumn) = 'Status'   THEN UPPER(A.STATUS)
                                            WHEN TRIM(pSearchColumn) = 'Cleanup Status'   THEN DECODE(NVL(B.UPLOAD_BATCH_ID,'Y'),'Y','CLEANEDUP','PENDING CLEANUP')
                                            ELSE UPPER(A.UPLOAD_BATCH_ID) END LIKE  '%'||UPPER(TRIM(pSearchValue))||'%'
                                ORDER BY SORT_DATA DESC
                            ) A
                      )
                    WHERE ROW_NO BETWEEN pGridPageIndex * pGridPageSize +1 AND (1 + pGridPageIndex) * pGridPageSize;
                    

    END;

    PROCEDURE FILL_SEARCH_UPLOAD(P_SEARCH_COLUMN VARCHAR2,P_SEARCH_VALUE VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,pComp_Aid VARCHAR2,
    Return_FillGrid OUT REC,Return_FillDrp OUT REC)
   IS
    vGridPageCount      NUMBER;
    vFillDrp            LONG;
    vStrQuery           LONG;
    vFrom               LONG;
    vSelect             LONG;
    vGridp              NUMBER;
    TYPE refCUR IS REF CURSOR;
    curRec              refCUR;
    vEMP_MID_FLAG       varchar2(10);
   BEGIN
        
        vStrQuery :='SELECT ';
        vSelect:='UPLOAD_AID, UPLOAD_NAME, UPLOAD_DESC,UPLOAD_TEMPLATE, DISP_ORDER, TABLE_NAME, PACKAGE_NAME,VIEW_NAME, REPLACE(UPLOAD_GUIDELINES,CHR(13),''</br>'') UPLOAD_GUIDELINES';
        vFrom:=' FROM HR_PM_STANDARD_UPLOAD
                WHERE  IS_ACTIVE=''Y''';
                
        IF  P_SEARCH_COLUMN IS NOT NULL AND P_SEARCH_VALUE IS NOT NULL THEN
            vFrom := vFrom || ' AND UPPER(TRIM(' || P_SEARCH_COLUMN || ')) LIKE ''%'|| UPPER(TRIM(P_SEARCH_VALUE))||'%''' ;
        END IF;  
        
        vFrom := vFrom|| 'ORDER BY UPLOAD_AID';     
                
        OPEN curRec FOR
            vStrQuery||' COUNT(*) '||vFrom;
        FETCH curRec INTO vGridPageCount;
        CLOSE curRec;
      
        --Return Page Index count
        OPEN Return_FillDrp FOR
             SELECT LEVEL PAGE_INDEX ,LEVEL|| ' of ' ||CEIL((NVL(vGridPageCount,0))/NVL(pGridPageSize,0)) PAGE_COUNT     
                       FROM DUAL WHERE NVL(vGridPageCount,0)>0  CONNECT BY LEVEL <= CEIL((NVL(vGridPageCount, 0))/NVL(pGridPageSize, 0));
 
        OPEN curRec FOR
           SELECT IS_EMP_CODE_AUTOGENERATED
           FROM GM_COMP WHERE COMP_ID=pComp_Aid;
        FETCH curRec INTO vEMP_MID_FLAG;
        CLOSE curRec;                       

        vStrQuery:='SELECT UPLOAD_AID, UPLOAD_NAME, UPLOAD_DESC,DECODE('''||vEMP_MID_FLAG||''',''Y'',DECODE(UPLOAD_AID,''UP000012'',REPLACE(UPLOAD_TEMPLATE,''EMPLOYEE_CODE|'',''''),UPLOAD_TEMPLATE),UPLOAD_TEMPLATE) UPLOAD_TEMPLATE, DISP_ORDER, TABLE_NAME, PACKAGE_NAME,VIEW_NAME, UPLOAD_GUIDELINES'
                    ||' FROM (SELECT ROWNUM MYROW, UPLOAD_AID, UPLOAD_NAME, UPLOAD_DESC,UPLOAD_TEMPLATE, DISP_ORDER, TABLE_NAME, PACKAGE_NAME,VIEW_NAME, 
                        UPLOAD_GUIDELINES FROM('||vStrQuery||'ROWNUM MYROW,'||vSelect||vFrom
                    ||' )) WHERE MYROW BETWEEN '||pGridPageIndex||'*'||pGridPageSize||'+1 AND (1+'||pGridPageIndex||')*'||pGridPageSize||' ORDER BY MYROW';

        OPEN Return_FillGrid FOR vStrQuery;

    END FILL_SEARCH_UPLOAD;
    --Get the Upload Batch Id
    FUNCTION FN_GET_UPLOAD_BATCH_ID (pUpload_Aid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vUploadBatch_Id     HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    BEGIN

        vUploadBatch_Id :=  pUpload_Aid||TO_CHAR(SYSDATE,'DDMMYYYYHHMISS');

        RETURN vUploadBatch_Id;
    END;
    --Fill the list of Uploads name in data grid
    PROCEDURE FILL_UPLOAD_LIST_GRID(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2
                                    ,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC,Return_FillDrp OUT REC)
    IS
    vGridPageCount      NUMBER;
    vFillDrp            LONG;
    vStrQuery           LONG;
    vFrom               LONG;
    vSelect             LONG;
    vGridp              NUMBER;
    
    TYPE refCUR IS REF CURSOR;
    curRec              refCUR;
    vEMP_MID_FLAG       varchar2(10);
    
    BEGIN
        
        vStrQuery :='SELECT ';        
        vSelect:='UPLOAD_AID, UPLOAD_NAME, UPLOAD_DESC,UPLOAD_TEMPLATE, DISP_ORDER, TABLE_NAME, PACKAGE_NAME,VIEW_NAME, REPLACE(UPLOAD_GUIDELINES,CHR(13),''</br>'') UPLOAD_GUIDELINES';                
                
        vFrom:=' FROM HR_PM_STANDARD_UPLOAD
                WHERE  IS_ACTIVE=''Y''
                ORDER BY DISP_ORDER';
                
        OPEN curRec FOR
            vStrQuery||' COUNT(*) '||vFrom;
        FETCH curRec INTO vGridPageCount;
        CLOSE curRec;
        
        --Return Page Index count
        OPEN Return_FillDrp FOR
             SELECT LEVEL PAGE_INDEX ,LEVEL|| ' of ' ||CEIL((NVL(vGridPageCount,0))/NVL(pGridPageSize,0)) PAGE_COUNT     
                       FROM DUAL WHERE NVL(vGridPageCount,0)>0  CONNECT BY LEVEL <= CEIL((NVL(vGridPageCount, 0))/NVL(pGridPageSize, 0));

         OPEN curRec FOR
               SELECT IS_EMP_CODE_AUTOGENERATED
               FROM GM_COMP WHERE COMP_ID=pComp_Aid;
           FETCH curRec INTO vEMP_MID_FLAG;
           CLOSE curRec; 
        
        vStrQuery:='SELECT UPLOAD_AID, UPLOAD_NAME, UPLOAD_DESC,DECODE('''||vEMP_MID_FLAG||''',''Y'',DECODE(UPLOAD_AID,''UP000012'',REPLACE(UPLOAD_TEMPLATE,''EMPLOYEE_CODE|'',''''),UPLOAD_TEMPLATE),UPLOAD_TEMPLATE) UPLOAD_TEMPLATE, DISP_ORDER, TABLE_NAME, PACKAGE_NAME,VIEW_NAME, UPLOAD_GUIDELINES'
                ||' FROM ( SELECT ROWNUM MYROW,UPLOAD_AID, UPLOAD_NAME, UPLOAD_DESC,UPLOAD_TEMPLATE, DISP_ORDER, TABLE_NAME, PACKAGE_NAME,VIEW_NAME,
                    UPLOAD_GUIDELINES FROM ('||vStrQuery||'ROWNUM MYROW,'||vSelect||vFrom
                ||' )) WHERE MYROW BETWEEN '||pGridPageIndex||'*'||pGridPageSize||'+1 AND (1+'||pGridPageIndex||')*'||pGridPageSize||' ORDER BY MYROW';
       
     
        OPEN Return_FillGrid FOR vStrQuery;
        
    END;

     PROCEDURE INSERT_FILTER_DATA(pSession_id VARCHAR2,pUser_id VARCHAR2,pUpload_id VARCHAR2,pOpenBracket arrTyp_OpenBracket,pFieldName arrTyp_FieldName,pCondition arrTyp_Condition,pFieldValue arrTyp_FieldValue,pCloseBracket arrTyp_CloseBracket,pConditionoperatior arrTyp_Conditionoperatior,pSrNo arrTyp_SrNo)

   IS
    vSrNo varchar2(8);

   BEGIN

     DELETE FROM HR_TEMP_DOWNLOAD_FILTER
        WHERE USER_ID = pUser_id;

    FOR I IN pSrNo.FIRST .. pSrNo.LAST
    LOOP
--        IF TRIM(UPPER(pFieldName(I)))<>'-SELECT-' THEN
            vSrNo:=pSrNo(I);

            INSERT INTO HR_TEMP_DOWNLOAD_FILTER (SESSION_ID, USER_ID, UPLOAD_ID,SEQ_NO, OPEN_BRAC, FIELD_NAME,CONDITION, FIELD_VALUE, CLOSE_BRAC,CONDN_OPERATOR)
            VALUES ( pSession_id,pUser_id ,pUpload_id ,pSrNo(I),pOpenBracket(I),pFieldName(I),pCondition(I),pFieldValue(I),pCloseBracket(I) ,pConditionoperatior(I));
--        END IF;
    END LOOP;
    commit;
   END;

    --Fill the list of Uploads Template in data grid
   PROCEDURE FILL_FEILD(PViewName VARCHAR2,Return_Recordset OUT REC)
   IS
   BEGIN
   /*
   Original code commented by satish dated as on 16-oct-2013
   OPEN RETURN_RECORDSET FOR
        SELECT TRIM(COLUMN_NAME),TRIM(COLUMN_NAME)||'+'||TRIM(DATA_TYPE)CTC_DESC
        FROM USER_TAB_COLS
        WHERE TABLE_NAME=PViewName
        ORDER BY COLUMN_ID;
        */
       OPEN RETURN_RECORDSET FOR
        SELECT TRIM(COLUMN_NAME),TRIM(COLUMN_NAME)||'+'||TRIM(DATA_TYPE)||'+'||TO_CHAR(DATA_LENGTH)CTC_DESC
        FROM USER_TAB_COLS
        WHERE TABLE_NAME=PViewName
        ORDER BY COLUMN_ID;
   END;
   
    PROCEDURE GET_UPLOAD_TEMPLATE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pTemplateOnlyFlag VARCHAR2
            ,Return_Recordset OUT REC)
    IS
    TYPE refCur IS REF CURSOR;
    curRec                    refCur;
    vUploadTemplate           HR_PM_STANDARD_UPLOAD.UPLOAD_TEMPLATE%TYPE;
    vTABLE_NAME               HR_PM_STANDARD_UPLOAD.TABLE_NAME%TYPE;
    vStrQuery                 LONG;
    vViewName               VARCHAR2(50);
    vStrWHERE               LONG;
    vStrFilterCondn         LONG;
    vIsFilter               number(3);
    vStrColumns             LONG;
    vEMP_MID_FLAG           VARCHAR2(10);
    vEMP_MID_LOGIC          VARCHAR2(10);
    vCOMP_MID               VARCHAR2(10);
    vCOMP_FLAG              NUMBER;
    BEGIN


        IF NVL(pTemplateOnlyFlag,'Y')='Y' THEN
           OPEN curRec FOR
                SELECT UPLOAD_TEMPLATE FROM HR_PM_STANDARD_UPLOAD
                    WHERE  UPLOAD_AID = pUpload_Aid;
           FETCH curRec INTO vUploadTemplate;
            
           OPEN curRec FOR
               SELECT IS_EMP_CODE_AUTOGENERATED,EMP_CODE_AUTOGENERATED_LOGIC
               FROM GM_COMP WHERE COMP_ID=pComp_Aid;
           FETCH curRec INTO vEMP_MID_FLAG,vEMP_MID_LOGIC;
           CLOSE curRec; 

           IF pUpload_Aid='UP000012' AND vEMP_MID_FLAG='Y' THEN
              vUploadTemplate:=REPLACE(vUploadTemplate,'EMPLOYEE_CODE|','');
           END IF;

            vUploadTemplate := REPLACE(vUploadTemplate,'|',',NULL ');

            vStrQuery := 'SELECT NULL '||vUploadTemplate|| ' FROM DUAL';

        ELSE
            OPEN curRec FOR
                SELECT VIEW_NAME FROM HR_PM_STANDARD_UPLOAD
                    WHERE  UPLOAD_AID = pUpload_Aid;
            FETCH curRec INTO vViewName;
            close curRec;

            vStrColumns:= NVL(HR_PK_VALIDATION.FUNC_FORMAT_COLS(vViewName,'N'),'*');

            SELECT COUNT(*) INTO vIsFilter
            FROM HR_TEMP_DOWNLOAD_FILTER
            WHERE SESSION_ID=pSessionId AND USER_ID=pUser_Aid AND UPLOAD_ID=pUpload_Aid;

            vStrQuery:='SELECT '||vStrColumns||' FROM '||vViewName;

            IF vIsFilter != 0 THEN
                OPEN curRec FOR
                SELECT UPPER(REPLACE (LISTAGG(CONDITOPN,',') WITHIN GROUP (ORDER BY CONDITOPN),',',' ')) --UPPER(REPLACE (WM_CONCAT(CONDITOPN),',',' '))
                FROM(
                    SELECT DECODE(OPEN_BRAC,'Y','( ',NULL)||' '||FIELD_NAME
--                          ||' '||DECODE(UPPER(FIELD_VALUE),'UPPER(''NULL'')',REPLACE(REPLACE(CONDITION,'=',' IS '),'<>',' IS NOT '),CONDITION)
                          ||' '||CONDITION
--                          ||' '||decode(FIELD_VALUE,'NULL',NULL,FIELD_VALUE)
                          ||' '||FIELD_VALUE
                          ||' ' ||DECODE(CLOSE_BRAC,'Y',') ',NULL)||CONDN_OPERATOR CONDITOPN
                    FROM HR_TEMP_DOWNLOAD_FILTER
                    WHERE SESSION_ID=pSessionId AND USER_ID=pUser_Aid AND UPLOAD_ID=pUpload_Aid 
                    ORDER BY SEQ_NO);
                FETCH curRec INTO vStrFilterCondn;
                CLOSE  curRec;
             
             SELECT COUNT(*) INTO vCOMP_FLAG 
              FROM COL WHERE TNAME=''''||vViewName||'''' 
              AND CNAME='COMPANY_CODE';
              
              IF vCOMP_FLAG = 0 THEN
              vStrFilterCondn:= '('||vStrFilterCondn||') AND';
             
              END IF;
                               
            END IF;
            
               vStrFilterCondn:=vStrFilterCondn||' COMPANY_CODE='''||HR_PK_VALIDATION.FN_GET_COMP_MID(UPPER(pComp_Aid))||'''';

                vStrWHERE:=' WHERE '||vStrFilterCondn;
        END IF;
        
      
      
       /*
       This is original code which is commented by satish dated as on 15-oct-2013
        vStrWHERE := CASE WHEN INSTR(vStrQuery,'COMPANY_CODE')>0 AND vIsFilter != 0 THEN
                              REPLACE(vStrWHERE,'WHERE', ' WHERE "COMPANY_CODE" = '''||HR_PK_VALIDATION.FN_GET_COMP_MID(UPPER(pComp_Aid))||''' AND ')
                          WHEN INSTR(vStrQuery,'COMPANY_CODE')>0 AND NVL(pTemplateOnlyFlag,'Y')='N' THEN
                              ' WHERE "COMPANY_CODE" = '''||HR_PK_VALIDATION.FN_GET_COMP_MID(UPPER(pComp_Aid))||''''
                      ELSE
                            ' '
                      END;
        */
--        vStrWHERE := CASE WHEN INSTR(vStrQuery,'COMPANY_CODE')>0 AND vIsFilter != 0 THEN
--                              REPLACE(vStrWHERE,'WHERE', ' WHERE "COMPANY_CODE" = '''||HR_PK_VALIDATION.FN_GET_COMP_MID(UPPER(pComp_Aid))||''' AND ')
--                          WHEN INSTR(vStrQuery,'COMPANY_CODE')>0 AND NVL(pTemplateOnlyFlag,'Y')='N' THEN
--                              ' WHERE "COMPANY_CODE" = '''||HR_PK_VALIDATION.FN_GET_COMP_MID(UPPER(pComp_Aid))||''''
--                      ELSE
--                            VSTRWHERE
--                      END;
        vStrQuery:=vStrQuery||vStrWHERE||' ORDER BY 1,2,3';
--        
--       DELETE FROM VAI;
--       INSERT INTO VAI VALUES(vStrQuery);
--       COMMIT;
        
        OPEN Return_Recordset FOR vStrQuery;
        
        DELETE FROM HR_TEMP_DOWNLOAD_FILTER
        WHERE SESSION_ID=pSessionId 
        AND USER_ID=pUser_Aid AND UPLOAD_ID=pUpload_Aid;

    EXCEPTION
        WHEN OTHERS THEN
            HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_TEMPLATE',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END;
   
     --Fill the upload type
    PROCEDURE GET_UPLOAD_TYPE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid  VARCHAR2,Return_Recordset OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUploadTemplate           HR_PM_STANDARD_UPLOAD.UPLOAD_TEMPLATE%TYPE;
    vStrQuery                 LONG;
    BEGIN

--        OPEN Return_Recordset FOR
--            SELECT '--Select--'  UPLOAD_TYPE FROM DUAL
--            UNION ALL
--            SELECT 'ADD' UPLOAD_TYPE FROM DUAL
--            UNION ALL
--            SELECT 'UPDATE' UPLOAD_TYPE FROM DUAL
--            UNION ALL
--            SELECT 'DELETE' UPLOAD_TYPE FROM DUAL
--            UNION ALL
--            SELECT 'REMOVE AND ADD' UPLOAD_TYPE FROM DUAL;

            OPEN Return_Recordset FOR
              SELECT TRIM(SUBSTR(TRANS_TYPE ,INSTR (TRANS_TYPE, '|', 1, LEVEL ) + 1, INSTR (TRANS_TYPE, '|', 1, LEVEL+1)- INSTR (TRANS_TYPE, '|', 1, LEVEL) -1))
                     AS UPLOAD_TYPE
               FROM (SELECT '|--Select--|'||UPLOAD_TYPE||'|' AS TRANS_TYPE FROM HR_PM_STANDARD_UPLOAD WHERE TRIM(UPLOAD_AID) = pUpload_Aid)
               CONNECT BY LEVEL <=LENGTH(TRANS_TYPE)-LENGTH(REPLACE(TRANS_TYPE,'|',''))-1;


     END;
    --Fill the upload type
    PROCEDURE INSERT_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pTrans_Type VARCHAR2,pUploadBatch_Id VARCHAR2)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    BEGIN

        INSERT INTO HR_PM_UPLOAD_STATUS_HD (UPLOAD_BATCH_ID, SESSION_ID, USER_AID, UPLOAD_AID, TRANS_TYPE, UPLOAD_DATE, TOTAL_RECORDS, SUCCESS_RECORDS, FAILED_RECORDS,STATUS)
            SELECT pUploadBatch_Id UPLOAD_BATCH_ID ,pSessionId SESSION_ID, pUSER_AID USER_AID, pUpload_Aid UPLOAD_AID,  pTrans_Type TRANS_TYPE, SYSDATE UPLOAD_DATE,
                COUNT(SESSION_ID) TOTAL_RECORDS, SUM(DECODE(NVL(ERROR_FLAG,'N'),'N',1,0)) SUCCESS_RECORDS, SUM(DECODE(NVL(ERROR_FLAG,'N'),'Y',1,0)) FAILED_RECORDS,'PENDING'
                FROM HR_TEMP_RAW_UPLOAD
            WHERE UPLOAD_BATCH_ID = pUploadBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid;


       EXCEPTION
            WHEN OTHERS THEN
                    HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

    END;
    --Fill the upload type
    PROCEDURE COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pUploadBatch_Id VARCHAR2)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    BEGIN

        IF pOperationType = 'COMMIT_UPLOAD' THEN

             UPDATE HR_PT_FINAL_UPLOAD_DATA SET ERROR_FLAG = 'N', ERROR_MSG='COMMIT'
                WHERE UPLOAD_BATCH_ID = pUploadBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUser_Aid
                    AND UPLOAD_AID = pUpload_Aid AND ERROR_FLAG IS NULL AND ERROR_MSG IS NULL;

             UPDATE HR_PM_UPLOAD_STATUS_HD SET STATUS='COMMIT'
                    WHERE UPLOAD_BATCH_ID = pUploadBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUser_Aid
                        AND UPLOAD_AID = pUpload_Aid AND STATUS = 'PENDING';

        ELSIF pOperationType = 'ROLLBACK_UPLOAD' OR pOperationType = 'CLEANUP_UPLOAD' THEN

             DELETE HR_TEMP_RAW_UPLOAD
                    WHERE  SESSION_ID = pSessionId AND USER_AID = pUser_Aid AND UPLOAD_AID = pUpload_Aid
                    AND UPLOAD_BATCH_ID = pUploadBatch_Id;

             DELETE HR_PT_FINAL_UPLOAD_DATA
                    WHERE  SESSION_ID = pSessionId AND USER_AID = pUser_Aid AND UPLOAD_AID = pUpload_Aid
                    AND UPLOAD_BATCH_ID = pUploadBatch_Id;


             UPDATE HR_PM_UPLOAD_STATUS_HD SET STATUS='ROLLBACK'
                    WHERE UPLOAD_BATCH_ID = pUploadBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUser_Aid
                        AND UPLOAD_AID = pUpload_Aid AND STATUS = 'PENDING';

        END IF;

       EXCEPTION
            WHEN OTHERS THEN
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

    END;
    --Fill the uploaded Summary
    PROCEDURE GET_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                        pUploadBatch_id  VARCHAR2, Return_Recordset OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          HR_PM_STANDARD_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    BEGIN


       OPEN Return_Recordset FOR
        SELECT  TRANS_TYPE TRANS_STATUS_CODE , NULL VIEW_FLAG , NULL EXPORT_FLAG, 'Transaction Type' DESCRIPTION, TRANS_TYPE RECORD_COUNT   FROM HR_PM_UPLOAD_STATUS_HD
            WHERE UPLOAD_BATCH_ID = pUploadBatch_id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
        UNION ALL
        SELECT  'TOTAL' ,'VIEW' VIEW_FLAG , 'EXPORT' EXPORT_FLAG,'Total Records' Description, TOTAL_RECORDS   FROM HR_PM_UPLOAD_STATUS_HD
            WHERE UPLOAD_BATCH_ID = pUploadBatch_id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
        UNION ALL
        SELECT  'SUCCEEDED' ,'VIEW' VIEW_FLAG , 'EXPORT' EXPORT_FLAG,'Success Records' Description,SUCCESS_RECORDS   FROM HR_PM_UPLOAD_STATUS_HD
            WHERE UPLOAD_BATCH_ID = pUploadBatch_id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
        UNION ALL
        SELECT  'FAILED','VIEW' VIEW_FLAG , 'EXPORT' EXPORT_FLAG,'Failed Records' Description,  FAILED_RECORDS   FROM HR_PM_UPLOAD_STATUS_HD
            WHERE UPLOAD_BATCH_ID = pUploadBatch_id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
        UNION ALL
        SELECT  STATUS ,NULL VIEW_FLAG , NULL EXPORT_FLAG, 'Status' Description,   STATUS   FROM HR_PM_UPLOAD_STATUS_HD
            WHERE UPLOAD_BATCH_ID = pUploadBatch_id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid;

       EXCEPTION

            WHEN OTHERS THEN
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_SUMMARY',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END;
    
    --Fill the uploaded Report
    PROCEDURE EXPORT_UPLOAD_DETAIL_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
           pStatus VARCHAR2, pUploadBatch_Id VARCHAR2,Return_Recordset OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          HR_PM_STANDARD_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    vStrQuery                 LONG;
    BEGIN

        OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE FROM HR_PM_STANDARD_UPLOAD
            WHERE    UPLOAD_AID = pUpload_Aid;
        FETCH curRec INTO vUpl_Report_Temp;
        CLOSE curRec;


        vStrQuery :='SELECT DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS, ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',')||
                      ' FROM HR_TEMP_RAW_UPLOAD WHERE SESSION_ID = '''||pSessionId||''' AND USER_AID = '''||pUSER_AID||'''
                            AND UPLOAD_AID = '''||pUpload_Aid||''' AND UPLOAD_BATCH_ID = '''||pUploadBatch_Id||'''' ;

        IF pStatus != 'TOTAL' THEN
            vStrQuery :=  vStrQuery||' AND DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') = '''||pStatus||'''';
        END IF;
        

       OPEN Return_Recordset FOR vStrQuery;


       EXCEPTION
            WHEN OTHERS THEN
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.EXPORT_UPLOAD_DETAIL_REPORT',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END;    
    
    --Fill the uploaded Report
    PROCEDURE GET_UPLOAD_DETAIL_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
           pStatus VARCHAR2, pUploadBatch_Id VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC,Return_FillDrp OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          HR_PM_STANDARD_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    vStrQuery                 LONG;
    VUploadTemp               HR_PM_STANDARD_UPLOAD.UPLOAD_TEMPLATE%TYPE;  
    vSelect                   LONG;
    vFrom                     LONG; 
    vFillDrp                  LONG;   
    vGridPageCount            NUMBER;   
    vGridp                    NUMBER;  
    vEMP_MID_FLAG             varchar2(10);
    vEMP_MID_LOGIC            varchar2(10);
    
    BEGIN

        OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE,UPLOAD_TEMPLATE FROM HR_PM_STANDARD_UPLOAD
            WHERE    UPLOAD_AID = pUpload_Aid;
        FETCH curRec INTO vUpl_Report_Temp,VUploadTemp;
        CLOSE curRec;

        OPEN curRec FOR
             SELECT IS_EMP_CODE_AUTOGENERATED,EMP_CODE_AUTOGENERATED_LOGIC
             FROM GM_COMP WHERE COMP_ID=pComp_Aid;
         FETCH curRec INTO vEMP_MID_FLAG,vEMP_MID_LOGIC;
         CLOSE curRec; 

         IF pUpload_Aid='UP000012' AND vEMP_MID_FLAG='Y' THEN
            VUploadTemp:=REPLACE(VUploadTemp,'EMPLOYEE_CODE|','');
            vUpl_Report_Temp:=REPLACE(vUpl_Report_Temp,'COL2 EMPLOYEE_CODE|','');
         END IF;
        
--        vStrQuery :='SELECT STATUS, "ERROR MESSAGES",'||REPLACE(VUploadTemp,'|',',')||' FROM (SELECT ROWNUM MYROW, DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS, ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',')||
--                      ' FROM HR_TEMP_RAW_UPLOAD WHERE SESSION_ID = '''||pSessionId||''' AND USER_AID = '''||pUSER_AID||'''
--                            AND UPLOAD_AID = '''||pUpload_Aid||''' AND UPLOAD_BATCH_ID = '''||pUploadBatch_Id||'''' ;
       

        vStrQuery :='SELECT ';
        
        vSelect:='DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS, ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',');
        
        vFrom:=' FROM HR_TEMP_RAW_UPLOAD WHERE SESSION_ID = '''||pSessionId||''' AND USER_AID = '''||pUSER_AID||'''
                            AND UPLOAD_AID = '''||pUpload_Aid||''' AND UPLOAD_BATCH_ID = '''||pUploadBatch_Id||'''' ;

        IF pStatus != 'TOTAL' THEN
            vFrom :=  vFrom||' AND DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') = '''||pStatus||'''';
        END IF;
        
        OPEN curRec FOR
            vStrQuery||' COUNT(*) '||vFrom;
        FETCH curRec INTO vGridPageCount;
        CLOSE curRec;    
 
        --Return Page Index count
        OPEN Return_FillDrp FOR
             SELECT LEVEL PAGE_INDEX ,LEVEL|| ' of ' ||CEIL((NVL(vGridPageCount,0))/NVL(pGridPageSize,0)) PAGE_COUNT     
                       FROM DUAL WHERE NVL(vGridPageCount,0)>0  CONNECT BY LEVEL <= CEIL((NVL(vGridPageCount, 0))/NVL(pGridPageSize, 0));
                       
        
        vStrQuery:='SELECT STATUS, "ERROR MESSAGES",'
                    ||REPLACE(VUploadTemp,'|',',')
                    ||' FROM ('||vStrQuery||'ROWNUM MYROW,'||vSelect||vFrom
                    ||' ) WHERE MYROW BETWEEN '||pGridPageIndex||'*'||pGridPageSize||'+1 AND (1+'||pGridPageIndex||')*'||pGridPageSize||' ORDER BY MYROW';
        
        OPEN Return_FillGrid FOR vStrQuery;
       

        EXCEPTION
            WHEN OTHERS THEN
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_DETAIL_REPORT',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END;


    PROCEDURE UPLOAD_GM_GRADE_MSTR(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser                dbms_xmlparser.Parser;
    vXmlDomDocument           dbms_xmldom.DOMDocument;
    vXmlDOMNodeList           dbms_xmldom.DOMNodeList;
    vXmlDOMNode               dbms_xmldom.DOMNode;
    vComp_Aid                 GM_COMP.COMP_ID%TYPE;
    vGrade_Aid                GM_GRADE_MSTR.GRADE_AID%TYPE;
    vBand_Aid                 GM_BAND.BAND_AID%TYPE;

    vCOMP_MID                 GM_COMP.COMP_MID%TYPE;
    vGRADE_MID                GM_GRADE_MSTR.GRADE_MID%TYPE;
    vGRADE_NAME               GM_GRADE_MSTR.GRADE_NAME%TYPE;
    vBAND_MID                 GM_BAND.BAND_MID%TYPE;

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    pGRADE_MID                GM_GRADE_MSTR.GRADE_MID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><GRADE_MID>0001</GRADE_MID><GRADE_NAME>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');



            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                 vERROR_MSG:= NULL;
                 vERROR_FLAG:='N';
                 
                 vComp_Mid:=NULL;vGRADE_MID:=NULL;vGRADE_NAME:=NULL;vBAND_MID:=NULL;vComp_Aid:=NULL;vGrade_Aid:=NULL;vBand_Aid:=NULL;
                 
               BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
               EXCEPTION

                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;


               END;

                 BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'GRADE_CODE/text()',vGRADE_MID);
               EXCEPTION

                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Grade Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Grade Code ';
                  END IF;
                  GOTO PRINT_ERROR;

               END;

                 BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'GRADE_NAME/text()',vGRADE_NAME);
               EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Grade Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Grade Name';
                  END IF;
                  GOTO PRINT_ERROR;

               END;

--               BEGIN
--                  dbms_xslprocessor.valueOf(vXmlDOMNode,'BAND_MID/text()',vBAND_MID);
--               EXCEPTION
--                  WHEN OTHERS THEN
--
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='INVALID VALUE FOR BAND_MID (MAX LIMIT IS 8 CHARACTER)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='INVALID VALUE FOR BAND_MID ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--               END;

              --Get the Comp_Aid

               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


               IF vGRADE_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Grade Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF vGRADE_NAME IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Grade Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


--               IF vBAND_MID IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='BAND MID SHOULD NOT BE BLANK';
--                   GOTO PRINT_ERROR;
--               END IF;

                 IF LENGTH(TRIM(NVL(vCOMP_MID,' ')))=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF LENGTH(TRIM(NVL(vGRADE_MID,' ')))=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Grade Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF LENGTH(TRIM(NVL(vGRADE_NAME,' ')))=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Grade Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               vComp_Aid := HR_PK_VALIDATION.FN_GET_COMP_AID(UPPER(vCOMP_MID));

               IF vComp_Aid IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vGRADE_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Grade Code special character found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vGRADE_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Grade Code space found!';
                     GOTO PRINT_ERROR;
               END IF;

              vGrade_Aid := HR_PK_VALIDATION.FN_GET_GRADE_AID(vComp_Aid,vGRADE_MID);

              IF vGRADE_AID IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Grade Code '||vGRADE_MID||' already exist';
                    GOTO PRINT_ERROR;
              END IF;

              OPEN curRec FOR
                  SELECT GRADE_MID,COUNT(*) 
                    FROM GM_GRADE_MSTR WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Aid)) AND UPPER(TRIM(GRADE_NAME))=UPPER(TRIM(vGRADE_NAME))
                    GROUP BY GRADE_MID;
              FETCH curRec INTO pGRADE_MID,vChkRecordCount;
              CLOSE curRec;   
                

              IF pGRADE_MID<>vGRADE_MID AND vChkRecordCount >0 THEN

               vERROR_FLAG:='Y';
               vERROR_MSG:='Grade Name already exist!';
                GOTO PRINT_ERROR;
             END IF;

             -- Checking duplicate data exist or not
             -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL2)) = UPPER(TRIM(vGRADE_MID));
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate record found !';
                     GOTO PRINT_ERROR;
                 END IF;

                -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL3)) = UPPER(TRIM(vGRADE_NAME))
                            AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vGRADE_NAME))='#NULL');
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate record found!';
                     GOTO PRINT_ERROR;
                 END IF;

               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_GRADE_MSTR
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_AID))  AND UPPER(TRIM(GRADE_MID)) = UPPER(TRIM(vGRADE_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_GRADE_MSTR
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_AID))  AND UPPER(TRIM(GRADE_MID)) = UPPER(TRIM(vGRADE_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

--               IF TRIM(UPPER(vBand_Mid)) IS NOT NULL THEN
--
--                   vBand_Aid  := CASE WHEN TRIM(UPPER(vBand_Mid))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vBand_Mid))
--                                         ELSE HR_PK_VALIDATION.FN_GET_BAND_AID(vComp_Aid, vBand_Mid) END;
--
--                   IF vBand_Aid IS NULL THEN
--                         vERROR_FLAG:='Y';
--                        vERROR_MSG:='BAND MID '||vBand_Mid||' DOES NOT EXIST';
--                        GOTO PRINT_ERROR;
--                   END IF;
--
--               END IF;

               --Get the Grade_Aid
              IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vGrade_Aid  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Aid, 'GM_GRADE_MSTR',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Aid, vGrade_Aid, vGRADE_MID, vGRADE_NAME, vBand_Aid);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3, COL4)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2,UPPER( vComp_Mid), vGRADE_MID, vGRADE_NAME, vBAND_MID);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID, COL2 GRADE_AID, COL3 GRADE_MID, COL4 GRADE_NAME, COL5 BAND_AID,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE,pUser_Aid USER_AT, SYSDATE DATE_AT
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_GRADE_MSTR (GRADE_AID, GRADE_MID, GRADE_NAME, BAND_AID, COMP_AID, CR_USER_ID, CR_DATE, ACTIVE_FLG)
                            VALUES(HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_AID, 'GM_GRADE_MSTR',1), I.GRADE_MID, I.GRADE_NAME, I.BAND_AID , I.COMP_AID, I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_GRADE_MSTR
                    SET GRADE_NAME  = DECODE(TRIM(I.GRADE_NAME),'#NULL',GRADE_NAME,TRIM(I.GRADE_NAME))
                        ,BAND_AID = DECODE(TRIM(I.BAND_AID),'#NULL',BAND_AID,TRIM(I.BAND_AID))
                        ,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                        ,ACTIVE_FLG=1
                        WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(GRADE_MID)) = UPPER(TRIM(I.GRADE_MID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_GRADE_MSTR' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            OPEN Return_Recordset FOR
               SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;


    END;


   PROCEDURE UPLOAD_GM_DEPTS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vDept_Id                GM_DEPTS.DEPT_ID%TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vDEPT_MID               GM_DEPTS.DEPT_MID%TYPE;
    vDEPT_DESC              GM_DEPTS.DEPT_DESC%TYPE;
    vDEPT_SUB_DESC          GM_DEPTS.DEPT_SUB_DESC%TYPE;


    vERROR_MSG              VARCHAR2(2000);
    vERROR_FLAG             VARCHAR2(1);
    vChkRecordCount         NUMBER;
    vUpldBatch_Id           HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    pDEPT_MID               GM_DEPTS.DEPT_MID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vComp_Mid:=NULL;vDEPT_MID:=NULL;vDEPT_DESC:=NULL;vDEPT_SUB_DESC:=NULL;vComp_Id:=NULL;vDept_Id:=NULL;

                BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;

                END;

                BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CODE/text()',vDEPT_MID);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Code';
                  END IF;

                  GOTO PRINT_ERROR;

                END;

                  BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_NAME/text()',vDEPT_DESC);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Name';
                  END IF;

                  GOTO PRINT_ERROR;
                END;

                  BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_SHORT_NAME/text()',vDEPT_SUB_DESC);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Short Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Short Name';
                  END IF;

                  GOTO PRINT_ERROR;
                END;

              --Get the Comp_Aid

                IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF vDEPT_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Department Code should not be blank';
                   GOTO PRINT_ERROR;
              END IF;

              IF vDEPT_DESC IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Department Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF NVL(LENGTH(TRIM(NVL(vDEPT_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Department Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vDEPT_DESC,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Department Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(TRIM(vCOMP_MID));

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vDEPT_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Department Code special character found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vDEPT_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Department Code space  found!';
                     GOTO PRINT_ERROR;
               END IF;

              vDept_Id := HR_PK_VALIDATION.FN_GET_DEPT_AID(vComp_Id,vDEPT_MID);

              IF vDept_Id IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Department Code '||vDEPT_MID||' already exist';
                    GOTO PRINT_ERROR;
              END IF;

             -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

             OPEN curRec FOR
                 SELECT DEPT_MID,COUNT(*) 
                    FROM GM_DEPTS WHERE COMP_ID=vComp_Id AND UPPER(TRIM(DEPT_DESC))=UPPER(TRIM(vDEPT_DESC))
                 GROUP BY DEPT_MID;
             FETCH curRec INTO pDEPT_MID,vChkRecordCount;
             CLOSE curRec; 

               IF pDEPT_MID<>vDEPT_MID AND vChkRecordCount >0 THEN

                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Department Name already exist!';
                    GOTO PRINT_ERROR;
                    
               END IF;

             --END IF;


           -- Checking duplicate data exist or not
          -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
               OPEN curRec FOR
                  SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                   WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL2)) = UPPER(TRIM(vDEPT_MID));
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate Department Code found !';
                     GOTO PRINT_ERROR;
                 END IF;
          -- END IF;

            --  IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL3)) = UPPER(TRIM(vDEPT_DESC))
                            AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vDEPT_DESC))='#NULL');
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate Department Name found!';
                     GOTO PRINT_ERROR;
                 END IF;
          -- END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_DEPTS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(DEPT_MID)) = UPPER(TRIM(vDEPT_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_DEPTS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(DEPT_MID)) = UPPER(TRIM(vDEPT_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount= 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vDept_Id  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_DEPTS',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vDept_Id, vDEPT_MID, vDEPT_DESC,vDEPT_SUB_DESC);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vComp_Mid, vDEPT_MID,vDEPT_DESC,vDEPT_SUB_DESC);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_ID, COL2 DEPT_ID, COL3 DEPT_MID, COL4 DEPT_DESC ,COL5 DEPT_SUB_DESC,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_DEPTS (COMP_ID, DEPT_ID, DEPT_MID, DEPT_DESC,DEPT_SUB_DESC ,CR_USER_ID, CR_DATE, ACTIVE)
                            VALUES(I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_DEPTS',1), I.DEPT_MID, I.DEPT_DESC , I.DEPT_SUB_DESC,I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_DEPTS
                    SET DEPT_DESC  = DECODE(TRIM(I.DEPT_DESC),'#NULL',DEPT_DESC,TRIM(I.DEPT_DESC))
                    ,DEPT_SUB_DESC= DECODE(TRIM(I.DEPT_SUB_DESC),'#NULL',DEPT_SUB_DESC,TRIM(I.DEPT_SUB_DESC))
                    ,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                    ,ACTIVE=1
                    WHERE  UPPER(TRIM(COMP_ID)) = UPPER(TRIM(I.COMP_ID)) AND UPPER(TRIM(DEPT_MID)) = UPPER(TRIM(I.DEPT_MID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

        COMMIT;

       OPEN Return_Recordset FOR
        SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;



       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_DEPTS' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            OPEN Return_Recordset FOR
                SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Data Uploading Unsuccessful' ErrMessage FROM DUAL;


    END;

PROCEDURE UPLOAD_GM_DESIGNATIONS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vDESGN_ID               GM_DESIGNATIONS.DESGN_ID%TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vDESGN_MID              GM_DESIGNATIONS.DESGN_MID%TYPE;
    vDESGN_SUB_DESC         GM_DESIGNATIONS.DESGN_SUB_DESC%TYPE;
    vDESGN_DESC             GM_DESIGNATIONS.DESGN_DESC%TYPE;
    pDESGN_MID              GM_DESIGNATIONS.DESGN_MID%TYPE;

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vComp_Mid:=NULL; vDESGN_MID:=NULL;vDESGN_DESC:=NULL;vDESGN_SUB_DESC:=NULL;vComp_Id:=NULL;vDESGN_ID:=NULL;

                 BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code ';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'DESIGNATION_CODE/text()',vDESGN_MID);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Designation Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Designation Code';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'DESIGNATION_NAME/text()',vDESGN_DESC);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Designation Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Designation Name ';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'DESIGNATION_SHORT_NAME/text()',vDESGN_SUB_DESC);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Designation Short Name (max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Designation Short Name';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF vDESGN_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Designation Code should not be blank';
                   GOTO PRINT_ERROR;
              END IF;

              IF vDESGN_DESC IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Designation Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

             IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vDESGN_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Designation Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vDESGN_DESC,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Designation Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vDESGN_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Invalid Designation Code special character found !';
                 GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vDESGN_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Designation Code space found!';
                     GOTO PRINT_ERROR;
               END IF;


              OPEN curRec FOR
                  SELECT DESGN_MID,COUNT(*) 
                    FROM GM_DESIGNATIONS WHERE COMPANY_ID=vComp_Id AND UPPER(TRIM(DESGN_DESC))=UPPER(TRIM(vDESGN_DESC))
                   GROUP BY DESGN_MID;
              FETCH curRec INTO pDESGN_MID,vChkRecordCount;
              CLOSE curRec;

              IF pDESGN_MID<>vDESGN_MID AND vChkRecordCount >0 THEN

               vERROR_FLAG:='Y';
               vERROR_MSG:='Designation Name already exist!';
                GOTO PRINT_ERROR;
              END IF;
           -- END IF;

              vDESGN_ID := HR_PK_VALIDATION.FN_GET_DESGN_ID(vComp_Id,vDESGN_MID);

              IF vDESGN_ID IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Designation Code '||vDESGN_MID||' already exist';
                    GOTO PRINT_ERROR;
              END IF;

               -- Checking duplicate data exist or not
              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL2)) = UPPER(TRIM(vDESGN_MID));
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate Designation Code found !';
                     GOTO PRINT_ERROR;
                 END IF;
             --  END IF;

                -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL3)) = UPPER(TRIM(vDESGN_DESC))
                            AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vDESGN_DESC))='#NULL');
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate Designation Name found !';
                     GOTO PRINT_ERROR;
                 END IF;
               --  END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                OPEN curRec FOR
                   SELECT COUNT(*) FROM GM_DESIGNATIONS
                        WHERE UPPER(TRIM(COMPANY_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(DESGN_MID)) = UPPER(TRIM(vDESGN_MID));
                 FETCH curRec INTO vChkRecordCount ;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Record already exist!';
                     GOTO PRINT_ERROR;
                 END IF;
               END IF;


               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_DESIGNATIONS
                            WHERE UPPER(TRIM(COMPANY_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(DESGN_MID) )= UPPER(TRIM(vDESGN_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vDESGN_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_DESIGNATIONS',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vDESGN_ID, vDESGN_MID, vDESGN_DESC,vDESGN_SUB_DESC);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vComp_Mid, vDESGN_MID,vDESGN_DESC,vDESGN_SUB_DESC);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMPANY_ID, COL2 DESGN_ID, COL3 DESGN_MID, COL4 DESGN_DESC,COL5 DESGN_SUB_DESC,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_DESIGNATIONS (COMPANY_ID, DESGN_ID, DESGN_MID, DESGN_DESC, DESGN_SUB_DESC,CR_USER_ID, CR_DATE,ACTIVE_FLG)
                            VALUES(I.COMPANY_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMPANY_ID, 'GM_DESIGNATIONS',1), I.DESGN_MID, I.DESGN_DESC ,I.DESGN_SUB_DESC, I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_DESIGNATIONS
                    SET DESGN_DESC  = DECODE(TRIM(I.DESGN_DESC),'#NULL',DESGN_DESC,TRIM(I.DESGN_DESC))
                    ,DESGN_SUB_DESC=DECODE(TRIM(I.DESGN_SUB_DESC),'#NULL',DESGN_SUB_DESC,TRIM(I.DESGN_SUB_DESC))
                    ,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                    ,ACTIVE_FLG=1
                        WHERE  UPPER(TRIM(COMPANY_ID)) = UPPER(TRIM(I.COMPANY_ID)) AND UPPER(TRIM(DESGN_MID)) = UPPER(TRIM(I.DESGN_MID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

        COMMIT;

       OPEN Return_Recordset FOR
       SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;



       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_DESIGNATIONS' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
               SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;




    END;

PROCEDURE UPLOAD_GM_HOLIDAYS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vHOLIDAY_ID             GM_HOLIDAYS.HOLIDAY_ID%TYPE;
    vHOLIDAY_TYPE           GM_HOLIDAYS.HOLIDAY_TYPE%TYPE;
    vIS_HOLI_ACTIVE         VARCHAR2(10);
    vPAR_AID                GM_PARAMETERS.PAR_AID%TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vHOLIDAY_NAME           GM_HOLIDAYS.HOLIDAY_NAME%TYPE;
    vHOLIDAY_DATE           VARCHAR2(20);
    ---vDESGN_DESC         GM_HOLIDAYS.DESGN_DESC%TYPE;
     vLOCATION_MID          GM_LOCATIONS.LOCATION_MID%TYPE;
    vLOCATION_ID            GM_LOCATIONS.LOCATION_ID%TYPE;
    vERROR_MSG              VARCHAR2(2000);
    vERROR_FLAG             VARCHAR2(1);
    vChkRecordCount         NUMBER;
    vUpldBatch_Id           HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    V_NO                    NUMBER;


    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

             V_NO:=0;

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vComp_Mid:=NULL;vLOCATION_MID:=NULL;vHOLIDAY_NAME:=NULL;vHOLIDAY_TYPE:=NULL;vHOLIDAY_DATE:=NULL;vIS_HOLI_ACTIVE:=NULL;
                vComp_Id:=NULL;vHOLIDAY_ID:=NULL;vLOCATION_ID:=NULL;vPAR_AID:=NULL;

                  BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOCATION_MID);
                EXCEPTION
                  WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Location Code (max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Location Code';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'HOLIDAY_NAME/text()',vHOLIDAY_NAME);
                EXCEPTION
                   WHEN OTHERS THEN

                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Holiday Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Holiday Name';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'HOLIDAY_TYPE/text()',vHOLIDAY_TYPE);
                EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Holiday Type (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Holiday Type';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'HOLIDAY_DATE/text()',vHOLIDAY_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Holiday Date should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Holiday Date should be date';
                  END IF;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'IS_HOLIDAY_ACTIVE/text()',vIS_HOLI_ACTIVE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Is Holiday Active (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Is Holiday Active';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                --dbms_xslprocessor.valueOf(vXmlDOMNode,'DESGN_SUB_DESC/text()',vDESGN_SUB_DESC);

                vHOLIDAY_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vHOLIDAY_DATE));



                IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF vLOCATION_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Location Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF vHOLIDAY_NAME IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Holiday Name should not be blank';
                   GOTO PRINT_ERROR;
              END IF;

              IF vHOLIDAY_TYPE IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Holiday Type should not be blank';
                   GOTO PRINT_ERROR;
              END IF;


              IF vHOLIDAY_DATE IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Holiday Date should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vIS_HOLI_ACTIVE IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Is Holiday Active flag should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF NVL(LENGTH(TRIM(NVL(vHOLIDAY_NAME,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Holiday Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

--               IF NVL(LENGTH(TRIM(NVL(vHOLIDAY_DATE,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='HOLIDAY DATE SHOULD NOT BE BLANK';
--                   GOTO PRINT_ERROR;
--               END IF;

              --Get the Comp_Aid
              vChkRecordCount :=HR_PK_VALIDATION.FN_IS_DATE(TRIM(vHOLIDAY_DATE));

                 IF vChkRecordCount =0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Holiday Date!';
                         GOTO PRINT_ERROR;
                END IF;

               IF(LENGTH(TRIM(vIS_HOLI_ACTIVE)) >1) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='invalid flag for Is Holiday Active!';
                 GOTO PRINT_ERROR;
              END IF;

                IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vIS_HOLI_ACTIVE),'YNyn') <>1 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid flag for Is Holiday Active!';
                     GOTO PRINT_ERROR;
               END IF;


            vPAR_AID := HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vHOLIDAY_TYPE);

             IF vPAR_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Holiday Type '||vHOLIDAY_TYPE||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

--               IF LENGTH(TRIM(NVL(vDESGN_MID,' ')))=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='DESG MID should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
               IF (UPPER(TRIM(vLOCATION_MID)) <>'ALL') THEN

               vLOCATION_ID := HR_PK_VALIDATION.FN_GET_LOCATION_ID(vComp_Id,vLOCATION_MID);

                 IF vLOCATION_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Location Code '||vLOCATION_MID||' does not exist';
                    GOTO PRINT_ERROR;
                 END IF;
               ELSE
                  SELECT COUNT(*)  INTO vChkRecordCount FROM GM_LOCATIONS  WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(vComp_Id));
                   IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Location Code not found!';
                         GOTO PRINT_ERROR;
                   ELSE

                     vLOCATION_ID:='ALL';

                   END IF;
               END IF;

               vHOLIDAY_ID := HR_PK_VALIDATION.FN_GET_HOLIDAY_ID(vComp_Id,vHOLIDAY_NAME,vHOLIDAY_DATE ,vLOCATION_ID);

              IF vHOLIDAY_ID IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Holiday Name '||vHOLIDAY_NAME||' for Holiday Date '||vHOLIDAY_DATE||' already exist';
                    GOTO PRINT_ERROR;
              END IF;

               -- Checking duplicate data exist or not
              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND UPPER(TRIM(COL5))=UPPER(TRIM(vHOLIDAY_DATE)) AND UPPER(TRIM(COL2))=UPPER(TRIM(vLOCATION_MID)) ;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;
              --- END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

                  IF(vLOCATION_ID='ALL') THEN

                      OPEN curRec FOR
                            SELECT COUNT(*) FROM GM_HOLIDAYS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))   AND UPPER(TRIM(HOLIDAY_DATE))=UPPER(TRIM(vHOLIDAY_DATE)) ;
                      FETCH curRec INTO vChkRecordCount ;
                      CLOSE  curRec;

                       IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                       END IF;

                  ELSE

                      OPEN curRec FOR
                            SELECT COUNT(*) FROM GM_HOLIDAYS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))   AND UPPER(TRIM(HOLIDAY_DATE))=UPPER(TRIM(vHOLIDAY_DATE)) AND UPPER(TRIM(LOCATION_ID))=UPPER(TRIM(vLOCATION_ID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                      IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                      END IF;

                END IF;
               END IF;

                  IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_HOLIDAYS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))   AND UPPER(TRIM(HOLIDAY_DATE))=UPPER(TRIM(vHOLIDAY_DATE)) AND UPPER(TRIM(LOCATION_ID))=UPPER(TRIM(vLOCATION_ID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               V_NO:=V_NO+1;
               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vHOLIDAY_ID  := HR_PK_VALIDATION.FN_GENERATE_HOLIDAY_ID(vComp_Id,vHOLIDAY_NAME,V_NO);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6,COL7)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id,vHOLIDAY_ID ,vLOCATION_ID ,vHOLIDAY_NAME,vPAR_AID ,vHOLIDAY_DATE,vIS_HOLI_ACTIVE);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vComp_Mid,vLOCATION_MID ,vHOLIDAY_NAME,vHOLIDAY_TYPE,vHOLIDAY_DATE,vIS_HOLI_ACTIVE);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_ID, COL2 HOLIDAY_ID, COL3 LOCATION_ID, COL4 HOLIDAY_NAME,COL5 HOLIDAY_TYPE,COL6 HOLIDAY_DATE ,COL7 IS_HOLI_ACTIVE ,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

               IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                   IF(I.LOCATION_ID='ALL') THEN

                       INSERT INTO GM_HOLIDAYS (COMP_ID, HOLIDAY_ID, LOCATION_ID,HOLIDAY_NAME,HOLIDAY_TYPE ,HOLIDAY_DATE,IS_HOLI_ACTIVE,CR_USER_ID, CR_DATE)
                       SELECT I.COMP_ID  COMP_ID , HR_PK_VALIDATION.FN_GENERATE_HOLIDAY_ID(I.COMP_ID,I.HOLIDAY_NAME,1) HOLIDAY_ID,LOCATION_ID LOCATION_ID,I.HOLIDAY_NAME HOLIDAY_NAME,I.HOLIDAY_TYPE HOLIDAY_TYPE,I.HOLIDAY_DATE HOLIDAY_DATE,I.IS_HOLI_ACTIVE IS_HOLI_ACTIVE,I.CR_USER_ID CR_USER_ID ,I.CR_DATE CR_DATE
                       FROM GM_LOCATIONS  WHERE COMP_ID=I.COMP_ID;
                   ELSE

                    INSERT INTO GM_HOLIDAYS (COMP_ID, HOLIDAY_ID, LOCATION_ID,HOLIDAY_NAME,HOLIDAY_TYPE ,HOLIDAY_DATE,IS_HOLI_ACTIVE,CR_USER_ID, CR_DATE)
                    VALUES(I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_HOLIDAY_ID(I.COMP_ID,I.HOLIDAY_NAME,1), I.LOCATION_ID, I.HOLIDAY_NAME,I.HOLIDAY_TYPE,I.HOLIDAY_DATE ,I.IS_HOLI_ACTIVE ,I.CR_USER_ID, I.CR_DATE);
                  END IF;

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                   IF(UPPER(TRIM(I.LOCATION_ID))<>'ALL') THEN

                    UPDATE GM_HOLIDAYS SET HOLIDAY_NAME  = I.HOLIDAY_NAME,HOLIDAY_TYPE=I.HOLIDAY_TYPE  ,IS_HOLI_ACTIVE=I.IS_HOLI_ACTIVE,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                    WHERE  UPPER(TRIM(COMP_ID)) = UPPER(TRIM(I.COMP_ID)) AND UPPER(TRIM(LOCATION_ID)) = UPPER(TRIM(I.LOCATION_ID))  AND TO_DATE(HOLIDAY_DATE)=TO_DATE(I.HOLIDAY_DATE)    ;
                  ELSE
                     UPDATE GM_HOLIDAYS SET HOLIDAY_NAME  = I.HOLIDAY_NAME,HOLIDAY_TYPE=I.HOLIDAY_TYPE ,IS_HOLI_ACTIVE=I.IS_HOLI_ACTIVE,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                     WHERE  UPPER(TRIM(COMP_ID)) = UPPER(TRIM(I.COMP_ID)) AND  TO_DATE(HOLIDAY_DATE)=TO_DATE(I.HOLIDAY_DATE)   AND LOCATION_ID IN(SELECT LOCATION_ID FROM GM_LOCATIONS WHERE  COMP_ID =I.COMP_ID)    ;
                  END IF;

             END IF;

            END LOOP;

            

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_HOLIDAYS' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;



    END;

PROCEDURE UPLOAD_GM_CITY(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vCITY_CODE              GM_CITY.CITY_CODE%TYPE;
    vCOUNTRY_CODE           GM_COUNTRY.COUNTRY_CODE%TYPE;
    vSTATE_CODE             GM_STATE.STATE_CODE%TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vCITY_MID               GM_CITY.CITY_MID%TYPE;
    vCITY_NAME              GM_CITY.CITY_NAME%TYPE;
    vSTATE_MID              GM_STATE.STATE_MID%TYPE;
    vCOUNTRY_MID            GM_COUNTRY.COUNTRY_MID%TYPE;
    pCITY_MID               GM_CITY.CITY_MID%TYPE;

    ---vDESGN_DESC         GM_CITY.DESGN_DESC%TYPE;


    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    
    vACTIVE_CODE_COUNTRY      VARCHAR2(50);
    vACTIVE_STATE_CODE        VARCHAR2(50);

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCITY_MID:=NULL;vCITY_NAME:=NULL;vSTATE_MID:=NULL;vCOUNTRY_MID:=NULL;vCITY_CODE:=NULL;vSTATE_CODE:=NULL;vCOUNTRY_CODE:=NULL;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'CITY_CODE/text()',vCITY_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for City Code (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for City Code';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                   BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'CITY_NAME/text()',vCITY_NAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for City Name (Max limit is 250 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for City Name';
                  END IF;

                 GOTO PRINT_ERROR;
                END;

                   BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_CODE/text()',vSTATE_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for State Code (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for State Code';
                  END IF;
                  GOTO PRINT_ERROR;

                END;

                   BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COUNTRY_CODE/text()',vCOUNTRY_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Country Code (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Country Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                IF vCITY_NAME IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' City Name should not be blank';
                   GOTO PRINT_ERROR;
                END IF;

                IF vSTATE_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' State Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;

                IF vCOUNTRY_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Country Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;

                IF vCITY_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='City Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;


                IF NVL(LENGTH(TRIM(NVL(vCITY_NAME,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='City Name should not be blank';
                   GOTO PRINT_ERROR;
                END IF;


               IF NVL(LENGTH(TRIM(NVL(vCITY_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='City Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


               IF NVL(LENGTH(TRIM(NVL(vCOUNTRY_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Country Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vSTATE_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='State Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               vChkRecordCount :=HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCITY_MID),'~!@#$%^&*()_+/-=.,');

               IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid City Code special character found !';
                     GOTO PRINT_ERROR;
               END IF;

              vChkRecordCount :=HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCITY_MID),' ');

               IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid City Code space found!';
                         GOTO PRINT_ERROR;
               END IF;

               vCOUNTRY_CODE := CASE WHEN TRIM(UPPER(vCOUNTRY_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                     ELSE HR_PK_VALIDATION.FN_GET_COUNTRY_CODE(vCOUNTRY_MID) END;

               IF vCOUNTRY_CODE IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Country Code '||vCOUNTRY_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;
               
               
               
                --ADDED BY VINAYAK PATIL 
               
                vACTIVE_CODE_COUNTRY := CASE WHEN TRIM(UPPER(vCOUNTRY_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vCOUNTRY_MID))
                                        ELSE HR_PK_VALIDATION.FN_GET_ACTIVE_COUNTRY_CODE(vCOUNTRY_MID) END;
               
               
                IF vACTIVE_CODE_COUNTRY IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Country Code '||vCOUNTRY_MID||' is Inactive in Country Master';
                    GOTO PRINT_ERROR;
                END IF;
                             
               -- END VINAYAK PATIL     
               

               vSTATE_CODE := CASE WHEN TRIM(UPPER(vSTATE_MID))='#NULL' AND pTrans_Type ='UPDATE'  THEN '#NULL'
                                   ELSE HR_PK_VALIDATION.FN_GET_STATE_CODE(vSTATE_MID) END;

                 IF vSTATE_CODE IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='State Code '||vSTATE_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


                 
                vACTIVE_STATE_CODE := CASE WHEN TRIM(UPPER(vSTATE_MID))='#NULL' AND pTrans_Type ='UPDATE'  THEN '#NULL'
                                    ELSE HR_PK_VALIDATION.FN_GET_ACTIVE_STATE_CODE(vSTATE_MID) END;

                 IF vACTIVE_STATE_CODE IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='State Code '||vSTATE_MID||' is Inactive in State Master';
                    GOTO PRINT_ERROR;
                END IF;

               


--               IF LENGTH(TRIM(NVL(vDESGN_MID,' ')))=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='DESG MID should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

              vCITY_CODE := HR_PK_VALIDATION.FN_GET_CITY_CODE(vCITY_MID);

              IF vCITY_CODE IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='City Code '||vCITY_MID||' already exists';
                    GOTO PRINT_ERROR;
              END IF;

             -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

               OPEN curRec FOR
               SELECT CITY_MID,COUNT(*) 
                    FROM GM_CITY WHERE  UPPER(TRIM(CITY_NAME))=UPPER(TRIM(vCITY_NAME))
                    GROUP BY CITY_MID;
               FETCH curRec INTO pCITY_MID,vChkRecordCount;
               CLOSE curRec;

               IF pCITY_MID<>vCITY_MID AND vChkRecordCount >0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='City Name already exists!';
                    GOTO PRINT_ERROR;
               END IF;

              --END IF;

               -- Checking duplicate data exist or not
              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCITY_MID ));
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate record found!';
                     GOTO PRINT_ERROR;
                 END IF;
            --   END IF;

               --    IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL2)) = UPPER(TRIM(vCITY_NAME)) ;
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate record found!';
                     GOTO PRINT_ERROR;
                 END IF;
              -- END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_CITY
                            WHERE UPPER(TRIM(CITY_MID)) = UPPER(TRIM(vCITY_MID))  ;
                           -- AND CITY_NAME = vCITY_NAME ;
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

                  IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_CITY
                            WHERE UPPER(TRIM(CITY_MID)) = UPPER(TRIM(vCITY_MID))  ;
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     ELSE
                      vCITY_CODE:= HR_PK_VALIDATION.FN_GET_CITY_CODE(vCITY_MID);

                     END IF;
               END IF;

               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vCITY_CODE  := HR_PK_VALIDATION.FN_GENERATE_AID('', 'GM_CITY',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vCITY_CODE,vCITY_MID ,vSTATE_CODE, vCOUNTRY_CODE,vCITY_NAME);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vCITY_MID, vCITY_NAME,vSTATE_MID,vCOUNTRY_MID);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 CITY_CODE, COL2 CITY_MID, COL3 STATE_CODE, COL4 COUNTRY_CODE,COL5 CITY_NAME,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_CITY (CITY_CODE, CITY_MID, STATE_CODE, COUNTRY_CODE,CR_USER_ID, CR_DATE,CITY_NAME, ACTIVE_FLG)
                            VALUES(HR_PK_VALIDATION.FN_GENERATE_AID('', 'GM_CITY',1), I.CITY_MID, I.STATE_CODE, I.COUNTRY_CODE , I.CR_USER_ID, I.CR_DATE,I.CITY_NAME,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_CITY
                    SET CITY_NAME=DECODE(TRIM(I.CITY_NAME),'#NULL',CITY_NAME,TRIM(I.CITY_NAME))
                        ,STATE_CODE=DECODE(TRIM(I.STATE_CODE),'#NULL',STATE_CODE,TRIM(I.STATE_CODE))
                        ,COUNTRY_CODE=DECODE(TRIM(I.COUNTRY_CODE),'#NULL',COUNTRY_CODE,TRIM(I.COUNTRY_CODE))
                        ,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                        ,ACTIVE_FLG=1
                        WHERE  UPPER(TRIM(CITY_MID)) = UPPER(TRIM(I.CITY_MID)) ;
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_CITY' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;


    END;



  PROCEDURE UPLOAD_GM_STATE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vSTATE_CODE             GM_STATE.STATE_CODE%TYPE;
    vCOUNTRY_MID            GM_COUNTRY.COUNTRY_MID%TYPE;
    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vSTATE_MID              GM_STATE.STATE_MID%TYPE;
    vSTATE_NAME             GM_STATE.STATE_NAME%TYPE;
    ---vDESGN_DESC          GM_STATE.DESGN_DESC%TYPE;
    vCOUNTRY_CODE           GM_COUNTRY.COUNTRY_CODE%TYPE;
    pSTATE_MID              GM_STATE.STATE_MID%TYPE;

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    VUPLDBATCH_ID             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%type;
    vPROF_TAX_FLAG            GM_STATE.PT_ON_ANNUAL_SALARY%TYPE;
    vACTIVE_CODE_COUNTRY      VARCHAR2(20);   
    
    vSRNO                     NUMBER;  
    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
                
                vSTATE_MID:=NULL;vSTATE_NAME:=NULL;vCOUNTRY_MID:=NULL;vPROF_TAX_FLAG:=NULL;vSTATE_CODE:=NULL;vCOUNTRY_CODE:=NULL;

                dbms_xslprocessor.valueOf(vXmlDOMNode,'COUNTRY_CODE/text()',vCOUNTRY_MID);
                dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_CODE/text()',vSTATE_MID);
                dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_NAME/text()',vSTATE_NAME);
                dbms_xslprocessor.valueOf(vXmlDOMNode,'PT_APPLICABLE/text()',vPROF_TAX_FLAG);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';

              --Get the Comp_Aid
--               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);
--
--               IF vComp_Id IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;

               IF NVL(LENGTH(TRIM(NVL(vSTATE_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='State Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF NVL(LENGTH(TRIM(NVL(vSTATE_NAME,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='State Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOUNTRY_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Country Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
               if NVL(UPPER(VPROF_TAX_FLAG),'X') not in ('Y','N') and not (PTRANS_TYPE ='UPDATE' and TRIM(UPPER(VPROF_TAX_FLAG))='#NULL') then
                    VERROR_FLAG:='Y';
                    vERROR_MSG:='PT Applicable field should not be blank  Y or N only';
                    GOTO PRINT_ERROR;
               END IF;
               
               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSTATE_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Invalid State Code special character found!';
                 GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSTATE_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid State Code space found !';
                     GOTO PRINT_ERROR;
               END IF;

               vCOUNTRY_CODE := CASE WHEN TRIM(UPPER(vCOUNTRY_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vCOUNTRY_MID))
                                        ELSE HR_PK_VALIDATION.FN_GET_COUNTRY_CODE(vCOUNTRY_MID) END;
                                        
              IF vCOUNTRY_CODE IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Country Code '||vCOUNTRY_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;                                        
                                        
               --ADDED BY VINAYAK PATIL 
               
                vACTIVE_CODE_COUNTRY := CASE WHEN TRIM(UPPER(vCOUNTRY_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vCOUNTRY_MID))
                                        ELSE HR_PK_VALIDATION.FN_GET_ACTIVE_COUNTRY_CODE(vCOUNTRY_MID) END;
               
                IF vACTIVE_CODE_COUNTRY IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Country Code '||vCOUNTRY_MID||' is Inactive in Country Master';
                    GOTO PRINT_ERROR;
                END IF;

               -- END VINAYAK PATIL                                                             

               

--               SELECT COUNT(*) INTO vChkRecordCount FROM T_STATE_VALIDATE WHERE UPPER(TRIM(STATE))= UPPER(TRIM(vSTATE_NAME));
--
--
--               IF vChkRecordCount = 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='INVALID STATE !';
--                         GOTO PRINT_ERROR;
--               END IF;

--               IF LENGTH(TRIM(NVL(vDESGN_MID,' ')))=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='DESG MID should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

              IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                vSTATE_CODE := HR_PK_VALIDATION.FN_GET_STATE_CODE(vSTATE_MID);  
                IF vSTATE_CODE IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='State Code '||vSTATE_MID||' already exist';
                      GOTO PRINT_ERROR;
                END IF;  
               END IF;

            -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
            
             OPEN curRec FOR
               SELECT STATE_MID,COUNT(*)  FROM GM_STATE WHERE  UPPER(TRIM(STATE_NAME))=UPPER(TRIM(vSTATE_NAME))
               group by STATE_MID;
             FETCH curRec INTO pSTATE_MID,vChkRecordCount;
             CLOSE curRec;
              IF NVL(pSTATE_MID,'X')<>vSTATE_MID AND vChkRecordCount >0 THEN
                vERROR_FLAG:='Y';
                vERROR_MSG:='State Name already exist!';
                GOTO PRINT_ERROR;
              END IF;

               -- Checking duplicate data exist or not
              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL2)) = UPPER(TRIM(vSTATE_MID));
                     FETCH curRec INTO vChkRecordCount;
                     close  CURREC;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate State Code found !';
                         GOTO PRINT_ERROR;
                     END IF;
            --   END IF;


                --   IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL3)) = UPPER(TRIM(vSTATE_NAME))
                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vSTATE_NAME))='#NULL');
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate State Name Found !';
                         GOTO PRINT_ERROR;
                     END IF;
            --   END IF;


               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_STATE
                            WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID))   ;
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

                IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_STATE
                            WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID))   ;
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;

                     ELSE
                     vSTATE_CODE  := HR_PK_VALIDATION.FN_GET_STATE_CODE(vSTATE_MID);

                     END IF;
               END IF;

               --Get the State_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vSTATE_CODE  := HR_PK_VALIDATION.FN_GENERATE_AID('', 'GM_STATE',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, 
                    ROW_NO, COL1, COL2, COL3, COL4, COL5)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE 
                    , I+2, vSTATE_CODE, vSTATE_MID, vSTATE_NAME,vCOUNTRY_CODE,vPROF_TAX_FLAG);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3, COL4)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, 
--                        vSTATE_MID, vSTATE_NAME,vCOUNTRY_MID,vPROF_TAX_FLAG);
                        vCOUNTRY_MID,vSTATE_MID, vSTATE_NAME,vPROF_TAX_FLAG);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE
            vSRNO:=0;
            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 STATE_CODE, COL2 STATE_MID, COL3 STATE_NAME, COL4 COUNTRY_CODE,COL5 PROF_TAX_FLAG,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP
                
                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN
                    --Get the State_Aid
                  vSTATE_CODE:=null;
                  
                        vSTATE_CODE  := HR_PK_VALIDATION.FN_GENERATE_AID('', 'GM_STATE',vSRNO+1);
                   

                    INSERT INTO GM_STATE (STATE_CODE, STATE_MID, STATE_NAME, COUNTRY_CODE,PT_ON_ANNUAL_SALARY,CR_USER_ID, CR_DATE,ACTIVE_FLG)
                            VALUES(vSTATE_CODE, I.STATE_MID, I.STATE_NAME, I.COUNTRY_CODE, I.PROF_TAX_FLAG, I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_STATE
                    SET STATE_NAME = DECODE(TRIM(I.STATE_NAME),'#NULL',STATE_NAME,TRIM(I.STATE_NAME))
                    ,COUNTRY_CODE=DECODE(TRIM(I.COUNTRY_CODE),'#NULL',COUNTRY_CODE,TRIM(I.COUNTRY_CODE))
                    ,PT_ON_ANNUAL_SALARY=DECODE(TRIM(I.PROF_TAX_FLAG),'#NULL',PT_ON_ANNUAL_SALARY,TRIM(I.PROF_TAX_FLAG))
                    ,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                    ,ACTIVE_FLG=1
                        WHERE  UPPER(TRIM(STATE_MID))=UPPER(TRIM(I.STATE_MID ));
                END IF;
                vSRNO:=vSRNO+1;
            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

       OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_STATE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

    END;

PROCEDURE UPLOAD_GM_BRANCH(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vBR_AID                 GM_BRANCH.BR_AID%TYPE;
    vLOCATION_ID            GM_LOCATIONS.LOCATION_ID%TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vLOCATION_MID           GM_LOCATIONS.LOCATION_MID%TYPE;
    vBR_MID                 GM_BRANCH.BR_MID%TYPE;
    vBR_NAME                GM_BRANCH.BR_NAME%TYPE;
    vBR_ADDR                GM_BRANCH.BR_ADDR%TYPE;
    vBR_TEL                 GM_BRANCH.BR_TEL %TYPE;
    --vDESGN_DESC         GM_BRANCH.DESGN_DESC%TYPE;
    pBR_MID                 GM_BRANCH.BR_MID%TYPE;


    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    vSRNO                     NUMBER;   

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCOMP_MID:=NULL;vLOCATION_MID:=NULL;vBR_MID:=NULL;vBR_NAME:=NULL;vBR_ADDR:=NULL;vBR_TEL:=NULL;vComp_Id:=NULL;vBR_AID:=NULL;vLOCATION_ID:=NULL;

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                      dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOCATION_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Location Code (max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Location Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BRANCH_CODE/text()',vBR_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Branch Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Branch Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BRANCH_NAME/text()',vBR_NAME);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Branch Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Branch Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                      dbms_xslprocessor.valueOf(vXmlDOMNode,'BRANCH_ADDRESS/text()',vBR_ADDR);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Branch Address (Max limit is 500 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Branch Address';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BRANCH_TELEPHONE_NO/text()',vBR_TEL);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Branch Telephone No';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Branch Telephone No ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

              IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vLOCATION_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Location Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
               IF NVL(LENGTH(TRIM(NVL(vBR_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Branch Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vBR_NAME,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Branch Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vBR_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Invalid Branch Code special character found!';
                 GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vBR_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Branch Code space found!';
                     GOTO PRINT_ERROR;
               END IF;

--                vCOUNTRY_CODE := CASE WHEN TRIM(UPPER(vCOUNTRY_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                     ELSE HR_PK_VALIDATION.FN_GET_COUNTRY_CODE(vCOUNTRY_MID) END;

               IF vBR_TEL IS NOT NULL AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vBR_TEL))='#NULL') THEN

                 vChkRecordCount :=HR_PK_VALIDATION.FN_VAL_BRANCH_TELL(TRIM(vBR_TEL));

                 IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Branch Telephone No!';
                         GOTO PRINT_ERROR;
                 END IF;

              END IF;
              
              vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);
               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

              vLOCATION_ID :=  CASE WHEN TRIM(UPPER(vLOCATION_MID))='#NULL' AND pTrans_Type ='UPDATE'  THEN '#NULL'
                                    ELSE HR_PK_VALIDATION.FN_GET_LOCATION_ID(vComp_Id,vLOCATION_MID) END;

               IF vLOCATION_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Location Code '||vLOCATION_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

              vBR_AID:= HR_PK_VALIDATION.FN_GET_BRANCH_ID(vComp_Id,vBR_MID);
               IF ((vBR_AID IS NOT NULL) AND (pTrans_Type IN ('ADD','REMOVE AND ADD') )  )  THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Branch Code '||vBR_MID||' already exist';
                    GOTO PRINT_ERROR;
               end if;

            -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
               OPEN curRec FOR 
                SELECT BR_MID,COUNT(*) 
                    FROM GM_BRANCH WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Id)) AND UPPER(TRIM(BR_NAME))=UPPER(TRIM(vBR_NAME))
                    GROUP BY BR_MID;
               FETCH curRec INTO pBR_MID,vChkRecordCount;
               CLOSE curRec;
               
              IF pBR_MID<>vBR_MID AND vChkRecordCount >0  THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='Branch Name already exist!';
                GOTO PRINT_ERROR;                
              END IF;

--              IF vChkRecordCount >0 AND pTrans_Type <> 'UPDATE' THEN

--               vERROR_FLAG:='Y';
--               vERROR_MSG:='Branch Name already exist!';
--                GOTO PRINT_ERROR;
--             END IF;
             --END IF;
--               IF LENGTH(TRIM(NVL(vDESGN_MID,' ')))=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='DESG MID should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

               -- Checking duplicate data exist or not
              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL3))=UPPER(TRIM(vBR_MID)) ;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found!';
                         GOTO PRINT_ERROR;
                     END IF;
             --  END IF;

             -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL4))=UPPER(TRIM(vBR_NAME))
                                AND NOT (pTrans_Type = 'UPDATE' AND UPPER(TRIM(vBR_NAME))='#NULL' );
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Branch Name found!';
                         GOTO PRINT_ERROR;
                     END IF;
              -- END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_BRANCH
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(BR_MID)) = UPPER(TRIM(vBR_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

              IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_BRANCH
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(BR_MID)) = UPPER(TRIM(vBR_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               --Get the Branch_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    
                    vBR_AID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_BRANCH',I+1);
                    
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6,COL7)
                   VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vBR_AID, vBR_MID, vLOCATION_ID,vBR_NAME,vBR_ADDR,vBR_TEL);
               END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, 
                        vCOMP_MID, vLOCATION_MID,vBR_MID,vBR_NAME,vBR_ADDR,vBR_TEL);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID, COL2 BR_AID, COL3 BR_MID, COL4 LOC_AID,COL5 BR_NAME,COL6 BR_ADDR,COL7 BR_TEL,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN
                 
                  
                        
                    INSERT INTO GM_BRANCH (COMP_AID, BR_AID, BR_MID, LOC_AID,BR_NAME, BR_ADDR ,BR_TEL,USER_CR,DATE_CR,ACTIVE_FLG)
                            VALUES(I.COMP_AID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_AID, 'GM_BRANCH',1), I.BR_MID, I.LOC_AID ,I.BR_NAME,I.BR_ADDR,I.BR_TEL ,I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_BRANCH SET
                     LOC_AID=I.LOC_AID ,
                     BR_NAME=DECODE(TRIM(I.BR_NAME),'#NULL',BR_NAME,TRIM(I.BR_NAME)),
                     BR_ADDR=DECODE(TRIM(I.BR_ADDR),'#NULL',BR_ADDR,TRIM(I.BR_ADDR)),
                     BR_TEL=DECODE(TRIM(I.BR_TEL),'#NULL',BR_TEL,TRIM(I.BR_TEL)),
                     USER_UP = I.UP_USER_ID,
                     DATE_UP = I.UP_DATE,
                     ACTIVE_FLG=1
                     WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(BR_MID)) = UPPER(TRIM(I.BR_MID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

       OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_BRANCH' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           select 1 STATUS,VUPLDBATCH_ID UPLOAD_BATCH_ID,'Commit Failed!' ERRMESSAGE from DUAL;
    END;


PROCEDURE UPLOAD_GM_COST_CENTER(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vCOST_CENTER_ID         GM_COST_CENTER.COST_CENTER_ID%TYPE;
    vDEPT_ID                GM_DEPTS.DEPT_ID%TYPE;
    vEMP_ID                 VARCHAR2(8);

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vDEPT_MID               GM_DEPTS.DEPT_MID%TYPE;
    vCOST_CODE              GM_COST_CENTER.COST_CODE%TYPE;
    vCOST_DESC              GM_COST_CENTER.COST_DESC%TYPE;
    vCC_HEAD                GM_COST_CENTER.CC_HEAD%TYPE;
    ---vDESGN_DESC         GM_BRANCH.DESGN_DESC%TYPE;
    pCOST_CODE              GM_COST_CENTER.COST_CODE%TYPE;


    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                VCOMP_MID:=null;  VCOST_CODE:=null;
                vCOST_DESC:=NULL; vDEPT_MID:=NULL; vCC_HEAD:=NULL;vComp_Id:=NULL;vCOST_CENTER_ID:=NULL;vDEPT_ID:=NULL;vEMP_ID:=NULL;

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for COMPANY_CODE (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COST_CENTER_CODE/text()',vCOST_CODE);
                EXCEPTION
                  WHEN OTHERS THEN
                 IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Cost Center Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Cost Center Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COST_CENTER_DESCRIPTION/text()',vCOST_DESC);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Cost Center Description (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Cost Center Description';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CODE/text()',vDEPT_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COST_CENTER_HEAD/text()',vCC_HEAD);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

              IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOST_CODE,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Cost Center Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               --Commented By Vishal Kute Sep 17 2012.
--               IF NVL(LENGTH(TRIM(NVL(vDEPT_MID,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:=' DEPT MID SHOULD NOT BE BLANK';
--                   GOTO PRINT_ERROR;
--               END IF;

--
               IF NVL(LENGTH(TRIM(NVL(vCOST_DESC,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Cost Center Description should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               --Commented By Vishal Kute Sep 17 2012.
--                IF NVL(LENGTH(TRIM(NVL(vDEPT_MID,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:=' DEPT MID SHOULD NOT BE BLANK';
--                   GOTO PRINT_ERROR;
--               END IF;

              vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOST_CODE),'~!@#$%^&*()_+/-=.,') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Cost Center Code special character found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOST_CODE),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Cost Center Code space found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF(vDEPT_MID) IS NOT NULL THEN

                   vDEPT_ID := CASE WHEN TRIM(UPPER(vDEPT_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vDEPT_MID))
                                    ELSE HR_PK_VALIDATION.FN_GET_DEPT_AID(vComp_Id,vDEPT_MID) END;

                   IF vDEPT_ID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Department Code '||vDEPT_MID||' does not exist';
                        GOTO PRINT_ERROR;
                   END IF;
               END IF;

              IF vCC_HEAD IS NOT NULL THEN

               vEMP_ID := CASE WHEN TRIM(UPPER(vCC_HEAD))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vCC_HEAD))
                                ELSE HR_PK_VALIDATION.FN_GET_EMP_AID(  vComp_Id,vCC_HEAD) END;


                 IF vEMP_ID IS NULL THEN
                     VERROR_FLAG:='Y';
                     vERROR_MSG:='Cost Center Head '||vCC_HEAD||' does not exist';
                     GOTO PRINT_ERROR;
                 END IF;

              END IF;

             --IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
              OPEN curRec FOR
                  SELECT COST_CODE,COUNT(*) 
                    FROM GM_COST_CENTER WHERE UPPER(TRIM(COMP_CODE))=UPPER(TRIM(vComp_Id)) AND UPPER(TRIM(COST_DESC))=UPPER(TRIM(vCOST_DESC))
                  GROUP BY COST_CODE;
              FETCH curRec INTO pCOST_CODE,vChkRecordCount;
              CLOSE curRec; 

             IF pCOST_CODE<>vCOST_CODE AND vChkRecordCount >0 THEN

               vERROR_FLAG:='Y';
               vERROR_MSG:='Cost Centre Description already exist!';
               GOTO PRINT_ERROR;
             END IF;

               -- Checking duplicate data exist or not
           --    IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vCOST_CODE)) ;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;

                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL3))=UPPER(TRIM(vCOST_DESC))
                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCOST_DESC))='#NULL');
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Cost Center Description Found !';
                         GOTO PRINT_ERROR;
                     END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_COST_CENTER
                            WHERE UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(vCOST_CODE));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


                 IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_COST_CENTER
                            WHERE UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(vCOST_CODE));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vCOST_CENTER_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_COST_CENTER',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6)
                   VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vCOST_CENTER_ID, vCOST_CODE, vCOST_DESC,vDEPT_ID,vEMP_ID);                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vCOMP_MID, vCOST_CODE,vCOST_DESC,vDEPT_MID,vCC_HEAD);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_CODE, COL2 COST_CENTER_ID, COL3 COST_CODE, COL4 COST_DESC,COL5 DEPT_ID,COL6 CC_HEAD,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_COST_CENTER (COMP_CODE, COST_CENTER_ID, COST_CODE, COST_DESC,DEPT_ID,CC_HEAD,USER_CR,DATE_CR,ACTIVE_FLAG)
                            VALUES(I.COMP_CODE, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_CODE,'GM_COST_CENTER',1), I.COST_CODE, I.COST_DESC ,I.DEPT_ID,I.CC_HEAD ,I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_COST_CENTER
                    SET COST_DESC=DECODE(TRIM(I.COST_DESC),'#NULL',COST_DESC,TRIM(I.COST_DESC))
                    ,DEPT_ID= DECODE(TRIM(I.DEPT_ID),'#NULL',DEPT_ID,TRIM(I.DEPT_ID))
                    ,CC_HEAD=DECODE(TRIM(i.CC_HEAD),'#NULL',i.CC_HEAD,TRIM(i.CC_HEAD))
                    ,USER_CR = I.UP_USER_ID, DATE_CR = I.UP_DATE
                    ,ACTIVE_FLAG=1
                    WHERE  UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(I.COMP_CODE)) AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(I.COST_CODE));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_COST_CENTER' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;
    
    
    PROCEDURE UPLOAD_GM_EMP(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
                            pUpload_Aid VARCHAR2, pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                VARCHAR2(100);
    vDESG_ID                VARCHAR2(100);
    vEMP_ID                 VARCHAR2(100);

    vCOMP_MID               VARCHAR2(100);
    vEMP_MID                VARCHAR2(100);
    vEMP_MID_FLAG           VARCHAR2(100);/* Added By Vishal Kute for Employee Mid Login / Validation*/
    vEMP_MID_LOGIC          VARCHAR2(100);/* Added By Vishal Kute for Employee Mid Login / Validation*/
    vEMP_FNAME              VARCHAR2(100);
    vEMP_MNAME              VARCHAR2(100);
     VEMP_LNAME             VARCHAR2(100);
     VEMP_NAME              VARCHAR2(100);
     vEMP_FATHNAME          VARCHAR2(100);
     vEMP_GENDER            VARCHAR2(100);
     vCORRS_MAIL1           VARCHAR2(100);
     vBIRTH_DATE            VARCHAR2(100);--GM_EMP.BIRTH_DATE%TYPE;
     vJOIN_DATE              VARCHAR2(100);--GM_EMP.JOIN_DATE%TYPE;
     vCONFIRMATION_DATE      VARCHAR2(100);--GM_EMP.CONFIRMATION_DATE%TYPE;
     vLEAVE_DATE            VARCHAR2(100);--GM_EMP.CONFIRMATION_DATE%TYPE;
     vDESG_MID              VARCHAR2(100);
    ---vDESGN_DESC         GM_EMP.DESGN_DESC%TYPE;
    vDEPT_MID                VARCHAR2(100);
    vLOC_MID                 VARCHAR2(100);
    vGRADE_MID               VARCHAR2(100);
    vBAND_MID                VARCHAR2(100);
    vCOSTCENTER_MID          VARCHAR2(100);
    vESIC_NO                 VARCHAR2(50);
    vPF_NO                   VARCHAR2(50);
    vNO_OF_CHILDRENS         VARCHAR2(10);

    vBANK_MID                VARCHAR2(100);
    vBANK_ACC_NO             VARCHAR2(100);
    vREIMB_BANK_MID          VARCHAR2(100);
    vREIMB_ACC_NO            VARCHAR2(100);
    vVALID_ACC               NUMBER(10);
    vACC_NO_SIZE             VARCHAR2(100);
    vVALID_REIMB_ACC          NUMBER(10);
    vREIMB_ACC_NO_SIZE       VARCHAR2(100);
    vBANK_AID                VARCHAR2(100);
    vREIMB_BANK_AID          VARCHAR2(100);

    vCur_Bank_Aid           VARCHAR2(100);
    vCur_Reimb_Bank_Aid     VARCHAR2(100);
    vCur_CUR_BIRTH_DATE     DATE;
    vCur_LEAVE_DATE         DATE;
    vCur_CONFIRMATION_DATE   DATE;
    vCur_JOIN_DATE          DATE;

    vESIC                    VARCHAR2(100);
    vPAN_NO                  VARCHAR2(100);
    vPF_FLAG                 VARCHAR2(100);--GM_EMP.PF_FLAG%type;
    vBR_AID                  VARCHAR2(100);
    vDEPT_ID                 VARCHAR2(100);
    vLOCATION_ID             VARCHAR2(100);
    vBR_MID                  VARCHAR2(100);
    vHANDICAP                VARCHAR2(100);
    vERROR_MSG               VARCHAR2(2000);
    vERROR_FLAG              VARCHAR2(1);
    vChkRecordCount          NUMBER;
    vUpldBatch_Id            VARCHAR2(100);
    vSR_NO                   NUMBER;
    vPAN_ERROR               VARCHAR2(2000);
    vGRADE_ID                VARCHAR2(100);
    vBAND_ID                 VARCHAR2(100);
    vCC_ID                   VARCHAR2(100); 
    vMGMT_CAT                VARCHAR2(15);
    vDEPT_CAT                VARCHAR2(15);
    vMGMT_CAT_ID             VARCHAR2(10);
    vDEPT_CAT_ID             VARCHAR2(8);
    vSUB_DEPT_ID             VARCHAR2(8);
    vSUB_DEPT_MID            VARCHAR2(8);
    vPF_CAL_TYPE             VARCHAR2(8);
    vPF_CAL_ID               VARCHAR2(100);
    vUAN_NO                  VARCHAR2(20);
    vAADHAR_NO               VARCHAR2(20);
    vIFSC_CODE               VARCHAR2(20);
    vACTUAL_QUIT_DATE        VARCHAR2(100);
    vFNF_SETTLEMENT_DATE     VARCHAR2(100); 
    vAct_Quit_Date           date;
    vFNF_SETTL_DATE          date;
    vAge                     NUMBER(18,2); 
    BEGIN
    
        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCOMP_MID :=NULL; vEMP_MID:=NULL;vEMP_FNAME:=NULL;vEMP_MNAME:=NULL;vEMP_LNAME:=NULL;vEMP_NAME:=NULL;vEMP_GENDER:=NULL;vCORRS_MAIL1:=NULL;
                vBIRTH_DATE:=NULL;vCONFIRMATION_DATE:=NULL;vJOIN_DATE:=NULL;vDESG_MID:=NULL;vBR_MID:=NULL;vDEPT_MID:=NULL;vLOC_MID:=NULL;vGRADE_MID:=NULL;
                vBAND_MID:=NULL;vCOSTCENTER_MID:=NULL;vESIC:=NULL;vESIC_NO:=NULL;vHANDICAP:=NULL;vPAN_NO:=NULL;vPF_FLAG:=NULL;vPF_NO:=NULL;vBANK_MID:=NULL;
                vBANK_ACC_NO:=NULL;vREIMB_BANK_MID:=NULL;vREIMB_ACC_NO:=NULL;vLEAVE_DATE:=NULL;vNO_OF_CHILDRENS:=NULL;
                
                vComp_Id:=NULL; vEMP_ID:=NULL;vDESG_ID:=NULL;vBR_AID:=NULL;vDEPT_ID:=NULL;vLOCATION_ID:=NULL;vGRADE_ID:=NULL;vBAND_ID:=NULL;vCC_ID:=NULL;
                vBANK_AID:=NULL;vBANK_ACC_NO:=NULL;vREIMB_BANK_AID:=NULL;vMGMT_CAT :=NULL;vDEPT_CAT :=NULL;vSUB_DEPT_MID :=NULL;
                vMGMT_CAT_ID :=NULL;vMGMT_CAT_ID :=NULL;vSUB_DEPT_ID :=NULL;
                
                vESIC_NO :=NULL ; vPF_NO :=NULL;
                vUAN_NO :=NULL; vAADHAR_NO :=NULL; vIFSC_CODE :=NULL; vACTUAL_QUIT_DATE :=NULL; vFNF_SETTLEMENT_DATE :=NULL; 

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                /****** Added by Vishal Kute 12-Nov-2013*******/
                 /* EMPLOYEE CODE VALIDATION  added by Vishal Kute*/
                  OPEN CURREC FOR
                     SELECT IS_EMP_CODE_AUTOGENERATED,EMP_CODE_AUTOGENERATED_LOGIC
                     FROM GM_COMP WHERE COMP_ID=pComp_Aid;
                  FETCH CURREC INTO vEMP_MID_FLAG,vEMP_MID_LOGIC;
                  CLOSE CURREC;
              
                  IF VEMP_MID_FLAG IS NULL THEN
                     VERROR_FLAG:='Y';
                     vERROR_MSG:='Set Employee Code Auto Generate or Auto Generate Not flag in Company Master';
                     GOTO PRINT_ERROR;
                  END IF;
                  
                /*********************************************/
                
                /****** Added by Vishal Kute 12-Nov-2013*******/
                IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    IF VEMP_MID_FLAG = 'N'  THEN
                        BEGIN
                          dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
                        EXCEPTION
                          WHEN OTHERS THEN
                          IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                            vERROR_FLAG:='Y';
                          ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Employee Code';
                          END IF;
                          GOTO PRINT_ERROR;
                        END;
                    ELSIF VEMP_MID_FLAG = 'Y' THEN    
                      IF VEMP_MID_LOGIC IS NOT NULL THEN
                          VEMP_MID := HR_PK_VALIDATION.GET_EMPLOYEE_CODE_NEWLY(pComp_Aid, VEMP_MID_LOGIC,I+1);
                      
                      ELSE
                         VERROR_FLAG:='Y';
                         VERROR_MSG:='Set Employee Auto Generate Logic in Company Master';
                         GOTO PRINT_ERROR;
                      END IF;
                  END IF;
                  
                ELSIF pTrans_Type = 'UPDATE' THEN
                    BEGIN
                          dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
                        EXCEPTION
                          WHEN OTHERS THEN
                         IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                            vERROR_FLAG:='Y';
                         ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Employee Code';
                         END IF;
                          GOTO PRINT_ERROR;
                     END;
                 END IF;
                 
                
                /*********************************************/
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'FIRST_NAME/text()',vEMP_FNAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee First Name (max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee First Name ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'MIDDLE_NAME/text()',vEMP_MNAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Middle Name (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Middle Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'LAST_NAME/text()',vEMP_LNAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Last Name (max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Last Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                /** Commented By Vishal Kute 14-Nov-2013 **/
--                BEGIN
--                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_NAME/text()',vEMP_NAME);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Employee Name (Max limit is 150 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Employee Name';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'FATHER_NAME/text()',vEMP_FATHNAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Father Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    VERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Father Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'GENDER/text()',vEMP_GENDER);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Gender (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Gender';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'OFFICIAL_EMAIL_ADDRESS/text()',vCORRS_MAIL1);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Official Email Address (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Official Email Address ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BIRTH_DATE/text()',vBIRTH_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Birth Date should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Birth Date should be date ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'CONFIRMATION_DATE/text()',vCONFIRMATION_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Confirmation Date should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Confirmation Date should be date ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'JOIN_DATE/text()',vJOIN_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Join Date should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Join Date should be date';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DESIGNATION_CODE/text()',vDESG_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Designation Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Designation Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BRANCH_CODE/text()',vBR_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Branch Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Branch Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CODE/text()',vDEPT_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOC_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Location Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Location Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'GRADE_CODE/text()',vGRADE_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Grade Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Grade Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BAND_CODE/text()',vBAND_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Band Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Band Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                   BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COSTCENTER_CODE/text()',vCOSTCENTER_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Cost Center Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Cost Center Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ESIC_FLAG/text()',vESIC);
                    vESIC:=UPPER(TRIM(vESIC));
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Esic Flag (Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Esic Flag';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ESIC_NUMBER/text()',vESIC_NO);
                    vESIC_NO:=UPPER(TRIM(vESIC_NO));
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for ESIC Number (max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for ESIC Number ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'HANDICAP_FLAG/text()',vHANDICAP);
                    vHANDICAP:=UPPER(TRIM(vHANDICAP));
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Handicap Flag (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Handicap Flag';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PAN_NUMBER/text()',vPAN_NO);
                    vPAN_NO:=UPPER(TRIM(vPAN_NO));
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Pan Number (max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Pan Number ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_FLAG/text()',vPF_FLAG);
                    vPF_FLAG:=UPPER(TRIM(vPF_FLAG));
                EXCEPTION
                  WHEN OTHERS THEN
                    vERROR_MSG:='Invalid value for PF FLAG (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                    GOTO PRINT_ERROR;
                END;
                
                   BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_NUMBER/text()',vPF_NO);
                    vPF_NO:=UPPER(TRIM(vPF_NO));
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for PF Number (max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for PF Number ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

        --PF CALCULATION TYPE 22 AUG 2013
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_CALCULATION_TYPE/text()',vPF_CAL_TYPE);
                    vPF_CAL_TYPE:=UPPER(TRIM(vPF_CAL_TYPE));
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for PF Calculation Type (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for PF Calculation Type';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_CODE/text()',vBANK_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Bank Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Bank Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_ACCOUNT_NO/text()',vBANK_ACC_NO);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Bank Account No';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Bank Account No';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'REIMBURSEMENT_BANK_CODE/text()',vREIMB_BANK_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Reimbursement Bank Code (max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Reimbursement Bank Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'REIMBURSEMENT_ACCOUNT_NO/text()',vREIMB_ACC_NO);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Reimbursement Bank Code';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Reimbursement Bank Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'LEAVE_DATE/text()',vLEAVE_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Leave Date Should Be Date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Leave Date should be date';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'NO_OF_CHILDRENS/text()',vNO_OF_CHILDRENS);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for No Of Childrens';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for No Of Childrens';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'MANAGEMENT_CATEGORY/text()',vMGMT_CAT);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Management Category(Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Management Category';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CATEGORY/text()',vDEPT_CAT);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Category(Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Category';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_DEPARTMENT_CODE/text()',vSUB_DEPT_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Department Code(Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Department Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'UAN_NO/text()',vUAN_NO);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for UAN Number(Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for UAN Number';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'AADHAR_NO/text()',vAADHAR_NO);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Aadhar Number(Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Aadhar Number';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'IFSC_CODE/text()',vIFSC_CODE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for IFSC Code(Max limit is 30 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for IFSC Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTUAL_QUIT_DATE/text()',vACTUAL_QUIT_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Actual Quit Date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Actual Quit Date';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'FNF_SETTLEMENT_DATE/text()',vFNF_SETTLEMENT_DATE);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for FNF Settlement Date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for FNF Settlement Date';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                

              -- dbms_xslprocessor.valueOf(vXmlDOMNode,'HANDICAP/text()',vHANDICAP);
              vBIRTH_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vBIRTH_DATE));
              vCONFIRMATION_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vCONFIRMATION_DATE));
              vJOIN_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vJOIN_DATE));
              vLEAVE_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vLEAVE_DATE));
              vACTUAL_QUIT_DATE:=HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vACTUAL_QUIT_DATE));
              vFNF_SETTLEMENT_DATE:=HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vFNF_SETTLEMENT_DATE));

               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
              
               /****** Added by Vishal Kute 12-Nov-2013*******/
              IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN 
                  IF VEMP_MID_FLAG = 'N' THEN
                      IF vEMP_MID IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Employee Code should not be blank';
                           GOTO PRINT_ERROR;
                      END IF;
                  END IF;
              ELSIF pTrans_Type = 'UPDATE' THEN
                  IF vEMP_MID IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Employee Code should not be blank';
                           GOTO PRINT_ERROR;
                   END IF;
              END IF;
              
               /*********************************************/
              
              IF vEMP_FNAME IS NULL THEN
                   VERROR_FLAG:='Y';
                   vERROR_MSG:='Employee First Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
              
              /** Commented By Vishal Kute 14-Nov-2013**/
--               IF vEMP_NAME IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

--               IF vEMP_MNAME IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:=' EMP MNAME SHOULD NOT BE BLANK';
--                   GOTO PRINT_ERROR;
--               END IF;

--               IF vEMP_LNAME IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Last Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
               
                IF vEMP_FATHNAME IS NULL THEN
                   VERROR_FLAG:='Y';
                   vERROR_MSG:='Employee Father Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               vEMP_GENDER:=upper(vEMP_GENDER);

               IF vEMP_GENDER IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Gender should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vBIRTH_DATE,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Birth Date should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vLOC_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Location Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF vESIC IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='ESIC Flag should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vHANDICAP IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Handicap Flag should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
              
              /************************** NVL Section *****************************/
              
               IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
              
                /****** Added by Vishal Kute 12-Nov-2013*******/
              IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                  IF VEMP_MID_FLAG = 'N' THEN
                     IF NVL(LENGTH(TRIM(NVL(vEMP_MID,' '))),0)=0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:=' Employee Code should not be blank';
                         GOTO PRINT_ERROR;
                     END IF;
                  END IF; 
              ELSIF pTrans_Type = 'UPDATE' THEN
                   IF NVL(LENGTH(TRIM(NVL(vEMP_MID,' '))),0)=0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:=' Employee Code should not be blank';
                         GOTO PRINT_ERROR;
                   END IF;
              END IF;
                /*********************************************/

               IF NVL(LENGTH(TRIM(NVL(vEMP_FNAME,' '))),0)=0 THEN
                   VERROR_FLAG:='Y';
                   vERROR_MSG:='Employee First Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

--                IF NVL(LENGTH(TRIM(NVL(vEMP_LNAME,' '))),0)=0 THEN
--                   VERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Last Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
               
                IF NVL(LENGTH(TRIM(NVL(vEMP_FATHNAME,' '))),0)=0 THEN
                   VERROR_FLAG:='Y';
                   vERROR_MSG:='Employee Father Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF NVL(LENGTH(TRIM(NVL(vEMP_GENDER,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Gender should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


                IF NVL(LENGTH(TRIM(NVL(vJOIN_DATE,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Join Date should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
--                IF NVL(LENGTH(TRIM(NVL(vMGMT_CAT,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Management Category should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
               
--               IF NVL(LENGTH(TRIM(NVL(vDEPT_CAT,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Department Category should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
               
--               IF NVL(LENGTH(TRIM(NVL(vSUB_DEPT_MID,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Sub Department Code should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

               --------------------------------------------------
                -- added by vaishali--
               vChkRecordCount :=CASE WHEN TRIM(UPPER(vBIRTH_DATE))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
                                      ELSE 0 END;

                IF vChkRecordCount =0 THEN
                  IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vBIRTH_DATE))= 0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vBIRTH_DATE)=0 THEN
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid Birth Date!';
                      GOTO PRINT_ERROR;                
                  END IF;
                END IF;
                -- END by vaishali--                 
                ---------------------------------------------------------
                -- start added by vaishali--
                vChkRecordCount :=CASE WHEN TRIM(UPPER(vJOIN_DATE))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
                                        ELSE 0 END;

                IF vChkRecordCount =0 THEN
                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vJOIN_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vJOIN_DATE)=0 THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid Join Date!';
                        GOTO PRINT_ERROR;                
                    END IF;                 
                END IF;
               -- end added by vaishali--         
               --------------------------------------- 
                -- start added by vaishali--
                vChkRecordCount :=CASE WHEN (TRIM(UPPER(vLEAVE_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(vLEAVE_DATE) IS NULL THEN 1
                                        ELSE 0 END;

                 IF vChkRecordCount =0  THEN
                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vLEAVE_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vLEAVE_DATE)=0 THEN       
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Invalid Leave Date!';
                           GOTO PRINT_ERROR;
                    END IF;
                END IF; 
                -- end added by vaishali--
--              ----------------------------------------------   
--               IF(vCONFIRMATION_DATE IS NOT NULL) THEN
                
                -- start added by vaishali--
                vChkRecordCount :=CASE WHEN (TRIM(UPPER(vCONFIRMATION_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(UPPER(vCONFIRMATION_DATE)) IS NULL THEN 1
                                        ELSE 0 END;

                IF vChkRecordCount =0 THEN 
                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vCONFIRMATION_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vCONFIRMATION_DATE)=0 THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid Confirmation Date!';
                        GOTO PRINT_ERROR;                
                    END IF;      
                END IF; 
                
               vChkRecordCount :=CASE WHEN (TRIM(UPPER(vACTUAL_QUIT_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(vACTUAL_QUIT_DATE) IS NULL THEN 1
                                        ELSE 0 END;

                 IF vChkRecordCount =0  THEN
                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vACTUAL_QUIT_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vACTUAL_QUIT_DATE)=0 THEN       
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Invalid Actual Date!';
                           GOTO PRINT_ERROR;
                    END IF;
                END IF; 
                
                 vChkRecordCount :=CASE WHEN (TRIM(UPPER(vFNF_SETTLEMENT_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(vFNF_SETTLEMENT_DATE) IS NULL THEN 1
                                        ELSE 0 END;

                 IF vChkRecordCount =0  THEN
                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vFNF_SETTLEMENT_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vFNF_SETTLEMENT_DATE)=0 THEN       
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Invalid FNF Settlement Date!';
                           GOTO PRINT_ERROR;
                    END IF;
                END IF; 
                
--               END IF;
              -- end added by vaishali-- 
              -------------------------------------------               
               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);
               
               /*to find Emp current Data*/
               OPEN curRec FOR
               SELECT BANK_AID,REIMB_BANK_AID,BIRTH_DATE, LEAVE_DATE, CONFIRMATION_DATE, JOIN_DATE,ACTUAL_QUIT_DATE,FNF_SETTLEMENT_DATE FROM GM_EMP 
               WHERE COMP_ID=vComp_Id AND EMP_MID=vEMP_MID;
               FETCH curRec INTO vCur_Bank_Aid,vCur_Reimb_Bank_Aid,vCur_CUR_BIRTH_DATE, vCur_LEAVE_DATE, vCur_CONFIRMATION_DATE, vCur_JOIN_DATE, vAct_Quit_Date, vFNF_SETTL_DATE ;
               CLOSE curRec;
              
               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCONFIRMATION_DATE))='#NULL') then
                   IF ( vCONFIRMATION_DATE IS NOT NULL ) THEN
                       IF(TO_DATE(vJOIN_DATE,'DD-MM-RRRR') > TO_DATE(vCONFIRMATION_DATE,'DD-MM-RRRR') ) THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Confirmation Date should be greater than or equal to Join Date';
                           GOTO PRINT_ERROR;
                       END IF;
                   END IF;
               END IF;

              IF vBIRTH_DATE Is Not Null THEN
                IF NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vBIRTH_DATE))='#NULL') then
  --                  IF( TO_NUMBER( TO_CHAR(SYSDATE,'YYYY')  - TO_CHAR(TO_DATE(vBIRTH_DATE,'DD-MM-RRRR'),'YYYY'))<18 ) THEN
  --                       vERROR_FLAG:='Y';
  --                       vERROR_MSG:='Employee Age can not be less than 18 yrs';
  --                       GOTO PRINT_ERROR;
  --                  END IF;
                    SELECT TRUNC(MONTHS_BETWEEN(sysdate, TO_DATE(vBIRTH_DATE,'DD-MM-RRRR'))/12) BIRTH_YEAR INTO vAge FROM DUAL;
                    IF( vAge < 18 ) THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Employee Age can not be less than 18 yrs';
                         GOTO PRINT_ERROR;
                    END IF;
                END IF;
              END IF;


              IF NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vBIRTH_DATE))='#NULL') THEN
--                  IF ( (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') >TO_DATE(vJOIN_DATE,'DD-MM-RRRR'))
--                                OR (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR')> TO_DATE(vCONFIRMATION_DATE,'DD-MM-RRRR')) ) THEN
                  IF ( (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') >CASE WHEN TRIM(UPPER(vJOIN_DATE))='#NULL' THEN TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') ELSE TO_DATE(vJOIN_DATE,'DD-MM-RRRR') END)
                                OR (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR')> CASE WHEN TRIM(UPPER(vCONFIRMATION_DATE))='#NULL' THEN TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') ELSE TO_DATE(vCONFIRMATION_DATE,'DD-MM-RRRR') END) )
                  THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Birth Date can not be greater than Join Date and Confirmation Date';
                       GOTO PRINT_ERROR;
                  END IF;
              END IF;

              IF NOT ((pTrans_Type ='UPDATE' AND TRIM(UPPER(vLEAVE_DATE))='#NULL') OR vLEAVE_DATE IS NULL) then

                   IF(TO_DATE(CASE WHEN TRIM(UPPER(vJOIN_DATE))='#NULL' THEN vCur_JOIN_DATE END ,'DD-MM-RRRR') > TO_DATE(vLEAVE_DATE,'DD-MM-RRRR') ) THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Leave Date should be greater than or equal to Join Date';
                       GOTO PRINT_ERROR;
                   END IF;

               END IF;
               
--              IF NOT ((pTrans_Type ='UPDATE' AND TRIM(UPPER(vLEAVE_DATE))='#NULL') OR vACTUAL_QUIT_DATE IS not NULL) THEN
--
--                   IF(TO_DATE(CASE WHEN TRIM(UPPER(vLEAVE_DATE))='#NULL' THEN vCur_LEAVE_DATE END ,'DD-MM-RRRR') > TO_DATE(vACTUAL_QUIT_DATE,'DD-MM-RRRR') ) THEN
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Actual Quit Date should be greater than or equal to Leave Date1';
--                       GOTO PRINT_ERROR;
--                   END IF;
--
--              END IF;
            
--              
              IF vACTUAL_QUIT_DATE IS NOT NULL AND vCur_LEAVE_DATE IS NOT NULL AND vLEAVE_DATE IS NOT NULL  THEN 
                  IF(TO_DATE(CASE WHEN TRIM(UPPER(vACTUAL_QUIT_DATE))='#NULL' THEN vAct_Quit_Date else vACTUAL_QUIT_DATE END ,'DD-MM-RRRR') < TO_DATE(CASE WHEN TRIM(UPPER(vLEAVE_DATE))='#NULL' THEN vCur_LEAVE_DATE else vLEAVE_DATE END ,'DD-MM-RRRR')) THEN
                 --IF TO_DATE(vACTUAL_QUIT_DATE,'DD-MM-RRRR') < 
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Actual Quit Date should be greater than or equal to Leave Date';
                       GOTO PRINT_ERROR;
                   END IF; 
              END IF;
              
              IF vFNF_SETTLEMENT_DATE IS NOT NULL AND vCur_LEAVE_DATE IS NOT NULL THEN 
                  IF(TO_DATE(CASE WHEN TRIM(UPPER(vFNF_SETTLEMENT_DATE))='#NULL' THEN vFNF_SETTL_DATE else vFNF_SETTLEMENT_DATE END ,'DD-MM-RRRR') < TO_DATE(CASE WHEN TRIM(UPPER(vLEAVE_DATE))='#NULL' THEN vCur_LEAVE_DATE else vLEAVE_DATE END ,'DD-MM-RRRR')) THEN
                 --IF TO_DATE(vACTUAL_QUIT_DATE,'DD-MM-RRRR') < 
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='FNF Settlement Date should be greater than or equal to Leave Date';
                       GOTO PRINT_ERROR;
                   END IF; 
              END IF;
              
              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vUAN_NO),'~!@$%^&*()+=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid UAN Number special character found!';
                         GOTO PRINT_ERROR;
              END IF;
              
              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vAADHAR_NO),'~!@$%^&*()+=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Aadhar Number special character found!';
                         GOTO PRINT_ERROR;
              END IF;
              
              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vIFSC_CODE),'~!@$%^&*()+=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid IFSC Code special character found!';
                         GOTO PRINT_ERROR;
              END IF;
           
            /****** Added by Vishal Kute 12-Nov-2013*******/
             IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                 IF VEMP_MID_FLAG = 'N' THEN
                     IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),'~!@#$%^&*()+=.,''') > 0 THEN
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Invalid Employee Code special character found!';
                             GOTO PRINT_ERROR;
                     END IF;
                 END IF; 
             ELSIF pTrans_Type = 'UPDATE' THEN
                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),'~!@#$%^&*()+=.,''') > 0 THEN
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Invalid Employee Code special character found!';
                             GOTO PRINT_ERROR;
                  END IF;
             END IF;
            /*********************************************/
                
            /****** Added by Vishal Kute 12-Nov-2013 for Employee Code *******/
             IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
             
                 IF VEMP_MID_FLAG = 'N' THEN   
                     IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),' ') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Employee Code, Space Found !';
                         GOTO PRINT_ERROR;
                     END IF;
                 END IF;
             ELSIF pTrans_Type = 'UPDATE' THEN
                IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),' ') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Employee Code, Space Found !';
                         GOTO PRINT_ERROR;
                END IF;
             END IF;
            /*********************************************/
            
            /** Commented By Vishal Kute 14-Nov-2013**/
--             IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_NAME),'1234567890') > 0 THEN
--                 vERROR_FLAG:='Y';
--                 vERROR_MSG:='Invalid Employee Name, Number Found !';
--                 GOTO PRINT_ERROR;
--             END IF;


                IF(vEMP_FNAME IS NOT NULL ) THEN
                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_FNAME),'1234567890') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Employee First Name, Number Found !';
                     GOTO PRINT_ERROR;
                  END IF;
                END IF;

                 IF(vEMP_MNAME IS NOT NULL ) THEN
                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MNAME),'1234567890') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Employee Middle Name, number found !';
                     GOTO PRINT_ERROR;
                  END IF;
                END IF;

                IF(vEMP_LNAME IS NOT NULL ) THEN
                   IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_LNAME),'1234567890') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Employee Last Name, number found !';
                     GOTO PRINT_ERROR;
                  END IF;
               END IF;
               
               
              /** Added By Vishal Kute 14-Nov-2013 **/
              IF(vEMP_FATHNAME IS NOT NULL ) THEN
                   IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_FATHNAME),'1234567890') > 0 THEN
                     VERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Employee Father Name, number found !';
                     GOTO PRINT_ERROR;
                  END IF;
               END IF;

                IF(LENGTH(TRIM(vEMP_GENDER)) >1 OR HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_GENDER),'MFmf') <>1)
                                                        AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vEMP_GENDER))='#NULL') THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Employee Gender !';
                     GOTO PRINT_ERROR;
                END IF;

               IF(LENGTH(TRIM(vHANDICAP)) >1 OR HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vHANDICAP),'YNyn') <>1)
                                                    AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vHANDICAP))='#NULL') THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Flag For Handicap!';
                     GOTO PRINT_ERROR;
               END IF;

                IF(LENGTH(TRIM(vESIC)) >1 OR HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vESIC),'YNyn') <>1)
                                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vESIC))='#NULL') THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Flag For ESIC !';
                     GOTO PRINT_ERROR;
                END IF;

                 IF(vCORRS_MAIL1 IS NOT NULL) THEN
                     IF HR_PK_VALIDATION.FN_EMAIL(vCORRS_MAIL1) >0 AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCORRS_MAIL1))='#NULL') THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Email Id!';
                         GOTO PRINT_ERROR;
                     END IF;
                 END IF;

             --IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

--                IF (vCORRS_MAIL1 IS NOT NULL) THEN
--                     SELECT COUNT(*) INTO vChkRecordCount
--                        FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(vComp_Id)) AND  LOWER(TRIM(CORRS_MAIL1))=LOWER(TRIM(vCORRS_MAIL1))
--                        AND UPPER(TRIM(EMP_MID))<>UPPER(TRIM(vEMP_MID));
--                     IF vChkRecordCount >0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:=' Email Id already exists, it should be unique!';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                END IF;


              IF(vDESG_MID IS NOT NULL)  THEN

               vDESG_ID := CASE WHEN TRIM(UPPER(vDESG_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_DESGN_ID(vComp_Id,vDESG_MID) END;

               IF vDESG_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Designation Code '||vDESG_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

              END IF;
              
              IF(vBR_MID IS NOT NULL)  THEN

               vBR_AID := CASE WHEN TRIM(UPPER(vBR_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_BRANCH_ID(vComp_Id,vBR_MID) END;

               IF vBR_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Branch Code '||vBR_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

              END IF;
              
              
              IF(vDEPT_MID IS NOT NULL)  THEN

              vDEPT_ID:= CASE WHEN TRIM(UPPER(vDEPT_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_DEPT_AID(vComp_Id,vDEPT_MID) END;

               IF vDEPT_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Department Code '||vDEPT_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
               
           
               vLOCATION_ID:=CASE WHEN TRIM(UPPER(vLOC_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                  ELSE HR_PK_VALIDATION.FN_GET_LOCATION_ID(TRIM(vComp_Id),TRIM(vLOC_MID)) END ;

                IF vLOCATION_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:=' Location Code '||vLOC_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;
               
                IF(vGRADE_MID IS NOT NULL)  THEN

               vGRADE_ID:= CASE WHEN TRIM(UPPER(vGRADE_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_GRADE_AID(vComp_Id,vGRADE_MID) END;

               IF vGRADE_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Grade Code '||vGRADE_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
               
                IF(vBAND_MID IS NOT NULL)  THEN

               vBAND_ID:= CASE WHEN TRIM(UPPER(vBAND_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_BAND_ID(vComp_Id,vBAND_MID) END;

               IF vBAND_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Band Code '||vBAND_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
               
                 IF(vCOSTCENTER_MID IS NOT NULL)  THEN

               vCC_ID:= CASE WHEN TRIM(UPPER(vCOSTCENTER_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_CC_AID(vComp_Id,vCOSTCENTER_MID) END;

               IF vCC_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Cost Center Code '||vCOSTCENTER_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
               

               -- Checking duplicate data exist or not

                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vEMP_MID)) ;
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate records found!';
                     GOTO PRINT_ERROR;
                 END IF;

            --   IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--                  IF(vCORRS_MAIL1 IS NOT NULL)  THEN
--                    OPEN curRec FOR
--                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
--                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
--                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and LOWER(TRIM(COL8))=LOWER(TRIM(vCORRS_MAIL1))
--                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCORRS_MAIL1))='#NULL');
--                     FETCH curRec INTO vChkRecordCount;
--                     CLOSE  curRec;
--
--                     IF vChkRecordCount > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Email Id should be unique!';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                   END IF;
             --  END IF;

                 vPAN_NO:=UPPER(vPAN_NO);
                 IF(vPAN_NO IS NOT NULL AND TRIM(UPPER(vPAN_NO))!='#NULL')  THEN
                    vPAN_ERROR:=  HR_PK_VALIDATION.FN_PAN_ISVALID(TRIM(vPAN_NO));
                     IF SUBSTR(vPAN_ERROR,1,1)<>'0' THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=SUBSTR(vPAN_ERROR,2);
                        GOTO PRINT_ERROR;
                     END IF;
                 END IF;

             IF(vPAN_NO IS NOT NULL AND TRIM(UPPER(vPAN_NO))!='#NULL') THEN
                -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

                   SELECT COUNT(*) INTO vChkRecordCount FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and LOWER(TRIM(COL22))=LOWER(TRIM(vPAN_NO))
                            AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vPAN_NO))='#NULL');

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='PAN Number should be unique!';
                     GOTO PRINT_ERROR;
                 END IF;

                 SELECT COUNT(*) INTO vChkRecordCount
                        FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(vComp_Id)) AND  LOWER(TRIM(PAN_NO))=LOWER(TRIM(vPAN_NO))
                        AND UPPER(TRIM(EMP_MID))<>UPPER(TRIM(vEMP_MID));
                 IF vChkRecordCount >0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:=' PAN Number should be unique!';
                     GOTO PRINT_ERROR;
                 END IF;

               END IF;

               IF NVL(TRIM(upper(vPF_FLAG)),'X') NOT IN ('Y','N') AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vPF_FLAG))='#NULL') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid PF Flag.It Should be Y or N!';
                    GOTO PRINT_ERROR;
               END IF;

               IF (vPF_FLAG = 'Y') OR (UPPER(vPF_FLAG) = '#NULL') OR TRIM(UPPER(vPF_CAL_TYPE))='#NULL' THEN
                  
                  IF(vPF_CAL_TYPE IS NOT NULL)  THEN
        
                      vPF_CAL_ID:= CASE WHEN TRIM(UPPER(vPF_CAL_TYPE))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                        ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vPF_CAL_TYPE) END;
        
                       IF vPF_CAL_ID IS NULL THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='PF Calculation Type '||vPF_CAL_TYPE||' does not exist';
                            GOTO PRINT_ERROR;
                       END IF;
                   ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='PF Calculation Type should not be blank';
                            GOTO PRINT_ERROR;
                   END IF;
              
               END IF;
               
               --Added By Vishal Kute
               --Validation for Bank Mid and Account Number

               IF(TRIM(vBANK_MID) IS NOT NULL ) THEN
                  vBANK_AID   := CASE WHEN TRIM(UPPER(vBANK_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN NVL(vCur_Bank_Aid,'#NULL')
                                  ELSE HR_PK_VALIDATION.FN_GET_BANK_ID(vComp_Id,vBANK_MID) END;

                   IF vBANK_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=' Bank Code '||vBANK_MID||' does not exist';
                        GOTO PRINT_ERROR;
                   END IF;

                   --Validation for Bank Account Number
                   IF VBANK_AID IS NOT NULL AND NVL(HR_PK_VALIDATION.FN_GET_ACC_SIZE(VCOMP_ID,VBANK_AID),0)>0 THEN
                        --Validation for Acct. No., Size
                        IF vBANK_ACC_NO  IS NULL AND NVL(HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vBANK_AID),0)>0 THEN
                                vERROR_FLAG:='Y';
                                vERROR_MSG:=' Bank Account No. should not be blank';
                                GOTO PRINT_ERROR;
                        ELSE

                          vVALID_ACC:=  CASE WHEN TRIM(UPPER(vBANK_ACC_NO))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
                                        ELSE HR_PK_VALIDATION.FN_CHK_ACC_NO(vComp_Id,vEMP_MID,vBANK_ACC_NO, vBANK_AID) END;

                          IF  (vVALID_ACC=0) THEN
                             vACC_NO_SIZE:=  HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vBANK_AID);
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Bank Account No. should be '||vACC_NO_SIZE||' characters or lesser.';
                             GOTO PRINT_ERROR;
                          END IF;
                          
                          if HR_PK_VALIDATION.FN_chk_dul_acc(vComp_Id ,vBANK_ACC_NO) > 0  THEN
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Bank Account No. '||vBANK_ACC_NO||' already exists';
                            GOTO PRINT_ERROR;
                          END IF;
                       
                       END IF;

                   END IF;
              
                   --Validation for Same Bank Account No
                   
               ELSIF vBANK_ACC_NO IS NOT NULL THEN
                    IF vBANK_MID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=' Bank Code should not be blank';
                        GOTO PRINT_ERROR;
                    END IF;

               END IF;

               --Added By Vishal Kute
               --Validation for Reimb Bank Mid and Reimb Account Number

               IF(TRIM(vREIMB_BANK_MID) IS NOT NULL ) THEN
                  vREIMB_BANK_AID   := CASE WHEN TRIM(UPPER(vREIMB_BANK_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN NVL(vCur_Reimb_Bank_Aid,'#NULL')
                                  ELSE HR_PK_VALIDATION.FN_GET_BANK_ID(vComp_Id,vREIMB_BANK_MID) END;

                   IF vREIMB_BANK_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=' Reimbursement Bank Code '||vREIMB_BANK_MID||' does not exist';
                        GOTO PRINT_ERROR;
                   END IF;

                   --Validation for Bank Account Number
                   IF vREIMB_BANK_AID IS NOT NULL AND NVL(HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vREIMB_BANK_AID),0)>0 THEN

                        IF vREIMB_ACC_NO  IS NULL THEN
                                vERROR_FLAG:='Y';
                                vERROR_MSG:=' Reimbursement Account No. should not be blank';
                                GOTO PRINT_ERROR;
                        ELSE

                          vVALID_REIMB_ACC:=  CASE WHEN TRIM(UPPER(vREIMB_ACC_NO))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
                                                ELSE HR_PK_VALIDATION.FN_CHK_ACC_NO(vComp_Id,vEMP_MID,vREIMB_ACC_NO, vREIMB_BANK_AID) END;

                          IF (vVALID_REIMB_ACC=0) THEN
                             vREIMB_ACC_NO_SIZE:=  HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vREIMB_BANK_AID);
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Reimbursement Account No. should be '||vREIMB_ACC_NO_SIZE||' characters or lesser.';
                             GOTO PRINT_ERROR;
                          END IF;

                        END IF;

                   END IF;

               ELSIF TRIM(vREIMB_ACC_NO) IS NOT NULL THEN
                    IF TRIM(vREIMB_BANK_MID) IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=' Reimbursement Bank Code should not be blank';
                        GOTO PRINT_ERROR;
                    END IF;

               END IF;
               
                IF(vMGMT_CAT IS NOT NULL)  THEN

               vMGMT_CAT_ID:= CASE WHEN TRIM(UPPER(vMGMT_CAT))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vMGMT_CAT) END;

               IF vMGMT_CAT_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Management Category '||vMGMT_CAT||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
               
                IF(vDEPT_CAT IS NOT NULL)  THEN

               vDEPT_CAT_ID:= CASE WHEN TRIM(UPPER(vDEPT_CAT))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vDEPT_CAT) END;

               IF vDEPT_CAT_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Department Category '||vDEPT_CAT||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
               
                IF(vSUB_DEPT_MID IS NOT NULL)  THEN

               vSUB_DEPT_ID:= CASE WHEN TRIM(UPPER(vSUB_DEPT_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_SUB_DEPT_AID(vComp_Id,vSUB_DEPT_MID) END;

               IF vSUB_DEPT_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Sub Department Code '||vSUB_DEPT_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;
                
                /***** Get Employee Name *****/
                VEMP_NAME:=NULL;
                
                
                IF (vEMP_MNAME IS NOT NULL) THEN
                    VEMP_NAME:= VEMP_FNAME||' '||VEMP_MNAME||' '||VEMP_LNAME;
                ELSIF (VEMP_MNAME IS NULL) THEN
                    VEMP_NAME:= VEMP_FNAME||' '||VEMP_LNAME;
                END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                      OPEN curRec FOR
                         SELECT COUNT(*) FROM GM_EMP
                              WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(EMP_MID)) = UPPER(TRIM(vEMP_MID));
                       FETCH curRec INTO vChkRecordCount ;
                       CLOSE  curRec;
                       
                       IF VEMP_MID_FLAG = 'N' THEN /* Added By Vishal Kute 13-Nov-2013*/
                           IF vChkRecordCount > 0 THEN
                               vERROR_FLAG:='Y';
                               vERROR_MSG:='Employee Code already exists!';
                               GOTO PRINT_ERROR;
                           END IF;
                       END IF;
               END IF;


               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_EMP
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(EMP_MID)) = UPPER(TRIM(vEMP_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Employee Code does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               --Get the Grade_Aid
               IF PTRANS_TYPE IN ('ADD','REMOVE AND ADD') THEN
                    vEMP_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_EMP',I+1);
                    --vEMP_ID := 'EM'||TRIM(TO_CHAR(SUBSTR(vEMP_ID,3)+I+1,'000000'));
               END IF;
              
              /*Inserting Uploaded data in Insertable format*/
              IF NVL(vERROR_FLAG,'N')='N' THEN
                INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO,  
                                                    COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,
                                                    COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,
                                                    COL19,COL20,COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,
                                                    COL29,COL30,COL31,COL32,COL33,COL34,COL35,
                                                    COL36,COL37,COL38,COL39,COL40,COL41)
                      VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2,    
                                                    VCOMP_ID, VEMP_ID, VEMP_MID, VEMP_FNAME,VEMP_MNAME,VEMP_LNAME,vEMP_FATHNAME,VEMP_GENDER,VCORRS_MAIL1,
                                                    VBIRTH_DATE,VCONFIRMATION_DATE,VJOIN_DATE,VDESG_ID,VBR_AID,VDEPT_ID,VLOCATION_ID,VGRADE_ID,VBAND_ID,
                                                    VCC_ID,VESIC,VESIC_NO,VHANDICAP,VPAN_NO,VPF_FLAG,VPF_NO,VPF_CAL_ID,VBANK_AID,VBANK_ACC_NO,
                                                    VREIMB_BANK_AID,VREIMB_ACC_NO,VLEAVE_DATE,VNO_OF_CHILDRENS,VMGMT_CAT_ID,VDEPT_CAT_ID,VSUB_DEPT_ID,
                                                    vUAN_NO,vAADHAR_NO,vIFSC_CODE,vACTUAL_QUIT_DATE,vFNF_SETTLEMENT_DATE,VEMP_NAME);
              END IF;

             <<PRINT_ERROR>>
             vComp_Id:=NULL;
                /*Inserting Uploaded data as it is in Upload File*/
            
               INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                                              COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8,COL9,
                                              COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,
                                              COL19,COL20,COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,
                                              COL29,COL30,COL31,COL32,COL33,COL34,COL35,
                                              COL36,COL37,COL38,COL39,COL40)
               VALUES( VUPLDBATCH_ID,PSESSIONID, PUSER_AID, PUPLOAD_AID, SYSDATE, VERROR_FLAG, VERROR_MSG, I+2,
                                              VCOMP_MID, VEMP_MID,VEMP_FNAME,VEMP_MNAME,VEMP_LNAME,vEMP_FATHNAME,VEMP_GENDER,VCORRS_MAIL1,VBIRTH_DATE,
                                              VCONFIRMATION_DATE,VJOIN_DATE,VDESG_MID,VBR_MID,VDEPT_MID,VLOC_MID,VGRADE_MID,VBAND_MID,VCOSTCENTER_MID,
                                              VESIC,VESIC_NO,VHANDICAP,VPAN_NO,VPF_FLAG,VPF_NO,VPF_CAL_ID,VBANK_MID,VBANK_ACC_NO,VREIMB_BANK_MID,
                                              VREIMB_ACC_NO,VLEAVE_DATE,VNO_OF_CHILDRENS,VMGMT_CAT,VDEPT_CAT,VSUB_DEPT_MID,
                                              vUAN_NO,vAADHAR_NO,vIFSC_CODE,vACTUAL_QUIT_DATE,vFNF_SETTLEMENT_DATE,VEMP_NAME);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE
        
            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE,COL1 COMP_ID,COL2 EMP_ID,COL3 EMP_MID,COL4 EMP_FNAME,COL5 EMP_MNAME,COL6 EMP_LNAME,COL7 FATHER_HUSBAND,
                      COL8 EMP_GENDER,COL9 CORRS_MAIL1,COL10 BIRTH_DATE,COL11 CONFIRMATION_DATE,COL12 JOIN_DATE,COL13 DESG_ID ,COL14  BR_AID,
                      COL15 DEPT_ID,COL16 LOCATION_ID,COL17 GRADE_ID,COL18 BAND_ID,COL19 CC_ID,COL20 ESIC,COL21 ESIC_NO,COL22 HANDICAP ,
                      COL23 PAN_NO, COL24 PF_FLAG ,COL25 PF_NO,COL26 PF_CAL_TYPE ,COL27 BANK_AID,COL28 BANK_ACC_NO,COL29 REIMB_BANK_AID,
                      COL30 REIMB_ACC_NO,COL31 LEAVE_DATE,COL32 NO_OF_CHILDRENS,COL33 MGMT_CAT_ID,COL34 DEPT_CAT_ID,COL35 SUB_DEPT_ID,
                      COL36 UAN_NO,COL37 AADHAR_NO,COL38 IFSC_CODE,COL39 ACTUAL_QUIT_DATE,COL40 FNF_SETTLEMENT_DATE,
                      COL41 EMP_NAME,pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP
            
                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN
                    
                    INSERT INTO GM_EMP ( GR_COMP_ID,COMP_ID,EMP_ID,
                                        EMP_MID,EMP_FNAME,EMP_MNAME ,EMP_LNAME,EMP_NAME,EMP_GENDER,CORRS_MAIL1,BIRTH_DATE,
                                        CONFIRMATION_DATE,JOIN_DATE,COPORATE_JOIN_DATE ,DESG_ID,DEPT_ID,LOC_ID,EMP_GRADE,BAND_ID,
                                        COSTCNTR_ID,ESIC_FLAG ,ESIC_NO,IS_HANDICAP,PAN_NO,   PF_FLAG,PF_NO, CR_USER_ID,  CR_DATE,   
                                        BANK_AID,  BANK_ACC_NO,   REIMB_BANK_AID,  REIMB_ACC_NO,LEAVE_DATE,CHILDRENS,BRANCH_AID,
                                        EFF_DATE_FROM,EMP_MGMT_CATE_AID, EMP_DEPT_CATE_AID, SUB_DEPT_AID,PF_CALCULATION_TYPE,FATHER_HUSBAND,
                                        UAN_NO,AADHAR_NO,IFSC_CODE,ACTUAL_QUIT_DATE,FNF_SETTLEMENT_DATE)
                     --VALUES(HR_PK_VALIDATION.FN_GET_GROUP_COMP_AID(I.COMP_ID)  ,I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_EMP',1), I.EMP_MID, I.EMP_FNAME,I.EMP_MNAME, I.EMP_LNAME, I.EMP_NAME, I.EMP_GENDER, I.CORRS_MAIL1, I.BIRTH_DATE, I.CONFIRMATION_DATE, I.JOIN_DATE,I.JOIN_DATE, I.DESG_ID ,I.DEPT_ID,I.LOCATION_ID,I.GRADE_ID,I.BAND_ID,I.CC_ID,I.ESIC ,I.ESIC_NO,I.HANDICAP ,I.PAN_NO, I.PF_FLAG,I.PF_NO, I.CR_USER_ID,I.CR_DATE, I.BANK_AID,I.BANK_ACC_NO, I.REIMB_BANK_AID,I.REIMB_ACC_NO,I.LEAVE_DATE,I.NO_OF_CHILDRENS,I.BR_AID, I.JOIN_DATE,I.MGMT_CAT_ID,I.DEPT_CAT_ID,I.SUB_DEPT_ID,I.PF_CAL_TYPE);
--                     VALUES(HR_PK_VALIDATION.FN_GET_GROUP_COMP_AID(I.COMP_ID)  ,I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_EMP',1), 
--                                        HR_PK_VALIDATION.GET_EMPLOYEE_CODE_NEWLY(I.COMP_ID, VEMP_MID_LOGIC,1), I.EMP_FNAME,I.EMP_MNAME, I.EMP_LNAME, I.EMP_NAME, I.EMP_GENDER, I.CORRS_MAIL1, I.BIRTH_DATE, I.CONFIRMATION_DATE, I.JOIN_DATE,I.JOIN_DATE, I.DESG_ID ,I.DEPT_ID,I.LOCATION_ID,I.GRADE_ID,I.BAND_ID,I.CC_ID,I.ESIC ,I.ESIC_NO,I.HANDICAP ,I.PAN_NO, I.PF_FLAG,I.PF_NO, I.CR_USER_ID,I.CR_DATE, I.BANK_AID,I.BANK_ACC_NO, I.REIMB_BANK_AID,I.REIMB_ACC_NO,I.LEAVE_DATE,I.NO_OF_CHILDRENS,I.BR_AID, I.JOIN_DATE,I.MGMT_CAT_ID,I.DEPT_CAT_ID,I.SUB_DEPT_ID,I.PF_CAL_TYPE);
                     VALUES(HR_PK_VALIDATION.FN_GET_GROUP_COMP_AID(I.COMP_ID)  ,I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_EMP',1), 
                                        I.EMP_MID, I.EMP_FNAME,I.EMP_MNAME, I.EMP_LNAME, I.EMP_NAME, I.EMP_GENDER, I.CORRS_MAIL1, I.BIRTH_DATE, 
                                        I.CONFIRMATION_DATE, I.JOIN_DATE,I.JOIN_DATE, I.DESG_ID ,I.DEPT_ID,I.LOCATION_ID,I.GRADE_ID,I.BAND_ID,
                                        I.CC_ID,I.ESIC ,I.ESIC_NO,I.HANDICAP ,I.PAN_NO, I.PF_FLAG,I.PF_NO, I.CR_USER_ID,I.CR_DATE, 
                                        I.BANK_AID,I.BANK_ACC_NO, I.REIMB_BANK_AID,I.REIMB_ACC_NO,I.LEAVE_DATE,I.NO_OF_CHILDRENS,I.BR_AID, 
                                        I.JOIN_DATE,I.MGMT_CAT_ID,I.DEPT_CAT_ID,I.SUB_DEPT_ID,I.PF_CAL_TYPE,I.FATHER_HUSBAND,
                                        I.UAN_NO,I.AADHAR_NO,I.IFSC_CODE,I.ACTUAL_QUIT_DATE,I.FNF_SETTLEMENT_DATE);

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID));
                    vSR_NO:=vSR_NO+1;

                    INSERT INTO GM_EMP_EMPLOYMENT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,CC_ID,BAND_ID,GRADE_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
                    VALUES(I.COMP_ID,I.EMP_ID,vSR_NO,I.JOIN_DATE,I.DESG_ID,I.DEPT_ID,I.CR_USER_ID,I.CR_DATE,I.CC_ID,I.BAND_ID,I.GRADE_ID,I.BR_AID,I.DEPT_CAT_ID,I.SUB_DEPT_ID);


                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_EMP
                        SET EMP_FNAME= DECODE(TRIM(UPPER(I.EMP_FNAME)),'#NULL',EMP_FNAME,TRIM(I.EMP_FNAME))
                        ,EMP_MNAME=DECODE(TRIM(UPPER(I.EMP_MNAME)),'#NULL',EMP_MNAME,TRIM(I.EMP_MNAME))
                        ,EMP_LNAME= DECODE(TRIM(UPPER(I.EMP_LNAME)),'#NULL',EMP_LNAME,TRIM(I.EMP_LNAME))
                        ,EMP_NAME=  REPLACE(DECODE(TRIM(UPPER(I.EMP_FNAME)),'#NULL',EMP_FNAME,TRIM(I.EMP_FNAME))--changed by vaishali
                            ||' '|| DECODE(TRIM(UPPER(I.EMP_MNAME)),'#NULL',EMP_MNAME,TRIM(I.EMP_MNAME))
                            ||' '|| DECODE(TRIM(UPPER(I.EMP_LNAME)),'#NULL',EMP_LNAME,TRIM(I.EMP_LNAME)),'  ',' ')
                        ,EMP_GENDER= DECODE(TRIM(UPPER(I.EMP_GENDER)),'#NULL',EMP_GENDER,TRIM(I.EMP_GENDER))
                        ,CORRS_MAIL1=DECODE(TRIM(UPPER(I.CORRS_MAIL1)),'#NULL',CORRS_MAIL1,TRIM(I.CORRS_MAIL1))
                        ,BIRTH_DATE= DECODE(TRIM(UPPER(I.BIRTH_DATE)),'#NULL',BIRTH_DATE,TRIM(I.BIRTH_DATE))
                        ,CONFIRMATION_DATE= DECODE(TRIM(UPPER(I.CONFIRMATION_DATE)),'#NULL',CONFIRMATION_DATE,TRIM(I.CONFIRMATION_DATE))
                        ,JOIN_DATE=DECODE(TRIM(UPPER(I.JOIN_DATE)),'#NULL',JOIN_DATE,TRIM(I.JOIN_DATE))
                        ,COPORATE_JOIN_DATE=DECODE(TRIM(UPPER(I.JOIN_DATE)),'#NULL',COPORATE_JOIN_DATE,TRIM(I.JOIN_DATE))
                        ,LEAVE_DATE=DECODE(TRIM(UPPER(I.LEAVE_DATE)),'#NULL',LEAVE_DATE,TRIM(I.LEAVE_DATE))
                        ,DESG_ID= DECODE(TRIM(UPPER(I.DESG_ID)),'#NULL',DESG_ID,TRIM(I.DESG_ID))
                        ,DEPT_ID= DECODE(TRIM(UPPER(I.DEPT_ID)),'#NULL',DEPT_ID,TRIM(I.DEPT_ID))
                        ,LOC_ID=  DECODE(TRIM(UPPER(I.LOCATION_ID)),'#NULL',LOC_ID,TRIM(I.LOCATION_ID))
                        ,EMP_GRADE=  DECODE(TRIM(UPPER(I.GRADE_ID)),'#NULL',EMP_GRADE,TRIM(I.GRADE_ID))
                        ,BAND_ID=  DECODE(TRIM(UPPER(I.BAND_ID)),'#NULL',BAND_ID,TRIM(I.BAND_ID))
                        ,COSTCNTR_ID=  DECODE(TRIM(UPPER(I.CC_ID)),'#NULL',COSTCNTR_ID,TRIM(I.CC_ID))
                        ,ESIC_FLAG= DECODE(TRIM(UPPER(I.ESIC)),'#NULL',ESIC_FLAG,TRIM(I.ESIC))
                        ,ESIC_NO= DECODE(TRIM(UPPER(I.ESIC_NO)),'#NULL',ESIC_NO,TRIM(I.ESIC_NO))
                        ,IS_HANDICAP=DECODE(TRIM(UPPER(I.HANDICAP)),'#NULL',IS_HANDICAP,TRIM(I.HANDICAP))
                        ,PAN_NO= DECODE(TRIM(UPPER(I.PAN_NO)),'#NULL',PAN_NO,TRIM(I.PAN_NO))
                        ,PF_FLAG= DECODE(TRIM(UPPER(I.PF_FLAG)),'#NULL',PF_FLAG,TRIM(I.PF_FLAG))
                        ,PF_NO= DECODE(TRIM(UPPER(I.PF_NO)),'#NULL',PF_NO,TRIM(I.PF_NO))
                        , UP_USER_ID=I.UP_USER_ID,UP_DATE=I.UP_DATE
                        ,BANK_AID=DECODE(TRIM(UPPER(I.BANK_AID)),'#NULL',BANK_AID,TRIM(I.BANK_AID))
                        ,BANK_ACC_NO=DECODE(TRIM(UPPER(I.BANK_ACC_NO)),'#NULL',BANK_ACC_NO,TRIM(I.BANK_ACC_NO))
                        ,REIMB_BANK_AID=DECODE(TRIM(UPPER(I.REIMB_BANK_AID)),'#NULL',REIMB_BANK_AID,TRIM(I.REIMB_BANK_AID))
                        ,REIMB_ACC_NO=DECODE(TRIM(UPPER(I.REIMB_ACC_NO)),'#NULL',REIMB_ACC_NO,TRIM(I.REIMB_ACC_NO))
                        ,CHILDRENS=DECODE(TRIM(UPPER(I.NO_OF_CHILDRENS)),'#NULL',CHILDRENS,TRIM(I.NO_OF_CHILDRENS))
                        ,BRANCH_AID=  DECODE(TRIM(UPPER(I.BR_AID)),'#NULL',BRANCH_AID,TRIM(I.BR_AID))
                        ,EFF_DATE_FROM=DECODE(TRIM(UPPER(I.JOIN_DATE)),'#NULL',EFF_DATE_FROM,TRIM(I.JOIN_DATE))
                        ,EMP_MGMT_CATE_AID =DECODE(TRIM(UPPER(I.MGMT_CAT_ID)),'#NULL',EMP_MGMT_CATE_AID,TRIM(I.MGMT_CAT_ID))
                        ,EMP_DEPT_CATE_AID =DECODE(TRIM(UPPER(I.DEPT_CAT_ID)),'#NULL',EMP_DEPT_CATE_AID,TRIM(I.DEPT_CAT_ID))
                        ,SUB_DEPT_AID =DECODE(TRIM(UPPER(I.SUB_DEPT_ID)),'#NULL',SUB_DEPT_AID,TRIM(I.SUB_DEPT_ID))
                        ,PF_CALCULATION_TYPE =DECODE(TRIM(UPPER(I.PF_CAL_TYPE)),'#NULL',PF_CALCULATION_TYPE,TRIM(I.PF_CAL_TYPE))
                        ,FATHER_HUSBAND = DECODE(TRIM(UPPER(I.FATHER_HUSBAND)),'#NULL',FATHER_HUSBAND,TRIM(I.FATHER_HUSBAND))
                        ,UAN_NO = DECODE(TRIM(UPPER(I.UAN_NO)),'#NULL',UAN_NO,TRIM(I.UAN_NO))
                        ,AADHAR_NO = DECODE(TRIM(UPPER(I.AADHAR_NO)),'#NULL',AADHAR_NO,TRIM(I.AADHAR_NO))
                        ,IFSC_CODE = DECODE(TRIM(UPPER(I.IFSC_CODE)),'#NULL',IFSC_CODE,TRIM(I.IFSC_CODE))
                        ,ACTUAL_QUIT_DATE = DECODE(TRIM(UPPER(I.ACTUAL_QUIT_DATE)),'#NULL',ACTUAL_QUIT_DATE,TRIM(I.ACTUAL_QUIT_DATE))
                        ,FNF_SETTLEMENT_DATE = DECODE(TRIM(UPPER(I.FNF_SETTLEMENT_DATE)),'#NULL',FNF_SETTLEMENT_DATE,TRIM(I.FNF_SETTLEMENT_DATE))
                    WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID)) AND  UPPER(TRIM(EMP_MID))= UPPER(TRIM(I.EMP_MID));

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID));
                    vSR_NO:=vSR_NO+1;

                    INSERT INTO GM_EMP_EMPLOYMENT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,GRADE_ID,BAND_ID,CC_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
                    SELECT COMP_ID,EMP_ID,vSR_NO,JOIN_DATE,DESG_ID,DEPT_ID,I.CR_USER_ID,SYSDATE,EMP_GRADE,BAND_ID,COSTCNTR_ID,BRANCH_AID,EMP_DEPT_CATE_AID, SUB_DEPT_AID
                    FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID)) AND UPPER(TRIM(EMP_MID))=UPPER(TRIM(I.EMP_MID));

                END IF;
         END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

       OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_EMP' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;

--    PROCEDURE UPLOAD_GM_EMP(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
--                            pUpload_Aid VARCHAR2, pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
--    AS
--    TYPE refCUR IS REF CURSOR;
--    curRec                    refCUR;
--
--    vXmlParser              dbms_xmlparser.Parser;
--    vXmlDomDocument         dbms_xmldom.DOMDocument;
--    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
--    vXmlDOMNode             dbms_xmldom.DOMNode;
--    vComp_Id                VARCHAR2(100);
--    vDESG_ID                VARCHAR2(100);
--    vEMP_ID                 VARCHAR2(100);
--
--    vCOMP_MID               VARCHAR2(100);
--    vEMP_MID                VARCHAR2(100);
--    vEMP_MID_FLAG           VARCHAR2(100);/* Added By Vishal Kute for Employee Mid Login / Validation*/
--    vEMP_MID_LOGIC          VARCHAR2(100);/* Added By Vishal Kute for Employee Mid Login / Validation*/
--    vEMP_FNAME              VARCHAR2(100);
--    vEMP_MNAME              VARCHAR2(100);
--     VEMP_LNAME             VARCHAR2(100);
--     VEMP_NAME              VARCHAR2(100);
--     vEMP_FATHNAME          VARCHAR2(100);
--     vEMP_GENDER            VARCHAR2(100);
--     vCORRS_MAIL1           VARCHAR2(100);
--     vBIRTH_DATE            VARCHAR2(100);--GM_EMP.BIRTH_DATE%TYPE;
--     vJOIN_DATE              VARCHAR2(100);--GM_EMP.JOIN_DATE%TYPE;
--     vCONFIRMATION_DATE      VARCHAR2(100);--GM_EMP.CONFIRMATION_DATE%TYPE;
--     vLEAVE_DATE            VARCHAR2(100);--GM_EMP.CONFIRMATION_DATE%TYPE;
--     vDESG_MID              VARCHAR2(100);
--    ---vDESGN_DESC         GM_EMP.DESGN_DESC%TYPE;
--    vDEPT_MID                VARCHAR2(100);
--    vLOC_MID                 VARCHAR2(100);
--    vGRADE_MID               VARCHAR2(100);
--    vBAND_MID                VARCHAR2(100);
--    vCOSTCENTER_MID          VARCHAR2(100);
--    vESIC_NO                 VARCHAR2(50);
--    vPF_NO                   VARCHAR2(50);
--    vNO_OF_CHILDRENS         VARCHAR2(10);
--
--    vBANK_MID                VARCHAR2(100);
--    vBANK_ACC_NO             VARCHAR2(100);
--    vREIMB_BANK_MID          VARCHAR2(100);
--    vREIMB_ACC_NO            VARCHAR2(100);
--    vVALID_ACC               NUMBER(10);
--    vACC_NO_SIZE             VARCHAR2(100);
--    vVALID_REIMB_ACC          NUMBER(10);
--    vREIMB_ACC_NO_SIZE       VARCHAR2(100);
--    vBANK_AID                VARCHAR2(100);
--    vREIMB_BANK_AID          VARCHAR2(100);
--
--    vCur_Bank_Aid           VARCHAR2(100);
--    vCur_Reimb_Bank_Aid     VARCHAR2(100);
--    vCur_CUR_BIRTH_DATE     DATE;
--    vCur_LEAVE_DATE         DATE;
--    vCur_CONFIRMATION_DATE   DATE;
--    vCur_JOIN_DATE          DATE;
--
--    vESIC                    VARCHAR2(100);
--    vPAN_NO                  VARCHAR2(100);
--    vPF_FLAG                 VARCHAR2(100);--GM_EMP.PF_FLAG%type;
--    vBR_AID                  VARCHAR2(100);
--    vDEPT_ID                 VARCHAR2(100);
--    vLOCATION_ID             VARCHAR2(100);
--    vBR_MID                  VARCHAR2(100);
--    vHANDICAP                VARCHAR2(100);
--    vERROR_MSG               VARCHAR2(2000);
--    vERROR_FLAG              VARCHAR2(1);
--    vChkRecordCount          NUMBER;
--    vUpldBatch_Id            VARCHAR2(100);
--    vSR_NO                   NUMBER;
--    vPAN_ERROR               VARCHAR2(2000);
--    vGRADE_ID                VARCHAR2(100);
--    vBAND_ID                 VARCHAR2(100);
--    vCC_ID                   VARCHAR2(100); 
--    vMGMT_CAT                VARCHAR2(15);
--    vDEPT_CAT                VARCHAR2(15);
--    vMGMT_CAT_ID             VARCHAR2(10);
--    vDEPT_CAT_ID             VARCHAR2(8);
--    vSUB_DEPT_ID             VARCHAR2(8);
--    vSUB_DEPT_MID            VARCHAR2(8);
--    vPF_CAL_TYPE             VARCHAR2(8);
--    vPF_CAL_ID               VARCHAR2(100);
--    vUAN_NO                  VARCHAR2(20);
--    vAADHAR_NO               VARCHAR2(20);
--    vIFSC_CODE               VARCHAR2(20);
--    vACTUAL_QUIT_DATE        VARCHAR2(100);
--    vFNF_SETTLEMENT_DATE     VARCHAR2(100); 
--    vAct_Quit_Date           date;
--    vFNF_SETTL_DATE          date;
--
--    BEGIN
--    
--        IF pOperationType = 'RAW_UPLOAD' THEN
--
--            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);
--
--            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';
--
--            vXmlParser := dbms_xmlparser.newParser;
--            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
--            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
--            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');
--
--            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP
--
--                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
--
--                vERROR_MSG:= NULL;
--                vERROR_FLAG:='N';
--                
--                vCOMP_MID :=NULL; vEMP_MID:=NULL;vEMP_FNAME:=NULL;vEMP_MNAME:=NULL;vEMP_LNAME:=NULL;vEMP_NAME:=NULL;vEMP_GENDER:=NULL;vCORRS_MAIL1:=NULL;
--                vBIRTH_DATE:=NULL;vCONFIRMATION_DATE:=NULL;vJOIN_DATE:=NULL;vDESG_MID:=NULL;vBR_MID:=NULL;vDEPT_MID:=NULL;vLOC_MID:=NULL;vGRADE_MID:=NULL;
--                vBAND_MID:=NULL;vCOSTCENTER_MID:=NULL;vESIC:=NULL;vESIC_NO:=NULL;vHANDICAP:=NULL;vPAN_NO:=NULL;vPF_FLAG:=NULL;vPF_NO:=NULL;vBANK_MID:=NULL;
--                vBANK_ACC_NO:=NULL;vREIMB_BANK_MID:=NULL;vREIMB_ACC_NO:=NULL;vLEAVE_DATE:=NULL;vNO_OF_CHILDRENS:=NULL;
--                
--                vComp_Id:=NULL; vEMP_ID:=NULL;vDESG_ID:=NULL;vBR_AID:=NULL;vDEPT_ID:=NULL;vLOCATION_ID:=NULL;vGRADE_ID:=NULL;vBAND_ID:=NULL;vCC_ID:=NULL;
--                vBANK_AID:=NULL;vBANK_ACC_NO:=NULL;vREIMB_BANK_AID:=NULL;vMGMT_CAT :=NULL;vDEPT_CAT :=NULL;vSUB_DEPT_MID :=NULL;
--                vMGMT_CAT_ID :=NULL;vMGMT_CAT_ID :=NULL;vSUB_DEPT_ID :=NULL;
--                
--                vESIC_NO :=NULL ; vPF_NO :=NULL;
--                vUAN_NO :=NULL; vAADHAR_NO :=NULL; vIFSC_CODE :=NULL; vACTUAL_QUIT_DATE :=NULL; vFNF_SETTLEMENT_DATE :=NULL; 
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Company Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                /****** Added by Vishal Kute 12-Nov-2013*******/
--                 /* EMPLOYEE CODE VALIDATION  added by Vishal Kute*/
--                  OPEN CURREC FOR
--                     SELECT IS_EMP_CODE_AUTOGENERATED,EMP_CODE_AUTOGENERATED_LOGIC
--                     FROM GM_COMP WHERE COMP_ID=pComp_Aid;
--                  FETCH CURREC INTO vEMP_MID_FLAG,vEMP_MID_LOGIC;
--                  CLOSE CURREC;
--              
--                  IF VEMP_MID_FLAG IS NULL THEN
--                     VERROR_FLAG:='Y';
--                     vERROR_MSG:='Set Employee Code Auto Generate or Auto Generate Not flag in Company Master';
--                     GOTO PRINT_ERROR;
--                  END IF;
--                  
--                /*********************************************/
--                
--                /****** Added by Vishal Kute 12-Nov-2013*******/
--                IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--                    IF VEMP_MID_FLAG = 'N'  THEN
--                        BEGIN
--                          dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
--                        EXCEPTION
--                          WHEN OTHERS THEN
--                          IF (SQLCODE ='-24331') THEN
--                            vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
--                            vERROR_FLAG:='Y';
--                          ELSE
--                            vERROR_FLAG:='Y';
--                            vERROR_MSG:='Invalid value for Employee Code';
--                          END IF;
--                          GOTO PRINT_ERROR;
--                        END;
--                    ELSIF VEMP_MID_FLAG = 'Y' THEN    
--                      IF VEMP_MID_LOGIC IS NOT NULL THEN
--                          VEMP_MID := HR_PK_VALIDATION.GET_EMPLOYEE_CODE_NEWLY(pComp_Aid, VEMP_MID_LOGIC,I+1);
--                      
--                      ELSE
--                         VERROR_FLAG:='Y';
--                         VERROR_MSG:='Set Employee Auto Generate Logic in Company Master';
--                         GOTO PRINT_ERROR;
--                      END IF;
--                  END IF;
--                  
--                ELSIF pTrans_Type = 'UPDATE' THEN
--                    BEGIN
--                          dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
--                        EXCEPTION
--                          WHEN OTHERS THEN
--                         IF (SQLCODE ='-24331') THEN
--                            vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
--                            vERROR_FLAG:='Y';
--                         ELSE
--                            vERROR_FLAG:='Y';
--                            vERROR_MSG:='Invalid value for Employee Code';
--                         END IF;
--                          GOTO PRINT_ERROR;
--                     END;
--                 END IF;
--                 
--                
--                /*********************************************/
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'FIRST_NAME/text()',vEMP_FNAME);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Employee First Name (max limit is 50 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Employee First Name ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'MIDDLE_NAME/text()',vEMP_MNAME);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Employee Middle Name (Max limit is 50 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Employee Middle Name';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                   dbms_xslprocessor.valueOf(vXmlDOMNode,'LAST_NAME/text()',vEMP_LNAME);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Employee Last Name (max limit is 50 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Employee Last Name';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                /** Commented By Vishal Kute 14-Nov-2013 **/
----                BEGIN
----                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_NAME/text()',vEMP_NAME);
----                EXCEPTION
----                  WHEN OTHERS THEN
----                  IF (SQLCODE ='-24331') THEN
----                    vERROR_MSG:='Invalid value for Employee Name (Max limit is 150 character)';
----                    vERROR_FLAG:='Y';
----                  ELSE
----                    vERROR_FLAG:='Y';
----                    vERROR_MSG:='Invalid value for Employee Name';
----                  END IF;
----                  GOTO PRINT_ERROR;
----                END;
--
--                 BEGIN
--                     dbms_xslprocessor.valueOf(vXmlDOMNode,'FATHER_NAME/text()',vEMP_FATHNAME);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Employee Father Name (Max limit is 100 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    VERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Employee Father Name';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'GENDER/text()',vEMP_GENDER);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                   IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Gender (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Gender';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'OFFICIAL_EMAIL_ADDRESS/text()',vCORRS_MAIL1);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                   IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Official Email Address (Max limit is 100 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Official Email Address ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BIRTH_DATE/text()',vBIRTH_DATE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Birth Date should be date';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Birth Date should be date ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'CONFIRMATION_DATE/text()',vCONFIRMATION_DATE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                   IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Confirmation Date should be date';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Confirmation Date should be date ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'JOIN_DATE/text()',vJOIN_DATE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Join Date should be date';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Join Date should be date';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DESIGNATION_CODE/text()',vDESG_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                   IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Designation Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Designation Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BRANCH_CODE/text()',vBR_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                   IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Branch Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Branch Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CODE/text()',vDEPT_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Department Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Department Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOC_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Location Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Location Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'GRADE_CODE/text()',vGRADE_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Grade Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Grade Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                  BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BAND_CODE/text()',vBAND_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Band Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Band Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                   BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COSTCENTER_CODE/text()',vCOSTCENTER_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Cost Center Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Cost Center Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ESIC_FLAG/text()',vESIC);
--                    vESIC:=UPPER(TRIM(vESIC));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Esic Flag (Max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Esic Flag';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                  BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ESIC_NUMBER/text()',vESIC_NO);
--                    vESIC_NO:=UPPER(TRIM(vESIC_NO));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for ESIC Number (max limit is 50 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for ESIC Number ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'HANDICAP_FLAG/text()',vHANDICAP);
--                    vHANDICAP:=UPPER(TRIM(vHANDICAP));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Handicap Flag (Max limit is 1 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Handicap Flag';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PAN_NUMBER/text()',vPAN_NO);
--                    vPAN_NO:=UPPER(TRIM(vPAN_NO));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Pan Number (max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Pan Number ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_FLAG/text()',vPF_FLAG);
--                    vPF_FLAG:=UPPER(TRIM(vPF_FLAG));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                    vERROR_MSG:='Invalid value for PF FLAG (Max limit is 1 character)';
--                    vERROR_FLAG:='Y';
--                    GOTO PRINT_ERROR;
--                END;
--                
--                   BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_NUMBER/text()',vPF_NO);
--                    vPF_NO:=UPPER(TRIM(vPF_NO));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for PF Number (max limit is 50 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for PF Number ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--        --PF CALCULATION TYPE 22 AUG 2013
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_CALCULATION_TYPE/text()',vPF_CAL_TYPE);
--                    vPF_CAL_TYPE:=UPPER(TRIM(vPF_CAL_TYPE));
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for PF Calculation Type (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for PF Calculation Type';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_CODE/text()',vBANK_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Bank Code (Max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Bank Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_ACCOUNT_NO/text()',vBANK_ACC_NO);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Bank Account No';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Bank Account No';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                  BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'REIMBURSEMENT_BANK_CODE/text()',vREIMB_BANK_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Reimbursement Bank Code (max limit is 8 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Reimbursement Bank Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                 BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'REIMBURSEMENT_ACCOUNT_NO/text()',vREIMB_ACC_NO);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Reimbursement Bank Code';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Reimbursement Bank Code ';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'LEAVE_DATE/text()',vLEAVE_DATE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Leave Date Should Be Date';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Leave Date should be date';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                  BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'NO_OF_CHILDRENS/text()',vNO_OF_CHILDRENS);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for No Of Childrens';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for No Of Childrens';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                  BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'MANAGEMENT_CATEGORY/text()',vMGMT_CAT);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Management Category(Max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Management Category';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                  BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CATEGORY/text()',vDEPT_CAT);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Department Category(Max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Department Category';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_DEPARTMENT_CODE/text()',vSUB_DEPT_MID);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Sub Department Code(Max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Sub Department Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'UAN_NO/text()',vUAN_NO);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for UAN Number(Max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for UAN Number';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'AADHAR_NO/text()',vAADHAR_NO);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Aadhar Number(Max limit is 20 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Aadhar Number';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'IFSC_CODE/text()',vIFSC_CODE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for IFSC Code(Max limit is 30 character)';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for IFSC Code';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTUAL_QUIT_DATE/text()',vACTUAL_QUIT_DATE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for Actual Quit Date';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for Actual Quit Date';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--                BEGIN
--                    dbms_xslprocessor.valueOf(vXmlDOMNode,'FNF_SETTLEMENT_DATE/text()',vFNF_SETTLEMENT_DATE);
--                EXCEPTION
--                  WHEN OTHERS THEN
--                  IF (SQLCODE ='-24331') THEN
--                    vERROR_MSG:='Invalid value for FNF Settlement Date';
--                    vERROR_FLAG:='Y';
--                  ELSE
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid value for FNF Settlement Date';
--                  END IF;
--                  GOTO PRINT_ERROR;
--                END;
--                
--
--              -- dbms_xslprocessor.valueOf(vXmlDOMNode,'HANDICAP/text()',vHANDICAP);
--              vBIRTH_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vBIRTH_DATE));
--              vCONFIRMATION_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vCONFIRMATION_DATE));
--              vJOIN_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vJOIN_DATE));
--              vLEAVE_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vLEAVE_DATE));
--              vACTUAL_QUIT_DATE:=HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vACTUAL_QUIT_DATE));
--              vFNF_SETTLEMENT_DATE:=HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vFNF_SETTLEMENT_DATE));
--
--               IF vCOMP_MID IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Company code should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--              
--               /****** Added by Vishal Kute 12-Nov-2013*******/
--              IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN 
--                  IF VEMP_MID_FLAG = 'N' THEN
--                      IF vEMP_MID IS NULL THEN
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Employee Code should not be blank';
--                           GOTO PRINT_ERROR;
--                      END IF;
--                  END IF;
--              ELSIF pTrans_Type = 'UPDATE' THEN
--                  IF vEMP_MID IS NULL THEN
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Employee Code should not be blank';
--                           GOTO PRINT_ERROR;
--                   END IF;
--              END IF;
--              
--               /*********************************************/
--              
--              IF vEMP_FNAME IS NULL THEN
--                   VERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee First Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--              
--              /** Commented By Vishal Kute 14-Nov-2013**/
----               IF vEMP_NAME IS NULL THEN
----                   vERROR_FLAG:='Y';
----                   vERROR_MSG:='Employee Name should not be blank';
----                   GOTO PRINT_ERROR;
----               END IF;
--
----               IF vEMP_MNAME IS NULL THEN
----                   vERROR_FLAG:='Y';
----                   vERROR_MSG:=' EMP MNAME SHOULD NOT BE BLANK';
----                   GOTO PRINT_ERROR;
----               END IF;
--
--               IF vEMP_LNAME IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Last Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--               
--                IF vEMP_FATHNAME IS NULL THEN
--                   VERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Father Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--               vEMP_GENDER:=upper(vEMP_GENDER);
--
--               IF vEMP_GENDER IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Gender should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--               IF NVL(LENGTH(TRIM(NVL(vBIRTH_DATE,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Birth Date should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--               IF vLOC_MID IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Location Code should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--              IF vESIC IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='ESIC Flag should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--               IF vHANDICAP IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Handicap Flag should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--              
--              /************************** NVL Section *****************************/
--              
--               IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:=' Company Code should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--              
--                /****** Added by Vishal Kute 12-Nov-2013*******/
--              IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--                  IF VEMP_MID_FLAG = 'N' THEN
--                     IF NVL(LENGTH(TRIM(NVL(vEMP_MID,' '))),0)=0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:=' Employee Code should not be blank';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                  END IF; 
--              ELSIF pTrans_Type = 'UPDATE' THEN
--                   IF NVL(LENGTH(TRIM(NVL(vEMP_MID,' '))),0)=0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:=' Employee Code should not be blank';
--                         GOTO PRINT_ERROR;
--                   END IF;
--              END IF;
--                /*********************************************/
--
--               IF NVL(LENGTH(TRIM(NVL(vEMP_FNAME,' '))),0)=0 THEN
--                   VERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee First Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--                IF NVL(LENGTH(TRIM(NVL(vEMP_LNAME,' '))),0)=0 THEN
--                   VERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Last Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--               
--                IF NVL(LENGTH(TRIM(NVL(vEMP_FATHNAME,' '))),0)=0 THEN
--                   VERROR_FLAG:='Y';
--                   vERROR_MSG:='Employee Father Name should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--                IF NVL(LENGTH(TRIM(NVL(vEMP_GENDER,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Gender should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--
--
--                IF NVL(LENGTH(TRIM(NVL(vJOIN_DATE,' '))),0)=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='Join Date should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;
--               
----                IF NVL(LENGTH(TRIM(NVL(vMGMT_CAT,' '))),0)=0 THEN
----                   vERROR_FLAG:='Y';
----                   vERROR_MSG:='Management Category should not be blank';
----                   GOTO PRINT_ERROR;
----               END IF;
--               
----               IF NVL(LENGTH(TRIM(NVL(vDEPT_CAT,' '))),0)=0 THEN
----                   vERROR_FLAG:='Y';
----                   vERROR_MSG:='Department Category should not be blank';
----                   GOTO PRINT_ERROR;
----               END IF;
--               
----               IF NVL(LENGTH(TRIM(NVL(vSUB_DEPT_MID,' '))),0)=0 THEN
----                   vERROR_FLAG:='Y';
----                   vERROR_MSG:='Sub Department Code should not be blank';
----                   GOTO PRINT_ERROR;
----               END IF;
--
--               --------------------------------------------------
--                -- added by vaishali--
--               vChkRecordCount :=CASE WHEN TRIM(UPPER(vBIRTH_DATE))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
--                                      ELSE 0 END;
--
--                IF vChkRecordCount =0 THEN
--                  IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vBIRTH_DATE))= 0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vBIRTH_DATE)=0 THEN
--                      vERROR_FLAG:='Y';
--                      vERROR_MSG:='Invalid Birth Date!';
--                      GOTO PRINT_ERROR;                
--                  END IF;
--                END IF;
--                -- END by vaishali--                 
--                ---------------------------------------------------------
--                -- start added by vaishali--
--                vChkRecordCount :=CASE WHEN TRIM(UPPER(vJOIN_DATE))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
--                                        ELSE 0 END;
--
--                IF vChkRecordCount =0 THEN
--                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vJOIN_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vJOIN_DATE)=0 THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:='Invalid Join Date!';
--                        GOTO PRINT_ERROR;                
--                    END IF;                 
--                END IF;
--               -- end added by vaishali--         
--               --------------------------------------- 
--                -- start added by vaishali--
--                vChkRecordCount :=CASE WHEN (TRIM(UPPER(vLEAVE_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(vLEAVE_DATE) IS NULL THEN 1
--                                        ELSE 0 END;
--
--                 IF vChkRecordCount =0  THEN
--                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vLEAVE_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vLEAVE_DATE)=0 THEN       
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Invalid Leave Date!';
--                           GOTO PRINT_ERROR;
--                    END IF;
--                END IF; 
--                -- end added by vaishali--
----              ----------------------------------------------   
----               IF(vCONFIRMATION_DATE IS NOT NULL) THEN
--                
--                -- start added by vaishali--
--                vChkRecordCount :=CASE WHEN (TRIM(UPPER(vCONFIRMATION_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(UPPER(vCONFIRMATION_DATE)) IS NULL THEN 1
--                                        ELSE 0 END;
--
--                IF vChkRecordCount =0 THEN 
--                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vCONFIRMATION_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vCONFIRMATION_DATE)=0 THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:='Invalid Confirmation Date!';
--                        GOTO PRINT_ERROR;                
--                    END IF;      
--                END IF; 
--                
--               vChkRecordCount :=CASE WHEN (TRIM(UPPER(vACTUAL_QUIT_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(vACTUAL_QUIT_DATE) IS NULL THEN 1
--                                        ELSE 0 END;
--
--                 IF vChkRecordCount =0  THEN
--                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vACTUAL_QUIT_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vACTUAL_QUIT_DATE)=0 THEN       
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Invalid Actual Date!';
--                           GOTO PRINT_ERROR;
--                    END IF;
--                END IF; 
--                
--                 vChkRecordCount :=CASE WHEN (TRIM(UPPER(vFNF_SETTLEMENT_DATE))='#NULL' AND pTrans_Type ='UPDATE') OR TRIM(vFNF_SETTLEMENT_DATE) IS NULL THEN 1
--                                        ELSE 0 END;
--
--                 IF vChkRecordCount =0  THEN
--                    IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vFNF_SETTLEMENT_DATE))=0 OR HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vFNF_SETTLEMENT_DATE)=0 THEN       
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Invalid FNF Settlement Date!';
--                           GOTO PRINT_ERROR;
--                    END IF;
--                END IF; 
--                
----               END IF;
--              -- end added by vaishali-- 
--              -------------------------------------------               
--               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);
--               
--               /*to find Emp current Data*/
--               OPEN curRec FOR
--               SELECT BANK_AID,REIMB_BANK_AID,BIRTH_DATE, LEAVE_DATE, CONFIRMATION_DATE, JOIN_DATE,ACTUAL_QUIT_DATE,FNF_SETTLEMENT_DATE FROM GM_EMP 
--               WHERE COMP_ID=vComp_Id AND EMP_MID=vEMP_MID;
--               FETCH curRec INTO vCur_Bank_Aid,vCur_Reimb_Bank_Aid,vCur_CUR_BIRTH_DATE, vCur_LEAVE_DATE, vCur_CONFIRMATION_DATE, vCur_JOIN_DATE, vAct_Quit_Date, vFNF_SETTL_DATE ;
--               CLOSE curRec;
--              
--               IF vComp_Id IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               IF NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCONFIRMATION_DATE))='#NULL') then
--                   IF ( vCONFIRMATION_DATE IS NOT NULL ) THEN
--                       IF(TO_DATE(vJOIN_DATE,'DD-MM-RRRR') > TO_DATE(vCONFIRMATION_DATE,'DD-MM-RRRR') ) THEN
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Confirmation Date should be greater than or equal to Join Date';
--                           GOTO PRINT_ERROR;
--                       END IF;
--                   END IF;
--               END IF;
--
--              IF NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vBIRTH_DATE))='#NULL') then
--                  IF( TO_NUMBER( TO_CHAR(SYSDATE,'YYYY')  - TO_CHAR(TO_DATE(vBIRTH_DATE,'DD-MM-RRRR'),'YYYY'))<18 ) THEN
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Employee Age can not be less than 18 yrs';
--                       GOTO PRINT_ERROR;
--                  END IF;
--              END IF;
--
--
--
--              IF NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vBIRTH_DATE))='#NULL') THEN
----                  IF ( (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') >TO_DATE(vJOIN_DATE,'DD-MM-RRRR'))
----                                OR (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR')> TO_DATE(vCONFIRMATION_DATE,'DD-MM-RRRR')) ) THEN
--                  IF ( (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') >CASE WHEN TRIM(UPPER(vJOIN_DATE))='#NULL' THEN TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') ELSE TO_DATE(vJOIN_DATE,'DD-MM-RRRR') END)
--                                OR (TO_DATE(vBIRTH_DATE,'DD-MM-RRRR')> CASE WHEN TRIM(UPPER(vCONFIRMATION_DATE))='#NULL' THEN TO_DATE(vBIRTH_DATE,'DD-MM-RRRR') ELSE TO_DATE(vCONFIRMATION_DATE,'DD-MM-RRRR') END) )
--                  THEN
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Birth Date can not be greater than Join Date and Confirmation Date';
--                       GOTO PRINT_ERROR;
--                  END IF;
--              END IF;
--
--              IF NOT ((pTrans_Type ='UPDATE' AND TRIM(UPPER(vLEAVE_DATE))='#NULL') OR vLEAVE_DATE IS NULL) then
--
--                   IF(TO_DATE(CASE WHEN TRIM(UPPER(vJOIN_DATE))='#NULL' THEN vCur_JOIN_DATE END ,'DD-MM-RRRR') > TO_DATE(vLEAVE_DATE,'DD-MM-RRRR') ) THEN
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Leave Date should be greater than or equal to Join Date';
--                       GOTO PRINT_ERROR;
--                   END IF;
--
--               END IF;
--               
----              IF NOT ((pTrans_Type ='UPDATE' AND TRIM(UPPER(vLEAVE_DATE))='#NULL') OR vACTUAL_QUIT_DATE IS not NULL) THEN
----
----                   IF(TO_DATE(CASE WHEN TRIM(UPPER(vLEAVE_DATE))='#NULL' THEN vCur_LEAVE_DATE END ,'DD-MM-RRRR') > TO_DATE(vACTUAL_QUIT_DATE,'DD-MM-RRRR') ) THEN
----                       vERROR_FLAG:='Y';
----                       vERROR_MSG:='Actual Quit Date should be greater than or equal to Leave Date1';
----                       GOTO PRINT_ERROR;
----                   END IF;
----
----              END IF;
--            
----              
--              IF vACTUAL_QUIT_DATE IS NOT NULL AND vCur_LEAVE_DATE IS NOT NULL AND vLEAVE_DATE IS NOT NULL  THEN 
--                  IF(TO_DATE(CASE WHEN TRIM(UPPER(vACTUAL_QUIT_DATE))='#NULL' THEN vAct_Quit_Date else vACTUAL_QUIT_DATE END ,'DD-MM-RRRR') < TO_DATE(CASE WHEN TRIM(UPPER(vLEAVE_DATE))='#NULL' THEN vCur_LEAVE_DATE else vLEAVE_DATE END ,'DD-MM-RRRR')) THEN
--                 --IF TO_DATE(vACTUAL_QUIT_DATE,'DD-MM-RRRR') < 
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Actual Quit Date should be greater than or equal to Leave Date';
--                       GOTO PRINT_ERROR;
--                   END IF; 
--              END IF;
--              
--              IF vFNF_SETTLEMENT_DATE IS NOT NULL AND vCur_LEAVE_DATE IS NOT NULL THEN 
--                  IF(TO_DATE(CASE WHEN TRIM(UPPER(vFNF_SETTLEMENT_DATE))='#NULL' THEN vFNF_SETTL_DATE else vFNF_SETTLEMENT_DATE END ,'DD-MM-RRRR') < TO_DATE(CASE WHEN TRIM(UPPER(vLEAVE_DATE))='#NULL' THEN vCur_LEAVE_DATE else vLEAVE_DATE END ,'DD-MM-RRRR')) THEN
--                 --IF TO_DATE(vACTUAL_QUIT_DATE,'DD-MM-RRRR') < 
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='FNF Settlement Date should be greater than or equal to Leave Date';
--                       GOTO PRINT_ERROR;
--                   END IF; 
--              END IF;
--              
--              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vUAN_NO),'~!@$%^&*()+=.,''') > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Invalid UAN Number special character found!';
--                         GOTO PRINT_ERROR;
--              END IF;
--              
--              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vAADHAR_NO),'~!@$%^&*()+=.,''') > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Invalid Aadhar Number special character found!';
--                         GOTO PRINT_ERROR;
--              END IF;
--              
--              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vIFSC_CODE),'~!@$%^&*()+=.,''') > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Invalid IFSC Code special character found!';
--                         GOTO PRINT_ERROR;
--              END IF;
--           
--            /****** Added by Vishal Kute 12-Nov-2013*******/
--             IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--                 IF VEMP_MID_FLAG = 'N' THEN
--                     IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),'~!@#$%^&*()+=.,''') > 0 THEN
--                             vERROR_FLAG:='Y';
--                             vERROR_MSG:='Invalid Employee Code special character found!';
--                             GOTO PRINT_ERROR;
--                     END IF;
--                 END IF; 
--             ELSIF pTrans_Type = 'UPDATE' THEN
--                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),'~!@#$%^&*()+=.,''') > 0 THEN
--                             vERROR_FLAG:='Y';
--                             vERROR_MSG:='Invalid Employee Code special character found!';
--                             GOTO PRINT_ERROR;
--                  END IF;
--             END IF;
--            /*********************************************/
--                
--            /****** Added by Vishal Kute 12-Nov-2013 for Employee Code *******/
--             IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--             
--                 IF VEMP_MID_FLAG = 'N' THEN   
--                     IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),' ') > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Invalid Employee Code, Space Found !';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                 END IF;
--             ELSIF pTrans_Type = 'UPDATE' THEN
--                IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),' ') > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Invalid Employee Code, Space Found !';
--                         GOTO PRINT_ERROR;
--                END IF;
--             END IF;
--            /*********************************************/
--            
--            /** Commented By Vishal Kute 14-Nov-2013**/
----             IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_NAME),'1234567890') > 0 THEN
----                 vERROR_FLAG:='Y';
----                 vERROR_MSG:='Invalid Employee Name, Number Found !';
----                 GOTO PRINT_ERROR;
----             END IF;
--
--
--                IF(vEMP_FNAME IS NOT NULL ) THEN
--                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_FNAME),'1234567890') > 0 THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Employee First Name, Number Found !';
--                     GOTO PRINT_ERROR;
--                  END IF;
--                END IF;
--
--                 IF(vEMP_MNAME IS NOT NULL ) THEN
--                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MNAME),'1234567890') > 0 THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Employee Middle Name, number found !';
--                     GOTO PRINT_ERROR;
--                  END IF;
--                END IF;
--
--                IF(vEMP_LNAME IS NOT NULL ) THEN
--                   IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_LNAME),'1234567890') > 0 THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Employee Last Name, number found !';
--                     GOTO PRINT_ERROR;
--                  END IF;
--               END IF;
--               
--               
--              /** Added By Vishal Kute 14-Nov-2013 **/
--              IF(vEMP_FATHNAME IS NOT NULL ) THEN
--                   IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_FATHNAME),'1234567890') > 0 THEN
--                     VERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Employee Father Name, number found !';
--                     GOTO PRINT_ERROR;
--                  END IF;
--               END IF;
--
--                IF(LENGTH(TRIM(vEMP_GENDER)) >1 OR HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_GENDER),'MFmf') <>1)
--                                                        AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vEMP_GENDER))='#NULL') THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Employee Gender !';
--                     GOTO PRINT_ERROR;
--                END IF;
--
--               IF(LENGTH(TRIM(vHANDICAP)) >1 OR HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vHANDICAP),'YNyn') <>1)
--                                                    AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vHANDICAP))='#NULL') THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Flag For Handicap!';
--                     GOTO PRINT_ERROR;
--               END IF;
--
--                IF(LENGTH(TRIM(vESIC)) >1 OR HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vESIC),'YNyn') <>1)
--                                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vESIC))='#NULL') THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Invalid Flag For ESIC !';
--                     GOTO PRINT_ERROR;
--                END IF;
--
--                 IF(vCORRS_MAIL1 IS NOT NULL) THEN
--                     IF HR_PK_VALIDATION.FN_EMAIL(vCORRS_MAIL1) >0 AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCORRS_MAIL1))='#NULL') THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Invalid Email Id!';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                 END IF;
--
--             --IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--
--                IF (vCORRS_MAIL1 IS NOT NULL) THEN
--                     SELECT COUNT(*) INTO vChkRecordCount
--                        FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(vComp_Id)) AND  LOWER(TRIM(CORRS_MAIL1))=LOWER(TRIM(vCORRS_MAIL1))
--                        AND UPPER(TRIM(EMP_MID))<>UPPER(TRIM(vEMP_MID));
--                     IF vChkRecordCount >0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:=' Email Id already exists, it should be unique!';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                END IF;
--
--
--              IF(vDESG_MID IS NOT NULL)  THEN
--
--               vDESG_ID := CASE WHEN TRIM(UPPER(vDESG_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_DESGN_ID(vComp_Id,vDESG_MID) END;
--
--               IF vDESG_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Designation Code '||vDESG_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--              END IF;
--              
--              IF(vBR_MID IS NOT NULL)  THEN
--
--               vBR_AID := CASE WHEN TRIM(UPPER(vBR_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_BRANCH_ID(vComp_Id,vBR_MID) END;
--
--               IF vBR_AID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Branch Code '||vBR_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--              END IF;
--              
--              
--              IF(vDEPT_MID IS NOT NULL)  THEN
--
--              vDEPT_ID:= CASE WHEN TRIM(UPPER(vDEPT_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_DEPT_AID(vComp_Id,vDEPT_MID) END;
--
--               IF vDEPT_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Department Code '||vDEPT_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--               
--           
--               vLOCATION_ID:=CASE WHEN TRIM(UPPER(vLOC_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                  ELSE HR_PK_VALIDATION.FN_GET_LOCATION_ID(TRIM(vComp_Id),TRIM(vLOC_MID)) END ;
--
--                IF vLOCATION_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:=' Location Code '||vLOC_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--               
--                IF(vGRADE_MID IS NOT NULL)  THEN
--
--               vGRADE_ID:= CASE WHEN TRIM(UPPER(vGRADE_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_GRADE_AID(vComp_Id,vGRADE_MID) END;
--
--               IF vGRADE_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Grade Code '||vGRADE_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--               
--                IF(vBAND_MID IS NOT NULL)  THEN
--
--               vBAND_ID:= CASE WHEN TRIM(UPPER(vBAND_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_BAND_ID(vComp_Id,vBAND_MID) END;
--
--               IF vBAND_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Band Code '||vBAND_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--               
--                 IF(vCOSTCENTER_MID IS NOT NULL)  THEN
--
--               vCC_ID:= CASE WHEN TRIM(UPPER(vCOSTCENTER_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_CC_AID(vComp_Id,vCOSTCENTER_MID) END;
--
--               IF vCC_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Cost Center Code '||vCOSTCENTER_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--               
--
--               -- Checking duplicate data exist or not
--
--                OPEN curRec FOR
--                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
--                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
--                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vEMP_MID)) ;
--                 FETCH curRec INTO vChkRecordCount;
--                 CLOSE  curRec;
--
--                 IF vChkRecordCount > 0 THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='Duplicate records found!';
--                     GOTO PRINT_ERROR;
--                 END IF;
--
--            --   IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--                  IF(vCORRS_MAIL1 IS NOT NULL)  THEN
--                    OPEN curRec FOR
--                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
--                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
--                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and LOWER(TRIM(COL8))=LOWER(TRIM(vCORRS_MAIL1))
--                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vCORRS_MAIL1))='#NULL');
--                     FETCH curRec INTO vChkRecordCount;
--                     CLOSE  curRec;
--
--                     IF vChkRecordCount > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Email Id should be unique!';
--                         GOTO PRINT_ERROR;
--                     END IF;
--                   END IF;
--             --  END IF;
--
--                 vPAN_NO:=UPPER(vPAN_NO);
--                 IF(vPAN_NO IS NOT NULL AND TRIM(UPPER(vPAN_NO))!='#NULL')  THEN
--                    vPAN_ERROR:=  HR_PK_VALIDATION.FN_PAN_ISVALID(TRIM(vPAN_NO));
--                     IF SUBSTR(vPAN_ERROR,1,1)<>'0' THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:=SUBSTR(vPAN_ERROR,2);
--                        GOTO PRINT_ERROR;
--                     END IF;
--                 END IF;
--
--             IF(vPAN_NO IS NOT NULL AND TRIM(UPPER(vPAN_NO))!='#NULL') THEN
--                -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--
--                   SELECT COUNT(*) INTO vChkRecordCount FROM HR_TEMP_RAW_UPLOAD
--                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
--                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and LOWER(TRIM(COL20))=LOWER(TRIM(vPAN_NO))
--                            AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vPAN_NO))='#NULL');
--
--                 IF vChkRecordCount > 0 THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:='PAN Number should be unique!';
--                     GOTO PRINT_ERROR;
--                 END IF;
--
--                 SELECT COUNT(*) INTO vChkRecordCount
--                        FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(vComp_Id)) AND  LOWER(TRIM(PAN_NO))=LOWER(TRIM(vPAN_NO))
--                        AND UPPER(TRIM(EMP_MID))<>UPPER(TRIM(vEMP_MID));
--                 IF vChkRecordCount >0 THEN
--                     vERROR_FLAG:='Y';
--                     vERROR_MSG:=' PAN Number should be unique!';
--                     GOTO PRINT_ERROR;
--                 END IF;
--
--               END IF;
--
--               IF NVL(TRIM(upper(vPF_FLAG)),'X') NOT IN ('Y','N') AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vPF_FLAG))='#NULL') THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Invalid PF Flag.It Should be Y or N!';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               IF (vPF_FLAG = 'Y') OR (UPPER(vPF_FLAG) = '#NULL') OR TRIM(UPPER(vPF_CAL_TYPE))='#NULL' THEN
--                  
--                  IF(vPF_CAL_TYPE IS NOT NULL)  THEN
--        
--                      vPF_CAL_ID:= CASE WHEN TRIM(UPPER(vPF_CAL_TYPE))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                        ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vPF_CAL_TYPE) END;
--        
--                       IF vPF_CAL_ID IS NULL THEN
--                            vERROR_FLAG:='Y';
--                            vERROR_MSG:='PF Calculation Type '||vPF_CAL_TYPE||' does not exist';
--                            GOTO PRINT_ERROR;
--                       END IF;
--                   ELSE
--                            vERROR_FLAG:='Y';
--                            vERROR_MSG:='PF Calculation Type should not be blank';
--                            GOTO PRINT_ERROR;
--                   END IF;
--              
--               END IF;
--               
--               --Added By Vishal Kute
--               --Validation for Bank Mid and Account Number
--
--               IF(TRIM(vBANK_MID) IS NOT NULL ) THEN
--                  vBANK_AID   := CASE WHEN TRIM(UPPER(vBANK_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN NVL(vCur_Bank_Aid,'#NULL')
--                                  ELSE HR_PK_VALIDATION.FN_GET_BANK_ID(vComp_Id,vBANK_MID) END;
--
--                   IF vBANK_AID IS NULL THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:=' Bank Code '||vBANK_MID||' does not exist';
--                        GOTO PRINT_ERROR;
--                   END IF;
--
--                   --Validation for Bank Account Number
--                   IF VBANK_AID IS NOT NULL AND NVL(HR_PK_VALIDATION.FN_GET_ACC_SIZE(VCOMP_ID,VBANK_AID),0)>0 THEN
--                        --Validation for Acct. No., Size
--                        IF vBANK_ACC_NO  IS NULL AND NVL(HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vBANK_AID),0)>0 THEN
--                                vERROR_FLAG:='Y';
--                                vERROR_MSG:=' Bank Account No. should not be blank';
--                                GOTO PRINT_ERROR;
--                        ELSE
--
--                          vVALID_ACC:=  CASE WHEN TRIM(UPPER(vBANK_ACC_NO))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
--                                        ELSE HR_PK_VALIDATION.FN_CHK_ACC_NO(vComp_Id,vEMP_MID,vBANK_ACC_NO, vBANK_AID) END;
--
--                          IF  (vVALID_ACC=0) THEN
--                             vACC_NO_SIZE:=  HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vBANK_AID);
--                             vERROR_FLAG:='Y';
--                             vERROR_MSG:='Bank Account No. should be '||vACC_NO_SIZE||' characters or lesser.';
--                             GOTO PRINT_ERROR;
--                          END IF;
--                          
--                          if HR_PK_VALIDATION.FN_chk_dul_acc(vComp_Id ,vBANK_ACC_NO) > 0  THEN
--                             vERROR_FLAG:='Y';
--                             vERROR_MSG:='Bank Account No. '||vBANK_ACC_NO||' already exists';
--                            GOTO PRINT_ERROR;
--                          END IF;
--                       
--                       END IF;
--
--                   END IF;
--              
--                   --Validation for Same Bank Account No
--                   
--               ELSIF vBANK_ACC_NO IS NOT NULL THEN
--                    IF vBANK_MID IS NULL THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:=' Bank Code should not be blank';
--                        GOTO PRINT_ERROR;
--                    END IF;
--
--               END IF;
--
--               --Added By Vishal Kute
--               --Validation for Reimb Bank Mid and Reimb Account Number
--
--               IF(TRIM(vREIMB_BANK_MID) IS NOT NULL ) THEN
--                  vREIMB_BANK_AID   := CASE WHEN TRIM(UPPER(vREIMB_BANK_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN NVL(vCur_Reimb_Bank_Aid,'#NULL')
--                                  ELSE HR_PK_VALIDATION.FN_GET_BANK_ID(vComp_Id,vREIMB_BANK_MID) END;
--
--                   IF vREIMB_BANK_AID IS NULL THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:=' Reimbursement Bank Code '||vREIMB_BANK_MID||' does not exist';
--                        GOTO PRINT_ERROR;
--                   END IF;
--
--                   --Validation for Bank Account Number
--                   IF vREIMB_BANK_AID IS NOT NULL AND NVL(HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vREIMB_BANK_AID),0)>0 THEN
--
--                        IF vREIMB_ACC_NO  IS NULL THEN
--                                vERROR_FLAG:='Y';
--                                vERROR_MSG:=' Reimbursement Account No. should not be blank';
--                                GOTO PRINT_ERROR;
--                        ELSE
--
--                          vVALID_REIMB_ACC:=  CASE WHEN TRIM(UPPER(vREIMB_ACC_NO))='#NULL' AND pTrans_Type ='UPDATE' THEN 1
--                                                ELSE HR_PK_VALIDATION.FN_CHK_ACC_NO(vComp_Id,vEMP_MID,vREIMB_ACC_NO, vREIMB_BANK_AID) END;
--
--                          IF (vVALID_REIMB_ACC=0) THEN
--                             vREIMB_ACC_NO_SIZE:=  HR_PK_VALIDATION.FN_GET_ACC_SIZE(vComp_Id,vREIMB_BANK_AID);
--                             vERROR_FLAG:='Y';
--                             vERROR_MSG:='Reimbursement Account No. should be '||vREIMB_ACC_NO_SIZE||' characters or lesser.';
--                             GOTO PRINT_ERROR;
--                          END IF;
--
--                        END IF;
--
--                   END IF;
--
--               ELSIF TRIM(vREIMB_ACC_NO) IS NOT NULL THEN
--                    IF TRIM(vREIMB_BANK_MID) IS NULL THEN
--                        vERROR_FLAG:='Y';
--                        vERROR_MSG:=' Reimbursement Bank Code should not be blank';
--                        GOTO PRINT_ERROR;
--                    END IF;
--
--               END IF;
--               
--                IF(vMGMT_CAT IS NOT NULL)  THEN
--
--               vMGMT_CAT_ID:= CASE WHEN TRIM(UPPER(vMGMT_CAT))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vMGMT_CAT) END;
--
--               IF vMGMT_CAT_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Management Category '||vMGMT_CAT||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--               
--                IF(vDEPT_CAT IS NOT NULL)  THEN
--
--               vDEPT_CAT_ID:= CASE WHEN TRIM(UPPER(vDEPT_CAT))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vDEPT_CAT) END;
--
--               IF vDEPT_CAT_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Department Category '||vDEPT_CAT||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--               
--                IF(vSUB_DEPT_MID IS NOT NULL)  THEN
--
--               vSUB_DEPT_ID:= CASE WHEN TRIM(UPPER(vSUB_DEPT_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
--                                ELSE HR_PK_VALIDATION.FN_GET_SUB_DEPT_AID(vComp_Id,vSUB_DEPT_MID) END;
--
--               IF vSUB_DEPT_ID IS NULL THEN
--                    vERROR_FLAG:='Y';
--                    vERROR_MSG:='Sub Department Code '||vSUB_DEPT_MID||' does not exist';
--                    GOTO PRINT_ERROR;
--               END IF;
--
--               END IF;
--                
--                /***** Get Employee Name *****/
--                VEMP_NAME:=NULL;
--                
--                
--                IF (vEMP_MNAME IS NOT NULL) THEN
--                    VEMP_NAME:= VEMP_FNAME||' '||VEMP_MNAME||' '||VEMP_LNAME;
--                ELSIF (VEMP_MNAME IS NULL) THEN
--                    VEMP_NAME:= VEMP_FNAME||' '||VEMP_LNAME;
--                END IF;
--
--               -- Checking data exist
--               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
--                      OPEN curRec FOR
--                         SELECT COUNT(*) FROM GM_EMP
--                              WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(EMP_MID)) = UPPER(TRIM(vEMP_MID));
--                       FETCH curRec INTO vChkRecordCount ;
--                       CLOSE  curRec;
--                       
--                       IF VEMP_MID_FLAG = 'N' THEN /* Added By Vishal Kute 13-Nov-2013*/
--                           IF vChkRecordCount > 0 THEN
--                               vERROR_FLAG:='Y';
--                               vERROR_MSG:='Employee Code already exists!';
--                               GOTO PRINT_ERROR;
--                           END IF;
--                       END IF;
--               END IF;
--
--
--               IF pTrans_Type IN ('UPDATE') THEN
--                    OPEN curRec FOR
--                       SELECT COUNT(*) FROM GM_EMP
--                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(EMP_MID)) = UPPER(TRIM(vEMP_MID));
--                     FETCH curRec INTO vChkRecordCount ;
--                     CLOSE  curRec;
--
--                     IF vChkRecordCount = 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Employee Code does not exist!';
--                         GOTO PRINT_ERROR;
--                     END IF;
--               END IF;
--
--               --Get the Grade_Aid
--               IF PTRANS_TYPE IN ('ADD','REMOVE AND ADD') THEN
--                    vEMP_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_EMP',I+1);
--                    --vEMP_ID := 'EM'||TRIM(TO_CHAR(SUBSTR(vEMP_ID,3)+I+1,'000000'));
--               END IF;
--              
--              /*Inserting Uploaded data in Insertable format*/
--              IF NVL(vERROR_FLAG,'N')='N' THEN
--                INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO,  
--                                                    COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,
--                                                    COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,
--                                                    COL19,COL20,COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,
--                                                    COL29,COL30,COL31,COL32,COL33,COL34,COL35,
--                                                    COL36,COL37,COL38,COL39,COL40,COL41)
--                      VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2,    
--                                                    VCOMP_ID, VEMP_ID, VEMP_MID, VEMP_FNAME,VEMP_MNAME,VEMP_LNAME,vEMP_FATHNAME,VEMP_GENDER,VCORRS_MAIL1,
--                                                    VBIRTH_DATE,VCONFIRMATION_DATE,VJOIN_DATE,VDESG_ID,VBR_AID,VDEPT_ID,VLOCATION_ID,VGRADE_ID,VBAND_ID,
--                                                    VCC_ID,VESIC,VESIC_NO,VHANDICAP,VPAN_NO,VPF_FLAG,VPF_NO,VPF_CAL_ID,VBANK_AID,VBANK_ACC_NO,
--                                                    VREIMB_BANK_AID,VREIMB_ACC_NO,VLEAVE_DATE,VNO_OF_CHILDRENS,VMGMT_CAT_ID,VDEPT_CAT_ID,VSUB_DEPT_ID,
--                                                    vUAN_NO,vAADHAR_NO,vIFSC_CODE,vACTUAL_QUIT_DATE,vFNF_SETTLEMENT_DATE,VEMP_NAME);
--              END IF;
--
--             <<PRINT_ERROR>>
--             vComp_Id:=NULL;
--                /*Inserting Uploaded data as it is in Upload File*/
--            
--               INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
--                                              COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8,COL9,
--                                              COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,
--                                              COL19,COL20,COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,
--                                              COL29,COL30,COL31,COL32,COL33,COL34,COL35,
--                                              COL36,COL37,COL38,COL39,COL40)
--               VALUES( VUPLDBATCH_ID,PSESSIONID, PUSER_AID, PUPLOAD_AID, SYSDATE, VERROR_FLAG, VERROR_MSG, I+2,
--                                              VCOMP_MID, VEMP_MID,VEMP_FNAME,VEMP_MNAME,VEMP_LNAME,vEMP_FATHNAME,VEMP_GENDER,VCORRS_MAIL1,VBIRTH_DATE,
--                                              VCONFIRMATION_DATE,VJOIN_DATE,VDESG_MID,VBR_MID,VDEPT_MID,VLOC_MID,VGRADE_MID,VBAND_MID,VCOSTCENTER_MID,
--                                              VESIC,VESIC_NO,VHANDICAP,VPAN_NO,VPF_FLAG,VPF_NO,VPF_CAL_ID,VBANK_MID,VBANK_ACC_NO,VREIMB_BANK_MID,
--                                              VREIMB_ACC_NO,VLEAVE_DATE,VNO_OF_CHILDRENS,VMGMT_CAT,VDEPT_CAT,VSUB_DEPT_MID,
--                                              vUAN_NO,vAADHAR_NO,vIFSC_CODE,vACTUAL_QUIT_DATE,vFNF_SETTLEMENT_DATE,VEMP_NAME);
--
--            END LOOP;
--
--           --Inserting Upload Summary
--           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);
--
--        ELSE
--        
--            --Final data insert in base table GM_GRADE_MSTR
--            FOR I IN (SELECT  TRANS_TYPE,COL1 COMP_ID,COL2 EMP_ID,COL3 EMP_MID,COL4 EMP_FNAME,COL5 EMP_MNAME,COL6 EMP_LNAME,COL7 FATHER_HUSBAND,
--                      COL8 EMP_GENDER,COL9 CORRS_MAIL1,COL10 BIRTH_DATE,COL11 CONFIRMATION_DATE,COL12 JOIN_DATE,COL13 DESG_ID ,COL14  BR_AID,
--                      COL15 DEPT_ID,COL16 LOCATION_ID,COL17 GRADE_ID,COL18 BAND_ID,COL19 CC_ID,COL20 ESIC,COL21 ESIC_NO,COL22 HANDICAP ,
--                      COL23 PAN_NO, COL24 PF_FLAG ,COL25 PF_NO,COL26 PF_CAL_TYPE ,COL27 BANK_AID,COL28 BANK_ACC_NO,COL29 REIMB_BANK_AID,
--                      COL30 REIMB_ACC_NO,COL31 LEAVE_DATE,COL32 NO_OF_CHILDRENS,COL33 MGMT_CAT_ID,COL34 DEPT_CAT_ID,COL35 SUB_DEPT_ID,
--                      COL36 UAN_NO,COL37 AADHAR_NO,COL38 IFSC_CODE,COL39 ACTUAL_QUIT_DATE,COL40 FNF_SETTLEMENT_DATE,
--                      COL41 EMP_NAME,pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
--                       FROM HR_VW_FINAL_UPLOAD_DATA
--                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
--                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
--            LOOP
--            
--                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN
--                    
--                    INSERT INTO GM_EMP ( GR_COMP_ID,COMP_ID,EMP_ID,
--                                        EMP_MID,EMP_FNAME,EMP_MNAME ,EMP_LNAME,EMP_NAME,EMP_GENDER,CORRS_MAIL1,BIRTH_DATE,
--                                        CONFIRMATION_DATE,JOIN_DATE,COPORATE_JOIN_DATE ,DESG_ID,DEPT_ID,LOC_ID,EMP_GRADE,BAND_ID,
--                                        COSTCNTR_ID,ESIC_FLAG ,ESIC_NO,IS_HANDICAP,PAN_NO,   PF_FLAG,PF_NO, CR_USER_ID,  CR_DATE,   
--                                        BANK_AID,  BANK_ACC_NO,   REIMB_BANK_AID,  REIMB_ACC_NO,LEAVE_DATE,CHILDRENS,BRANCH_AID,
--                                        EFF_DATE_FROM,EMP_MGMT_CATE_AID, EMP_DEPT_CATE_AID, SUB_DEPT_AID,PF_CALCULATION_TYPE,FATHER_HUSBAND,
--                                        UAN_NO,AADHAR_NO,IFSC_CODE,ACTUAL_QUIT_DATE,FNF_SETTLEMENT_DATE)
--                     --VALUES(HR_PK_VALIDATION.FN_GET_GROUP_COMP_AID(I.COMP_ID)  ,I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_EMP',1), I.EMP_MID, I.EMP_FNAME,I.EMP_MNAME, I.EMP_LNAME, I.EMP_NAME, I.EMP_GENDER, I.CORRS_MAIL1, I.BIRTH_DATE, I.CONFIRMATION_DATE, I.JOIN_DATE,I.JOIN_DATE, I.DESG_ID ,I.DEPT_ID,I.LOCATION_ID,I.GRADE_ID,I.BAND_ID,I.CC_ID,I.ESIC ,I.ESIC_NO,I.HANDICAP ,I.PAN_NO, I.PF_FLAG,I.PF_NO, I.CR_USER_ID,I.CR_DATE, I.BANK_AID,I.BANK_ACC_NO, I.REIMB_BANK_AID,I.REIMB_ACC_NO,I.LEAVE_DATE,I.NO_OF_CHILDRENS,I.BR_AID, I.JOIN_DATE,I.MGMT_CAT_ID,I.DEPT_CAT_ID,I.SUB_DEPT_ID,I.PF_CAL_TYPE);
----                     VALUES(HR_PK_VALIDATION.FN_GET_GROUP_COMP_AID(I.COMP_ID)  ,I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_EMP',1), 
----                                        HR_PK_VALIDATION.GET_EMPLOYEE_CODE_NEWLY(I.COMP_ID, VEMP_MID_LOGIC,1), I.EMP_FNAME,I.EMP_MNAME, I.EMP_LNAME, I.EMP_NAME, I.EMP_GENDER, I.CORRS_MAIL1, I.BIRTH_DATE, I.CONFIRMATION_DATE, I.JOIN_DATE,I.JOIN_DATE, I.DESG_ID ,I.DEPT_ID,I.LOCATION_ID,I.GRADE_ID,I.BAND_ID,I.CC_ID,I.ESIC ,I.ESIC_NO,I.HANDICAP ,I.PAN_NO, I.PF_FLAG,I.PF_NO, I.CR_USER_ID,I.CR_DATE, I.BANK_AID,I.BANK_ACC_NO, I.REIMB_BANK_AID,I.REIMB_ACC_NO,I.LEAVE_DATE,I.NO_OF_CHILDRENS,I.BR_AID, I.JOIN_DATE,I.MGMT_CAT_ID,I.DEPT_CAT_ID,I.SUB_DEPT_ID,I.PF_CAL_TYPE);
--                     VALUES(HR_PK_VALIDATION.FN_GET_GROUP_COMP_AID(I.COMP_ID)  ,I.COMP_ID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_ID, 'GM_EMP',1), 
--                                        I.EMP_MID, I.EMP_FNAME,I.EMP_MNAME, I.EMP_LNAME, I.EMP_NAME, I.EMP_GENDER, I.CORRS_MAIL1, I.BIRTH_DATE, 
--                                        I.CONFIRMATION_DATE, I.JOIN_DATE,I.JOIN_DATE, I.DESG_ID ,I.DEPT_ID,I.LOCATION_ID,I.GRADE_ID,I.BAND_ID,
--                                        I.CC_ID,I.ESIC ,I.ESIC_NO,I.HANDICAP ,I.PAN_NO, I.PF_FLAG,I.PF_NO, I.CR_USER_ID,I.CR_DATE, 
--                                        I.BANK_AID,I.BANK_ACC_NO, I.REIMB_BANK_AID,I.REIMB_ACC_NO,I.LEAVE_DATE,I.NO_OF_CHILDRENS,I.BR_AID, 
--                                        I.JOIN_DATE,I.MGMT_CAT_ID,I.DEPT_CAT_ID,I.SUB_DEPT_ID,I.PF_CAL_TYPE,I.FATHER_HUSBAND,
--                                        I.UAN_NO,I.AADHAR_NO,I.IFSC_CODE,I.ACTUAL_QUIT_DATE,I.FNF_SETTLEMENT_DATE);
--
--                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID));
--                    vSR_NO:=vSR_NO+1;
--
--                    INSERT INTO GM_EMP_EMPLOYMENT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,CC_ID,BAND_ID,GRADE_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
--                    VALUES(I.COMP_ID,I.EMP_ID,vSR_NO,I.JOIN_DATE,I.DESG_ID,I.DEPT_ID,I.CR_USER_ID,I.CR_DATE,I.CC_ID,I.BAND_ID,I.GRADE_ID,I.BR_AID,I.DEPT_CAT_ID,I.SUB_DEPT_ID);
--
--
--                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN
--
--                    UPDATE GM_EMP
--                        SET EMP_FNAME= DECODE(TRIM(UPPER(I.EMP_FNAME)),'#NULL',EMP_FNAME,TRIM(I.EMP_FNAME))
--                        ,EMP_MNAME=DECODE(TRIM(UPPER(I.EMP_MNAME)),'#NULL',EMP_MNAME,TRIM(I.EMP_MNAME))
--                        ,EMP_LNAME= DECODE(TRIM(UPPER(I.EMP_LNAME)),'#NULL',EMP_LNAME,TRIM(I.EMP_LNAME))
--                        ,EMP_NAME=  REPLACE(DECODE(TRIM(UPPER(I.EMP_FNAME)),'#NULL',EMP_FNAME,TRIM(I.EMP_FNAME))--changed by vaishali
--                            ||' '|| DECODE(TRIM(UPPER(I.EMP_MNAME)),'#NULL',EMP_MNAME,TRIM(I.EMP_MNAME))
--                            ||' '|| DECODE(TRIM(UPPER(I.EMP_LNAME)),'#NULL',EMP_LNAME,TRIM(I.EMP_LNAME)),'  ',' ')
--                        ,EMP_GENDER= DECODE(TRIM(UPPER(I.EMP_GENDER)),'#NULL',EMP_GENDER,TRIM(I.EMP_GENDER))
--                        ,CORRS_MAIL1=DECODE(TRIM(UPPER(I.CORRS_MAIL1)),'#NULL',CORRS_MAIL1,TRIM(I.CORRS_MAIL1))
--                        ,BIRTH_DATE= DECODE(TRIM(UPPER(I.BIRTH_DATE)),'#NULL',BIRTH_DATE,TRIM(I.BIRTH_DATE))
--                        ,CONFIRMATION_DATE= DECODE(TRIM(UPPER(I.CONFIRMATION_DATE)),'#NULL',CONFIRMATION_DATE,TRIM(I.CONFIRMATION_DATE))
--                        ,JOIN_DATE=DECODE(TRIM(UPPER(I.JOIN_DATE)),'#NULL',JOIN_DATE,TRIM(I.JOIN_DATE))
--                        ,COPORATE_JOIN_DATE=DECODE(TRIM(UPPER(I.JOIN_DATE)),'#NULL',COPORATE_JOIN_DATE,TRIM(I.JOIN_DATE))
--                        ,LEAVE_DATE=DECODE(TRIM(UPPER(I.LEAVE_DATE)),'#NULL',LEAVE_DATE,TRIM(I.LEAVE_DATE))
--                        ,DESG_ID= DECODE(TRIM(UPPER(I.DESG_ID)),'#NULL',DESG_ID,TRIM(I.DESG_ID))
--                        ,DEPT_ID= DECODE(TRIM(UPPER(I.DEPT_ID)),'#NULL',DEPT_ID,TRIM(I.DEPT_ID))
--                        ,LOC_ID=  DECODE(TRIM(UPPER(I.LOCATION_ID)),'#NULL',LOC_ID,TRIM(I.LOCATION_ID))
--                        ,EMP_GRADE=  DECODE(TRIM(UPPER(I.GRADE_ID)),'#NULL',EMP_GRADE,TRIM(I.GRADE_ID))
--                        ,BAND_ID=  DECODE(TRIM(UPPER(I.BAND_ID)),'#NULL',BAND_ID,TRIM(I.BAND_ID))
--                        ,COSTCNTR_ID=  DECODE(TRIM(UPPER(I.CC_ID)),'#NULL',COSTCNTR_ID,TRIM(I.CC_ID))
--                        ,ESIC_FLAG= DECODE(TRIM(UPPER(I.ESIC)),'#NULL',ESIC_FLAG,TRIM(I.ESIC))
--                        ,ESIC_NO= DECODE(TRIM(UPPER(I.ESIC_NO)),'#NULL',ESIC_NO,TRIM(I.ESIC_NO))
--                        ,IS_HANDICAP=DECODE(TRIM(UPPER(I.HANDICAP)),'#NULL',IS_HANDICAP,TRIM(I.HANDICAP))
--                        ,PAN_NO= DECODE(TRIM(UPPER(I.PAN_NO)),'#NULL',PAN_NO,TRIM(I.PAN_NO))
--                        ,PF_FLAG= DECODE(TRIM(UPPER(I.PF_FLAG)),'#NULL',PF_FLAG,TRIM(I.PF_FLAG))
--                        ,PF_NO= DECODE(TRIM(UPPER(I.PF_NO)),'#NULL',PF_NO,TRIM(I.PF_NO))
--                        , UP_USER_ID=I.UP_USER_ID,UP_DATE=I.UP_DATE
--                        ,BANK_AID=DECODE(TRIM(UPPER(I.BANK_AID)),'#NULL',BANK_AID,TRIM(I.BANK_AID))
--                        ,BANK_ACC_NO=DECODE(TRIM(UPPER(I.BANK_ACC_NO)),'#NULL',BANK_ACC_NO,TRIM(I.BANK_ACC_NO))
--                        ,REIMB_BANK_AID=DECODE(TRIM(UPPER(I.REIMB_BANK_AID)),'#NULL',REIMB_BANK_AID,TRIM(I.REIMB_BANK_AID))
--                        ,REIMB_ACC_NO=DECODE(TRIM(UPPER(I.REIMB_ACC_NO)),'#NULL',REIMB_ACC_NO,TRIM(I.REIMB_ACC_NO))
--                        ,CHILDRENS=DECODE(TRIM(UPPER(I.NO_OF_CHILDRENS)),'#NULL',CHILDRENS,TRIM(I.NO_OF_CHILDRENS))
--                        ,BRANCH_AID=  DECODE(TRIM(UPPER(I.BR_AID)),'#NULL',BRANCH_AID,TRIM(I.BR_AID))
--                        ,EFF_DATE_FROM=DECODE(TRIM(UPPER(I.JOIN_DATE)),'#NULL',EFF_DATE_FROM,TRIM(I.JOIN_DATE))
--                        ,EMP_MGMT_CATE_AID =DECODE(TRIM(UPPER(I.MGMT_CAT_ID)),'#NULL',EMP_MGMT_CATE_AID,TRIM(I.MGMT_CAT_ID))
--                        ,EMP_DEPT_CATE_AID =DECODE(TRIM(UPPER(I.DEPT_CAT_ID)),'#NULL',EMP_DEPT_CATE_AID,TRIM(I.DEPT_CAT_ID))
--                        ,SUB_DEPT_AID =DECODE(TRIM(UPPER(I.SUB_DEPT_ID)),'#NULL',SUB_DEPT_AID,TRIM(I.SUB_DEPT_ID))
--                        ,PF_CALCULATION_TYPE =DECODE(TRIM(UPPER(I.PF_CAL_TYPE)),'#NULL',PF_CALCULATION_TYPE,TRIM(I.PF_CAL_TYPE))
--                        ,FATHER_HUSBAND = DECODE(TRIM(UPPER(I.FATHER_HUSBAND)),'#NULL',FATHER_HUSBAND,TRIM(I.FATHER_HUSBAND))
--                        ,UAN_NO = DECODE(TRIM(UPPER(I.UAN_NO)),'#NULL',UAN_NO,TRIM(I.UAN_NO))
--                        ,AADHAR_NO = DECODE(TRIM(UPPER(I.AADHAR_NO)),'#NULL',AADHAR_NO,TRIM(I.AADHAR_NO))
--                        ,IFSC_CODE = DECODE(TRIM(UPPER(I.IFSC_CODE)),'#NULL',IFSC_CODE,TRIM(I.IFSC_CODE))
--                        ,ACTUAL_QUIT_DATE = DECODE(TRIM(UPPER(I.ACTUAL_QUIT_DATE)),'#NULL',ACTUAL_QUIT_DATE,TRIM(I.ACTUAL_QUIT_DATE))
--                        ,FNF_SETTLEMENT_DATE = DECODE(TRIM(UPPER(I.FNF_SETTLEMENT_DATE)),'#NULL',FNF_SETTLEMENT_DATE,TRIM(I.FNF_SETTLEMENT_DATE))
--                    WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID)) AND  UPPER(TRIM(EMP_MID))= UPPER(TRIM(I.EMP_MID));
--
--                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID));
--                    vSR_NO:=vSR_NO+1;
--
--                    INSERT INTO GM_EMP_EMPLOYMENT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,GRADE_ID,BAND_ID,CC_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
--                    SELECT COMP_ID,EMP_ID,vSR_NO,JOIN_DATE,DESG_ID,DEPT_ID,I.CR_USER_ID,SYSDATE,EMP_GRADE,BAND_ID,COSTCNTR_ID,BRANCH_AID,EMP_DEPT_CATE_AID, SUB_DEPT_AID
--                    FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_ID)) AND UPPER(TRIM(EMP_MID))=UPPER(TRIM(I.EMP_MID));
--
--                END IF;
--         END LOOP;
--
--            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);
--
--        END IF;
--
--       COMMIT;
--
--       OPEN Return_Recordset FOR
--            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;
--
--
--       EXCEPTION
--            WHEN OTHERS THEN
--                ROLLBACK;
--                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_EMP' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
--
--        OPEN Return_Recordset FOR
--           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;
--
--    END;



PROCEDURE UPLOAD_GM_BAND(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vBAND_AID               GM_BAND.BAND_AID %TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vBAND_MID               GM_BAND.BAND_MID%TYPE;
    vBAND_DESC              GM_BAND.BAND_DESC%TYPE;
    pBAND_MID               GM_BAND.BAND_MID%TYPE;


    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

--'<NewDataSet><ExcelInfo><COMP_MID>BCD</COMP_MID><BAND_MID>OO1</BAND_MID><BAND_DESC>ASD</BAND_DESC>  </ExcelInfo></NewDataSet>';--
            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

               vERROR_MSG:= NULL;
               vERROR_FLAG:='N';
               
               vComp_Mid:=NULL;vBAND_MID:=NULL;vBAND_DESC:=NULL;vComp_Id:=NULL;vBAND_AID:=NULL;

                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 28 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BAND_CODE/text()',vBAND_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Band Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Band Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BAND_NAME/text()',vBAND_DESC);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Band Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Band Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                                --dbms_xslprocessor.valueOf(vXmlDOMNode,'DESGN_SUB_DESC/text()',vDESGN_SUB_DESC);
              --Get the Comp_Aid



               IF NVL(LENGTH((NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH((NVL(vBAND_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Band Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF NVL(LENGTH((NVL(vBAND_DESC,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Band Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vBAND_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Band Code special character found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vBAND_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:=' Invalid Band Code space found!';
                     GOTO PRINT_ERROR;
               END IF;

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);
               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

              vBAND_AID := HR_PK_VALIDATION.FN_GET_BAND_ID(vComp_Id,vBAND_MID);
              IF vBAND_AID IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Band Code '||vBAND_MID||' already exist';
                    GOTO PRINT_ERROR;
              END IF;

             -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
               OPEN curRec FOR
                    SELECT BAND_MID,COUNT(*)  FROM GM_BAND
                    WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Id)) AND UPPER(TRIM(BAND_DESC))=UPPER(TRIM(vBAND_DESC))
                    GROUP BY BAND_MID;
               FETCH curRec INTO pBAND_MID,vChkRecordCount;
               CLOSE curRec;

              IF vBAND_MID<>pBAND_MID AND vChkRecordCount >0 THEN

               vERROR_FLAG:='Y';
               vERROR_MSG:='Band Name already exist!';
                GOTO PRINT_ERROR;
             END IF;

            -- END IF;
               -- Checking duplicate data exist or not
              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL3)) = UPPER(TRIM(vBAND_DESC))
                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vBAND_DESC))='#NULL');
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Band Name found!';
                         GOTO PRINT_ERROR;
                     END IF;
            --   END IF;

              -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL2)) = UPPER(TRIM(vBAND_MID));
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Band Code found !';
                         GOTO PRINT_ERROR;
                     END IF;
              -- END IF;


               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_BAND
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(BAND_MID)) = UPPER(TRIM(vBAND_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_BAND
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(BAND_MID)) = UPPER(TRIM(vBAND_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record Does Not Exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vBAND_AID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_BAND',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vBAND_AID, vBAND_MID, vBAND_DESC  );
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vComp_Mid, vBAND_MID,vBAND_DESC);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID, COL2 BAND_AID, COL3 BAND_MID, COL4 BAND_DESC,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_BAND (COMP_AID, BAND_AID, BAND_MID, BAND_DESC,USER_CR, DATE_CR,ACTIVE_FLG)
                            VALUES(I.COMP_AID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_AID, 'GM_BAND',1), I.BAND_MID, I.BAND_DESC , I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_BAND
                    SET  BAND_DESC=DECODE(TRIM(I.BAND_DESC),'#NULL',BAND_DESC,TRIM(I.BAND_DESC))
                    ,USER_UP = I.UP_USER_ID, DATE_UP = I.UP_DATE
                    ,ACTIVE_FLG=1
                    WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(BAND_MID)) = UPPER(TRIM(I.BAND_MID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_BAND' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

            OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;


    END;

    PROCEDURE UPLOAD_GM_COUNTRY(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vCOUNTRY_CODE           GM_COUNTRY.COUNTRY_CODE %TYPE;

    vCOMP_MID              GM_COMP.COMP_MID%TYPE;
    vCOUNTRY_MID           GM_COUNTRY.COUNTRY_MID %TYPE;
    vCOUNTRY_NAME          GM_COUNTRY.COUNTRY_NAME%TYPE;
    --vTIME_DIFF             GM_COUNTRY.TIME_DIFF%TYPE;
    vTIME_DIFF               VARCHAR2(500) ;
    pCOUNTRY_MID           GM_COUNTRY.COUNTRY_MID %TYPE;

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
   -- vERROR_MSG                VARCHAR2(500);


   BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');




            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
                
                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCOUNTRY_MID:=NULL;vCOUNTRY_NAME:=NULL;vTIME_DIFF:=NULL;vCOUNTRY_CODE:=NULL;

                BEGIN

                dbms_xslprocessor.valueOf(vXmlDOMNode,'COUNTRY_CODE/text()',vCOUNTRY_MID);

                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for COUNTRY_CODE (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for COUNTRY_CODE';
                  END IF;
                  GOTO PRINT_ERROR;

                END;

                BEGIN

                dbms_xslprocessor.valueOf(vXmlDOMNode,'COUNTRY_NAME/text()',vCOUNTRY_NAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for COUNTRY_NAME (Max limit is 250 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for COUNTRY_NAME';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                dbms_xslprocessor.valueOf(vXmlDOMNode,'TIME_DIFFERENCE/text()',vTIME_DIFF);

                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for time_difference';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for time_difference';
                  END IF;
                  GOTO PRINT_ERROR;

                END;
                --dbms_xslprocessor.valueOf(vXmlDOMNode,'DESGN_SUB_DESC/text()',vDESGN_SUB_DESC);
               

               IF NVL(LENGTH(TRIM(NVL(vCOUNTRY_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='COUNTRY CODE should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOUNTRY_NAME,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' COUNTRY NAME should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

             vChkRecordCount :=HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOUNTRY_MID),'~!@#$%^&*()_+/-=.,');


               IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid COUNTRY CODE special character found!';
                         GOTO PRINT_ERROR;
               END IF;
               
               vChkRecordCount :=HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOUNTRY_MID),' ');

               IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:=' Invalid country code space found !';
                     GOTO PRINT_ERROR;
               END IF;

                IF  (vTIME_DIFF IS NOT NULL ) AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vTIME_DIFF))='#NULL') THEN

                   vChkRecordCount:= HR_PK_VALIDATION.FN_VAL_TIME_DIFF(TRIM(vTIME_DIFF));
                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Time Difference !';
                         GOTO PRINT_ERROR;
                     END IF;
                END IF;


              vCOUNTRY_CODE := CASE WHEN TRIM(UPPER(vCOUNTRY_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN TRIM(UPPER(vCOUNTRY_MID))
                                    ELSE HR_PK_VALIDATION.FN_GET_COUNTRY_CODE(vCOUNTRY_MID) END;

              IF vCOUNTRY_CODE IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='COUNTRY CODE '||vCOUNTRY_MID||' already exist';
                    GOTO PRINT_ERROR;
              END IF;
              
            IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

              OPEN curRec FOR
                 SELECT COUNTRY_MID,COUNT(*) FROM GM_COUNTRY 
                 WHERE  UPPER(TRIM(COUNTRY_NAME))=UPPER(TRIM(vCOUNTRY_NAME)) GROUP BY COUNTRY_MID;
              FETCH curRec INTO pCOUNTRY_MID,vChkRecordCount;
              CLOSE curRec; 

              IF vCOUNTRY_MID<>pCOUNTRY_MID AND vChkRecordCount >0 THEN
                vERROR_FLAG:='Y';
                vERROR_MSG:='COUNTRY NAME already exist!';
                GOTO PRINT_ERROR;
              END IF;

            END IF;

               -- Checking duplicate data exist or not
               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        where SESSION_ID = PSESSIONID and USER_AID = PUSER_AID and UPLOAD_AID = PUPLOAD_AID and UPLOAD_BATCH_ID = VUPLDBATCH_ID
                                AND  (UPPER(TRIM(COL1)) = UPPER(TRIM(vCOUNTRY_MID)) OR UPPER(TRIM(COL2)) = UPPER(TRIM(vCOUNTRY_NAME)));
                     FETCH CURREC into VCHKRECORDCOUNT;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_COUNTRY
                            WHERE   UPPER(TRIM(COUNTRY_MID)) = UPPER(TRIM(vCOUNTRY_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

                IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_COUNTRY
                            WHERE   UPPER(TRIM(COUNTRY_MID)) = UPPER(TRIM(vCOUNTRY_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;
                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vCOUNTRY_CODE  := HR_PK_VALIDATION.FN_GENERATE_AID('', 'GM_COUNTRY',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vCOUNTRY_CODE, vCOUNTRY_MID, vCOUNTRY_NAME, vTIME_DIFF);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, 
                  ROW_NO,COL1, COL2, COL3)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG
                  , I+2, vCOUNTRY_MID, vCOUNTRY_NAME,vTIME_DIFF);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COUNTRY_CODE, COL2 COUNTRY_MID, COL3 COUNTRY_NAME, COL4 TIME_DIFF,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_COUNTRY (COUNTRY_CODE, COUNTRY_MID, COUNTRY_NAME, TIME_DIFF,CR_USER_ID, CR_DATE,ACTIVE_FLG)
                            VALUES(I.COUNTRY_CODE, I.COUNTRY_MID, I.COUNTRY_NAME, I.TIME_DIFF , I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_COUNTRY SET 
                    COUNTRY_NAME=DECODE(TRIM(I.COUNTRY_NAME),'#NULL',COUNTRY_NAME,TRIM(I.COUNTRY_NAME))
                    , TIME_DIFF = DECODE(TRIM(I.TIME_DIFF),'#NULL',TIME_DIFF,TRIM(I.TIME_DIFF))
                    ,UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                    ,ACTIVE_FLG=1
                        WHERE   UPPER(TRIM(COUNTRY_MID)) = UPPER(TRIM(I.COUNTRY_MID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_COUNTRY' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

    END;

    PROCEDURE UPLOAD_GM_LOCATIONS(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vLOCATION_ID            GM_LOCATIONS.LOCATION_ID%TYPE;

    vCOMP_MID               GM_COMP.COMP_MID%TYPE;
    vLOCATION_MID           GM_LOCATIONS.LOCATION_MID%TYPE;
    vLOCATION_DESC          GM_LOCATIONS.LOCATION_DESC%TYPE;
    vLOCATION_SUB_DESC      GM_LOCATIONS.LOCATION_SUB_DESC%TYPE;
    vSTATE_MID              GM_STATE.STATE_MID%TYPE;
    vSTATE_ID               GM_STATE.STATE_CODE %TYPE;
    vHRA_RATE               NUMBER(18,2);
    vHOUSE_PERQ             NUMBER(18,2);
    vESIC_Applicable        GM_LOCATIONS.ESIC_APPLICABLE%TYPE;
    pLOCATION_MID           GM_LOCATIONS.LOCATION_MID%TYPE;

    vERROR_MSG              VARCHAR2(2000);
    vERROR_FLAG             VARCHAR2(1);
    vChkRecordCount         NUMBER;
    vUpldBatch_Id           HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    vACTIVE_STATE_CODE      VARCHAR2(50);
    
    vSRNO                   NUMBER;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
                
                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCOMP_MID:=NULL;vLOCATION_MID:=NULL;vLOCATION_DESC:=NULL;vLOCATION_SUB_DESC:=NULL;vSTATE_MID:=NULL;vHRA_RATE:=NULL;vHOUSE_PERQ:=NULL;
                vESIC_Applicable:=NULL;vComp_Id:=NULL; vLOCATION_ID:=NULL;vSTATE_ID:=NULL;

--                dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOCATION_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_NAME/text()',vLOCATION_DESC);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_SHORT_NAME/text()',vLOCATION_SUB_DESC);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_CODE/text()',vSTATE_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'HRA_RATE/text()',vHRA_RATE);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'HOUSE_PERQ_PERCENT/text()',vHOUSE_PERQ);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'ESIC_APPLICABLE/text()',vESIC_Applicable);
                --dbms_xslprocessor.valueOf(vXmlDOMNode,'BR_TEL/text()',vBR_TEL);

                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                    BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOCATION_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                
                      BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_NAME/text()',vLOCATION_DESC);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Location Code (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Location Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                
                        BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_SHORT_NAME/text()',vLOCATION_SUB_DESC);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Location Short Name(Max limit is 25 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Location Short Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                
                
                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_CODE/text()',vSTATE_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for State Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for State Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


               BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'HRA_RATE/text()',vHRA_RATE);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for HRA RATE';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for HRA RATE';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'HOUSE_PERQ_PERCENT/text()',vHOUSE_PERQ);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for House Perquisite Percent';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for House Perquisite Percent';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                
                   BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'ESIC_APPLICABLE/text()',vESIC_Applicable);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Esic Applicable (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Esic Applicable (Max limit is 1 character)';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
              --Get the Comp_Aid
               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF vLOCATION_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Location Code should not be blank';
                   GOTO PRINT_ERROR;
              END IF;

              IF vLOCATION_DESC IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Location Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vSTATE_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' State Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              IF NVL(LENGTH(TRIM(NVL(vLOCATION_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Location Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vLOCATION_DESC,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Location Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vSTATE_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='State Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vHRA_RATE IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='HRA Rate should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.fn_is_number(vHRA_RATE)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid HRA Rate ';
                   GOTO PRINT_ERROR;
               END IF;

--               IF vHOUSE_PERQ IS NULL THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='House Perq Percent should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

               IF HR_PK_VALIDATION.fn_is_number(vHOUSE_PERQ)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid House Perq Percent';
                   GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vLOCATION_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Location Code special character found!';
                         GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vLOCATION_MID),' ') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Location Code space found!';
                         GOTO PRINT_ERROR;
               END IF;

               IF NVL(UPPER(vESIC_Applicable),'X') NOT IN ('Y','N') AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vESIC_Applicable))='#NULL') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='ESIC Applicable field accepts Y or N only';
                    GOTO PRINT_ERROR;
               END IF;


               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               if(VSTATE_MID is not null) then
               
                vSTATE_ID := CASE WHEN TRIM(UPPER(vSTATE_MID))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                   ELSE HR_PK_VALIDATION.FN_GET_STATE_CODE(vSTATE_MID) END;

                IF vSTATE_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='State Code '||vSTATE_MID||' does not exist';
                    GOTO PRINT_ERROR;                   
                 END IF;
                
                   
                vACTIVE_STATE_CODE := CASE WHEN TRIM(UPPER(vSTATE_MID))='#NULL' AND pTrans_Type ='UPDATE'  THEN '#NULL'
                                    ELSE HR_PK_VALIDATION.FN_GET_ACTIVE_STATE_CODE(vSTATE_MID) END;

                 IF vACTIVE_STATE_CODE IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='State Code '||vSTATE_MID||' is Inactive ';
                    GOTO PRINT_ERROR;
                END IF;
                
               END IF;

             vLOCATION_ID := HR_PK_VALIDATION.FN_GET_LOCATION_ID(vComp_Id,vLOCATION_MID);

             IF vLOCATION_ID IS NOT NULL AND pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:=' Location Code '||vLOCATION_MID||' already exist' ;
                    GOTO PRINT_ERROR;
             END IF;

            -- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

             OPEN curRec FOR
                SELECT LOCATION_MID,COUNT(*) FROM GM_LOCATIONS
                 WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(vComp_Id)) AND UPPER(TRIM(LOCATION_DESC))=UPPER(TRIM(vLOCATION_DESC))
                 GROUP BY LOCATION_MID;
             FETCH curRec INTO pLOCATION_MID,vChkRecordCount;
             CLOSE curRec;
             
             IF pLOCATION_MID<>vLOCATION_MID AND vChkRecordCount >0  THEN

               vERROR_FLAG:='Y';
               vERROR_MSG:='Location Name already exist!';
                GOTO PRINT_ERROR;
                
             END IF;

--             IF vChkRecordCount >0 AND pTrans_Type <>'UPDATE' THEN

--               vERROR_FLAG:='Y';
--               vERROR_MSG:='Location Name already exist!';
--                GOTO PRINT_ERROR;
--             END IF;

            --  END IF;
--               IF LENGTH(TRIM(NVL(vDESGN_MID,' ')))=0 THEN
--                   vERROR_FLAG:='Y';
--                   vERROR_MSG:='DESG MID should not be blank';
--                   GOTO PRINT_ERROR;
--               END IF;

               -- Checking duplicate data exist or not
            --   IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vLOCATION_MID));
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found!';
                         GOTO PRINT_ERROR;
                     END IF;
            --   END IF;

               --- IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL3))=UPPER(TRIM(vLOCATION_DESC))
                                AND NOT (pTrans_Type = 'UPDATE' AND UPPER(TRIM(vLOCATION_DESC))='#NULL' );
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;
             ---  END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_LOCATIONS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_LOCATIONS
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCOMP_ID))  AND  UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vLOCATION_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_LOCATIONS',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6,COL7,COL8,COL9)
                   VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vLOCATION_ID, vLOCATION_MID,vLOCATION_DESC,vLOCATION_SUB_DESC,vSTATE_ID,vHRA_RATE,vHOUSE_PERQ,vESIC_Applicable);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vCOMP_MID,vLOCATION_MID,vLOCATION_DESC,vLOCATION_SUB_DESC,vSTATE_MID,vHRA_RATE,vHOUSE_PERQ,vESIC_Applicable);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        else
              vSRNO:=0;
            --Final data insert in base table GM_location
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_ID, COL2 LOCATION_ID, COL3 LOCATION_MID, COL4 LOCATION_DESC,COL5 LOCATION_SUB_DESC,COL6 STATE_ID,COL7 HRA_RATE,COL8 HOUSE_PERQ,COL9 ESIC_APPLICABLE,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                  vLOCATION_ID:=null;--                  
                        vLOCATION_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_LOCATIONS',vSRNO+1);
                  
                INSERT INTO GM_LOCATIONS (COMP_ID, LOCATION_ID, LOCATION_MID, LOCATION_DESC,LOCATION_SUB_DESC ,STATE_AID,HRA_RATE, HOUSE_PERQ,ESIC_APPLICABLE,CR_USER_ID,CR_DATE,ACTIVE_FLG)
                            VALUES(I.COMP_ID, I.LOCATION_ID, I.LOCATION_MID, I.LOCATION_DESC ,I.LOCATION_SUB_DESC, I.STATE_ID,I.HRA_RATE, I.HOUSE_PERQ, I.ESIC_APPLICABLE, I.CR_USER_ID ,I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_LOCATIONS
                    SET LOCATION_DESC= DECODE(TRIM(I.LOCATION_DESC),'#NULL',LOCATION_DESC,TRIM(I.LOCATION_DESC))
                        ,LOCATION_SUB_DESC= DECODE(TRIM(I.LOCATION_SUB_DESC),'#NULL',LOCATION_SUB_DESC,TRIM(I.LOCATION_SUB_DESC))
                        ,STATE_AID= DECODE(TRIM(I.STATE_ID),'#NULL',STATE_AID,TRIM(I.STATE_ID))
                        ,HRA_RATE= DECODE(TRIM(I.HRA_RATE),'#NULL',HRA_RATE,TRIM(I.HRA_RATE))
                        ,HOUSE_PERQ= DECODE(TRIM(I.HOUSE_PERQ),'#NULL',HOUSE_PERQ,TRIM(I.HOUSE_PERQ))
                        ,ESIC_APPLICABLE = DECODE(TRIM(I.ESIC_APPLICABLE),'#NULL',ESIC_APPLICABLE,TRIM(I.ESIC_APPLICABLE)),
                         UP_USER_ID = I.UP_USER_ID, UP_DATE = I.UP_DATE
                         ,ACTIVE_FLG=1
                        WHERE  UPPER(TRIM(COMP_ID)) = UPPER(TRIM(I.COMP_ID)) AND UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(I.LOCATION_MID));
                end if;
                vSRNO:=vSRNO+1;

            end LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_LOCATIONS' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

    END;





PROCEDURE UPLOAD_PT_EMP_CTC_DEFINE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser             dbms_xmlparser.Parser;
    vXmlDomDocument        dbms_xmldom.DOMDocument;
    vXmlDOMNodeList        dbms_xmldom.DOMNodeList;
    vXmlDOMNode            dbms_xmldom.DOMNode;
    vComp_Id               GM_COMP.COMP_ID%TYPE;
    vLOCATION_ID           GM_LOCATIONS.LOCATION_ID%TYPE;
    vACC_YEAR              VARCHAR2(10);
    vEMP_ID                GM_EMP.EMP_ID%TYPE;
    vEMP_MID               GM_EMP.EMP_MID%TYPE;
    aEMP_ID                GM_EMP.EMP_ID%TYPE;
    vEMP_CTC_ID            PM_EMP_CTC_DEFINE.EMP_CTC_ID%TYPE;
    aEMP_CTC_ID            PM_EMP_CTC_DEFINE.EMP_CTC_ID%TYPE;

    vCOMP_MID              GM_COMP.COMP_MID%TYPE;
    vALLWDED_MID           CTC_ALLOWANCE_MAST.CTC_MID%TYPE;
    vAMOUNT                PT_EMP_CTC_DEFINE.AMOUNT%TYPE;
    vMONTH_AMT             PT_EMP_CTC_DEFINE.MONTH_AMT%TYPE;
    vEFF_DATE_FR           VARCHAR2(200);
    vCTCAMOUNT             PM_EMP_CTC_DEFINE.CTCAMOUNT%TYPE;
    vALLWDED_AID           CTC_ALLOWANCE_MAST.CTC_CODE%TYPE;
    vALLWDED_TYPE          CTC_ALLOWANCE_MAST.CTC_TYPE%TYPE; 
    aEFF_DATE_FR           VARCHAR2(200);--PM_EMP_CTC_DEFINE.EFF_DATE_FR%TYPE;
    --vDESGN_DESC         GM_LOCATIONS.DESGN_DESC%TYPE;
    V_JOIN_DATE              DATE;

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    cEMP_ID                   NUMBER;
    cEFF_DATE_FR              NUMBER;


    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

           vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

           vXmlParser := dbms_xmlparser.newParser;
           dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
           vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
           vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

          FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCOMP_MID:=NULL;vEMP_MID:=NULL;vALLWDED_MID:=NULL;vEFF_DATE_FR:=NULL;vMONTH_AMT:=NULL;vCTCAMOUNT:=NULL;
                vComp_Id:=NULL;vEMP_CTC_ID:=NULL;vEMP_ID:=NULL;vALLWDED_AID:=NULL;     

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'ALLOWANCE_CODE/text()',vALLWDED_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Allowance Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Allowance Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                      dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_FROM/text()',aEFF_DATE_FR);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Effective Date From should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Effective Date From should be date';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                      dbms_xslprocessor.valueOf(vXmlDOMNode,'MONTHLY_AMOUNT/text()',vMONTH_AMT);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Monthly Amount (Max limit is 18 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Monthly Amount ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'CTC_AMOUNT/text()',vCTCAMOUNT);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for CTC Amount (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for CTC Amount';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                vEFF_DATE_FR:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(aEFF_DATE_FR));

                IF vEMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Employee Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;

                IF vALLWDED_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Allowance Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vEFF_DATE_FR IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='  Effective Date From should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

--               vChkRecordCount:= HR_PK_VALIDATION.FN_DATE_VALDATION(TRIM(vEFF_DATE_FR)) ;
--
--                IF vChkRecordCount > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='INVALID EFF_DATE_FR !';
--                         GOTO PRINT_ERROR;
--                END IF;

               IF vMONTH_AMT IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Monthly Amount should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vCTCAMOUNT IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' CTC AMOUNT should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


              IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vALLWDED_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Allowance Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              vChkRecordCount :=HR_PK_VALIDATION.FN_IS_DATE(TRIM(vEFF_DATE_FR));

                 IF vChkRecordCount =0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Effective Date From!';
                     GOTO PRINT_ERROR;
                END IF;

                -- START added by vinayak patil--  
              IF HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vEFF_DATE_FR)=0 THEN
                   vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Format of From Date ';
                    GOTO PRINT_ERROR;                
                END IF;
                -- end added by vinayak patil--  

               vEFF_DATE_FR:=TO_DATE(vEFF_DATE_FR,'DD-MM-RRRR');

               vChkRecordCount :=HR_PK_VALIDATION.FN_IS_NUMBER(TRIM(vAMOUNT));

             IF vChkRecordCount =0 THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Invalid Amount';
                 GOTO PRINT_ERROR;
            END IF;

           vChkRecordCount :=HR_PK_VALIDATION.FN_IS_NUMBER(TRIM(vMONTH_AMT));

             IF vChkRecordCount =0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Monthly Amount';
                     GOTO PRINT_ERROR;
            END IF;

           vChkRecordCount :=HR_PK_VALIDATION.FN_IS_NUMBER(TRIM(vCTCAMOUNT));

             IF vChkRecordCount =0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid CTC Amount';
                     GOTO PRINT_ERROR;
            END IF;


           IF(TO_NUMBER(vMONTH_AMT)>TO_NUMBER(vCTCAMOUNT)) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='CTC Amount should be greater than Monthly Amount';
                 GOTO PRINT_ERROR;
           END IF;

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='COMPANY CODE '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               vEMP_ID := HR_PK_VALIDATION.FN_GET_EMP_AID(  vComp_Id,vEMP_MID);

               IF vEMP_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Employee Code '||vEMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               vALLWDED_AID := HR_PK_VALIDATION.FN_GET_ALLWDED_AID(vComp_Id,vALLWDED_MID,'CTC');

               IF vALLWDED_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Allowance Code '||vALLWDED_MID||' is invalid.'||chr(13)||' It should be defined in Allowance Master & (i)be Part of CTC & (ii)not be OTHER THAN CTC';
                    GOTO PRINT_ERROR;
               END IF;
               
               vALLWDED_TYPE := HR_PK_VALIDATION.FN_GET_ALLWDED_TYPE(vComp_Id,vALLWDED_MID);
               
               IF vALLWDED_TYPE = 'D' THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Allowance Code '||vALLWDED_MID||' is a Deduction,Hence it is not allowed';
                    GOTO PRINT_ERROR;
               END IF;
               
               SELECT TO_DATE(JOIN_DATE,'DD-MM-RRRR') INTO V_JOIN_DATE  FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))= UPPER(TRIM(vComp_Id)) AND  UPPER(TRIM(EMP_ID))=UPPER(TRIM(vEMP_ID)) ;

              IF( TO_DATE(vEFF_DATE_FR,'DD-MM-RRRR' ) <TO_DATE( V_JOIN_DATE,'DD-MM-RRRR') ) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Effective From Date should be greater than/equal to Join Date';
                 GOTO PRINT_ERROR;
              END IF;

               -- Checking duplicate data exist or not
               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

                    OPEN curRec FOR
                        SELECT COUNT(*)
                        FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vEMP_MID))  and UPPER(TRIM(COL3))=UPPER(TRIM(vALLWDED_MID));
                    FETCH curRec INTO vChkRecordCount;
                    CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Allowance code '||UPPER(TRIM(vALLWDED_MID))||' found for Employee code '||UPPER(TRIM(vEMP_MID));
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               SELECT    COUNT (DISTINCT COL4)  INTO cEFF_DATE_FR FROM  HR_TEMP_RAW_UPLOAD  WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID and COL2=vEMP_MID AND ERROR_MSG IS NULL ;

               IF(cEFF_DATE_FR >0) THEN

               SELECT    DISTINCT COL4  INTO aEFF_DATE_FR FROM  HR_TEMP_RAW_UPLOAD  WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID and COL2=vEMP_MID AND ERROR_MSG IS NULL ;

                   IF(TO_DATE(vEFF_DATE_FR,'DD-MM-RRRR')<>TO_DATE(aEFF_DATE_FR,'DD-MM-RRRR')) THEN
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Effective Date '||vEFF_DATE_FR||' should be same for all the allowances!';
                      GOTO PRINT_ERROR;
                   END IF;
               END IF;

               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

                  SELECT DISTINCT COUNT(COL3) INTO cEMP_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id AND COL3=vEMP_ID ;

                    IF(cEMP_ID = 0 ) THEN
                       IF(I=0) THEN
                          vEMP_CTC_ID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'PM_EMP_CTC_DEFINE',I+1);
                       ELSE
--                          SELECT  TO_NUMBER(MAX(SUBSTR(COL2,3)))   INTO   aEMP_CTC_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id  ;
--                          vEMP_CTC_ID:='EC'||TRIM(TO_CHAR(NVL(aEMP_CTC_ID,0)+1,'000000'));
--                            SELECT  TO_NUMBER(MAX(SUBSTR(COL2,11)))  INTO   aEMP_CTC_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id  ;
                              SELECT  TO_NUMBER(MAX(SUBSTR(COL2,11)))  INTO   aEMP_CTC_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE COL1= vComp_Id  ;
                              --UPDATED BY ANISH ON 4TH JULY 2014
                            vEMP_CTC_ID:='EC'||TO_CHAR(SYSDATE,'DDMMYYYY')||TRIM(TO_CHAR(NVL(aEMP_CTC_ID,0)+1,'000000'));
                        END IF;
                    ELSE
                    SELECT DISTINCT COL2 INTO vEMP_CTC_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id AND COL3=vEMP_ID;
                    END IF;
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6,COL7,COL8,COL9)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id,vEMP_CTC_ID ,vEMP_ID, vALLWDED_AID,vEFF_DATE_FR,vMONTH_AMT,vCTCAMOUNT,pAcc_Year,vEMP_MID);                END IF;
                   --COMMIT;
             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2,
                        vCOMP_MID,vEMP_MID,vALLWDED_MID,vEFF_DATE_FR,vMONTH_AMT,vCTCAMOUNT);

                 COMMIT;

            END LOOP;

--            UPDATE HR_TEMP_RAW_UPLOAD SET ERROR_FLAG='Y',ERROR_MSG='CTC can not be uploaded. Some of the CTC component has error'
--            WHERE UPLOAD_BATCH_ID=vUpldBatch_Id AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND  UPLOAD_AID=pUpload_Aid AND ERROR_FLAG<>'Y'
--             AND (COL1, COL2) IN
--            (SELECT COL1, COL2 FROM HR_TEMP_RAW_UPLOAD
--             WHERE  UPLOAD_BATCH_ID=vUpldBatch_Id AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND  UPLOAD_AID=pUpload_Aid
--                AND ERROR_FLAG IS NOT NULL AND  ERROR_MSG IS NOT NULL);

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            IF(pOperationType = 'COMMIT_UPLOAD') THEN--Final data insert in base table GM_GRADE_MSTR
                FOR I IN ( SELECT  TRANS_TYPE,COMP_ID,EMP_CTC_ID,EMP_ID,EFF_DATE_FR,SUM(MONTH_AMT) CTCAMOUNT,ACC_YEAR,pUser_Aid USER_CR, SYSDATE DATE_CR ,pUser_Aid USER_UP, SYSDATE DATE_UP 
                            FROM   (SELECT  TRANS_TYPE, COL1 COMP_ID, COL2 EMP_CTC_ID, COL3 EMP_ID, COL4 ALLWDED_AID,COL5 EFF_DATE_FR,COL6 MONTH_AMT, COL7 CTCAMOUNT ,COL8 ACC_YEAR,COL9 EMP_MID                             
                           FROM HR_VW_FINAL_UPLOAD_DATA
                           WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                            AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD') WHERE EMP_MID NOT IN (SELECT COL2 FROM HR_TEMP_RAW_UPLOAD  WHERE  UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND ERROR_MSG IS NOT NULL    ) GROUP BY TRANS_TYPE,COMP_ID,EMP_CTC_ID,EMP_ID,EFF_DATE_FR,ACC_YEAR)
                LOOP

                    IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD','UPDATE') THEN

                        UPDATE PM_EMP_CTC_DEFINE SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR')-1
                        WHERE COMP_ID = I.COMP_ID  AND EMP_ID = I.EMP_ID AND (EFF_DATE_TO IS NULL OR EFF_DATE_TO>=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR'));

                        INSERT INTO PM_EMP_CTC_DEFINE (COMP_ID, EMP_CTC_ID, EMP_ID, EFF_DATE_FR,CTCAMOUNT, ACC_YEAR ,USER_CR,DATE_CR)
                                VALUES(I.COMP_ID, I.EMP_CTC_ID, I.EMP_ID, TO_DATE(I.EFF_DATE_FR) ,I.CTCAMOUNT,I.ACC_YEAR,I.USER_CR ,I.DATE_CR);

--                    ELSIF I.TRANS_TYPE IN ('UPDATE') THEN
--
--                        UPDATE PM_EMP_CTC_DEFINE SET CTCAMOUNT  = I.CTCAMOUNT,EFF_DATE_FR=I.EFF_DATE_FR ,USER_UP = I.USER_UP, DATE_UP = I.DATE_UP
--                            WHERE  COMP_ID = I.COMP_ID AND  EMP_CTC_ID=I.EMP_CTC_ID AND EMP_ID = I.EMP_ID ;
                    END IF;

                END LOOP;

                 FOR I IN (  SELECT  TRANS_TYPE,EMP_CTC_ID,ROW_NUMBER() OVER (PARTITION BY EMP_CTC_ID ORDER BY ALLWDED_AID  ) SR_NO ,ALLWDED_AID,MONTH_AMT,CTCAMOUNT,COMP_ID
                             FROM (SELECT  TRANS_TYPE, COL1 COMP_ID, COL2 EMP_CTC_ID, COL3 EMP_ID, COL4 ALLWDED_AID,COL5 EFF_DATE_FR,COL6 MONTH_AMT, COL7 CTCAMOUNT ,COL8 ACC_YEAR,COL9 EMP_MID
                                  ,pUser_Aid USER_CR, SYSDATE DATE_CR ,pUser_Aid USER_UP, SYSDATE DATE_UP
                                  FROM HR_VW_FINAL_UPLOAD_DATA
                                  WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                                  AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
                             WHERE EMP_MID NOT IN (SELECT COL2 FROM HR_TEMP_RAW_UPLOAD  WHERE  UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND ERROR_MSG IS NOT NULL    ))
                LOOP

                    IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD','UPDATE') THEN

                        INSERT INTO PT_EMP_CTC_DEFINE ( EMP_CTC_ID, SRNO, ALLWDED_AID, MONTH_AMT,AMOUNT,COMP_ID )
                                VALUES(I.EMP_CTC_ID, I.SR_NO, I.ALLWDED_AID ,I.MONTH_AMT,I.CTCAMOUNT,I.COMP_ID);

--                    ELSIF I.TRANS_TYPE IN ('UPDATE') THEN
--
--                        UPDATE PT_EMP_CTC_DEFINE SET MONTH_AMT=I.MONTH_AMT
--                            WHERE  EMP_CTC_ID = I.EMP_CTC_ID AND  ALLWDED_AID=I.ALLWDED_AID ;
                    END IF;

                END LOOP;
            END IF;
            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PT_EMP_CTC_DEFINE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;
    END;


 PROCEDURE UPLOAD_GM_BANK(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser                dbms_xmlparser.Parser;
    vXmlDomDocument           dbms_xmldom.DOMDocument;
    vXmlDOMNodeList           dbms_xmldom.DOMNodeList;
    vXmlDOMNode               dbms_xmldom.DOMNode;
    vComp_Aid                 GM_COMP.COMP_ID%TYPE;
    vBANK_AID                GM_BANK.BANK_AID%TYPE;
    vBand_Aid                 GM_BAND.BAND_AID%TYPE;

    vCOMP_MID                 GM_COMP.COMP_MID%TYPE;
    vBANK_MID                GM_BANK.BANK_MID%TYPE;
    vBANK_NAME                GM_BANK.BANK_NAME%TYPE;
    vBAND_MID                 GM_BAND.BAND_MID%TYPE;
    pBANK_MID                GM_BANK.BANK_MID%TYPE;

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><GRADE_MID>0001</GRADE_MID><GRADE_NAME>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);


                 vERROR_MSG:= NULL;
                 vERROR_FLAG:='N';
                
                vComp_Mid:=NULL;vBANK_MID:=NULL;vBANK_NAME:=NULL;vComp_Aid:=NULL;vBANK_AID:=NULL;  

                 BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                      dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_CODE/text()',vBANK_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Bank Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Bank Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                      dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_NAME/text()',vBANK_NAME);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                    vERROR_MSG:='Invalid value for Bank Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Bank Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                --dbms_xslprocessor.valueOf(vXmlDOMNode,'BAND_MID/text()',vBAND_MID);

                IF vBANK_NAME IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' BANK NAME should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


                IF NVL(LENGTH(TRIM(NVL(vBANK_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:=' Bank Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              vComp_Aid := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Aid IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vBANK_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Bank Code, special character found !';
                     GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vBANK_MID),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Bank Code, space found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_BANK
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_AID))  AND UPPER(TRIM(BANK_MID)) = UPPER(TRIM(vBANK_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


              --Get the Comp_Aid
             --IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

              OPEN curRec FOR
                  SELECT BANK_MID,COUNT(*) 
                   FROM GM_BANK WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Aid))
                    AND UPPER(TRIM(BANK_NAME))=UPPER(TRIM(vBANK_NAME))
                  GROUP BY BANK_MID;
              FETCH curRec INTO pBANK_MID,vChkRecordCount;
              CLOSE curRec;
              
              IF pBANK_MID<>vBANK_MID AND vChkRecordCount >0  THEN

               vERROR_FLAG:='Y';
               vERROR_MSG:='Bank Name already exist!';
               GOTO PRINT_ERROR;
                
             END IF;

--             IF vChkRecordCount >0 AND pTrans_Type <>'UPDATE' THEN

--               vERROR_FLAG:='Y';
--               vERROR_MSG:='Bank Name already exist!';
--                GOTO PRINT_ERROR;
--             END IF;

               -- Checking duplicate data exist or not

                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE TRIM(SESSION_ID) = TRIM(pSessionId) AND TRIM(USER_AID) = TRIM(pUSER_AID) AND TRIM(UPLOAD_AID) = TRIM(pUpload_Aid) AND TRIM(UPLOAD_BATCH_ID) = TRIM(vUpldBatch_Id)
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL2)) = UPPER(TRIM(vBANK_MID));
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;

                     OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE TRIM(SESSION_ID) = TRIM(pSessionId) AND TRIM(USER_AID) = TRIM(pUSER_AID) AND TRIM(UPLOAD_AID) = TRIM(pUpload_Aid) AND TRIM(UPLOAD_BATCH_ID) = TRIM(vUpldBatch_Id)
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vComp_Mid)) AND  UPPER(TRIM(COL3)) = UPPER(TRIM(vBANK_NAME))
                                AND NOT (pTrans_Type = 'UPDATE' AND UPPER(TRIM(vBANK_NAME))='#NULL' );
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;
            --   END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_BANK
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_AID))  AND UPPER(TRIM(BANK_MID)) = UPPER(TRIM(vBANK_MID));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

              -- vBand_Aid  := NVL(HR_PK_VALIDATION.FN_GET_BAND_AID(vComp_Aid, vBand_Mid),'NA');

               --Get the Grade_Aid
               IF pTrans_Type IN ( 'ADD','REMOVE AND ADD' ) THEN
                    vBANK_AID  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Aid, 'GM_BANK',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3,COL4)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Aid, vBANK_AID,vBANK_MID, vBANK_NAME);
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vComp_Mid, vBANK_MID, vBANK_NAME);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID, COL2  BANK_AID, COL3  BANK_MID, COL4  BANK_NAME,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE,pUser_Aid USER_AT, SYSDATE DATE_AT
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_BANK (COMP_AID,BANK_AID, BANK_MID, BANK_NAME, USER_CR, DATE_CR,ACTIVE_FLG)
                            VALUES(I.COMP_AID, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_AID, 'GM_BANK',1), I.BANK_MID, I.BANK_NAME,  I.CR_USER_ID, I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_BANK SET BANK_NAME  = DECODE(TRIM(I.BANK_NAME),'#NULL',BANK_NAME,TRIM(I.BANK_NAME))
                        , USER_UP = I.UP_USER_ID, DATE_UP = I.UP_DATE
                        ,ACTIVE_FLG=1
                        WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(BANK_MID)) = UPPER(TRIM(I.BANK_MID));

                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

        COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_BANK' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;

     PROCEDURE UPLOAD_GM_ATTRIBUTE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser                dbms_xmlparser.Parser;
    vXmlDomDocument           dbms_xmldom.DOMDocument;
    vXmlDOMNodeList           dbms_xmldom.DOMNodeList;
    vXmlDOMNode               dbms_xmldom.DOMNode;
    vComp_Aid                 GM_COMP.COMP_ID%TYPE;
    vATTB_AID                 GM_ATTRIBUTE.ATTB_AID%TYPE;
    V_MSG                     VARCHAR2(200);
    vValidationChar           VARCHAR2(200);
    vCOMP_MID                 VARCHAR2(200);
    vATTB_MID                 VARCHAR2(200);
    vATTB_DESC                VARCHAR2(200);
    vACTIVE_FLG               VARCHAR2(200);
    vIS_SUB_ATTB_ACTIVE       VARCHAR2(200);
    vDATA_TYPE                VARCHAR2(200);
    vMaster_Aid               VARCHAR2(200);
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><GRADE_MID>0001</GRADE_MID><GRADE_NAME>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

         --  '<NewDataSet><ExcelInfo><COMP_MID>BCD</COMP_MID><ATTB_MID>45</ATTB_MID><ATTB_DESC>@@@@@@@@@@@</ATTB_DESC><ACTIVE>Y</ACTIVE><IS_SUB_ATTB_ACTIVE>N</IS_SUB_ATTB_ACTIVE><DATA_TYPE>TEXT33333</DATA_TYPE></ExcelInfo></NewDataSet>';

             vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vComp_AId :=NULL;vATTB_AID:=NULL; vATTB_MID:=NULL;vATTB_DESC:=NULL;vACTIVE_FLG:=NULL;vIS_SUB_ATTB_ACTIVE:=NULL;VDATA_TYPE:=NULL;vValidationChar:=NULL;V_MSG:=NULL;vCOMP_MID:=NULL;

                BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);

                  EXCEPTION
                  
                  WHEN OTHERS THEN
                 -- vERROR_FLAG :=SQLCODE;
                 -- vERROR_MSG:=SQLERRM;

                  IF SQLCODE ='-24331' THEN
                  vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                  vERROR_FLAG:='Y';
                  ELSE
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;

                END;

                BEGIN
                dbms_xslprocessor.valueOf(vXmlDOMNode,'ATTRIBUTE_CODE/text()',vATTB_MID);

                  EXCEPTION

                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Attribute Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Attribute Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'ATTRIBUTE_DESCRIPTION/text()',vATTB_DESC);
                  EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Attribute Description (Max limit is 150 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Attribute Description';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                   BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTIVE/text()',vACTIVE_FLG);
                  EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Active (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Active';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                   BEGIN
                dbms_xslprocessor.valueOf(vXmlDOMNode,'ALLOW_SUB_ATTRIBUTE/text()',vIS_SUB_ATTB_ACTIVE);
                  EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Allow Sub Attribute (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Allow Sub Attribute';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'DATA_TYPE/text()',vDATA_TYPE);
                EXCEPTION WHEN OTHERS THEN
                    IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Data Type (Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Data Type';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

--

               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
               
               IF vATTB_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Attribute Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
                IF vATTB_DESC IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Attribute Description should not be blank';
                  GOTO PRINT_ERROR;
               END IF;
               
               IF vACTIVE_FLG IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Active should not be blank';
                  GOTO PRINT_ERROR;
               END IF;
               
                IF vIS_SUB_ATTB_ACTIVE IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Allow Sub Attribute should not be blank';
                  GOTO PRINT_ERROR;
               END IF;
               
               
                IF vDATA_TYPE IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Data Type should not be blank';
                  GOTO PRINT_ERROR;
                 END IF;


               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOMP_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Company Code special character found!';
                     GOTO PRINT_ERROR;
               END IF;

                vComp_AID := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;
            

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vATTB_MID),'~!@#$%^&*()+=.,''') > 0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid Attribute Code special character found!';
                   GOTO PRINT_ERROR;
               END IF;

            

                IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vATTB_DESC),'~!@#$%^&*()+=.,''') > 0 THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Invalid Attribute Description special character found!';
                 GOTO PRINT_ERROR;
               END IF;

           

               IF UPPER(TRIM(vACTIVE_FLG)) NOT IN ('Y','N') AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vACTIVE_FLG))='#NULL')  THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Active should be either Y or N';
                  GOTO PRINT_ERROR;
               END IF;

              

                 IF UPPER(TRIM(vIS_SUB_ATTB_ACTIVE)) NOT IN ('Y','N') AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vIS_SUB_ATTB_ACTIVE))='#NULL') THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Allow Sub Attribute should be either Y or N';
                  GOTO PRINT_ERROR;
               END IF;

              
               IF   TRIM(UPPER(vIS_SUB_ATTB_ACTIVE)) ='N' then
                    IF UPPER(TRIM(vDATA_TYPE)) NOT IN('TEXT','NUMBER','DATE') THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Invalid Data Type';
                       GOTO PRINT_ERROR;
                   END IF;

               ELSE
                   vDATA_TYPE:='NA' ;
               END IF;

               IF UPPER(TRIM(vDATA_TYPE)) ='TEXT' THEN
                  V_MSG := 'Special character ~!@#$%^&*()_+=-[]{}\|;:?/<>,."`'' are not allowed and max limit is 500 character.';
                  vValidationChar:='~!@#$%^&*()_+=-[]{}\|;:?/<>,."`''';
               END IF;

               IF UPPER(TRIM(vDATA_TYPE)) = 'NUMBER' THEN
                  V_MSG := 'Number format should be 99999999999999999.99 and max limit is 20 character';
                  vValidationChar:='99999999999999999.99';
               END IF;

               IF UPPER(TRIM(vDATA_TYPE)) = 'DATE' THEN
                  V_MSG := 'Date format should be DD-MMM-YYYY and max limit is 11 character';
                  vValidationChar:='DD-MMM-YYYY';
               END IF;

                OPEN curRec FOR
                SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                WHERE SESSION_ID = pSessionId
                AND USER_AID = pUSER_AID
                AND UPLOAD_AID = pUpload_Aid
                AND UPLOAD_BATCH_ID = vUpldBatch_Id
                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID))
                and (UPPER(TRIM(COL2))=UPPER(TRIM(vATTB_MID))
                OR (UPPER(TRIM(COL3))=UPPER(TRIM(vATTB_DESC)) AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vATTB_DESC))='#NULL')));

                FETCH curRec INTO vChkRecordCount;
                CLOSE  curRec;

                IF vChkRecordCount > 0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Duplicate record found !';
                    GOTO PRINT_ERROR;
                END IF;

               IF pTrans_Type IN ('REMOVE AND ADD','ADD') THEN

                 SELECT COUNT(*) INTO vChkRecordCount FROM GM_ATTRIBUTE
                 WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_AId)) AND  UPPER(TRIM(ATTB_MID))=UPPER(TRIM(vATTB_MID));
                 IF vChkRecordCount >0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Attribute Code already exists,It should be unique!';
                     GOTO PRINT_ERROR;
                 END IF;

                 SELECT COUNT(*) INTO vChkRecordCount FROM GM_ATTRIBUTE
                 WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_AId)) AND  UPPER(TRIM(ATTB_DESC))=UPPER(TRIM(vATTB_DESC));
                 IF vChkRecordCount >0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Attribute Description already exist,should be unique!';
                     GOTO PRINT_ERROR;
                 END IF;

               END IF;

               IF pTrans_Type IN ('UPDATE') THEN

                 SELECT COUNT(*) INTO vChkRecordCount
                 FROM GM_ATTRIBUTE
                 WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_AId))
                 AND  UPPER(TRIM(ATTB_MID))=UPPER(TRIM(vATTB_MID));
                 IF vChkRecordCount =0  THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Record does not exist';
                     GOTO PRINT_ERROR;
                 END IF;

                 SELECT COUNT(*) INTO vChkRecordCount
                 FROM GM_ATTRIBUTE
                 WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_AId))
                 AND  UPPER(TRIM(ATTB_MID))<>UPPER(TRIM(vATTB_MID))
                 AND  UPPER(TRIM(ATTB_DESC))=UPPER(TRIM(vATTB_DESC));
                 IF vChkRecordCount >1 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Attribute Description already exist';
                     GOTO PRINT_ERROR;
                 END IF;

               END IF;

                 vATTB_AID:= HR_PK_VALIDATION.FN_GENERATE_AID(vComp_AId,'GM_ATTRIBUTE',I+1);

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN

                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2,COL3, COL4,COL5,COL6,COL7,COL8,COL9,COL10)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_AId,vATTB_AID, vATTB_MID,vATTB_DESC, TRIM(UPPER(vACTIVE_FLG)),UPPER(TRIM(vIS_SUB_ATTB_ACTIVE))
                    ,UPPER(TRIM(VDATA_TYPE)),vValidationChar,V_MSG,DECODE(vDATA_TYPE,'TEXT','500','DATE','11','NUMBER','20','0'));

                END IF;

                <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vCOMP_MID, vATTB_MID,vATTB_DESC, vACTIVE_FLG,vIS_SUB_ATTB_ACTIVE,vDATA_TYPE);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID,COL2 ATTB_AID, COL3 ATTB_MID ,COL4 ATTB_DESC, COL5  ACTIVE_FLAG,COL6 IS_SUB_ATTB_ACTIVE,
                       COL7 DATA_TYPE,COL8 VALIDATION,COL9 VALIDATION_SUMMARY ,COL10 DATA_LIMIT ,pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE,pUser_Aid USER_AT, SYSDATE DATE_AT
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId
                       AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                       AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_ATTRIBUTE (COMP_AID,ATTB_AID,ATTB_MID, ATTB_DESC, ACTIVE_FLG, LIST_FLAG,DATA_TYPE,VALIDATION,VALIDATION_SUMMARY,DATA_LIMIT,USER_CR,DATE_CR)
                    VALUES(I.COMP_AID,HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_AID,'GM_ATTRIBUTE',1),I.ATTB_MID,I.ATTB_DESC,I.ACTIVE_FLAG,I.IS_SUB_ATTB_ACTIVE,--CASE WHEN I.IS_SUB_ATTB_ACTIVE ='N' THEN I.DATA_TYPE ELSE 'NA' END,
                    DECODE(UPPER(I.IS_SUB_ATTB_ACTIVE),'N',I.DATA_TYPE,'NA'),DECODE(UPPER(I.IS_SUB_ATTB_ACTIVE),'N',I.VALIDATION,'NA'),
                    DECODE(UPPER(I.IS_SUB_ATTB_ACTIVE),'N',I.VALIDATION_SUMMARY,'NA'),I.DATA_LIMIT,pUser_Aid,SYSDATE);

                    IF UPPER(I.IS_SUB_ATTB_ACTIVE) in('N') AND UPPER(I.ACTIVE_FLAG) in('Y') THEN

                      INSERT INTO PM_SUB_ATTRIBUTE(COMP_AID,ATTB_AID,SUB_ATTB_AID,SUB_ATTB_MID,SUB_ATTB_DESC,USER_CR,DATE_CR)
                      VALUES ( I.COMP_AID,I.ATTB_AID,'SB000000',I.ATTB_MID,I.ATTB_MID,pUser_Aid,SYSDATE);

                    END IF;

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_ATTRIBUTE
                    SET ATTB_DESC = DECODE(TRIM(I.ATTB_DESC),'#NULL',ATTB_DESC,TRIM(I.ATTB_DESC))
                    ,ACTIVE_FLG = DECODE(TRIM(I.ACTIVE_FLAG),'#NULL',ACTIVE_FLG,TRIM(I.ACTIVE_FLAG))
                    ,LIST_FLAG = DECODE(TRIM(I.IS_SUB_ATTB_ACTIVE),'#NULL',LIST_FLAG,TRIM(I.IS_SUB_ATTB_ACTIVE))
                    ,DATA_TYPE = DECODE(TRIM(I.DATA_TYPE),'#NULL',DATA_TYPE,DECODE(UPPER(I.IS_SUB_ATTB_ACTIVE),'N',I.DATA_TYPE,'NA'))
                    ,VALIDATION = DECODE(TRIM(I.VALIDATION),'#NULL',VALIDATION,DECODE(UPPER(I.IS_SUB_ATTB_ACTIVE),'N',I.VALIDATION,'NA'))
                    ,VALIDATION_SUMMARY = DECODE(TRIM(I.VALIDATION_SUMMARY),'#NULL',VALIDATION_SUMMARY,DECODE(UPPER(I.IS_SUB_ATTB_ACTIVE),'N',I.VALIDATION_SUMMARY,'NA'))
                    ,DATA_LIMIT = DECODE(TRIM(I.DATA_LIMIT),'#NULL',DATA_LIMIT,TRIM(I.DATA_LIMIT))
                    ,USER_UP=pUser_Aid,DATE_UP = SYSDATE
                    WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(ATTB_MID)) = UPPER(TRIM(I.ATTB_MID));

                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

        COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

       EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_ATTRIBUTE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;

 PROCEDURE UPLOAD_PM_SUB_ATTRIBUTE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser               dbms_xmlparser.Parser;
    vXmlDomDocument          dbms_xmldom.DOMDocument;
    vXmlDOMNodeList          dbms_xmldom.DOMNodeList;
    vXmlDOMNode              dbms_xmldom.DOMNode;
    vComp_Aid                GM_COMP.COMP_ID%TYPE;
    vATTB_AID                GM_ATTRIBUTE.ATTB_AID%TYPE;
    vSUB_ATTB_MID            VARCHAR2(20);
    vSUB_ATTB_DESC           VARCHAR2(150); -- vSUB_ATTB_DESC           VARCHAR2(30);
    vCOMP_MID                VARCHAR2(8);
    vATTB_MID                VARCHAR2(20);
    vATTB_DESC               VARCHAR2(20);
    vSUB_ATTB_AID            PM_SUB_ATTRIBUTE.SUB_ATTB_AID%TYPE;
    vIS_SUB_ATTB_ACTIVE      VARCHAR2(1);
    vDATA_TYPE               VARCHAR2(20);
    vERROR_MSG               VARCHAR2(2000);
    vERROR_FLAG              VARCHAR2(1);
    vChkRecordCount          NUMBER;
    vUpldBatch_Id            HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    vIsLIST_FLAG             GM_ATTRIBUTE.LIST_FLAG%TYPE;
    vACTIVE_FLG              GM_ATTRIBUTE.ACTIVE_FLG%TYPE;
    vSAP_CODE                VARCHAR2(15);
    vGL_CODE                 VARCHAR2(15);
    vGL_DESC                 VARCHAR2(100);
    vSUB_ATTB_SDESC          VARCHAR2(100);
    vSPECIAL_CHAR            VARCHAR2(50); 
    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

          --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><GRADE_MID>0001</GRADE_MID><GRADE_NAME>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';
          -- '<NewDataSet><ExcelInfo><COMP_MID>BCD</COMP_MID><ATTB_MID>DESG</ATTB_MID><SUB_ATTB_MID>rt45</SUB_ATTB_MID><SUB_ATTB_DESC>\\----</SUB_ATTB_DESC>
          -- <SUB_ATTB_SDESC>ddsfds543543%% </SUB_ATTB_SDESC><SAP_CODE>gfdgfdgfdgfdgfdgfdgfdgfdgfd654645645645656</SAP_CODE><GL_CODE>BBB</GL_CODE><GL_DESC>CCC</GL_DESC></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vComp_Aid :=NULL;vATTB_AID:=NULL;vSUB_ATTB_AID:=NULL;vSUB_ATTB_MID:=NULL;vSUB_ATTB_DESC:=NULL;vSUB_ATTB_SDESC:=NULL;vSAP_CODE:=NULL;
                vGL_CODE:=NULL;vGL_DESC:=NULL;vCOMP_MID:=NULL;vATTB_MID:=NULL;


               BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
               EXCEPTION

                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

               BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'ATTRIBUTE_CODE/text()',vATTB_MID);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Attribute Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Attribute Code';
                  END IF;
                  GOTO PRINT_ERROR;

               END;

                  BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_ATTRIBUTE_CODE/text()',vSUB_ATTB_MID);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Attribute Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Attribute Code';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

               BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_ATTRIBUTE_DESCRIPTION/text()',vSUB_ATTB_DESC);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Attribute Description (Max limit is 150 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Attribute Description';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

                  BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_ATTRIBUTE_SHORT_DESCRIPT/text()',vSUB_ATTB_SDESC);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Attribute Short Description (Max limit is 10 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Attribute Short Description';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

               BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'SAP_CODE/text()',vSAP_CODE);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for SAP Code (Max limit is 15 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for SAP Code';
                  END IF;
                  GOTO PRINT_ERROR;
               END;


               BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'GENERAL_LEDGER_CODE/text()',vGL_CODE);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for General Ledger Code (Max limit is 15 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for General Ledger Code';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

               BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'GENERAL_LEDGER_DESCRIPTION/text()',vGL_DESC);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for General Ledger Description (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for General Ledger Description';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

                IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
                IF vATTB_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Attribute Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
                  IF vSUB_ATTB_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Sub Attribute Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF vSUB_ATTB_DESC IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Sub Attribute Description should not be blank';
                  GOTO PRINT_ERROR;
               end if;
               
               
                 --Get Comp Aid
               vComp_Aid := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Aid IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOMP_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid Company Code special character found!';
                   GOTO PRINT_ERROR;
               END IF;

              

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vATTB_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid Attribute Code special character found!';
                   GOTO PRINT_ERROR;
               END IF;

                 --Get Attribute Master AID and Is sun attribute list allow
               HR_PK_VALIDATION.FN_GET_ATTB_AID(vComp_Aid,vATTB_MID,vATTB_AID,vIsLIST_FLAG,vACTIVE_FLG);

               IF vATTB_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Attribute Code '||vATTB_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

              IF UPPER(TRIM(vACTIVE_FLG)) ='N'THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Attribute Code '||vATTB_MID||' is inactive in Attribute Master.You can not add more Sub Attributes';
                  GOTO PRINT_ERROR;
              END IF;

              IF UPPER(TRIM(vIsLIST_FLAG))='N' THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Sub Attribute not applicable for Attribute Code '||vATTB_MID||' ';
                 GOTO PRINT_ERROR;
              END IF;

            
               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSUB_ATTB_MID),'~!@#$%^*()_+/=.,''') > 0 THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Sub Attribute Code, special character found!';
                  GOTO PRINT_ERROR;
               END IF;
               
--               CHANGED BY VAI
              OPEN curRec FOR
                    SELECT NVL(VALIDATION,'~!@#$%^*()+=.''') FROM GM_ATTRIBUTE
                    WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vComp_Aid))
                    AND  UPPER(TRIM(ATTB_AID))= UPPER(TRIM(vATTB_AID));
              FETCH curRec INTO vSPECIAL_CHAR ;
              CLOSE  curRec;
              
               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSUB_ATTB_DESC),vSPECIAL_CHAR) > 0 AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vSUB_ATTB_DESC))='#NULL') THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Sub Attribute Description,special character found, '||vSPECIAL_CHAR||' special characters not allowed';
                     GOTO PRINT_ERROR;
               END IF;
--**
               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vGL_CODE),'~!@#$%^&*()_+/=.''') > 0 AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vGL_CODE))='#NULL') THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid General Ledger Code, special character found';
                     GOTO PRINT_ERROR;
               END IF;

                OPEN curRec FOR
                    SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID
                    AND UPLOAD_AID = pUpload_Aid
                    AND UPLOAD_BATCH_ID = vUpldBatch_Id
                    AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID))
                    AND UPPER(TRIM(COL2))=UPPER(TRIM(vATTB_MID))
                    AND UPPER(TRIM(COL3))=UPPER(TRIM(vSUB_ATTB_MID));
                FETCH curRec INTO vChkRecordCount;
                CLOSE  curRec;

                IF vChkRecordCount > 0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Duplicate record found !';
                    GOTO PRINT_ERROR;
                END IF;


                OPEN curRec FOR
                    SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID
                    AND UPLOAD_AID = pUpload_Aid
                    AND UPLOAD_BATCH_ID = vUpldBatch_Id
                    AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID))
                    AND UPPER(TRIM(COL2))=UPPER(TRIM(vATTB_MID))
                    AND UPPER(TRIM(COL4))=UPPER(TRIM(vSUB_ATTB_DESC))
                    AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vSUB_ATTB_DESC))='#NULL');
                FETCH curRec INTO vChkRecordCount;
                CLOSE  curRec;

                IF vChkRecordCount > 0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Duplicate record found for Sub Attribute Description '||vSUB_ATTB_DESC;
                    GOTO PRINT_ERROR;
                END IF;

               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                    SELECT COUNT(*) INTO vChkRecordCount FROM PM_SUB_ATTRIBUTE
                    WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vComp_Aid))
                    AND  UPPER(TRIM(ATTB_AID))=UPPER(TRIM(vATTB_AID))
                    AND UPPER(TRIM(SUB_ATTB_MID)) = UPPER(TRIM(VSUB_ATTB_MID));
                    FETCH curRec INTO vChkRecordCount ;
                    CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;

                    OPEN curRec FOR
                    SELECT COUNT(*) INTO vChkRecordCount FROM PM_SUB_ATTRIBUTE
                    WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vComp_Aid))
                    AND  UPPER(TRIM(ATTB_AID))=UPPER(TRIM(vATTB_AID))
                    AND UPPER(TRIM(SUB_ATTB_DESC)) = UPPER(TRIM(VSUB_ATTB_DESC));
                    FETCH curRec INTO vChkRecordCount ;
                    CLOSE  curRec;

                     IF vChkRecordCount > 1 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Sub Attribute Description already exists, It should be unique!';
                         GOTO PRINT_ERROR;
                     END IF;

               END IF;

             IF pTrans_Type IN ('ADD') THEN


                 SELECT COUNT(*) INTO vChkRecordCount
                 FROM PM_SUB_ATTRIBUTE
                 WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Aid))
                 AND  UPPER(TRIM(ATTB_AID))=UPPER(TRIM(VATTB_AID))
                 AND UPPER(TRIM(SUB_ATTB_MID)) = UPPER(TRIM(VSUB_ATTB_MID));
                 IF vChkRecordCount >0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Sub Attribute Code '||UPPER(TRIM(VSUB_ATTB_MID))||' for Attribute Code '||UPPER(TRIM(vATTB_MID))||' already exists in system, It should be unique!';
                     GOTO PRINT_ERROR;
                 END IF;


                IF (vSUB_ATTB_DESC  IS NOT NULL) THEN
                     SELECT COUNT(*) INTO vChkRecordCount
                     FROM PM_SUB_ATTRIBUTE
                     WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Aid))
                     AND  UPPER(TRIM(ATTB_AID))=UPPER(TRIM(VATTB_AID))
                     AND UPPER(TRIM(SUB_ATTB_DESC)) = UPPER(TRIM(vSUB_ATTB_DESC))
                     AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vSUB_ATTB_DESC))='#NULL');
                     IF vChkRecordCount >0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Sub Attribute Description already exists in system, It should be unique!';
                         GOTO PRINT_ERROR;
                     END IF;
                END IF;


             END IF;
                /*Inserting Uploaded data in Insertable format*/
             IF pTrans_Type IN ('REMOVE AND ADD','ADD') THEN

              vSUB_ATTB_AID  := HR_PK_VALIDATION.FN_GENERATE_SUB_ATTB_AID(vComp_Aid,vATTB_AID,I);

             END IF;


              IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8,COL9)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Aid,vATTB_AID,vSUB_ATTB_AID,vSUB_ATTB_MID,vSUB_ATTB_DESC,vSUB_ATTB_SDESC,vSAP_CODE,vGL_CODE,vGL_DESC);
              END IF;


             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vCOMP_MID,vATTB_MID,vSUB_ATTB_MID,UPPER(TRIM(vSUB_ATTB_DESC)),UPPER(TRIM(vSUB_ATTB_SDESC))
                ,vSAP_CODE,vGL_CODE,vGL_DESC);

            END LOOP;



           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_GRADE_MSTR
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID, COL2  ATTB_AID,COL3 SUB_ATTB_AID, COL4  SUB_ATTB_MID, COL5 SUB_ATTB_DESC,COL6 SUB_ATTB_SDESC
                       ,COL7 SAP_CODE ,COL8 GL_CODE,COL9 GL_DESC, pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE,pUser_Aid USER_AT, SYSDATE DATE_AT
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId
                       AND USER_AID = pUSER_AID
                       AND UPLOAD_AID = pUpload_Aid
                       AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO PM_SUB_ATTRIBUTE (COMP_AID,ATTB_AID,SUB_ATTB_AID,SUB_ATTB_MID,SUB_ATTB_DESC,SUB_ATTB_SDESC,SAP_CODE ,GL_CODE,GL_DESC,USER_CR,DATE_CR )
                    VALUES(I.COMP_AID, I.ATTB_AID,HR_PK_VALIDATION.FN_GENERATE_SUB_ATTB_AID(I.COMP_AID,I.ATTB_AID,1),I.SUB_ATTB_MID,I.SUB_ATTB_DESC,I.SUB_ATTB_SDESC,I.SAP_CODE ,I.GL_CODE,I.GL_DESC,pUser_Aid,SYSDATE);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE PM_SUB_ATTRIBUTE
                    SET SUB_ATTB_DESC = DECODE(TRIM(I.SUB_ATTB_DESC),'#NULL',SUB_ATTB_DESC,TRIM(SUB_ATTB_DESC))
                    ,SUB_ATTB_SDESC=DECODE(TRIM(I.SUB_ATTB_SDESC),'#NULL',SUB_ATTB_SDESC,TRIM(I.SUB_ATTB_SDESC))
                    ,SAP_CODE = DECODE(TRIM(I.SAP_CODE),'#NULL',SAP_CODE,TRIM(I.SAP_CODE))
                    ,GL_CODE =DECODE(TRIM(I.GL_CODE),'#NULL',GL_CODE,TRIM(I.GL_CODE))
                    ,GL_DESC =DECODE(TRIM(I.GL_DESC),'#NULL',GL_DESC,TRIM(I.GL_DESC))
                    ,USER_UP = pUser_Aid,DATE_UP = SYSDATE
                    WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(SUB_ATTB_MID)) = UPPER(TRIM(I.SUB_ATTB_MID))AND UPPER(TRIM(ATTB_AID)) = UPPER(TRIM(I.ATTB_AID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

        COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;



       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PM_SUB_ATTRIBUTE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());


         OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;

    PROCEDURE UPLOAD_PM_EMP_ATTRIBUTE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                          pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser                dbms_xmlparser.Parser;
    vXmlDomDocument           dbms_xmldom.DOMDocument;
    vXmlDOMNodeList           dbms_xmldom.DOMNodeList;
    vXmlDOMNode               dbms_xmldom.DOMNode;
    vComp_Aid                VARCHAR2(8);
    vEMP_AID                 VARCHAR2(8);
    vEMP_MID                 VARCHAR2(20);
    vATTB_MID                VARCHAR2(30);
    vSUB_ATTB_MID_VALUE      VARCHAR2(100);
    vATTB_DESC               GM_ATTRIBUTE.ATTB_DESC%TYPE;
    vCOMP_MID                VARCHAR2(8);
    vATTB_Aid               GM_ATTRIBUTE.ATTB_AID%TYPE;
    vATTB_VALUE             PM_EMP_ATTRIBUTE.ATTB_VALUE%TYPE;
    vACTIVE_FLG              VARCHAR2(10);
    vIS_SUB_ATTB_ACTIVE      VARCHAR2(10);
    vsub_ATTB_Aid            VARCHAR2(10);
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    vDATA_TYPE                 VARCHAR2(20);
    vIsLIST_FLAG              GM_ATTRIBUTE.LIST_FLAG%TYPE;
    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><GRADE_MID>0001</GRADE_MID><GRADE_NAME>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

           --'<NewDataSet><ExcelInfo><COMP_MID>BCD</COMP_MID><EMP_MID>'00517</EMP_MID><ATTB_MID>DESG</ATTB_MID><SUB_ATTB_MID>DESG1</SUB_ATTB_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vComp_AId:=NULL; vEMP_AID:=NULL;vATTB_AID:=NULL;vIsLIST_FLAG:=NULL;vsub_ATTB_Aid:=NULL;vIsLIST_FLAG:=NULL;vSUB_ATTB_MID_VALUE:=NULL;
                vCOMP_MID:=NULL;vEMP_MID:=NULL;vATTB_MID:=NULL;vSUB_ATTB_MID_VALUE:=NULL;

               BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
               END;

               BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
               EXCEPTION
                   WHEN OTHERS THEN
                    IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Code ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

               BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'ATTRIBUTE_CODE/text()',vATTB_MID);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Attribute Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Attribute Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

               BEGIN
                   dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_ATTRIBUTE_CODE_OR_VALUE/text()',vSUB_ATTB_MID_VALUE);
               EXCEPTION
                   WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Attribute Code Or Value (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Attribute Code Or Value';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
               
                  IF vATTB_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Attribute Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               
               
                IF vEMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Employee Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;
                
              IF vSUB_ATTB_MID_VALUE IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Sub Attribute Code Or Value should not be blank';
                  GOTO PRINT_ERROR;
               END IF;

               

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vCOMP_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Company Code special character found!';
                  GOTO PRINT_ERROR;
               END IF;

               vComp_AId := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_AId IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                  GOTO PRINT_ERROR;
               END IF;

            

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vATTB_MID),'~!@#$%^*()_+/-=.,''') > 0 THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Attribute Code special character found!';
                  GOTO PRINT_ERROR;
               END IF;
             

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),'~!@#$%^&*()_+/-=.,''') > 0 THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Employee Code special character found!';
                  GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vEMP_MID),' ') > 0 THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Invalid Employee Code space found!';
                 GOTO PRINT_ERROR;
                END IF;

               vEMP_AID := HR_PK_VALIDATION.FN_GET_EMP_AID(vComp_AId,vEMP_MID);

                IF vEMP_AID IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Employee Code '||vEMP_MID||' does not exist';
                  GOTO PRINT_ERROR;
               END IF;

            
               HR_PK_VALIDATION.FN_GET_ATTB_AID(vComp_AId,vATTB_MID,vATTB_AID,vIsLIST_FLAG,vACTIVE_FLG);

               IF vATTB_AID IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Attribute Code';
                  GOTO PRINT_ERROR;
                  END IF;

                IF UPPER(TRIM(vACTIVE_FLG)) ='N' THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Attribute Master is inactive';
                  GOTO PRINT_ERROR;

                ELSIF  UPPER(TRIM(vACTIVE_FLG)) ='Y' AND  UPPER(TRIM(vIsLIST_FLAG))= 'Y' THEN

                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSUB_ATTB_MID_VALUE),'~!@#$%^*()_+/=-.,''') > 0 THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Sub Attribute Code Or Value special character found!';
                  GOTO PRINT_ERROR;
                  END IF;

                  IF LENGTH(TRIM(vSUB_ATTB_MID_VALUE)) >30 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid input size for Sub Attribute Code Or Value !';
                     GOTO PRINT_ERROR;
                  END IF;

                END IF;

               vsub_ATTB_Aid := CASE WHEN TRIM(UPPER(vSUB_ATTB_MID_VALUE))='#NULL' AND pTrans_Type ='UPDATE' THEN '#NULL'
                                    ELSE HR_PK_VALIDATION.FN_GET_SUB_ATTB_AID(vComp_AId,vATTB_Aid,vSUB_ATTB_MID_VALUE) END;


               IF UPPER(TRIM(vIsLIST_FLAG))= 'Y' THEN

                 IF vsub_ATTB_Aid IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Invalid Sub Attribute Code Or Value';
                  GOTO PRINT_ERROR;
                END IF;

               ELSE

                HR_PK_VALIDATION.FN_GET_VALIDATION(vComp_AId,vATTB_AID,vSUB_ATTB_MID_VALUE,vERROR_FLAG,vERROR_MSG);


              END IF;

               IF vERROR_FLAG IS NOT NULL AND  vERROR_MSG IS NOT NULL THEN
                  GOTO PRINT_ERROR;
               END IF;

                    OPEN curRec FOR
                    SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId
                    AND USER_AID = pUSER_AID
                    AND UPLOAD_AID = pUpload_Aid
                    AND UPLOAD_BATCH_ID = vUpldBatch_Id
                    AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID))
                    and UPPER(TRIM(COL2))=UPPER(TRIM(vEMP_MID))
                    AND (UPPER(TRIM(COL3))=UPPER(TRIM(vATTB_MID))
                    OR  (UPPER(TRIM(COL4))=UPPER(TRIM(vSUB_ATTB_MID_VALUE))) AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vSUB_ATTB_MID_VALUE))='#NULL'));
               FETCH curRec INTO vChkRecordCount;
               CLOSE  curRec;

                IF vChkRecordCount > 0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Duplicate record found!';
                    GOTO PRINT_ERROR;
                END IF;

               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN

                  IF (vATTB_AID  IS NOT NULL) THEN
                     SELECT COUNT(*) INTO vChkRecordCount
                     FROM PM_EMP_ATTRIBUTE
                     WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_AId))
                     AND  UPPER(TRIM(ATTB_AID))=UPPER(TRIM(vATTB_AID))
                     AND UPPER(TRIM(EMP_AID)) = UPPER(TRIM(vEMP_AID))
                     AND UPPER(TRIM(SUB_ATTB_AID)) = UPPER(TRIM(vsub_ATTB_Aid));
                     IF vChkRecordCount >0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist, It should be unique !';
                         GOTO PRINT_ERROR;
                     END IF;
                  END IF;

                END IF;

               IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                    SELECT COUNT(*) FROM PM_EMP_ATTRIBUTE
                    WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vComp_AId))
                    AND UPPER(TRIM(EMP_AID)) = UPPER(TRIM(vEMP_AID))
                    AND UPPER(TRIM(ATTB_AID))=UPPER(TRIM(VATTB_AID));
                    FETCH curRec INTO vChkRecordCount ;
                    CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;

               END IF;

               /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN

                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3,COL4,COL5)
                   VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_AId, vEMP_AID,vATTB_AID,DECODE(vIsLIST_FLAG,'Y',vsub_ATTB_Aid,'N','SB000000'),DECODE(vIsLIST_FLAG,'N',vSUB_ATTB_MID_VALUE,'Y',''));
                   --VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_AId, vEMP_AID,vATTB_AID,DECODE(vIsLIST_FLAG,'Y',vsub_ATTB_Aid,'N','SB000000'),vSUB_ATTB_MID_VALUE);

                END IF;


             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vCOMP_MID,  vEMP_MID,vATTB_MID,vSUB_ATTB_MID_VALUE);


            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            MERGE INTO PM_EMP_ATTRIBUTE A
            USING (SELECT * FROM HR_VW_FINAL_UPLOAD_DATA
            WHERE  UPLOAD_BATCH_ID =pUpload_Batch_Id AND SESSION_ID =pSessionId AND USER_AID =pUSER_AID AND UPLOAD_AID = pUpload_Aid AND STATUS = 'PENDING') B
            ON(UPPER(TRIM(A.COMP_AID)) =UPPER(TRIM(COL1))
            AND UPPER(TRIM(A.EMP_AID))=UPPER(TRIM(COL2))
            AND UPPER(TRIM(A.ATTB_AID))=UPPER(TRIM(COL3))
            AND pOperationType ='COMMIT_UPLOAD')
            WHEN MATCHED THEN UPDATE SET
            A.SUB_ATTB_AID= DECODE(UPPER(TRIM(COL4)),'#NULL',SUB_ATTB_AID,UPPER(TRIM(COL4))),
            A.ATTB_VALUE = DECODE(UPPER(TRIM(COL5)),'#NULL',ATTB_VALUE,UPPER(TRIM(COL5))),
            USER_UP = pUSER_AID,
            DATE_UP = SYSDATE
            WHEN NOT MATCHED THEN INSERT
            (A.COMP_AID, A.EMP_AID, A.ATTB_AID,A.SUB_ATTB_AID, A.ATTB_VALUE,A.USER_CR, A.DATE_CR)
            VALUES(TRIM(B.COL1),TRIM(B.COL2),TRIM(B.COL3),TRIM(B.COL4),TRIM(B.COL5),pUSER_AID, SYSDATE);


--            --Final data insert in base table GM_GRADE_MSTR
--            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_AID, COL2  EMP_AID, COL3  ATTB_AID, COL4 sub_ATTB_Aid,COL5 SUB_ATTB_MID_VALUE,
--                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE,pUser_Aid USER_AT, SYSDATE DATE_AT
--                       FROM HR_VW_FINAL_UPLOAD_DATA
--                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId
--                       AND USER_AID = pUSER_AID
--                       AND UPLOAD_AID = pUpload_Aid
--                       AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
--            LOOP

--                 IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN
--
--                    INSERT INTO PM_EMP_ATTRIBUTE (COMP_AID,EMP_AID,ATTB_AID,SUB_ATTB_AID  )
--                    VALUES(I.COMP_AID,I.EMP_AID,I.ATTB_AID,I.sub_ATTB_Aid);
--
--              ELSIF I.TRANS_TYPE IN ('UPDATE') THEN
--
--                    UPDATE PM_EMP_ATTRIBUTE SET COMP_AID  = I.COMP_AID,EMP_AID =vEMP_ID, ATTB_AID = I.ATTB_AID,SUB_ATTB_AID = I.sub_ATTB_Aid
--                    WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(ATTB_AID)) = UPPER(TRIM(I.ATTB_AID));
--
--              END IF;
--
--            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

         COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PM_EMP_ATTRIBUTE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            OPEN Return_Recordset FOR
               SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;

PROCEDURE UPLOAD_PT_EMP_OTHER_CTC_DEFINE(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser             dbms_xmlparser.Parser;
    vXmlDomDocument        dbms_xmldom.DOMDocument;
    vXmlDOMNodeList        dbms_xmldom.DOMNodeList;
    vXmlDOMNode            dbms_xmldom.DOMNode;
    vComp_Id               GM_COMP.COMP_ID%TYPE;
    vLOCATION_ID           GM_LOCATIONS.LOCATION_ID%TYPE;
    vACC_YEAR              VARCHAR2(10);
    vEMP_ID                GM_EMP.EMP_ID%TYPE;
    vEMP_MID               GM_EMP.EMP_MID%TYPE;
    aEMP_ID                GM_EMP.EMP_ID%TYPE;
    vREV_NO                VARCHAR2(200);
    aREV_NO                VARCHAR2(200);

    vCOMP_MID              GM_COMP.COMP_MID%TYPE;
    vALLWDED_MID           CTC_ALLOWANCE_MAST.CTC_MID%TYPE;
    vAMOUNT                VARCHAR2(200);
    vMONTH_AMT             VARCHAR2(15);
    vEFF_DATE_FR           VARCHAR2(200);
    vEFF_DATE_TO           VARCHAR2(200);
    vCTCAMOUNT             VARCHAR2(15);
    vALLWDED_AID           CTC_ALLOWANCE_MAST.CTC_CODE%TYPE;
    aEFF_DATE_FR           VARCHAR2(8);
    --vDESGN_DESC          GM_LOCATIONS.DESGN_DESC%TYPE;
    V_JOIN_DATE            DATE;

    vERROR_MSG             VARCHAR2(2000);
    vERROR_FLAG            VARCHAR2(1);
    vChkRecordCount        NUMBER;
    vUpldBatch_Id          HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    cEMP_ID                NUMBER;
    cEFF_DATE_FR           NUMBER;


    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

           vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

           vXmlParser := dbms_xmlparser.newParser;
           dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
           vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
           vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

          FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vCOMP_MID:=NULL;vEMP_MID:=NULL;vALLWDED_MID:=NULL;vEFF_DATE_FR:=NULL;vEFF_DATE_TO:=NULL;vMONTH_AMT:=NULL;vCTCAMOUNT:=NULL;vEMP_ID:=NULL; vALLWDED_AID:=NULL;
                cEMP_ID := 0;

--                dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'ALLOWANCE_CODE/text()',vALLWDED_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_FROM/text()',vEFF_DATE_FR);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_TO/text()',vEFF_DATE_TO);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'MONTHLY_AMOUNT/text()',vMONTH_AMT);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'CTC_AMOUNT/text()',vCTCAMOUNT);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';

                BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Company Code (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Company Code';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

                 BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Employee Code (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Employee Code';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

                 BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'ALLOWANCE_CODE/text()',vALLWDED_MID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Allowance Code (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Allowance Code';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

                 BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_FROM/text()',vEFF_DATE_FR);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Effective Date From';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Effective Date From';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;


                  BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_TO/text()',vEFF_DATE_TO);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Effective Date To';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Effective Date To';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;
          
                  BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'MONTHLY_AMOUNT/text()',vMONTH_AMT);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Monthly Amount(Max limit is 15 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Monthly Amount';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

                   BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'CTC_AMOUNT/text()',vCTCAMOUNT);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For CTC Amount(Max limit is 15 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for CTC Amount';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;


              --Get the Comp_Aid

               IF vCOMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF vEMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Employee Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;

                IF vALLWDED_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Allowance Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vEFF_DATE_FR IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Effective Date From should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF pTrans_Type IN ('UPDATE') THEN
                  IF vEFF_DATE_TO IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Effective Date To should not be blank';
                   GOTO PRINT_ERROR;
                  END IF;
               END IF;


               IF vMONTH_AMT IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Monthly Amount should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vCTCAMOUNT IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='CTC Amount should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


              IF NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vALLWDED_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Allowance Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

              vEFF_DATE_FR:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vEFF_DATE_FR));
              vEFF_DATE_TO:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vEFF_DATE_TO));

              vChkRecordCount :=HR_PK_VALIDATION.FN_IS_DATE(TRIM(vEFF_DATE_FR));

              IF vChkRecordCount =0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid Effective From Date';
                   GOTO PRINT_ERROR;
              END IF;
              
              --vEFF_DATE_FR:=TO_DATE(vEFF_DATE_FR,'DD-MM-YYYY');
              
              vChkRecordCount :=HR_PK_VALIDATION.FN_IS_DATE(TRIM(vEFF_DATE_TO));

               IF vChkRecordCount =0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Invalid Effective To Date';
                   GOTO PRINT_ERROR;
               END IF;

               --vEFF_DATE_TO:=TO_DATE(vEFF_DATE_TO,'DD-MM-YYYY');

            
              IF HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vEFF_DATE_FR)=0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Effective From Date';
                    GOTO PRINT_ERROR;
                END IF;

            IF vEFF_DATE_TO IS NOT NULL THEN
             
                IF HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vEFF_DATE_TO)=0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Effective To Date';
                    GOTO PRINT_ERROR;
                END IF;
                
             END IF;                      

            vChkRecordCount :=HR_PK_VALIDATION.FN_IS_NUMBER(TRIM(vMONTH_AMT));

             IF vChkRecordCount =0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Monthly Amount';
                     GOTO PRINT_ERROR;
            END IF;

           vChkRecordCount :=HR_PK_VALIDATION.FN_IS_NUMBER(TRIM(vCTCAMOUNT));

             IF vChkRecordCount =0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid CTC Amount';
                     GOTO PRINT_ERROR;
            END IF;


           IF(TO_NUMBER(vMONTH_AMT)>TO_NUMBER(vCTCAMOUNT)) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='CTC AMOUNT should be greater than Monthly Amount';
                 GOTO PRINT_ERROR;
           END IF;

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               vEMP_ID := HR_PK_VALIDATION.FN_GET_EMP_AID(  vComp_Id,vEMP_MID);

               IF vEMP_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Employee Code '||vEMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               vALLWDED_AID := HR_PK_VALIDATION.FN_GET_ALLWDED_AID(  vComp_Id,vALLWDED_MID,'OTC');

               IF vALLWDED_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Allowance Code '||vALLWDED_MID||' is invalid. It should be defined in Allowance Master and should be OTHER THAN CTC';
                    GOTO PRINT_ERROR;
               END IF;


              SELECT JOIN_DATE INTO V_JOIN_DATE  FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))= UPPER(TRIM(vComp_Id)) AND  UPPER(TRIM(EMP_ID))=UPPER(TRIM(vEMP_ID)) ;

              IF( TO_DATE(vEFF_DATE_FR,'DD-MM-YYYY' ) < V_JOIN_DATE) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Effective Date From should be greater than or equal to Join Date';
                 GOTO PRINT_ERROR;
              END IF;

               IF( TO_DATE(vEFF_DATE_FR,'DD-MM-YYYY' ) > TO_DATE( vEFF_DATE_TO,'DD-MM-YYYY') ) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Effective Date From should be less than Effective To Date';
                 GOTO PRINT_ERROR;
              END IF;

               -- Checking duplicate data exist or not
               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

                    OPEN curRec FOR
                        SELECT COUNT(*)
                        FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vEMP_MID))  and UPPER(TRIM(COL3))=UPPER(TRIM(vALLWDED_MID));
                    FETCH curRec INTO vChkRecordCount;
                    CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Allowance Code '||TRIM(UPPER(vALLWDED_MID))||' for Employee code '||UPPER(TRIM(vEMP_MID));
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

                 IF pTrans_Type IN ('UPDATE') THEN

                    OPEN curRec FOR
                        SELECT COUNT(*)
                        FROM HR_PT_EMP_OTC_DEFINE
                        WHERE COMP_AID=vComp_Id AND EMP_AID=vEMP_ID AND ALLWDED_AID=vALLWDED_AID;
                    FETCH curRec INTO vChkRecordCount;
                    CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record Does not Exist to Update';
                         GOTO PRINT_ERROR;
                     END IF;

                     OPEN curRec FOR
                        SELECT COUNT(*)
                        FROM HR_PT_EMP_OTC_DEFINE
                        WHERE COMP_AID=vComp_Id AND EMP_AID=vEMP_ID AND ALLWDED_AID=vALLWDED_AID AND EFF_DATE_TO IS NULL;
                    FETCH curRec INTO vChkRecordCount;
                    CLOSE  curRec;

                    IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Effective To Date cannot be updated for '||vALLWDED_MID||' , as no valid record is present';
                         GOTO PRINT_ERROR;
                     END IF;

               END IF;

               SELECT    COUNT (DISTINCT COL4)  INTO cEFF_DATE_FR FROM  HR_TEMP_RAW_UPLOAD  WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID and COL2=vEMP_MID AND ERROR_MSG IS NULL ;

--               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN
--
--                  SELECT DISTINCT COUNT(COL3) INTO cEMP_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id AND COL3=vEMP_ID ;
--
--                     IF(cEMP_ID = 0 ) THEN
--                       IF(I=0) THEN
--                          vREV_NO  := TRIM(HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'HR_PT_EMP_OTC_DEFINE',I+1));
--                       ELSE
--                         -- SELECT  TO_NUMBER(MAX(SUBSTR(COL2,3)))   INTO     FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id  ;
----                          vREV_NO:='EC'||TRIM(TO_CHAR(NVL(aREV_NO,0)+1,'000000'));
--                            SELECT  TO_NUMBER(MAX(SUBSTR(COL2,11)))   INTO   aREV_NO  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id  ;
--                            vREV_NO:='OC'||TO_CHAR(SYSDATE,'DDMMYYYY')||TRIM(TO_CHAR(NVL(aREV_NO,0)+1,'000000'));
--                        END IF;
--                    ELSE
--                        /*to assign the same Rev No for all the allowances being uploaded for an employee*/
--                        SELECT DISTINCT COL2 INTO vREV_NO  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id AND COL3=vEMP_ID ;
--
--                    END IF;
--               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6,COL7,COL8,COL9)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id,vEMP_ID, vALLWDED_AID,vEFF_DATE_FR,vEFF_DATE_TO,vMONTH_AMT,vCTCAMOUNT,pAcc_Year,vEMP_MID);
                END IF;
                   --COMMIT;
             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6,COL7)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2,
                        vCOMP_MID,vEMP_MID,vALLWDED_MID,vEFF_DATE_FR,vEFF_DATE_TO,vMONTH_AMT,vCTCAMOUNT);

                 COMMIT;

            END LOOP;

--            UPDATE HR_TEMP_RAW_UPLOAD SET ERROR_FLAG='Y'
--            WHERE UPLOAD_BATCH_ID=vUpldBatch_Id AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND  UPLOAD_AID=pUpload_Aid
--             AND (COL1, COL2) IN
--            (SELECT COL1, COL2 FROM HR_TEMP_RAW_UPLOAD
--             WHERE  UPLOAD_BATCH_ID=vUpldBatch_Id AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND  UPLOAD_AID=pUpload_Aid
--                AND ERROR_FLAG IS NOT NULL AND  ERROR_MSG IS NOT NULL);

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            IF(pOperationType = 'COMMIT_UPLOAD') THEN--Final data insert in base table GM_GRADE_MSTR

                FOR R IN ( SELECT DISTINCT COL1 COMP_ID, COL2 EMP_AID
                   FROM HR_VW_FINAL_UPLOAD_DATA
                   WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                     AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD' AND TRANS_TYPE IN ('REMOVE AND ADD','ADD','UPDATE'))
                 LOOP

                    vREV_NO := TRIM(HR_PK_VALIDATION.FN_GENERATE_AID(R.COMP_ID, 'HR_PT_EMP_OTC_DEFINE',1 ));

                    FOR I IN ( SELECT  TRANS_TYPE, COL1 COMP_ID, vREV_NO REV_NO, COL2 EMP_AID, COL3 ALLWDED_AID,COL4 EFF_DATE_FR,COL5 EFF_DATE_TO,COL6 AMOUNT, COL7 CTC_AMOUNT ,COL8 ACC_YEAR,COL9 EMP_MID,
                                     pUser_Aid USER_CR, SYSDATE DATE_CR ,pUser_Aid USER_UP, SYSDATE DATE_UP
                                   FROM HR_VW_FINAL_UPLOAD_DATA
                                   WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                                     AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD' AND COL1=R.COMP_ID AND COL2 = R.EMP_AID)
                    LOOP

                        IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                               UPDATE HR_PT_EMP_OTC_DEFINE
                               SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR,'DD-MM-YYYY')-1
                               --SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR,'DD-MM-YYYY')-1
                               WHERE COMP_AID = I.COMP_ID
                               AND EMP_AID = I.EMP_AID
                               AND ALLWDED_AID=I.ALLWDED_AID
                               AND (EFF_DATE_TO IS NULL OR EFF_DATE_TO>=TO_DATE(I.EFF_DATE_FR,'DD-MM-YYYY'));

                              INSERT INTO HR_PT_EMP_OTC_DEFINE (COMP_AID,REV_NO, ALLWDED_AID, EMP_AID, EFF_DATE_FR,EFF_DATE_TO,AMOUNT,CTC_AMOUNT, USER_CR,DATE_CR,USER_UP,DATE_UP)
                                    VALUES(I.COMP_ID,I.REV_NO, I.ALLWDED_AID,I.EMP_AID, I.EFF_DATE_FR,I.EFF_DATE_TO,I.AMOUNT,I.CTC_AMOUNT,I.USER_CR ,I.DATE_CR,I.USER_CR,I.DATE_CR);

                        ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                               UPDATE HR_PT_EMP_OTC_DEFINE
                               SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_TO,'DD-MM-YYYY'),USER_UP=I.USER_CR,DATE_UP=I.DATE_CR
                               WHERE COMP_AID = I.COMP_ID
                               AND EMP_AID = I.EMP_AID
                               AND ALLWDED_AID=I.ALLWDED_AID
                               AND EFF_DATE_TO IS NULL;

                        END IF;

                    END LOOP;

                END LOOP;

            END IF;
            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
           SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PT_EMP_CTC_DEFINE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

           OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;


    END;


      PROCEDURE UPLOAD_FAMILY_MEMBER(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser             dbms_xmlparser.Parser;
    vXmlDomDocument        dbms_xmldom.DOMDocument;
    vXmlDOMNodeList        dbms_xmldom.DOMNodeList;
    vXmlDOMNode            dbms_xmldom.DOMNode;
    vComp_Id               GM_COMP.COMP_ID%TYPE;
    vLOCATION_ID           GM_LOCATIONS.LOCATION_ID%TYPE;
    vACC_YEAR              VARCHAR2(10);
    vEMP_ID                GM_EMP.EMP_ID%TYPE;
    vEMP_MID               GM_EMP.EMP_MID%TYPE;
    aEMP_ID                GM_EMP.EMP_ID%TYPE;
    vREV_NO            VARCHAR2(200);
    aREV_NO            VARCHAR2(8);

    vCOMP_MID              GM_COMP.COMP_MID%TYPE;

    vDEPENDENT_NAME         GM_EMP_DEPENDENT.DEPENDENT_NAME%TYPE;
    vMARITAL_STATUS         GM_EMP_DEPENDENT.MARITAL_STATUS%TYPE;
    vGENDER                 GM_EMP_DEPENDENT.GENDER%TYPE;
    vADDRESS                GM_EMP_DEPENDENT.ADDRESS%TYPE;
    vPHONE_NO               GM_EMP_DEPENDENT.PHONE_NO%TYPE;
    vRELATION               GM_EMP_DEPENDENT.RELATION_EMP%TYPE;
    vDATE_OF_BIRTH          VARCHAR2(50);
    vAGE                    GM_EMP_DEPENDENT.AGE%TYPE;
    vAGENUM                 NUMBER(5,2);
    vCOUNTRY                GM_EMP_DEPENDENT.BIRTH_COUNTRY%TYPE;
    vSTATE                  GM_EMP_DEPENDENT.BIRTH_STATE%TYPE;
    vLOCATION               GM_EMP_DEPENDENT.BIRTH_CITY%TYPE;
    vBENEFIC_TYPE           GM_EMP_DEPENDENT.DEPENDENT_TYPE%TYPE;
    vOCCUPATION             GM_EMP_DEPENDENT.OCCUPATION%TYPE;
    vSR_NO                  GM_EMP_DEPENDENT.SR_NO%TYPE;

    vMARITAL_STATUS_ID      VARCHAR2(8);
    vRELATION_ID            VARCHAR2(8);
    vCOUNTRY_ID             VARCHAR2(8);
    vSTATE_ID               VARCHAR2(8);
    vLOCATIONID             VARCHAR2(8);
    vBENEFIC_TYPE_ID        VARCHAR2(8);

    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    cEMP_ID                   NUMBER;
    cEFF_DATE_FR              NUMBER;


    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

           vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

           vXmlParser := dbms_xmlparser.newParser;
           dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
           vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
           vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

          FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vCOMP_MID:=NULL;vEMP_MID:=NULL;vDEPENDENT_NAME:=NULL;vMARITAL_STATUS:=NULL;vGENDER:=NULL;vADDRESS:=NULL;vPHONE_NO:=NULL;vRELATION:=NULL;
                vDATE_OF_BIRTH:=NULL;vCOUNTRY:=NULL;vSTATE:=NULL;vLOCATION:=NULL;vBENEFIC_TYPE:=NULL;vOCCUPATION:=NULL;vSR_NO:=NULL;
                vComp_Id:=NULL;vEMP_ID:=NULL;vMARITAL_STATUS_ID:=NULL;vRELATION_ID :=NULL;vCOUNTRY_ID:=NULL;vSTATE_ID:=NULL;vLOCATIONID:=NULL;vBENEFIC_TYPE_ID:=NULL;


                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


                 BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Employee Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


             BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'MEMBER_NAME/text()',vDEPENDENT_NAME);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Member Name (Max limit is 50 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Member Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                 BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'MARITAL_STATUS/text()',vMARITAL_STATUS);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Marital Status (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Marital Status';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                   BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'GENDER/text()',vGENDER);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for GENDER (Max limit is 1 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Gender ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'ADDRESS/text()',vADDRESS);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for ADDRESS (Max limit is 500 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Address ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'PHONE_NO/text()',vPHONE_NO);
                    EXCEPTION
                      WHEN OTHERS THEN
                      IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Phone No (Max limit is 12 character)';
                        vERROR_FLAG:='Y';
                      ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Phone No';
                      END IF;
                      GOTO PRINT_ERROR;
                    END;


                  BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'RELATION/text()',vRELATION);
                    EXCEPTION
                      WHEN OTHERS THEN
                      IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Relation (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                      ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Relation';
                      END IF;
                      GOTO PRINT_ERROR;
                    END;


               dbms_xslprocessor.valueOf(vXmlDOMNode,'DATE_OF_BIRTH/text()',vDATE_OF_BIRTH);

                BEGIN
                    dbms_xslprocessor.valueOf(vXmlDOMNode,'COUNTRY_CODE/text()',vCOUNTRY);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Country Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Country Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


                       BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_CODE/text()',vSTATE);
                    EXCEPTION
                      WHEN OTHERS THEN
                      IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for State Code (Max limit is 50 character)';
                        vERROR_FLAG:='Y';
                      ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for State Code';
                      END IF;
                      GOTO PRINT_ERROR;
                    END;

                       BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',vLOCATION);
                    EXCEPTION
                      WHEN OTHERS THEN
                      IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Location Code (Max limit is 50 character)';
                        vERROR_FLAG:='Y';
                      ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Location Code';
                      END IF;
                      GOTO PRINT_ERROR;
                    END;

                       BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'BENEFICIARY_TYPE/text()',vBENEFIC_TYPE);
                    EXCEPTION
                      WHEN OTHERS THEN
                      IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Beneficiary Type (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                      ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Beneficiary Type ';
                      END IF;
                      GOTO PRINT_ERROR;
                    END;


                           BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'OCCUPATION/text()',vOCCUPATION);
                    EXCEPTION
                      WHEN OTHERS THEN
                      IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Occupation (Max limit is 50 character)';
                        vERROR_FLAG:='Y';
                      ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Occupation ';
                      END IF;
                      GOTO PRINT_ERROR;
                    END;



                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';


               IF vCOMP_MID IS NULL OR NVL(LENGTH(TRIM(NVL(vCOMP_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

                IF vEMP_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Employee Code should not be blank';
                   GOTO PRINT_ERROR;
                END IF;

                IF vDEPENDENT_NAME IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Member Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF vGENDER IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Gender should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


               IF vRELATION IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Relation should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vDEPENDENT_NAME,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Member Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


             IF(vPHONE_NO IS NOT NULL) THEN

              IF HR_PK_VALIDATION.FN_IS_NUMBER(TRIM(vPHONE_NO)) =0 AND NOT (TRIM(UPPER(vPHONE_NO))='#NULL' AND pTrans_Type ='UPDATE' ) THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Phone Number';
                     GOTO PRINT_ERROR;

             END IF;

            END IF;


              IF(vADDRESS IS NOT NULL) THEN

             vADDRESS :=CASE WHEN TRIM(UPPER(vADDRESS))='#NULL' AND pTrans_Type ='UPDATE' THEN vADDRESS
                         ELSE vADDRESS END;

            END IF;

              vDATE_OF_BIRTH:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vDATE_OF_BIRTH));

            IF(vDATE_OF_BIRTH IS NOT NULL) THEN

             vDATE_OF_BIRTH :=CASE WHEN TRIM(UPPER(vDATE_OF_BIRTH))='#NULL' AND pTrans_Type ='UPDATE' THEN vDATE_OF_BIRTH
                         ELSE vDATE_OF_BIRTH END;


             END IF;

              
              IF HR_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vDATE_OF_BIRTH)=0 THEN
                   vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Date Of Birth!';
                    GOTO PRINT_ERROR;                
                END IF;


             


             IF(vMARITAL_STATUS IS NOT NULL) THEN

             vMARITAL_STATUS_ID :=CASE WHEN TRIM(UPPER(vMARITAL_STATUS))='#NULL' AND pTrans_Type ='UPDATE' THEN vMARITAL_STATUS
                         ELSE  HR_PK_VALIDATION. FN_GET_PARAMETERS_ID(vMARITAL_STATUS) END;

            END IF;


              IF(vDATE_OF_BIRTH IS NOT NULL) THEN

              IF HR_PK_VALIDATION.FN_IS_DATE(TRIM(vDATE_OF_BIRTH))=0 AND NOT (TRIM(UPPER(vDATE_OF_BIRTH))='#NULL' AND pTrans_Type ='UPDATE' ) THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Date Of Birth!';
                     GOTO PRINT_ERROR;

             END IF;

            END IF;
                 
                      


                IF(vCOUNTRY IS NOT NULL) THEN

             vCOUNTRY_ID :=CASE WHEN TRIM(UPPER(vCOUNTRY))='#NULL' AND pTrans_Type ='UPDATE' THEN vCOUNTRY
                          ELSE  HR_PK_VALIDATION. FN_GET_COUNTRY_CODE(vCOUNTRY) END;

               IF vCOUNTRY_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Country Code '||vCOUNTRY||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;
            END IF;


             IF(vSTATE IS NOT NULL) THEN

             vSTATE_ID :=CASE WHEN TRIM(UPPER(vSTATE))='#NULL' AND pTrans_Type ='UPDATE' THEN vSTATE
                          ELSE  HR_PK_VALIDATION. FN_GET_STATE_CODE(vSTATE) END;

             IF vSTATE_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='State Code '||vSTATE||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


            END IF;

             vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

             IF(vLOCATION IS NOT NULL) THEN

             vLOCATIONID :=CASE WHEN TRIM(UPPER(vLOCATION))='#NULL' AND pTrans_Type ='UPDATE' THEN vLOCATION
                          ELSE HR_PK_VALIDATION.FN_GET_LOCATION_ID(vComp_Id,vLOCATION) END;

              IF vLOCATIONID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Location Code '||vLOCATION||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


            END IF;



             IF(vBENEFIC_TYPE IS NOT NULL) THEN

             vBENEFIC_TYPE_ID :=CASE WHEN TRIM(UPPER(vBENEFIC_TYPE))='#NULL' AND pTrans_Type ='UPDATE' THEN vBENEFIC_TYPE
                          ELSE HR_PK_VALIDATION.FN_GET_PARAMETERS_ID(vBENEFIC_TYPE) END;

               IF vBENEFIC_TYPE_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Beneficiary Type '||vBENEFIC_TYPE||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


            END IF;



             IF(vOCCUPATION IS NOT NULL) THEN

             vOCCUPATION :=CASE WHEN TRIM(UPPER(vOCCUPATION))='#NULL' AND pTrans_Type ='UPDATE' THEN vOCCUPATION
                         ELSE vOCCUPATION END;

            END IF;



             IF(vDEPENDENT_NAME IS NOT NULL) THEN

             vDEPENDENT_NAME :=CASE WHEN TRIM(UPPER(vDEPENDENT_NAME))='#NULL' AND pTrans_Type ='UPDATE' THEN vDEPENDENT_NAME
                         ELSE vDEPENDENT_NAME END;

            END IF;

               vEMP_ID := HR_PK_VALIDATION.FN_GET_EMP_AID(  vComp_Id,vEMP_MID);
               vRELATION_ID:= HR_PK_VALIDATION. FN_GET_PARAMETERS_ID(vRELATION);
               
              IF(vMARITAL_STATUS IS NOT NULL) THEN

             vMARITAL_STATUS_ID :=CASE WHEN TRIM(UPPER(vMARITAL_STATUS))='#NULL' AND pTrans_Type ='UPDATE' THEN vMARITAL_STATUS
                         ELSE  HR_PK_VALIDATION. FN_GET_PARAMETERS_ID(vMARITAL_STATUS) END;

            END IF;

               IF vEMP_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Employee Code '||vEMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               -- Checking duplicate data exist or not
               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

                    OPEN curRec FOR
                        SELECT COUNT(*)
                        FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vEMP_MID))  and UPPER(TRIM(COL3))=UPPER(TRIM(vDEPENDENT_NAME));
                                 -- AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vGRADE_NAME))='#NULL');
                    FETCH curRec INTO vChkRecordCount;
                    CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Member Name '||TRIM(UPPER(vDEPENDENT_NAME))||' for Employee code '||UPPER(TRIM(vEMP_MID));
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;



               SELECT    COUNT (DISTINCT COL4)  INTO cEFF_DATE_FR FROM  HR_TEMP_RAW_UPLOAD  WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID and COL2=vEMP_MID AND ERROR_MSG IS NULL ;

               IF pTrans_Type IN ('ADD','REMOVE AND ADD','UPDATE') THEN

                  SELECT DISTINCT COUNT(COL3) INTO cEMP_ID  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id AND COL3=vEMP_ID ;

                    IF(cEMP_ID = 0 ) THEN
                       IF(I=0) THEN
                          vREV_NO  := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'HR_PT_EMP_OTC_DEFINE',I+1);
                       ELSE
                         -- SELECT  TO_NUMBER(MAX(SUBSTR(COL2,3)))   INTO     FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id  ;
                          vREV_NO:='EC'||TRIM(TO_CHAR(NVL(aREV_NO,0)+1,'000000'));
                        END IF;
                    ELSE
                        /*to assign the same Rev No for all the allowances being uploaded for an employee*/
                        SELECT DISTINCT COL2 INTO vREV_NO  FROM  HR_PT_FINAL_UPLOAD_DATA  WHERE UPLOAD_BATCH_ID= vUpldBatch_Id AND COL1= vComp_Id AND COL3=vEMP_ID;
                    END IF;
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,
                                                        ROW_NO,COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15)
                       VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2,
                        vComp_Id,vEMP_ID,vDEPENDENT_NAME,vMARITAL_STATUS_ID,vGENDER,vADDRESS,vPHONE_NO,vRELATION_ID,vDATE_OF_BIRTH,
                        vCOUNTRY_ID,vSTATE_ID,vLOCATIONID,vBENEFIC_TYPE_ID,vOCCUPATION,vSR_NO);
                    END IF;
                   --COMMIT;
             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2,
                        vCOMP_MID,vEMP_MID,vDEPENDENT_NAME,vMARITAL_STATUS,vGENDER,vADDRESS,vPHONE_NO,vRELATION,vDATE_OF_BIRTH,vCOUNTRY,vSTATE,vLOCATION,vBENEFIC_TYPE,vOCCUPATION,vSR_NO);

                 COMMIT;

            END LOOP;

            UPDATE HR_TEMP_RAW_UPLOAD SET ERROR_FLAG='Y'
            WHERE UPLOAD_BATCH_ID=vUpldBatch_Id AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND  UPLOAD_AID=pUpload_Aid
             AND (COL1, COL2) IN
            (SELECT COL1, COL2 FROM HR_TEMP_RAW_UPLOAD
             WHERE  UPLOAD_BATCH_ID=vUpldBatch_Id AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND  UPLOAD_AID=pUpload_Aid
                AND ERROR_FLAG IS NOT NULL AND  ERROR_MSG IS NOT NULL);

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE



            IF(pOperationType = 'COMMIT_UPLOAD') THEN--Final data insert in base table GM_GRADE_MSTR
                FOR I IN ( SELECT  TRANS_TYPE,SR_NO,COMP_ID,EMP_ID,DEPENDENT_NAME,MARITAL_STATUS,GENDER,ADDRESS,PHONE_NO,RELATION_EMP,BIRTH_DATE,
                                    BIRTH_COUNTRY,BIRTH_STATE,BIRTH_CITY,DEPENDENT_TYPE,OCCUPATION,USER_CR,CR_DATE
                           FROM   (SELECT  TRANS_TYPE,COL16 SR_NO, COL1 COMP_ID, COL2 EMP_ID, COL3 DEPENDENT_NAME, COL4 MARITAL_STATUS,COL5 GENDER,
                                           COL6 ADDRESS, COL7 PHONE_NO, COL8 RELATION_EMP ,COL9 BIRTH_DATE,COL10 BIRTH_COUNTRY,
                                           COL11 BIRTH_STATE,COL12 BIRTH_CITY,COL13 DEPENDENT_TYPE ,COL14 OCCUPATION,pUser_Aid USER_CR, SYSDATE CR_DATE
                               FROM HR_VW_FINAL_UPLOAD_DATA
                               WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                                 AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
                           WHERE EMP_ID NOT IN (SELECT COL2 FROM HR_TEMP_RAW_UPLOAD  WHERE  UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND ERROR_MSG IS NOT NULL    )
                           GROUP BY TRANS_TYPE,SR_NO,COMP_ID,EMP_ID,DEPENDENT_NAME,MARITAL_STATUS,GENDER,ADDRESS,PHONE_NO,RELATION_EMP,BIRTH_DATE,
                                    BIRTH_COUNTRY,BIRTH_STATE,BIRTH_CITY,DEPENDENT_TYPE,OCCUPATION,USER_CR,CR_DATE)
                LOOP



                    IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                                   vAGENUM:=ROUND(TO_NUMBER(SYSDATE -TO_DATE(I.BIRTH_DATE))/365);

                     SELECT NVL(MAX(SR_NO),0) + 1 INTO vSR_NO  FROM GM_EMP_DEPENDENT  WHERE EMP_ID=I.EMP_ID;
                                 INSERT INTO GM_EMP_DEPENDENT(EMP_ID,SR_NO,DEPENDENT_NAME,MARITAL_STATUS,GENDER,ADDRESS,PHONE_NO,
                                                    RELATION_EMP,BIRTH_DATE,BIRTH_COUNTRY,BIRTH_STATE,BIRTH_CITY,DEPENDENT_TYPE,OCCUPATION,USER_CR,CR_DATE,AGE,COMP_ID)
                                            VALUES(I.EMP_ID,vSR_NO,I.DEPENDENT_NAME,I.MARITAL_STATUS,I.GENDER,I.ADDRESS,I.PHONE_NO,
                                                    I.RELATION_EMP,I.BIRTH_DATE,I.BIRTH_COUNTRY,I.BIRTH_STATE,I.BIRTH_CITY,I.DEPENDENT_TYPE,I.OCCUPATION,pUser_Aid,SYSDATE,vAGENUM,I.COMP_ID );



                     ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                     SELECT SR_NO INTO vSR_NO FROM GM_EMP_DEPENDENT
                                     WHERE COMP_ID = I.COMP_ID
                                         AND EMP_ID = I.EMP_ID
                                         AND UPPER(TRIM(DEPENDENT_NAME))=UPPER(TRIM(I.DEPENDENT_NAME));

                     vAGENUM:=ROUND(TO_NUMBER(SYSDATE -TO_DATE(I.BIRTH_DATE))/365);


                              UPDATE GM_EMP_DEPENDENT
                                   SET --DEPENDENT_NAME=I.DEPENDENT_NAME,
                                    DEPENDENT_NAME=DECODE(TRIM(I.DEPENDENT_NAME),'#NULL',DEPENDENT_NAME,TRIM(I.DEPENDENT_NAME)),
                                     MARITAL_STATUS=DECODE(TRIM(I.MARITAL_STATUS),'#NULL',MARITAL_STATUS,TRIM(I.MARITAL_STATUS)),
                                     GENDER=DECODE(TRIM(I.GENDER),'#NULL',GENDER,TRIM(I.GENDER)),
                                     ADDRESS=DECODE(TRIM(I.ADDRESS),'#NULL',ADDRESS,TRIM(I.ADDRESS)),
                                     PHONE_NO=DECODE(TRIM(I.PHONE_NO),'#NULL',PHONE_NO,TRIM(I.PHONE_NO)),
                                     RELATION_EMP=DECODE(TRIM(I.RELATION_EMP),'#NULL',RELATION_EMP,TRIM(I.RELATION_EMP)),
                                     BIRTH_DATE=DECODE(TRIM(I.BIRTH_DATE),'#NULL',BIRTH_DATE,TRIM(I.BIRTH_DATE)),
                                     BIRTH_COUNTRY=DECODE(TRIM(I.BIRTH_COUNTRY),'#NULL',BIRTH_COUNTRY,TRIM(I.BIRTH_COUNTRY)),
                                     BIRTH_STATE=DECODE(TRIM(I.BIRTH_STATE),'#NULL',BIRTH_STATE,TRIM(I.BIRTH_STATE)),
                                     BIRTH_CITY=DECODE(TRIM(I.BIRTH_CITY),'#NULL',BIRTH_CITY,TRIM(I.BIRTH_CITY)),
                                     DEPENDENT_TYPE=DECODE(TRIM(I.DEPENDENT_TYPE),'#NULL',DEPENDENT_TYPE,TRIM(I.DEPENDENT_TYPE)),
                                     OCCUPATION=DECODE(TRIM(I.OCCUPATION),'#NULL',OCCUPATION,TRIM(I.OCCUPATION)),
                                     AGE=DECODE(TRIM(vAGENUM),'#NULL',vAGENUM,TRIM(vAGENUM)),
                                     USER_UP=pUser_Aid,
                                     UP_DATE=SYSDATE
                                            WHERE COMP_ID = I.COMP_ID
                                           AND EMP_ID = I.EMP_ID
                                           AND SR_NO=vSR_NO;


                    END IF;

                END LOOP;

            END IF;
            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
           SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PT_EMP_CTC_DEFINE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

           OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;


    END;


PROCEDURE UPLOAD_SUB_DEPARTMENT(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;
    vComp_Id                GM_COMP.COMP_ID%TYPE;
    vSub_Dept_Aid           GM_SUB_DEPT.SUB_DEPT_AID%TYPE;
    vDept_Aid               GM_DEPTS.DEPT_ID%TYPE;
    
    vComp_Mid               GM_COMP.COMP_MID%TYPE;
    vSub_Dept_Mid           GM_SUB_DEPT.SUB_DEPT_MID%TYPE;
    vSub_Dept_Desc          GM_SUB_DEPT.SUB_DEPT_DESC%TYPE;
    vSub_Dept_Sdesc         GM_SUB_DEPT.SUB_DEPT_SDESC%TYPE;
    vDept_Mid               GM_DEPTS.DEPT_MID%TYPE;
    vRemarks                GM_SUB_DEPT.REMARKS%TYPE;
    pSub_Dept_Mid           GM_SUB_DEPT.SUB_DEPT_MID%TYPE;
    
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    vACTIVE_Dept_Aid          VARCHAR2(20);

    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

            vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            --'<NewDataSet><ExcelInfo><COMP_MID>JW</COMP_MID><DEPT_MID>0001</GRADE_MID><DEPT_DESC>GRADE1</GRADE_NAME><BAND_MID>HI</BAND_MID></ExcelInfo></NewDataSet>';

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';
                
                vSub_Dept_Aid := NULL; vDept_Aid := NULL; vComp_Mid := NULL; vSub_Dept_Mid := NULL; 
                vSub_Dept_Desc := NULL; vSub_Dept_Sdesc := NULL; vDept_Mid := NULL; vRemarks := NULL; 
                
                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vComp_Mid);
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for COMPANY_CODE (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Company Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_DEPT_CODE/text()',vSub_Dept_Mid );
                EXCEPTION
                  WHEN OTHERS THEN
                 IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Department Code (Max limit is 30 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Department Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;


                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_DEPT_NAME/text()',vSub_Dept_Desc );
                EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Department Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Department Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;
                
                
                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'SUB_DEPT_SHORT_NAME/text()',vSub_Dept_Sdesc);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Sub Department Short Name (Max limit is 100 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Sub Department Short Name';
                  END IF;
                  GOTO PRINT_ERROR;
                END;                

                BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPARTMENT_CODE/text()',vDept_Mid );
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Department Code (Max limit is 8 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Department Code';
                  END IF;
                  GOTO PRINT_ERROR;
                END;

                BEGIN 
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'REMARKS/text()',vRemarks);
                EXCEPTION
                  WHEN OTHERS THEN
                  IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Remarks (Max limit is 200 character)';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Remarks';
                  END IF;
                  GOTO PRINT_ERROR;
                END; 


                 IF vComp_Mid IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Company Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

               IF NVL(LENGTH(TRIM(NVL(vSub_Dept_Mid ,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Sub Department Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


               IF NVL(LENGTH(TRIM(NVL(vSub_Dept_Desc,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Sub Department Name should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
             
                
                IF TRIM(vREMARKS) IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Remarks cannot be blank';
                    GOTO PRINT_ERROR;
                END IF; 

               vComp_Id := HR_PK_VALIDATION.FN_GET_COMP_AID(vComp_Mid);

               IF vComp_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vComp_Mid||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSub_Dept_Mid),'~!@#$%^&*()_+/-=.,') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Sub Department Code special character found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vSub_Dept_Mid),' ') > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid Sub Department Code space found!';
                     GOTO PRINT_ERROR;
               END IF;

               IF pTrans_Type ='UPDATE' THEN
                   vSub_Dept_Aid := HR_PK_VALIDATION.FN_GET_SUB_DEPT_AID(vComp_Id, vSub_Dept_Mid);

                   IF vSub_Dept_Aid IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Sub Department Code '||vSub_Dept_Mid||' does not exist';
                        GOTO PRINT_ERROR;
                   END IF;
               END IF;
               

               IF vDept_Mid IS NOT NULL THEN

                   vDept_Aid := HR_PK_VALIDATION.FN_GET_DEPT_AID(vComp_Id, vDept_Mid); 

                   IF vDept_Aid IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Department Code '||vDept_Mid||' does not exist';
                        GOTO PRINT_ERROR;
                   END IF;
                         
                   --start added by vinayak 
                                
                  vACTIVE_Dept_Aid:=HR_PK_VALIDATION.FN_GET_ACTIVE_DEPT_AID(vComp_Id, vDept_Mid);
                   
                   IF vACTIVE_Dept_Aid IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Department Code '||vDept_Mid||' is Inactive';
                        GOTO PRINT_ERROR;
                   END IF;
                   
                   --- end
                   
               END IF;

--               IF pTrans_Type IN ('ADD') THEN
                OPEN curRec FOR
                  SELECT SUB_DEPT_MID,COUNT(*) 
                    FROM GM_SUB_DEPT WHERE UPPER(TRIM(COMP_AID))=UPPER(TRIM(vComp_Id)) AND UPPER(TRIM(SUB_DEPT_DESC))=UPPER(TRIM(vSub_Dept_Desc))
                     GROUP BY SUB_DEPT_MID;
                FETCH curRec INTO pSub_Dept_Mid,vChkRecordCount;
                CLOSE curRec;

                  IF pSub_Dept_Mid<>vSub_Dept_Mid AND vChkRecordCount >0 THEN

                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Sub Department Code already exist!';
                    GOTO PRINT_ERROR;
                 END IF;
                 
--               END IF;

               -- Checking duplicate data exist or not
           --    IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) AND UPPER(TRIM(COL2))=UPPER(TRIM(vSub_Dept_Mid)) ;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;

                    OPEN curRec FOR
                       SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) AND UPPER(TRIM(COL3))=UPPER(TRIM(vSub_Dept_Desc))
                                AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vSub_Dept_Desc))='#NULL');
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate Sub Department Name Found !';
                         GOTO PRINT_ERROR;
                     END IF;

               -- Checking data exist
               IF pTrans_Type IN ('ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_SUB_DEPT
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(SUB_DEPT_MID)) = UPPER(TRIM(vSub_Dept_Mid));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;


                 IF pTrans_Type IN ('UPDATE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_SUB_DEPT
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(SUB_DEPT_AID)) = UPPER(TRIM(vSub_Dept_Aid));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount = 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;
               
                 IF pTrans_Type IN ('DELETE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(*) FROM GM_SUB_DEPT
                            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(SUB_DEPT_MID)) = UPPER(TRIM(vSub_Dept_Mid));
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount < 1 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist to delete!';
                         GOTO PRINT_ERROR;
                     ELSE
                          DELETE FROM GM_SUB_DEPT 
                              WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(vCOMP_ID))  AND UPPER(TRIM(SUB_DEPT_MID)) = UPPER(TRIM(vSub_Dept_Mid));
                                             
                     END IF;
                     
               END IF;


               --Get the Grade_Aid
               IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
                    vSub_Dept_Aid   := HR_PK_VALIDATION.FN_GENERATE_AID(vComp_Id, 'GM_SUB_DEPT',I+1);
               END IF;

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO, COL1, COL2, COL3, COL4,COL5,COL6,COL7)
                   VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE , I+2, vComp_Id, vSub_Dept_Aid , vSub_Dept_Mid , vSub_Dept_Desc, vSub_Dept_Sdesc, vDept_Aid ,vRemarks );  
                END IF;

             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
                        COL1, COL2, COL3,COL4,COL5,COL6)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2, vComp_Mid, vSub_Dept_Mid,vSub_Dept_Desc,vSub_Dept_Sdesc,vDept_Mid,vRemarks);

            END LOOP;

           --Inserting Upload Summary
           INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

        ELSE

            --Final data insert in base table GM_SUB_DEPT
            FOR I IN (SELECT  TRANS_TYPE, COL1 COMP_CODE, COL2 SUB_DEPT_AID, COL3 SUB_DEPT_MID, COL4 SUB_DEPT_DESC,COL5 SUB_DEPT_SDESC,COL6 DEPT_AID,COL7 REMARKS,
                         pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
            LOOP

                IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN

                    INSERT INTO GM_SUB_DEPT (COMP_AID, SUB_DEPT_AID, SUB_DEPT_MID, SUB_DEPT_DESC, SUB_DEPT_SDESC, DEPT_AID, REMARKS, USER_CR, DATE_CR, IS_ACTIVE)
                            VALUES(I.COMP_CODE, HR_PK_VALIDATION.FN_GENERATE_AID(I.COMP_CODE, 'GM_SUB_DEPT',1), I.SUB_DEPT_MID, I.SUB_DEPT_DESC ,I.SUB_DEPT_SDESC,
                            I.DEPT_AID ,I.REMARKS,I.CR_USER_ID,I.CR_DATE,1);

                ELSIF I.TRANS_TYPE IN ('UPDATE') THEN

                    UPDATE GM_SUB_DEPT
                    SET SUB_DEPT_DESC= DECODE(TRIM(I.SUB_DEPT_DESC),'#NULL',SUB_DEPT_DESC,TRIM(I.SUB_DEPT_DESC))
                    ,SUB_DEPT_SDESC= DECODE(TRIM(I.SUB_DEPT_SDESC),'#NULL',SUB_DEPT_SDESC,TRIM(I.SUB_DEPT_SDESC))
                    ,DEPT_AID= DECODE(TRIM(I.DEPT_AID),'#NULL',DEPT_AID,TRIM(I.DEPT_AID))
                    ,REMARKS= DECODE(TRIM(I.REMARKS),'#NULL',REMARKS,TRIM(I.REMARKS))
                    ,USER_UP = I.UP_USER_ID, DATE_UP = I.UP_DATE 
                    WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_CODE)) AND UPPER(TRIM(SUB_DEPT_AID)) = UPPER(TRIM(I.SUB_DEPT_AID));
                END IF;

            END LOOP;

            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

       COMMIT;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;


       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_SUB_DEPT' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

        OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

    END;

PROCEDURE GET_UPLOAD_FORMAT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid  VARCHAR2,pUpload_Type VARCHAR2,Return_Recordset OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    VUploadTemp               HR_PM_STANDARD_UPLOAD.UPLOAD_TEMPLATE%TYPE;
    vUpl_Report_Temp          HR_PM_STANDARD_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    vEMP_MID_FLAG             VARCHAR2(10);
    vEMP_MID_LOGIC            VARCHAR2(10);
    BEGIN
     
       OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE,UPLOAD_TEMPLATE FROM HR_PM_STANDARD_UPLOAD
            WHERE    UPLOAD_AID = pUpload_Aid;
        FETCH curRec INTO vUpl_Report_Temp,VUploadTemp;
        CLOSE curRec;

        OPEN curRec FOR
             SELECT IS_EMP_CODE_AUTOGENERATED,EMP_CODE_AUTOGENERATED_LOGIC
             FROM GM_COMP WHERE COMP_ID=pComp_Aid;
         FETCH curRec INTO vEMP_MID_FLAG,vEMP_MID_LOGIC;
         CLOSE curRec; 
        
        IF pUpload_Aid='UP000012' AND vEMP_MID_FLAG='Y' AND pUpload_Type = 'ADD' THEN
          VUploadTemp:=REPLACE(VUploadTemp,'EMPLOYEE_CODE|','');
          vUpl_Report_Temp:=REPLACE(vUpl_Report_Temp,'COL2 EMPLOYEE_CODE|','');
        END IF;   
        
        open Return_Recordset for
        select VUploadTemp,vUpl_Report_Temp from dual;

     END;

END ;