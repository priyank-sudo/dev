create or replace PACKAGE PCK_FTP_UPLOAD
AS

TYPE REC IS REF CURSOR;

PROCEDURE GET_MAPPED_COLUMNS(pUploadType VARCHAR2,Return_RecordSet OUT REC);

PROCEDURE GET_HRMS_COLUMNS(pUploadType VARCHAR2,Return_RecordSet OUT REC);

PROCEDURE GET_VAR_COLUMN_FLAG(pUploadType varchar2,oMessage OUT varchar2);

PROCEDURE GET_SFTP_MASTER_DATA(pFTPUploadID varchar2, Return_RecordSet OUT REC);

PROCEDURE GET_SFTP_UPLOAD_DATA(pFTPUploadID varchar2,pUploadMasterID varchar2,Return_RecordSet OUT REC);

PROCEDURE FILL_GRID_SFTP_UPLOAD_DATA(pUploadId IN VARCHAR2,pUploadMasterId IN VARCHAR2,CONDICOLUMNNAME1 IN VARCHAR2,CONDICOLUMNVALUE1 IN VARCHAR2,DEFAULTORDERSTRING IN VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC);

PROCEDURE UPLOAD_SFTP_DATA(pUploadType varchar2, pUserID varchar2,pRawFTPXMLData CLOB,pFileName varchar2,pFilePath varchar2,pErrorMessage varchar2,Return_RecordSet OUT REC);

PROCEDURE UPDATE_SFTP_UPLOAD(pStatus varchar2,pUploadMasterID varchar2,pUploadBatchID varchar2,pSessionID varchar2,oMessage OUT varchar2);

PROCEDURE SFTP_FILE_UPLOADED_DETAILS(pColumnName varchar2,pColumnValue varchar2,pPageSize varchar2,pPageNo varchar2, Return_RecordSet OUT REC);

PROCEDURE GET_UPLOAD_DETAIL_REPORT(pUserID VARCHAR2,pSessionID VARCHAR2,pUploadID VARCHAR2,pStatus VARCHAR2,
       pUploadBatchID VARCHAR2,Return_Recordset OUT REC);

PROCEDURE GET_UPLOAD_MASTER(Return_RecordSet OUT REC);

PROCEDURE GET_SFTP_VARIANCE_REPORT(pReportType varchar2,pUploadMasterID varchar2,Return_RecordSet OUT REC);

PROCEDURE EXPORT_UPLOAD_DETAIL_REPORT(pStatus VARCHAR2,pUpload_Aid varchar2, pUploadBatch_Id VARCHAR2,Return_Recordset OUT REC);

PROCEDURE PRO_GET_PACKAGE_NAME(pUploadID varchar2,oMessage OUT varchar2);


--Fill the uploaded Summary
PROCEDURE GET_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
        pUploadBatch_id  VARCHAR2, Return_Recordset OUT REC);

PROCEDURE SAVE_ACKNOWLEDGE_DETAILS(pFile_Name VARCHAR2, pFile_Status VARCHAR2, pError_log VARCHAR2);

PROCEDURE GET_ACKNOWLEDGE_REPORTS(Return_RecordSet OUT REC);

PROCEDURE GET_ERROR_LOG_REPORT(pReportType VARCHAR2,pUploadMasterID VARCHAR2,Return_Recordset OUT REC);

PROCEDURE GET_ALUMNI_PAYSLIP_COUNT(pUploadMasterID varchar2,pUploadBatchID varchar2,pSessionID varchar2,Return_RecordSet OUT REC);

PROCEDURE InsertMail_ErrorLog(pCompId varchar2,pReportID varchar2,pFileName varchar2,pMailBody varchar2,pMAIL_STATUS varchar2,pMAIL_STATUS_MESSAGE varchar2,pMail_ID varchar2, pCURSOR OUT REC);
PROCEDURE GET_MAIL_DETAILS(pCompId varchar2,pFileName varchar2 ,Return_RecordSet OUT REC);

END PCK_FTP_UPLOAD;


/


create or replace PACKAGE BODY PCK_FTP_UPLOAD
AS


PROCEDURE GET_MAPPED_COLUMNS(pUploadType VARCHAR2,Return_RecordSet OUT REC)
AS
vUploadID             VARCHAR2(100);
BEGIN
    SELECT UPLOAD_ID INTO vUploadID             
      FROM GM_FTP_UPLOAD 
        where UPLOAD_NAME=pUploadType;
  OPEN Return_RecordSet FOR
      SELECT UPPER(TRIM(TEMPLATE_COLUMN_NAME)) TEMPLATE_COLUMN_NAME
            ,UPPER(TRIM(UPLOAD_COLUMN_NAME)) UPLOAD_COLUMN_NAME
            ,UPPER(TRIM(HRMS_COLUMN_NAME)) HRMS_COLUMN_NAME
          FROM PM_FTP_UPLOAD_COLUMN_MAPPING
            WHERE UPLOAD_ID=vUploadID AND NVL(HRMS_COLUMN_NAME,'0')<>'COMP_CODE' 
            AND TEMPLATE_COLUMN_NAME<>'VAR_COL';
   -- select UPLOAD_ID, UPLOAD_COLUMNS,MAPPED_COLUMNS FROM GM_FTP_UPLOAD where Upload_ID=vUploadID;
END GET_MAPPED_COLUMNS;

PROCEDURE GET_HRMS_COLUMNS(pUploadType VARCHAR2,Return_RecordSet OUT REC)
AS
vUploadID             VARCHAR2(100);
BEGIN
    SELECT UPLOAD_ID INTO vUploadID             
      FROM GM_FTP_UPLOAD 
        where UPLOAD_NAME=pUploadType;
  OPEN Return_RecordSet FOR
      SELECT LISTAGG(HRMS_COLUMN_NAME,'|') WITHIN GROUP (ORDER BY SORT_ORDER) UPLOAD_TEMPLATE
        FROM PM_FTP_UPLOAD_COLUMN_MAPPING 
          where UPLOAD_ID=vUploadID
            AND HRMS_COLUMN_NAME IS NOT NULL 
        ORDER BY SORT_ORDER;
END GET_HRMS_COLUMNS;

PROCEDURE GET_VAR_COLUMN_FLAG(pUploadType varchar2,oMessage OUT varchar2)
AS
vUploadID             VARCHAR2(20);
BEGIN
  SELECT UPLOAD_ID INTO vUploadID             
      FROM GM_FTP_UPLOAD 
        where UPLOAD_NAME=pUploadType;
  oMessage:='0';
  SELECT NVL(MAX(IS_VAR_COLUMN_PRESENT),0) INTO oMessage
    FROM GM_FTP_UPLOAD WHERE UPLOAD_ID=vUploadID;
END GET_VAR_COLUMN_FLAG;


PROCEDURE GET_SFTP_MASTER_DATA(pFTPUploadID varchar2, Return_RecordSet OUT REC)
AS
BEGIN
  OPEN Return_RecordSet FOR
    SELECT M.Upload_Master_ID
        ,M.Upload_Id
        ,GM.HRMS_UPLOAD_AID HrmsUploadID
        ,GM.PACKAGE_NAME HrmsPackageName
        ,TO_CHAR(M.Upload_Date,'DD-MON-yyyy') Upload_Date
        ,M.File_Name
        ,M.File_Path 
        ,CASE STATUS 
            WHEN 'PUBLISHED' THEN 'SUCCESS'
            WHEN 'SFTP0' THEN 'READY FOR PUBLISHED' 
            WHEN 'SFTP1' THEN 'FAILED' 
            WHEN 'FAILED' THEN 'FAILED'
            ELSE 'FAILED'
            END AS STATUS         
        ,M.ERROR_MESSAGE
      FROM PM_FTP_UPLOAD M
        LEFT JOIN GM_FTP_UPLOAD GM
          ON M.UPLOAD_ID=GM.UPLOAD_ID
        WHERE M.UPLOAD_ID=pFTPUploadID
        ORDER BY M.UPLOAD_MASTER_ID DESC;
END GET_SFTP_MASTER_DATA;

PROCEDURE GET_SFTP_UPLOAD_DATA(pFTPUploadID varchar2,pUploadMasterID varchar2,Return_RecordSet OUT REC)
AS
  vQuery CLOB;
  vColumns LONG;
BEGIN
  SELECT NVL(REPLACE(rtrim(xmlagg(xmlelement(e,str,',').extract('//text()') order by SRNO).GetClobVal(),','),'null;',''''),''''' AS A') STR_RPT_COLUMN INTO vColumns
      FROM (SELECT ftp.HRMS_COLUMN_NAME 
                  ,upload_column_name || ' AS ' ||  HRMS_COLUMN_NAME STR
                  ,ROWNUM SRNO
                FROM PM_FTP_UPLOAD_COLUMN_MAPPING ftp
                  WHERE UPLOAD_ID=pFTPUploadID
                    AND HRMS_COLUMN_NAME IS NOT NULL);

  vQuery:='SELECT 
                 '
                 ||vColumns||
             ' FROM PM_FTP_UPLOAD M
                 LEFT JOIN PT_FTP_UPLOAD D
                   ON M.UPLOAD_MASTER_ID=D.UPLOAD_MASTER_ID

                    WHERE M.UPLOAD_ID='''||pFTPUploadID||'''
                      AND M.UPLOAD_MASTER_ID='''||pUploadMasterID||'''
                  ORDER BY M.UPLOAD_MASTER_ID DESC';                  

  OPEN Return_RecordSet FOR vQuery;
END GET_SFTP_UPLOAD_DATA;

PROCEDURE FILL_GRID_SFTP_UPLOAD_DATA(pUploadId IN VARCHAR2,pUploadMasterId IN VARCHAR2,CONDICOLUMNNAME1 IN VARCHAR2,CONDICOLUMNVALUE1 IN VARCHAR2,DEFAULTORDERSTRING IN VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC)
AS
  vQuery CLOB;
  vColumns LONG;
BEGIN

SELECT NVL(REPLACE(rtrim(xmlagg(xmlelement(e,str,',').extract('//text()') order by SRNO).GetClobVal(),','),'null;',''''),''''' AS A') STR_RPT_COLUMN INTO vColumns
      FROM (SELECT ftp.HRMS_COLUMN_NAME 
                  ,upload_column_name || ' AS ' ||  HRMS_COLUMN_NAME STR
                  ,ROWNUM SRNO
                FROM PM_FTP_UPLOAD_COLUMN_MAPPING ftp
                  WHERE UPLOAD_ID=pUploadId
                    AND HRMS_COLUMN_NAME IS NOT NULL);

            IF CONDICOLUMNNAME1 is NULL THEN

            vQuery:=
                ' SELECT * from(
                SELECT '||vColumns||' 
                 FROM PM_FTP_UPLOAD M
                 LEFT JOIN PT_FTP_UPLOAD D
                   ON M.UPLOAD_MASTER_ID=D.UPLOAD_MASTER_ID

                    WHERE M.UPLOAD_ID='''||pUploadId||'''
                      AND M.UPLOAD_MASTER_ID='''||pUploadMasterId||'''
                  ORDER BY M.UPLOAD_MASTER_ID DESC
                 )a';

                 --where a.'||CONDICOLUMNNAME1||' LIKE  ''%'||CONDICOLUMNVALUE1||'%'''; 
            ELSE


      vQuery:=
                ' SELECT * from(
                SELECT '||vColumns||' 
                 FROM PM_FTP_UPLOAD M
                 LEFT JOIN PT_FTP_UPLOAD D
                   ON M.UPLOAD_MASTER_ID=D.UPLOAD_MASTER_ID

                    WHERE M.UPLOAD_ID='''||pUploadId||'''
                      AND M.UPLOAD_MASTER_ID='''||pUploadMasterId||'''
                  ORDER BY M.UPLOAD_MASTER_ID DESC
                 )a
                 where a.'||CONDICOLUMNNAME1||' LIKE  ''%'||CONDICOLUMNVALUE1||'%''';                  

  END IF;
  OPEN Return_FillGrid FOR vQuery;


END FILL_GRID_SFTP_UPLOAD_DATA;

  PROCEDURE UPLOAD_SFTP_DATA(pUploadType varchar2, pUserID varchar2,pRawFTPXMLData CLOB,pFileName varchar2,pFilePath varchar2,pErrorMessage varchar2,Return_RecordSet OUT REC)
AS 
  vCount Number(18,2);
  vNewValue             VARCHAR2(4000);
  vColumnNames          varchar2(1000);
  vColumnValues         varchar2(4000);
  vUploadID             varchar2(8);
  vUploadMasterID       NUMBER(18,2);
  vUploadDetailsID      NUMBER(18,2);
  vEMP_MID              VARCHAR2(200);
  vPAY_GROUP            VARCHAR2(200);

  vQuery                CLOB;
  vXmlParser            dbms_xmlparser.Parser;
  vXmlDomDocument       dbms_xmldom.DOMDocument;
  vXmlDOMNodeList       dbms_xmldom.DOMNodeList;
  vXmlDOMNode           dbms_xmldom.DOMNode;
  vCompMID              VARCHAR(20);
  vCompID               VARCHAR2(8);
  vCompAID               VARCHAR2(8);
  vYearID               VARCHAR2(8);
  vHRMSUploadID         VARCHAR2(8);
  vBatchID              VARCHAR2(25);
  vERROR_MSG                VARCHAR2(2000);
  vERROR_FLAG               VARCHAR2(1);

  vSessionID            VARCHAR2(30);
  pSessionID            VARCHAR2(30);
  vPackageName          VARCHAR2(200);
  vCOMP_CODE            VARCHAR2(8);
  vCOMP_AID             VARCHAR2(8);
  Vpaygroup          EXCEPTION;
  VComp_AID          EXCEPTION;
  vVarColumn            PT_FTP_UPLOAD.VAR_COLUMN%TYPE;
  VpErrorMessage          VARCHAR2(200);


BEGIN
--DELETE ABG_OSO;
--INSERT INTO ABG_OSO VALUES(pUploadType||','||pUserID||','||pRawFTPXMLData||','||pFileName||','||pFilePath||','||pErrorMessage);
--COMMIT;
    INSERT INTO UPLOAD_SFTP_DATA_TEMP VALUES(pRawFTPXMLData,pUploadType,SYSDATE);
    INSERT INTO UPLOAD_SFTP_DATA_TEMP1 VALUES(pUploadType||'@'||pUserID||'@'||pFileName||'@'||pFilePath||'@'||pErrorMessage,SYSDATE);
    COMMIT;
vERROR_FLAG:='N';
  vColumnNames :='UPLOAD_DETAILS_ID,UPLOAD_MASTER_ID';
  vColumnValues :='';
  vSessionID := TO_CHAR(SYSDATE,'DDMMYYYYHHMISS');
  select UPLOAD_ID--,HRMS_UPLOAD_AID 
  INTO vUploadID--,vHRMSUploadID             
      FROM GM_FTP_UPLOAD 
        where UPLOAD_NAME=pUploadType;

  select NVL(MAX(UPLOAD_MASTER_ID),0) + 1 INTO vUploadMasterID
    FROM PM_FTP_UPLOAD;

  INSERT INTO PM_FTP_UPLOAD(UPLOAD_MASTER_ID,UPLOAD_ID,UPLOAD_DATE,FILE_NAME,FILE_PATH,SESSIONID,ERROR_MESSAGE,USER_CR,DATE_CR)VALUES
  (vUploadMasterID,vUploadID,SYSDATE,pFileName,pFilePath,vSessionID,pErrorMessage,pUserID,SYSDATE);

--  SELECT distinct SUBSTR(pFileName,0,INSTR(pFileName,'_')-1) INTO vCOMP_CODE FROM DUAL;
--  
--  SELECT  NVL(COMP_MID, '') INTO vCompMID FROM GM_COMP WHERE MARSHA_CODE = vCOMP_CODE;
--  
--    SELECT distinct SUBSTR(pFileName,8,INSTR(pFileName,'_')-1) INTO vCOMP_CODE FROM DUAL;----  ADD BY SAROJ KUMAR GIRI
--    SELECT COMP_ID INTO vCOMP_AID FROM GM_EMP WHERE EMP_MID=vCOMP_CODE;
--    SELECT  NVL(COMP_MID, '') INTO vCompMID FROM GM_COMP WHERE COMP_ID = vCOMP_AID;


--Delete from VAI;  

  IF(pErrorMessage IS NULL OR pErrorMessage ='') THEN

      vXmlParser := dbms_xmlparser.newParser;
      dbms_xmlparser.parseClob(vXmlParser, pRawFTPXMLData);
--      dbms_xmlparser.parseClob(vXmlParser, '<DocumentElement> <dtUploadDetails>    <COLUMN1>Aditya Birla Mgmt Co. Pvt Ltd.</COLUMN1>    <COLUMN2>189224</COLUMN2>    <COLUMN3>06-22-2018</COLUMN3>    <COLUMN4>Change in Name</COLUMN4>    <COLUMN5>Change</COLUMN5>    <COLUMN6>Mr</COLUMN6>    <COLUMN7>Vij</COLUMN7>    <COLUMN8>TEST</COLUMN8>    <COLUMN9>Akshay</COLUMN9>    <COLUMN10>Mr Akshay Vij</COLUMN10>    <COLUMN11>M</COLUMN11>    <COLUMN12>09-29-1988</COLUMN12>    <COLUMN13>Single</COLUMN13>    <COLUMN14 />    <COLUMN15>poornataroute@adityabirla.com</COLUMN15>    <COLUMN16>Sanjeev Vij</COLUMN16>    <COLUMN17 />    <COLUMN18>0</COLUMN18>    <COLUMN19 /><COLUMN20 /><COLUMN21 /><COLUMN22 />    <COLUMN23 /><COLUMN24 />    <COLUMN25 />    <COLUMN26 />    <COLUMN27 />    <COLUMN28 />    <COLUMN29 />    <COLUMN30 />    <COLUMN31 />    <COLUMN32 />    <COLUMN33 />    <COLUMN34 />    <COLUMN35 />    <COLUMN36 />    <COLUMN37 />    <COLUMN38 />    <COLUMN39 />    <COLUMN40 />    <COLUMN41 />    <COLUMN42 />    <COLUMN43 />    <COLUMN44 />    <COLUMN45 />    <COLUMN46 />    <COLUMN47 />    <COLUMN48 />    <COLUMN49 />    <COLUMN50 />    <COLUMN51 />    <COLUMN52 />    <COLUMN53 />    <COLUMN54 />    <COLUMN55 />    <COLUMN56 /><COLUMN57 /><COLUMN58>0</COLUMN58><COLUMN59>0</COLUMN59><COLUMN60 />    <COLUMN61 />    <COLUMN62 />    <COLUMN63 />    <COLUMN64 />    <COLUMN65 />    <COLUMN66 />    <COLUMN67 /><COLUMN68 /><COLUMN69 /><COLUMN70 /><COLUMN71 /><COLUMN72 /><COLUMN73 /><COLUMN74 /><COLUMN75 /><COLUMN76 /><COLUMN77 /><COLUMN78 /><COLUMN79 /></dtUploadDetails></DocumentElement>');
      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
--      INSERT INTO OSO_CLOB VALUES(pRawFTPXMLData,SYSDATE);
--      COMMIT;
        vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/DocumentElement/dtUploadDetails');
      dbms_output.put_line(dbms_xmldom.getLength(vXmlDOMNodeList));
       FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1
            LOOP
                vNewValue:=null;
                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

         
         
          BEGIN

          IF vUploadID ='FT000007' THEN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'COLUMN17/text()',vPAY_GROUP);
          ELSIF vUploadID='FT000009' THEN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'COLUMN7/text()',vPAY_GROUP);
          ELSIF vUploadID IN ('FT000002') THEN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'COLUMN1/text()',vPAY_GROUP);
          ELSE 
           dbms_xslprocessor.valueOf(vXmlDOMNode,'COLUMN48/text()',vPAY_GROUP);
          END IF;        
          
--          INSERT INTO paygroup_check VALUES(vUploadID||'-'||vPAY_GROUP);
--            COMMIT;        
             
          IF vPAY_GROUP='AMET_PG002' THEN 
              
            vPAY_GROUP:='AMET_PG001';
                   
          END IF; 
           
          END;
          


                vColumnNames:='UPLOAD_DETAILS_ID,UPLOAD_MASTER_ID,VAR_COLUMN';
                SELECT NVL(MAX(UPLOAD_DETAILS_ID),0) + 1 INTO vUploadDetailsID
                  FROM PT_FTP_UPLOAD;

                dbms_xslprocessor.valueOf(vXmlDOMNode,'VAR_COLUMN/text()',vVarColumn);
                vColumnValues:= vUploadDetailsID||','|| vUploadMasterID ||','''||vVarColumn || '''';

                 FOR k IN
                    (select TRIM(UPLOAD_COLUMN_NAME) NUM_VALUE FROM PM_FTP_UPLOAD_COLUMN_MAPPING 
                      where UPLOAD_ID=vUploadID)
                    LOOP
                        dbms_xslprocessor.valueOf(vXmlDOMNode,k.num_value || '/text()',vNewValue);
                        IF(k.num_value='COLUMN1')THEN
                          vColumnNames := vColumnNames || ',' || k.num_value ;
                          vColumnValues := vColumnValues || ',''' || REPLACE(vCOMP_CODE,'''','') || '''';
                        ELSE
                          vColumnNames := vColumnNames || ',' || k.num_value ;
                          vColumnValues := vColumnValues || ',''' || REPLACE(SUBSTR(vNewValue,0,100),'''','') || '''';

                        END IF;
                    END LOOP;


            vQuery := 'INSERT INTO PT_FTP_UPLOAD('|| vColumnNames ||')VALUES('|| vColumnValues ||')';
--            INSERT INTO VAI VALUES(vQuery);
--                 COMMIT;
            EXECUTE IMMEDIATE vQuery;
          END LOOP;

    END IF;
    
    
--    OPEN Return_Recordset FOR
----        SELECT COMP_ID /*INTO vCompAID*/ FROM GM_COMP WHERE TRIM(BUSINESS_NATURE_ID)=TRIM(vPAY_GROUP);
--
--            SELECT REPLACE(COMP_ID,'M','A') FROM GM_COMP---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
--            WHERE BUSINESS_NATURE_ID=vPAY_GROUP
--            UNION ALL
--            SELECT REPLACE(COMP_ID,'M','H') FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
--            WHERE BUSINESS_NATURE_ID=vPAY_GROUP
--            UNION ALL
--            SELECT REPLACE(COMP_ID,'M','B') FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT
--            WHERE BUSINESS_NATURE_ID=vPAY_GROUP;            
--
--       FETCH Return_Recordset INTO  vCompAID;       
--       CLOSE Return_Recordset;
       
--       INSERT INTO VAI VALUES(vPAY_GROUP||'-'||vCompAID);
--            COMMIT;

      OPEN Return_Recordset FOR
        SELECT COMP_ID /*INTO vCompAID*/ FROM GM_COMP WHERE TRIM(BUSINESS_NATURE_ID)=TRIM(vPAY_GROUP);
       FETCH Return_Recordset INTO  vCompAID;
       CLOSE Return_Recordset;
       
              
              
       IF vUploadID NOT IN ('FT000002','FT000007','FT000009') THEN ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR. 
               vCompAID:='CM'||SUBSTR(vCompAID,3);     
       END IF;  

--      OPEN Return_Recordset FOR--COMMENTED BY ANISH BHOIL ON 13TH FEB 2020 FOR 3 IN 1 CONCEPT.
--        SELECT MAX(COMP_ID) --INTO vCompID
--          FROM GM_COMP where TRIM(UPPER(COMP_ID))=TRIM(UPPER(vCompAID));
--        FETCH Return_Recordset INTO  vCompID;
--       CLOSE Return_Recordset;

        SELECT MAX(YEAR_ID) INTO vYearID
            FROM PY_GM_ACCT_YEARS 
            where IS_YEAR_OPEN='Y';

      OPEN Return_Recordset FOR
        SELECT SESSIONID --INTO vCompID
          FROM PM_FTP_UPLOAD where TRIM(UPPER(UPLOAD_MASTER_ID))=TRIM(UPPER(vUploadMasterID));
        FETCH Return_Recordset INTO  pSessionID;
       CLOSE Return_Recordset;         


        select PACKAGE_NAME INTO vPackageName
          FROM GM_FTP_UPLOAD 
          where UPLOAD_ID=vUploadID;

--   IF vUploadID IN ('FT000002','FT000007','FT000009') THEN 
--        IF vPAY_GROUP IS NULL THEN
--        VpErrorMessage:='Pay Group Can Not be Null !';
--         RAISE Vpaygroup;
--      elsIF vCompAID IS NULL THEN
--        VpErrorMessage:='Comp Code Can Not be Null !';
--  --       RAISE VComp_AID;
--         RAISE Vpaygroup;
--      END IF;     
--   END IF;   
       
       OPEN Return_Recordset FOR
        SELECT vUploadMasterID UploadMasterID
              ,vCompAID COMP_ID--vcompid
              ,vYearID	ACCYEAR
              ,'US000000' USER_ID
              ,pSessionID SESSIONID
              ,vUploadID HRMS_UPLOAD_ID
              ,'ADD' TRANS_TYPE
              ,vPackageName PACKAGE_NAME
              ,CASE WHEN pErrorMessage IS NULL OR pErrorMessage='' THEN 'Success' ELSE pErrorMessage END   MESSAGE
             FROM DUAL;

--        HR_PK_SFTP_STANDARD_UPLOADS.Upload_New_Joinee('RAW_UPLOAD',vCompID,vYearID,'admin003',vSessionID,vHRMSUploadID,pRawHRMSXMLData,'ADD',NULL,Return_Recordset=>Return_Recordset);
--        
--        LOOP
--          FETCH Return_Recordset INTO rec;
--          EXIT WHEN Return_Recordset%NOTFOUND;
--            vBatchID:= rec.col2;
--        END LOOP;
--        HR_PK_SFTP_STANDARD_UPLOADS.Upload_New_Joinee('COMMIT_UPLOAD',vCompID,vYearID,'admin003',vSessionID,vHRMSUploadID,pRawHRMSXMLData,'ADD',vBatchID,Return_Recordset);
--        UPDATE PM_FTP_UPLOAD SET UPLOAD_BATCH_ID=vBatchID WHERE  SESSIONID=vSessionID AND UPLOAD_MASTER_ID=vUploadMasterID;
        COMMIT;
--        EXCEPTION WHEN OTHERS THEN
--          OPEN Return_Recordset FOR
--             SELECT vUploadMasterID UploadMasterID
--              ,'' COMP_ID
--              ,''	ACCYEAR
--              ,'US000000' USER_ID
--              ,'' SESSIONID
--              ,'' HRMS_UPLOAD_ID
--              ,'ADD' TRANS_TYPE
--              ,vPackageName PACKAGE_NAME
--              ,'Failed:: Data not saved' MESSAGE
--             FROM DUAL;
--               ROLLBACK;



   EXCEPTION 


   WHEN Vpaygroup THEN
   OPEN Return_Recordset FOR
           SELECT vUploadMasterID UploadMasterID
              ,vCompAID COMP_ID--vCompID
              ,vYearID	ACCYEAR
              ,'US000000' USER_ID
              ,vSessionID SESSIONID
              ,vUploadID HRMS_UPLOAD_ID
              ,'ADD' TRANS_TYPE
              ,vPackageName PACKAGE_NAME
              ,VpErrorMessage MESSAGE
             FROM DUAL;


   WHEN OTHERS THEN


      INSERT INTO EXCEPTION_TEST VALUES(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,SYSDATE);---format_error_stack
      INSERT INTO EXCEPTION_TEST VALUES(DBMS_UTILITY.format_error_stack,SYSDATE);---
      COMMIT;

END UPLOAD_SFTP_DATA;

PROCEDURE UPDATE_SFTP_UPLOAD(pStatus varchar2,pUploadMasterID varchar2,pUploadBatchID varchar2,pSessionID varchar2,oMessage OUT varchar2)
AS
BEGIN
    IF(pStatus ='SUCCESS') THEN
      IF((pUploadBatchID IS NULL or pUploadBatchID='') OR pSessionID IS NULL OR pSessionID ='' ) THEN
        UPDATE PM_FTP_UPLOAD SET STATUS='FAILED' WHERE Upload_Master_ID=pUploadMasterID;
      ELSE
        UPDATE PM_FTP_UPLOAD SET UPLOAD_BATCH_ID=pUploadBatchID ,STATUS='PUBLISHED'
          WHERE  UPLOAD_MASTER_ID=pUploadMasterID;--  AND SESSIONID=pSessionID;
      END IF;
    ELSIF(pStatus='SFTP0' OR pStatus='SFTP1')THEN
      UPDATE PM_FTP_UPLOAD SET STATUS=pStatus WHERE Upload_Master_ID=pUploadMasterID;
    ELSE
        UPDATE PM_FTP_UPLOAD SET STATUS='FAILED' WHERE Upload_Master_ID=pUploadMasterID;
    END IF;
    COMMIT;
      oMessage:='SUCCESS';
--    EXCEPTION WHEN OTHERS THEN
--      BEGIN
--          oMessage:='STATUS1:Data not saved!';
--          UPDATE PM_FTP_UPLOAD SET STATUS='ERROR' WHERE Upload_Master_ID=pUploadMasterID;
--          COMMIT;
--      END;
END UPDATE_SFTP_UPLOAD ;


PROCEDURE SFTP_FILE_UPLOADED_DETAILS(pColumnName varchar2,pColumnValue varchar2,pPageSize varchar2,pPageNo varchar2, Return_RecordSet OUT REC)
AS
  BEGIN
    OPEN Return_RecordSet FOR
      SELECT TO_CHAR(ftp.UPLOAD_DATE,'DD-MON-yyyy') UPLOAD_DATE
            ,HRM.USER_AID
            ,FTP.SESSIONID
            ,FTP.UPLOAD_BATCH_ID
            ,HRM.UPLOAD_AID HRMS_UPLOAD_ID
            ,ftp.FILE_NAME
            ,ftp.FILE_PATH
            ,NVL(hrm.TOTAL_RECORDS,0) TOTAL_RECORDS
            ,NVL(hrm.SUCCESS_RECORDS,0) SUCCESS_RECORDS
            ,NVL(hrm.FAILED_RECORDS,0) FAILED_RECORDS
            ,NVL(hrm.STATUS,'FAILED') STATUS
            ,ftp.ERROR_MESSAGE REMARK
            ,'VIEW' VIEW_DETAILS
            ,'EXPORT' EXPORT_DETAILS
        FROM PM_FTP_UPLOAD ftp
          LEFT JOIN HR_PM_UPLOAD_STATUS_HD hrm
            ON ftp.SESSIONID = hrm.SESSION_ID 
              AND ftp.UPLOAD_BATCH_ID = hrm.UPLOAD_BATCH_ID
          WHERE ((ftp.UPLOAD_BATCH_ID IS NOT NULL) OR (ERROR_MESSAGE IS NOT NULL))
          ORDER BY UPLOAD_DATE;
  END SFTP_FILE_UPLOADED_DETAILS;


PROCEDURE GET_UPLOAD_DETAIL_REPORT(pUserID VARCHAR2,pSessionID VARCHAR2,pUploadID VARCHAR2,pStatus VARCHAR2,
       pUploadBatchID VARCHAR2,Return_Recordset OUT REC)
AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          GM_FTP_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    vStrQuery                 LONG;

    BEGIN
        OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE 
              FROM GM_FTP_UPLOAD
                WHERE UPLOAD_ID = pUploadID;
        FETCH curRec INTO vUpl_Report_Temp;
        CLOSE curRec;


        vStrQuery :='SELECT DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS
                            ,ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',')||' 
                              FROM HR_TEMP_RAW_UPLOAD 
                                WHERE SESSION_ID = '''||pSessionID||''' 
                                  AND USER_AID = '''||pUserID||'''
                                  AND UPLOAD_AID = '''||pUploadID||''' 
                                  AND UPLOAD_BATCH_ID = '''||pUploadBatchID||'''' ;

        IF pStatus != 'TOTAL' THEN
            vStrQuery :=  vStrQuery||' AND DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') = '''||pStatus||'''';
        END IF;

       OPEN Return_Recordset FOR vStrQuery;

       EXCEPTION
            WHEN OTHERS THEN
              NULL;
                --HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUserID, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_DETAIL_REPORT',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END GET_UPLOAD_DETAIL_REPORT;





PROCEDURE GET_UPLOAD_MASTER(Return_RecordSet OUT REC)
AS
  BEGIN
    OPEN Return_Recordset FOR 
      SELECT UPLOAD_ID,TRIM(UPPER(UPLOAD_NAME)) UPLOAD_NAME,SRNO FROM GM_FTP_UPLOAD
        WHERE IS_ACTIVE=1;
  END GET_UPLOAD_MASTER;

PROCEDURE GET_SFTP_VARIANCE_REPORT(pReportType varchar2,pUploadMasterID varchar2,Return_RecordSet OUT REC)
AS
  vQuery CLOB;
  vTableColumn CLOB;
  vVARColumn CLOB;
BEGIN

  SELECT REPLACE(rtrim(xmlagg(xmlelement(e,TABLE_COLUMN,',').extract('//text()') order by SRNO).GetClobVal(),','),'null;','''') TABLE_COLUMN
      ,REPLACE(rtrim(xmlagg(xmlelement(e,str,',').extract('//text()') order by SRNO).GetClobVal(),','),'null;','''') STR_RPT_COLUMN
      INTO vTableColumn,vVARColumn
      FROM (
    SELECT ftp.HRMS_COLUMN_NAME ,ftp.UPLOAD_COLUMN_NAME ||' AS '||ftp.HRMS_COLUMN_NAME TABLE_COLUMN
          , 'AA.'||ftp.HRMS_COLUMN_NAME ||' AS File_'||ftp.HRMS_COLUMN_NAME||' ,BB.'||ftp.HRMS_COLUMN_NAME ||' 
          , CASE WHEN TRIM(UPPER(NVL(AA.'||ftp.HRMS_COLUMN_NAME ||',''#NULL'')))=TRIM(UPPER(NVL(BB.'||ftp.HRMS_COLUMN_NAME ||',''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_'||ftp.HRMS_COLUMN_NAME||'' STR 
          ,ROWNUM SRNO
        FROM PM_FTP_UPLOAD_COLUMN_MAPPING ftp
        where UPLOAD_ID=pReportType
          AND trim(HRMS_COLUMN_NAME) IS NOT NULL and HRMS_COLUMN_NAME not in ('REMARKS','ACTION','COST_CENTER_CODE','IFSC_CODE')
          );

  IF(pReportType='FT000001') THEN
    vQuery :='SELECT '|| vVARColumn ||' FROM (
                SELECT '|| vTableColumn ||'
                FROM PT_FTP_UPLOAD where UPLOAD_MASTER_ID='||pUploadMasterID||'
                ) AA
                LEFT JOIN
                (SELECT comp.MARSHA_CODE COMP_CODE  
                      ,emp.EMP_MID EMP_CODE
                      ,emp.EMP_FNAME EMP_FNAME
                      ,emp.EMP_MNAME EMP_MNAME
                      ,emp.emp_MID EMP_MID
                      ,emp.EMP_GENDER SEX
                      ,emp.MARITAL_STATUS MARITAL_STATUS
                      ,emp.EMP_NAME EMP_NAME
                      ,dept.DEPT_DESC DEPT_DESC
                      ,dept.DEPT_MID DEPT_MID
                      ,TO_CHAR(emp.LEAVE_DATE ,''MM/DD/yyyy'') LEAVE_DATE
                      ,TO_CHAR(emp.JOIN_DATE ,''MM/DD/yyyy'') JOIN_DATE
                      ,TO_CHAR(emp.COPORATE_JOIN_DATE,''MM/DD/yyyy'')CORP_JOIN_DATE
                      ,TO_CHAR(emp.CHILDRENS) CHILDREN
                      ,emp.IS_HANDICAP HANDICAP
                      ,emp.EMP_LNAME EMP_LNAME
                      ,emp.FATHER_HUSBAND EMP_FATHERNAME
                      , emp.CORRS_MAIL1 CORRESPONDENCE_EMAIL1
                      ,TO_CHAR(emp.BIRTH_DATE,''MM/DD/yyyy'') BIRTH_DATE
                      ,'''' BR_NAME
                      ,emp.IFSC_CODE IFSC_CODE
                      ,cst.COST_CODE COST_CENTER_CODE
                      ,emp.UAN_NO UAN_NO
                      ,'''' BANK_NAME
                      ,emp.EPF_NO EPF_NO
                      ,emp.AADHAR_NO AADHAR_NO
                      ,emp.PAN_NO PAN_NO
                      ,'''' EMP_MGMT_CATE_AID
                      ,desg.DESGN_DESC  DESGN_DESC
                      ,'''' STATE_MID
                      ,'''' COMP_NAME
                      ,loc.LOCATION_DESC LOCATION_DESC
                      ,loc.LOCATION_MID LOCATION_MID
                  FROM GM_EMP emp
                    LEFT JOIN GM_COMP comp
                      ON emp.COMP_ID=COMP.COMP_ID
                    LEFT JOIN GM_DESIGNATIONS desg
                      ON emp.COMP_ID=desg.COMPANY_ID AND emp.DESG_ID = desg.DESGN_ID
                    LEFT JOIN GM_DEPTS dept
                      on emp.COMP_ID=dept.COMP_ID AND emp.DEPT_ID=dept.DEPT_ID
                    LEFT JOIN GM_LOCATIONS loc
                      ON emp.COMP_ID=loc.COMP_ID AND emp.LOC_ID=loc.LOCATION_ID
                    LEFT JOIN GM_GRADE_MSTR grd
                      ON emp.COMP_ID=grd.COMP_AID AND emp.EMP_GRADE=grd.GRADE_AID
                    LEFT JOIN GM_BAND band
                      ON emp.COMP_ID=band.COMP_AID AND emp.BAND_ID=band.BAND_AID
                    LEFT JOIN GM_COST_CENTER cst
                      ON emp.COMP_ID=cst.COMP_CODE AND emp.COSTCNTR_ID=cst.COST_CENTER_ID
                    LEFT JOIN GM_PARAMETERS par
                      ON emp.EMP_TYPE=par.PAR_AID AND PARA_GRP_ID=''PG000159''
                ) bb
                ON TRIM(UPPER(aa.COMP_CODE))=TRIM(UPPER(bb.COMP_CODE)) AND TRIM(UPPER(aa.EMP_CODE))=TRIM(UPPER(bb.EMP_CODE))';
    NULL;
  ELSIF (pReportType='FT000002') THEN
    vQuery:='
            SELECT A.MARSHA_CODE AS FILE_COMP_CODE, B.MARSHA_CODE COMP_CODE,  CASE WHEN TRIM(UPPER(NVL(A.MARSHA_CODE,''#NULL'')))=TRIM(UPPER(NVL(B.MARSHA_CODE,''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_COMP_CODE,
              A.POORNATA_ID AS FILE_POORNATA_ID, B.POORNATA_ID POORNATA_ID,  CASE WHEN TRIM(UPPER(NVL(A.POORNATA_ID,''#NULL'')))=TRIM(UPPER(NVL(B.POORNATA_ID,''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_POORNATA_ID,
              A.EMP_NAME AS FILE_EMP_NAME, B.EMP_NAME EMP_NAME,  CASE WHEN TRIM(UPPER(NVL(A.EMP_NAME,''#NULL'')))=TRIM(UPPER(NVL(B.EMP_NAME,''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_EMP_NAME,
              A.DESIGNATION AS FILE_DESIGNATION, B.DESIGNATION DESIGNATION,  CASE WHEN TRIM(UPPER(NVL(A.DESIGNATION,''#NULL'')))=TRIM(UPPER(NVL(B.DESIGNATION,''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_DESIGNATION,
              A.LOCATION AS FILE_LOCATION, B.LOCATION LOCATION,  CASE WHEN TRIM(UPPER(NVL(A.LOCATION,''#NULL'')))=TRIM(UPPER(NVL(B.LOCATION,''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_LOCATION,
              A.CTC_MID AS FILE_CTC_CODE, B.CTC_MID CTC_CODE,  CASE WHEN TRIM(UPPER(NVL(A.CTC_MID,''#NULL'')))=TRIM(UPPER(NVL(B.CTC_MID,''#NULL''))) THEN  '''' ELSE ''CHANGE'' END AS DIFF_CTC_CODE,
              A.EFFECTIVE_DATE AS FILE_EFFECTIVE_DATE, B.EFFECTIVE_DATE EFFECTIVE_DATE,  
              CASE WHEN NVL(TO_CHAR(TO_DATE(A.EFFECTIVE_DATE,''MM/DD/YYYY''),''DD-MON-YY''),''#NULL'')=NVL(TO_CHAR(TO_DATE(B.EFFECTIVE_DATE,''DD-MON-YY''),''DD-MON-YY''),''#NULL'') THEN  '''' ELSE ''CHANGE'' END AS DIFF_EFFECTIVE_DATE,
              A.AMOUNT AS FILE_AMOUNT, B.AMOUNT AMOUNT,  CASE WHEN NVL(TO_CHAR(A.AMOUNT),''#NULL'')=NVL(TO_CHAR(B.AMOUNT),''#NULL'') THEN  '''' ELSE ''CHANGE'' END AS DIFF_AMOUNT


             FROM   

            (SELECT A.SORT_ORDER,MARSHA_CODE, POORNATA_ID, EMP_NAME, DESIGNATION, LOCATION, EFFECTIVE_DATE,AMOUNT,CTC_NAME CTC_MID,CTC_CODE FROM (
            SELECT SORT_ORDER,MARSHA_CODE,POORNATA_ID,EMP_NAME, DESIGNATION, LOCATION, EFFECTIVE_DATE,  AMOUNT  FROM(
            with t1(MARSHA_CODE,POORNATA_ID, EMP_NAME, DESIGNATION, LOCATION, EFFECTIVE_DATE, AMOUNT) as
            (
            SELECT B.MARSHA_CODE,COLUMN5, COLUMN6, COLUMN7, COLUMN8,COLUMN10, VAR_COLUMN  FROM PT_FTP_UPLOAD A, GM_COMP B WHERE A.COLUMN1=B.MARSHA_CODE AND UPLOAD_MASTER_ID ='||pUploadMasterID||' AND COLUMN5 NOT LIKE ''%POORNATA%''
            ),
            Occurence(ocr) as(
              SELECT LEVEL AS OCR
              FROM(
              SELECT  MAX(REGEXP_COUNT(AMOUNT,''[^,]+'')) MX FROM T1
                  ) CONNECT BY LEVEL <=MX
            )
            SELECT * FROM 
            (
              SELECT MARSHA_CODE,POORNATA_ID,EMP_NAME, DESIGNATION, LOCATION, EFFECTIVE_DATE, REGEXP_SUBSTR(AMOUNT,''[^,]+'',1,O.OCR) AMOUNT,O.OCR SORT_ORDER FROM T1 T
              CROSS JOIN Occurence o

            )
            ) WHERE AMOUNT<>0
            )A,

            (SELECT A.SORT_ORDER,A.CTC_NAME, B.CTC_CODE  FROM (
            with t1( COMP_ID, CTC_NAME) as
            (
            SELECT  COMP_ID,VAR_COLUMN FROM PT_FTP_UPLOAD A, (SELECT COMP_ID, MARSHA_CODE FROM GM_COMP WHERE MARSHA_CODE IS NOT NULL) B 
            WHERE A.COLUMN1=B.MARSHA_CODE AND UPLOAD_MASTER_ID =2 AND ROWNUM<=1
            ),
            Occurence(ocr) as(
              SELECT LEVEL AS OCR
              FROM(
              SELECT  MAX(REGEXP_COUNT(CTC_NAME,''[^,]+'')) MX FROM T1
                  ) CONNECT BY LEVEL <=MX
            )
            SELECT * FROM 
            (
              SELECT  COMP_ID,REGEXP_SUBSTR(CTC_NAME,''[^,]+'',1,O.OCR) CTC_NAME,O.OCR SORT_ORDER FROM T1 T
              CROSS JOIN Occurence o
            )
            ) A, CTC_ALLOWANCE_MAST B
            WHERE A.CTC_NAME=B.CTC_CLIENT_CODE(+) AND A.COMP_ID=B.COMP_ID(+)

            )B

            WHERE A.SORT_ORDER=B.SORT_ORDER AND CTC_CODE IS NOT NULL

            --AND POORNATA_ID=''005710''
            ORDER BY POORNATA_ID, SORT_ORDER) A,

            (SELECT MARSHA_CODE, ATTB_VALUE POORNATA_ID,EMP_NAME,DESG_DESC DESIGNATION, LOC_DESC LOCATION,A.EFF_DATE_FR EFFECTIVE_DATE,
            AMOUNT, CTC_MID,CTC_CODE FROM PY_PM_EMPCTCDTL A, PY_GM_EMPMAST B, GM_COMP C, 
            (SELECT COMP_AID, EMP_AID, ATTB_VALUE FROM PY_GM_EMP_ATTRIBUTE_MAST WHERE ATTB_MID=''Poornata'') D,
            CTC_ALLOWANCE_MAST E
            WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.COMP_AID=C.COMP_ID
            AND A.COMP_AID=D.COMP_AID AND A.EMP_AID=D.EMP_AID
            AND A.COMP_AID=E.COMP_ID AND A.ALLWDED_AID=E.CTC_CODE
            AND MARSHA_CODE IS NOT NULL) B
            WHERE A.MARSHA_CODE=B.MARSHA_CODE(+) AND A.POORNATA_ID=B.POORNATA_ID(+) AND A.DESIGNATION=B.DESIGNATION(+)
            AND   A.LOCATION=B.LOCATION(+) AND A.CTC_CODE=B.CTC_CODE(+)
            ORDER BY COALESCE(A.POORNATA_ID,B.POORNATA_ID),COALESCE(A.CTC_MID,B.CTC_MID)
              ';
  ELSIF (pReportType='EMPMASTER') THEN
    NULL;
  ELSIF (pReportType='EMPMASTER') THEN
    NULL;
  ELSIF (pReportType='EMPMASTER') THEN
    NULL;
  ELSIF (pReportType='FT000006') THEN
    vQuery :='SELECT '|| vVARColumn ||' FROM (
                SELECT '|| vTableColumn ||'
                FROM PT_FTP_UPLOAD where UPLOAD_MASTER_ID='||pUploadMasterID||'
                ) AA
                LEFT JOIN
                (SELECT COMP.COMP_MID COMP_CODE
                      ,emp.EMP_MID EMP_CODE
                      ,TO_CHAR(fnf.QUIT_DATE,''DD/MM/yyyy'') QUIT_DATE
                      ,TO_CHAR(FNF.GRATUITY_ENTITLED) GRATUITY_ENTITLED
                      ,TO_CHAR(FNF.NOTICE_PAY) NOTICE_PAY
                      ,TO_CHAR(FNF.NOTICE_PAY_RECOVERY) NOTICE_PAY_RECOVERY
                      ,TO_CHAR(FNF.ANY_OTHER_PAYMENT) ANY_OTHER_PAYMENT
                      ,TO_CHAR(FNF.ANY_OTHER_RECOVERY) ANY_OTHER_RECOVERY
                      ,FNF.REMARK REMARK
                      FROM PY_PT_FNF_DT fnf
                  LEFT JOIN GM_EMP emp
                    ON fnf.EMP_AID=emp.EMP_ID
                      AND fnf.COMP_AID=emp.COMP_ID
                  LEFT JOIN GM_COMP comp
                    ON emp.COMP_ID=COMP.COMP_ID
                ) bb
                  ON TRIM(UPPER(aa.COMP_CODE))=TRIM(UPPER(bb.COMP_CODE)) AND TRIM(UPPER(aa.EMP_CODE))=TRIM(UPPER(bb.EMP_CODE))';
  END IF;
  vQuery:=REPLACE(vQuery,'&apos;','''');
  DELETE FROM testclOB;
  INSERT INTO testclOB(DT) VALUES(vQuery);
  OPEN Return_RecordSet  FOR vQuery;
  COMMIT;
END GET_SFTP_VARIANCE_REPORT;


    --Fill the uploaded Report
      PROCEDURE EXPORT_UPLOAD_DETAIL_REPORT(pStatus VARCHAR2,pUpload_Aid varchar2, pUploadBatch_Id VARCHAR2,Return_Recordset OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          VARCHAR2(4000 BYTE);
    vUpload_Template          VARCHAR2(4000 BYTE);
    vStrQuery                 LONG;
    BEGIN

        OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE UPLOAD_TEMPLATE
--            LISTAGG(HRMS_COLUMN_NAME,'|') WITHIN GROUP (ORDER BY SORT_ORDER) UPLOAD_TEMPLATE
        FROM GM_FTP_UPLOAD 
          where UPLOAD_ID = (SELECT NVL(MAX(UPLOAD_ID),'') FROM GM_FTP_UPLOAD WHERE HRMS_UPLOAD_AID= pUpload_Aid);
        FETCH curRec INTO vUpl_Report_Temp;
        CLOSE curRec;
        vStrQuery :='SELECT DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS, ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',')||
                      ' FROM HR_TEMP_RAW_UPLOAD WHERE UPLOAD_AID = '''||pUpload_Aid||''' AND UPLOAD_BATCH_ID = '''||pUploadBatch_Id||'''' ;
        IF pStatus != 'TOTAL' THEN
            vStrQuery :=  vStrQuery||' AND DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') = '''||pStatus||'''';
        END IF;


       OPEN Return_Recordset FOR vStrQuery;

       EXCEPTION
            WHEN OTHERS THEN
                NULL;
--                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG('SFTP', 'US000000', 'PY_PK_STANDARD_UPLOADS.GET_UPLOAD_DETAIL_REPORT',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()||vStrQuery);
    END;


PROCEDURE PRO_GET_PACKAGE_NAME(pUploadID varchar2,oMessage OUT varchar2)
AS
  vPackageName varchar2(200);
BEGIN
          select PACKAGE_NAME INTO vPackageName
          FROM GM_FTP_UPLOAD 
          where UPLOAD_ID=pUploadID;

          oMessage:=vPackageName;
END PRO_GET_PACKAGE_NAME;


PROCEDURE GET_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                    pUploadBatch_id  VARCHAR2, Return_Recordset OUT REC)
IS
TYPE refCUR IS REF CURSOR;
curRec                    refCUR;
vUpl_Report_Temp          HR_PM_STANDARD_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
BEGIN

IF PUPLOAD_AID='UP000108' OR PUPLOAD_AID='UP000059' OR PUPLOAD_AID='UP000060' THEN
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

else
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
end if;
   EXCEPTION

        WHEN OTHERS THEN
            HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_SUMMARY',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
END GET_UPLOAD_SUMMARY;



 PROCEDURE SAVE_ACKNOWLEDGE_DETAILS(pFile_Name VARCHAR2, pFile_Status VARCHAR2, pError_log VARCHAR2)
        IS
          vSRNO int;
      BEGIN
       SELECT NVL(MAX(SRNO),0) + 1 INTO vSRNO FROM GM_FTP_ACKNOWLEDGE;
            INSERT INTO GM_FTP_ACKNOWLEDGE (SRNO,FILE_NAME,FILE_STATUS,ERROR_DETAILS,DATE_CR)
                VALUES (vSRNO,pFile_Name,pFile_Status,pError_log, SYSDATE);
            COMMIT;

      EXCEPTION
            WHEN OTHERS THEN
            RETURN;
      END;


PROCEDURE GET_ACKNOWLEDGE_REPORTS(Return_RecordSet OUT REC)
AS
  BEGIN
    OPEN Return_RecordSet FOR
      SELECT FILE_NAME,FILE_STATUS,To_CHAr(DATE_CR,'MM/DD/YYYY HH24:MI:SS')DATE_CR FROM GM_FTP_ACKNOWLEDGE 
              WHERE TO_char(DATE_CR,'DD-MON-YY')=TO_char(SYSDATE,'DD-MON-YY') ;

  END GET_ACKNOWLEDGE_REPORTS;

PROCEDURE GET_ALUMNI_PAYSLIP_COUNT(pUploadMasterID varchar2,pUploadBatchID varchar2,pSessionID varchar2,Return_RecordSet OUT REC)
AS
  vPayslipcount NUMBER;
  vCOMP_AID VARCHAR2(100);
  vEMP_AID  VARCHAR2(100);
  vDbLink   VARCHAR2(500);
  STRSQL    LONG;
  BEGIN

  --saroj
--     SELECT  COUNT(EMP_AID)INTO vPayslipcount  
--     FROM PI_PT_SAL_HD@DBLINK_PIP_ABG_UAT 
--     WHERE COMP_AID = 'CM000004' AND EMP_AID = 'EM000526';
--     
--     OPEN Return_RecordSet FOR
--     SELECT TRIM(UPPER(COL1)) COMP_AID
--                      ,COL2 EMP_AID
--                      ,COL3 CORRESPONDENCE_EMAIL2
--                      ,COL4 LEAVE_DATE
--                      ,vPayslipcount "PAYSLIP COUNT"
--                      ,'PU000001' CR_USER_ID
--                      ,SYSDATE CR_DATE ,
--                      'PU000001' UP_USER_ID 
--                      ,SYSDATE UP_DATE
--                      FROM HR_PT_FINAL_UPLOAD_DATA 
--                      WHERE UPLOAD_BATCH_ID = pUploadBatchID AND UPLOAD_AID = pUploadMasterID AND SESSION_ID = pSessionID;

                OPEN Return_RecordSet FOR
                      SELECT TRIM(UPPER(COL1)) COMP_AID,TRIM(COL2) EMP_AID
                      FROM HR_PT_FINAL_UPLOAD_DATA 
                      WHERE UPLOAD_BATCH_ID = pUploadBatchID 
                      AND UPLOAD_AID =  pUploadMasterID 
                      AND SESSION_ID = pSessionID;
                FETCH Return_RecordSet INTO vCOMP_AID,vEMP_AID; 
                CLOSE Return_RecordSet;


                OPEN Return_RecordSet FOR
                      SELECT UPPER(TRIM(DBLINK_PAY_TO_HRMS))   FROM PY_GM_COMP WHERE COMP_ID=vCOMP_AID;
                FETCH Return_RecordSet INTO vDbLink; 
                CLOSE Return_RecordSet;


--                OPEN Return_RecordSet FOR
--                      SELECT  COUNT(EMP_AID)  
--                      FROM PI_PT_SAL_HD@DBLINK_PIP_ABG_UAT 
--                      WHERE COMP_AID =vCOMP_AID AND EMP_AID = vEMP_AID;
--                FETCH Return_RecordSet INTO vPayslipcount; 
--                CLOSE Return_RecordSet;

--OPEN Return_RecordSet FOR
--SELECT B.EMP_MID "POORNATA ID",D.COMP_MID ||'_'||C.USER_NAME "Username",NULL "COUNT"
--FROM HR_PT_FINAL_UPLOAD_DATA A ,GM_EMP B,PI_GM_USERS@DBLINK_PIP_ABG_UAT C,PI_GM_COMP@DBLINK_PIP_ABG_UAT D
--WHERE A.COL2=B.EMP_ID
--AND A.COL1=B.COMP_ID
--AND A.COL2=C.EMP_ID
--AND A.COL1=C.COMP_AID
--AND B.COMP_ID=D.COMP_ID 
--AND C.GRP_COMP_ID = D.GRP_COMP_ID
--AND C.COMP_AID= D.COMP_ID
--AND UPLOAD_BATCH_ID = pUploadBatchID 
--AND UPLOAD_AID =  pUploadMasterID 
--AND SESSION_ID = pSessionID;

STRSQL:='SELECT B.EMP_MID "POORNATA ID",D.COMP_MID ||''_''||C.USER_NAME "Username",'''||vPayslipcount||''' "COUNT"
          FROM HR_PT_FINAL_UPLOAD_DATA A ,GM_EMP B,PI_GM_USERS@'||vDbLink||' C,PI_GM_COMP@'||vDbLink||' D
          WHERE A.COL2=B.EMP_ID
          AND A.COL1=B.COMP_ID
          AND A.COL2=C.EMP_ID
          AND A.COL1=C.COMP_AID
          AND B.COMP_ID=D.COMP_ID 
          AND C.GRP_COMP_ID = D.GRP_COMP_ID
          AND C.COMP_AID= D.COMP_ID
          AND UPLOAD_BATCH_ID = '''||pUploadBatchID||'''
          AND UPLOAD_AID =  '''||pUploadMasterID||''' 
          AND SESSION_ID ='''||pSessionID||'''';

--DELETE VAI;
--INSERT INTO VAI VALUES(STRSQL);
--COMMIT;
OPEN Return_RecordSet FOR STRSQL;

END GET_ALUMNI_PAYSLIP_COUNT;

PROCEDURE GET_ERROR_LOG_REPORT(pReportType VARCHAR2,pUploadMasterID VARCHAR2,Return_Recordset OUT REC)
AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          GM_FTP_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    vStrQuery                 LONG;

    BEGIN
        OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE 
              FROM GM_FTP_UPLOAD
                WHERE UPLOAD_ID = pReportType;
        FETCH curRec INTO vUpl_Report_Temp;
        CLOSE curRec;

IF PREPORTTYPE  IN ('FT000002','FT000009') THEN
        vStrQuery :='SELECT distinct DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS
                            ,ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',')||'
                            ,FILE_NAME,B.UPLOAD_DATE "FILE UPLOADED",A.UPLOAD_DATE "ERROR LOG DATE" 
                              FROM HR_TEMP_RAW_UPLOAD_NEW A, PM_FTP_UPLOAD B 
                                 WHERE A.SESSION_ID=B.SESSIONID AND A.UPLOAD_BATCH_ID=B.UPLOAD_BATCH_ID AND A.UPLOAD_AID=B.UPLOAD_ID
--                                AND UPLOAD_MASTER_ID='''||pUploadMasterID||'''
                                AND UPLOAD_ID='''||pReportType||''' ';
ELSE 

        vStrQuery :='SELECT distinct DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS
                            ,ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',')||'
                            ,FILE_NAME,B.UPLOAD_DATE "FILE UPLOADED",A.UPLOAD_DATE "ERROR LOG DATE" 
                              FROM HR_TEMP_RAW_UPLOAD A, PM_FTP_UPLOAD B 
                                 WHERE A.SESSION_ID=B.SESSIONID AND A.UPLOAD_BATCH_ID=B.UPLOAD_BATCH_ID AND A.UPLOAD_AID=B.UPLOAD_ID
--                                AND UPLOAD_MASTER_ID='''||pUploadMasterID||'''
                                AND UPLOAD_ID='''||pReportType||''' ';
END IF;

--DELETE SFTP_SG;
--INSERt INTO SFTP_SG VALUES(vStrQuery);
COMMIT;

--        IF pStatus != 'TOTAL' THEN
--            vStrQuery :=  vStrQuery||' AND DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') = '''||pStatus||'''';
--        END IF;

       OPEN Return_Recordset FOR vStrQuery;

       EXCEPTION
            WHEN OTHERS THEN
              NULL;
                --HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pUploadID, pUploadMasterID, 'HR_PK_STANDARD_UPLOADS.GET_ERROR_LOG_REPORT',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END GET_ERROR_LOG_REPORT;

PROCEDURE InsertMail_ErrorLog(pCompId varchar2,pReportID varchar2,pFileName varchar2,pMailBody varchar2,pMAIL_STATUS varchar2,pMAIL_STATUS_MESSAGE varchar2,pMail_ID varchar2, pCURSOR OUT REC)
 IS
  BEGIN

  Insert into PY_MAIL_ERROR_LOG (COMP_AID, REPORT_ID, FILE_NAME, EMP_EMAIL_ID, MAIL_BODY, MAIL_STATUS, MAIL_STATUS_MESSAGE) values
  (pCompId, pReportID, pFileName, pMail_ID, pMailBody, pMAIL_STATUS, pMAIL_STATUS_MESSAGE);
Commit;

          OPEN pCURSOR FOR
          select 'Record Saved Successfully' from dual;
END; 
PROCEDURE GET_MAIL_DETAILS(pCompId varchar2,pFileName varchar2 ,Return_RecordSet OUT REC)
AS
 vStrQuery                 LONG;
  BEGIN
    vStrQuery :='SELECT '''' MAIL_ID ,''Please find attached the error log for the file '||pFileName||') consumed on date'' MAIL_BODY  from dual' ;    
     OPEN Return_Recordset FOR vStrQuery;
END;



END PCK_FTP_UPLOAD;