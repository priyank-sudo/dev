create or replace PACKAGE PY_PK_SFTP_STANDARD_UPLOADS
AS

TYPE REC IS REF CURSOR;

FUNCTION FN_GET_UPLOAD_BATCH_ID (pUpload_Aid VARCHAR2) RETURN VARCHAR2;

PROCEDURE INSERT_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pTrans_Type VARCHAR2,pUploadBatch_Id VARCHAR2);

PROCEDURE COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pUploadBatch_Id VARCHAR2);

PROCEDURE GET_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                    pUploadBatch_id  VARCHAR2, Return_Recordset OUT REC);

PROCEDURE GET_UPLOAD_DETAIL_REPORT(pUpload_Aid VARCHAR2,pStatus VARCHAR2, pUploadBatch_Id VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC);


PROCEDURE PRO_UPLOAD_EMP_MASTER_NEW(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);

PROCEDURE PRO_UPDATE_EMP_MASTER(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  ----add by saroj kumar giri

PROCEDURE PRO_UPLOAD_EMP_CTC(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  ----add by saroj kumar giri

PROCEDURE PRO_UPLOAD_LOAN_DISBURSEMENT(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);

PROCEDURE PROC_UPLOAD_RENT (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);                

PROCEDURE PRO_UPLOAD_EMPLOYEE_VEHICLE (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);

PROCEDURE PRO_UPLOAD_LEAVE_BALANCE (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);

PROCEDURE PRO_MARRIAGE_GIFT_UPLOAD (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC);  

PROCEDURE PRO_EMP_CLEARANCE_UPLOAD (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC); ----add by saroj kumar giri

PROCEDURE PRO_EMP_CLEARANCE_UPLOAD_NEW (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC); ----add by saroj kumar giri


END PY_PK_SFTP_STANDARD_UPLOADS;


/

create or replace PACKAGE BODY PY_PK_SFTP_STANDARD_UPLOADS
AS

vSrNo                     NUMBER(5) DEFAULT 0;
FUNCTION FN_GET_UPLOAD_BATCH_ID (pUpload_Aid VARCHAR2) RETURN VARCHAR2
AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vUploadBatch_Id     HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
BEGIN
    vUploadBatch_Id :=  pUpload_Aid||TO_CHAR(SYSDATE,'DDMMYYYYHHMISS');
    RETURN vUploadBatch_Id;
END FN_GET_UPLOAD_BATCH_ID;

PROCEDURE INSERT_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2 ,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,pTrans_Type VARCHAR2,pUploadBatch_Id VARCHAR2)
AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    BEGIN

        INSERT INTO HR_PM_UPLOAD_STATUS_HD (UPLOAD_BATCH_ID, SESSION_ID, USER_AID, UPLOAD_AID, TRANS_TYPE, UPLOAD_DATE, TOTAL_RECORDS, SUCCESS_RECORDS, FAILED_RECORDS,STATUS)
            SELECT pUploadBatch_Id UPLOAD_BATCH_ID ,pSessionId SESSION_ID, pUSER_AID USER_AID, pUpload_Aid UPLOAD_AID,  pTrans_Type TRANS_TYPE, SYSDATE UPLOAD_DATE,
                COUNT(SESSION_ID) TOTAL_RECORDS, SUM(DECODE(NVL(ERROR_FLAG,'N'),'N',1,0)) SUCCESS_RECORDS, SUM(DECODE(NVL(ERROR_FLAG,'N'),'Y',1,0)) FAILED_RECORDS,'PENDING'
                FROM HR_TEMP_RAW_UPLOAD_NEW
            WHERE UPLOAD_BATCH_ID = pUploadBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid;


    EXCEPTION WHEN OTHERS THEN
--      NULL;
      HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

END INSERT_UPLOAD_SUMMARY;

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

       EXCEPTION WHEN OTHERS THEN
          NULL;
--          HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());

END COMMIT_ROLLBACK_UPLOADED_DATA;

PROCEDURE GET_UPLOAD_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                    pUploadBatch_id  VARCHAR2, Return_Recordset OUT REC)
IS
TYPE refCUR IS REF CURSOR;
curRec                    refCUR;
vUpl_Report_Temp          VARCHAR2(4000 BYTE);
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
          NULL;
--            HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_SUMMARY',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
END GET_UPLOAD_SUMMARY;

PROCEDURE GET_UPLOAD_DETAIL_REPORT(pUpload_Aid VARCHAR2,pStatus VARCHAR2, pUploadBatch_Id VARCHAR2,pGridPageIndex VARCHAR2,pGridPageSize VARCHAR2,Return_FillGrid OUT REC)
    IS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vUpl_Report_Temp          HR_PM_STANDARD_UPLOAD.UPLOADED_REPORT_TEMPLATE%TYPE;
    vStrQuery                 LONG;
    VUploadTemp               HR_PM_STANDARD_UPLOAD.UPLOAD_TEMPLATE%TYPE;  
    vSelect                   LONG;
    vFrom                     LONG;  
    vGridPageCount            NUMBER;   
    vGridp                    NUMBER;  

    BEGIN

        OPEN curRec FOR
            SELECT UPLOADED_REPORT_TEMPLATE,UPLOAD_TEMPLATE FROM GM_FTP_UPLOAD
            WHERE    UPLOAD_ID = pUpload_Aid;
        FETCH curRec INTO vUpl_Report_Temp,VUploadTemp;
        CLOSE curRec;

        vStrQuery :='SELECT ';
        vSelect:='DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') STATUS, ERROR_MSG "ERROR MESSAGES" , '||REPLACE(vUpl_Report_Temp,'|',',');
        vFrom:=' FROM HR_TEMP_RAW_UPLOAD WHERE UPLOAD_AID = '''||pUpload_Aid||''' AND UPLOAD_BATCH_ID = '''||pUploadBatch_Id||'''' ;

        IF pStatus != 'TOTAL' THEN
            vFrom :=  vFrom||' AND DECODE(NVL(ERROR_FLAG,''Y''),''Y'',''FAILED'',''SUCCEEDED'') = '''||pStatus||'''';
        END IF;

        OPEN curRec FOR
            vStrQuery||' COUNT(*) '||vFrom;
        FETCH curRec INTO vGridPageCount;
        CLOSE curRec;


        vStrQuery:='SELECT STATUS, "ERROR MESSAGES",'
                    ||REPLACE(VUploadTemp,'|',',')
                    ||' FROM ('||vStrQuery||'ROWNUM MYROW,'||vSelect||vFrom
                    ||' ) WHERE MYROW BETWEEN '||pGridPageIndex||'*'||pGridPageSize||'+1 AND (1+'||pGridPageIndex||')*'||pGridPageSize||' ORDER BY MYROW';

--        DELETE FROM VAI;
--        INSERT INTO VAI VALUES(vStrQuery);
--        COMMIT;
        OPEN Return_FillGrid FOR vStrQuery;


--        EXCEPTION WHEN OTHERS THEN
--          NULL;
          --HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOADS.GET_UPLOAD_DETAIL_REPORT',SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    END GET_UPLOAD_DETAIL_REPORT;

PROCEDURE PRO_UPLOAD_EMP_MASTER(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;

    vUpldBatch_Id           HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    vCompID                   VARCHAR2(8);
    vCOMP_CODE                VARCHAR2(20);
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vCount                    NUMBER;
    vACTION                   VARCHAR2(200);
    vEMP_MID                  VARCHAR2(200);
    vEMP_LNAME                VARCHAR2(200);
    vEMP_MNAME                VARCHAR2(200);
    vEMP_FNAME                VARCHAR2(200);
    vEMP_NAME                 VARCHAR2(200);
    vSEX                      VARCHAR2(200);
    vBIRTH_DATE               VARCHAR2(200);
    vMARITAL_STATUS           VARCHAR2(200);
    vCORRESPONDENCE_EMAIL1    VARCHAR2(200);
    vEMP_FATHERNAME           VARCHAR2(200);
    vHANDICAP                 VARCHAR2(200);
    vCHILDREN                 VARCHAR2(200);
    vCORP_JOIN_DATE           VARCHAR2(200);
    vJOIN_DATE                VARCHAR2(200);
    vLEAVE_DATE               VARCHAR2(200);
    vCONFIRMATION_DATE        VARCHAR2(200);
    vDESG_MID                 VARCHAR2(200);
    vBR_MID                   VARCHAR2(200);
    vDEPT_MID                 VARCHAR2(200);
    vLOC_MID                  VARCHAR2(200);
    vGRADE_MID                VARCHAR2(200);
    vBAND_MID                 VARCHAR2(200);
    vCOSTCENTER_MID           VARCHAR2(200);
    vBR_AID                   VARCHAR2(200);
    vGRADE_ID                 VARCHAR2(200);
    vBAND_ID                  VARCHAR2(200);
    vCC_ID                    VARCHAR2(200);
    vESIC                     VARCHAR2(200);
    vESIC_NO                  VARCHAR2(200);
    vPAN_NO                   VARCHAR2(200);
    vPF_FLAG                  VARCHAR2(200);
    vPF_NO                    VARCHAR2(200);
    vPF_CAL_TYPE              VARCHAR2(200);
    vBANK_MID                 VARCHAR2(200);
    vBANK_ACC_NO              VARCHAR2(200);
    vREIMB_BANK_MID           VARCHAR2(200);
    vREIMB_ACC_NO             VARCHAR2(200);
    vMGMT_CAT                 VARCHAR2(200);
    vDEPT_CAT                 VARCHAR2(200);
    vSUB_DEPT_MID             VARCHAR2(200);
    vUAN_NO                   VARCHAR2(200);
    vAADHAR_NO                VARCHAR2(200);
    vIFSC_CODE                VARCHAR2(200);
    vACTUAL_QUIT_DATE         VARCHAR2(200);
    vFNF_SETTLEMENT_DATE      VARCHAR2(200);
    vPF_CAL_ID                VARCHAR2(200);
    vBANK_AID                 VARCHAR2(200);
    vREIMB_BANK_AID           VARCHAR2(200);
    vSUB_DEPT_ID              VARCHAR2(200);
    vComp_Id                  VARCHAR2(200);
    vChkRecordCount            NUMBER;
    vCOMP_MID                 VARCHAR2(200);
BEGIN
    vERROR_FLAG:='N';
    IF pOperationType= 'RAW_UPLOAD' THEN
      vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);
      vXmlParser := dbms_xmlparser.newParser;
      dbms_xmlparser.parseClob(vXmlParser,pRawXmlData);
--      dbms_xmlparser.parseClob(vXmlParser,'<DocumentElement>\r\n  <ExcelInfo>\r\n    <COMP_CODE>RENUSTAF</COMP_CODE>\r\n    <ACTION>Add</ACTION>\r\n    <EMP_LNAME>Ingle1</EMP_LNAME>\r\n    <EMP_MNAME>Rajendra Test</EMP_MNAME>\r\n    <EMP_FNAME>Divyank1</EMP_FNAME>\r\n    <EMP_NAME>Mr Divyank1 Ingle1</EMP_NAME>\r\n    <SEX>M</SEX>\r\n    <BIRTH_DATE>10-29-1991</BIRTH_DATE>\r\n    <MARITAL_STATUS>Unknown</MARITAL_STATUS>\r\n    <CORRESPONDENCE_EMAIL1>poornataroute@adityabirla.com</CORRESPONDENCE_EMAIL1>\r\n    <CHILDREN>1</CHILDREN>\r\n  </ExcelInfo>\r\n</DocumentElement>');
--      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

      vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

      FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

          vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
          dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTION/text()',vACTION);

          BEGIN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'COMP_CODE/text()',vCOMP_CODE);
          EXCEPTION WHEN OTHERS THEN
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
            dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',vEMP_MID);
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
              dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_FNAME/text()',vEMP_FNAME);
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
              dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MNAME/text()',vEMP_MNAME);
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
             dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_LNAME/text()',vEMP_LNAME);
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

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_FATHERNAME/text()',vEMP_FATHERNAME);
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
              dbms_xslprocessor.valueOf(vXmlDOMNode,'SEX/text()',vSEX);
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
              dbms_xslprocessor.valueOf(vXmlDOMNode,'CORRESPONDENCE_EMAIL1/text()',vCORRESPONDENCE_EMAIL1);
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
--              dbms_xslprocessor.valueOf(vXmlDOMNode,'CONFIRMATION_DATE/text()',vCONFIRMATION_DATE);
              dbms_xslprocessor.valueOf(vXmlDOMNode,'CORP_JOIN_DATE/text()',vCORP_JOIN_DATE);
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
            dbms_xslprocessor.valueOf(vXmlDOMNode,'HANDICAP/text()',vHANDICAP);
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
           dbms_xslprocessor.valueOf(vXmlDOMNode,'CHILDREN/text()',vCHILDREN);
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
         dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_NAME/text()',vEMP_NAME);
           EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Employee Name should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for  Employee Name  should be date ';
                  END IF;
                  GOTO PRINT_ERROR;
                END;




          BEGIN
          dbms_xslprocessor.valueOf(vXmlDOMNode,'MARITAL_STATUS/text()',vMARITAL_STATUS);
           EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid value for Marital Status should be date';
                    vERROR_FLAG:='Y';
                  ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Marital Status should be date ';
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



 vCONFIRMATION_DATE:= HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vCONFIRMATION_DATE));


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
                 IF vDESG_MID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Branch Code '||vDESG_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;



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

               IF vBR_AID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Branch Code '||vBR_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


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
                IF vLOC_MID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Location Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

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

               IF vGRADE_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Grade Code '||vGRADE_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


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
               IF vBAND_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Band Code '||vBAND_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


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

             IF vCC_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Cost Center Code '||vCOSTCENTER_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;


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

                IF vESIC IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='ESIC Flag should not be blank';
                   GOTO PRINT_ERROR;
               END IF;


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

                IF NVL(TRIM(upper(vPF_FLAG)),'X') NOT IN ('Y','N') AND NOT (pTrans_Type ='UPDATE' AND TRIM(UPPER(vPF_FLAG))='#NULL') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid PF Flag.It Should be Y or N!';
                    GOTO PRINT_ERROR;
               END IF;


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

                      IF vPF_CAL_ID IS NULL THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='PF Calculation Type '||vPF_CAL_TYPE||' does not exist';
                            GOTO PRINT_ERROR;
                       END IF;

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
                IF vBANK_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=' Bank Code '||vBANK_MID||' does not exist';
                        GOTO PRINT_ERROR;
                 END IF;


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

              IF vREIMB_BANK_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:=' Reimbursement Bank Code '||vREIMB_BANK_MID||' does not exist';
                        GOTO PRINT_ERROR;
                   END IF;

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

                IF vREIMB_ACC_NO  IS NULL THEN
                                vERROR_FLAG:='Y';
                                vERROR_MSG:=' Reimbursement Account No. should not be blank';
                                GOTO PRINT_ERROR;
                                END IF;

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

                 IF NVL(LENGTH(TRIM(NVL(vMGMT_CAT,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Management Category should not be blank';
                   GOTO PRINT_ERROR;
               END IF;

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

              IF NVL(LENGTH(TRIM(NVL(vDEPT_CAT,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Department Category should not be blank';
                   GOTO PRINT_ERROR;
               END IF;  

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

                IF NVL(LENGTH(TRIM(NVL(vSUB_DEPT_MID,' '))),0)=0 THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='Sub Department Code should not be blank';
                   GOTO PRINT_ERROR;
               END IF;
               IF(vSUB_DEPT_MID IS NOT NULL)  THEN

               vSUB_DEPT_ID:= CASE WHEN TRIM(UPPER(vSUB_DEPT_MID))='#NULL' THEN '#NULL'
                                ELSE HR_PK_VALIDATION.FN_GET_SUB_DEPT_AID(vComp_Id,vSUB_DEPT_MID) END;

               IF vSUB_DEPT_ID IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Sub Department Code '||vSUB_DEPT_MID||' does not exist';
                    GOTO PRINT_ERROR;
               END IF;

               END IF;

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
              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vUAN_NO),'~!@$%^&*()+=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid UAN Number special character found!';
                         GOTO PRINT_ERROR;
              END IF;

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


             IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vAADHAR_NO),'~!@$%^&*()+=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid Aadhar Number special character found!';
                         GOTO PRINT_ERROR;
              END IF;



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


                  IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vIFSC_CODE),'~!@$%^&*()+=.,''') > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Invalid IFSC Code special character found!';
                         GOTO PRINT_ERROR;
              END IF;

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


 vACTUAL_QUIT_DATE:=HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vACTUAL_QUIT_DATE));

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

  vFNF_SETTLEMENT_DATE:=HR_PK_VALIDATION.FN_CAST_DATE(TRIM(vFNF_SETTLEMENT_DATE));


          vCOMP_CODE:='RENUSTAF';
          IF TRIM(vCOMP_CODE) IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:=' PAYROLL CODE SHOULD NOT BE BLANK';
               GOTO PRINT_ERROR;
          END IF;

          IF vEMP_MID IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='Employee Code should not be blank';
               GOTO PRINT_ERROR;
          END IF;

          IF NVL(LENGTH(TRIM(NVL(vJOIN_DATE,' '))),0)=0 THEN
             vERROR_FLAG:='Y';
             vERROR_MSG:='Join Date should not be blank';
             GOTO PRINT_ERROR;
          END IF;

          IF vEMP_FNAME IS NULL THEN
             VERROR_FLAG:='Y';
             vERROR_MSG:='Employee First Name should not be blank';
             GOTO PRINT_ERROR;
          END IF;

         IF vEMP_FATHERNAME IS NULL THEN
             VERROR_FLAG:='Y';
             vERROR_MSG:='Employee Father Name should not be blank';
             GOTO PRINT_ERROR;
         END IF;

         IF vSEX IS NULL THEN
             vERROR_FLAG:='Y';
             vERROR_MSG:='Gender should not be blank';
             GOTO PRINT_ERROR;
         ELSE
          vSEX:=TRIM(UPPER(vSEX));
          vSEX:=CASE WHEN vSEX='FEMALE' THEN 'F' 
                     WHEN vSEX='MALE' THEN 'M'
                     ELSE '' END;
          IF vSEX='' THEN 
            GOTO PRINT_ERROR;
          END IF;
         END IF;



         IF NVL(LENGTH(TRIM(NVL(vBIRTH_DATE,' '))),0)=0 THEN
             vERROR_FLAG:='Y';
             vERROR_MSG:='Birth Date should not be blank';
             GOTO PRINT_ERROR;
         END IF;


          vCompID :=PI_HR_PK_FTP_VALIDATION.FN_GET_COMP_AID(TRIM(vCOMP_CODE));
          IF vCompID IS NULL THEN
              vERROR_FLAG:='Y';
              vERROR_MSG:=' COMPANY CODE '||vCOMP_CODE||' DOES NOT EXIST';
              GOTO PRINT_ERROR;
           END IF;

          vBIRTH_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vBIRTH_DATE));
          vCORP_JOIN_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vCORP_JOIN_DATE));
          vJOIN_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vJOIN_DATE));
          vLEAVE_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vLEAVE_DATE));

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



          IF NVL(vERROR_FLAG,'N')='N' THEN
                INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO
                        ,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10
                        ,COL11,COL12,COL13,COL14,COL15,COL16,COL17)
                VALUES(vUpldBatch_Id,pSessionId,pUser_Aid, pUpload_Aid, SYSDATE , I+2
                        ,vACTION,vCompID,vEMP_MID,vEMP_NAME,vEMP_FNAME,vEMP_MNAME,vEMP_LNAME,vSEX,vBIRTH_DATE,vMARITAL_STATUS
                        ,vCORRESPONDENCE_EMAIL1,vEMP_FATHERNAME,vHANDICAP,vCHILDREN,vCORP_JOIN_DATE,vJOIN_DATE,vLEAVE_DATE);
          END IF;

          <<PRINT_ERROR>>
              INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                    ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                    ,COL11, COL12, COL13,COL14,COL15, COL16, COL17)
              VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, vERROR_FLAG, vERROR_MSG, I+2
                    ,vACTION,vCompID,vEMP_MID,vEMP_NAME,vEMP_FNAME,vEMP_MNAME,vEMP_LNAME,vSEX,vBIRTH_DATE,vMARITAL_STATUS
                    ,vCORRESPONDENCE_EMAIL1,vEMP_FATHERNAME,vHANDICAP,vCHILDREN,vCORP_JOIN_DATE,vJOIN_DATE,vLEAVE_DATE);


      END LOOP; 

      INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

    ELSIF pOperationType= 'COMMIT_UPLOAD' THEN 
      FOR I IN (SELECT TRIM(UPPER(COL1)) ACTION
                      ,COL2 COMP_AID
                      ,COL3 EMP_MID
                      ,COL4 EMP_NAME
                      ,COL5 EMP_FNAME
                      ,COL6 EMP_MNAME
                      ,COL7 EMP_LNAME
                      ,COL8 SEX
                      ,COL9 BIRTH_DATE
                      ,COL10 MARITAL_STATUS
                      ,COL11 CORRESPONDENCE_EMAIL1
                      ,COL12 EMP_FATHERNAME
                      ,COL13 HANDICAP 
                      ,COL14 CHILDREN
                      ,COL15 CORP_JOIN_DATE
                      ,COL16 JOIN_DATE
                      ,COL17 LEAVE_DATE
                      ,pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_VW_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = pUpload_Batch_Id AND UPLOAD_AID = pUpload_Aid
                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
      LOOP
        IF(I.ACTION='ADD') THEN
          Insert into GM_EMP (GR_COMP_ID,COMP_ID,EMP_ID,EMP_MID,EMP_FNAME,EMP_MNAME,EMP_LNAME,FATHER_HUSBAND,EMP_NAME,EMP_GENDER,BIRTH_DATE,COPORATE_JOIN_DATE,JOIN_DATE,LEAVE_DATE,CORRS_MAIL1,CHILDRENS,MARITAL_STATUS,IS_HANDICAP,CR_USER_ID,CR_DATE) values 
                                    ('CG000163',I.COMP_AID,PI_HR_PK_FTP_VALIDATION.FN_GENERATE_AID(I.COMP_AID, 'GM_EMP',1),I.EMP_MID,I.EMP_FNAME,I.EMP_MNAME,I.EMP_LNAME,I.EMP_FATHERNAME,I.EMP_NAME,I.SEX,I.BIRTH_DATE,I.CORP_JOIN_DATE,I.JOIN_DATE,I.LEAVE_DATE,I.CORRESPONDENCE_EMAIL1,I.CHILDREN,I.MARITAL_STATUS,I.HANDICAP,I.UP_USER_ID,SYSDATE);

        ELSIF(I.ACTION='CHANGE')THEN  
          UPDATE GM_EMP 
            SET EMP_MID=I.EMP_MID
               ,EMP_FNAME=I.EMP_FNAME
               ,EMP_MNAME=I.EMP_MNAME
               ,EMP_LNAME=I.EMP_LNAME
               ,FATHER_HUSBAND=I.EMP_FATHERNAME
               ,EMP_NAME=I.EMP_NAME
               ,EMP_GENDER=I.SEX
               ,BIRTH_DATE=I.BIRTH_DATE
               ,COPORATE_JOIN_DATE=I.CORP_JOIN_DATE
               ,JOIN_DATE=I.JOIN_DATE
               ,LEAVE_DATE=I.LEAVE_DATE
               ,CORRS_MAIL1=I.CORRESPONDENCE_EMAIL1
               ,CHILDRENS=I.CHILDREN
               ,MARITAL_STATUS=I.MARITAL_STATUS
               ,IS_HANDICAP=I.HANDICAP
--               ,UP_USER=UP_USER_ID
               ,UP_DATE=UP_DATE
              WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_MID))= UPPER(TRIM(I.EMP_MID));
        END IF;
      END LOOP;
            COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);
    END IF;

    COMMIT;


       OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'SUCCESS:: Data commited successfully' ErrMessage FROM DUAL;

--    EXCEPTION WHEN OTHERS THEN
----      ROLLBACK;
------      HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_GM_EMP' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
--    OPEN Return_Recordset FOR
--      SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

END PRO_UPLOAD_EMP_MASTER;

PROCEDURE PRO_UPLOAD_EMP_MASTER_NEW(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
AS---ENTIRE PROCEDURE CHANGED BY ANISH BHOIL ON 06TH MAR 2019 , REQUESTED BY AZHAR.
    TYPE refCUR IS REF CURSOR;---ENTIRE PROCEDURE CHANGED AGAIN BY ANISH BHOIL ON 11TH FEB 2020 , REQUESTED BY AZHAR FOR 3 IN 1 CONCEPT.
    curRec                    refCUR;
    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;

    vUpldBatch_Id           HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    vCompID                   VARCHAR2(8);
    vCOMP_CODE                VARCHAR2(20);
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vCount                    NUMBER;
    vACTION                   VARCHAR2(200);
    vEMP_MID                  VARCHAR2(200);
    vEMP_LNAME                VARCHAR2(200);
    vEMP_MNAME                VARCHAR2(200);
    vEMP_FNAME                VARCHAR2(200);
    vEMP_NAME                 VARCHAR2(200);
    vSEX                      VARCHAR2(200);
    vBIRTH_DATE               VARCHAR2(200);
    vMARITAL_STATUS           VARCHAR2(200);
    vCORRESPONDENCE_EMAIL1    VARCHAR2(200);
    vEMP_FATHERNAME           VARCHAR2(200);
    vHANDICAP                 VARCHAR2(200);
    vCHILDREN                 VARCHAR2(200);
    vGROUP_JOINING_DATE       VARCHAR2(200);
    vJOIN_DATE                VARCHAR2(200);
    vLEAVE_DATE               VARCHAR2(200);

    vBR_MID                   VARCHAR2(200);
    vDEPT_MID                 VARCHAR2(200);
    vDEPT_DESC                VARCHAR2(200);---ADDED BY ANISH BHOIL ON 21ST FEB 2019, REQUESTED BY AZHAR.
    vSYS_GEN_DEPT_MID         VARCHAR2(200);---ADDED BY ANISH BHOIL ON 26TH FEB 2019, REQUESTED BY AZHAR.
    vDEPT_AID                 VARCHAR2(200);
    vLOC_MID                  VARCHAR2(200);
    vGRADE_MID                VARCHAR2(200);
    vBAND_MID                 VARCHAR2(200);
    vCOSTCENTER_MID           VARCHAR2(200);
    vBR_AID                   VARCHAR2(200);
    vGRADE_ID                 VARCHAR2(200);
    vBAND_ID                  VARCHAR2(200);
    vCC_ID                    VARCHAR2(200);
    vESIC                     VARCHAR2(200);
    vESIC_NO                  VARCHAR2(200);
    vPAN_NO                   VARCHAR2(200);
    vPF_FLAG                  VARCHAR2(200);
    vPF_NO                    VARCHAR2(200);
    vPF_CAL_TYPE              VARCHAR2(200);
    vBANK_MID                 VARCHAR2(200);
    vBANK_ACC_NO              VARCHAR2(200);
    vREIMB_BANK_MID           VARCHAR2(200);
    vREIMB_ACC_NO             VARCHAR2(200);
    vMGMT_CAT                 VARCHAR2(200);
    vDEPT_CAT                 VARCHAR2(200);
    vSUB_DEPT_MID             VARCHAR2(200);
    vUAN_NO                   VARCHAR2(200);
    vAADHAR_NO                VARCHAR2(200);
    vIFSC_CODE                VARCHAR2(200);
    vACTUAL_QUIT_DATE         VARCHAR2(200);
    vFNF_SETTLEMENT_DATE      VARCHAR2(200);
    vPF_CAL_ID                VARCHAR2(200);
    vBANK_AID                 VARCHAR2(200);
    vREIMB_BANK_AID           VARCHAR2(200);
    vSUB_DEPT_ID              VARCHAR2(200);
--    vComp_Id                  VARCHAR2(200);
    vChkRecordCount            NUMBER;
    vCOMP_MID                 VARCHAR2(200);
    vLOCATION_MID             VARCHAR2(200);
    vSTATE_MID                VARCHAR2(200);
    vDESGN_DESC               VARCHAR2(200);
    vDESG_ID                  VARCHAR2(200);
    vDESG_MID                 VARCHAR2(8);  ---ADDED BY ANISH BHOIL ON 21ST FEB 2019, REQUESTED BY AZHAR. 
    vBANK_NAME                VARCHAR2(200);
    vEMPL_CADRE               VARCHAR2(200);
    vEPF_NO                   VARCHAR2(200);
    vEMP_MGMT_CATEGORY        VARCHAR2(200);
    vLOC_AID                  VARCHAR2(200);
    vSTATE_AID                VARCHAR2(200);
    vActiveLocation           VARCHAR2(200);
    vEMP_CODE                 VARCHAR2(200);
    vREMARKS                  VARCHAR2(200);
    vCOMP_NAME                VARCHAR2(200);
    vEMP_ID                   GM_EMP.EMP_ID%TYPE;
    vSR_NO                    NUMBER;

    vEFFECTIVE_DATE           VARCHAR2(20);---ADDED BY ANISH BHOIL ON 4TH JAN 2019 REQUESTED BY AZHAR AND KAMLAKAR. 
    VCOUNT_UPLOADED           number(18);
    VLAST_SUCCESS_FILE_DATE   DATE;
    VCURRENT_FILE_DATE        DATE;
    VLOCATION_DESC            VARCHAR2(30);

    VPAYGROUP                 VARCHAR2(30);---ADDED BY ANISH BHOIL ON 13TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI. 
    PAY_GROUP_NOT_FOUND       EXCEPTION; 
    vTransfer_emp_flag        NUMBER;  
    vOLD_emp_flag             NUMBER;  
    vemp_exist                NUMBER; 
    
    VSCHEMA_TRANS_DBLINK            VARCHAR2(40);---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
    vMaxNumber                      NUMBER(18,2);  
    DBLINK_NOT_TRACED EXCEPTION;
       
    vSAF_NO                VARCHAR2(30);
    vEMPL_CLASS            VARCHAR2(30);
    vPROFIT_CENTER_CODE    VARCHAR2(30);
    vALT_DEPT_CODE         VARCHAR2(30);
    vALTER_EMPLID          VARCHAR2(30);     
    vBU_DESCR              VARCHAR2(30);
    vCLUSTER_CODE          VARCHAR2(30);
    vF1_CODE               VARCHAR2(30);
    vLOCATION_ACOUNT_CODE  VARCHAR2(30);
    vPF_ESTAB_TYPE         VARCHAR2(30);----static as attb mid is not the same.
    vPRAN_NO               VARCHAR2(30);
    vPRODUCT_CODE          VARCHAR2(30);
    vSITE_ID_CODE          VARCHAR2(30);
    vVENDOR_ID_CODE        VARCHAR2(30);


BEGIN

INSERT INTO UPLOAD_EMP_MASTER_TEMP VALUES(pRawXmlData,SYSDATE);
INSERT INTO UPLOAD_EMP_MASTER_TEMP1 VALUES(pOperationType||'@'||pComp_Aid||'@'||pAcc_Year||'@'||pUser_Aid||'@'||pSessionId||'@'||pUpload_Aid||'@'||pTrans_Type||'@'||pUpload_Batch_Id,SYSDATE);
DELETE FROM TBL_RAW_DATA_ORDERWISE;---ADDED BY ANISH BHOIL ON 14TH FEB 2020 AS IT WAS TEMPORARY TABLE, FOR TESTING MADE PERMANENT.NEED TO REPLACE WITH GLOBAL TEMPORARY TABLE POST TESTING.  
delete from int_check;

COMMIT;
    vERROR_FLAG:='N';
--    insert into VAICLOB(ABC, UPLOAD_AID) values(pRawXmlData,pUpload_Aid);
--    COMMIT;
--      vRawXmlData:= REGEXP_REPLACE(pRawXmlData,' xml:space="preserve"',NULL)  ;
--      pRawXmlData:= REGEXP_REPLACE(pRawXmlData,'&amp;','&');
    IF pOperationType= 'RAW_UPLOAD' THEN
      vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);
      vXmlParser := dbms_xmlparser.newParser;
      dbms_xmlparser.parseClob(vXmlParser,pRawXmlData);
--      dbms_xmlparser.parseClob(vXmlParser,'<DocumentElement>\r\n  <ExcelInfo>\r\n    <COMP_CODE>RENUSTAF</COMP_CODE>\r\n    <ACTION>Add</ACTION>\r\n    <EMP_LNAME>Ingle1</EMP_LNAME>\r\n    <EMP_MNAME>Rajendra Test</EMP_MNAME>\r\n    <EMP_FNAME>Divyank1</EMP_FNAME>\r\n    <EMP_NAME>Mr Divyank1 Ingle1</EMP_NAME>\r\n    <SEX>M</SEX>\r\n    <BIRTH_DATE>10-29-1991</BIRTH_DATE>\r\n    <MARITAL_STATUS>Unknown</MARITAL_STATUS>\r\n    <CORRESPONDENCE_EMAIL1>poornataroute@adityabirla.com</CORRESPONDENCE_EMAIL1>\r\n    <CHILDREN>1</CHILDREN>\r\n  </ExcelInfo>\r\n</DocumentElement>');
--      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

      vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

      FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

      vERROR_MSG:=NULL; vERROR_FLAG:=NULL;  vREMARKS:=NULL; vACTION:=NULL; vCOMP_CODE:=NULL; vEMP_CODE:=NULL; vEMP_MID:=NULL;vCOMP_NAME:=null;
      vDEPT_MID:=NULL; vLOCATION_MID:=NULL; vSTATE_MID:=NULL;vEMP_MGMT_CATEGORY:=NULL; VLOCATION_DESC:= NULL;
      vCompID:=NULL; vLOC_AID:=NULL; vActiveLocation:=NULL; vSTATE_AID:=NULL; vSTATE_MID:=NULL; vDEPT_MID:=NULL; vDEPT_AID:=NULL;
      vDESGN_DESC:=NULL; vDESG_ID:=NULL;  vEMPL_CADRE:=NULL; vCOSTCENTER_MID:=NULL; vCC_ID:=NULL; vPAN_NO:=NULL; 
      vAADHAR_NO:=NULL; vEMP_FNAME:=NULL;vEMP_MNAME:=NULL; vEMP_LNAME:=NULL; vEMP_FATHERNAME:=NULL; vSEX:=NULL; 
      vCORRESPONDENCE_EMAIL1:=NULL; vBIRTH_DATE:=NULL; vGROUP_JOINING_DATE:=NULL; vJOIN_DATE:=NULL; vHANDICAP:=NULL; vLEAVE_DATE:= NULL;
      vCHILDREN:=NULL; vEMP_NAME:=NULL; vMARITAL_STATUS:=NULL; vEPF_NO:=NULL; vUAN_NO:=NULL; vBANK_NAME:=NULL; vIFSC_CODE:=NULL; vBANK_AID:=NULL; 
      vEMP_ID:=NULL;VEFFECTIVE_DATE:=null;vPAYGROUP:=NULL;vTransfer_emp_flag:=NULL;vDEPT_DESC:=NULL;vDESG_MID:=NULL;vSYS_GEN_DEPT_MID:=NULL;VSCHEMA_TRANS_DBLINK:=null;
      vSAF_NO:=NULL; vEMPL_CLASS:=NULL; vPROFIT_CENTER_CODE:=NULL; vALT_DEPT_CODE:=NULL; vALTER_EMPLID:=NULL; vBU_DESCR:=NULL; vCLUSTER_CODE:=NULL; 
      vF1_CODE:=NULL; vLOCATION_ACOUNT_CODE:=NULL;vPF_ESTAB_TYPE:=NULL; vPRAN_NO:=NULL; vPRODUCT_CODE:=NULL; vSITE_ID_CODE:=NULL; VVENDOR_ID_CODE:=NULL;
      vOLD_emp_flag:=null;vTransfer_emp_flag:=NULL;

          vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);


          dbms_xslprocessor.valueOf(vXmlDOMNode,'PAYGROUP/text()',vPAYGROUP);---ADDED BY ANISH BHOIL ON 13TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI. 
        
          IF vPAYGROUP='AMET_PG002' THEN 
              
            vPAYGROUP:='AMET_PG001';
                   
          END IF; 
        
         dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE/text()',vEFFECTIVE_DATE);

         -- insert into sftp_test values('!!!  '||vPAYGROUP);

          dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTION/text()',vACTION);
          dbms_xslprocessor.valueOf(vXmlDOMNode,'REMARKS/text()',vREMARKS);
          dbms_xslprocessor.valueOf(vXmlDOMNode,'COMP_NAME/text()',vCOMP_NAME);

             -- insert into sftp_test values('$$$   '||vREMARKS);
--          INSERT INTO VAI VALUES(vREMARKS);
          BEGIN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'COMP_CODE/text()',vCOMP_CODE);
          EXCEPTION WHEN OTHERS THEN
              IF (SQLCODE ='-24331') THEN
                vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                vERROR_FLAG:='Y';
              ELSE
                vERROR_FLAG:='Y';
                vERROR_MSG:='Invalid value for Company Code';
              END IF;
              GOTO PRINT_ERROR_l;
          END;

          BEGIN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_CODE/text()',vEMP_CODE);
          EXCEPTION WHEN OTHERS THEN
              IF (SQLCODE ='-24331') THEN
                vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
                vERROR_FLAG:='Y';
              ELSE
                vERROR_FLAG:='Y';
                vERROR_MSG:='Invalid value for Company Code';
              END IF;
              GOTO PRINT_ERROR_l;
          END;

          vEMP_CODE:=lpad(vEMP_CODE,'6','0');

        -- insert into sftp_test values('@@@@   '||vEMP_CODE);           

          BEGIN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',vEMP_MID);
          EXCEPTION
            WHEN OTHERS THEN
            IF (SQLCODE ='-24331') THEN
              vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
              vERROR_FLAG:='Y';
            ELSE
              vERROR_FLAG:='Y';
              vERROR_MSG:='Invalid value for Employee Code';
            END IF;
            GOTO PRINT_ERROR_l;
          END;

--          IF UPPER(TRIM(vREMARKS))='CHANGE IN JOB INFORMATION' THEN
                               BEGIN
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPT_MID/text()',vDEPT_MID);
                                EXCEPTION
                                  WHEN OTHERS THEN
                                   IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for Department Code (Max limit is 8 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for Department Code';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;

                              BEGIN---ADDED BY ANISH BHOIL ON 21ST FEB 2019,REQUESTED BY AZHAR FOR NEW DEPT ENTRY.
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DEPT_DESC/text()',vDEPT_DESC);
                                EXCEPTION
                                  WHEN OTHERS THEN
                                   IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for Department desc (Max limit is 20 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for Department desc';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;


                                BEGIN
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_MID/text()',vLOCATION_MID);
                                EXCEPTION
                                  WHEN OTHERS THEN
                                   IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for Location Code (Max limit is 8 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for Location Code';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;

                                 BEGIN---ADDED BY ANISH BHOIL ON 24TH JAN 2019 REQUESTED BY AZHAR AND KAMLAKAR. 
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_DESC/text()',VLOCATION_DESC);
                                EXCEPTION
                                  WHEN OTHERS THEN
                                   IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for Location DESC (Max limit is 30 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for Location Code';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;



                           BEGIN
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'STATE_MID/text()',vSTATE_MID);
                                EXCEPTION
                                  WHEN OTHERS THEN
                                   IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for State Code (Max limit is 8 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for State Code';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;




                             BEGIN
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'DESGN_DESC/text()',vDESGN_DESC);
                                EXCEPTION
                                  WHEN OTHERS THEN
                                  IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for Designation Description (Max limit is 100 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for Designation Description';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;


                             BEGIN
                                    dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPL_CADRE/text()',vEMPL_CADRE);--EMP_MGMT_CATEGORY
                                EXCEPTION
                                  WHEN OTHERS THEN
                                  IF (SQLCODE ='-24331') THEN
                                    vERROR_MSG:='Invalid value for Management Category Code (Max limit is 8 character)';
                                    vERROR_FLAG:='Y';
                                  ELSE
                                    vERROR_FLAG:='Y';
                                    vERROR_MSG:='Invalid value for Management Category Code';
                                  END IF;
                                  GOTO PRINT_ERROR_l;
                                END;



--          ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN CHARTFIELD DETAILS' THEN

                                           BEGIN
                                                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COST_CENTER_CODE/text()',vCOSTCENTER_MID);
                                              EXCEPTION
                                                WHEN OTHERS THEN
                                                IF (SQLCODE ='-24331') THEN
                                                  vERROR_MSG:='Invalid value for Cost Center Code (Max limit is 8 character)';
                                                  vERROR_FLAG:='Y';
                                                ELSE
                                                  vERROR_FLAG:='Y';
                                                  vERROR_MSG:='Invalid value for Cost Center Code';
                                                END IF;
                                                GOTO PRINT_ERROR_l;
                                              END;

--          ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN NID DETAILS' THEN

                              BEGIN
                                  dbms_xslprocessor.valueOf(vXmlDOMNode,'PAN_NO/text()',vPAN_NO);
                              EXCEPTION
                                WHEN OTHERS THEN
                                IF (SQLCODE ='-24331') THEN
                                  vERROR_MSG:='Invalid value for PAN No (Max limit is 20 character)';
                                  vERROR_FLAG:='Y';
                                ELSE
                                  vERROR_FLAG:='Y';
                                  vERROR_MSG:='Invalid value for PAN No';
                                END IF;
                                GOTO PRINT_ERROR_l;
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
                                GOTO PRINT_ERROR_l;
                              END;

--          ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN PERSONAL INFORMATION' THEN

                            BEGIN
                                dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_FNAME/text()',vEMP_FNAME);
                            EXCEPTION
                              WHEN OTHERS THEN
                              IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Employee First Name (max limit is 50 character)';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Employee First Name ';
                              END IF;
                              GOTO PRINT_ERROR_l;
                            END;

                            BEGIN
                                dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MNAME/text()',vEMP_MNAME);
                            EXCEPTION
                              WHEN OTHERS THEN
                              IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Employee Middle Name (Max limit is 50 character)';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Employee Middle Name';
                              END IF;
                              GOTO PRINT_ERROR_l;
                            END;

                            BEGIN
                               dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_LNAME/text()',vEMP_LNAME);
                            EXCEPTION
                              WHEN OTHERS THEN
                              IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Employee Last Name (max limit is 50 character)';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Employee Last Name';
                              END IF;
                              GOTO PRINT_ERROR_l;
                            END;

                            BEGIN
                                 dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_FATHERNAME/text()',vEMP_FATHERNAME);
                            EXCEPTION
                              WHEN OTHERS THEN
                              IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Employee Father Name (Max limit is 100 character)';
                                vERROR_FLAG:='Y';
                              ELSE
                                VERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Employee Father Name';
                              END IF;
                              GOTO PRINT_ERROR_l;
                            END;          

                            BEGIN
                                dbms_xslprocessor.valueOf(vXmlDOMNode,'SEX/text()',vSEX);
                            EXCEPTION
                              WHEN OTHERS THEN
                               IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Gender (Max limit is 8 character)';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Gender';
                              END IF;
                              GOTO PRINT_ERROR_l;
                            END;          

                            BEGIN
                                dbms_xslprocessor.valueOf(vXmlDOMNode,'CORRESPONDENCE_EMAIL1/text()',vCORRESPONDENCE_EMAIL1);
                            EXCEPTION
                              WHEN OTHERS THEN
                               IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Official Email Address (Max limit is 100 character)';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Official Email Address ';
                              END IF;
                              GOTO PRINT_ERROR_l;
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
                              GOTO PRINT_ERROR_l;
                            END;

                            BEGIN
                  --              dbms_xslprocessor.valueOf(vXmlDOMNode,'CONFIRMATION_DATE/text()',vCONFIRMATION_DATE);
                                dbms_xslprocessor.valueOf(vXmlDOMNode,'GROUP_JOINING_DATE/text()',vGROUP_JOINING_DATE);
                            EXCEPTION
                              WHEN OTHERS THEN
                               IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for Confirmation Date should be date';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for Confirmation Date should be date ';
                              END IF;
                              GOTO PRINT_ERROR_l;
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
                              GOTO PRINT_ERROR_l;
                            END;

                            BEGIN
                              dbms_xslprocessor.valueOf(vXmlDOMNode,'HANDICAP/text()',vHANDICAP);
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
                              GOTO PRINT_ERROR_l;
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
                            GOTO PRINT_ERROR_l;
                          END;

                          BEGIN
                             dbms_xslprocessor.valueOf(vXmlDOMNode,'CHILDREN/text()',vCHILDREN);
                            EXCEPTION
                              WHEN OTHERS THEN
                              IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid value for No Of Childrens';
                                vERROR_FLAG:='Y';
                              ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid value for No Of Childrens';
                              END IF;
                              GOTO PRINT_ERROR_l;
                            END;


                             BEGIN
                           dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_NAME/text()',vEMP_NAME);
                             EXCEPTION
                                    WHEN OTHERS THEN
                                     IF (SQLCODE ='-24331') THEN
                                      vERROR_MSG:='Invalid value for Employee Name should be date';
                                      vERROR_FLAG:='Y';
                                    ELSE
                                      vERROR_FLAG:='Y';
                                      vERROR_MSG:='Invalid value for  Employee Name  should be date ';
                                    END IF;
                                    GOTO PRINT_ERROR_l;
                                  END;

                            BEGIN
                            dbms_xslprocessor.valueOf(vXmlDOMNode,'MARITAL_STATUS/text()',vMARITAL_STATUS);
                             EXCEPTION
                                    WHEN OTHERS THEN
                                     IF (SQLCODE ='-24331') THEN
                                      vERROR_MSG:='Invalid value for Marital Status should be date';
                                      vERROR_FLAG:='Y';
                                    ELSE
                                      vERROR_FLAG:='Y';
                                      vERROR_MSG:='Invalid value for Marital Status should be date ';
                                    END IF;
                                    GOTO PRINT_ERROR_l;
                                  END;

--          ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN PF DETAILS' THEN
                                    BEGIN
                                      dbms_xslprocessor.valueOf(vXmlDOMNode,'EPF_NO/text()',vEPF_NO);
                                    EXCEPTION
                                    WHEN OTHERS THEN
                                    IF (SQLCODE ='-24331') THEN
                                      vERROR_MSG:='Invalid value for EPF Number (max limit is 50 character)';
                                      vERROR_FLAG:='Y';
                                    ELSE
                                      vERROR_FLAG:='Y';
                                      vERROR_MSG:='Invalid value for EPF Number ';
                                    END IF;
                                    GOTO PRINT_ERROR_l;
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
                                      GOTO PRINT_ERROR_l;
                                    END;


--        ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN BANK ACCOUNTS' OR UPPER(TRIM(vREMARKS)) LIKE '%BANK%'  THEN

                                          BEGIN
                                                dbms_xslprocessor.valueOf(vXmlDOMNode,'BANK_NAME/text()',vBANK_NAME);
                                            EXCEPTION
                                              WHEN OTHERS THEN
                                              IF (SQLCODE ='-24331') THEN
                                                vERROR_MSG:='Invalid value for Bank Name (Max limit is 100 character)';
                                                vERROR_FLAG:='Y';
                                              ELSE
                                                vERROR_FLAG:='Y';
                                                vERROR_MSG:='Invalid value for Bank Name';
                                              END IF;
                                              GOTO PRINT_ERROR_l;
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
                                              GOTO PRINT_ERROR_l;
                                            END;
                                            
                                            
      dbms_xslprocessor.valueOf(vXmlDOMNode,'SAF_NO/text()',vSAF_NO); 
      dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPL_CLASS/text()',vEMPL_CLASS);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'PROFIT_CENTER_CODE/text()',vPROFIT_CENTER_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'ALT_DEPT_CODE/text()',vALT_DEPT_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'ALTER_EMPLID/text()',vALTER_EMPLID);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'BU_DESCR/text()',vBU_DESCR); 
      dbms_xslprocessor.valueOf(vXmlDOMNode,'CLUSTER_CODE/text()',vCLUSTER_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'F1_CODE/text()',vF1_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_ACOUNT_CODE/text()',vLOCATION_ACOUNT_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'PF_ESTAB_TYPE/text()',vPF_ESTAB_TYPE); 
      dbms_xslprocessor.valueOf(vXmlDOMNode,'PRAN_NO/text()',vPRAN_NO); 
      dbms_xslprocessor.valueOf(vXmlDOMNode,'PRODUCT_CODE/text()',vPRODUCT_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'SITE_ID_CODE/text()',vSITE_ID_CODE);   
      dbms_xslprocessor.valueOf(vXmlDOMNode,'VENDOR_ID_CODE/text()',vVENDOR_ID_CODE);   

--insert into  sftp_test values('%%%  '||vERROR_MSG);                  

  --INSERT INTO INT_CHECK VALUES('1');

    IF NVL(vERROR_FLAG,'N')='N' THEN                                       
                ---TABLE ADDED ON 6TH MAR 2019 BY ANISH BHOIL,REQUESTED BY AZHAR, THIS IS FOR MULTIPLE ENRTY TO BRING IN ORDER FOR PAYGROUP.                                     
           INSERT INTO TBL_RAW_DATA_ORDERWISE (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                    ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                    ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
                    ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
                    ,COL25, COL26, COL27, COL28, COL29, COL30, COL31,COL32,
                    COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46)
           VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, NVL(vERROR_FLAG,'N'), vERROR_MSG, I+2
                    ,vACTION,vCOMP_CODE,vEMP_CODE,vEMP_NAME,vEMP_FNAME,vEMP_MNAME,vEMP_LNAME,vSEX,vBIRTH_DATE,vMARITAL_STATUS
                    ,vCORRESPONDENCE_EMAIL1,vEMP_FATHERNAME,vHANDICAP,vCHILDREN,vGROUP_JOINING_DATE,vJOIN_DATE,vLEAVE_DATE
                    ,vDEPT_MID, vLOCATION_MID, vSTATE_MID, vDESGN_DESC,vEMPL_CADRE, vPAN_NO, vCOSTCENTER_MID
                    ,vAADHAR_NO,vEPF_NO,vUAN_NO,vBANK_NAME,vIFSC_CODE,vREMARKS,VEFFECTIVE_DATE,VPAYGROUP,
                    vSAF_NO,vEMPL_CLASS,vPROFIT_CENTER_CODE,vALT_DEPT_CODE,vALTER_EMPLID,vBU_DESCR,vCLUSTER_CODE,
                    vF1_CODE,vLOCATION_ACOUNT_CODE,vPF_ESTAB_TYPE,vPRAN_NO,vPRODUCT_CODE,vSITE_ID_CODE,vVENDOR_ID_CODE
                  );    
                    
                     -- INSERT INTO INT_CHECK VALUES('2');
    END IF;                                                                   

              <<PRINT_ERROR_l>>


        IF vERROR_FLAG='Y' THEN    
        
            -- INSERT INTO INT_CHECK VALUES('3');

              INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                    ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                    ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
                    ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
                    ,COL25, COL26, COL27, COL28, COL29, COL30, COL31, COL32
                    ,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46)
              VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, NVL(vERROR_FLAG,'N'), vERROR_MSG, I+2
                    ,vACTION,vCOMP_CODE,vEMP_CODE,vEMP_NAME,vEMP_FNAME,vEMP_MNAME,vEMP_LNAME,vSEX,vBIRTH_DATE,vMARITAL_STATUS
                    ,vCORRESPONDENCE_EMAIL1,vEMP_FATHERNAME,vHANDICAP,vCHILDREN,vGROUP_JOINING_DATE,vJOIN_DATE,vLEAVE_DATE
                    ,vDEPT_MID, vLOCATION_MID, vSTATE_MID, vDESGN_DESC,vEMPL_CADRE, vPAN_NO, vCOSTCENTER_MID
                    ,vAADHAR_NO,vEPF_NO,vUAN_NO,vBANK_NAME,vIFSC_CODE,vREMARKS,VEFFECTIVE_DATE,VPAYGROUP
                    ,vSAF_NO,vEMPL_CLASS,vPROFIT_CENTER_CODE,vALT_DEPT_CODE,vALTER_EMPLID,vBU_DESCR,vCLUSTER_CODE
                    ,vF1_CODE,vLOCATION_ACOUNT_CODE,vPF_ESTAB_TYPE,vPRAN_NO,vPRODUCT_CODE,vSITE_ID_CODE,vVENDOR_ID_CODE);                                

         END IF;

    END LOOP; 
      ------------------------------------------VALIDATION PART------------------------------------------------------
--                vCompID:=HR_PK_VALIDATION.FN_GET_MASTER_AID('COMPANY_MASTER', vCOMP_NAME);

--    FOR TRDO IN (SELECT UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,ROW_NO
--                    ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
--                    ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
--                    ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
--                    ,COL25, COL26, COL27, COL28, COL29, COL30, COL31, COL32,ROWNUM ROW_NUM
--                    FROM TBL_RAW_DATA_ORDERWISE) LOOP


     FOR TRDO IN (SELECT UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                                  ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                                  ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
                                  ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
                                  ,COL25, COL26, COL27, COL28, COL29, COL30, COL31, COL32
                                  ,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46
                                  ,ORDER_CHECK,ROWNUM ROW_NUM FROM (
                           SELECT UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                                                ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                                                ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
                                                ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
                                                ,COL25, COL26, COL27, COL28, COL29, COL30, COL31, COL32
                                                ,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46
                                                ,'A' ORDER_CHECK
                                                FROM TBL_RAW_DATA_ORDERWISE where UPPER(COL30)='CHANGE IN JOB INFORMATION'
                                UNION ALL  
                           SELECT UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                                                ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                                                ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
                                                ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
                                                ,COL25, COL26, COL27, COL28, COL29, COL30, COL31, COL32
                                                ,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46
                                                ,'B' ORDER_CHECK
                                                FROM TBL_RAW_DATA_ORDERWISE where UPPER(COL30)!='CHANGE IN JOB INFORMATION')
                                                ORDER BY ORDER_CHECK
                   ) LOOP
     
             --  INSERT INTO INT_CHECK VALUES('4');
       
       vUpldBatch_Id:=NULL;           
       vERROR_MSG:=NULL; vERROR_FLAG:=NULL;  vREMARKS:=NULL; vACTION:=NULL; vCOMP_CODE:=NULL; vEMP_CODE:=NULL; vEMP_MID:=NULL;vCOMP_NAME:=null;
      vDEPT_MID:=NULL; vLOCATION_MID:=NULL; vSTATE_MID:=NULL;vEMP_MGMT_CATEGORY:=NULL; VLOCATION_DESC:= NULL;
      vCompID:=NULL; vLOC_AID:=NULL; vActiveLocation:=NULL; vSTATE_AID:=NULL; vSTATE_MID:=NULL; vDEPT_MID:=NULL; vDEPT_AID:=NULL;
      vDESGN_DESC:=NULL; vDESG_ID:=NULL;  vEMPL_CADRE:=NULL; vCOSTCENTER_MID:=NULL; vCC_ID:=NULL; vPAN_NO:=NULL; 
      vAADHAR_NO:=NULL; vEMP_FNAME:=NULL;vEMP_MNAME:=NULL; vEMP_LNAME:=NULL; vEMP_FATHERNAME:=NULL; vSEX:=NULL; 
      vCORRESPONDENCE_EMAIL1:=NULL; vBIRTH_DATE:=NULL; vGROUP_JOINING_DATE:=NULL; vJOIN_DATE:=NULL; vHANDICAP:=NULL; vLEAVE_DATE:= NULL;
      vCHILDREN:=NULL; vEMP_NAME:=NULL; vMARITAL_STATUS:=NULL; vEPF_NO:=NULL; vUAN_NO:=NULL; vBANK_NAME:=NULL; vIFSC_CODE:=NULL; vBANK_AID:=NULL; 
      vEMP_ID:=NULL;VEFFECTIVE_DATE:=null;vPAYGROUP:=NULL;vTransfer_emp_flag:=NULL;vDEPT_DESC:=NULL;vDESG_MID:=NULL;vSYS_GEN_DEPT_MID:=NULL;
      vSAF_NO:=NULL; vEMPL_CLASS:=NULL; vPROFIT_CENTER_CODE:=NULL; vALT_DEPT_CODE:=NULL; vALTER_EMPLID:=NULL; vBU_DESCR:=NULL; vCLUSTER_CODE:=NULL; 
      vF1_CODE:=NULL; vLOCATION_ACOUNT_CODE:=NULL;vPF_ESTAB_TYPE:=NULL; vPRAN_NO:=NULL; vPRODUCT_CODE:=NULL; vSITE_ID_CODE:=NULL; VVENDOR_ID_CODE:=NULL;
      vOLD_emp_flag:=null;vTransfer_emp_flag:=NULL;

      vUpldBatch_Id:=TRDO.UPLOAD_BATCH_ID;vERROR_FLAG:=TRDO.ERROR_FLAG;vERROR_MSG:=TRDO.ERROR_MSG;        
      vACTION:=TRDO.COL1;vCOMP_CODE:=TRDO.COL2;vEMP_CODE:=TRDO.COL3;vEMP_NAME:=TRDO.COL4;vEMP_FNAME:=TRDO.COL5;vEMP_MNAME:=TRDO.COL6;vEMP_LNAME:=TRDO.COL7;vSEX:=TRDO.COL8;vBIRTH_DATE:=TRDO.COL9;vMARITAL_STATUS:=TRDO.COL10;
      vCORRESPONDENCE_EMAIL1:=TRDO.COL11;vEMP_FATHERNAME:=TRDO.COL12;vHANDICAP:=TRDO.COL13;vCHILDREN:=TRDO.COL14;vGROUP_JOINING_DATE:=TRDO.COL15;vJOIN_DATE:=TRDO.COL16;vLEAVE_DATE:=TRDO.COL17;
      vDEPT_MID:=TRDO.COL18;vLOCATION_MID:=TRDO.COL19; vSTATE_MID:=TRDO.COL20; vDESGN_DESC:=TRDO.COL21;vEMPL_CADRE:=TRDO.COL22; vPAN_NO:=TRDO.COL23; vCOSTCENTER_MID:=TRDO.COL24;
      vAADHAR_NO:=TRDO.COL25;vEPF_NO:=TRDO.COL26;vUAN_NO:=TRDO.COL27;vBANK_NAME:=TRDO.COL28;vIFSC_CODE:=TRDO.COL29;vREMARKS:=TRDO.COL30;VEFFECTIVE_DATE:=TRDO.COL31;VPAYGROUP:=TRDO.COL32;    
      vSAF_NO:=TRDO.COL33; vEMPL_CLASS:=TRDO.COL34; vPROFIT_CENTER_CODE:=TRDO.COL35; vALT_DEPT_CODE:=TRDO.COL36; vALTER_EMPLID:=TRDO.COL37; vBU_DESCR:=TRDO.COL38; vCLUSTER_CODE:=TRDO.COL39; 
      vF1_CODE:=TRDO.COL40; vLOCATION_ACOUNT_CODE:=TRDO.COL41;vPF_ESTAB_TYPE:=TRDO.COL42; vPRAN_NO:=TRDO.COL43; vPRODUCT_CODE:=TRDO.COL44; vSITE_ID_CODE:=TRDO.COL45; VVENDOR_ID_CODE:=TRDO.COL46;
 
--
--        IF UPPER(TRIM(vREMARKS))='CHANGE IN JOB INFORMATION' THEN 
--                OPEN CURREC FOR   
--                    select comp_id from gm_comp
--                    where BUSINESS_NATURE_ID=vpaygroup;
--                 FETCH CURREC INTO  vCompID;
--                CLOSE  CURREC; 
--             
--             IF vCompID IS NULL THEN ---ADDED BY ANISH BHOIL ON 13TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI. 
--               VERROR_FLAG:='Y';
--               vERROR_MSG:='Pay group '||vpaygroup||' is not mapped with any of the company';
--                GOTO PRINT_ERROR;
--               --RAISE PAY_GROUP_NOT_FOUND;
--             END IF;   
--                
--        ELSE      
--                OPEN CURREC FOR   
--                    SELECT count(1) FROM GM_EMP --ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
--                    WHERE EMP_MID=vEMP_CODE;
--                    --AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
--                 FETCH CURREC INTO  vemp_exist;
--                CLOSE  CURREC; 
--                
--             IF vemp_exist=0 THEN
--               VERROR_FLAG:='Y';
--               vERROR_MSG:='EMPLOYEE '||vEMP_CODE||' DOES NOT EXIST';
--               GOTO PRINT_ERROR;
--             ELSE
--               OPEN CURREC FOR   
--                    SELECT COMP_ID FROM GM_EMP --ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
--                    WHERE EMP_MID=vEMP_CODE
--                    AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
--                 FETCH CURREC INTO  vCompID;
--               CLOSE  CURREC;    
--                
--               IF vCompID IS NULL THEN--ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
--                 VERROR_FLAG:='Y';
--                 vERROR_MSG:='Employee '||vEMP_CODE||' have resigned';
--                  GOTO PRINT_ERROR;
--                 --RAISE PAY_GROUP_NOT_FOUND;
--               END IF;           
--             END IF;  
--        END IF;
--        

   DELETE FROM EMP_DATA_SET;---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER,TO AVOID UNNECESSARY UNION ALL IN BELOW CODES.  
   
   INSERT INTO EMP_DATA_SET---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER,TO AVOID UNNECESSARY UNION ALL IN BELOW CODES.  
       SELECT  EMP_MID,EMP_ID,join_date,leave_date,B.COMP_MID,B.COMP_ID,BUSINESS_NATURE_ID,'ABGGROUP'
       FROM GM_EMP A,GM_COMP B
       WHERE A.COMP_ID=B.COMP_ID AND EMP_MID=vEMP_CODE
       UNION ALL
       SELECT  EMP_MID,EMP_ID,join_date,leave_date,B.COMP_MID,B.COMP_ID,BUSINESS_NATURE_ID,'DBLINK_ABG_OP_ABGHINDALCO_UAT'
       FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT A,GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT B
       WHERE A.COMP_ID=B.COMP_ID AND EMP_MID=vEMP_CODE
       UNION ALL
       SELECT ATTB_VALUE,EMP_ID,join_date,leave_date,E.COMP_MID,E.COMP_ID,BUSINESS_NATURE_ID,'DBLINK_ABG_OP_BIRLACHEM_UAT' 
       FROM GM_ATTRIBUTE@DBLINK_ABG_OP_BIRLACHEM_UAT A,PM_SUB_ATTRIBUTE@DBLINK_ABG_OP_BIRLACHEM_UAT B,PM_EMP_ATTRIBUTE@DBLINK_ABG_OP_BIRLACHEM_UAT C,
       GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT D,GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT E
       where a.attb_aid=b.attB_aid AND A.COMP_AID=B.COMP_AID
       AND b.attB_aid=C.attB_aid AND B.SUB_ATTB_AID=C.SUB_ATTB_AID AND B.COMP_AID=C.COMP_AID
       AND C.EMP_AID=D.EMP_ID AND D.COMP_ID=E.COMP_ID
       AND a.attb_mid='PID' AND ATTB_VALUE=vEMP_CODE;    
       
      --  INSERT INTO INT_CHECK VALUES('5');

        IF UPPER(TRIM(vREMARKS))='CHANGE IN JOB INFORMATION' THEN 
        
      --   INSERT INTO INT_CHECK VALUES('6');
                OPEN CURREC FOR   
--                    select comp_id from gm_comp---COMMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
--                    where BUSINESS_NATURE_ID=vpaygroup;
                    SELECT COMP_ID,'ABGGROUP' FROM GM_COMP---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                    WHERE BUSINESS_NATURE_ID=VPAYGROUP
                    UNION ALL
                    SELECT COMP_ID,'DBLINK_ABG_OP_ABGHINDALCO_UAT' FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                    WHERE BUSINESS_NATURE_ID=VPAYGROUP
                    UNION ALL
                    SELECT COMP_ID,'DBLINK_ABG_OP_BIRLACHEM_UAT' FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                    WHERE BUSINESS_NATURE_ID=VPAYGROUP;
                 FETCH CURREC INTO  vCompID,VSCHEMA_TRANS_DBLINK;
                CLOSE  CURREC; 

             IF vCompID IS NULL THEN ---ADDED BY ANISH BHOIL ON 13TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI. 
               VERROR_FLAG:='Y';
               vERROR_MSG:='Pay group '||vpaygroup||' is not mapped with any of the company';
                GOTO PRINT_ERROR;
               --RAISE PAY_GROUP_NOT_FOUND;
             END IF;   

        ELSE  

                OPEN CURREC FOR   
--                    SELECT count(1) FROM GM_EMP --ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
--                    WHERE EMP_MID=vEMP_CODE;---COMMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                      SELECT COUNT(1) FROM EMP_DATA_SET
                      WHERE EMP_MID=vEMP_CODE;---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                    ----AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
                 FETCH CURREC INTO  vemp_exist;
                CLOSE  CURREC;   

             IF vemp_exist=0 THEN
               VERROR_FLAG:='Y';
               vERROR_MSG:='EMPLOYEE '||vEMP_CODE||' DOES NOT EXIST';
               GOTO PRINT_ERROR;
             ELSE            

                OPEN CURREC FOR   
                    SELECT col32 FROM TBL_RAW_DATA_ORDERWISE --ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
                    WHERE COL3=vEMP_CODE
                    and upper(COL30)='CHANGE IN JOB INFORMATION';
                    --AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
                 FETCH CURREC INTO  vpaygroup;
                CLOSE  CURREC; 

              IF vpaygroup IS NULL THEN 
                 OPEN CURREC FOR   
--                    SELECT COMP_ID FROM GM_EMP --ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
--                    WHERE EMP_MID=vEMP_CODE--COMMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR. 
--                    AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
                    SELECT COUNT(1) FROM EMP_DATA_SET
                    WHERE EMP_MID=vEMP_CODE---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                    AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
                 FETCH CURREC INTO  vCompID;
               CLOSE  CURREC;    

                  IF vCompID IS NULL THEN 
                       VERROR_FLAG:='Y';
                       vERROR_MSG:='EMPLOYEE '||vEMP_CODE||' NEEDS TO HAVE PAY GROUP';
                    GOTO PRINT_ERROR;              
                  END IF;   
               END IF;            

               OPEN CURREC FOR   
--                    SELECT COMP_ID FROM GM_EMP --ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
--                    WHERE EMP_MID=vEMP_CODE--COMMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.
--                    AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
                      SELECT COMP_AID FROM EMP_DATA_SET
                      WHERE EMP_MID=vEMP_CODE
                      AND (LEAVE_DATE IS NULL OR LEAVE_DATE>=TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY'));
                 FETCH CURREC INTO  vCompID;
               CLOSE  CURREC;    
               
              OPEN CURREC FOR  
               SELECT SCHEMA_DBLINK FROM EMP_DATA_SET;
                FETCH CURREC INTO  VSCHEMA_TRANS_DBLINK;--ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
              CLOSE  CURREC;    
              
    --          INSERT INTO INT_CHECK VALUES('6'||' '||VSCHEMA_TRANS_DBLINK);

               IF vCompID IS NULL THEN--ADDED BY ANISH BHOIL ON 5TH MAR 2019, REQUESTED BY AZHAR AND CLIENT AS THEY WILL PROVIDE PAYGROUP ONLY FOR JOB CHANGE.
                 VERROR_FLAG:='Y';
                 vERROR_MSG:='Employee '||vEMP_CODE||' have resigned';
                  GOTO PRINT_ERROR;
                 --RAISE PAY_GROUP_NOT_FOUND;
               END IF;           
             END IF;  
        END IF;
              --  HR_PK_VALIDATION.PROC_GET_COMP_CODE( vCOMP_NAME, vCompID, vCOMP_CODE);

              OPEN CURREC FOR  ---ADDED BY ANISH BHOIL ON 14TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI. 
--                SELECT COUNT(1)
--                FROM GM_EMP
--                WHERE EMP_MID=vEMP_CODE---COMMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
--                AND COMP_ID !=vCompID
--                AND LEAVE_DATE IS NULL;
                    SELECT COUNT(1)---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                    FROM EMP_DATA_SET
                    WHERE EMP_MID=vEMP_CODE
                    AND COMP_AID !=vCompID
                    AND LEAVE_DATE IS NULL;
                FETCH CURREC INTO  vTransfer_emp_flag;
              CLOSE  CURREC; 

              OPEN CURREC FOR  ---ADDED BY ANISH BHOIL ON 14TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI.    
                    --SELECT count(1) FROM GM_EMP
                    SELECT COUNT(1) FROM EMP_DATA_SET
                    WHERE COMP_AID=VCOMPID
                    AND EMP_MID=VEMP_CODE;
                FETCH CURREC INTO  vOLD_emp_flag;
              CLOSE  CURREC;  

              vOLD_emp_flag:=nvl(vOLD_emp_flag,0);

              vTransfer_emp_flag:=NVL(vTransfer_emp_flag,0);

--                 INSERT INTO SFTP_TEST VALUES(vEMP_CODE||' ^^^ '||vJOIN_DATE); 
--                 COMMIT;

                IF vEMP_CODE IS NOT NULL AND vOLD_emp_flag!=0 THEN
                        --vEMP_ID:=HR_PK_VALIDATION.FN_GET_EMP_AID (vCompID, vEMP_CODE);
                          
                        IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN                            
                            OPEN curRec FOR
                                SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT---QUERY TAKEN OUT FROM ABOVE FUNCTION TO AVOID CHANGES IN FUNCTION BY ANISH BHOIL ON 12TH FEB 2020.
                                    WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCompID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_CODE));
                            FETCH curRec INTO vEMP_ID;
                            CLOSE  curRec;  
                        ELSIF  VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN 
                            OPEN curRec FOR
                                SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT---QUERY TAKEN OUT FROM ABOVE FUNCTION TO AVOID CHANGES IN FUNCTION BY ANISH BHOIL ON 12TH FEB 2020.
                                    WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCompID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_CODE));
                            FETCH curRec INTO vEMP_ID;
                            CLOSE  curRec;    
                        ELSE    
                            OPEN curRec FOR
                                SELECT EMP_ID FROM GM_EMP---QUERY TAKEN OUT FROM ABOVE FUNCTION TO AVOID CHANGES IN FUNCTION BY ANISH BHOIL ON 12TH FEB 2020.
                                    WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(vCompID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_CODE));
                            FETCH curRec INTO vEMP_ID;
                            CLOSE  curRec;                         
                        END IF; 
--                ELSE
--                        vEMP_ID:=HR_PK_VALIDATION.FN_GET_POORNATA_EMP_AID(vCompID, vEMP_CODE);
                END IF;

              IF vEMP_CODE IS NOT NULL AND vOLD_emp_flag=0 AND vTransfer_emp_flag>0 THEN

                --vEMP_ID:=PI_HR_PK_FTP_VALIDATION.FN_GENERATE_AID(vCompID, 'GM_EMP',1);--ADDED BY ANISH BHOIL ON 18TH FEB 2019, REQUESTED BY AZHAR AS PER CLIENT REQUIREMENT.
                    
                  IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN       
                    OPEN curRec FOR---QUERY TAKEN OUT FROM ABOVE FUNCTION TO AVOID CHANGES IN FUNCTION BY ANISH BHOIL ON 12TH FEB 2020.
                      SELECT TO_NUMBER(MAX(SUBSTR(EMP_ID,3))) EMP_AID FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT;
                     FETCH curRec INTO vMaxNumber;
                     
                      vEMP_ID := 'EM'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                    CLOSE curRec;     
                  ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN
                    OPEN curRec FOR---QUERY TAKEN OUT FROM ABOVE FUNCTION TO AVOID CHANGES IN FUNCTION BY ANISH BHOIL ON 12TH FEB 2020.
                      SELECT TO_NUMBER(MAX(SUBSTR(EMP_ID,3))) EMP_AID FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT;
                     FETCH curRec INTO vMaxNumber;
                     
                      vEMP_ID := 'EM'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                    CLOSE curRec;    
                  ELSE  
                    OPEN curRec FOR---QUERY TAKEN OUT FROM ABOVE FUNCTION TO AVOID CHANGES IN FUNCTION BY ANISH BHOIL ON 12TH FEB 2020.
                      SELECT TO_NUMBER(MAX(SUBSTR(EMP_ID,3))) EMP_AID FROM GM_EMP;
                     FETCH curRec INTO vMaxNumber;
                     
                      vEMP_ID := 'EM'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                    CLOSE curRec;     
                  END IF;                      
              --TRDO.ROW_NUM
              END IF;   
              
              
                   IF VSCHEMA_TRANS_DBLINK IS NULL  THEN 
                       VERROR_FLAG:='Y';
                       vERROR_MSG:=' Unable to find group company for employee '||vEMP_CODE;
                      GOTO PRINT_ERROR;
                   END IF;   
                   
                    IF vEMP_ID is null THEN 
                       VERROR_FLAG:='Y';
                       vERROR_MSG:='Employee '||vEMP_CODE||' have come for change request but no data present in system';
                      GOTO PRINT_ERROR;
                   END IF;  


               OPEN CURREC FOR  
                SELECT COUNT(COLUMN4)---ADDED BY ANISH BHOIL ON 4TH JAN 2019 REQUESTED BY AZHAR AND KAMLAKAR. 
                FROM  PT_FTP_UPLOAD
                WHERE COLUMN3=vEMP_CODE AND TO_DATE(COLUMN4,'MM-DD-YY')>TO_DATE(VEFFECTIVE_DATE,'MM-DD-YY')
                 AND upload_master_id in (select distinct UPLOAD_MASTER_ID from Pm_FTP_UPLOAD where UPLOAD_ID='FT000001');
               FETCH CURREC INTO  VCOUNT_UPLOADED;
              CLOSE  CURREC;

--             OPEN CURREC FOR 
--              SELECT MAX(UPLOAD_DATE) 
--              FROM HR_TEMP_RAW_UPLOAD
--              WHERE UPLOAD_AID='FT000001'
--              AND ERROR_FLAG='N' AND COL3=vEMP_CODE;
--            FETCH CURREC INTO  VLAST_SUCCESS_FILE_DATE;
--            CLOSE  CURREC;

            OPEN CURREC FOR ---ADDED BY ANISH BHOIL ON 4TH JAN 2019 REQUESTED BY AZHAR AND KAMLAKAR. 
                select TO_DATE(SUBSTR(FILE_NAME,24,8),'MM-DD-YY') 
                from Pm_FTP_UPLOAD a,Pt_FTP_UPLOAD b,HR_TEMP_RAW_UPLOAD C
                where a.UPLOAD_MASTER_ID=b.UPLOAD_MASTER_ID
                AND A.UPLOAD_BATCH_ID=C.UPLOAD_BATCH_ID
                --AND B.COLUMN3=C.COLUMN3
                and b.COLUMN3=vEMP_CODE
                and UPLOAD_ID='FT000001'
                AND ERROR_FLAG='N'
                AND A.UPLOAD_ID=C.UPLOAD_AID
                AND A.UPLOAD_MASTER_ID=(SELECT MAX(A.UPLOAD_MASTER_ID) 
                FROM  Pm_FTP_UPLOAD a,Pt_FTP_UPLOAD b,HR_TEMP_RAW_UPLOAD C
                where a.UPLOAD_MASTER_ID=b.UPLOAD_MASTER_ID
                AND A.UPLOAD_BATCH_ID=C.UPLOAD_BATCH_ID
                --AND B.COLUMN3=C.COLUMN3
                and b.COLUMN3=vEMP_CODE
                and UPLOAD_ID='FT000001'
                AND ERROR_FLAG='N'
                AND A.UPLOAD_ID=C.UPLOAD_AID);
--                select TO_DATE(SUBSTR(FILE_NAME,24,8),'MM-DD-YY')
--                from Pm_FTP_UPLOAD
--                where upload_id='FT000001'
--                AND UPLOAD_DATE =(select MAX(UPLOAD_DATE)
--                from hr_temp_raw_upload
--                where error_flag='N'
--                AND COL3=vEMP_CODE);
             FETCH CURREC INTO  VLAST_SUCCESS_FILE_DATE;
            CLOSE  CURREC;

              OPEN CURREC FOR ---ADDED BY ANISH BHOIL ON 4TH JAN 2019 REQUESTED BY AZHAR AND KAMLAKAR. 
               select TO_DATE(SUBSTR(FILE_NAME,24,8),'MM-DD-YY') 
                from Pm_FTP_UPLOAD a
                where UPLOAD_ID='FT000001' AND UPLOAD_MASTER_ID=(SELECT MAX(UPLOAD_MASTER_ID) from Pm_FTP_UPLOAD a
                where UPLOAD_ID='FT000001');
--                select TO_DATE(SUBSTR(FILE_NAME,24,8),'MM-DD-YY')
--                from Pm_FTP_UPLOAD
--                where upload_id='FT000001'
--                AND UPLOAD_DATE =(select MAX(UPLOAD_DATE)
--                from hr_temp_raw_upload
--                WHERE COL3=vEMP_CODE);
             FETCH CURREC INTO  VCURRENT_FILE_DATE;
            CLOSE  CURREC;

                VCOUNT_UPLOADED:=nvl(VCOUNT_UPLOADED,0);

--                delete from vai;
--                insert into vai values(vEMP_CODE||' '||VEFFECTIVE_DATE ||'.m. '||VCURRENT_FILE_DATE||' .a. '||VCOUNT_UPLOADED||'  .b. '||VLAST_SUCCESS_FILE_DATE);
--                commit;

                ---ADDED BY ANISH BHOIL ON 4TH JAN 2019 REQUESTED BY AZHAR AND KAMLAKAR. 
                IF VCOUNT_UPLOADED!=0 AND TO_DATE(VCURRENT_FILE_DATE)<TO_DATE(VLAST_SUCCESS_FILE_DATE) THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Cannot upload backdated file for employee '|| vEMP_CODE;                
                END IF;

              IF  UPPER(vACTION) IN ('CHANGE') AND  vOLD_emp_flag!=0 THEN   
                IF UPPER(TRIM(vREMARKS))<>'CHANGE IN PERSONAL INFORMATION' THEN
                    IF vEMP_ID IS NULL THEN
                       vERROR_FLAG:='Y';--COMMENTED BY ANISH BHOIL ON 18TH FEB 2019, REQUESTED BY AZHAR AS PER CLIENT REQUIREMENT.
                       vERROR_MSG:='Employee code '||NVL(vEMP_CODE,vEMP_CODE)||' does not exist';
                       GOTO PRINT_ERROR;
                    END IF;
                END IF;
              END IF;  


            IF vSTATE_MID IS NOT NULL THEN
                   -- vSTATE_AID:=HR_PK_VALIDATION.FN_GET_STATE_CODE(vSTATE_MID);
                   
               IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN    ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                   
                   OPEN curRec FOR
                      SELECT STATE_CODE FROM GM_STATE@DBLINK_ABG_OP_BIRLACHEM_UAT
                          WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID));
                  FETCH curRec INTO vSTATE_AID;
                  CLOSE  curRec;
               ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN  
                  OPEN curRec FOR
                      SELECT STATE_CODE FROM GM_STATE@DBLINK_ABG_OP_ABGHINDALCO_UAT
                          WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID));
                  FETCH curRec INTO vSTATE_AID;
                  CLOSE  curRec;
               ELSE   
                  OPEN curRec FOR
                      SELECT STATE_CODE FROM GM_STATE
                          WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID));
                  FETCH curRec INTO vSTATE_AID;
                  CLOSE  curRec;
                
               END IF;                
                   
            END IF; 


            IF UPPER(TRIM(vREMARKS))='CHANGE IN JOB INFORMATION' THEN
                IF vSTATE_MID IS NOT NULL THEN
                       -- vSTATE_AID:=HR_PK_VALIDATION.FN_GET_STATE_CODE(vSTATE_MID);
               IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN    ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                   
                   OPEN curRec FOR
                      SELECT STATE_CODE FROM GM_STATE@DBLINK_ABG_OP_BIRLACHEM_UAT
                          WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID));
                  FETCH curRec INTO vSTATE_AID;
                  CLOSE  curRec;
               ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN  
                  OPEN curRec FOR
                      SELECT STATE_CODE FROM GM_STATE@DBLINK_ABG_OP_ABGHINDALCO_UAT
                          WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID));
                  FETCH curRec INTO vSTATE_AID;
                  CLOSE  curRec;
               ELSE   
                  OPEN curRec FOR
                      SELECT STATE_CODE FROM GM_STATE
                          WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(vSTATE_MID));
                  FETCH curRec INTO vSTATE_AID;
                  CLOSE  curRec;
                
               END IF;                    
                       
                END IF; 

                IF vSTATE_AID IS NULL THEN
                   vERROR_FLAG:='Y';
                   vERROR_MSG:='State code '||vSTATE_MID||' does not exist';
                   GOTO PRINT_ERROR;
                END IF;
            END IF;        

                IF UPPER(TRIM(vREMARKS))='CHANGE IN JOB INFORMATION' THEN
                             IF  UPPER(vACTION) IN ('ADD','CHANGE') THEN  
                                    IF vLOCATION_MID IS NOT NULL  THEN
                                        --vLOC_AID:=HR_PK_VALIDATION.FN_GET_LOCATION_ID(vCompID,vLOCATION_MID);
                                       IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN   ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                          OPEN curRec FOR
                                              SELECT LOCATION_ID FROM GM_LOCATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                  WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(vCompID));
                                          FETCH curRec INTO vLOC_AID;
                                          CLOSE  curRec;
                                       ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
                                           OPEN curRec FOR
                                              SELECT LOCATION_ID FROM GM_LOCATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                  WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(vCompID));
                                          FETCH curRec INTO vLOC_AID;
                                          CLOSE  curRec;
                                       ELSE   
                                           OPEN curRec FOR
                                              SELECT LOCATION_ID FROM GM_LOCATIONS
                                                  WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(vCompID));
                                          FETCH curRec INTO vLOC_AID;
                                          CLOSE  curRec;
                                       
                                       END IF;
                                        
                                        IF vLOC_AID IS NULL THEN
                                             --vLOC_AID:=HR_PK_VALIDATION.FN_GENERATE_AID(vCompID, 'GM_LOCATIONS',1);    ---ADDED BY ANISH BHOIL ON 18TH FEB 2019 REQUESTED BY AZHAR.
                                            vMaxNumber:=0;
                                             IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN     
                                                OPEN curRec FOR---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                                    SELECT TO_NUMBER(MAX(SUBSTR(LOCATION_ID,3))) LOCATION_ID FROM GM_LOCATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                    WHERE COMP_ID = vCompID;
                                                FETCH curRec INTO vMaxNumber;
                                                CLOSE curRec;
                                             ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
                                                OPEN curRec FOR
                                                    SELECT TO_NUMBER(MAX(SUBSTR(LOCATION_ID,3))) LOCATION_ID FROM GM_LOCATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                    WHERE COMP_ID = vCompID;
                                                FETCH curRec INTO vMaxNumber;
                                                CLOSE curRec;
                                             ELSE   
                                                OPEN curRec FOR
                                                    SELECT TO_NUMBER(MAX(SUBSTR(LOCATION_ID,3))) LOCATION_ID FROM GM_LOCATIONS
                                                    WHERE COMP_ID = vCompID;
                                                FETCH curRec INTO vMaxNumber;
                                                CLOSE curRec;
                                             END IF; 
                                       
                                       vLOC_AID := 'LC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));


----Added AND COMMENTED BY ANISH BHOIL ON 20TH FEB 2019, REQUESTED BY AZHAR.
         
        IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN    
          INSERT INTO GM_LOCATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT(GR_COMP_ID, COMP_ID, LOCATION_ID, LOCATION_MID, LOCATION_DESC, LOCATION_SUB_DESC, REMARKS, 
                         CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, OLP_ID, ADMINISTRATOR,CITY_CODE, 
                         REGION_ID, SCHEDULAR_MANAGER, ACTIVE_FLG, OFFICE_ADD, STATE_AID, HRA_RATE, HOUSE_PERQ, SELF_ATTENDANCE,ESIC_APPLICABLE) 
          VALUES('CG000163',vCompID,vLOC_AID,vLOCATION_MID,VLOCATION_DESC,NULL,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                         pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N',NULL,NULL,NULL,
                         NULL,NULL,'1',NULL,vSTATE_AID,'0.4',NULL,NULL,'N');
        ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
          INSERT INTO GM_LOCATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT(GR_COMP_ID, COMP_ID, LOCATION_ID, LOCATION_MID, LOCATION_DESC, LOCATION_SUB_DESC, REMARKS, 
                         CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, OLP_ID, ADMINISTRATOR,CITY_CODE, 
                         REGION_ID, SCHEDULAR_MANAGER, ACTIVE_FLG, OFFICE_ADD, STATE_AID, HRA_RATE, HOUSE_PERQ, SELF_ATTENDANCE,ESIC_APPLICABLE) 
          VALUES('CG000184',vCompID,vLOC_AID,vLOCATION_MID,VLOCATION_DESC,NULL,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                         pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N',NULL,NULL,NULL,
                         NULL,NULL,'1',NULL,vSTATE_AID,'0.4',NULL,NULL,'N');
        ELSE                 
          INSERT INTO GM_LOCATIONS(GR_COMP_ID, COMP_ID, LOCATION_ID, LOCATION_MID, LOCATION_DESC, LOCATION_SUB_DESC, REMARKS, 
                         CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, OLP_ID, ADMINISTRATOR,CITY_CODE, 
                         REGION_ID, SCHEDULAR_MANAGER, ACTIVE_FLG, OFFICE_ADD, STATE_AID, HRA_RATE, HOUSE_PERQ, SELF_ATTENDANCE,ESIC_APPLICABLE) 
          VALUES('CG000185',vCompID,vLOC_AID,vLOCATION_MID,VLOCATION_DESC,NULL,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                         pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N',NULL,NULL,NULL,
                         NULL,NULL,'1',NULL,vSTATE_AID,'0.4',NULL,NULL,'N');               
           
        END IF;
--     vERROR_FLAG:='Y';
--                                           vERROR_MSG:='Location code '||vLOCATION_MID||' does not exist';
--                                           GOTO PRINT_ERROR;
                                        END IF;
                                        --vActiveLocation:=HR_PK_VALIDATION.FN_GET_ACTIVE_LOCATION_ID(vCompID,vLOCATION_MID);
                                           IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                              OPEN curRec FOR
                                                  SELECT LOCATION_ID FROM GM_LOCATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                      WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(vCompID)) AND ACTIVE_FLG='1';
                                              FETCH curRec INTO vActiveLocation;
                                              CLOSE  curRec;
                                            ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN  
                                              OPEN curRec FOR
                                                  SELECT LOCATION_ID FROM GM_LOCATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                      WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(vCompID)) AND ACTIVE_FLG='1';
                                              FETCH curRec INTO vActiveLocation;
                                              CLOSE  curRec;
                                            ELSE  
                                              OPEN curRec FOR
                                                  SELECT LOCATION_ID FROM GM_LOCATIONS
                                                      WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(vLOCATION_MID)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(vCompID)) AND ACTIVE_FLG='1';
                                              FETCH curRec INTO vActiveLocation;
                                              CLOSE  curRec;
                                           END IF;
                                        
                                        IF vActiveLocation IS NULL THEN 
                                           vERROR_FLAG:='Y';
                                           vERROR_MSG:='Location code '||vLOCATION_MID||' is inactive';
                                           GOTO PRINT_ERROR;
                                        END IF;
                                    END IF;
                       
                     INSERT INTO INT_CHECK VALUES('7---  '||vDEPT_MID||' '||vCompID||' '||vEMP_CODE||' '||VPAYGROUP||' '||VSCHEMA_TRANS_DBLINK);
                     --COMMIT;

                                    IF vDEPT_MID IS NOT NULL THEN
                                              --vDEPT_AID:=HR_PK_VALIDATION.FN_GET_DEPT_AID(vCompID,vDEPT_MID);  
                                       IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN
                                          OPEN CURREC FOR ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                              SELECT DEPT_ID 
                                              FROM GM_DEPTS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                              WHERE COMP_ID=vCompID AND DEPRTMENT_HEAD=vDEPT_MID;
                                             FETCH CURREC INTO  vDEPT_AID;
                                          CLOSE  CURREC;
                                       ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
                                          OPEN CURREC FOR 
                                              SELECT DEPT_ID 
                                              FROM GM_DEPTS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                              WHERE COMP_ID=vCompID AND DEPRTMENT_HEAD=vDEPT_MID;
                                             FETCH CURREC INTO  vDEPT_AID;
                                          CLOSE  CURREC;
                                       ELSE   
                                          OPEN CURREC FOR 
                                              SELECT DEPT_ID 
                                              FROM GM_DEPTS
                                              WHERE COMP_ID=vCompID AND DEPRTMENT_HEAD=vDEPT_MID;
                                             FETCH CURREC INTO  vDEPT_AID;
                                          CLOSE  CURREC;
                                       END IF;  
                                    END IF;


                              IF vDEPT_AID IS NULL THEN                
                                       -- vDEPT_AID:=HR_PK_VALIDATION.FN_GENERATE_AID(vCompID, 'GM_DEPTS',1);    ---ADDED BY ANISH BHOIL ON 21TH FEB 2019 REQUESTED BY AZHAR.
                        ----Added AND COMMENTED BY ANISH BHOIL ON 21TH FEB 2019, REQUESTED BY AZHAR.
                                        vMaxNumber:=0;
                                        
                                       IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN    
                                          
                                          OPEN curRec FOR
                                              SELECT TO_NUMBER(MAX(SUBSTR(DEPT_ID,3))) DEPT_ID FROM GM_DEPTS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                  WHERE COMP_ID = vCompID;
                                          FETCH curRec INTO vMaxNumber;
                                       ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
                                           OPEN curRec FOR
                                              SELECT TO_NUMBER(MAX(SUBSTR(DEPT_ID,3))) DEPT_ID FROM GM_DEPTS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                  WHERE COMP_ID = vCompID;
                                          FETCH curRec INTO vMaxNumber;
                                       ELSE   
                                           OPEN curRec FOR
                                              SELECT TO_NUMBER(MAX(SUBSTR(DEPT_ID,3))) DEPT_ID FROM GM_DEPTS
                                                  WHERE COMP_ID = vCompID;
                                          FETCH curRec INTO vMaxNumber;
                                       END IF;   
                                                    
                                          vDEPT_AID := 'DE'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                                 
                                 IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN   
                                      OPEN CURREC FOR 
                                              SELECT 'DEP'||TO_CHAR(NVL(MAX(SUBSTR(TRIM(DEPT_MID),4)),0) +1)--NVL(MAX(DEPT_MID),0)+1
                                              FROM GM_DEPTS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                              WHERE COMP_ID=vCompID ;
                                         FETCH CURREC INTO  vSYS_GEN_DEPT_MID;
                                      CLOSE  CURREC;
                                      
                                      INSERT INTO GM_DEPTS@DBLINK_ABG_OP_BIRLACHEM_UAT(GRP_COMP_ID, COMP_ID, DEPT_ID, DEPT_MID, DEPT_DESC, DEPT_SUB_DESC, REMARKS, 
                                              CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, 
                                              DEPRTMENT_HEAD, ACTIVE, DEPT_HEAD) 
                          VALUES('CG000163',vCompID,vDEPT_AID,vSYS_GEN_DEPT_MID,vDEPT_DESC,vDEPT_DESC,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                                              pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N',vDEPT_MID,'1',NULL);
                        --                                           vERROR_FLAG:='Y';
                        --                                           vERROR_MSG:='Department code '||vDEPT_MID||' does not exist';
                                                                 --  GOTO PRINT_ERROR;
                                                                 
                                 ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN     
                                      OPEN CURREC FOR 
                                              SELECT  MAX(ROWNUM)+1--TO_CHAR(NVL(MAX(SUBSTR(TRIM(DEPT_MID),3)),0) +1)--NVL(MAX(DEPT_MID),0)+1
                                              FROM GM_DEPTS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                              WHERE COMP_ID=vCompID;
                                         FETCH CURREC INTO  vSYS_GEN_DEPT_MID;
                                      CLOSE  CURREC;
                                      
                                      INSERT INTO INT_CHECK VALUES('8 '||vSYS_GEN_DEPT_MID||'  '||vDEPT_MID||' '||vDEPT_DESC||' '||vCompID||' '||vEMP_CODE||' '||VPAYGROUP||' '||VSCHEMA_TRANS_DBLINK);
                                      commit;
                                      
                                      INSERT INTO GM_DEPTS@DBLINK_ABG_OP_ABGHINDALCO_UAT(GRP_COMP_ID, COMP_ID, DEPT_ID, DEPT_MID, DEPT_DESC, DEPT_SUB_DESC, REMARKS, 
                                              CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, 
                                              DEPRTMENT_HEAD, ACTIVE, DEPT_HEAD) 
                          VALUES('CG000184',vCompID,vDEPT_AID,vSYS_GEN_DEPT_MID,vDEPT_DESC,vDEPT_DESC,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                                              pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N',vDEPT_MID,'1',NULL);
                        --                                           vERROR_FLAG:='Y';
                        --                                           vERROR_MSG:='Department code '||vDEPT_MID||' does not exist';
                                                                 --  GOTO PRINT_ERROR;
                                 ELSE     
                                      OPEN CURREC FOR 
                                              SELECT 'DEP'||TO_CHAR(NVL(MAX(SUBSTR(TRIM(DEPT_MID),4)),0) +1)--NVL(MAX(DEPT_MID),0)+1
                                              FROM GM_DEPTS
                                              WHERE COMP_ID=vCompID;
                                         FETCH CURREC INTO  vSYS_GEN_DEPT_MID;
                                      CLOSE  CURREC;
                                      
                                      INSERT INTO GM_DEPTS(GRP_COMP_ID, COMP_ID, DEPT_ID, DEPT_MID, DEPT_DESC, DEPT_SUB_DESC, REMARKS, 
                                              CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, 
                                              DEPRTMENT_HEAD, ACTIVE, DEPT_HEAD) 
                          VALUES('CG000185',vCompID,vDEPT_AID,vSYS_GEN_DEPT_MID,vDEPT_DESC,vDEPT_DESC,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                                              pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N',vDEPT_MID,'1',NULL);
                        --                                           vERROR_FLAG:='Y';
                        --                                           vERROR_MSG:='Department code '||vDEPT_MID||' does not exist';
                                                                 --  GOTO PRINT_ERROR;
                                      
                                 END IF; 

                          
                              END IF;

                                    IF vDESGN_DESC IS NOT NULL THEN
                                             -- vDESG_ID:=HR_PK_VALIDATION.FN_GET_DESGN_ID_DESC(vCompID,vDESGN_DESC);
                                         IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN      
                                              OPEN curRec FOR
                                                  SELECT DESGN_ID FROM GM_DESIGNATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                      WHERE COMPANY_ID = vCompID AND UPPER(DESGN_MID) = UPPER(TRIM(vDESGN_DESC));
                                              FETCH curRec INTO vDESG_ID;
                                              CLOSE  curRec;
                                         ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN     
                                               OPEN curRec FOR
                                                  SELECT DESGN_ID FROM GM_DESIGNATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                      WHERE COMPANY_ID = vCompID AND UPPER(DESGN_MID) = UPPER(TRIM(vDESGN_DESC));
                                              FETCH curRec INTO vDESG_ID;
                                              CLOSE  curRec;
                                         ELSE     
                                               OPEN curRec FOR
                                                  SELECT DESGN_ID FROM GM_DESIGNATIONS
                                                      WHERE COMPANY_ID = vCompID AND UPPER(DESGN_MID) = UPPER(TRIM(vDESGN_DESC));
                                              FETCH curRec INTO vDESG_ID;
                                              CLOSE  curRec;
                                    
                                         END IF;
                                              
                                    END IF;

                                       IF vDESG_ID IS NULL THEN
                                          --vDESG_ID:=HR_PK_VALIDATION.FN_GENERATE_AID(vCompID, 'GM_DESIGNATIONS',1); ---ADDED BY ANISH BHOIL ON 21TH FEB 2019 REQUESTED BY AZHAR.
                                       ----Added AND COMMENTED BY ANISH BHOIL ON 21TH FEB 2019, REQUESTED BY AZHAR. 
                                       vMaxNumber:=0;
                                       
                                       IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN     
                                            OPEN curRec FOR
                                                SELECT TO_NUMBER(MAX(SUBSTR(DESGN_ID,3))) DESGN_ID FROM GM_DESIGNATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                    WHERE COMPANY_ID = vCompID;
                                            FETCH curRec INTO vMaxNumber;
                                            CLOSE curRec;
                                
                                            vDESG_ID := 'DG'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                                       
                                            OPEN CURREC FOR
                                                 SELECT 'DEG'||TO_CHAR(NVL(MAX(SUBSTR(TRIM(DESGN_MID),4)),0) +1) FROM GM_DESIGNATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT  
                                                      WHERE COMPANY_ID=vCompID;
                                               FETCH CURREC INTO  vDESG_MID;
                                            CLOSE  CURREC;

                                       INSERT INTO GM_DESIGNATIONS@DBLINK_ABG_OP_BIRLACHEM_UAT(GRP_COMP_ID, COMPANY_ID, DESGN_ID, DESGN_MID, DESGN_DESC, DESGN_SUB_DESC, REMARKS, 
                                                      CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, AUTO_APPR_FLAG, 
                                                      RESOURCEPLAN, DISPLAY_ORDER, ACTIVE_FLG)
                                       VALUES('CG000163',vCompID,vDESG_ID,vDESG_MID,vDESGN_DESC,vDESGN_DESC,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                                             pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N','0',NULL,NULL,'1');     
--                                           vERROR_FLAG:='Y';
--                                           vERROR_MSG:='Designation '||vDESGN_DESC||' does not exist';
--                                           GOTO PRINT_ERROR;
                                      ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                        OPEN curRec FOR
                                                SELECT TO_NUMBER(MAX(SUBSTR(DESGN_ID,3))) DESGN_ID FROM GM_DESIGNATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                    WHERE COMPANY_ID = vCompID;
                                            FETCH curRec INTO vMaxNumber;
                                            CLOSE curRec;
                                
                                            vDESG_ID := 'DG'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                                       
                                            OPEN CURREC FOR
                                                 SELECT 'DEG'||TO_CHAR(NVL(MAX(SUBSTR(TRIM(DESGN_MID),4)),0) +1) FROM GM_DESIGNATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT  
                                                      WHERE COMPANY_ID=vCompID;
                                               FETCH CURREC INTO  vDESG_MID;
                                            CLOSE  CURREC;

                                       INSERT INTO GM_DESIGNATIONS@DBLINK_ABG_OP_ABGHINDALCO_UAT(GRP_COMP_ID, COMPANY_ID, DESGN_ID, DESGN_MID, DESGN_DESC, DESGN_SUB_DESC, REMARKS, 
                                                      CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, AUTO_APPR_FLAG, 
                                                      RESOURCEPLAN, DISPLAY_ORDER, ACTIVE_FLG)
                                       VALUES('CG000184',vCompID,vDESG_ID,vDESG_MID,vDESGN_DESC,vDESGN_DESC,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                                             pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N','0',NULL,NULL,'1');     
--                                           vERROR_FLAG:='Y';
--                                           vERROR_MSG:='Designation '||vDESGN_DESC||' does not exist';
--                                           GOTO PRINT_ERROR;
                                       ELSE
                                        OPEN curRec FOR
                                                SELECT TO_NUMBER(MAX(SUBSTR(DESGN_ID,3))) DESGN_ID FROM GM_DESIGNATIONS
                                                    WHERE COMPANY_ID = vCompID;
                                            FETCH curRec INTO vMaxNumber;
                                            CLOSE curRec;
                                
                                            vDESG_ID := 'DG'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
                                       
                                            OPEN CURREC FOR
                                                 SELECT 'DEG'||TO_CHAR(NVL(MAX(SUBSTR(TRIM(DESGN_MID),4)),0) +1) FROM GM_DESIGNATIONS  
                                                      WHERE COMPANY_ID=vCompID;
                                               FETCH CURREC INTO  vDESG_MID;
                                            CLOSE  CURREC;

                                       INSERT INTO GM_DESIGNATIONS(GRP_COMP_ID, COMPANY_ID, DESGN_ID, DESGN_MID, DESGN_DESC, DESGN_SUB_DESC, REMARKS, 
                                                      CR_USER_ID, CR_DATE, UP_USER_ID, UP_DATE, DEL_USER_ID, DEL_DATE, IS_DELETED, AUTO_APPR_FLAG, 
                                                      RESOURCEPLAN, DISPLAY_ORDER, ACTIVE_FLG)
                                       VALUES('CG000185',vCompID,vDESG_ID,vDESG_MID,vDESGN_DESC,vDESGN_DESC,'ADDED THROUGH INTEGRATION ON '||SYSDATE,
                                             pUser_Aid,SYSDATE,NULL,NULL,NULL,NULL,'N','0',NULL,NULL,'1');     
--                                           vERROR_FLAG:='Y';
--                                           vERROR_MSG:='Designation '||vDESGN_DESC||' does not exist';
--                                           GOTO PRINT_ERROR;
                                   END IF;     
                                        
                                        END IF;

                                    IF vEMPL_CADRE IS NOT NULL THEN 
                                              --vEMPL_CADRE:=HR_PK_VALIDATION.FN_GET_PAR_AID(vEMP_MGMT_CATEGORY);
   
                                         IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN        
                                              OPEN curRec FOR
                                                  SELECT PAR_AID FROM GM_PARAMETERS@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                      WHERE UPPER(PARA_DESC) LIKE '%'||UPPER(vEMPL_CADRE)||'%';
                                              FETCH curRec INTO vEMP_MGMT_CATEGORY;
                                              CLOSE  curRec;
                                         ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN     
                                                OPEN curRec FOR
                                                  SELECT PAR_AID FROM GM_PARAMETERS@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                      WHERE UPPER(PARA_DESC) LIKE '%'||UPPER(vEMPL_CADRE)||'%';
                                              FETCH curRec INTO vEMP_MGMT_CATEGORY;
                                              CLOSE  curRec;
                                         ELSE     
                                                OPEN curRec FOR
                                                  SELECT PAR_AID FROM GM_PARAMETERS
                                                      WHERE UPPER(PARA_DESC) LIKE '%'||UPPER(vEMPL_CADRE)||'%';--vEMP_MGMT_CATEGORY
                                              FETCH curRec INTO vEMP_MGMT_CATEGORY;
                                              CLOSE  curRec;
                                         END IF;
                                    END IF;
                                    
                               insert  into int_check values(' cate issue: '||vEMPL_CADRE||' '||vEMP_MGMT_CATEGORY ); 
                               commit;

                                       IF vEMP_MGMT_CATEGORY IS NULL THEN
                                           vERROR_FLAG:='Y';
                                           vERROR_MSG:='Management Category '||vEMPL_CADRE||' does not exist';
                                           GOTO PRINT_ERROR;
                                        END IF;
                               END IF;  
                ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN CHARTFIELD DETAILS' THEN

                                    IF vCOSTCENTER_MID IS NOT NULL THEN---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                             -- vCC_ID:=HR_PK_VALIDATION.FN_GET_CC_AID(vCompID,vCOSTCENTER_MID);
                                             IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN  
                                                OPEN curRec FOR
                                                    SELECT COST_CENTER_ID FROM GM_COST_CENTER@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                        WHERE UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(vCompID)) AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(vCOSTCENTER_MID));
                                                FETCH curRec INTO vCC_ID;
                                                CLOSE  curRec;
                                             ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN 
                                                OPEN curRec FOR
                                                  SELECT COST_CENTER_ID FROM GM_COST_CENTER@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                      WHERE UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(vCompID)) AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(vCOSTCENTER_MID));
                                                FETCH curRec INTO vCC_ID;
                                                CLOSE  curRec;
                                             ELSE 
                                                OPEN curRec FOR
                                                  SELECT COST_CENTER_ID FROM GM_COST_CENTER
                                                      WHERE UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(vCompID)) AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(vCOSTCENTER_MID));
                                                FETCH curRec INTO vCC_ID;
                                                CLOSE  curRec;
                                             END IF;
                                    END IF;

                                    IF vCOSTCENTER_MID is not null and vCC_ID IS NULL THEN---ADDED by ANISH BHOIL ON 08TH MAR 2019 , REQUESTED BY AZHAR.
                                           vMaxNumber:=0;
                                      --vCC_ID:=HR_PK_VALIDATION.FN_GENERATE_AID(vCompID,'GM_COST_CENTER',1); 
                                      ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                        IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN 
                                            OPEN curRec FOR
                                                SELECT TO_NUMBER(MAX(SUBSTR(COST_CENTER_ID,3))) COST_CENTER_ID FROM GM_COST_CENTER@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                    WHERE COMP_CODE = vCompID;
                                            FETCH curRec INTO vMaxNumber;
                                            CLOSE  curRec;
                                
                                            vCC_ID := 'CC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
    
                                          INSERT INTO GM_COST_CENTER@DBLINK_ABG_OP_BIRLACHEM_UAT(COMP_CODE,COST_CENTER_ID,COST_CODE,COST_DESC,ACTIVE_FLAG,DATE_CR,USER_CR,REMARKS) 
                                              VALUES(vCompID,vCC_ID,vCOSTCENTER_MID,vCOSTCENTER_MID,1,SYSDATE,pUser_Aid,'ADDED THROUGH INTEGRATION ON '||SYSDATE); 
                                       ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN
                                          OPEN curRec FOR
                                                SELECT TO_NUMBER(MAX(SUBSTR(COST_CENTER_ID,3))) COST_CENTER_ID FROM GM_COST_CENTER@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                    WHERE COMP_CODE = vCompID;
                                            FETCH curRec INTO vMaxNumber;
                                            CLOSE  curRec;
                                
                                            vCC_ID := 'CC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
    
                                          INSERT INTO GM_COST_CENTER@DBLINK_ABG_OP_ABGHINDALCO_UAT(COMP_CODE,COST_CENTER_ID,COST_CODE,COST_DESC,ACTIVE_FLAG,DATE_CR,USER_CR,REMARKS) 
                                              VALUES(vCompID,vCC_ID,vCOSTCENTER_MID,vCOSTCENTER_MID,1,SYSDATE,pUser_Aid,'ADDED THROUGH INTEGRATION ON '||SYSDATE); 
                                        ELSE      
                                          OPEN curRec FOR
                                                SELECT TO_NUMBER(MAX(SUBSTR(COST_CENTER_ID,3))) COST_CENTER_ID FROM GM_COST_CENTER
                                                    WHERE COMP_CODE = vCompID;
                                            FETCH curRec INTO vMaxNumber;
                                            CLOSE  curRec;
                                
                                            vCC_ID := 'CC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
    
                                          INSERT INTO GM_COST_CENTER(COMP_CODE,COST_CENTER_ID,COST_CODE,COST_DESC,ACTIVE_FLAG,DATE_CR,USER_CR,REMARKS) 
                                              VALUES(vCompID,vCC_ID,vCOSTCENTER_MID,vCOSTCENTER_MID,1,SYSDATE,pUser_Aid,'ADDED THROUGH INTEGRATION ON '||SYSDATE);     

                                        END IF; 
                                    END IF; 

--                                         IF vCC_ID IS NULL THEN---commented by ANISH BHOIL ON 08TH MAR 2019 , REQUESTED BY AZHAR.
--                                              vERROR_FLAG:='Y';
--                                              vERROR_MSG:='Cost Center Code '||vCOSTCENTER_MID||' does not exist';
--                                              GOTO PRINT_ERROR;
--                                         END IF;

                ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN NID DETAILS' THEN

                              IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vAADHAR_NO),'~!@$%^&*()+=.,''') > 0 THEN
                                         vERROR_FLAG:='Y';
                                         vERROR_MSG:='Invalid Aadhar Number special character found!';
                                         GOTO PRINT_ERROR;
                              END IF;

--              ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN PERSONAL INFORMATION' THEN

                ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN PF DETAILS' THEN

                                    IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vUAN_NO),'~!@$%^&*()+=.,''') > 0 THEN
                                       vERROR_FLAG:='Y';
                                       vERROR_MSG:='Invalid UAN Number special character found!';
                                       GOTO PRINT_ERROR;
                                    END IF;

                ELSIF UPPER(TRIM(vREMARKS))='CHANGE IN BANK ACCOUNTS' OR UPPER(TRIM(vREMARKS)) LIKE '%BANK%'  THEN

                                      ----------------------------------------------------------------------     
                                            IF HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(vIFSC_CODE),'~!@$%^&*()+=.,''') > 0 THEN
                                                     vERROR_FLAG:='Y';
                                                     vERROR_MSG:='Invalid IFSC Code special character found!';
                                                     GOTO PRINT_ERROR;
                                            END IF;


                                            IF vBANK_NAME IS NOT NULL THEN
                                                      --vBANK_AID:=HR_PK_VALIDATION.FN_GET_BANK_ID_NAME(vCompID,vBANK_NAME);
                                                      ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                                                        
                                                  IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN     
                                                        OPEN curRec FOR
                                                            SELECT BANK_AID FROM gm_bank@DBLINK_ABG_OP_BIRLACHEM_UAT
                                                                WHERE  COMP_AID = vCompID AND UPPER( TRIM(BANK_NAME)) =UPPER( TRIM(vBANK_NAME));
                                                        FETCH curRec INTO vBANK_AID;
                                                        CLOSE  curRec;
                                                  ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN      
                                                         OPEN curRec FOR
                                                            SELECT BANK_AID FROM gm_bank@DBLINK_ABG_OP_ABGHINDALCO_UAT
                                                                WHERE  COMP_AID = vCompID AND UPPER( TRIM(BANK_NAME)) =UPPER( TRIM(vBANK_NAME));
                                                        FETCH curRec INTO vBANK_AID;
                                                        CLOSE  curRec;
                                                  ELSE      
                                                         OPEN curRec FOR
                                                            SELECT BANK_AID FROM gm_bank
                                                                WHERE  COMP_AID = vCompID AND UPPER( TRIM(BANK_NAME)) =UPPER( TRIM(vBANK_NAME));
                                                        FETCH curRec INTO vBANK_AID;
                                                        CLOSE  curRec;
                                                  END IF;    
                                            END IF;

                                            IF vBANK_AID IS NULL THEN
                                                    vERROR_FLAG:='Y';
                                                    vERROR_MSG:='Bank name '||vBANK_NAME||' does not exist';
                                                    GOTO PRINT_ERROR;
                                            END IF;   
                                              NULL;
                END IF;
      ---------------------------------------------------------------------------------------------------------------


          IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
            IF  vEMP_CODE IS NULL THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Employee Code should not be blank';
                 GOTO PRINT_ERROR;
            END IF;
          END IF;

          IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
            IF NVL(LENGTH(TRIM(NVL(vJOIN_DATE,' '))),0)=0 THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='Join Date should not be blank';
               GOTO PRINT_ERROR;
            END IF;
          END IF;

          IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
            IF vEMP_FNAME IS NULL THEN
               VERROR_FLAG:='Y';
               vERROR_MSG:='Employee First Name should not be blank';
               GOTO PRINT_ERROR;
            END IF;
          END IF;

          IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
             IF vEMP_FATHERNAME IS NULL THEN
                 VERROR_FLAG:='Y';
                 vERROR_MSG:='Employee Father Name should not be blank';
                 GOTO PRINT_ERROR;
             END IF;
         END IF;

         IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION) IN('ADD','CHANGE') THEN 
           IF vSEX IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='Gender should not be blank';
               GOTO PRINT_ERROR;
           ELSE
            vSEX:=TRIM(UPPER(vSEX));

            vSEX:=CASE WHEN vSEX='FEMALE' THEN 'F' 
                       WHEN vSEX='MALE' THEN 'M'
                       ELSE '' END;
            IF vSEX='' THEN 
              GOTO PRINT_ERROR;
            END IF;
           END IF;
         END IF;

         vSEX:=SUBSTR(vSEX,1,1);

        IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
           IF NVL(LENGTH(TRIM(NVL(vBIRTH_DATE,' '))),0)=0 THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='Birth Date should not be blank';
               GOTO PRINT_ERROR;
           END IF;
         END IF;



          vBIRTH_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vBIRTH_DATE));
          vGROUP_JOINING_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vGROUP_JOINING_DATE));
          vJOIN_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vJOIN_DATE));
          vLEAVE_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vLEAVE_DATE));

                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL2)) = UPPER(TRIM(vCOMP_CODE)) and UPPER(TRIM(COL3))=UPPER(TRIM(vEMP_MID)) ;
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate records found!';
                     GOTO PRINT_ERROR;
                 END IF;

                IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
                      OPEN curRec FOR
--                          SELECT COUNT(*) FROM GM_EMP ---COMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
--                          WHERE COMP_ID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID));
---COMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                           SELECT COUNT(*) FROM EMP_DATA_SET ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
                           WHERE COMP_AID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID)); 
                      FETCH curRec INTO vChkRecordCount;
                           
                      IF vChkRecordCount > 0 THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Record Already exist!';
                           GOTO PRINT_ERROR;
                     END IF; 
               END IF;

                IF UPPER(vREMARKS) NOT LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
                      OPEN curRec FOR
--                          SELECT COUNT(*) FROM GM_EMP ---COMENTED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.  
--                          WHERE COMP_ID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID));
                          SELECT COUNT(*) FROM EMP_DATA_SET  ---added BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR.
                          WHERE COMP_aID=UPPER(TRIM(vCompID)) 
                          AND EMP_ID=UPPER(TRIM(vEMP_ID));
                      FETCH curRec INTO vChkRecordCount;

                      IF vChkRecordCount = 0 THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Personal information does not exist for employee code '||vEMP_MID;
                           GOTO PRINT_ERROR;
                     END IF; 
               END IF;               


--                IF  UPPER(vACTION) IN('CHANGE','DELETE') AND vTransfer_emp_flag=0 THEN 
--                      OPEN curRec FOR
--                          SELECT COUNT(*) FROM GM_EMP 
--                          WHERE COMP_ID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID));
--                      FETCH curRec INTO vChkRecordCount;
--              
--                      IF vChkRecordCount = 0 THEN
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Record does not exist to '||vACTION||'!';
--                           GOTO PRINT_ERROR;
--                     END IF; 
--               END IF;             --commented by ANISH BHOIL ON 18TH FEB 2019. AS NEW EMP WILL COME AS IN CHANGE.   
          
          
          
       IF vEMP_ID IS NOT NULL THEN
                 
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vSAF_NO',2),vSAF_NO);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vEMPL_CLASS',2),vEMPL_CLASS);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vPROFIT_CENTER_CODE',2),vPROFIT_CENTER_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vALT_DEPT_CODE',2),vALT_DEPT_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vALTER_EMPLID',2),vALTER_EMPLID);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vBU_DESCR',2),vBU_DESCR);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vCLUSTER_CODE',2),vCLUSTER_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vF1_CODE',2),vF1_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vLOCATION_ACOUNT_CODE',2),vLOCATION_ACOUNT_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vPF_ESTAB_TYPE',2),vPF_ESTAB_TYPE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vPRAN_NO',2),vPRAN_NO);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vPRODUCT_CODE',2),vPRODUCT_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vSITE_ID_CODE',2),vSITE_ID_CODE);
          PRO_INSERT_ATTB_DETAILS (VSCHEMA_TRANS_DBLINK,vCompID,vEMP_ID,SUBSTR('vVENDOR_ID_CODE',2),vVENDOR_ID_CODE);

       END IF;   
          
          IF NVL(vERROR_FLAG,'N')='N' THEN

              IF vTransfer_emp_flag>0 THEN ---ADDED BY ANISH BHOIL ON 14TH FEB 2019 REQUESTED BY AZHAR AND KAMLAKAR AND RISHI. 
                     ---ADDED BY ANISH BHOIL ON 12TH FEB 2020 FOR 3 IN 1 TRANSFER, REQUESTED BY AZHAR AND VINIT SIR. 
                      IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN
                        UPDATE GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                        SET LEAVE_DATE=TO_DATE(vJOIN_DATE,'DD-MM-YY')-1
                        WHERE EMP_MID=vEMP_CODE
                        AND COMP_ID !=vCompID
                        AND LEAVE_DATE IS NULL;
                      ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN  
                        UPDATE GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                        SET LEAVE_DATE=TO_DATE(vJOIN_DATE,'DD-MM-YY')-1
                        WHERE EMP_MID=vEMP_CODE
                        AND COMP_ID !=vCompID
                        AND LEAVE_DATE IS NULL;
                      ELSE  
                        UPDATE GM_EMP
                        SET LEAVE_DATE=TO_DATE(vJOIN_DATE,'DD-MM-YY')-1
                        WHERE EMP_MID=vEMP_CODE
                        AND COMP_ID !=vCompID
                        AND LEAVE_DATE IS NULL;
                      END IF; 
              
              END IF;


                INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO
                        ,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10
                        ,COL11,COL12,COL13,COL14,COL15,COL16,COL17
                        ,COL18,COL19,COL20,COL21,COL22,COL23,COL24,COL25,COL26
                        ,COL27,COL28,COL29, COL30, COL31,COL32
                        ,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                        COL47,COL48
                        )---ADDED BY ANISH BHOIL FOR 3 IN 1 CONCEPT TO GET PROPER DBLINK IN COL32 IN 2ND LOOP USED BELOW. 
                VALUES(vUpldBatch_Id,pSessionId,pUser_Aid, pUpload_Aid, SYSDATE ,TRDO.ROW_NUM+2
                        ,vACTION,vCompID,vEMP_ID,vEMP_NAME,vEMP_FNAME,vEMP_MNAME,vEMP_LNAME,vSEX,vBIRTH_DATE,vMARITAL_STATUS
                        ,vCORRESPONDENCE_EMAIL1,vEMP_FATHERNAME,vHANDICAP,vCHILDREN,vGROUP_JOINING_DATE,vJOIN_DATE,vLEAVE_DATE
                        ,vDEPT_AID, vLOC_AID, vSTATE_AID, vDESG_ID, vEMP_MGMT_CATEGORY, vPAN_NO, vCC_ID, vEPF_NO, vBANK_AID
                        ,vUAN_NO, vAADHAR_NO, vIFSC_CODE, vREMARKS, vEMP_CODE,VSCHEMA_TRANS_DBLINK
                        ,vSAF_NO,vEMPL_CLASS,vPROFIT_CENTER_CODE,vALT_DEPT_CODE,vALTER_EMPLID,vBU_DESCR,vCLUSTER_CODE,vF1_CODE,vLOCATION_ACOUNT_CODE,vPF_ESTAB_TYPE,vPRAN_NO,vPRODUCT_CODE,vSITE_ID_CODE,vVENDOR_ID_CODE
                        ,vOLD_emp_flag,vTransfer_emp_flag);---ADDED BY ANISH BHOIL FOR 3 IN 1 CONCEPT TO GET PROPER DBLINK IN 2ND LOOP USED BELOW. 
          END IF;

          <<PRINT_ERROR>>
              INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                    ,COL1, COL2, COL3,COL4, COL5, COL6,COL7,COL8, COL9, COL10
                    ,COL11, COL12, COL13,COL14,COL15, COL16, COL17
                    ,COL18, COL19, COL20, COL21, COL22, COL23, COL24
                    ,COL25, COL26, COL27, COL28, COL29, COL30, COL31, COL32
                    ,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46
                    )
              VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, NVL(vERROR_FLAG,'N'), vERROR_MSG,TRDO.ROW_NUM+2--I+2
                    ,vACTION,vCOMP_CODE,vEMP_CODE,vEMP_NAME,vEMP_FNAME,vEMP_MNAME,vEMP_LNAME,vSEX,vBIRTH_DATE,vMARITAL_STATUS
                    ,vCORRESPONDENCE_EMAIL1,vEMP_FATHERNAME,vHANDICAP,vCHILDREN,vGROUP_JOINING_DATE,vJOIN_DATE,vLEAVE_DATE
                    ,vDEPT_MID, vLOCATION_MID, vSTATE_MID, vDESGN_DESC,vEMP_MGMT_CATEGORY, vPAN_NO, vCOSTCENTER_MID
                    ,vAADHAR_NO,vEPF_NO,vUAN_NO,vBANK_NAME,vIFSC_CODE,vREMARKS,VEFFECTIVE_DATE,VPAYGROUP
                    ,vSAF_NO,vEMPL_CLASS,vPROFIT_CENTER_CODE,vALT_DEPT_CODE,vALTER_EMPLID,vBU_DESCR,vCLUSTER_CODE,vF1_CODE,vLOCATION_ACOUNT_CODE,vPF_ESTAB_TYPE,vPRAN_NO,vPRODUCT_CODE,vSITE_ID_CODE,vVENDOR_ID_CODE
                    );
--          INSERT INTO VAI VALUES(vEMP_MID||':='||vEMP_CODE);

      END LOOP; 

--           INSERT INTO SFTP_TEST VALUES('1.'||' %%%% '||vEMP_CODE||' @@@@ '||vCompID||' !!!! '||vOLD_emp_flag||' &&&& '||vTransfer_emp_flag||' ^^^ '||vEMP_ID||'  @@@ '||vSEX); 
--              COMMIT;

      PY_PK_SFTP_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

--         INSERT INTO SFTP_TEST VALUES('2.'||' %%%% '||vEMP_CODE||' @@@@ '||vCompID||' !!!! '||vOLD_emp_flag||' &&&& '||vTransfer_emp_flag||' ^^^ '||vEMP_ID); 
--              COMMIT;

--    ELSIF pOperationType= 'COMMIT_UPLOAD' THEN 

---COMMENTED TO AVOID ENTRY IM MASTER
      FOR I IN (SELECT TRIM(UPPER(COL1)) ACTION
                      ,COL2 COMP_AID
                      ,COL3 EMP_AID
                      ,COL4 EMP_NAME
                      ,COL5 EMP_FNAME
                      ,COL6 EMP_MNAME
                      ,COL7 EMP_LNAME
                      ,COL8 SEX
                      ,COL9 BIRTH_DATE
                      ,COL10 MARITAL_STATUS
                      ,COL11 CORRESPONDENCE_EMAIL1
                      ,COL12 EMP_FATHERNAME
                      ,COL13 HANDICAP 
                      ,DECODE(COL14,'',0) CHILDREN
                      ,COL15 GROUP_JOINING_DATE
                      ,COL16 JOIN_DATE
                      ,COL17 LEAVE_DATE
                      ,COL18	DEPT_ID
                      ,COL19	LOC_ID
--                      ,COL20	STATE_AID
                      ,COL21	DESG_ID
                      ,COL22	EMP_MGMT_CATE_AID
                      ,COL23	PAN_NO
                      ,COL24	COSTCNTR_ID
                      ,COL25	EPF_NO
                      ,COL26	BANK_AID
                      ,COL27	UAN_NO
                      ,COL28	AADHAR_NO
                      ,COL29	IFSC_CODE
                      ,COL30  REMARKS
                      ,COL31  EMP_MID
                      ,COL32  DBLINK
                      ,COL47  OLD_emp_flag
                      ,COL48  Transfer_emp_flag
                      ,pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_PT_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId)
--                         AND STATUS = 'PENDING' AND pOperationType ='COMMIT_UPLOAD')
      LOOP  


        IF (UPPER(I.ACTION)='ADD' AND I.OLD_emp_flag=0 AND I.Transfer_emp_flag>0) OR ((UPPER(I.ACTION)='CHANGE') AND I.OLD_emp_flag=0 AND I.Transfer_emp_flag>0) THEN
       insert into int_check values(' inserting..... '||I.ACTION || ' ' ||I.EMP_MID||' '||I.COMP_AID||' '||I.DBLINK);
       commit;
            
          IF I.DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN  
              Insert into GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT (GR_COMP_ID,COMP_ID,EMP_ID,EMP_MID,EMP_FNAME,EMP_MNAME,EMP_LNAME,FATHER_HUSBAND,EMP_NAME,EMP_GENDER,BIRTH_DATE,COPORATE_JOIN_DATE,JOIN_DATE,LEAVE_DATE,CORRS_MAIL1,CHILDRENS,MARITAL_STATUS,IS_HANDICAP,
                                DEPT_ID, LOC_ID, DESG_ID, EMP_MGMT_CATE_AID, PAN_NO, COSTCNTR_ID, EPF_NO, BANK_AID,UAN_NO,AADHAR_NO, IFSC_CODE,
                                CR_USER_ID,CR_DATE) values 
                                      ('CG000163',I.COMP_AID,vEmp_id,I.EMP_MID,I.EMP_FNAME,I.EMP_MNAME,I.EMP_LNAME,I.EMP_FATHERNAME,I.EMP_NAME,I.SEX,I.BIRTH_DATE,I.GROUP_JOINING_DATE,I.JOIN_DATE,I.LEAVE_DATE,I.CORRESPONDENCE_EMAIL1,I.CHILDREN,I.MARITAL_STATUS,I.HANDICAP,
                                      I.DEPT_ID, I.LOC_ID, I.DESG_ID, I.EMP_MGMT_CATE_AID, I.PAN_NO, I.COSTCNTR_ID, I.EPF_NO, I.BANK_AID,I.UAN_NO,I.AADHAR_NO, I.IFSC_CODE,I.UP_USER_ID,SYSDATE);
          ELSIF I.DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
              Insert into GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT (GR_COMP_ID,COMP_ID,EMP_ID,EMP_MID,EMP_FNAME,EMP_MNAME,EMP_LNAME,FATHER_HUSBAND,EMP_NAME,EMP_GENDER,BIRTH_DATE,COPORATE_JOIN_DATE,JOIN_DATE,LEAVE_DATE,CORRS_MAIL1,CHILDRENS,MARITAL_STATUS,IS_HANDICAP,
                                DEPT_ID, LOC_ID, DESG_ID, EMP_MGMT_CATE_AID, PAN_NO, COSTCNTR_ID, EPF_NO, BANK_AID,UAN_NO,AADHAR_NO, IFSC_CODE,
                                CR_USER_ID,CR_DATE) values 
                                      ('CG000184',I.COMP_AID,vEmp_id,I.EMP_MID,I.EMP_FNAME,I.EMP_MNAME,I.EMP_LNAME,I.EMP_FATHERNAME,I.EMP_NAME,I.SEX,I.BIRTH_DATE,I.GROUP_JOINING_DATE,I.JOIN_DATE,I.LEAVE_DATE,I.CORRESPONDENCE_EMAIL1,I.CHILDREN,I.MARITAL_STATUS,I.HANDICAP,
                                      I.DEPT_ID, I.LOC_ID, I.DESG_ID, I.EMP_MGMT_CATE_AID, I.PAN_NO, I.COSTCNTR_ID, I.EPF_NO, I.BANK_AID,I.UAN_NO,I.AADHAR_NO, I.IFSC_CODE,I.UP_USER_ID,SYSDATE);
          ELSE
              Insert into GM_EMP (GR_COMP_ID,COMP_ID,EMP_ID,EMP_MID,EMP_FNAME,EMP_MNAME,EMP_LNAME,FATHER_HUSBAND,EMP_NAME,EMP_GENDER,BIRTH_DATE,COPORATE_JOIN_DATE,JOIN_DATE,LEAVE_DATE,CORRS_MAIL1,CHILDRENS,MARITAL_STATUS,IS_HANDICAP,
                                DEPT_ID, LOC_ID, DESG_ID, EMP_MGMT_CATE_AID, PAN_NO, COSTCNTR_ID, EPF_NO, BANK_AID,UAN_NO,AADHAR_NO, IFSC_CODE,
                                CR_USER_ID,CR_DATE) values 
                                      ('CG000185',I.COMP_AID,vEmp_id,I.EMP_MID,I.EMP_FNAME,I.EMP_MNAME,I.EMP_LNAME,I.EMP_FATHERNAME,I.EMP_NAME,I.SEX,I.BIRTH_DATE,I.GROUP_JOINING_DATE,I.JOIN_DATE,I.LEAVE_DATE,I.CORRESPONDENCE_EMAIL1,I.CHILDREN,I.MARITAL_STATUS,I.HANDICAP,
                                      I.DEPT_ID, I.LOC_ID, I.DESG_ID, I.EMP_MGMT_CATE_AID, I.PAN_NO, I.COSTCNTR_ID, I.EPF_NO, I.BANK_AID,I.UAN_NO,I.AADHAR_NO, I.IFSC_CODE,I.UP_USER_ID,SYSDATE);
          END IF;      
        ELSE --ELSIF(UPPER(I.ACTION)='CHANGE')THEN  
         
         IF I.DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN  
 
          UPDATE GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT 
            SET EMP_MID=NVL(I.EMP_MID, EMP_MID)
               ,EMP_FNAME=NVL(I.EMP_FNAME,EMP_FNAME)
               ,EMP_MNAME=NVL(I.EMP_MNAME, EMP_MNAME)
               ,EMP_LNAME=NVL(I.EMP_LNAME, EMP_LNAME)
               ,FATHER_HUSBAND=NVL(I.EMP_FATHERNAME, FATHER_HUSBAND)
               ,EMP_NAME=NVL(I.EMP_NAME, EMP_NAME)
               ,EMP_GENDER=NVL(I.SEX, EMP_GENDER)
               ,BIRTH_DATE=NVL(I.BIRTH_DATE, BIRTH_DATE)
               ,COPORATE_JOIN_DATE=NVL(I.GROUP_JOINING_DATE, COPORATE_JOIN_DATE)
               ,JOIN_DATE=NVL(I.JOIN_DATE, JOIN_DATE)
               ,LEAVE_DATE=NVL(I.LEAVE_DATE, LEAVE_DATE)
               ,CORRS_MAIL1=NVL(I.CORRESPONDENCE_EMAIL1, CORRS_MAIL1)
               ,CHILDRENS=NVL(I.CHILDREN,CHILDRENS)--,CHILDRENS=CASE WHEN (I.CHILDREN IS NULL OR TRIM(I.CHILDREN) ='') THEN CHILDRENS ELSE TO_NUMBER(NVL(I.CHILDREN,0)) END
               ,MARITAL_STATUS=NVL(I.MARITAL_STATUS, MARITAL_STATUS)
               ,IS_HANDICAP=NVL(I.HANDICAP, IS_HANDICAP)
               ,DEPT_ID=NVL(I.DEPT_ID, DEPT_ID)
               ,LOC_ID=NVL(I.LOC_ID, LOC_ID)
               ,DESG_ID=NVL(I.DESG_ID, DESG_ID)
               ,EMP_MGMT_CATE_AID=NVL(I.EMP_MGMT_CATE_AID, EMP_MGMT_CATE_AID)
               ,PAN_NO=NVL(I.PAN_NO, PAN_NO)
               ,COSTCNTR_ID=NVL(I.COSTCNTR_ID, COSTCNTR_ID)
               ,EPF_NO=NVL(I.EPF_NO, EPF_NO)
               ,BANK_AID=NVL(I.BANK_AID, BANK_AID)
               ,UAN_NO=NVL(I.UAN_NO, UAN_NO)
               ,AADHAR_NO=NVL(I.AADHAR_NO, AADHAR_NO)
               ,IFSC_CODE=NVL(I.IFSC_CODE, IFSC_CODE)
               ,UP_USER_ID=UP_USER_ID
               ,UP_DATE=UP_DATE
              WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));
--              LOG ERRORS INTO ERR$_GM_EMP ('UPDATE') REJECT LIMIT UNLIMITED;

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT@DBLINK_ABG_OP_BIRLACHEM_UAT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID));
                    vSR_NO:=vSR_NO+1;

                    INSERT INTO GM_EMP_EMPLOYMENT@DBLINK_ABG_OP_BIRLACHEM_UAT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,GRADE_ID,BAND_ID,CC_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
                    SELECT COMP_ID,EMP_ID,vSR_NO,JOIN_DATE,DESG_ID,DEPT_ID,I.CR_USER_ID,SYSDATE,EMP_GRADE,BAND_ID,COSTCNTR_ID,BRANCH_AID,EMP_DEPT_CATE_AID, SUB_DEPT_AID
                    FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(EMP_ID))=UPPER(TRIM(I.EMP_AID));
         ELSIF I.DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN    
         
           insert into int_check values(' updating... '||I.ACTION || ' ' ||I.EMP_MID||' '||I.COMP_AID||' '||I.DBLINK);
        commit;
                  
             UPDATE GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT 
            SET EMP_MID=NVL(I.EMP_MID, EMP_MID)
               ,EMP_FNAME=NVL(I.EMP_FNAME,EMP_FNAME)
               ,EMP_MNAME=NVL(I.EMP_MNAME, EMP_MNAME)
               ,EMP_LNAME=NVL(I.EMP_LNAME, EMP_LNAME)
               ,FATHER_HUSBAND=NVL(I.EMP_FATHERNAME, FATHER_HUSBAND)
               ,EMP_NAME=NVL(I.EMP_NAME, EMP_NAME)
               ,EMP_GENDER=NVL(I.SEX, EMP_GENDER)
               ,BIRTH_DATE=NVL(I.BIRTH_DATE, BIRTH_DATE)
               ,COPORATE_JOIN_DATE=NVL(I.GROUP_JOINING_DATE, COPORATE_JOIN_DATE)
               ,JOIN_DATE=NVL(I.JOIN_DATE, JOIN_DATE)
               ,LEAVE_DATE=NVL(I.LEAVE_DATE, LEAVE_DATE)
               ,CORRS_MAIL1=NVL(I.CORRESPONDENCE_EMAIL1, CORRS_MAIL1)
               ,CHILDRENS=NVL(I.CHILDREN,CHILDRENS)--,CHILDRENS=CASE WHEN (I.CHILDREN IS NULL OR TRIM(I.CHILDREN) ='') THEN CHILDRENS ELSE TO_NUMBER(NVL(I.CHILDREN,0)) END
               ,MARITAL_STATUS=NVL(I.MARITAL_STATUS, MARITAL_STATUS)
               ,IS_HANDICAP=NVL(I.HANDICAP, IS_HANDICAP)
               ,DEPT_ID=NVL(I.DEPT_ID, DEPT_ID)
               ,LOC_ID=NVL(I.LOC_ID, LOC_ID)
               ,DESG_ID=NVL(I.DESG_ID, DESG_ID)
               ,EMP_MGMT_CATE_AID=NVL(I.EMP_MGMT_CATE_AID, EMP_MGMT_CATE_AID)
               ,PAN_NO=NVL(I.PAN_NO, PAN_NO)
               ,COSTCNTR_ID=NVL(I.COSTCNTR_ID, COSTCNTR_ID)
               ,EPF_NO=NVL(I.EPF_NO, EPF_NO)
               ,BANK_AID=NVL(I.BANK_AID, BANK_AID)
               ,UAN_NO=NVL(I.UAN_NO, UAN_NO)
               ,AADHAR_NO=NVL(I.AADHAR_NO, AADHAR_NO)
               ,IFSC_CODE=NVL(I.IFSC_CODE, IFSC_CODE)
               ,UP_USER_ID=UP_USER_ID
               ,UP_DATE=sysdate
              WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));
--              LOG ERRORS INTO ERR$_GM_EMP ('UPDATE') REJECT LIMIT UNLIMITED;

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT@DBLINK_ABG_OP_ABGHINDALCO_UAT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID));
                    vSR_NO:=vSR_NO+1;

                    INSERT INTO GM_EMP_EMPLOYMENT@DBLINK_ABG_OP_ABGHINDALCO_UAT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,GRADE_ID,BAND_ID,CC_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
                    SELECT COMP_ID,EMP_ID,vSR_NO,JOIN_DATE,DESG_ID,DEPT_ID,I.CR_USER_ID,SYSDATE,EMP_GRADE,BAND_ID,COSTCNTR_ID,BRANCH_AID,EMP_DEPT_CATE_AID, SUB_DEPT_AID
                    FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(EMP_ID))=UPPER(TRIM(I.EMP_AID));
         ELSE    
              UPDATE GM_EMP 
            SET EMP_MID=NVL(I.EMP_MID, EMP_MID)
               ,EMP_FNAME=NVL(I.EMP_FNAME,EMP_FNAME)
               ,EMP_MNAME=NVL(I.EMP_MNAME, EMP_MNAME)
               ,EMP_LNAME=NVL(I.EMP_LNAME, EMP_LNAME)
               ,FATHER_HUSBAND=NVL(I.EMP_FATHERNAME, FATHER_HUSBAND)
               ,EMP_NAME=NVL(I.EMP_NAME, EMP_NAME)
               ,EMP_GENDER=NVL(I.SEX, EMP_GENDER)
               ,BIRTH_DATE=NVL(I.BIRTH_DATE, BIRTH_DATE)
               ,COPORATE_JOIN_DATE=NVL(I.GROUP_JOINING_DATE, COPORATE_JOIN_DATE)
               ,JOIN_DATE=NVL(I.JOIN_DATE, JOIN_DATE)
               ,LEAVE_DATE=NVL(I.LEAVE_DATE, LEAVE_DATE)
               ,CORRS_MAIL1=NVL(I.CORRESPONDENCE_EMAIL1, CORRS_MAIL1)
               ,CHILDRENS=NVL(I.CHILDREN,CHILDRENS)--,CHILDRENS=CASE WHEN (I.CHILDREN IS NULL OR TRIM(I.CHILDREN) ='') THEN CHILDRENS ELSE TO_NUMBER(NVL(I.CHILDREN,0)) END
               ,MARITAL_STATUS=NVL(I.MARITAL_STATUS, MARITAL_STATUS)
               ,IS_HANDICAP=NVL(I.HANDICAP, IS_HANDICAP)
               ,DEPT_ID=NVL(I.DEPT_ID, DEPT_ID)
               ,LOC_ID=NVL(I.LOC_ID, LOC_ID)
               ,DESG_ID=NVL(I.DESG_ID, DESG_ID)
               ,EMP_MGMT_CATE_AID=NVL(I.EMP_MGMT_CATE_AID, EMP_MGMT_CATE_AID)
               ,PAN_NO=NVL(I.PAN_NO, PAN_NO)
               ,COSTCNTR_ID=NVL(I.COSTCNTR_ID, COSTCNTR_ID)
               ,EPF_NO=NVL(I.EPF_NO, EPF_NO)
               ,BANK_AID=NVL(I.BANK_AID, BANK_AID)
               ,UAN_NO=NVL(I.UAN_NO, UAN_NO)
               ,AADHAR_NO=NVL(I.AADHAR_NO, AADHAR_NO)
               ,IFSC_CODE=NVL(I.IFSC_CODE, IFSC_CODE)
               ,UP_USER_ID=UP_USER_ID
               ,UP_DATE=UP_DATE
              WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));
--              LOG ERRORS INTO ERR$_GM_EMP ('UPDATE') REJECT LIMIT UNLIMITED;

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID));
                    vSR_NO:=vSR_NO+1;

                    INSERT INTO GM_EMP_EMPLOYMENT (COMP_ID,EMP_ID,SR_NO,EFFECT_DATE,DESG_ID,DEPT_ID,USER_CR,CR_DATE,GRADE_ID,BAND_ID,CC_ID,BRANCH_ID,EMP_DEPT_CATE_AID, SUB_DEPT_AID)
                    SELECT COMP_ID,EMP_ID,vSR_NO,JOIN_DATE,DESG_ID,DEPT_ID,I.CR_USER_ID,SYSDATE,EMP_GRADE,BAND_ID,COSTCNTR_ID,BRANCH_AID,EMP_DEPT_CATE_AID, SUB_DEPT_AID
                    FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(EMP_ID))=UPPER(TRIM(I.EMP_AID));

           END IF;        

        END IF;
      END LOOP;


            PY_PK_SFTP_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);
    END IF;

    COMMIT;

                OPEN Return_Recordset FOR
                     SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'SUCCESS:: Data commited successfully' ErrMessage FROM DUAL;


     EXCEPTION
    WHEN PAY_GROUP_NOT_FOUND THEN
        HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPLOAD_EMP_MASTER_NEW' ,'PAY GROUP NOT DEFINE IN SYSTEM AS PASSED THROUGH FILE'||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    WHEN DBLINK_NOT_TRACED THEN
        HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPLOAD_EMP_MASTER_NEW' ,'UNABLE TO TRACK DBLINK OR TRANSFER COMPANY FOR EMPLOYEE ' ||vEMP_CODE||' '||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    WHEN OTHERS THEN
      ROLLBACK;
      HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPLOAD_EMP_MASTER_NEW' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    OPEN Return_Recordset FOR
      SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,NVL(vERROR_MSG,'ERROR OCCURRED DUE TO SOME REASON') ErrMessage FROM DUAL;

END PRO_UPLOAD_EMP_MASTER_NEW;



PROCEDURE PRO_UPDATE_EMP_MASTER(  ---- Created By Saaroj Kumar Giri for Employee Leave Date
    pOperationType VARCHAR2,--EDITED BY ANISH BHOIL ON 13TH FEB 2020 FOR 3 IN 1 CONCEPT. 
    pComp_Aid      VARCHAR2,
    pAcc_Year      VARCHAR2,
    pUser_Aid      VARCHAR2,
    pSessionId     VARCHAR2,
    pUpload_Aid    VARCHAR2,
    pRawXmlData    CLOB,
    pTrans_Type      VARCHAR2,
    pUpload_Batch_Id VARCHAR2,
    Return_Recordset OUT REC)
AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vXmlParser              dbms_xmlparser.Parser;
    vXmlDomDocument         dbms_xmldom.DOMDocument;
    vXmlDOMNodeList         dbms_xmldom.DOMNodeList;
    vXmlDOMNode             dbms_xmldom.DOMNode;

    vUpldBatch_Id           HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    excemp                    EXCEPTION;
    excemp_leave_date         EXCEPTION;
    excemp_users         EXCEPTION;
    vCompID                   VARCHAR2(8);
    vCOMP_CODE                VARCHAR2(20);
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vCount                    NUMBER;
    vACTION                   VARCHAR2(200);
    vEMP_MID                  VARCHAR2(200);
    vEMP_LNAME                VARCHAR2(200);
    vEMP_MNAME                VARCHAR2(200);
    vEMP_FNAME                VARCHAR2(200);
    vEMP_NAME                 VARCHAR2(200);
    vSEX                      VARCHAR2(200);
    vBIRTH_DATE               VARCHAR2(200);
    vMARITAL_STATUS           VARCHAR2(200);
    vCORRESPONDENCE_EMAIL2    VARCHAR2(200);
    vEMP_FATHERNAME           VARCHAR2(200);
    vHANDICAP                 VARCHAR2(200);
    vCHILDREN                 VARCHAR2(200);
    vCORP_JOIN_DATE           VARCHAR2(200);
    vJOIN_DATE                VARCHAR2(200);
    vLEAVE_DATE               VARCHAR2(200);
    vLEAVE_DATE1              DATE;
    vLEAVE_DATE2              DATE;
    vDESG_MID                 VARCHAR2(200);
    vBR_MID                   VARCHAR2(200);
    vDEPT_MID                 VARCHAR2(200);
    vDEPT_AID                 VARCHAR2(200);
    vLOC_MID                  VARCHAR2(200);
    vGRADE_MID                VARCHAR2(200);
    vBAND_MID                 VARCHAR2(200);
    vCOSTCENTER_MID           VARCHAR2(200);
    vBR_AID                   VARCHAR2(200);
    vGRADE_ID                 VARCHAR2(200);
    vBAND_ID                  VARCHAR2(200);
    vCC_ID                    VARCHAR2(200);
    vESIC                     VARCHAR2(200);
    vESIC_NO                  VARCHAR2(200);
    vPAN_NO                   VARCHAR2(200);
    vPF_FLAG                  VARCHAR2(200);
    vPF_NO                    VARCHAR2(200);
    vPF_CAL_TYPE              VARCHAR2(200);
    vBANK_MID                 VARCHAR2(200);
    vBANK_ACC_NO              VARCHAR2(200);
    vREIMB_BANK_MID           VARCHAR2(200);
    vREIMB_ACC_NO             VARCHAR2(200);
    vMGMT_CAT                 VARCHAR2(200);
    vDEPT_CAT                 VARCHAR2(200);
    vSUB_DEPT_MID             VARCHAR2(200);
    vUAN_NO                   VARCHAR2(200);
    vAADHAR_NO                VARCHAR2(200);
    vIFSC_CODE                VARCHAR2(200);
    vACTUAL_QUIT_DATE         VARCHAR2(200);
    vFNF_SETTLEMENT_DATE      VARCHAR2(200);
    vPF_CAL_ID                VARCHAR2(200);
    vBANK_AID                 VARCHAR2(200);
    vREIMB_BANK_AID           VARCHAR2(200);
    vSUB_DEPT_ID              VARCHAR2(200);
--    vComp_Id                  VARCHAR2(200);
    vChkRecordCount            NUMBER;
    vCOMP_MID                 VARCHAR2(200);
    vLOCATION_MID             VARCHAR2(200);
    vSTATE_MID                VARCHAR2(200);
    vDESGN_DESC               VARCHAR2(200);
    vDESG_ID                  VARCHAR2(200);    
    vBANK_NAME                VARCHAR2(200);
    vEMP_MGMT_CATE_AID        VARCHAR2(200);
    vEPF_NO                   VARCHAR2(200);
    vEMP_MGMT_CATEGORY        VARCHAR2(200);
    vLOC_AID                  VARCHAR2(200);
    vSTATE_AID                VARCHAR2(200);
    vActiveLocation           VARCHAR2(200);
    vEMP_CODE                 VARCHAR2(200);
    vREMARKS                  VARCHAR2(200);
    vCOMP_NAME                VARCHAR2(200);
    vComp_Aid                 VARCHAR2(200);
    vPAY_GROUP                VARCHAR2(200);
    vEMP_ID                   GM_EMP.EMP_ID%TYPE;

    vSR_NO                    NUMBER;
    MAILBODY1 LONG;
    BODYMSG LONG;
    SUBJECT VARCHAR2(1000);
    vCompCode VARCHAR2(10);

    vDbLink VARCHAR2(100);
    vEmpMid VARCHAR2(100);
    V_EMP_NAME VARCHAR2(100);
    STRSQL VARCHAR2(2000);
    vCompDispCode VARCHAR2(10);
    vUserName VARCHAR2(20);
    vPassword VARCHAR2(10);
    VCOMP_ID                VARCHAR2(8);
    vPaygroup               VARCHAR2(20);
    VSCHEMA_TRANS_DBLINK    VARCHAR2(30);
    DBLINK_NOT_TRACED       EXCEPTION;
    vEmp_Aid                VARCHAR2(8);
    vDATE_OF_SEPARATION_NEW date;
    vDATE_OF_SEPARATION  Date;
    vHIRE_DATE_NEW  Date;
    vHIRE_DATE     Date;

BEGIN
    vERROR_FLAG:='N';

INSERT INTO PRO_UPDATE_EMP_MASTER_TEMP VALUES(pRawXmlData,pUpload_Aid,SYSDATE);
INSERT INTO PRO_UPDATE_EMP_MASTER_TEMP1 VALUES(pOperationType||'@'||pComp_Aid||'@'||pAcc_Year||'@'||pUser_Aid||'@'||pSessionId||'@'||pUpload_Aid||'@'||pTrans_Type||'@'||pUpload_Batch_Id,SYSDATE);
COMMIT;

--      vRawXmlData:= REGEXP_REPLACE(pRawXmlData,' xml:space="preserve"',NULL)  ;
--      pRawXmlData:= REGEXP_REPLACE(pRawXmlData,'&amp;','&');


    IF pOperationType='RAW_UPLOAD' THEN


      vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);
      vXmlParser := dbms_xmlparser.newParser;
      dbms_xmlparser.parseClob(vXmlParser,pRawXmlData);


--            insert into OSO2_CLOB(XYZ, UPLOAD_AID) 
--                   values(pRawXmlData,pUpload_Aid);
--                   COMMIT;
--      dbms_xmlparser.parseClob(vXmlParser,'<DocumentElement>\r\n  <ExcelInfo>\r\n    <COMP_CODE>RENUSTAF</COMP_CODE>\r\n    <ACTION>Add</ACTION>\r\n    <EMP_LNAME>Ingle1</EMP_LNAME>\r\n    <EMP_MNAME>Rajendra Test</EMP_MNAME>\r\n    <EMP_FNAME>Divyank1</EMP_FNAME>\r\n    <EMP_NAME>Mr Divyank1 Ingle1</EMP_NAME>\r\n    <SEX>M</SEX>\r\n    <BIRTH_DATE>10-29-1991</BIRTH_DATE>\r\n    <MARITAL_STATUS>Unknown</MARITAL_STATUS>\r\n    <CORRESPONDENCE_EMAIL1>poornataroute@adityabirla.com</CORRESPONDENCE_EMAIL1>\r\n    <CHILDREN>1</CHILDREN>\r\n  </ExcelInfo>\r\n</DocumentElement>');
--      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

      vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);


      vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

      FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

      vERROR_MSG:=NULL; vERROR_FLAG:=NULL;  vREMARKS:=NULL; vACTION:=NULL; vCOMP_CODE:=NULL; vEMP_CODE:=NULL; vEMP_MID:=NULL;
      vDEPT_MID:=NULL; vLOCATION_MID:=NULL; vSTATE_MID:=NULL; vDESGN_DESC:=NULL; vEMP_MGMT_CATEGORY:=NULL; vLOCATION_MID:= NULL; 
      vCompID:=NULL; vLOC_AID:=NULL; vActiveLocation:=NULL; vSTATE_AID:=NULL; vSTATE_MID:=NULL; vDEPT_MID:=NULL; vDEPT_AID:=NULL;
      vDESGN_DESC:=NULL; vDESG_ID:=NULL;  vEMP_MGMT_CATE_AID:=NULL; vCOSTCENTER_MID:=NULL; vCC_ID:=NULL; vPAN_NO:=NULL; 
      vAADHAR_NO:=NULL; vEMP_FNAME:=NULL;vEMP_MNAME:=NULL; vEMP_LNAME:=NULL; vEMP_FATHERNAME:=NULL; vSEX:=NULL; 
      vCORRESPONDENCE_EMAIL2:=NULL; vBIRTH_DATE:=NULL; vCORP_JOIN_DATE:=NULL; vJOIN_DATE:=NULL; vHANDICAP:=NULL; vLEAVE_DATE:= NULL;
      vCHILDREN:=NULL; vEMP_NAME:=NULL; vMARITAL_STATUS:=NULL; vEPF_NO:=NULL; vUAN_NO:=NULL; vBANK_NAME:=NULL; vIFSC_CODE:=NULL; vBANK_AID:=NULL; 
      vPAY_GROUP:=NULL;VSCHEMA_TRANS_DBLINK:=NULL;


          vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
          dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTION/text()',vACTION);
          dbms_xslprocessor.valueOf(vXmlDOMNode,'REMARKS/text()',vREMARKS);
          dbms_xslprocessor.valueOf(vXmlDOMNode,'COMP_NAME/text()',vCOMP_NAME);
--          INSERT INTO VAI VALUES(vREMARKS);
          BEGIN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS_CODE/text()',vCOMP_CODE);
          EXCEPTION WHEN OTHERS THEN
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
            dbms_xslprocessor.valueOf(vXmlDOMNode,'PAY_GROUP/text()',vPAY_GROUP);
          EXCEPTION WHEN OTHERS THEN
              IF (SQLCODE ='-24331') THEN
                vERROR_MSG:='Invalid value for Pay Group (Max limit is 10 character)';
                vERROR_FLAG:='Y';
              ELSE
                vERROR_FLAG:='Y';
                vERROR_MSG:='Invalid value for Pay Group';
              END IF;
              GOTO PRINT_ERROR;
          END;


--          BEGIN
--            dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_CODE/text()',vEMP_CODE);
--          EXCEPTION WHEN OTHERS THEN
--              IF (SQLCODE ='-24331') THEN
--                vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
--                vERROR_FLAG:='Y';
--              ELSE
--                vERROR_FLAG:='Y';
--                vERROR_MSG:='Invalid value for Company Code';
--              END IF;
--              GOTO PRINT_ERROR;
--          END;

          BEGIN
            dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',vEMP_MID);
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
                                dbms_xslprocessor.valueOf(vXmlDOMNode,'CORRESPONDENCE_EMAIL2/text()',vCORRESPONDENCE_EMAIL2);
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

                          vLEAVE_DATE2:=TO_DATE(TO_DATE(vLEAVE_DATE,'YYYY-MM-DD'),'DD-MM-YY');

--                                    INSERT INTO ABC10 VALUES (vLEAVE_DATE2);
--          INSERT INTO ABC5 VALUES (vLEAVE_DATE2);
          COMMIT;
--                                            BEGIN
--                                              dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_CODE/text()',vEMP_CODE);
--                                            EXCEPTION WHEN OTHERS THEN
--                                                IF (SQLCODE ='-24331') THEN
--                                                  vERROR_MSG:='Invalid value for Company Code (Max limit is 8 character)';
--                                                  vERROR_FLAG:='Y';
--                                                ELSE
--                                                  vERROR_FLAG:='Y';
--                                                  vERROR_MSG:='Invalid value for Company Code';
--                                                END IF;
--                                                GOTO PRINT_ERROR;
--                                            END;
--                                                      
--                                            BEGIN
--                                              dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',vEMP_MID);
--                                            EXCEPTION
--                                              WHEN OTHERS THEN
--                                              IF (SQLCODE ='-24331') THEN
--                                                vERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
--                                                vERROR_FLAG:='Y';
--                                              ELSE
--                                                vERROR_FLAG:='Y';
--                                                vERROR_MSG:='Invalid value for Employee Code';
--                                              END IF;
--                                              GOTO PRINT_ERROR;
--                                            END;
--vCompID:=HR_PK_VALIDATION.FN_GET_MARSHA_TO_COMP_AID(vCOMP_CODE);


--vCompID:=HR_PK_VALIDATION.FN_GET_PAYGROUP_COMP_AID_new(vPAY_GROUP);--COMMENTED BY ANISH BHOIL ON 13TH FEB 2020 FOR 3 IN 1 CONCEPT.

-----==============================================================================
              OPEN CURREC for
                  SELECT COMP_ID,'DBLINK_ABG_OP_ABGHINDALCO_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                  WHERE  BUSINESS_NATURE_ID=vPAY_GROUP
                  UNION ALL
                  SELECT COMP_ID,'DBLINK_ABG_OP_BIRLACHEM_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                  WHERE  BUSINESS_NATURE_ID=vPAY_GROUP
                  UNION ALL
                  SELECT COMP_ID,'ABGGROUP' 
                  FROM GM_COMP
                  WHERE  BUSINESS_NATURE_ID=vPAY_GROUP;
                FETCH CURREC INTO VCOMP_ID,VSCHEMA_TRANS_DBLINK;
              CLOSE  CURREC;
            
           IF VSCHEMA_TRANS_DBLINK IS NULL THEN  
                vERROR_FLAG:='Y';
                vERROR_MSG:='Unable to track employee '||vEMP_MID||  ' group company';
                GOTO PRINT_ERROR;
           END IF;  
    

            
            IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                OPEN curRec FOR
                   select COMP_MID from gm_comp@DBLINK_ABG_OP_BIRLACHEM_UAT
                   where COMP_ID=VCOMP_ID;
                  FETCH curRec INTO vCOMP_MID;
                CLOSE curRec;
            ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN     
                 OPEN curRec FOR
                   select COMP_MID from gm_comp@DBLINK_ABG_OP_ABGHINDALCO_UAT
                   where COMP_ID=VCOMP_ID;
                  FETCH curRec INTO vCOMP_MID;
                CLOSE curRec;
            ELSE                    
                 OPEN curRec FOR
                   select COMP_MID from gm_comp
                   where COMP_ID=VCOMP_ID;
                  FETCH curRec INTO vCOMP_MID;
                CLOSE curRec;
            END IF;
            
                    vHIRE_DATE_NEW:= DATE_RETURN(vHIRE_DATE);
                    vDATE_OF_SEPARATION_NEW:=DATE_RETURN(vDATE_OF_SEPARATION) ;
--vComp_Aid                    vComp_Aid:=HR_PK_VALIDATION.FN_GET_MARSHA_TO_COMP_AID(vBUSINESS);
                    
                   --vEmp_Aid:=HR_PK_VALIDATION.FN_GET_EMP_AID(pComp_Aid, vEMP_MID);---COMMENTED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
              
               IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT.    
                   OPEN curRec FOR 
                    SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(VCOMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_MID));
                    FETCH curRec INTO vEmp_Aid;
                    CLOSE  curRec;
               ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN      
                    OPEN curRec FOR
                    SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(VCOMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_MID));
                    FETCH curRec INTO vEmp_Aid;
                    CLOSE  curRec; 
               ELSE     
                    OPEN curRec FOR
                    SELECT EMP_ID FROM GM_EMP---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(VCOMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_MID));
                    FETCH curRec INTO vEmp_Aid;
                    CLOSE  curRec; 
               END IF;   
--- =======================================================================================================
    
--vEMP_ID:=HR_PK_VALIDATION.FN_GET_EMP_AID(vCompID,vEMP_MID);


IF vEMP_ID IS NULL  THEN
      RAISE excemp;
END IF;

  IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT.    
        OPEN curRec FOR
            SELECT LEAVE_DATE FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_AID)) AND UPPER(TRIM(EMP_ID))= UPPER(TRIM(vEMP_ID));
        FETCH curRec INTO vLEAVE_DATE1;
        CLOSE  curRec;
  ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN      
         OPEN curRec FOR
            SELECT LEAVE_DATE FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_AID)) AND UPPER(TRIM(EMP_ID))= UPPER(TRIM(vEMP_ID));
        FETCH curRec INTO vLEAVE_DATE1;
        CLOSE  curRec;
  ELSE
         OPEN curRec FOR
            SELECT LEAVE_DATE FROM GM_EMP
                WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_AID)) AND UPPER(TRIM(EMP_ID))= UPPER(TRIM(vEMP_ID));
        FETCH curRec INTO vLEAVE_DATE1;
        CLOSE  curRec;  
  END IF;
  
--vLeave_Date1:=HR_PK_VALIDATION.FN_GET_EMP_LEAVE_DATE(vCompID,vEMP_ID);


IF vLeave_Date1 IS NOT NULL THEN
    RAISE excemp_leave_date;
END IF;


--                    IF vEMP_ID IS NULL THEN
--                           vERROR_FLAG:='Y';
--                           vERROR_MSG:='Employee Already Quite !';
--                           GOTO PRINT_ERROR;
--                     END IF; 
      ------------------------------------------VALIDATION PART------------------------------------------------------
--                vCompID:=HR_PK_VALIDATION.FN_GET_MASTER_AID('COMPANY_MASTER', vCOMP_NAME);


--          select COMP_MID, COMP_ID INTO vCOMP_CODE, vCompID  
--          from GM_COMP where COMP_NAME = vCOMP_NAME;
--         DELETE FROM VAI;
--          INSERt INTO VAI VALUES('vCOMP_CODE '||vCOMP_CODE || 'vCompID ' ||vCompID);
--          COMMIT;

--INSERT INTO VAI2 VALUES('vEMP_MID: ' || vEMP_MID || 'vCompID: ' || vCompID || 'vCOMP_CODE '||vCOMP_CODE);
--COMMIT;

--                IF vEMP_MID IS NOT NULL THEN
--                        vEMP_ID:=HR_PK_VALIDATION.FN_GET_EMP_AID (vCompID, vEMP_MID);
--                ELSE
--                        vEMP_ID:=HR_PK_VALIDATION.FN_GET_POORNATA_EMP_AID(vCompID, vEMP_CODE);
--                END IF;
--                    IF vEMP_ID IS NULL THEN
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Employee code 2:'||NVL(vEMP_CODE,vEMP_MID)||' does not exist';
--                       GOTO PRINT_ERROR;
--                    END IF;

          IF TRIM(vCOMP_CODE) IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:=' PAYROLL CODE SHOULD NOT BE BLANK';
               GOTO PRINT_ERROR;
          END IF;

          IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
            IF vEMP_MID IS NULL AND vEMP_CODE IS NULL THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Employee Code should not be blank';
                 GOTO PRINT_ERROR;
            END IF;
          END IF;

          IF UPPER(vREMARKS) LIKE UPPER('%Personal%') AND  UPPER(vACTION)='ADD' THEN 
            IF NVL(LENGTH(TRIM(NVL(vJOIN_DATE,' '))),0)=0 THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='Join Date should not be blank';
               GOTO PRINT_ERROR;
            END IF;
          END IF;
--          vBIRTH_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vBIRTH_DATE));
--          
--          vCORP_JOIN_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vCORP_JOIN_DATE));
--          vJOIN_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vJOIN_DATE));
--          vLEAVE_DATE2:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vLEAVE_DATE2));


                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL2)) = UPPER(TRIM(vCOMP_CODE)) and UPPER(TRIM(COL3))=UPPER(TRIM(vEMP_MID)) ;
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate records found!';
                     GOTO PRINT_ERROR;
                 END IF;

--                 INSERT INTO OSO VALUES(vCompID,vEMP_ID);
--                 COMMIT;
                      
                 IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT.          
                      OPEN curRec FOR
                          SELECT COUNT(*) FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT 
                          WHERE COMP_ID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID));
                      FETCH curRec INTO vChkRecordCount;
                 ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN      
                       OPEN curRec FOR
                          SELECT COUNT(*) FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT 
                          WHERE COMP_ID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID));
                      FETCH curRec INTO vChkRecordCount;
                 ELSE     
                       OPEN curRec FOR
                          SELECT COUNT(*) FROM GM_EMP 
                          WHERE COMP_ID=UPPER(TRIM(vCompID)) AND EMP_ID=UPPER(TRIM(vEMP_ID));
                      FETCH curRec INTO vChkRecordCount;
                 END IF;     

                      IF vChkRecordCount = 0 THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Record does not exist!';
                           GOTO PRINT_ERROR;
                     END IF; 
               INSERT INTO OSO_K (XYZ) VALUES (vERROR_FLAG);
               COMMIT;

          IF NVL(vERROR_FLAG,'N')='N' THEN

                INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO
                        ,COL1,COL2,COL3,COL4,COL5)
                VALUES(vUpldBatch_Id,pSessionId,pUser_Aid, pUpload_Aid, SYSDATE , I+2
                        ,vCompID,vEMP_ID,vCORRESPONDENCE_EMAIL2,vLEAVE_DATE2,VSCHEMA_TRANS_DBLINK);
          END IF;

          <<PRINT_ERROR>>
              INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO
                    ,COL1, COL2, COL3,COL4,COL5,COL6,COL7)
              VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, pUpload_Aid, SYSDATE, NVL(vERROR_FLAG,'N'), NVL(vERROR_MSG,'SUCCESS'), I+2
                    ,vCOMP_CODE,NVL(vEMP_CODE,vEMP_MID),vCORRESPONDENCE_EMAIL2,vLEAVE_DATE2,vACTION,vREMARKS,vCOMP_NAME);

      END LOOP; 
-- DELETE OSO_2;
-- COMMIT;
      PY_PK_SFTP_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY(vCompID ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

      SUBJECT:='ALUMNI PORTAL CREDENTAILS';  
     
 IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN   
      SELECT UPPER(TRIM(DBLINK_PAY_TO_HRMS))  INTO vDbLink FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT WHERE COMP_ID=vCompID;
 ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
      SELECT UPPER(TRIM(DBLINK_PAY_TO_HRMS))  INTO vDbLink FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT WHERE COMP_ID=vCompID;
 ELSE
      SELECT UPPER(TRIM(DBLINK_PAY_TO_HRMS))  INTO vDbLink FROM GM_COMP WHERE COMP_ID=vCompID; 
 END IF;

--      vCompCode: = 
      FOR I IN (SELECT TRIM(UPPER(COL1)) COMP_AID
                      ,COL2 EMP_AID
                      ,COL3 CORRESPONDENCE_EMAIL2
                      ,COL4 LEAVE_DATE,COL5 EMP_DBLINK
                      ,pUser_Aid CR_USER_ID, SYSDATE CR_DATE ,pUser_Aid UP_USER_ID, SYSDATE UP_DATE
                       FROM HR_PT_FINAL_UPLOAD_DATA
                       WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId)
      LOOP
         
         
       IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN     
          UPDATE GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT SET 
                LEAVE_DATE=I.LEAVE_DATE
               ,CORRS_MAIL2=NVL(I.CORRESPONDENCE_EMAIL2, CORRS_MAIL1)
--               ,UP_USER_ID=UP_USER_ID
--               ,UP_DATE=UP_DATE
               WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));   

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT@DBLINK_ABG_OP_BIRLACHEM_UAT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID));
                    vSR_NO:=vSR_NO+1;

          SELECT Emp_Mid, EMP_FNAME INTO vEmpMid,V_EMP_NAME
          FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT
          WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));
        ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
           UPDATE GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT SET 
                LEAVE_DATE=I.LEAVE_DATE
               ,CORRS_MAIL2=NVL(I.CORRESPONDENCE_EMAIL2, CORRS_MAIL1)
--               ,UP_USER_ID=UP_USER_ID
--               ,UP_DATE=UP_DATE
               WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));   

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT@DBLINK_ABG_OP_ABGHINDALCO_UAT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID));
                    vSR_NO:=vSR_NO+1;

          SELECT Emp_Mid, EMP_FNAME INTO vEmpMid,V_EMP_NAME
          FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
          WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));
        ELSE            
           UPDATE GM_EMP SET 
                LEAVE_DATE=I.LEAVE_DATE
               ,CORRS_MAIL2=NVL(I.CORRESPONDENCE_EMAIL2, CORRS_MAIL1)
--               ,UP_USER_ID=UP_USER_ID
--               ,UP_DATE=UP_DATE
               WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));   

                    SELECT  COUNT(EMP_ID) INTO vSR_NO   FROM GM_EMP_EMPLOYMENT WHERE UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID));
                    vSR_NO:=vSR_NO+1;

          SELECT Emp_Mid, EMP_FNAME INTO vEmpMid,V_EMP_NAME
          FROM GM_EMP
          WHERE  UPPER(TRIM(COMP_ID))=UPPER(TRIM(I.COMP_AID)) AND  UPPER(TRIM(EMP_ID))= UPPER(TRIM(I.EMP_AID));          
       END IF;   

--          SELECT 'CO'||LTRIM(TO_CHAR(TO_NUMBER(SUBSTR(B.GRP_COMP_ID,3,6))||TO_NUMBER(SUBSTR(B.COMP_ID,3,6)),'000000')) "COMP DISP CODE"
--                 , B.COMP_MID ||'_'||A.USER_NAME "Username"
--                 ,PasswordEncrypt_Decrypt(A.USER_PWD) "Password"
--                 INTO vCompDispCode, vUserName, vPassword
--          FROM PI_GM_USERS@DBLINK_PIP_ABG A,PI_GM_COMP@DBLINK_PIP_ABG B
--          WHERE A.GRP_COMP_ID = B.GRP_COMP_ID
--          AND A.COMP_AID= B.COMP_ID
--          AND B.COMP_ID= pCOMP_AID 
--          AND A.USER_NAME = vEmpMid;

           STRSQL := 'Select ''CO''||LTRIM(TO_CHAR(TO_NUMBER(SUBSTR(B.GRP_COMP_ID,3,6))||TO_NUMBER(SUBSTR(B.COMP_ID,3,6)),''000000'')) "COMP DISP CODE"                      ---INTO vCompDispCode, vUserName, vPassword
                       , B.COMP_MID ||''_''||A.USER_NAME "Username",
                       PasswordEncrypt_Decrypt(A.USER_PWD) "Password"
                      FROM PI_GM_USERS@' || vDbLink ||' A,PI_GM_COMP@' || vDbLink ||' B
                      WHERE A.GRP_COMP_ID = B.GRP_COMP_ID
                      AND A.COMP_AID= B.COMP_ID
                      AND B.COMP_ID='''|| vCompID ||'''
                      AND A.USER_NAME = '''|| vEmpMid ||'''';

          DELETE FROM OSO_2;

--          EXECUTE IMMEDIATE STRSQL INTO vCompDispCode, vUserName, vPassword;

                OPEN curRec FOR STRSQL;
                FETCH curRec INTO vCompDispCode, vUserName, vPassword;
                CLOSE  curRec;

IF vUserName IS NULL THEN
    RAISE excemp_users;
END IF;

--          INSERT INTO OSO_2 VALUES (STRSQL,SYSDATE);
          COMMIT;

--          DELETE FROM VAI2;
--          INSERT INTO VAI2 VALUES(vCompDispCode ||' '||vCompDispCode||' '||vUserName);
--          COMMIT; 

          MAILBODY1 := MAILBODY1||'<html><BODY>' || '<FONT style="FONT-FAMILY: arial; FONT-SIZE: 12px;">';
                       MAILBODY1 := MAILBODY1||''||''||'';
                       MAILBODY1 := MAILBODY1||'';
                       MAILBODY1 := MAILBODY1||'<P>Dear <b>' || V_EMP_NAME || ',</b> </p>';
                       MAILBODY1 := MAILBODY1||'<p> Here are your credentials for Alumni Portal:</P>';
                       MAILBODY1 := MAILBODY1||'<p> Link: <b> https://cs.osourceindia.com/ABGESS_UAT/ </b> </P>';
                       MAILBODY1 := MAILBODY1||'<p> Company Code: <b> '|| vCompDispCode || ' </b> </P>';
                       MAILBODY1 := MAILBODY1||'<p> User Name: <b> '|| vUserName || ' </b> </P>';
                       MAILBODY1 := MAILBODY1||'<p> Password: <b> '|| vPassword || ' </b> </P>';
--                       MAILBODY1 := MAILBODY1||'<p> Link: <b> https://cs.osourceindia.com/ABGESS_UAT/ </b> </P>';

                       MAILBODY1 := MAILBODY1||'<P><br>Best Regards,</P>';
                       MAILBODY1 := MAILBODY1||'<P><b>Payroll Team - Osource</b></P>';
                       MAILBODY1 := MAILBODY1||'</BODY></HTML>';
          DELETE OSO_K;
          INSERT INTO OSO_K (XYZ,DATETIME) VALUES(I.CORRESPONDENCE_EMAIL2||'-------'||SUBJECT||'------'||MAILBODY1,SYSDATE);
          COMMIT;
--          PRO_SEND_MAIL('payroll@osourceindia.com' ,I.CORRESPONDENCE_EMAIL2,SUBJECT,MAILBODY1,NULL);                    
      END LOOP;
--            PY_PK_SFTP_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);
      END IF;

    COMMIT;
                OPEN Return_Recordset FOR
                     SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'SUCCESS:: Data commited successfully' ErrMessage FROM DUAL;



    EXCEPTION 

     WHEN excemp THEN
--        PY_PK_ERROR_LOG.PROCESS_ERROR_LOG(vCompID,vEMP_ID,null,null, 'GM_EMP','Employee Leave Date Already Exist !', null);
    OPEN Return_Recordset FOR
      SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID, 'Employee Doesn''t Exist !' ErrMessage FROM DUAL;

WHEN excemp_leave_date THEN

OPEN Return_Recordset FOR
      SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Employee Leave Date Already Exist !' ErrMessage FROM DUAL;

WHEN excemp_users THEN
OPEN Return_Recordset FOR
      SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Employee Master Not Publish In Payroll to Pip !' ErrMessage FROM DUAL;

 RETURN;
    WHEN OTHERS THEN

      ROLLBACK;

      INSERT INTO EXCEPTION_TEST VALUES(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,SYSDATE);
      COMMIT;
      HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPDATE_EMP_MASTER' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    OPEN Return_Recordset FOR
      SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;

END PRO_UPDATE_EMP_MASTER;

PROCEDURE PRO_UPLOAD_EMP_CTC(   ----Created By Saroj Kumar Giri Employee CTC
    pOperationType   VARCHAR2,
    pComp_Aid        VARCHAR2,
    pAcc_Year        VARCHAR2,
    pUser_Aid        VARCHAR2,
    pSessionId       VARCHAR2,
    pUpload_Aid      VARCHAR2,
    pRawXmlData      CLOB,
    pTrans_Type      VARCHAR2,
    pUpload_Batch_Id VARCHAR2,
    Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;
    vXmlParser                dbms_xmlparser.Parser;
    vXmlDomDocument           dbms_xmldom.DOMDocument;
    vXmlDOMNodeList           dbms_xmldom.DOMNodeList;
    vXmlDOMNode               dbms_xmldom.DOMNode;
   
    vEMP_ID                   GM_EMP.EMP_ID%TYPE;
    vEMP_CTC_ID               PM_EMP_CTC_DEFINE.EMP_CTC_ID%TYPE;
    vEFF_DATE_FR              VARCHAR2(200);
    V_JOIN_DATE               DATE;
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vUpldBatch_Id             HR_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;
    vALLOWANCE                VARCHAR2(20);
    vCOUNTRY                  VARCHAR2(50);
    vBUSINESS_DESCR           VARCHAR2(50);
    vBUSINESS_UNIT_DESCR      VARCHAR2(50);
    vPoornata_ID              VARCHAR2(8);
    vName_Display             VARCHAR2(50);
    vDesignation              VARCHAR2(50);
    vPaygroup                 VARCHAR2(20);
    vLocation                 VARCHAR2(50);
    vCurrency_Cd              VARCHAR2(50);
    vEffective_Date           DATE;
    pEffective_Date           varchar2(15);
    vAudit_Action             VARCHAR2(50);
    vFixed_Compensation_AMT   NUMBER(24,6);
    vAmount                   NUMBER(24,6);
    pAmount                   VARCHAR2(100);
    vComp_Mid                 VARCHAR2(100);
    vnumber_count             NUMBER(20):=0;
    varCTC_CODE               CTC_ALLOWANCE_MAST.CTC_CODE%TYPE;
    varCTC_MID               CTC_ALLOWANCE_MAST.CTC_MID%TYPE;
    
    vComp_Id                  GM_COMP.COMP_ID%TYPE;--ADDED BY ANISH BHOIL ON 13TH FEB 2020 FOR 3 IN 1 CONCEPT.
    vQuery                    VARCHAR2(2000);
    VDBLINK_NAME              VARCHAR2(30);
    DBLINK_NOT_TRACED         EXCEPTION;
  
BEGIN
DELETE OSO;
--        DELETE UPLOAD_EMP_CTC_TEMP;
--        DELETE UPLOAD_EMP_CTC_TEMP1;
        INSERT INTO UPLOAD_EMP_CTC_TEMP VALUES(pRawXmlData,pUpload_Aid,SYSDATE);
        INSERT INTO UPLOAD_EMP_CTC_TEMP1 VALUES(pOperationType||'@'||pComp_Aid||'@'||pAcc_Year||'@'||pUser_Aid||'@'||pSessionId||'@'||pUpload_Aid||'@'||pTrans_Type||'@'||pUpload_Batch_Id,SYSDATE);
--        DELETE FROM int_check; 
--        COMMIT;
        vUpldBatch_Id := FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);
        vXmlParser := dbms_xmlparser.newParser;
        dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
        vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
        vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');
        FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP
              vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);
              vERROR_MSG:= 'SUCCESS:: Data commited successfully';
              vERROR_FLAG:='N';
              vERROR_MSG              :=NULL;
              vEFF_DATE_FR            :=NULL;
              vEMP_CTC_ID             :=NULL;
              vCOUNTRY                :=NULL;
              vBUSINESS_DESCR         :=NULL;
              vBUSINESS_UNIT_DESCR    :=NULL;
              vPoornata_ID            :=NULL;
              vName_Display           :=NULL;
              vDesignation            :=NULL;
              vPaygroup               :=NULL;
              vLocation               :=NULL;
              vCurrency_Cd            :=NULL;
              vEffective_Date         :=NULL;
              vAudit_Action           :=NULL;
              vFixed_Compensation_AMT :=NULL;
              vComp_Id                :=NULL;
              vComp_Mid               :=NULL;
              vEMP_ID                 :=NULL;
              varCTC_MID              :=NULL;
              VDBLINK_NAME            :=NULL;    

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'COUNTRY/text()',vCOUNTRY);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Country (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid value for Country ';
                   END IF;
              GOTO PRINT_ERROR;
          END;
          
          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'PAYGROUP/text()',vPaygroup);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for PAYGROUP (Max limit is 8 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Invalid value for PAYGROUP ';
                   END IF;
              GOTO PRINT_ERROR;
          END;
          
          IF vPAYGROUP='AMET_PG002' THEN 
              
            vPAYGROUP:='AMET_PG001';
                   
          END IF;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'BRAND_NAME/text()',vBUSINESS_DESCR);
          EXCEPTION
              WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                      vERROR_MSG:='Invalid Value For BUSINESS DESCR(Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for BUSINESS DESCR';
                   END IF;
              GOTO PRINT_ERROR;
          END;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS_UNIT_DESCR/text()',vBUSINESS_UNIT_DESCR);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for BUSINESS UNIT DESCR (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for BUSINESS UNIT DESCR';
                   END IF;
              GOTO PRINT_ERROR;
          END;

               dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_CODE/text()',vPoornata_ID);

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'Name_Display/text()',vName_Display);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Name Display (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for Name Display From should be date';
                   END IF;
              GOTO PRINT_ERROR;
          END;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'Designation/text()',vDesignation);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Designation (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for Designation';
                   END IF;
              GOTO PRINT_ERROR;
          END;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'Location/text()',vLocation);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Location (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for Location';
                   END IF;
              GOTO PRINT_ERROR;
          END;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'Currency_Cd/text()',vCurrency_Cd);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Currency Cd (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for Currency Cd';
                   END IF;
              GOTO PRINT_ERROR;
          END;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'EFF_FROM_DATE/text()',pEffective_Date); 
               vEffective_Date:=TO_DATE(pEffective_Date,'MM/DD/YYYY');
--INSERT INTO OSO VALUES(vEffective_Date);
--COMMIT;
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Effective Date,it must be a date';
                      vERROR_FLAG:='Y';
                   ELSE

                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for Effective Date';
                   END IF;
              GOTO PRINT_ERROR;
          END;

          BEGIN
               dbms_xslprocessor.valueOf(vXmlDOMNode,'ACTION/text()',vAudit_Action);
          EXCEPTION
              WHEN OTHERS THEN
                   IF SQLCODE ='-24331' THEN
                      vERROR_MSG:='Invalid value for Audit Action (Max limit is 50 character)';
                      vERROR_FLAG:='Y';
                   ELSE
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid value for Audit Action';
                   END IF;
              GOTO PRINT_ERROR;
          END;

               dbms_xslprocessor.valueOf(vXmlDOMNode,'ALLOWANCE/text()',vALLOWANCE);
               dbms_xslprocessor.valueOf(vXmlDOMNode,'AMOUNT/text()',pAmount);

               vAmount:=TO_NUMBER(pAmount);

            IF VPAYGROUP IS NULL THEN
                vERROR_FLAG:='Y';
                vERROR_MSG:='Paygroup '||VPAYGROUP||' is not mapped with any of the entity';
                GOTO PRINT_ERROR;
            END IF;
            
              OPEN CURREC for
                  SELECT COMP_ID,COMP_MID,'DBLINK_ABG_OP_ABGHINDALCO_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                  WHERE  BUSINESS_NATURE_ID=vPaygroup
                  UNION ALL
                  SELECT COMP_ID,COMP_MID,'DBLINK_ABG_OP_BIRLACHEM_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                  WHERE  BUSINESS_NATURE_ID=vPaygroup
                  UNION ALL
                  SELECT COMP_ID,COMP_MID,'ABGGROUP' 
                  FROM GM_COMP
                  WHERE  BUSINESS_NATURE_ID=vPaygroup;
                FETCH CURREC INTO VCOMP_ID,vComp_Mid,VDBLINK_NAME;
              CLOSE  CURREC;
            
           IF VDBLINK_NAME IS NULL THEN  
                vERROR_FLAG:='Y';
                vERROR_MSG:='Unable to track employee '||vPoornata_ID||  ' group company';
                GOTO PRINT_ERROR;
           END IF;  
    

            IF vPoornata_ID IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:=' Poornata ID should not be blank';
               GOTO PRINT_ERROR;
            END IF;

           IF vEffective_Date IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='  Effective Date should not be blank';
               GOTO PRINT_ERROR;
           END IF;

           IF vAudit_Action IS NULL THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:=' Audit Action should not be blank';
               GOTO PRINT_ERROR;
           END IF;

--           IF vChkRecordCount =0 THEN
--               vERROR_FLAG:='Y';
--               vERROR_MSG:='Invalid Monthly Amount';
--               GOTO PRINT_ERROR;
--           END IF;


         IF VDBLINK_NAME='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN  
              open CURREC for
                  SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                  WHERE EMP_MID=VPOORNATA_ID
                  AND COMP_ID=VCOMP_ID;
                  FETCH CURREC INTO vEMP_ID;
              CLOSE  CURREC;  
          ELSIF VDBLINK_NAME='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN      
              open CURREC for
                  SELECT emp_id
                   FROM GM_ATTRIBUTE@DBLINK_ABG_OP_BIRLACHEM_UAT A,PM_SUB_ATTRIBUTE@DBLINK_ABG_OP_BIRLACHEM_UAT B,PM_EMP_ATTRIBUTE@DBLINK_ABG_OP_BIRLACHEM_UAT C,
                   GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT D,GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT E
                   where a.attb_aid=b.attB_aid AND A.COMP_AID=B.COMP_AID
                   AND b.attB_aid=C.attB_aid AND B.SUB_ATTB_AID=C.SUB_ATTB_AID AND B.COMP_AID=C.COMP_AID
                   AND C.EMP_AID=D.EMP_ID AND D.COMP_ID=E.COMP_ID
                   AND a.attb_mid='PID' AND ATTB_VALUE=VPOORNATA_ID AND a.COMP_aID=VCOMP_ID; 
                  FETCH CURREC INTO vEMP_ID;
              CLOSE  CURREC;  
          ELSE 
              open CURREC for
                  SELECT EMP_ID FROM GM_EMP
                  WHERE EMP_MID=VPOORNATA_ID
                  AND COMP_ID=VCOMP_ID;
                  FETCH CURREC INTO vEMP_ID;
              CLOSE  CURREC;  
          END IF; 
           
           
            insert into int_check values (' emp_check--:--  '||VDBLINK_NAME||' '||pComp_Aid||' '||vPoornata_ID||' '||vEMP_ID);
            COMMIT;
            
             IF vEMP_ID IS NULL THEN
                  vERROR_FLAG:='Y';
                  vERROR_MSG:='Poornata id '||vPoornata_ID||' does not exist';
                  GOTO PRINT_ERROR;
             END IF;
             
             
       IF VDBLINK_NAME='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN  
           SELECT TO_DATE(JOIN_DATE,'DD-MM-RRRR') INTO V_JOIN_DATE  
           FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT WHERE UPPER(TRIM(COMP_ID))= UPPER(TRIM(VCOMP_ID)) 
           AND  UPPER(TRIM(EMP_ID))=UPPER(TRIM(vEMP_ID));
       ELSIF VDBLINK_NAME='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN    
           SELECT TO_DATE(JOIN_DATE,'DD-MM-RRRR') INTO V_JOIN_DATE  
           FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT WHERE UPPER(TRIM(COMP_ID))= UPPER(TRIM(VCOMP_ID)) 
           AND  UPPER(TRIM(EMP_ID))=UPPER(TRIM(vEMP_ID));
       ELSE
           SELECT TO_DATE(JOIN_DATE,'DD-MM-RRRR') INTO V_JOIN_DATE  
           FROM GM_EMP WHERE UPPER(TRIM(COMP_ID))= UPPER(TRIM(VCOMP_ID)) 
           AND  UPPER(TRIM(EMP_ID))=UPPER(TRIM(vEMP_ID));
       END IF;


       IF VDBLINK_NAME='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN
          OPEN curRec FOR
              SELECT MAX(CTC_CODE),MAX(CTC_MID) FROM CTC_ALLOWANCE_MAST@DBLINK_ABG_OP_ABGHINDALCO_UAT
                WHERE CTC_CLIENT_CODE=vALLOWANCE;
              FETCH curRec INTO varCTC_CODE,varCTC_MID;
          CLOSE curRec;
       ELSIF VDBLINK_NAME='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN   
           OPEN curRec FOR
              SELECT MAX(CTC_CODE),MAX(CTC_MID) FROM CTC_ALLOWANCE_MAST@DBLINK_ABG_OP_BIRLACHEM_UAT
                WHERE CTC_CLIENT_CODE=vALLOWANCE;
              FETCH curRec INTO varCTC_CODE,varCTC_MID;
          CLOSE curRec; 
       ELSE   
           OPEN curRec FOR
              SELECT MAX(CTC_CODE),MAX(CTC_MID) FROM CTC_ALLOWANCE_MAST
                WHERE CTC_CLIENT_CODE=vALLOWANCE;
              FETCH curRec INTO varCTC_CODE,varCTC_MID;
          CLOSE curRec; 
       END IF;


              IF( TO_DATE(vEffective_Date,'DD-MM-RRRR' ) <TO_DATE( V_JOIN_DATE,'DD-MM-RRRR') ) THEN
                 vERROR_FLAG:='Y';
                 vERROR_MSG:='Effective From Date should be greater than/equal to Join Date';
                 GOTO PRINT_ERROR;
              END IF;

               IF UPPER(vALLOWANCE)='FIXED COMPENSATION' THEN
                   vEMP_CTC_ID:=FN_GENERATE_AID_INTEGRATION(VCOMP_ID, I+1,vALLOWANCE,VDBLINK_NAME);---CREATED BY ANISH BHOIL ON 20TH FEB 2020, FOR 3 IN 1 CONCEPT.
               END IF;

               CTC_ALLOWANCE_WISE_INSERT_DATA(vUpldBatch_Id,pSessionId,pUser_Aid,pUpload_Aid,VCOMP_ID,vEMP_ID,vALLOWANCE,vAmount,vEMP_CTC_ID,vEffective_Date,pAcc_Year,vERROR_FLAG,vERROR_MSG,VDBLINK_NAME);   
                   IF vERROR_FLAG='Y' THEN
                      GOTO PRINT_ERROR;
                   END IF;
                /*Inserting Uploaded data in Insertable format*/
    IF NVL(vERROR_FLAG,'N')='N' THEN

       INSERT INTO HR_PM_FINAL_UPLOAD_DATA(UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID,UPLOAD_DATE,ROW_NO,
       COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12)
       SELECT UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID,SYSDATE,ROWCOUNT,CTCAMOUNT,EMP_CTC_ID, COMP_ID,
       EMP_ID,EFF_DATE_FR,ACC_YEAR,NULL AMOUNT,ROWNUM,NULL ALLWDED_AID,NULL MONTH_AMT,vPoornata_ID,VDBLINK_NAME--ADDED DBLINK IN TABLE BY ANISH BHOIL ON 20TH FEB 2020. FOR 3 IN 1 CONCEPT.
       FROM (SELECT EMP_CTC_ID,COMP_ID,EMP_ID,EFF_DATE_FR,ACC_YEAR,CTCAMOUNT,UPLOAD_BATCH_ID, SESSION_ID, USER_AID, UPLOAD_AID ,ROWNUM ROWCOUNT
       FROM TEMP_PM_EMP_CTC_DEFINE WHERE EMP_ID=vEMP_ID AND COMP_ID=VCOMP_ID AND ACC_YEAR=pAcc_Year AND UPLOAD_BATCH_ID=vUpldBatch_Id
       AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND UPLOAD_AID=pUpload_Aid AND EMP_CTC_ID=vEMP_CTC_ID);

          OPEN curRec FOR
          SELECT MAX(EMP_CTC_ID) FROM TEMP_PM_EMP_CTC_DEFINE WHERE EMP_ID=vEMP_ID AND COMP_ID=VCOMP_ID;
          FETCH curRec INTO vEMP_CTC_ID;
          CLOSE curRec;     

       INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID,USER_AID,UPLOAD_AID, UPLOAD_DATE, ROW_NO,
       COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12)
       SELECT UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID,SYSDATE,I+1,
       NULL,EMP_CTC_ID, COMP_ID,EMP_ID,Effective_Date,Acc_Year,AMOUNT,ROWNUM,ALLWDED_AID,MONTH_AMT,vPoornata_ID,DBLINK
       FROM ( SELECT EMP_CTC_ID,COMP_ID,EMP_ID,vEffective_Date Effective_Date,pAcc_Year Acc_Year,AMOUNT,
       ALLWDED_AID,MONTH_AMT,UPLOAD_BATCH_ID, SESSION_ID, USER_AID, UPLOAD_AID,VDBLINK_NAME DBLINK
       FROM TEMP_PT_EMP_CTC_DEFINE ---PT_EMP_CTC--
       WHERE EMP_ID=vEMP_ID AND COMP_ID=VCOMP_ID AND ALLWDED_AID=varCTC_CODE  AND UPLOAD_BATCH_ID=vUpldBatch_Id
       AND SESSION_ID=pSessionId AND USER_AID=pUser_Aid AND UPLOAD_AID=pUpload_Aid AND EMP_CTC_ID=vEMP_CTC_ID);

    END IF;

      <<PRINT_ERROR>>
       /*Inserting Uploaded data as it is in Upload File*/
        INSERT INTO HR_TEMP_RAW_UPLOAD_NEW (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG, ROW_NO,
        COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,COL21,COL22,COL23,COL24,COL25,
        COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41, COL42,COL43,COL44,COL45,COL46,COL47,COL48,
        COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,COL60,COL61,COL62,COL63,COL64,COL65,COL66)
        VALUES(vUpldBatch_Id,pSessionId,pUser_Aid,pUpload_Aid,SYSDATE,vERROR_FLAG,vERROR_MSG,I+2,
        vPoornata_ID,vName_Display,vComp_Mid,vPaygroup,vEffective_Date,vAudit_Action,varCTC_MID,pAmount,
        vCOUNTRY,vBUSINESS_DESCR,vBUSINESS_UNIT_DESCR,vDesignation,vLocation,vCurrency_Cd,
        VDBLINK_NAME,null,null,null,null,null,null,null,null,null,null,null,null,
        null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
        null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
    END LOOP;

      INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);
      FOR I IN (SELECT  TRANS_TYPE,COMP_ID,EMP_CTC_ID,EMP_ID,EFF_DATE_FR,CTCAMOUNT,ACC_YEAR,'US000000' USER_CR,SYSDATE DATE_CR,NULL USER_UP,NULL DATE_UP,EMP_DBLINK
                FROM (SELECT DISTINCT A.TRANS_TYPE,A.COL3 COMP_ID,A.COL2 EMP_CTC_ID,A.COL4 EMP_ID,A.COL5 EFF_DATE_FR,
                B.CTCAMOUNT CTCAMOUNT,A.COL6 ACC_YEAR,A.COL11 EMP_MID,A.UPLOAD_BATCH_ID,A.SESSION_ID,A.USER_AID,A.UPLOAD_AID,COL12 EMP_DBLINK
                FROM HR_PM_VW_FINAL_UPLOAD_DATA A,TEMP_PM_EMP_CTC_DEFINE B WHERE A.UPLOAD_BATCH_ID=B.UPLOAD_BATCH_ID
                AND A.SESSION_ID=B.SESSION_ID AND A.USER_AID=B.USER_AID AND A.UPLOAD_AID=B.UPLOAD_AID AND A.COL4=B.EMP_ID
                AND A.COL2=B.EMP_CTC_ID AND A.COL3=B.COMP_ID AND A.UPLOAD_BATCH_ID =vUpldBatch_Id AND A.SESSION_ID =pSessionId
                AND A.USER_AID =pUser_Aid AND A.UPLOAD_AID =pUpload_Aid AND A.STATUS = 'PENDING')
                WHERE EMP_MID NOT IN (SELECT COL4 FROM HR_TEMP_RAW_UPLOAD_NEW WHERE  UPLOAD_BATCH_ID =vUpldBatch_Id
                AND SESSION_ID =pSessionId AND USER_AID =pUser_Aid AND UPLOAD_AID =pUpload_Aid AND ERROR_FLAG='Y'))
      LOOP
          IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD','UPDATE') THEN
             
              IF  I.EMP_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN
                                 
                UPDATE PM_EMP_CTC_DEFINE@DBLINK_ABG_OP_ABGHINDALCO_UAT SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR')-1,REMARKS='ADDED THROUGH INTEGRATION ON '||SYSDATE
                WHERE COMP_ID = I.COMP_ID  AND EMP_ID = I.EMP_ID AND (EFF_DATE_TO IS NULL OR EFF_DATE_TO>=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR'));
          
                INSERT INTO PM_EMP_CTC_DEFINE@DBLINK_ABG_OP_ABGHINDALCO_UAT (COMP_ID, EMP_CTC_ID, EMP_ID, EFF_DATE_FR,CTCAMOUNT, ACC_YEAR ,USER_CR,DATE_CR,REMARKS)
                VALUES(I.COMP_ID, I.EMP_CTC_ID, I.EMP_ID, TO_DATE(I.EFF_DATE_FR) ,I.CTCAMOUNT,I.ACC_YEAR,I.USER_CR ,I.DATE_CR,'ADDED THROUGH INTEGRATION ON '||SYSDATE);
            
              ELSIF  I.EMP_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN   
             
                UPDATE PM_EMP_CTC_DEFINE@DBLINK_ABG_OP_BIRLACHEM_UAT SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR')-1,REMARKS='ADDED THROUGH INTEGRATION ON '||SYSDATE
                WHERE COMP_ID = I.COMP_ID  AND EMP_ID = I.EMP_ID AND (EFF_DATE_TO IS NULL OR EFF_DATE_TO>=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR'));
          
                INSERT INTO PM_EMP_CTC_DEFINE@DBLINK_ABG_OP_BIRLACHEM_UAT (COMP_ID, EMP_CTC_ID, EMP_ID, EFF_DATE_FR,CTCAMOUNT, ACC_YEAR ,USER_CR,DATE_CR,REMARKS)
                VALUES(I.COMP_ID, I.EMP_CTC_ID, I.EMP_ID, TO_DATE(I.EFF_DATE_FR) ,I.CTCAMOUNT,I.ACC_YEAR,I.USER_CR ,I.DATE_CR,'ADDED THROUGH INTEGRATION ON '||SYSDATE);
              ELSE
                UPDATE PM_EMP_CTC_DEFINE SET EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR')-1,REMARKS='ADDED THROUGH INTEGRATION ON '||SYSDATE
                WHERE COMP_ID = I.COMP_ID  AND EMP_ID = I.EMP_ID AND (EFF_DATE_TO IS NULL OR EFF_DATE_TO>=TO_DATE(I.EFF_DATE_FR,'DD-MM-RRRR'));
          
                INSERT INTO PM_EMP_CTC_DEFINE (COMP_ID, EMP_CTC_ID, EMP_ID, EFF_DATE_FR,CTCAMOUNT, ACC_YEAR ,USER_CR,DATE_CR,REMARKS)
                VALUES(I.COMP_ID, I.EMP_CTC_ID, I.EMP_ID, TO_DATE(I.EFF_DATE_FR) ,I.CTCAMOUNT,I.ACC_YEAR,I.USER_CR ,I.DATE_CR,'ADDED THROUGH INTEGRATION ON '||SYSDATE);
              END IF;
              
           END IF;
     END LOOP;

     FOR I IN ( SELECT DATE_CR,USER_CR,TRANS_TYPE,EMP_CTC_ID,ROW_NUMBER() OVER (PARTITION BY EMP_CTC_ID ORDER BY ALLWDED_AID ) SR_NO,
                ALLWDED_AID,MONTH_AMT,CTCAMOUNT,COMP_ID,EM_DBLINK FROM (SELECT TRANS_TYPE,COL3 COMP_ID,COL2 EMP_CTC_ID,COL4 EMP_ID,COL9 ALLWDED_AID,
                COL5 EFF_DATE_FR,COL10 MONTH_AMT,COL7 CTCAMOUNT,COL6 ACC_YEAR,COL11 EMP_MID,pUser_Aid USER_CR,SYSDATE DATE_CR,COL12 EM_DBLINK,
                pUser_Aid USER_UP,SYSDATE DATE_UP FROM HR_PT_VW_FINAL_UPLOAD_DATA WHERE UPLOAD_BATCH_ID=vUpldBatch_Id
                AND SESSION_ID=pSessionId AND USER_AID=pUSER_AID AND UPLOAD_AID=pUpload_Aid AND STATUS='PENDING')
                WHERE EMP_MID NOT IN (SELECT COL4 FROM HR_TEMP_RAW_UPLOAD_NEW WHERE UPLOAD_BATCH_ID=vUpldBatch_Id 
                AND SESSION_ID=pSessionId AND USER_AID=pUSER_AID AND UPLOAD_AID=pUpload_Aid AND ERROR_MSG IS NOT NULL))
      LOOP
          IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD','UPDATE') THEN
                 
              IF   I.EM_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN   
                 INSERT INTO PT_EMP_CTC_DEFINE@DBLINK_ABG_OP_ABGHINDALCO_UAT ( EMP_CTC_ID, SRNO, ALLWDED_AID, MONTH_AMT,AMOUNT,COMP_ID,USER_CR,DATE_CR )
                 VALUES(I.EMP_CTC_ID,I.SR_NO,I.ALLWDED_AID,I.MONTH_AMT,I.CTCAMOUNT,I.COMP_ID,I.USER_CR,I.DATE_CR);
              ELSIF   I.EM_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN    
                 INSERT INTO PT_EMP_CTC_DEFINE@DBLINK_ABG_OP_BIRLACHEM_UAT ( EMP_CTC_ID, SRNO, ALLWDED_AID, MONTH_AMT,AMOUNT,COMP_ID,USER_CR,DATE_CR )
                 VALUES(I.EMP_CTC_ID,I.SR_NO,I.ALLWDED_AID,I.MONTH_AMT,I.CTCAMOUNT,I.COMP_ID,I.USER_CR,I.DATE_CR);
               ELSE  
                 INSERT INTO PT_EMP_CTC_DEFINE ( EMP_CTC_ID, SRNO, ALLWDED_AID, MONTH_AMT,AMOUNT,COMP_ID,USER_CR,DATE_CR )
                 VALUES(I.EMP_CTC_ID,I.SR_NO,I.ALLWDED_AID,I.MONTH_AMT,I.CTCAMOUNT,I.COMP_ID,I.USER_CR,I.DATE_CR);
               END IF;  
               
          END IF;
      COMMIT;
      END LOOP;
      COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);
      COMMIT;
      OPEN Return_Recordset FOR
           SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'SUCCESS:: Data commited successfully' ErrMessage FROM DUAL;
      EXCEPTION
            WHEN DBLINK_NOT_TRACED THEN
               HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PT_EMP_CTC_DEFINE' ,'UNABLE TO TRACK DBLINK OR TRANSFER COMPANY FOR EMPLOYEE ' ||vPoornata_ID||' '||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()); 
            WHEN OTHERS THEN ROLLBACK;
                HR_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'HR_PK_STANDARD_UPLOAD.UPLOAD_PT_EMP_CTC_DEFINE' ,SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
      OPEN Return_Recordset FOR
           SELECT 1 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'Commit Failed!' ErrMessage FROM DUAL;
      END PRO_UPLOAD_EMP_CTC;


    PROCEDURE PRO_UPLOAD_LOAN_DISBURSEMENT(pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS

    TYPE refCUR IS REF CURSOR;
    curRec                      refCUR;
    TEMP_CUR                    refCUR;
    cRes                        refCUR;
    cOUT_TEMP                   refCUR;
    vXmlParser                  dbms_xmlparser.Parser;
    vXmlDomDocument             dbms_xmldom.DOMDocument;
    vXmlDOMNodeList             dbms_xmldom.DOMNodeList;
    vXmlDOMNode                 dbms_xmldom.DOMNode;
    vERROR_MSG                  VARCHAR2(2000);
    vERROR_FLAG                 VARCHAR2(1);
    vChkRecordCount             NUMBER;
    vUpldBatch_Id               PY_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;


    vBRAND_NAME                 PY_GM_COMP.BRAND_NAME%TYPE;
    vPOORNATA_ID                VARCHAR2(20);
    vEFFECTIVE_DATE             VARCHAR2(20);
    vComp_Aid                   PY_GM_COMP.COMP_ID%TYPE;
    vEmp_Aid                    PY_LT_LOAN_DISBURSE.EMP_AID%TYPE;
    vLOAN_AID                   PY_LT_LOAN_DISBURSE.LOAN_AID%TYPE;
    vBacth_Id                   PY_LT_LOAN_DISBURSE.BATCH_ID%TYPE;
    vloan_Ref_no                VARCHAR2(50);
    vloan_Acc_No                PY_LT_LOAN_DISBURSE.LOAN_ACCT_NO%TYPE;
    vLOAN_MID                   PY_GM_LOAN_TYPE.LOAN_MID%TYPE;
    vcomp_mid                   py_gm_comp.comp_mid%type;
    vEMP_MID                    VARCHAR(10);
--    vEMP_MID                    PY_GM_EMPMAST.EMP_MID%TYPE;
    vInterest_rate              PY_LT_LOAN_DISBURSE.INT_RATE%TYPE;
    vStd_interest_rate          PY_LT_LOAN_DISBURSE.STD_INT_RATE%TYPE;
    vLoan_taken_date            VARCHAR2(50);
--    vDeduction_start_month      PY_LT_LOAN_DISBURSE.DED_START_MONTH%TYPE;
    vDeduction_start_month      VARCHAR(8);
    --vLoan_taken_mode            PY_LT_LOAN_DISBURSE.LOAN_MODE%TYPE;
    vLoan_taken_mode            VARCHAR2(20);
    vlOAN_TAKEN_MODE_ID         VARCHAR(40);
    vDDCheque_no                PY_LT_LOAN_DISBURSE.DD_CHQ_NO%TYPE;
    vDDCheque_Date              PY_LT_LOAN_DISBURSE.DD_CHQ_DATE%TYPE;
    vLoanAmount                 PY_LT_LOAN_DISBURSE.AMOUNT%TYPE;
    vEmiAmount                  PY_LT_LOAN_DISBURSE.EMI_AMOUNT%TYPE;
    vPriAmount                  PY_LT_LOAN_DISBURSE.PRI_AMOUNT%TYPE;
    vInterestAmount             PY_LT_LOAN_DISBURSE.INT_AMOUNT%TYPE;
    vPARA_GRP_MID               PY_GM_PARAMETER_GRPS.PARA_GRP_MID%TYPE DEFAULT 'LOANMODE';
    vEFF_DATE_FR                VARCHAR2(100);
    vEFF_DATE_TO                VARCHAR2(100);
    vChkCarCost                 VARCHAR2(100);
    vChkDupVehi                 VARCHAR2(100);
    vACTIVE_INACTIVE_PARA       VARCHAR2(100);
    vLOAN_TYPE                  VARCHAR2(200);
    vNO_OF_EMI                  VARCHAR2(200);

     BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

--            insert into VAICLOB(ABC, UPLOAD_AID) values(pRawXmlData,pUpload_Aid);
--            COMMIT;            
            vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

              FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vComp_Aid := NULL; vEmp_Aid := NULL; vLOAN_AID := NULL; vBacth_Id := NULL; vloan_Ref_no := NULL; vloan_Acc_No := NULL; vLOAN_MID := NULL;
                vCOMP_MID := NULL; vEMP_MID := NULL; vInterest_rate := NULL; vStd_interest_rate := NULL; vLoan_taken_date := NULL;
                vDeduction_start_month := NULL; vLoan_taken_mode := NULL; vlOAN_TAKEN_MODE_ID := NULL; vDDCheque_no := NULL;
                vDDCheque_Date := NULL; vLoanAmount := NULL; vEmiAmount := NULL; vPriAmount := NULL; vInterestAmount := NULL;
                vEFF_DATE_FR := NULL; vEFF_DATE_TO := NULL; vChkCarCost := NULL; vChkDupVehi := NULL; vBRAND_NAME:=NULL;
                vEFFECTIVE_DATE := NULL; vPOORNATA_ID := NULL; vLOAN_TYPE:= NULL; vNO_OF_EMI := NULL;

                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';



                ------------------------------------------------company code
                  BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'BRAND_NAME/text()',vBRAND_NAME);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Brand Name(Max limit is 500 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Brand Name';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;



                    begin
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'POORNATA_ID/text()',vPOORNATA_ID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Poornata ID (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Poornata ID';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;


                       BEGIN
                           dbms_xslprocessor.valueOf(vXmlDOMNode,'LOAN_TYPE/text()',vLOAN_TYPE);
                      EXCEPTION
                       WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Loan Type (Max limit is 8 character)';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Loan Type ';
                           END IF;
                      GOTO PRINT_ERROR;
                     END;



                   --vInterestRate
                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'INTEREST_RATE/text()',vInterest_rate    );
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Interest Rate (Max limit is 8 character)';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Interest Rate ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;




                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'STD_INTEREST_RATE/text()',vStd_interest_rate);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Standard Interest Rate (Max limit is 8 character)';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Standard Interest Rate ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;


                   BEGIN
                             dbms_xslprocessor.valueOf(vXmlDOMNode,'LOAN_AMOUNT/text()',vLoanAmount);
                         EXCEPTION
                          WHEN OTHERS THEN
                               IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid Value For Loan Amount (Max limit is 18 character)';
                                vERROR_FLAG:='Y';
                               ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid Value For Loan Amount ';
                               END IF;
                          GOTO PRINT_ERROR;
                        END;


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'LOAN_TAKEN_DATE/text()',vLoan_taken_date);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Loan Taken Date';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Loan Taken Date';
                           END IF;
                      GOTO PRINT_ERROR;
                END;



                  -- Deduction_start_month
                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_PREPAYMENT_DATE/text()',vEFFECTIVE_DATE);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Deduction Start Month(Valid deduction start month format: MMM YYYY)';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Deduction Start Month(valid deduction start month format: MMM YYYY)';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;

                    ---------------------------------------No of EMI----------------------------------------------------------------
                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'NUMBER_OF_EMI/text()',vNO_OF_EMI);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Number of EMI';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Number of EMI';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;


                    HR_PK_VALIDATION.PROC_GET_COMP_CODE( vBRAND_NAME, vComp_Aid, vCOMP_MID);

                    IF vCOMP_MID IS NULL THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Company Code cannot be blank';
                       GOTO PRINT_ERROR;
                    END IF;


                    vEmp_Aid:=HR_PK_VALIDATION.FN_GET_POORNATA_EMP_AID(vComp_Aid, vPOORNATA_ID);

                    vDeduction_start_month := TO_CHAR(TO_DATE(vEFFECTIVE_DATE,'MM/DD/YYYY'),'MON YYYY');


                    IF vInterest_rate IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Interest Rate cannot be blank';
                     GOTO PRINT_ERROR;
                    END IF;

                    IF vStd_interest_rate IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Standard Interest Rate cannot be blank';
                     GOTO PRINT_ERROR;
                    END IF;


                    IF vLoan_taken_date IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Loan Taken Date cannot be blank';
                     GOTO PRINT_ERROR;
                    END IF;


                    IF vDeduction_start_month IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Deduction Start Month cannot be blank';
                     GOTO PRINT_ERROR;
                    END IF;


                    IF vLoanAmount IS NULL THEN
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Loan Amount should not be blank';
                      GOTO PRINT_ERROR;
                    END IF;

                    IF vComp_Aid IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Company '||vBRAND_NAME||' does not exist';
                        GOTO PRINT_ERROR;
                    END IF;



                    IF vEMP_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Employee Code 4'||vPOORNATA_ID||' Does Not Exist';
                        GOTO PRINT_ERROR;
                    END IF;

                ---loan code

                    vLOAN_AID:= PY_PK_VALIDATION.FN_GET_LOAN_DESC_AID(vComp_Aid,vLOAN_TYPE);

                    IF vLOAN_AID IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Loan Code '''||vLOAN_TYPE||''' does not exist';
                     Goto Print_Error;
                    END IF;


                   -----------------------------------------interest rate -----------


                  IF PY_PK_VALIDATION.FN_IS_NUMBER(TRIM(vInterest_rate))=0 THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid Interest Rate';
                        GOTO PRINT_ERROR;
                  END IF;
                     ----------------------------------------------Standard Interest rate-------

                 IF PY_PK_VALIDATION.FN_IS_NUMBER(TRIM(vStd_interest_rate))=0 THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Invalid Interest Rate';
                       GOTO PRINT_ERROR;
                 END IF;

                vLoan_taken_date:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vLoan_taken_date));


                ------------------------------Deduction Start Month

                IF PY_PK_VALIDATION.FN_IS_PAYMONTH(vDeduction_start_month)=0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Deduction Start Month(Valid Deduction Start  Month format: MMM YYYY)';
                    Goto Print_Error;
                 END IF;


                  IF  TO_DATE(vLoan_taken_date,'DD-MON-YYYY') > TO_DATE(01||vDeduction_start_month) THEN
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Deduction start month must be greater than Loan taken Date';
                      GOTO PRINT_ERROR;
                  END IF;

                  IF PY_PK_VALIDATION.FN_IS_NUMBER(TRIM(vLoanAmount))=0 THEN
                      vERROR_FLAG:='Y';
                      vERROR_MSG:='Invalid Loan Amount';
                      Goto Print_Error;
                  END IF;

                    ----------------------------------------Emi Amount------------------------
                  vEmiAmount:=vLoanAmount/vNO_OF_EMI;

                      -----------------------------------Interest Amount-----------------------
                   IF PY_PK_VALIDATION.FN_IS_NUMBER(TRIM(vInterestAmount))=0 THEN
                          vERROR_FLAG:='Y';
                          vERROR_MSG:='Invalid Interest Amount';
                          GOTO PRINT_ERROR;
                   END IF;

                -- Checking duplicate data exist or not
                OPEN curRec FOR
                   SELECT COUNT(*)  FROM HR_TEMP_RAW_UPLOAD
                    WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                            AND UPPER(TRIM(COL1)) = UPPER(TRIM(vCOMP_MID)) and UPPER(TRIM(COL2))=UPPER(TRIM(vPOORNATA_ID))
                            AND UPPER(TRIM(COL3))=UPPER(TRIM(vLOAN_MID));
                 FETCH curRec INTO vChkRecordCount;
                 CLOSE  curRec;

                 IF vChkRecordCount > 0 THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Duplicate records found!';
                     GOTO PRINT_ERROR;
                 END IF;


                    /*Inserting Uploaded data in Insertable format*/
                    IF NVL(vERROR_FLAG,'N')='N' THEN

                      INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,
                                   ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9)
                      VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid,SYSDATE
                                   ,I+2,vComp_Aid,vEmp_Aid,vLOAN_AID,vInterest_rate,vStd_interest_rate,vLoan_taken_date,vDeduction_start_month
                                   ,vLoanAmount,vEmiAmount);
                    END IF;

                    <<PRINT_ERROR>>
                    /*Inserting Uploaded data as it is in Upload File*/
                    INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,
                    ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE , vERROR_FLAG,vERROR_MSG,
                    I+2, vCOMP_MID,vPOORNATA_ID,vLOAN_MID,vInterest_rate,vStd_interest_rate,vLoan_taken_date,vDeduction_start_month
                    ,vLoanAmount,vNO_OF_EMI);


                 END LOOP;
               --Inserting Upload Summary
             INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , pTrans_Type , vUpldBatch_Id);

--         ELSE


                 --Final data insert in base table PY_LT_LOAN_DISBURSE
              FOR I IN (SELECT  COL1 COMP_AID, COL2 EMP_AID, COL3 LOAN_AID,COL4 INT_RATE,COL5 STD_INT_RATE,COL6 LOAN_DATE,COL7 DED_START_MONTH
                       ,COL8 AMOUNT,COL9 EMI_AMOUNT, 'PS007615' LOAN_MODE
                       ,pUser_Aid USER_CR,BATCH_ID
                        FROM HR_PT_FINAL_UPLOAD_DATA
                        WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId)

                LOOP
--                     IF I.TRANS_TYPE IN ('REMOVE AND ADD','ADD') THEN


                      vloan_Ref_no:=PY_PK_VALIDATION.GET_LOANREFNO(I.COMP_AID,I.EMP_AID,I.LOAN_AID);



                        INSERT INTO HR_LT_LOAN_DISBURSE(COMP_AID,ACC_YEAR,LOAN_AID,EMP_AID,LOAN_REF_NO,LOAN_DATE,LOAN_MODE,
                                                        DED_START_MONTH,AMOUNT,EMI_AMOUNT,PRI_AMOUNT,
                                                        INT_RATE,STD_INT_RATE,
                                                         BATCH_ID, USER_CR,DATE_CR, USER_UP, DATE_UP,USER_AT,DATE_AT)
                          VALUES (I.COMP_AID,pAcc_Year ,I.LOAN_AID,I.EMP_AID,vloan_Ref_no,I.LOAN_DATE,I.LOAN_MODE,
                                  I.DED_START_MONTH,I.AMOUNT,I.EMI_AMOUNT,I.EMI_AMOUNT,I.INT_RATE,I.STD_INT_RATE
                                  ,I.BATCH_ID,I.USER_CR,SYSDATE,I.USER_CR,SYSDATE,I.USER_CR,SYSDATE);


--                       PY_PCK_LOAN_MODULE.PY_CALL_GENERATE_LOAN_SCHEDULE(I.COMP_AID,pAcc_Year,I.EMP_AID,I.LOAN_AID,vloan_Ref_no,I.USER_CR,'TRANSACTION',null,null,null,null,null);




--                    END IF;

                END LOOP;


               COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);


         END IF;

          OPEN Return_Recordset FOR
                SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

          COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                vERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPLOAD_LOAN_DISBURSEMENT' ,vERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,vERROR_MSG ErrMessage  FROM DUAL;


    END;

PROCEDURE PROC_UPLOAD_RENT (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                    refCUR;

    vXmlParser                dbms_xmlparser.Parser;
    vXmlDomDocument           dbms_xmldom.DOMDocument;
    vXmlDOMNodeList           dbms_xmldom.DOMNodeList;
    vXmlDOMNode               dbms_xmldom.DOMNode;
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vChkUpdateRecord          NUMBER;
    vUpldBatch_Id             PY_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    vComp_Aid                 PY_GM_COMP.COMP_ID%TYPE;
    vEmp_Aid                  PY_PT_ARR_DT.EMP_AID%TYPE;
    vAllwded_Aid              PY_PT_ARR_DT.ALLWDED_AID%TYPE;
    vBacth_Id                 PY_PM_MONTH_STATUS.BATCH_ID%TYPE;
    vOpen_Pay_Month           PY_PM_MONTH_STATUS.Pay_Month%TYPE;
    vCOMP_MID                 PY_GM_COMP.COMP_MID%TYPE;
    vEMP_MID                  PY_GM_EMPMAST.EMP_MID%TYPE;
    vPAY_MONTH                HR_PT_RENT.PAY_MONTH%TYPE;
    vEFF_FR_DATE              VARCHAR2(100);
    vEFF_TO_DATE              VARCHAR2(100);
    vDEC_AMOUNT               VARCHAR2(12);
    vSUP_AMOUNT               VARCHAR2(12);
    vPROM_AMT                 VARCHAR2(12);
    vLOC_MID                  VARCHAR2(20);
    vMETRO_FLAG               HR_PT_RENT.METRO_YN%TYPE;
    vLoc_Aid                  HR_PT_RENT.Loc_Aid%TYPE;
    vRENT_TYPE                PY_GM_PARAMETERS.PAR_AID%TYPE;
    vREMARKS                  HR_PT_RENT.REMARKS%TYPE;
    vMaxSRNO                  NUMBER;
    vBRAND_NAME               PY_GM_COMP.BRAND_NAME%TYPE;
    vPOORNATA_ID              VARCHAR2(20); 
    vTYPE_OF_CHANGE           VARCHAR2(100);



    BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

        --  insert into VAICLOB(ABC, UPLOAD_AID) values(pRawXmlData,pUpload_Aid);
      --    COMMIT;
            vUpldBatch_Id := PY_PK_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vComp_Aid := NULL; vEmp_Aid := NULL; vAllwded_Aid := NULL; vBacth_Id := NULL; vOpen_Pay_Month := NULL; vCOMP_MID := NULL; vEMP_MID := NULL;
                vPAY_MONTH := NULL; vEFF_FR_DATE := NULL; vEFF_TO_DATE := NULL; vDEC_AMOUNT := NULL; vSUP_AMOUNT := NULL; vPROM_AMT := NULL; vLOC_MID := NULL;
                vMETRO_FLAG := NULL; vLoc_Aid := NULL; vRENT_TYPE := NULL; vREMARKS := NULL; vPOORNATA_ID := NULL; vBRAND_NAME := NULL; vTYPE_OF_CHANGE := NULL;


                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

--                dbms_xslprocessor.valueOf(vXmlDOMNode,'COMPANY_CODE/text()',vCOMP_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'EMPLOYEE_CODE/text()',vEMP_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'PAY_MONTH/text()',vPAY_MONTH);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'FROM_DATE/text()',vEFF_FR_DATE);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'UPTO_DATE/text()',vEFF_TO_DATE);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'DECLARE_AMOUNT/text()',vDEC_AMOUNT);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'SUP_AMOUNT/text()',vSUP_AMOUNT);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'LOCATION_CODE/text()',   vLOC_MID);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'METRO_FLAG/text()',vMETRO_FLAG);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'PROMISE_AMOUNT/text()',vPROM_AMT);
--                dbms_xslprocessor.valueOf(vXmlDOMNode,'REMARKS/text()',vREMARKS);


                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';

                 BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'BRAND_NAME/text()',vBRAND_NAME);
                 EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid Value For Business Description (Max limit is 500 character)';
                    vERROR_FLAG:='Y';
                   ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Business Description';
                   END IF;
                  GOTO PRINT_ERROR;
                END;

                  BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'POORNATA_ID/text()',vPOORNATA_ID);
                 EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid Value For Poornata ID (Max limit is 20 character)';
                    vERROR_FLAG:='Y';
                   ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Poornata ID';
                   END IF;
                  GOTO PRINT_ERROR;
                END;

                  BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'TYPE_OF_CHANGE/text()',vTYPE_OF_CHANGE);
                 EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid Value For Type of Change';
                    vERROR_FLAG:='Y';
                   ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Type of Change';
                   END IF;
                  GOTO PRINT_ERROR;
                END;

                   BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'FROM_DATE/text()',vEFF_FR_DATE);
                 EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid Value For Issue Date ';
                    vERROR_FLAG:='Y';
                   ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Issue Date';
                   END IF;
                  GOTO PRINT_ERROR;
                END;

                   BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'UPTO_DATE/text()',vEFF_TO_DATE);
                 EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid Value For Return Date ';
                    vERROR_FLAG:='Y';
                   ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for Return Date';
                   END IF;
                  GOTO PRINT_ERROR;
                END;

                  BEGIN
                 dbms_xslprocessor.valueOf(vXmlDOMNode,'DECLARE_AMOUNT/text()',vDEC_AMOUNT);
                 EXCEPTION
                  WHEN OTHERS THEN
                   IF (SQLCODE ='-24331') THEN
                    vERROR_MSG:='Invalid Value For House Rent Recovery(Monthly)';
                    vERROR_FLAG:='Y';
                   ELSE
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid value for House Rent Recovery(Monthly)';
                   END IF;
                  GOTO PRINT_ERROR;
                END;


                    HR_PK_VALIDATION.PROC_GET_COMP_CODE( vBRAND_NAME, vComp_Aid, vCOMP_MID);

                    IF vCOMP_MID IS NULL THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Company Code cannot be blank';
                       GOTO PRINT_ERROR;
                    END IF;

--                    IF vEMP_MID IS NOT NULL THEN
--                            vEmp_Aid:=HR_PK_VALIDATION.FN_GET_EMP_AID (vComp_Aid, vEMP_MID);
--                    ELSE
                            vEmp_Aid:=HR_PK_VALIDATION.FN_GET_POORNATA_EMP_AID(vComp_Aid, vPOORNATA_ID);
--                    END IF;                    


                    vEMP_MID := NVL(vEMP_MID, vPOORNATA_ID);

                    vPAY_MONTH := TO_CHAR(TO_DATE(vEFF_FR_DATE,'MM/DD/YYYY'),'MON YYYY');


                IF vCOMP_MID IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Company Code cannot be blank';
                     GOTO PRINT_ERROR;
                 END IF;

                  IF vEmp_Aid IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Employee Code 5'||vPOORNATA_ID||' does not exist';
                     GOTO PRINT_ERROR;
                 END IF;

                  IF vPAY_MONTH IS NULL THEN
                     vERROR_FLAG:='Y';
                     vERROR_MSG:='Pay Month cannot be blank';
                     GOTO PRINT_ERROR;
                 END IF;

                vPAY_MONTH :=UPPER(vPAY_MONTH);

                /*Casting to Date Format*/
                vEFF_FR_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vEFF_FR_DATE));
                /*Casting to Date Format*/
                vEFF_TO_DATE:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vEFF_TO_DATE));

                --Get the Comp_Aid
--                vComp_Aid := PY_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

                IF vComp_Aid IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Company Code '||vCOMP_MID||' does not exist';
                    GOTO PRINT_ERROR;
                ELSE
                    PY_PK_VALIDATION.PR_GET_OPENING_MONTH_BATCH(vComp_Aid , pAcc_Year,vBacth_Id ,vOpen_Pay_Month);
                END IF;

                IF vBacth_Id IS NULL THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='No open batch is found';
                    GOTO PRINT_ERROR;
                END IF;


                --checking Effective From Date
                IF PY_PK_VALIDATION.FN_IS_DATE(vEFF_FR_DATE)=0 OR PY_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vEFF_FR_DATE)=0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Effective From Date ';
                    GOTO PRINT_ERROR;
                END IF;

                --checking Effective to Date
                IF PY_PK_VALIDATION.FN_IS_DATE(vEFF_TO_DATE)=0 OR PY_PK_VALIDATION.FN_CHECK_DATE_FORMAT(vEFF_TO_DATE)=0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Effective To Date ';
                    GOTO PRINT_ERROR;
                END IF;

                IF TO_DATE(vEFF_TO_DATE) < TO_DATE(vEFF_FR_DATE) THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Effective From Date should be lesser than Effective To Date';
                    GOTO PRINT_ERROR;
                END IF;

                IF NOT (vPAY_MONTH=TO_CHAR(TO_DATE(vEFF_FR_DATE),'MON YYYY') AND vPAY_MONTH=TO_CHAR(TO_DATE(vEFF_TO_DATE),'MON YYYY')) THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Rent Declaration Dates (FROM_DATE and UPTO_DATE) cannot be blank and should be same as Pay Month';
                    GOTO PRINT_ERROR;
                END IF;

                IF PY_PK_VALIDATION.FN_IS_NUMBER(vDEC_AMOUNT)=0 THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Invalid Declare Amount ';
                    GOTO PRINT_ERROR;
                END IF;



                vMETRO_FLAG:=UPPER(vMETRO_FLAG);
                IF NVL(UPPER(vMETRO_FLAG),'N') NOT IN ('Y','N') THEN
                    vERROR_FLAG:='Y';
                    vERROR_MSG:='Metro Flag '||vMETRO_FLAG||' is invalid';
                    GOTO PRINT_ERROR;
                END IF;



               -- Checking duplicate data exist or not
               IF UPPER(vTYPE_OF_CHANGE) IN ('ADD','CHANGE','DELETE') THEN
                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID AND  COL2 = vEMP_MID AND  COL3 = vPAY_MONTH AND COL4 =vEFF_FR_DATE AND COL5= vEFF_TO_DATE;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               --get Rent Type
               OPEN curRec FOR
                SELECT B.PAR_AID FROM PY_VW_GM_PARAMETERS B
                    WHERE B.PARA_GRP_MID ='RENTTYPE' AND B.PARA_MID='EMPLOYEE';
               FETCH curRec INTO vRENT_TYPE ;
               CLOSE  curRec;

               -- Checking data exist
--                IF pTrans_Type IN ('ADD','REMOVE AND ADD') THEN
               IF UPPER(vTYPE_OF_CHANGE) IN ('ADD') THEN
                    OPEN curRec FOR
                       SELECT COUNT(1) FROM HR_PT_RENT
                            WHERE COMP_AID=vComp_Aid AND ACC_YEAR=pAcc_Year AND EMP_AID=vEMP_AID AND PAY_MONTH=vPAY_MONTH AND RENT_TYPE=vRENT_TYPE
                                AND EFF_FR_DATE=vEFF_FR_DATE AND EFF_TO_DATE=vEFF_TO_DATE ;
                     FETCH curRec INTO vChkRecordCount ;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record already exist!';
                         GOTO PRINT_ERROR;
                     END IF;
               END IF;

               IF UPPER(vTYPE_OF_CHANGE) IN ('CHANGE') THEN
                    SELECT COUNT(1) INTO vChkUpdateRecord FROM HR_PT_RENT
                    WHERE  COMP_AID = vCOMP_AID AND ACC_YEAR = pAcc_Year AND PAY_MONTH = vPAY_MONTH  AND EMP_AID = vEMP_AID
                            AND RENT_TYPE=vRENT_TYPE AND EFF_FR_DATE=vEFF_FR_DATE AND EFF_TO_DATE=vEFF_TO_DATE;
                    IF vChkUpdateRecord=0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Record does not exist to Change!';
                         GOTO PRINT_ERROR;
                    END IF;
               END IF;
               /*end of validations*/

                /*Inserting Uploaded data in Insertable format*/
                IF NVL(vERROR_FLAG,'N')='N' THEN
                   INSERT INTO HR_PT_FINAL_UPLOAD_DATA  (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,
                        ROW_NO, COL1, COL2, COL3, COL4, COL5, COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15)
                     VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE
                        ,I+2, vTYPE_OF_CHANGE,vCOMP_AID,pAcc_Year,vEMP_AID,vPAY_MONTH,TRIM(TO_CHAR(MONTH_TO_NUMBER(vPAY_MONTH),'00')),vRENT_TYPE,vEFF_FR_DATE,vEFF_TO_DATE,vDEC_AMOUNT,vLOC_AID,vMETRO_FLAG,vSUP_AMOUNT,vPROM_AMT,vREMARKS);
                END IF;


             <<PRINT_ERROR>>
                /*Inserting Uploaded data as it is in Upload File*/
                INSERT INTO HR_TEMP_RAW_UPLOAD  (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,
                ROW_NO, COL1, COL2, COL3, COL4, COL5, COL6,COL7,  COL8, COL9,COL10,COL11,COL12)
                VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE , vERROR_FLAG , vERROR_MSG,
                I+2, vTYPE_OF_CHANGE,vCOMP_MID,vEMP_MID,vPAY_MONTH,vEFF_FR_DATE,vEFF_TO_DATE,vDEC_AMOUNT,vSUP_AMOUNT,vLOC_MID,vMETRO_FLAG,vPROM_AMT,vREMARKS);

            END LOOP;

           --Inserting Upload Summary
           PY_PK_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , vTYPE_OF_CHANGE , vUpldBatch_Id);

--        ELSE

            --Final data insert in base table HR_PT_RENT
            FOR I IN (SELECT   COL1 TYPE_OF_CHANGE , COL2 COMP_AID, COL3 ACC_YEAR,COL4 EMP_AID,COL7 RENT_TYPE
                        FROM HR_PT_FINAL_UPLOAD_DATA 
                        WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                       GROUP BY  COL1 , COL2 ,  COL3 ,COL4, COL7)
            LOOP
                 IF UPPER(I.TYPE_OF_CHANGE) IN ('DELETE') THEN
                    DELETE FROM HR_PT_RENT
                        WHERE COMP_AID = I.COMP_AID AND ACC_YEAR = I.ACC_YEAR AND EMP_AID=I.EMP_AID AND RENT_TYPE=I.RENT_TYPE AND VERSION_NO = '00000000';

                     DELETE FROM HR_PT_RENT_HD
                        WHERE COMP_AID = I.COMP_AID AND ACC_YEAR = I.ACC_YEAR AND EMP_AID=I.EMP_AID AND RENT_TYPE=I.RENT_TYPE AND VERSION_NO = '00000000';
                END IF;
            END LOOP;

            --Final data insert in base table PY_PT_INVESTMENT
            FOR I IN (SELECT  COL1 TYPE_OF_CHANGE,COL2 COMP_AID, COL3 ACC_YEAR, COL4 EMP_AID, COL5 PAY_MONTH, COL6 MONTH_SEQ, COL7 RENT_TYPE,COL8 EFF_FR_DATE,COL9 EFF_TO_DATE,COL10 DEC_AMOUNT,COL11 LOC_AID,COL12 METRO_FLAG,COL13 SUP_AMOUNT,COL14 PROM_AMT ,COL15 REMARKS
                        ,ROWNUM SR_NO, pUser_Aid USER_CR, SYSDATE DATE_CR ,pUser_Aid USER_UP, SYSDATE DATE_UP,pUser_Aid USER_AT, SYSDATE DATE_AT, BATCH_ID
                        FROM HR_PT_FINAL_UPLOAD_DATA 
                        WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                      )
            LOOP


                IF UPPER(I.TYPE_OF_CHANGE) IN ('ADD','REMOVE AND ADD') THEN
                    IF UPPER(I.TYPE_OF_CHANGE) IN ('ADD') THEN
                        vMaxSRNO:=PY_PK_VALIDATION.FN_GET_MAX('SR_NO','HR_PT_RENT_HD','COMP_AID||ACC_YEAR||EMP_AID||RENT_TYPE',TRIM(I.COMP_AID)||TRIM(I.ACC_YEAR)||TRIM(I.EMP_AID)||TRIM(I.RENT_TYPE));
                        vMaxSRNO:=vMaxSRNO+1;
                    ELSE
                        vMaxSRNO:=I.SR_NO;
                    END IF;

                    INSERT INTO HR_PT_RENT (COMP_AID, ACC_YEAR, EMP_AID, PAY_MONTH, MONTH_SEQ, RENT_TYPE,EFF_FR_DATE,EFF_TO_DATE,DEC_AMT,SUP_AMT,LOC_AID,METRO_YN,PROM_AMT,VERSION_NO,TRANS_FLAG,REMARKS
                             ,USER_CR,DATE_CR, USER_AT, DATE_AT, BATCH_ID)                                                                  /*I.SUP_AMOUNT*/  
                    VALUES(I.COMP_AID, I.ACC_YEAR, I.EMP_AID, I.PAY_MONTH, I.MONTH_SEQ, I.RENT_TYPE,I.EFF_FR_DATE,I.EFF_TO_DATE,I.DEC_AMOUNT,I.DEC_AMOUNT,I.LOC_AID,I.METRO_FLAG, I.PROM_AMT,'00000000','UPLOAD-ADD',I.REMARKS
                            ,I.USER_CR,I.DATE_CR, I.USER_AT, I.DATE_AT, I.BATCH_ID);

                    INSERT INTO HR_PT_RENT_HD (COMP_AID, ACC_YEAR, EMP_AID, VERSION_NO, RENT_TYPE, SR_NO, EFF_FR_DATE, EFF_TO_DATE, DEC_AMT, SUP_AMT, PROM_AMT, METRO_YN, REMARKS,
                              USER_CR, DATE_CR, USER_AT, DATE_AT,TRANS_FLAG)                                                                /*I.SUP_AMOUNT*/  
                    VALUES( I.COMP_AID,  I.ACC_YEAR, I.EMP_AID, '00000000', I.RENT_TYPE, vMaxSRNO, I.EFF_FR_DATE,I.EFF_TO_DATE,I.DEC_AMOUNT,I.DEC_AMOUNT,I.PROM_AMT,I.METRO_FLAG, I.REMARKS, I.USER_CR, SYSDATE, I.USER_CR, SYSDATE
                            ,'UPLOAD-ADD');

                ELSIF UPPER(I.TYPE_OF_CHANGE) IN ('CHANGE') THEN

                    UPDATE HR_PT_RENT SET DEC_AMT = DECODE(NVL(I.DEC_AMOUNT,0),0,DEC_AMT,I.DEC_AMOUNT),LOC_AID= I.LOC_AID,METRO_YN=I.METRO_FLAG,
                                    USER_UP = I.USER_UP, DATE_UP = I.DATE_UP, BATCH_ID = BATCH_ID,SUP_AMT=DECODE(NVL(I.SUP_AMOUNT,0),0,SUP_AMT,I.SUP_AMOUNT),
                                    PROM_AMT= DECODE(NVL(I.PROM_AMT,0),0,PROM_AMT,I.PROM_AMT),VERSION_NO='00000000',TRANS_FLAG='UPLOAD'
                        WHERE  COMP_AID = I.COMP_AID AND ACC_YEAR = I.ACC_YEAR AND EMP_AID = I.EMP_AID AND PAY_MONTH = I.PAY_MONTH
                            AND RENT_TYPE=I.RENT_TYPE AND EFF_FR_DATE=I.EFF_FR_DATE AND EFF_TO_DATE=I.EFF_TO_DATE;

                   UPDATE HR_PT_RENT_HD SET DEC_AMT = DECODE(NVL(I.DEC_AMOUNT,0),0,DEC_AMT,I.DEC_AMOUNT)--,LOC_AID= I.LOC_AID
                   ,METRO_YN=I.METRO_FLAG,
                        USER_UP = I.USER_UP, DATE_UP = I.DATE_UP, BATCH_ID = BATCH_ID,SUP_AMT=DECODE(NVL(I.SUP_AMOUNT,0),0,SUP_AMT,I.SUP_AMOUNT),
                        PROM_AMT= DECODE(NVL(I.PROM_AMT,0),0,PROM_AMT,I.PROM_AMT),VERSION_NO='00000000',TRANS_FLAG='UPLOAD'
            WHERE  COMP_AID = I.COMP_AID AND ACC_YEAR = I.ACC_YEAR AND EMP_AID = I.EMP_AID --AND PAY_MONTH = I.PAY_MONTH
                AND RENT_TYPE=I.RENT_TYPE AND EFF_FR_DATE=I.EFF_FR_DATE AND EFF_TO_DATE=I.EFF_TO_DATE;


                END IF;
            END LOOP;

            PY_PK_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);

        END IF;

        OPEN Return_Recordset FOR
            SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

       COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                vERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PROC_UPLOAD_RENT' ,vERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,vERROR_MSG ErrMessage  FROM DUAL;
    END ;

 PROCEDURE PRO_UPLOAD_EMPLOYEE_VEHICLE (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
     AS
     TYPE refCUR IS REF CURSOR;
    curRec                      refCUR;
    TEMP_CUR                    refCUR;
    cRes                        refCUR;
    cOUT_TEMP                   refCUR;

    vXmlParser                  dbms_xmlparser.Parser;
    vXmlDomDocument             dbms_xmldom.DOMDocument;
    vXmlDOMNodeList             dbms_xmldom.DOMNodeList;
    vXmlDOMNode                 dbms_xmldom.DOMNode;
    vERROR_MSG                VARCHAR2(2000);
    vERROR_FLAG               VARCHAR2(1);
    vChkRecordCount           NUMBER;
    vChkUpdateRecord          NUMBER;
    vUpldBatch_Id             PY_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    vComp_Aid                   PY_GM_COMP.COMP_ID%TYPE;
    vEmp_Aid                    HR_PM_EMP_VEHICLE_MST.EMP_AID%TYPE;
    vAllwded_Aid                HR_PM_EMP_VEHICLE_MST.ALLWDED_AID%TYPE;
    vBacth_Id                   PY_PM_MONTH_STATUS.BATCH_ID%TYPE;
    vOpen_Pay_Month             PY_PM_MONTH_STATUS.Pay_Month%TYPE;

    vCOMP_MID                   PY_GM_COMP.COMP_MID%TYPE;
    vEMP_MID                    PY_GM_EMPMAST.EMP_MID%TYPE;
    vVEHICLE_MID                PY_PM_VEHICLEMASTER.VEHICLE_MID%TYPE;
    vCAR_TYPE                   PY_GM_PARAMETERS.PARA_MID%TYPE;
    vCAR_USES                   PY_GM_PARAMETERS.PARA_MID%TYPE;
    VDRIVER                     HR_PM_EMP_VEHICLE_MST.DRIVER%type;
    vCAR_COST                   VARCHAR2(15);--HR_PM_EMP_VEHICLE_MST.CAR_COST%TYPE;
    vALLWDED_MID                PY_CTC_ALLOWANCE_MAST.CTC_MID%TYPE;
    vEFF_DATE_FR                VARCHAR2(100);
    vEFF_DATE_TO                VARCHAR2(100);
    vVEHICLE_AID                VARCHAR2(100);
    vCAR_TYPE_AID               HR_PM_EMP_VEHICLE_MST.CAR_TYPE%TYPE;
    vPARA_GRP_MID1              PY_GM_PARAMETER_GRPS.PARA_GRP_MID%TYPE DEFAULT 'VEHOWNER';
    vPARA_GRP_MID2              PY_GM_PARAMETER_GRPS.PARA_GRP_MID%TYPE DEFAULT 'VEHUSE';
    vCAR_USE_AID                HR_PM_EMP_VEHICLE_MST.CAR_USES%TYPE;
    vSRNO                       HR_PM_EMP_VEHICLE_MST.SRNO%TYPE;
    vChkCarCost                 VARCHAR2(100);
    vChkDupVehi                 VARCHAR2(100);
    vACTIVE_INACTIVE_PARA       VARCHAR2(1000);
    vBRAND_NAME                 VARCHAR2(500);
    vTYPE_OF_CHANGE             VARCHAR2(100);
    vENGINE_CC                  VARCHAR2(50);


    BEGIN

         IF pOperationType = 'RAW_UPLOAD' THEN

--            insert into VAICLOB(ABC, UPLOAD_AID) values(pRawXmlData,pUpload_Aid);
--            COMMIT;            
            vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

              FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vComp_Aid := NULL; vEmp_Aid := NULL; vAllwded_Aid := NULL; vBacth_Id := NULL; vOpen_Pay_Month := NULL; vCOMP_MID := NULL; vEMP_MID := NULL;
                vVEHICLE_MID := NULL; vCAR_TYPE := NULL; vCAR_USES := NULL; vDRIVER := NULL; vCAR_COST := NULL; vALLWDED_MID := NULL; vEFF_DATE_FR := NULL;
                vEFF_DATE_TO := NULL; vVEHICLE_AID := NULL; vCAR_TYPE_AID := NULL; vCAR_USE_AID := NULL;
                vSRNO := NULL; vChkCarCost := NULL; vChkDupVehi := NULL;  vACTIVE_INACTIVE_PARA:=NULL; vChkRecordCount:= NULL;
                vBRAND_NAME:= NULL; vTYPE_OF_CHANGE := NULL;


               vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';

                   --COMP_MID
                    BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'BRAND_NAME/text()',vBRAND_NAME);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Business Desc (Max limit is 500 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Business Desc';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

                    --vEMP_MID
                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',vEMP_MID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Employee Code';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Employee Code';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

                    --vVEHICLE_MID
                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'TYPE_OF_CHANGE/text()',vTYPE_OF_CHANGE);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for type_of_change';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Value For type_of_change';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;


                    --vEFF_DATE_FR
                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_FROM/text()',vEFF_DATE_FR);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Effective Date From';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Effective Date From';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;

                    --vEFF_DATE_TO
                     BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'EFFECTIVE_DATE_TO/text()',vEFF_DATE_TO);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Effective Date To';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Effective Date To ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;


                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'ENGINE_CC/text()',vENGINE_CC);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Engine_cc';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Engine_cc ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;


                    HR_PK_VALIDATION.PROC_GET_COMP_CODE( vBRAND_NAME, vComp_Aid, vCOMP_MID);

                    IF trim(vCOMP_MID) IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Company Code cannot be blank';
                        GOTO PRINT_ERROR;
                    END IF;

                    --Get the Comp_Aid
--                    vComp_Aid := PY_PK_VALIDATION.FN_GET_COMP_AID(vCOMP_MID);

                    IF vComp_Aid IS NULL THEN
                        Verror_Flag:='Y';
                        vERROR_MSG:='Company '||vBRAND_NAME||' does not exist';
                        GOTO PRINT_ERROR;
                    ELSE
                        PY_PK_VALIDATION.PR_GET_OPENING_MONTH_BATCH(vComp_Aid , pAcc_Year,vBacth_Id ,vOpen_Pay_Month);
                    END IF;

                    vEMP_MID:=TRIM(vEMP_MID);
                    vEmp_Aid := PY_PK_VALIDATION.FN_GET_EMP_AID(vComp_Aid,vEMP_MID);

                    IF vEMP_MID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Employee Code cannot be blank';
                        GOTO PRINT_ERROR;
                    END IF;

                    IF vEmp_Aid IS NULL THEN
                        VERROR_FLAG:='Y';
                        vERROR_MSG:='Employee Code 6'||TRIM(vEMP_MID)||' does not exist';
                        GOTO PRINT_ERROR;
                    END IF;

                    IF vBacth_Id IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='No open batch is found';
                        GOTO PRINT_ERROR;
                    END IF;

                    vENGINE_CC:=TRIM(vENGINE_CC);
                    vVEHICLE_AID:=PY_PK_VALIDATION.FN_GET_VEHICLE_ENG_AID(vComp_Aid,vENGINE_CC);



                    IF vVEHICLE_AID IS NULL THEN
                        VERROR_FLAG:='Y';
                        VERROR_MSG:='Engine cc '||trim(vENGINE_CC)||' does not exist';
                        GOTO PRINT_ERROR;
                    END IF;

                      --From Date
                      IF vEFF_DATE_FR IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Issue Date cannot be blank';
                        GOTO PRINT_ERROR;
                      End If;


                      --To Date
                      IF vEFF_DATE_TO IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Return Date cannot be blank';
                        GOTO PRINT_ERROR;
                      End If;

                        /*Casting to Date Format*/
                        vEFF_DATE_FR:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vEFF_DATE_FR));
                        /*Casting to Date Format*/
                        vEFF_DATE_TO:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vEFF_DATE_TO));


                        IF vEFF_DATE_FR IS NOT NULL AND vEFF_DATE_TO IS NOT NULL THEN

                            IF TO_DATE(vEFF_DATE_TO,'dd-MON-yyyy') < TO_DATE(vEFF_DATE_FR,'dd-MON-yyyy') THEN
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Effective To Date should be greater than Effective From Date';
                                GOTO PRINT_ERROR;
                            END IF;
                        END IF;

                   IF UPPER(vTYPE_OF_CHANGE) IN ('ADD','CHANGE','DELETE') THEN
                       SELECT COUNT(*) INTO vChkRecordCount FROM HR_TEMP_RAW_UPLOAD
                        Where Session_Id = Psessionid And User_Aid = Puser_Aid And Upload_Aid = Pupload_Aid And Upload_Batch_Id = Vupldbatch_Id
                                AND TRIM(COL1) = TRIM(vCOMP_MID) AND  TRIM(COL2) = TRIM(vEMP_MID) AND TRIM(COL3) = TRIM(vVEHICLE_MID) ;

                         IF vChkRecordCount > 0 THEN
                             VERROR_FLAG:='Y';
                             vERROR_MSG:='Duplicate record found !';
                             GOTO PRINT_ERROR;
                         END IF;
                    END IF;

                    IF UPPER(vTYPE_OF_CHANGE) IN ('ADD') THEN
                        SELECT COUNT(*) INTO vChkUpdateRecord FROM HR_PM_EMP_VEHICLE_MST
                        WHERE  COMP_AID = vComp_Aid  AND EMP_AID=vEmp_Aid AND VEHICLE_AID=vVEHICLE_AID 
                                AND SIGN(NVL(EFF_DATE_TO,EFF_DATE_FR)-EFF_DATE_FR)>=0;
                        IF vChkUpdateRecord>0 THEN
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Record already exist!';
                             GOTO PRINT_ERROR;
                        END IF;
                    END IF;

                   IF UPPER(vTYPE_OF_CHANGE) IN ('UPDATE') THEN
                    SELECT COUNT(*) INTO vChkUpdateRecord FROM HR_PM_EMP_VEHICLE_MST
                    WHERE  COMP_AID = vComp_Aid  AND EMP_AID=vEmp_Aid AND VEHICLE_AID=vVEHICLE_AID ;
                        IF vChkUpdateRecord=0 THEN
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Record does not exist to Update!';
                             GOTO PRINT_ERROR;
                        END IF;
                    END IF;


                   IF UPPER(vTYPE_OF_CHANGE) IN ('DELETE') THEN
                    SELECT COUNT(*) INTO vChkUpdateRecord FROM HR_PM_EMP_VEHICLE_MST
                    WHERE  COMP_AID = vComp_Aid  AND EMP_AID=vEmp_Aid AND VEHICLE_AID=vVEHICLE_AID AND (EFF_DATE_TO IS NULL OR EFF_DATE_TO=vEFF_DATE_TO);
                        IF vChkUpdateRecord=0 THEN
                             vERROR_FLAG:='Y';
                             vERROR_MSG:='Record does not exist to Delete!';
                             GOTO PRINT_ERROR;
                        END IF;
                   END IF;


                  /*end of validations*/

                    /*Inserting Uploaded data in Insertable format*/
                    IF NVL(vERROR_FLAG,'N')='N' THEN
                       INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,
                                   ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6)
                       VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE
                                   ,I+2,vTYPE_OF_CHANGE,vCOMP_AID,vEmp_Aid,vVEHICLE_AID,vEFF_DATE_FR,vEFF_DATE_TO);
                    END IF;

                    <<PRINT_ERROR>>
                    /*Inserting Uploaded data as it is in Upload File*/
                    INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,
                    ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE , vERROR_FLAG , vERROR_MSG,
                    I+2, vTYPE_OF_CHANGE, vCOMP_MID,vEMP_MID,vENGINE_CC,vEFF_DATE_FR,vEFF_DATE_TO);

              END LOOP;

               --Inserting Upload Summary
             INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , UPPER(vTYPE_OF_CHANGE) , vUpldBatch_Id);

--         ELSE



                 --Final data insert in base table HR_PM_EMP_VEHICLE_MST
              FOR I IN (SELECT  UPPER(COL1) TYPE_OF_CHANGE, COL2 COMP_AID,COL3 EMP_AID,COL4 VEHICLE_AID,COL5 EFF_DATE_FR,COL6 EFF_DATE_TO,'PA000044' ALLWDED_AID
                        ,pUser_Aid USER_CR, SYSDATE DATE_CR ,pUser_Aid USER_UP, SYSDATE DATE_UP, BATCH_ID
                        FROM HR_PT_FINAL_UPLOAD_DATA
                        WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid
                        )

                LOOP
                    vSRNO:=0;

                    OPEN cRes FOR
                    SELECT MAX(SRNO) FROM HR_PM_EMP_VEHICLE_MST WHERE COMP_AID= I.COMP_AID AND EMP_AID = I.EMP_AID
                    AND VEHICLE_AID=I.VEHICLE_AID ;
                    FETCH cRes INTO vSRNO;
                    CLOSE cRes;

                    IF I.TYPE_OF_CHANGE IN ('DELETE','ADD','CHANGE') THEN

                        Update HR_PM_EMP_VEHICLE_MST Set EFF_DATE_TO=TO_DATE(I.EFF_DATE_FR)-1,USER_UP = I.USER_UP, DATE_UP = I.DATE_UP,BATCH_ID = I.BATCH_ID
                         Where  Upper(Trim(Comp_Aid)) = Upper(Trim(I.Comp_Aid)) And Upper(Trim(Emp_Aid)) = Upper(Trim(I.Emp_Aid)) And Upper(Trim(Vehicle_Aid)) = Upper(Trim(I.Vehicle_Aid))
                              AND ((EFF_DATE_TO IS NULL OR EFF_DATE_FR >=TO_DATE(I.EFF_DATE_FR)) AND SIGN(NVL(EFF_DATE_TO,EFF_DATE_FR)-EFF_DATE_FR)>=0);

                        vSRNO   :=  NVL(vSRNO,0)+1;

                        INSERT INTO HR_PM_EMP_VEHICLE_MST (COMP_AID, EMP_AID, SRNO, VEHICLE_AID, ALLWDED_AID,
                                 EFF_DATE_FR, EFF_DATE_TO, USER_CR, DATE_CR, USER_UP, DATE_UP, BATCH_ID)
                        VALUES(I.COMP_AID, I.EMP_AID,vSRNO,I.VEHICLE_AID,I.ALLWDED_AID,
                                 I.EFF_DATE_FR,I.EFF_DATE_TO,I.USER_CR,I.DATE_CR,I.USER_UP,I.DATE_UP,I.BATCH_ID);

                    ELSIF I.TYPE_OF_CHANGE IN ('DELETE') THEN
                        Delete From HR_PM_EMP_VEHICLE_MST
                        WHERE  UPPER(TRIM(COMP_AID)) = UPPER(TRIM(I.COMP_AID)) AND UPPER(TRIM(EMP_AID)) = UPPER(TRIM(I.EMP_AID)) AND UPPER(TRIM(VEHICLE_AID)) = UPPER(TRIM(I.VEHICLE_AID)) 
                               AND (EFF_DATE_FR =TO_DATE(I.EFF_DATE_FR) AND SIGN(NVL(EFF_DATE_TO,EFF_DATE_FR)-EFF_DATE_FR)>=0);
                    END IF;

                END LOOP;

               COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, vUpldBatch_Id);

         END IF;

          OPEN Return_Recordset FOR
                SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

          COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                vERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_STANDARD_UPLOADS.UPLOAD_EMPLOYEE_VEHICLE' ,vERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,vERROR_MSG ErrMessage  FROM DUAL;

    END;

  PROCEDURE PRO_UPLOAD_LEAVE_BALANCE (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                      refCUR;
    TEMP_CUR                    refCUR;
    cRes                        refCUR;
    cOUT_TEMP                   refCUR;
    vXmlParser                  dbms_xmlparser.Parser;
    vXmlDomDocument             dbms_xmldom.DOMDocument;
    vXmlDOMNodeList             dbms_xmldom.DOMNodeList;
    vXmlDOMNode                 dbms_xmldom.DOMNode;
    vERROR_MSG                  VARCHAR2(2000);
    vERROR_FLAG                 VARCHAR2(1);
    vChkRecordCount             NUMBER;
    vUpldBatch_Id               PY_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;


    vBRAND_NAME                 PY_GM_COMP.BRAND_NAME%TYPE;
    vPOORNATA_ID                VARCHAR2(20);
    vComp_Aid                   PY_GM_COMP.COMP_ID%TYPE;
    vEmp_Aid                    PY_PT_LEAVE_BAL.EMP_AID%TYPE;
    vBacth_Id                   PY_PT_LEAVE_BAL.BATCH_ID%TYPE;
    vcomp_mid                   py_gm_comp.comp_mid%type;
    vEMP_MID                    PY_GM_EMPMAST.EMP_MID%TYPE;
    vPAY_MONTH                  PY_PT_LEAVE_BAL.PAY_MONTH%TYPE;
    vLeaveType_Aid              PY_GM_PARAMETERS.PAR_AID%TYPE;
    vACTIVE_INACTIVE_PARA       VARCHAR2(200);
    vREC_MONTH                  PY_PT_LEAVE_BAL.PAY_MONTH%TYPE;
    vOpen_Pay_Month             VARCHAR2(20);
    vPUBLISH_DATE               VARCHAR2(20);
    vPL_TAKEN                   VARCHAR2(20);
    vPL_BAL                     VARCHAR2(20);
    vCL_TAKEN                   VARCHAR2(20);
    vCL_BAL                     VARCHAR2(20);
    vML_TAKEN                   VARCHAR2(20);
    vML_BAL                     VARCHAR2(20);
    vLEAVE_TYPE                 VARCHAR2(100);

     BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

--            insert into VAICLOB(ABC, UPLOAD_AID) values(pRawXmlData,pUpload_Aid);
--            COMMIT;
            vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

              FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vComp_Aid := NULL; vEmp_Aid := NULL;  vBacth_Id := NULL; vCOMP_MID := NULL; vEMP_MID := NULL;  
                vBRAND_NAME:=NULL; vPAY_MONTH := NULL; vLeaveType_Aid := NULL;  
                vPOORNATA_ID := NULL; vACTIVE_INACTIVE_PARA := NULL; vREC_MONTH := NULL; vPUBLISH_DATE := NULL; 
                vPL_TAKEN := NULL; vPL_BAL := NULL; vCL_TAKEN := NULL; vCL_BAL := NULL;
                vML_TAKEN := NULL; vML_BAL := NULL; vLEAVE_TYPE := NULL;


                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';



                ------------------------------------------------company code
                  BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'BRAND_NAME/text()',vBRAND_NAME);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Brand Name(Max limit is 500 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Brand Name';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;



                    begin
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'POORNATA_ID/text()',vPOORNATA_ID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Poornata ID (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Poornata ID';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;


                       BEGIN
                           dbms_xslprocessor.valueOf(vXmlDOMNode,'PUBLISH_DATE/text()',vPUBLISH_DATE);
                      EXCEPTION
                       WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Publish Date';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Publish Date ';
                           END IF;
                      GOTO PRINT_ERROR;
                     END;



                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'PL_TAKEN/text()',vPL_TAKEN    );
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Privilege Leaves Taken';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Privilege Leaves Taken ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;




                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'PL_BAL/text()',vPL_BAL);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for PL Balance';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for PL Balance ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;


                   BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'CL_TAKEN/text()',vCL_TAKEN);
                         EXCEPTION
                          WHEN OTHERS THEN
                               IF (SQLCODE ='-24331') THEN
                                vERROR_MSG:='Invalid Value For Casual Leaves Taken';
                                vERROR_FLAG:='Y';
                               ELSE
                                vERROR_FLAG:='Y';
                                vERROR_MSG:='Invalid Value For Casual Leaves Taken ';
                               END IF;
                          GOTO PRINT_ERROR;
                        END;


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'CL_BAL/text()',vCL_BAL);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for CL Balance';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for CL Balance';
                           END IF;
                      GOTO PRINT_ERROR;
                END;


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'ML_TAKEN/text()',vML_TAKEN);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Medical Leaves Taken';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Medical Leaves Taken';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;


                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'ML_BAL/text()',vML_BAL);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for ML Balance';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for ML Balance';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;


                    HR_PK_VALIDATION.PROC_GET_COMP_CODE( vBRAND_NAME, vComp_Aid, vCOMP_MID);

                    IF vCOMP_MID IS NULL THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Company Code cannot be blank';
                       GOTO PRINT_ERROR;
                    END IF;


                    vEmp_Aid:=HR_PK_VALIDATION.FN_GET_POORNATA_EMP_AID(vComp_Aid, vPOORNATA_ID);

                    vPAY_MONTH := TO_CHAR(TO_DATE(vPUBLISH_DATE,'MM/DD/YYYY'),'MON YYYY');



                    IF vComp_Aid IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Company Code '||vBRAND_NAME||' does not exist';
                        GOTO PRINT_ERROR;
                    ELSE
                         PY_PK_VALIDATION.PR_GET_OPENING_MONTH_BATCH(vComp_Aid , pAcc_Year,vBacth_Id ,vOpen_Pay_Month);
                    END IF;


                    IF vEMP_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Employee Code 7'||vPOORNATA_ID||' Does Not Exist';
                        GOTO PRINT_ERROR;
                    END IF;

                    IF vBacth_Id IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='No open batch is found';
                        GOTO PRINT_ERROR;
                    END IF;


                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID AND  COL2 = vPOORNATA_ID AND  COL3 = vPUBLISH_DATE;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;




                    /*Inserting Uploaded data in Insertable format*/
                    IF NVL(vERROR_FLAG,'N')='N' THEN

                      INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,
                                   ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9)
                      VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid,SYSDATE
                                   ,I+2,vComp_Aid,vEmp_Aid,vPAY_MONTH ,vPL_TAKEN,vPL_BAL ,vCL_TAKEN ,vCL_BAL 
                                   ,vML_TAKEN ,vML_BAL);
                    END IF;

                    <<PRINT_ERROR>>
                    /*Inserting Uploaded data as it is in Upload File*/
                    INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,
                    ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE , vERROR_FLAG,vERROR_MSG,
                    I+2, vCOMP_MID,vPOORNATA_ID,vPUBLISH_DATE,vPL_TAKEN,vPL_BAL ,vCL_TAKEN ,vCL_BAL 
                    ,vML_TAKEN ,vML_BAL );


                 END LOOP;
               --Inserting Upload Summary
             INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , 'ADD' , vUpldBatch_Id);

--         ELSE
               FOR I IN (SELECT COMP_AID, ACC_YEAR, EMP_AID, PAY_MONTH, DECODE(LEAVE_TYPE,'PL_TAKEN', PL_BAL, 'CL_TAKEN',CL_BAL,'ML_TAKEN', ML_BAL) CLOSING_BAL, 
                             DECODE(LEAVE_TYPE,'PL_TAKEN', 'PS015629', 'CL_TAKEN', 'PS015632',  'ML_TAKEN' ,'PS015630') LEAVE_TYPE, LEAVE_AV, USER_CR,BATCH_ID
                        FROM (
                        SELECT  COL1 COMP_AID, pAcc_Year ACC_YEAR, COL2 EMP_AID, COL3 PAY_MONTH,COL4 PL_TAKEN,COL5 PL_BAL,COL6 CL_TAKEN,COL7 CL_BAL
                                             ,COL8 ML_TAKEN,COL9 ML_BAL
                                             ,pUser_Aid USER_CR,BATCH_ID
                                              FROM HR_PT_FINAL_UPLOAD_DATA
                                              WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId
                        )
                        UNPIVOT
                        (
                        LEAVE_AV FOR LEAVE_TYPE IN (PL_TAKEN,CL_TAKEN, ML_TAKEN)
                        ))

                 --Final data insert in base table PY_LT_LOAN_DISBURSE ---Commented
--              FOR I IN (SELECT  COL1 COMP_AID, pAcc_Year ACC_YEAR, COL2 EMP_AID, COL3 PAY_MONTH,COL4 PL_TAKEN,COL5 PL_BAL,COL6 CL_TAKEN,COL7 CL_BAL
--                       ,COL8 ML_TAKEN,COL9 ML_BAL
--                       ,pUser_Aid USER_CR,BATCH_ID
--                        FROM HR_PT_FINAL_UPLOAD_DATA
--                        WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId)

                LOOP



                        DELETE FROM HR_PT_LEAVE_BAL WHERE COMP_AID = I.COMP_AID AND ACC_YEAR= I.ACC_YEAR AND PAY_MONTH = I.PAY_MONTH
                                                    AND EMP_AID= I.EMP_AID AND LEAVE_TYPE=I.LEAVE_TYPE AND REC_MONTH=I.PAY_MONTH;



                        INSERT INTO HR_PT_LEAVE_BAL(COMP_AID, ACC_YEAR, PAY_MONTH, EMP_AID, LEAVE_TYPE, 
                                                     LEAVE_AV, CLOSING_BAL, USER_CR, DATE_CR, 
                                                     USER_AT, DATE_AT, BATCH_ID, REC_MONTH)
                          VALUES (I.COMP_AID,I.ACC_YEAR ,I.PAY_MONTH,I.EMP_AID,I.LEAVE_TYPE,I.LEAVE_AV,I.CLOSING_BAL
                                  ,I.USER_CR,SYSDATE,I.USER_CR,SYSDATE,I.BATCH_ID,I.PAY_MONTH);




                END LOOP;


               COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);


         END IF;

          OPEN Return_Recordset FOR
                SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

          COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                vERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPLOAD_LEAVE_BALANCE' ,vERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,vERROR_MSG ErrMessage  FROM DUAL;


    END;


  PROCEDURE PRO_MARRIAGE_GIFT_UPLOAD (pOperationType VARCHAR2,pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pUpload_Aid VARCHAR2,
                pRawXmlData CLOB,pTrans_Type VARCHAR2,pUpload_Batch_Id VARCHAR2,Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    curRec                      refCUR;
    TEMP_CUR                    refCUR;
    cRes                        refCUR;
    cOUT_TEMP                   refCUR;
    vXmlParser                  dbms_xmlparser.Parser;
    vXmlDomDocument             dbms_xmldom.DOMDocument;
    vXmlDOMNodeList             dbms_xmldom.DOMNodeList;
    vXmlDOMNode                 dbms_xmldom.DOMNode;
    vERROR_MSG                  VARCHAR2(2000);
    vERROR_FLAG                 VARCHAR2(1);
    vChkRecordCount             NUMBER;
    vUpldBatch_Id               PY_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;


    vBRAND_NAME                 PY_GM_COMP.BRAND_NAME%TYPE;
    vPOORNATA_ID                VARCHAR2(20);
    vComp_Aid                   PY_GM_COMP.COMP_ID%TYPE;
    vEmp_Aid                    PY_PT_LEAVE_BAL.EMP_AID%TYPE;
    vBacth_Id                   PY_PT_LEAVE_BAL.BATCH_ID%TYPE;
    vcomp_mid                   py_gm_comp.comp_mid%type;
    vEMP_MID                    PY_GM_EMPMAST.EMP_MID%TYPE;
    vPAY_MONTH                  PY_PT_LEAVE_BAL.PAY_MONTH%TYPE;
    vApproval_Date              VARCHAR2(20);--HR_PT_MARRIAGE_BAL.APPROVAL_DATE%TYPE;
    vStatus                     HR_PT_MARRIAGE_BAL.STATUS%TYPE;
    vGift_Amount                 HR_PT_MARRIAGE_BAL.GIFT_AMOUNT%TYPE;
    vOpen_Pay_Month             VARCHAR2(20);


     BEGIN

        IF pOperationType = 'RAW_UPLOAD' THEN

--            insert into VAICLOB(ABC, UPLOAD_AID) values(pRawXmlData,pUpload_Aid);
--            COMMIT;
            vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser := dbms_xmlparser.newParser;
            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);
            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);
            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

              FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                vComp_Aid := NULL; vEmp_Aid := NULL;  vBacth_Id := NULL; vCOMP_MID := NULL; vEMP_MID := NULL;  
                vBRAND_NAME:=NULL; vPAY_MONTH := NULL; vApproval_Date := NULL;  
                vPOORNATA_ID := NULL; vStatus := NULL; vGift_Amount := NULL; vOpen_Pay_Month:=NULL;



                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= NULL;
                vERROR_FLAG:='N';


                ------------------------------------------------company code
                  BEGIN
                        dbms_xslprocessor.valueOf(vXmlDOMNode,'BRAND_NAME/text()',vBRAND_NAME);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid Value For Brand Name(Max limit is 500 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Brand Name';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;



                    begin
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'POORNATA_ID/text()',vPOORNATA_ID);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Poornata ID (Max limit is 8 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Poornata ID';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;


                       BEGIN
                           dbms_xslprocessor.valueOf(vXmlDOMNode,'APPROVAL_DATE/text()',vApproval_Date);
                      EXCEPTION
                       WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Approval Date';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Approval Date ';
                           END IF;
                      GOTO PRINT_ERROR;
                     END;



                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'STATUS/text()',vStatus    );
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for status';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for status ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;




                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'GIFT_AMOUNT/text()',vGift_Amount);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Gift Amount';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Gift Amount ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;



                    HR_PK_VALIDATION.PROC_GET_COMP_CODE( vBRAND_NAME, vComp_Aid, vCOMP_MID);

                    IF vCOMP_MID IS NULL THEN
                       vERROR_FLAG:='Y';
                       vERROR_MSG:='Company Code cannot be blank';
                       GOTO PRINT_ERROR;
                    END IF;


                    vEmp_Aid:=HR_PK_VALIDATION.FN_GET_POORNATA_EMP_AID(vComp_Aid, vPOORNATA_ID);


                    vPAY_MONTH := TO_CHAR(TO_DATE(vApproval_Date,'MM/DD/YYYY'),'MON YYYY');



                    IF vComp_Aid IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Company Code '||vBRAND_NAME||' does not exist';
                        GOTO PRINT_ERROR;
                    ELSE
                         PY_PK_VALIDATION.PR_GET_OPENING_MONTH_BATCH(vComp_Aid , pAcc_Year,vBacth_Id ,vOpen_Pay_Month);
                    END IF;


                    IF vEMP_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Employee Code 8'||vPOORNATA_ID||' Does Not Exist';
                        GOTO PRINT_ERROR;
                    END IF;

                    IF vBacth_Id IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='No open batch is found';
                        GOTO PRINT_ERROR;
                    END IF;


                     vApproval_Date:= PI_HR_PK_FTP_VALIDATION.FN_CAST_DATE(TRIM(vApproval_Date));


                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM HR_TEMP_RAW_UPLOAD
                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
                                AND COL1 = vCOMP_MID AND  COL2 = vPOORNATA_ID AND  COL3 = vApproval_Date;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;

                     IF vChkRecordCount > 0 THEN
                         vERROR_FLAG:='Y';
                         vERROR_MSG:='Duplicate record found !';
                         GOTO PRINT_ERROR;
                     END IF;




                    /*Inserting Uploaded data in Insertable format*/
                    IF NVL(vERROR_FLAG,'N')='N' THEN

                      INSERT INTO HR_PT_FINAL_UPLOAD_DATA (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,
                                   ROW_NO, COL1,COL2,COL3,COL4,COL5,COL6)
                      VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid,SYSDATE
                                   ,I+2,vComp_Aid,vEmp_Aid,vPAY_MONTH ,vApproval_Date,vStatus,vGift_Amount);
                    END IF;

                    <<PRINT_ERROR>>
                    /*Inserting Uploaded data as it is in Upload File*/
                    INSERT INTO HR_TEMP_RAW_UPLOAD (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,
                    ROW_NO, COL1,COL2,COL3,COL4,COL5)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE , NVL(vERROR_FLAG,'N'),vERROR_MSG,
                    I+2, vCOMP_MID,vPOORNATA_ID,vApproval_Date,vStatus,vGift_Amount  );


                 END LOOP;
               --Inserting Upload Summary
             PY_PK_SFTP_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , 'ADD' , vUpldBatch_Id);

--         ELSE
               FOR I IN (SELECT  COL1 COMP_AID, pAcc_Year ACC_YEAR, COL2 EMP_AID, COL3 PAY_MONTH,COL4 APPROVAL_DATE,COL5 STATUS,COL6 GIFT_AMOUNT,pUser_Aid USER_CR,BATCH_ID
                         FROM HR_PT_FINAL_UPLOAD_DATA
                         WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId
                        )


                LOOP



                        DELETE FROM HR_PT_MARRIAGE_BAL WHERE COMP_AID = I.COMP_AID AND ACC_YEAR= I.ACC_YEAR AND PAY_MONTH = I.PAY_MONTH
                                                    AND EMP_AID= I.EMP_AID AND APPROVAL_DATE=I.APPROVAL_DATE;



                        INSERT INTO HR_PT_MARRIAGE_BAL(COMP_AID, ACC_YEAR, PAY_MONTH, EMP_AID, APPROVAL_DATE, 
                                                     STATUS, GIFT_AMOUNT, USER_CR, DATE_CR, 
                                                     USER_AT, DATE_AT, BATCH_ID)
                          VALUES (I.COMP_AID,I.ACC_YEAR ,I.PAY_MONTH,I.EMP_AID,I.APPROVAL_DATE,I.STATUS,I.GIFT_AMOUNT
                                  ,I.USER_CR,SYSDATE,I.USER_CR,SYSDATE,I.BATCH_ID);




                END LOOP;


               PY_PK_SFTP_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);


         END IF;

          OPEN Return_Recordset FOR
                SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

          COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                vERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_UPLOAD_LEAVE_BALANCE' ,vERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,vERROR_MSG ErrMessage  FROM DUAL;


    END;  


  PROCEDURE PRO_EMP_CLEARANCE_UPLOAD(-----Created By Saroj Kumar Giri for Employee  Clearance
    pOperationType   VARCHAR2,---CHANGES DONE BY ANISH BHOIL ON 13TH FEB 2020 FOR 3 IN 1 CONCEPT.
    pComp_Aid        VARCHAR2,
    pAcc_Year        VARCHAR2,
    pUser_Aid        VARCHAR2,
    pSessionId       VARCHAR2,
    pUpload_Aid      VARCHAR2,
    pRawXmlData      CLOB,
    pTrans_Type      VARCHAR2,
    pUpload_Batch_Id VARCHAR2,
    Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;

    curRec                      refCUR;
    TEMP_CUR                    refCUR;
    cRes                        refCUR;
    cOUT_TEMP                   refCUR;
    vXmlParser                  dbms_xmlparser.Parser;
    vXmlDomDocument             dbms_xmldom.DOMDocument;
    vXmlDOMNodeList             dbms_xmldom.DOMNodeList;
    vXmlDOMNode                 dbms_xmldom.DOMNode;
    vERROR_MSG                  VARCHAR2(2000);
    vERROR_FLAG                 VARCHAR2(1);
    vChkRecordCount             NUMBER;
    vUpldBatch_Id               PY_PM_UPLOAD_STATUS_HD.UPLOAD_BATCH_ID%TYPE;

    vBacth_Id                   PY_PT_LEAVE_BAL.BATCH_ID%TYPE;
    vCOMP_MID                   GM_COMP.COMP_MID%TYPE;
    vCOMP_AID                   GM_COMP.COMP_ID%TYPE;
    vEMP_AID                    GM_EMP.EMP_ID%TYPE;
    vEMP_MID                    GM_EMP.EMP_MID%TYPE;
    vEMP_NAME                   GM_EMP.EMP_NAME%TYPE;
    vBUSINESS               EMP_CLEARANCE.BUSINESS%TYPE;
    vBUSINESS_UNIT_DESC     EMP_CLEARANCE.BUSINESS_UNIT_DESC%TYPE;
    vBUSINESS_UNIT          EMP_CLEARANCE.BUSINESS_UNIT%TYPE;
    vDESCRIPTION            EMP_CLEARANCE.DESCRIPTION%TYPE;
    vJOB_BAND               EMP_CLEARANCE.JOB_BAND%TYPE;
    vGRADE                  EMP_CLEARANCE.GRADE%TYPE;
    vHIRE_DATE              VARCHAR2(20);--EMP_CLEARANCE.HIRE_DATE%TYPE;
    vHIRE_DATE_NEW          DATE;
    vEMAIL_ID               EMP_CLEARANCE.EMAIL_ID%TYPE;
    vEXIT_TYPE              EMP_CLEARANCE.EXIT_TYPE%TYPE;
    vDATE_OF_SEPARATION     VARCHAR2(20);--EMP_CLEARANCE.DATE_OF_SEPARATION%TYPE;
    vDATE_OF_SEPARATION_NEW DATE;
    vNOTICE_PERIOD_DAYS     EMP_CLEARANCE.NOTICE_PERIOD_DAYS%TYPE;
    vPL_TO_BE_ENCASHED      EMP_CLEARANCE.PL_TO_BE_ENCASHED%TYPE;
    vTENURE_MONTHS          EMP_CLEARANCE.TENURE_MONTHS%TYPE;
    VRECOVERY_DAYS          EMP_CLEARANCE.RECOVERY_DAYS%TYPE;
    vBATCH_ID               EMP_CLEARANCE.BATCH_ID%TYPE;
    vUSER_CR                EMP_CLEARANCE.USER_CR%TYPE;
    vDATE_CR                EMP_CLEARANCE.DATE_CR%TYPE;
    vUSER_UP                EMP_CLEARANCE.USER_UP%TYPE;
    vDATE_UP                EMP_CLEARANCE.DATE_UP%TYPE;
    vUSER_AT                EMP_CLEARANCE.USER_AT%TYPE;
    vDATE_AT                EMP_CLEARANCE.DATE_AT%TYPE;
    vROW_NO                 EMP_CLEARANCE.ROW_NO%TYPE;
    vCOMMENTS               EMP_CLEARANCE.COMMENTS%TYPE;
    vCOL1                   EMP_CLEARANCE.COL1%TYPE;
    vCOL2                   EMP_CLEARANCE.COL2%TYPE;
    vCOL3                   EMP_CLEARANCE.COL3%TYPE;
    vCOL4                   EMP_CLEARANCE.COL4%TYPE;
    vCOL5                   EMP_CLEARANCE.COL5%TYPE;
    vCOL6                   EMP_CLEARANCE.COL6%TYPE;
    vCOL7                   EMP_CLEARANCE.COL7%TYPE;
    vCOL8                   EMP_CLEARANCE.COL8%TYPE;
    vCOL9                   EMP_CLEARANCE.COL9%TYPE;
    vCOL10                  EMP_CLEARANCE.COL10%TYPE;
    vCOL11                  EMP_CLEARANCE.COL11%TYPE;
    vCOL12                  EMP_CLEARANCE.COL12%TYPE;
    vCOL13                  EMP_CLEARANCE.COL13%TYPE;
    vCOL14                  EMP_CLEARANCE.COL14%TYPE;
    vCOL15                  EMP_CLEARANCE.COL15%TYPE;
    vCOL16                  EMP_CLEARANCE.COL16%TYPE;
    vCOL17                  EMP_CLEARANCE.COL17%TYPE;
    vCOL18                  EMP_CLEARANCE.COL18%TYPE;
    vCOL19                  EMP_CLEARANCE.COL19%TYPE;
    vCOL20                  EMP_CLEARANCE.COL20%TYPE;
    vCOL21                  EMP_CLEARANCE.COL21%TYPE;
    vCOL22                  EMP_CLEARANCE.COL22%TYPE;
    vCOL23                  EMP_CLEARANCE.COL23%TYPE;
    vCOL24                  EMP_CLEARANCE.COL24%TYPE;
    vCOL25                  EMP_CLEARANCE.COL25%TYPE;
    vCOL26                  EMP_CLEARANCE.COL26%TYPE;
    vCOL27                  EMP_CLEARANCE.COL27%TYPE;
    vCOL28                  EMP_CLEARANCE.COL28%TYPE;
    vCOL29                  EMP_CLEARANCE.COL29%TYPE;
    vCOL30                  EMP_CLEARANCE.COL30%TYPE;
    vCOL31                  EMP_CLEARANCE.COL31%TYPE;
    vCOL32                  EMP_CLEARANCE.COL32%TYPE;
    vCOL33                  EMP_CLEARANCE.COL33%TYPE;
    vCOL34                  EMP_CLEARANCE.COL34%TYPE;
    vCOL35                  EMP_CLEARANCE.COL35%TYPE;
    vCOL36                  EMP_CLEARANCE.COL36%TYPE;
    vCOL37                  EMP_CLEARANCE.COL37%TYPE;
    vCOL38                  EMP_CLEARANCE.COL38%TYPE;
    vCOL39                  EMP_CLEARANCE.COL39%TYPE;
    vCOL40                  EMP_CLEARANCE.COL40%TYPE;
    vCOL41                  EMP_CLEARANCE.COL41%TYPE;
    vCOL42                  EMP_CLEARANCE.COL42%TYPE;
    vCOL43                  EMP_CLEARANCE.COL43%TYPE;
    vCOL44                  EMP_CLEARANCE.COL44%TYPE;
    vCOL45                  EMP_CLEARANCE.COL45%TYPE;
    vCOL46                  EMP_CLEARANCE.COL46%TYPE;
    vCOL47                  EMP_CLEARANCE.COL47%TYPE;
    vCOL48                  EMP_CLEARANCE.COL48%TYPE;
    vCOL49                  EMP_CLEARANCE.COL49%TYPE;
    vCOL50                  EMP_CLEARANCE.COL50%TYPE;
    vCOL51                  EMP_CLEARANCE.COL51%TYPE;
    vCOL52                  EMP_CLEARANCE.COL52%TYPE;
    vCOL53                  EMP_CLEARANCE.COL53%TYPE;
    vCOL54                  EMP_CLEARANCE.COL54%TYPE;
    vCOL55                  EMP_CLEARANCE.COL55%TYPE;
    vCOL56                  EMP_CLEARANCE.COL56%TYPE;
    vCOL57                  EMP_CLEARANCE.COL57%TYPE;
    vCOL58                  EMP_CLEARANCE.COL58%TYPE;
    vCOL59                  EMP_CLEARANCE.COL59%TYPE;
    vCOL60                  EMP_CLEARANCE.COL60%TYPE;
    vCOL61                  EMP_CLEARANCE.COL61%TYPE;
    vCOL62                  EMP_CLEARANCE.COL62%TYPE;
    vCOL63                  EMP_CLEARANCE.COL63%TYPE;
    vCOL64                  EMP_CLEARANCE.COL64%TYPE;
    vCOL65                  EMP_CLEARANCE.COL65%TYPE;
    vCOL66                  EMP_CLEARANCE.COL66%TYPE;
    vCOL67                  EMP_CLEARANCE.COL67%TYPE;
    vCOL68                  EMP_CLEARANCE.COL68%TYPE;
    vCOL69                  EMP_CLEARANCE.COL69%TYPE;
    vCOL70                  EMP_CLEARANCE.COL70%TYPE;
    vCOL71                  EMP_CLEARANCE.COL71%TYPE;
    vCOL72                  EMP_CLEARANCE.COL72%TYPE;
    vCOL73                  EMP_CLEARANCE.COL73%TYPE;
    vCOL74                  EMP_CLEARANCE.COL74%TYPE;
    vCOL75                  EMP_CLEARANCE.COL75%TYPE;
    vCOL76                  EMP_CLEARANCE.COL76%TYPE;
    vCOL77                  EMP_CLEARANCE.COL77%TYPE;
    vCOL78                  EMP_CLEARANCE.COL78%TYPE;
    vCOL79                  EMP_CLEARANCE.COL79%TYPE;
    vCOL80                  EMP_CLEARANCE.COL80%TYPE;
    vCOL81                  EMP_CLEARANCE.COL81%TYPE;
    vCOL82                  EMP_CLEARANCE.COL82%TYPE;
    vCOL83                  EMP_CLEARANCE.COL83%TYPE;
    vCOL84                  EMP_CLEARANCE.COL84%TYPE;
    vCOL85                  EMP_CLEARANCE.COL85%TYPE;
    vCOL86                  EMP_CLEARANCE.COL86%TYPE;
    vCOL87                  EMP_CLEARANCE.COL87%TYPE;
    vCOL88                  EMP_CLEARANCE.COL88%TYPE;
    vCOL89                  EMP_CLEARANCE.COL89%TYPE;
    vCOL90                  EMP_CLEARANCE.COL90%TYPE;
    vCOL91                  EMP_CLEARANCE.COL91%TYPE;
    vCOL92                  EMP_CLEARANCE.COL92%TYPE;
    vCOL93                  EMP_CLEARANCE.COL93%TYPE;
    vCOL94                  EMP_CLEARANCE.COL94%TYPE;
    vCOL95                  EMP_CLEARANCE.COL95%TYPE;
    vCOL96                  EMP_CLEARANCE.COL96%TYPE;
    vCOL97                  EMP_CLEARANCE.COL97%TYPE;
    vCOL98                  EMP_CLEARANCE.COL98%TYPE;
    vCOL99                  EMP_CLEARANCE.COL99%TYPE;
    vCOL100                 EMP_CLEARANCE.COL100%TYPE;


    VCOMP_ID                VARCHAR2(8);
    vPaygroup               VARCHAR2(20);
    VSCHEMA_TRANS_DBLINK    VARCHAR2(30);
    DBLINK_NOT_TRACED       EXCEPTION;
    

     BEGIN

--INSERT INTO PRO_EMP_CLEARANCE_UPLOAD_TEMP VALUES(pRawXmlData,pUpload_Aid,SYSDATE);
--INSERT INTO PRO_EMP_CLEARANCE_UPLOAD_TEMP1 VALUES(pOperationType||'@'||pComp_Aid||'@'||pAcc_Year||'@'||pUser_Aid||'@'||pSessionId||'@'||pUpload_Aid||'@'||pTrans_Type||'@'||pUpload_Batch_Id,SYSDATE);
COMMIT;
      IF pOperationType = 'RAW_UPLOAD' THEN

--            insert into VAICLOB(ABC, UPLOAD_AID) 
--                   values(pRawXmlData,pUpload_Aid);
--                   COMMIT;
--            INSERT INTO OSO VALUES(' 1- '||pOperationType||' 2- '||pComp_Aid||' 3- '||pAcc_Year||' 4- '||pUser_Aid||' 5- '||pSessionId||' 6- '||pUpload_Aid||' 7- '||pTrans_Type||' 8- '||pUpload_Batch_Id,SYSDATE);
--            COMMIT;
            vUpldBatch_Id := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser    := dbms_xmlparser.newParser;

            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);

            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                        vDATE_OF_SEPARATION_NEW:=NULL;
                        vEMP_MID            := NULL;
                        vEMP_NAME           := NULL;
                        vBUSINESS           := NULL;
                        vBUSINESS_UNIT_DESC := NULL;
                        vBUSINESS_UNIT      := NULL;
                        vDESCRIPTION        := NULL;
                        vJOB_BAND           := NULL;
                        vGRADE              := NULL;
                        vHIRE_DATE          := NULL;
                        vEMAIL_ID           := NULL;
                        vEXIT_TYPE          := NULL;
                        vDATE_OF_SEPARATION := NULL;
                        vNOTICE_PERIOD_DAYS := NULL;
                        vPL_TO_BE_ENCASHED  := NULL;
                        vTENURE_MONTHS      := NULL;
                        VRECOVERY_DAYS      := NULL;
                        vCOMMENTS           := NULL;
                        vCOL1               := NULL;
                        vCOL2               := NULL;
                        vCOL3               := NULL;
                        vCOL4               := NULL;
                        vCOL5               := NULL;
                        vCOL6               := NULL;
                        vCOL7               := NULL;
                        vCOL8               := NULL;
                        vCOL9               := NULL;
                        vCOL10              := NULL;
                        vCOL11              := NULL;
                        vCOL12              := NULL;
                        vCOL13              := NULL;
                        vCOL14              := NULL;
                        vCOL15              := NULL;
                        vCOL16              := NULL;
                        vCOL17              := NULL;
                        vCOL18              := NULL;
                        vCOL19              := NULL;
                        vCOL20              := NULL;
                        vCOL21              := NULL;
                        vCOL22              := NULL;
                        vCOL23              := NULL;
                        vCOL24              := NULL;
                        vCOL25              := NULL;
                        vCOL26              := NULL;
                        vCOL27              := NULL;
                        vCOL28              := NULL;
                        vCOL29              := NULL;
                        vCOL30              := NULL;
                        vCOL31              := NULL;
                        vCOL32              := NULL;
                        vCOL33              := NULL;
                        vCOL34              := NULL;
                        vCOL35              := NULL;
                        vCOL36              := NULL;
                        vCOL37              := NULL;
                        vCOL38              := NULL;
                        vCOL39              := NULL;
                        vCOL40              := NULL;
                        vCOL41              := NULL;
                        vCOL42              := NULL;
                        vCOL43              := NULL;
                        vCOL44              := NULL;
                        vCOL45              := NULL;
                        vCOL46              := NULL;
                        vCOL47              := NULL;
                        vCOL48              := NULL;
                        vCOL49              := NULL;
                        vCOL50              := NULL;
                        vCOL51              := NULL;
                        vCOL52              := NULL;
                        vCOL53              := NULL;
                        vCOL54              := NULL;
                        vCOL55              := NULL;
                        vCOL56              := NULL;
                        vCOL57              := NULL;
                        vCOL58              := NULL;
                        vCOL59              := NULL;
                        vCOL60              := NULL;
                        vCOL61              := NULL;
                        vCOL62              := NULL;
                        vCOL63              := NULL;
                        vCOL64              := NULL;
                        VCOMP_ID            := NULL; 
                        VSCHEMA_TRANS_DBLINK  := NULL; 
                        vPaygroup            :=NULL;  


                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                vERROR_MSG:= 'Sucess';
                vERROR_FLAG:='N';
delete oso_cl;
commit;

                 BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'PAY_GROUP/text()',vPaygroup);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        vERROR_MSG:='Invalid value for Pay Group (Max limit is 20 character)';
                        vERROR_FLAG:='Y';
                       ELSE
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Invalid value for Pay Group';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

               ------------------------------------------------Employee Code

                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',vEMP_MID);

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
           INSERT INTO oso_cl VALUES (vEMP_MID||'-'||'vEMP_MID',1);
           COMMIT;
               ------------------------------------------------Employee Name
                       BEGIN
                           dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_NAME/text()',vEMP_NAME);
                      EXCEPTION
                       WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Employee Name';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Employee Name ';
                           END IF;
                      GOTO PRINT_ERROR;
                     END;
           INSERT INTO oso_cl VALUES (vEMP_NAME||'-'||'vEMP_NAME',2);
           COMMIT;

               ------------------------------------------------BUSINESS

                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS/text()',vBUSINESS);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Business';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Business ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;
           INSERT INTO oso_cl VALUES (vBUSINESS||'-'||'vBUSINESS',3);
           COMMIT;

               ------------------------------------------------BUSINESS_UNIT_DESC


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS_UNIT_DESC/text()',vBUSINESS_UNIT_DESC);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for Business Unit Description';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for Business Unit Description ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (vBUSINESS_UNIT_DESC||'-'||'vBUSINESS_UNIT_DESC',4);
           COMMIT;

               ------------------------------------------------ BUSINESS_UNIT


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS_UNIT/text()',vBUSINESS_UNIT);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Business Unit';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Business Unit ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (vBUSINESS_UNIT||'-'||'vBUSINESS_UNIT',5);
           COMMIT;


               ------------------------------------------------ DESCRIPTION


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'DESCRIPTION/text()',vDESCRIPTION);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Description';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Description';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (vDESCRIPTION||'-'||'vDESCRIPTION',6);
           COMMIT;


               ------------------------------------------------ JOB_BAND


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'JOB_BAND/text()',vJOB_BAND);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Job Band';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Job Band';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (vJOB_BAND||'-'||'vJOB_BAND',7);
           COMMIT;



               ------------------------------------------------ GRADE


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'GRADE/text()',vGRADE);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Grade';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Grade';
                           END IF;
                      GOTO PRINT_ERROR;
                END;


           INSERT INTO oso_cl VALUES (vGRADE||'-'||'vGRADE',8);
           COMMIT;


               ------------------------------------------------ HIRE_DATE


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'HIRE_DATE/text()',vHIRE_DATE);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Hire Date';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Hire Date';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vHIRE_DATE||'-'||'vHIRE_DATE',9);
           COMMIT;

               ------------------------------------------------ EMAIL_ID


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EMAIL_ID/text()',vEMAIL_ID);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Email Id';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for   Email Id';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vEMAIL_ID||'-'||'vEMAIL_ID',10);
           COMMIT;


               ------------------------------------------------ EXIT_TYPE


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EXIT_TYPE/text()',vEXIT_TYPE);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Exit Type )';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Exit Type';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vEXIT_TYPE||'-'||'vEXIT_TYPE',11);
           COMMIT;

               ------------------------------------------------ DATE_OF_SEPARATION


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'DATE_OF_SEPARATION/text()',vDATE_OF_SEPARATION);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Date Of Separation';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Date Of Separation';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vDATE_OF_SEPARATION||'-'||'vDATE_OF_SEPARATION',12);
           COMMIT;

               ------------------------------------------------ NOTICE_PERIOD_DAYS


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'NOTICE_PERIOD_DAYS/text()',vNOTICE_PERIOD_DAYS);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Notice Period Days';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Notice Period Days';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vNOTICE_PERIOD_DAYS||'-'||'vNOTICE_PERIOD_DAYS',13);
           COMMIT;

               ------------------------------------------------ PL_TO_BE_ENCASHED


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'PL_TO_BE_ENCASHED/text()',vPL_TO_BE_ENCASHED);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Pl To Be Encashed ';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Pl To Be Encashed';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vPL_TO_BE_ENCASHED||'-'||'vPL_TO_BE_ENCASHED',14);
           COMMIT;

               ------------------------------------------------ TENURE_MONTHS


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'TENURE_MONTHS/text()',vTENURE_MONTHS);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Tenure(Months)';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Tenure(Months)';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vTENURE_MONTHS||'-'||'vTENURE_MONTHS',15);
           COMMIT;


               ------------------------------------------------ RECOVERY_DAYS


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'RECOVERY_DAYS/text()',vRECOVERY_DAYS);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            vERROR_MSG:='Invalid value for  Recovery Days';
                            vERROR_FLAG:='Y';
                           ELSE
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid value for  Recovery Days';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (vRECOVERY_DAYS||'-'||'vRECOVERY_DAYS',16);
           COMMIT;


            ------------------------------------- Clearance

                BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COMMENTS/text()',vCOMMENTS);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL1/text()',vCOL1);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL2/text()',vCOL2);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance1(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL3/text()',vCOL3);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL4/text()',vCOL4);

                    IF vCOL1 IS NOT NULL THEN
                       IF vCOL2 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance1 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
---------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL5/text()',vCOL5);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL6/text()',vCOL6);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance2(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL7/text()',vCOL7);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL8/text()',vCOL8);

                    IF vCOL5 IS NOT NULL THEN
                       IF vCOL6 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance2 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL9/text()',vCOL9);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL10/text()',vCOL10);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance3(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL11/text()',vCOL11);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL12/text()',vCOL12);

                  IF vCOL9 IS NOT NULL THEN
                       IF vCOL10 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance3 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL13/text()',vCOL13);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL14/text()',vCOL14);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance4(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL15/text()',vCOL15);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL16/text()',vCOL16);

                  IF vCOL13 IS NOT NULL THEN
                       IF vCOL14 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance4 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL17/text()',vCOL17);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL18/text()',vCOL18);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance5(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL19/text()',vCOL19);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL20/text()',vCOL20);

                  IF vCOL17 IS NOT NULL THEN
                       IF vCOL18 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance5 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL21/text()',vCOL21);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL22/text()',vCOL22);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance6(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL23/text()',vCOL23);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL24/text()',vCOL24);

                  IF vCOL21 IS NOT NULL THEN
                       IF vCOL22 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance6 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL25/text()',vCOL25);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL26/text()',vCOL26);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance7(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL27/text()',vCOL27);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL28/text()',vCOL28);

                  IF vCOL25 IS NOT NULL THEN
                       IF vCOL26 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance7 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL29/text()',vCOL29);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL30/text()',vCOL30);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance8(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL31/text()',vCOL31);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL32/text()',vCOL32);

                  IF vCOL29 IS NOT NULL THEN
                       IF vCOL30 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance8 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL33/text()',vCOL33);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL34/text()',vCOL34);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance9(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL35/text()',vCOL35);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL36/text()',vCOL36);

                  IF vCOL33 IS NOT NULL THEN
                       IF vCOL34 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance9 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL37/text()',vCOL37);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL38/text()',vCOL38);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance10(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL39/text()',vCOL39);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL40/text()',vCOL40);

                  IF vCOL37 IS NOT NULL THEN
                       IF vCOL38 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance10 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL41/text()',vCOL41);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL42/text()',vCOL42);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance11(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL43/text()',vCOL43);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL44/text()',vCOL44);

                  IF vCOL41 IS NOT NULL THEN
                       IF vCOL42 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance11 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL45/text()',vCOL45);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL46/text()',vCOL46);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance12(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL47/text()',vCOL47);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL48/text()',vCOL48);

                  IF vCOL45 IS NOT NULL THEN
                       IF vCOL46 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance12 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL49/text()',vCOL49);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL50/text()',vCOL50);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance13(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL51/text()',vCOL51);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL52/text()',vCOL52);

                  IF vCOL49 IS NOT NULL THEN
                       IF vCOL50 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance13 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL53/text()',vCOL53);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL54/text()',vCOL54);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance14(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL55/text()',vCOL55);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL56/text()',vCOL56);

                  IF vCOL53 IS NOT NULL THEN
                       IF vCOL54 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance14 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL57/text()',vCOL57);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL58/text()',vCOL58);
                    EXCEPTION
                       WHEN OTHERS THEN
                            vERROR_FLAG:='Y';
                            vERROR_MSG:='Invalid Amount in Clearance15(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL59/text()',vCOL59);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL60/text()',vCOL60);

                  IF vCOL57 IS NOT NULL THEN
                       IF vCOL58 IS NULL THEN
                           vERROR_FLAG:='Y';
                           vERROR_MSG:='Clearance15 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL61/text()',vCOL61);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL62/text()',vCOL62);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL63/text()',vCOL63);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL64/text()',vCOL64);

                END ;
----===========  saroj 06-nov-19
--     OPEN curRec FOR---COMMENTED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
--     select COMP_MID from gm_comp where COMP_ID=pComp_Aid;
--     FETCH curRec INTO vCOMP_MID;
--     CLOSE curRec;
----=====================
 
--            IF SUBSTR(pComp_Aid,2,1)='H' THEN ---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
--               VCOMP_ID:=REPLACE(pComp_Aid,'H','M');
--               VSCHEMA_TRANS_DBLINK:='DBLINK_ABG_OP_ABGHINDALCO_UAT';
--            ELSIF SUBSTR(pComp_Aid,2,1)='B' THEN 
--               VCOMP_ID:=REPLACE(pComp_Aid,'B','M'); 
--               VSCHEMA_TRANS_DBLINK:='DBLINK_ABG_OP_BIRLACHEM_UAT';
--            ELSIF SUBSTR(pComp_Aid,2,1)='A' THEN   
--               VCOMP_ID:=REPLACE(pComp_Aid,'A','M');
--               VSCHEMA_TRANS_DBLINK:='ABGGROUP';
--            END IF;
--
--             IF VSCHEMA_TRANS_DBLINK IS NULL THEN  
--               RAISE DBLINK_NOT_TRACED;
--             END IF;  

              OPEN CURREC for
                  SELECT COMP_ID,'DBLINK_ABG_OP_ABGHINDALCO_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                  WHERE  BUSINESS_NATURE_ID=vPaygroup
                  UNION ALL
                  SELECT COMP_ID,'DBLINK_ABG_OP_BIRLACHEM_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                  WHERE  BUSINESS_NATURE_ID=vPaygroup
                  UNION ALL
                  SELECT COMP_ID,'ABGGROUP' 
                  FROM GM_COMP
                  WHERE  BUSINESS_NATURE_ID=vPaygroup;
                FETCH CURREC INTO VCOMP_ID,VSCHEMA_TRANS_DBLINK;
              CLOSE  CURREC;
            
           IF VSCHEMA_TRANS_DBLINK IS NULL THEN  
                vERROR_FLAG:='Y';
                vERROR_MSG:='Unable to track employee '||vEMP_MID||  ' group company';
                GOTO PRINT_ERROR;
           END IF;  
    

            
            IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                OPEN curRec FOR
                   select COMP_MID from gm_comp@DBLINK_ABG_OP_BIRLACHEM_UAT
                   where COMP_ID=VCOMP_ID;
                  FETCH curRec INTO vCOMP_MID;
                CLOSE curRec;
            ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN     
                 OPEN curRec FOR
                   select COMP_MID from gm_comp@DBLINK_ABG_OP_ABGHINDALCO_UAT
                   where COMP_ID=VCOMP_ID;
                  FETCH curRec INTO vCOMP_MID;
                CLOSE curRec;
            ELSE                    
                 OPEN curRec FOR
                   select COMP_MID from gm_comp
                   where COMP_ID=VCOMP_ID;
                  FETCH curRec INTO vCOMP_MID;
                CLOSE curRec;
            END IF;
            
                    vHIRE_DATE_NEW:= DATE_RETURN(vHIRE_DATE);
                    vDATE_OF_SEPARATION_NEW:=DATE_RETURN(vDATE_OF_SEPARATION) ;
--vComp_Aid                    vComp_Aid:=HR_PK_VALIDATION.FN_GET_MARSHA_TO_COMP_AID(vBUSINESS);
                    
                   --vEmp_Aid:=HR_PK_VALIDATION.FN_GET_EMP_AID(pComp_Aid, vEMP_MID);---COMMENTED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
              
               IF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT.    
                   OPEN curRec FOR 
                    SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(VCOMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_MID));
                    FETCH curRec INTO vEmp_Aid;
                    CLOSE  curRec;
               ELSIF VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN      
                    OPEN curRec FOR
                    SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(VCOMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_MID));
                    FETCH curRec INTO vEmp_Aid;
                    CLOSE  curRec; 
               ELSE     
                    OPEN curRec FOR
                    SELECT EMP_ID FROM GM_EMP---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(VCOMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(vEMP_MID));
                    FETCH curRec INTO vEmp_Aid;
                    CLOSE  curRec; 
               END IF;          

--vComp_Aid:=HR_PK_VALIDATION.FN_GET_PAYGROUP_COMP_AID_new(vEMP_MID);
--vEmp_Aid:=HR_PK_VALIDATION.FN_GET_EMP_AID(vComp_Aid,vEMP_MID);

--                    IF vComp_Aid IS NULL THEN
--                       vERROR_FLAG:='Y';
--                       vERROR_MSG:='Business cannot be blank';
--                       GOTO PRINT_ERROR;
--                    END IF;


                    IF vEMP_AID IS NULL THEN
                        vERROR_FLAG:='Y';
                        vERROR_MSG:='Employee Code'||vEMP_MID||' Does Not Exist';
                        GOTO PRINT_ERROR;
                    END IF;


--                    OPEN curRec FOR
--                       SELECT COUNT(1)  FROM HR_TEMP_RAW_UPLOAD_NEW
--                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = vUpldBatch_Id
--                                AND COL1 = vCOMP_MID AND  COL2 = vEMP_MID;-- AND  COL3 = vApproval_Date;
--                     FETCH curRec INTO vChkRecordCount;
--                     CLOSE  curRec;

--                     IF vChkRecordCount > 0 THEN
--                         vERROR_FLAG:='Y';
--                         vERROR_MSG:='Duplicate record found !';
--                         GOTO PRINT_ERROR;
--                     END IF;


                    /*Inserting Uploaded data in Insertable format*/
                    IF NVL(vERROR_FLAG,'N')='N' THEN

                      INSERT INTO HR_PT_FINAL_UPLOAD_DATA_NEW (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,ROW_NO,
                                   COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,---col12 to start Clearance
                                   COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,
                                   COL41,COL42,COL43,COL44,COL45,COL46,COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,COL60,
                                   COL61,COL62,COL63,COL64,COL65,COL66,COL67,COL68,COL69,COL70,COL71,COL72,COL73,COL74,COL75,COL76,COL77,COL78,COL79,COL80,COL81,COL82,COL83,COL84,COL85)

                      VALUES(vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid,SYSDATE,I+2,pComp_Aid,vComp_Mid,vEmp_Aid,vEMP_MID,vEMP_NAME,vBUSINESS,
                             vBUSINESS_UNIT_DESC,vBUSINESS_UNIT,vDESCRIPTION,vJOB_BAND,vGRADE,vHIRE_DATE_NEW,vEMAIL_ID,vEXIT_TYPE,vDATE_OF_SEPARATION_NEW,vNOTICE_PERIOD_DAYS,
                             vPL_TO_BE_ENCASHED,vTENURE_MONTHS,VRECOVERY_DAYS,vCOMMENTS,vCOL1,vCOL2,vCOL3,vCOL4,vCOL5,vCOL6,vCOL7,
                             vCOL8,vCOL9,vCOL10,vCOL11,vCOL12,vCOL13,vCOL14,vCOL15,vCOL16,vCOL17,vCOL18,vCOL19,vCOL20,vCOL21,vCOL22,vCOL23,vCOL24,vCOL25,
                             vCOL26,vCOL27,vCOL28,vCOL29,vCOL30,vCOL31,vCOL32,vCOL33,vCOL34,vCOL35,vCOL36,vCOL37,vCOL38,vCOL39,vCOL40,vCOL41,vCOL42,vCOL43,
                             vCOL44,vCOL45,vCOL46,vCOL47,vCOL48,vCOL49,vCOL50,vCOL51,vCOL52,vCOL53,vCOL54,vCOL55,vCOL56,vCOL57,vCOL58,vCOL59,vCOL60,vCOL61,
                             vCOL62,vCOL63,vCOL64,VSCHEMA_TRANS_DBLINK);
                    END IF;

                    <<PRINT_ERROR>>
                    /*Inserting Uploaded data as it is in Upload File*/
                    INSERT INTO HR_TEMP_RAW_UPLOAD_NEW (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,ROW_NO,
                                   COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,---col12 to start Clearance
                                   COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,
                                   COL41,COL42,COL43,COL44,COL45,COL46,COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,COL60,
                                   COL61,COL62,COL63,COL64,COL65,COL66,COL67,COL68,COL69,COL70,COL71,COL72,COL73,COL74,COL75,COL76,COL77,COL78,COL79,COL80,COL81,COL82)
                    VALUES( vUpldBatch_Id,pSessionId, pUser_Aid, vBacth_Id, pUpload_Aid, SYSDATE , NVL(vERROR_FLAG,'N'),vERROR_MSG,I+2,
                            vCOMP_MID,vEMP_MID,vEMP_NAME,vBUSINESS,vBUSINESS_UNIT_DESC,vBUSINESS_UNIT,vDESCRIPTION,vJOB_BAND,vGRADE,vHIRE_DATE_NEW,vEMAIL_ID,
                            vEXIT_TYPE,vDATE_OF_SEPARATION_NEW,vNOTICE_PERIOD_DAYS,vPL_TO_BE_ENCASHED,vTENURE_MONTHS,VRECOVERY_DAYS,vCOMMENTS,
                            vCOL1,vCOL2,vCOL3,vCOL4,vCOL5,vCOL6,vCOL7,vCOL8,vCOL9,vCOL10,vCOL11,vCOL12,vCOL13,vCOL14,vCOL15,vCOL16,vCOL17,vCOL18,vCOL19,
                            vCOL20,vCOL21,vCOL22,vCOL23,vCOL24,vCOL25,vCOL26,vCOL27,vCOL28,vCOL29,vCOL30,vCOL31,vCOL32,vCOL33,vCOL34,vCOL35,vCOL36,vCOL37,
                            vCOL38,vCOL39,vCOL40,vCOL41,vCOL42,vCOL43,vCOL44,vCOL45,vCOL46,vCOL47,vCOL48,vCOL49,vCOL50,vCOL51,vCOL52,vCOL53,vCOL54,vCOL55,
                            vCOL56,vCOL57,vCOL58,vCOL59,vCOL60,vCOL61,vCOL62,vCOL63,vCOL64);


                 END LOOP;
               --Inserting Upload Summary
             PY_PK_SFTP_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , 'ADD' , vUpldBatch_Id);

               FOR J IN (SELECT  ROWNUM SRNO,COL1 COMP_AID,COL2 COMP_MID,COL3 EMP_AID,COL4 EMP_MID,COL5 EMP_NAME,COL6 BUSINESS,COL7 BUSINESS_UNIT_DESC,
                                COL8 BUSINESS_UNIT,COL9 DESCRIPTION,COL10 JOB_BAND,COL11 GRADE,COL12 HIRE_DATE,COL13 EMAIL_ID,COL14 EXIT_TYPE,
                                COL15 DATE_OF_SEPARATION,COL16 NOTICE_PERIOD_DAYS,COL17 PL_TO_BE_ENCASHED,COL18 TENURE_MONTHS,COL19 RECOVERY_DAYS,
                                COL20 COMMENTS,COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,
                                COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,
                                COL56,COL57,COL58,COL59,COL60,COL61,COL62,COL63,COL64,COL65,COL66,COL67,COL68,COL69,COL70,COL71,COL72,COL73,COL74,
                                COL75,COL76,COL77,COL78,COL79,COL80,COL81,COL82,COL83,COL84,USER_AID USER_CR,BATCH_ID,COL85 DBLINK_EMP
                         FROM HR_PT_FINAL_UPLOAD_DATA_NEW WHERE UPLOAD_BATCH_ID = vUpldBatch_Id AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId )

                LOOP

--                        DELETE FROM EMP_CLEARANCE WHERE COMP_AID = J.COMP_AID AND EMP_AID= J.EMP_AID AND BUSINESS = J.BUSINESS;
               IF J.DBLINK_EMP='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN
                        INSERT INTO EMP_CLEARANCE@DBLINK_ABG_OP_BIRLACHEM_UAT(COMP_AID,EMP_AID,EMP_MID,EMP_NAME,BUSINESS,BUSINESS_UNIT_DESC,BUSINESS_UNIT,DESCRIPTION,
                                                  JOB_BAND,GRADE,HIRE_DATE,EMAIL_ID,EXIT_TYPE,DATE_OF_SEPARATION,NOTICE_PERIOD_DAYS,
                                                  PL_TO_BE_ENCASHED,TENURE_MONTHS,RECOVERY_DAYS,BATCH_ID,USER_CR,DATE_CR,USER_UP,
                                                  DATE_UP,USER_AT,DATE_AT,ROW_NO,COMMENTS,COL1,COL2,COL3,COL4,COL5,COL6,COL7,
                                                  COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,
                                                  COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,
                                                  COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                                                  COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,
                                                  COL60,COL61,COL62,COL63,COL64)
                          VALUES (J.COMP_AID,J.EMP_AID,J.EMP_MID,J.EMP_NAME,J.BUSINESS,J.BUSINESS_UNIT_DESC,J.BUSINESS_UNIT,J.DESCRIPTION,
                                  J.JOB_BAND,J.GRADE,J.HIRE_DATE,J.EMAIL_ID,J.EXIT_TYPE,TO_DATE(J.DATE_OF_SEPARATION),J.NOTICE_PERIOD_DAYS,
                                  J.PL_TO_BE_ENCASHED,J.TENURE_MONTHS,J.RECOVERY_DAYS,J.BATCH_ID,J.USER_CR,SYSDATE,NULL,NULL,NULL,NULL,
                                  J.SRNO,J.COMMENTS,J.COL21,J.COL22,J.COL23,J.COL24,J.COL25,J.COL26,J.COL27,J.COL28,J.COL29,J.COL30,
                                  J.COL31,J.COL32,J.COL33,J.COL34,J.COL35,J.COL36,J.COL37,J.COL38,J.COL39,J.COL40,J.COL41,J.COL42,J.COL43,
                                  J.COL44,J.COL45,J.COL46,J.COL47,J.COL48,J.COL49,J.COL50,J.COL51,J.COL52,J.COL53,J.COL54,J.COL55,J.COL56,
                                  J.COL57,J.COL58,J.COL59,J.COL60,J.COL61,J.COL62,J.COL63,J.COL64,J.COL65,J.COL66,J.COL67,J.COL68,J.COL69,
                                  J.COL70,J.COL71,J.COL72,J.COL73,J.COL74,J.COL75,J.COL76,J.COL77,J.COL78,J.COL79,J.COL80,J.COL81,J.COL82,
                                  J.COL83,J.COL84);

                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                        WHERE  EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID AND LEAVE_DATE IS NOT NULL;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;
                     
                     
                 IF vChkRecordCount=0 THEN
                 update GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT set LEAVE_DATE=J.DATE_OF_SEPARATION where EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID;
                 END IF;
               ELSIF J.DBLINK_EMP='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN 
                                         INSERT INTO EMP_CLEARANCE@DBLINK_ABG_OP_ABGHINDALCO_UAT(COMP_AID,EMP_AID,EMP_MID,EMP_NAME,BUSINESS,BUSINESS_UNIT_DESC,BUSINESS_UNIT,DESCRIPTION,
                                                  JOB_BAND,GRADE,HIRE_DATE,EMAIL_ID,EXIT_TYPE,DATE_OF_SEPARATION,NOTICE_PERIOD_DAYS,
                                                  PL_TO_BE_ENCASHED,TENURE_MONTHS,RECOVERY_DAYS,BATCH_ID,USER_CR,DATE_CR,USER_UP,
                                                  DATE_UP,USER_AT,DATE_AT,ROW_NO,COMMENTS,COL1,COL2,COL3,COL4,COL5,COL6,COL7,
                                                  COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,
                                                  COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,
                                                  COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                                                  COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,
                                                  COL60,COL61,COL62,COL63,COL64)
                          VALUES (J.COMP_AID,J.EMP_AID,J.EMP_MID,J.EMP_NAME,J.BUSINESS,J.BUSINESS_UNIT_DESC,J.BUSINESS_UNIT,J.DESCRIPTION,
                                  J.JOB_BAND,J.GRADE,J.HIRE_DATE,J.EMAIL_ID,J.EXIT_TYPE,TO_DATE(J.DATE_OF_SEPARATION),J.NOTICE_PERIOD_DAYS,
                                  J.PL_TO_BE_ENCASHED,J.TENURE_MONTHS,J.RECOVERY_DAYS,J.BATCH_ID,J.USER_CR,SYSDATE,NULL,NULL,NULL,NULL,
                                  J.SRNO,J.COMMENTS,J.COL21,J.COL22,J.COL23,J.COL24,J.COL25,J.COL26,J.COL27,J.COL28,J.COL29,J.COL30,
                                  J.COL31,J.COL32,J.COL33,J.COL34,J.COL35,J.COL36,J.COL37,J.COL38,J.COL39,J.COL40,J.COL41,J.COL42,J.COL43,
                                  J.COL44,J.COL45,J.COL46,J.COL47,J.COL48,J.COL49,J.COL50,J.COL51,J.COL52,J.COL53,J.COL54,J.COL55,J.COL56,
                                  J.COL57,J.COL58,J.COL59,J.COL60,J.COL61,J.COL62,J.COL63,J.COL64,J.COL65,J.COL66,J.COL67,J.COL68,J.COL69,
                                  J.COL70,J.COL71,J.COL72,J.COL73,J.COL74,J.COL75,J.COL76,J.COL77,J.COL78,J.COL79,J.COL80,J.COL81,J.COL82,
                                  J.COL83,J.COL84);

                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                        WHERE  EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID AND LEAVE_DATE IS NOT NULL;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;
                     
                     
                 IF vChkRecordCount=0 THEN
                 update GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT set LEAVE_DATE=J.DATE_OF_SEPARATION where EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID;
                 END IF;
               ELSE  
                 
                                         INSERT INTO EMP_CLEARANCE(COMP_AID,EMP_AID,EMP_MID,EMP_NAME,BUSINESS,BUSINESS_UNIT_DESC,BUSINESS_UNIT,DESCRIPTION,
                                                  JOB_BAND,GRADE,HIRE_DATE,EMAIL_ID,EXIT_TYPE,DATE_OF_SEPARATION,NOTICE_PERIOD_DAYS,
                                                  PL_TO_BE_ENCASHED,TENURE_MONTHS,RECOVERY_DAYS,BATCH_ID,USER_CR,DATE_CR,USER_UP,
                                                  DATE_UP,USER_AT,DATE_AT,ROW_NO,COMMENTS,COL1,COL2,COL3,COL4,COL5,COL6,COL7,
                                                  COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,
                                                  COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,
                                                  COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                                                  COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,
                                                  COL60,COL61,COL62,COL63,COL64)
                          VALUES (J.COMP_AID,J.EMP_AID,J.EMP_MID,J.EMP_NAME,J.BUSINESS,J.BUSINESS_UNIT_DESC,J.BUSINESS_UNIT,J.DESCRIPTION,
                                  J.JOB_BAND,J.GRADE,J.HIRE_DATE,J.EMAIL_ID,J.EXIT_TYPE,TO_DATE(J.DATE_OF_SEPARATION),J.NOTICE_PERIOD_DAYS,
                                  J.PL_TO_BE_ENCASHED,J.TENURE_MONTHS,J.RECOVERY_DAYS,J.BATCH_ID,J.USER_CR,SYSDATE,NULL,NULL,NULL,NULL,
                                  J.SRNO,J.COMMENTS,J.COL21,J.COL22,J.COL23,J.COL24,J.COL25,J.COL26,J.COL27,J.COL28,J.COL29,J.COL30,
                                  J.COL31,J.COL32,J.COL33,J.COL34,J.COL35,J.COL36,J.COL37,J.COL38,J.COL39,J.COL40,J.COL41,J.COL42,J.COL43,
                                  J.COL44,J.COL45,J.COL46,J.COL47,J.COL48,J.COL49,J.COL50,J.COL51,J.COL52,J.COL53,J.COL54,J.COL55,J.COL56,
                                  J.COL57,J.COL58,J.COL59,J.COL60,J.COL61,J.COL62,J.COL63,J.COL64,J.COL65,J.COL66,J.COL67,J.COL68,J.COL69,
                                  J.COL70,J.COL71,J.COL72,J.COL73,J.COL74,J.COL75,J.COL76,J.COL77,J.COL78,J.COL79,J.COL80,J.COL81,J.COL82,
                                  J.COL83,J.COL84);

                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM GM_EMP
                        WHERE  EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID AND LEAVE_DATE IS NOT NULL;
                     FETCH curRec INTO vChkRecordCount;
                     CLOSE  curRec;
                     
                     
                 IF vChkRecordCount=0 THEN
                 update GM_EMP set LEAVE_DATE=J.DATE_OF_SEPARATION where EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID;
                 END IF;
               END IF;  

                END LOOP;


               PY_PK_SFTP_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);


         END IF;

          OPEN Return_Recordset FOR
                SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

          COMMIT;

                OPEN Return_Recordset FOR
                     SELECT 0 STATUS,vUpldBatch_Id UPLOAD_BATCH_ID,'SUCCESS:: Data commited successfully' ErrMessage FROM DUAL;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                vERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_EMP_CLEARANCE_UPLOAD' ,vERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,vERROR_MSG ErrMessage  FROM DUAL;


    END;  

 PROCEDURE PRO_EMP_CLEARANCE_UPLOAD_NEW(-----Created By Saroj Kumar Giri for Employee  Clearance
    pOperationType   VARCHAR2,
    pComp_Aid        VARCHAR2,
    pAcc_Year        VARCHAR2,
    pUser_Aid        VARCHAR2,
    pSessionId       VARCHAR2,
    pUpload_Aid      VARCHAR2,
    pRawXmlData      CLOB,
    pTrans_Type      VARCHAR2,
    pUpload_Batch_Id VARCHAR2,
    Return_Recordset OUT REC)
    AS
    TYPE refCUR IS REF CURSOR;
    TYPE clear_emp_ver IS RECORD(
    ERROR_MSG              VARCHAR2(2000),
    ERROR_FLAG             VARCHAR2(1),
    ChkRecordCount         NUMBER,
    HIRE_DATE              VARCHAR2(20),
    HIRE_DATE_NEW          DATE,
    DATE_OF_SEPARATION_NEW DATE,
    DATE_OF_SEPARATION     VARCHAR2(20),
    Paygroup               VARCHAR2(20),
    COMP_ID                VARCHAR2(8),
    VSCHEMA_TRANS_DBLINK    VARCHAR2(30));
    
    k                     clear_emp_ver;
    curRec                      refCUR;
    TEMP_CUR                    refCUR;
    cRes                        refCUR;
    cOUT_TEMP                   refCUR;
    vXmlParser                  dbms_xmlparser.Parser;
    vXmlDomDocument             dbms_xmldom.DOMDocument;
    vXmlDOMNodeList             dbms_xmldom.DOMNodeList;
    vXmlDOMNode                 dbms_xmldom.DOMNode;
    s PY_PM_UPLOAD_STATUS_HD%ROWTYPE;
    a PY_PT_LEAVE_BAL%ROWTYPE;
    r GM_COMP%ROWTYPE;
    o GM_EMP%ROWTYPE;
    j EMP_CLEARANCE%ROWTYPE;
    vDBLINK_NOT_TRACED       EXCEPTION;

     BEGIN

INSERT INTO PRO_EMP_CLEARANCE_UPLOAD_TEMP VALUES(pRawXmlData,pUpload_Aid,SYSDATE);
INSERT INTO PRO_EMP_CLEARANCE_UPLOAD_TEMP1 VALUES(pOperationType||'@'||pComp_Aid||'@'||pAcc_Year||'@'||pUser_Aid||'@'||pSessionId||'@'||pUpload_Aid||'@'||pTrans_Type||'@'||pUpload_Batch_Id,SYSDATE);
COMMIT;
      IF pOperationType = 'RAW_UPLOAD' THEN

--            insert into VAICLOB(ABC, UPLOAD_AID) 
--                   values(pRawXmlData,pUpload_Aid);
--                   COMMIT;
--            INSERT INTO OSO VALUES(' 1- '||pOperationType||' 2- '||pComp_Aid||' 3- '||pAcc_Year||' 4- '||pUser_Aid||' 5- '||pSessionId||' 6- '||pUpload_Aid||' 7- '||pTrans_Type||' 8- '||pUpload_Batch_Id,SYSDATE);
--            COMMIT;
            s.UPLOAD_BATCH_ID := PY_PK_SFTP_STANDARD_UPLOADS.FN_GET_UPLOAD_BATCH_ID(pUpload_Aid);

            vXmlParser    := dbms_xmlparser.newParser;

            dbms_xmlparser.parseClob(vXmlParser, pRawXmlData);

            vXmlDomDocument := dbms_xmlparser.getDocument(vXmlParser);

            vXmlDOMNodeList := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(vXmlDomDocument),'/NewDataSet/ExcelInfo');

            FOR  I IN 0 .. dbms_xmldom.getLength(vXmlDOMNodeList) - 1 LOOP

                        k.DATE_OF_SEPARATION_NEW:=NULL;
                        o.EMP_MID            := NULL;
                        o.EMP_NAME           := NULL;
                        j.BUSINESS           := NULL;
                        j.BUSINESS_UNIT_DESC := NULL;
                        j.BUSINESS_UNIT      := NULL;
                        j.DESCRIPTION        := NULL;
                        j.JOB_BAND           := NULL;
                        j.GRADE              := NULL;
                        k.HIRE_DATE          := NULL;
                        j.EMAIL_ID           := NULL;
                        j.EXIT_TYPE          := NULL;
                        k.DATE_OF_SEPARATION := NULL;
                        j.NOTICE_PERIOD_DAYS := NULL;
                        j.PL_TO_BE_ENCASHED  := NULL;
                        j.TENURE_MONTHS      := NULL;
                        j.RECOVERY_DAYS      := NULL;
                        j.COMMENTS           := NULL;
                        j.COL1               := NULL;
                        j.COL2               := NULL;
                        j.COL3               := NULL;
                        j.COL4               := NULL;
                        j.COL5               := NULL;
                        j.COL6               := NULL;
                        j.COL7               := NULL;
                        j.COL8               := NULL;
                        j.COL9               := NULL;
                        j.COL10              := NULL;
                        j.COL11              := NULL;
                        j.COL12              := NULL;
                        j.COL13              := NULL;
                        j.COL14              := NULL;
                        j.COL15              := NULL;
                        j.COL16              := NULL;
                        j.COL17              := NULL;
                        j.COL18              := NULL;
                        j.COL19              := NULL;
                        j.COL20              := NULL;
                        j.COL21              := NULL;
                        j.COL22              := NULL;
                        j.COL23              := NULL;
                        j.COL24              := NULL;
                        j.COL25              := NULL;
                        j.COL26              := NULL;
                        j.COL27              := NULL;
                        j.COL28              := NULL;
                        j.COL29              := NULL;
                        j.COL30              := NULL;
                        j.COL31              := NULL;
                        j.COL32              := NULL;
                        j.COL33              := NULL;
                        j.COL34              := NULL;
                        j.COL35              := NULL;
                        j.COL36              := NULL;
                        j.COL37              := NULL;
                        j.COL38              := NULL;
                        j.COL39              := NULL;
                        j.COL40              := NULL;
                        j.COL41              := NULL;
                        j.COL42              := NULL;
                        j.COL43              := NULL;
                        j.COL44              := NULL;
                        j.COL45              := NULL;
                        j.COL46              := NULL;
                        j.COL47              := NULL;
                        j.COL48              := NULL;
                        j.COL49              := NULL;
                        j.COL50              := NULL;
                        j.COL51              := NULL;
                        j.COL52              := NULL;
                        j.COL53              := NULL;
                        j.COL54              := NULL;
                        j.COL55              := NULL;
                        j.COL56              := NULL;
                        j.COL57              := NULL;
                        j.COL58              := NULL;
                        j.COL59              := NULL;
                        j.COL60              := NULL;
                        j.COL61              := NULL;
                        j.COL62              := NULL;
                        j.COL63              := NULL;
                        j.COL64              := NULL;
                        k.COMP_ID            := NULL; 
                        k.VSCHEMA_TRANS_DBLINK  := NULL; 
                        k.Paygroup            :=NULL;  


                vXmlDOMNode := dbms_xmldom.item(vXmlDOMNodeList, I);

                k.ERROR_MSG:= 'Sucess';
                k.ERROR_FLAG:='N';
delete oso_cl;
commit;

                 BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'PAY_GROUP/text()',k.Paygroup);
                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        k.ERROR_MSG:='Invalid value for Pay Group (Max limit is 20 character)';
                        k.ERROR_FLAG:='Y';
                       ELSE
                        k.ERROR_FLAG:='Y';
                        k.ERROR_MSG:='Invalid value for Pay Group';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;

               ------------------------------------------------Employee Code

                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_MID/text()',o.EMP_MID);

                     EXCEPTION
                      WHEN OTHERS THEN
                       IF (SQLCODE ='-24331') THEN
                        k.ERROR_MSG:='Invalid value for Employee Code (Max limit is 8 character)';
                        k.ERROR_FLAG:='Y';
                       ELSE
                        k.ERROR_FLAG:='Y';
                        k.ERROR_MSG:='Invalid value for Employee Code';
                       END IF;
                      GOTO PRINT_ERROR;
                    END;
           INSERT INTO oso_cl VALUES (o.EMP_MID||'-'||'o.EMP_MID',1);
           COMMIT;
               ------------------------------------------------Employee Name
                       BEGIN
                           dbms_xslprocessor.valueOf(vXmlDOMNode,'EMP_NAME/text()',o.EMP_NAME);
                      EXCEPTION
                       WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for Employee Name';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for Employee Name ';
                           END IF;
                      GOTO PRINT_ERROR;
                     END;
           INSERT INTO oso_cl VALUES (o.EMP_NAME||'-'||'o.EMP_NAME',2);
           COMMIT;

               ------------------------------------------------BUSINESS

                    BEGIN
                         dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS/text()',j.BUSINESS);
                     EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for Business';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for Business ';
                           END IF;
                      GOTO PRINT_ERROR;
                    END;
           INSERT INTO oso_cl VALUES (j.BUSINESS||'-'||'j.BUSINESS',3);
           COMMIT;

               ------------------------------------------------BUSINESS_UNIT_DESC


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS_UNIT_DESC/text()',j.BUSINESS_UNIT_DESC);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for Business Unit Description';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for Business Unit Description ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (j.BUSINESS_UNIT_DESC||'-'||'j.BUSINESS_UNIT_DESC',4);
           COMMIT;

               ------------------------------------------------ BUSINESS_UNIT


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'BUSINESS_UNIT/text()',j.BUSINESS_UNIT);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Business Unit';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Business Unit ';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (j.BUSINESS_UNIT||'-'||'j.BUSINESS_UNIT',5);
           COMMIT;


               ------------------------------------------------ DESCRIPTION


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'DESCRIPTION/text()',j.DESCRIPTION);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Description';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Description';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (j.DESCRIPTION||'-'||'j.DESCRIPTION',6);
           COMMIT;


               ------------------------------------------------ JOB_BAND


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'JOB_BAND/text()',j.JOB_BAND);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Job Band';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Job Band';
                           END IF;
                      GOTO PRINT_ERROR;
                END;

           INSERT INTO oso_cl VALUES (j.JOB_BAND||'-'||'j.JOB_BAND',7);
           COMMIT;



               ------------------------------------------------ GRADE


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'GRADE/text()',j.GRADE);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Grade';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Grade';
                           END IF;
                      GOTO PRINT_ERROR;
                END;


           INSERT INTO oso_cl VALUES (j.GRADE||'-'||'j.GRADE',8);
           COMMIT;


               ------------------------------------------------ HIRE_DATE


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'HIRE_DATE/text()',k.HIRE_DATE);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Hire Date';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Hire Date';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (k.HIRE_DATE||'-'||'k.HIRE_DATE',9);
           COMMIT;

               ------------------------------------------------ EMAIL_ID


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EMAIL_ID/text()',j.EMAIL_ID);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Email Id';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for   Email Id';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (j.EMAIL_ID||'-'||'j.EMAIL_ID',10);
           COMMIT;


               ------------------------------------------------ EXIT_TYPE


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'EXIT_TYPE/text()',j.EXIT_TYPE);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Exit Type )';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Exit Type';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (j.EXIT_TYPE||'-'||'j.EXIT_TYPE',11);
           COMMIT;

               ------------------------------------------------ DATE_OF_SEPARATION


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'DATE_OF_SEPARATION/text()',k.DATE_OF_SEPARATION);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Date Of Separation';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Date Of Separation';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (k.DATE_OF_SEPARATION||'-'||'k.DATE_OF_SEPARATION',12);
           COMMIT;

               ------------------------------------------------ NOTICE_PERIOD_DAYS


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'NOTICE_PERIOD_DAYS/text()',j.NOTICE_PERIOD_DAYS);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Notice Period Days';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Notice Period Days';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (j.NOTICE_PERIOD_DAYS||'-'||'j.NOTICE_PERIOD_DAYS',13);
           COMMIT;

               ------------------------------------------------ PL_TO_BE_ENCASHED


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'PL_TO_BE_ENCASHED/text()',j.PL_TO_BE_ENCASHED);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Pl To Be Encashed ';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Pl To Be Encashed';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (j.PL_TO_BE_ENCASHED||'-'||'j.PL_TO_BE_ENCASHED',14);
           COMMIT;

               ------------------------------------------------ TENURE_MONTHS


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'TENURE_MONTHS/text()',j.TENURE_MONTHS);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Tenure(Months)';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Tenure(Months)';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (j.TENURE_MONTHS||'-'||'j.TENURE_MONTHS',15);
           COMMIT;


               ------------------------------------------------ RECOVERY_DAYS


                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'RECOVERY_DAYS/text()',j.RECOVERY_DAYS);
                   EXCEPTION
                      WHEN OTHERS THEN
                           IF (SQLCODE ='-24331') THEN
                            k.ERROR_MSG:='Invalid value for  Recovery Days';
                            k.ERROR_FLAG:='Y';
                           ELSE
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid value for  Recovery Days';
                           END IF;
                      GOTO PRINT_ERROR;
                END;
           INSERT INTO oso_cl VALUES (j.RECOVERY_DAYS||'-'||'j.RECOVERY_DAYS',16);
           COMMIT;


            ------------------------------------- Clearance

                BEGIN
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COMMENTS/text()',j.COMMENTS);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL1/text()',j.COL1);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL2/text()',j.COL2);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance1(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL3/text()',j.COL3);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL4/text()',j.COL4);

                    IF j.COL1 IS NOT NULL THEN
                       IF j.COL2 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance1 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
---------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL5/text()',j.COL5);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL6/text()',j.COL6);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance2(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL7/text()',j.COL7);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL8/text()',j.COL8);

                    IF j.COL5 IS NOT NULL THEN
                       IF j.COL6 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance2 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL9/text()',j.COL9);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL10/text()',j.COL10);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance3(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL11/text()',j.COL11);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL12/text()',j.COL12);

                  IF j.COL9 IS NOT NULL THEN
                       IF j.COL10 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance3 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL13/text()',j.COL13);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL14/text()',j.COL14);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance4(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL15/text()',j.COL15);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL16/text()',j.COL16);

                  IF j.COL13 IS NOT NULL THEN
                       IF j.COL14 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance4 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL17/text()',j.COL17);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL18/text()',j.COL18);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance5(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL19/text()',j.COL19);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL20/text()',j.COL20);

                  IF j.COL17 IS NOT NULL THEN
                       IF j.COL18 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance5 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL21/text()',j.COL21);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL22/text()',j.COL22);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance6(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL23/text()',j.COL23);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL24/text()',j.COL24);

                  IF j.COL21 IS NOT NULL THEN
                       IF j.COL22 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance6 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL25/text()',j.COL25);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL26/text()',j.COL26);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance7(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL27/text()',j.COL27);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL28/text()',j.COL28);

                  IF j.COL25 IS NOT NULL THEN
                       IF j.COL26 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance7 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL29/text()',j.COL29);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL30/text()',j.COL30);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance8(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL31/text()',j.COL31);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL32/text()',j.COL32);

                  IF j.COL29 IS NOT NULL THEN
                       IF j.COL30 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance8 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL33/text()',j.COL33);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL34/text()',j.COL34);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance9(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL35/text()',j.COL35);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL36/text()',j.COL36);

                  IF j.COL33 IS NOT NULL THEN
                       IF j.COL34 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance9 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL37/text()',j.COL37);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL38/text()',j.COL38);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance10(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL39/text()',j.COL39);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL40/text()',j.COL40);

                  IF j.COL37 IS NOT NULL THEN
                       IF j.COL38 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance10 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL41/text()',j.COL41);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL42/text()',j.COL42);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance11(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL43/text()',j.COL43);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL44/text()',j.COL44);

                  IF j.COL41 IS NOT NULL THEN
                       IF j.COL42 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance11 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL45/text()',j.COL45);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL46/text()',j.COL46);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance12(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL47/text()',j.COL47);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL48/text()',j.COL48);

                  IF j.COL45 IS NOT NULL THEN
                       IF j.COL46 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance12 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL49/text()',j.COL49);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL50/text()',j.COL50);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance13(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL51/text()',j.COL51);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL52/text()',j.COL52);

                  IF j.COL49 IS NOT NULL THEN
                       IF j.COL50 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance13 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL53/text()',j.COL53);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL54/text()',j.COL54);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance14(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL55/text()',j.COL55);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL56/text()',j.COL56);

                  IF j.COL53 IS NOT NULL THEN
                       IF j.COL54 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance14 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL57/text()',j.COL57);
                  BEGIN
                     dbms_xslprocessor.valueOf(vXmlDOMNode,'COL58/text()',j.COL58);
                    EXCEPTION
                       WHEN OTHERS THEN
                            k.ERROR_FLAG:='Y';
                            k.ERROR_MSG:='Invalid Amount in Clearance15(Amount Should be in Numbers)';
                       GOTO PRINT_ERROR;
                  END;
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL59/text()',j.COL59);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL60/text()',j.COL60);

                  IF j.COL57 IS NOT NULL THEN
                       IF j.COL58 IS NULL THEN
                           k.ERROR_FLAG:='Y';
                           k.ERROR_MSG:='Clearance15 Amount cannot be blank';
                           GOTO PRINT_ERROR;
                       END IF;
                    END IF;
-----------------------------------------------------------------------------

                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL61/text()',j.COL61);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL62/text()',j.COL62);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL63/text()',j.COL63);
                  dbms_xslprocessor.valueOf(vXmlDOMNode,'COL64/text()',j.COL64);

                END ;
----===========  saroj 06-nov-19
--     OPEN curRec FOR---COMMENTED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
--     select COMP_MID from gm_comp where COMP_ID=pComp_Aid;
--     FETCH curRec INTO r.COMP_MID;
--     CLOSE curRec;
----=====================
 
--            IF SUBSTR(pComp_Aid,2,1)='H' THEN ---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
--               k.COMP_ID:=REPLACE(pComp_Aid,'H','M');
--               k.VSCHEMA_TRANS_DBLINK:='DBLINK_ABG_OP_ABGHINDALCO_UAT';
--            ELSIF SUBSTR(pComp_Aid,2,1)='B' THEN 
--               k.COMP_ID:=REPLACE(pComp_Aid,'B','M'); 
--               k.VSCHEMA_TRANS_DBLINK:='DBLINK_ABG_OP_BIRLACHEM_UAT';
--            ELSIF SUBSTR(pComp_Aid,2,1)='A' THEN   
--               k.COMP_ID:=REPLACE(pComp_Aid,'A','M');
--               k.VSCHEMA_TRANS_DBLINK:='ABGGROUP';
--            END IF;
--
--             IF k.VSCHEMA_TRANS_DBLINK IS NULL THEN  
--               RAISE DBLINK_NOT_TRACED;
--             END IF;  

              OPEN CURREC for
                  SELECT COMP_ID,'DBLINK_ABG_OP_ABGHINDALCO_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                  WHERE  BUSINESS_NATURE_ID=k.Paygroup
                  UNION ALL
                  SELECT COMP_ID,'DBLINK_ABG_OP_BIRLACHEM_UAT' 
                  FROM GM_COMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                  WHERE  BUSINESS_NATURE_ID=k.Paygroup
                  UNION ALL
                  SELECT COMP_ID,'ABGGROUP' 
                  FROM GM_COMP
                  WHERE  BUSINESS_NATURE_ID=k.Paygroup;
                FETCH CURREC INTO k.COMP_ID,k.VSCHEMA_TRANS_DBLINK;
              CLOSE  CURREC;
            
           IF k.VSCHEMA_TRANS_DBLINK IS NULL THEN  
                k.ERROR_FLAG:='Y';
                k.ERROR_MSG:='Unable to track employee '||o.EMP_MID||  ' group company';
                GOTO PRINT_ERROR;
           END IF;  
    

            
            IF k.VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                OPEN curRec FOR
                   select COMP_MID from gm_comp@DBLINK_ABG_OP_BIRLACHEM_UAT
                   where COMP_ID=k.COMP_ID;
                  FETCH curRec INTO r.COMP_MID;
                CLOSE curRec;
            ELSIF k.VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN     
                 OPEN curRec FOR
                   select COMP_MID from gm_comp@DBLINK_ABG_OP_ABGHINDALCO_UAT
                   where COMP_ID=k.COMP_ID;
                  FETCH curRec INTO r.COMP_MID;
                CLOSE curRec;
            ELSE                    
                 OPEN curRec FOR
                   select COMP_MID from gm_comp
                   where COMP_ID=k.COMP_ID;
                  FETCH curRec INTO r.COMP_MID;
                CLOSE curRec;
            END IF;
            
                    k.HIRE_DATE_NEW:= DATE_RETURN(k.HIRE_DATE);
                    k.DATE_OF_SEPARATION_NEW:=DATE_RETURN(k.DATE_OF_SEPARATION) ;
--vComp_Aid                    vComp_Aid:=HR_PK_VALIDATION.FN_GET_MARSHA_TO_COMP_AID(j.BUSINESS);
                    
                   --o.Emp_id:=HR_PK_VALIDATION.FN_GET_EMP_AID(pComp_Aid, o.EMP_MID);---COMMENTED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
              
               IF k.VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT.    
                   OPEN curRec FOR 
                    SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(k.COMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(o.EMP_MID));
                    FETCH curRec INTO o.Emp_id;
                    CLOSE  curRec;
               ELSIF k.VSCHEMA_TRANS_DBLINK='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN      
                    OPEN curRec FOR
                    SELECT EMP_ID FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(k.COMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(o.EMP_MID));
                    FETCH curRec INTO o.Emp_id;
                    CLOSE  curRec; 
               ELSE     
                    OPEN curRec FOR
                    SELECT EMP_ID FROM GM_EMP---ADDED BY ANISH BHOIL ON 13TH FEB 2020, FOR 3 IN 1 CONCEPT. 
                            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(k.COMP_ID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(o.EMP_MID));
                    FETCH curRec INTO o.Emp_id;
                    CLOSE  curRec; 
               END IF;          

--vComp_Aid:=HR_PK_VALIDATION.FN_GET_PAYGROUP_COMP_AID_new(o.EMP_MID);
--o.Emp_id:=HR_PK_VALIDATION.FN_GET_EMP_AID(vComp_Aid,o.EMP_MID);

--                    IF vComp_Aid IS NULL THEN
--                       k.ERROR_FLAG:='Y';
--                       k.ERROR_MSG:='Business cannot be blank';
--                       GOTO PRINT_ERROR;
--                    END IF;


                    IF o.Emp_id IS NULL THEN
                        k.ERROR_FLAG:='Y';
                        k.ERROR_MSG:='Employee Code'||o.EMP_MID||' Does Not Exist';
                        GOTO PRINT_ERROR;
                    END IF;


--                    OPEN curRec FOR
--                       SELECT COUNT(1)  FROM HR_TEMP_RAW_UPLOAD_NEW
--                        WHERE SESSION_ID = pSessionId AND USER_AID = pUSER_AID AND UPLOAD_AID = pUpload_Aid AND UPLOAD_BATCH_ID = s.UPLOAD_BATCH_ID
--                                AND COL1 = r.COMP_MID AND  COL2 = o.EMP_MID;-- AND  COL3 = vApproval_Date;
--                     FETCH curRec INTO k.ChkRecordCount;
--                     CLOSE  curRec;

--                     IF k.ChkRecordCount > 0 THEN
--                         k.ERROR_FLAG:='Y';
--                         k.ERROR_MSG:='Duplicate record found !';
--                         GOTO PRINT_ERROR;
--                     END IF;


                    /*Inserting Uploaded data in Insertable format*/
                    IF NVL(k.ERROR_FLAG,'N')='N' THEN

                      INSERT INTO HR_PT_FINAL_UPLOAD_DATA_NEW (UPLOAD_BATCH_ID,SESSION_ID, USER_AID, BATCH_ID, UPLOAD_AID, UPLOAD_DATE,ROW_NO,
                                   COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,---col12 to start Clearance
                                   COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,
                                   COL41,COL42,COL43,COL44,COL45,COL46,COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,COL60,
                                   COL61,COL62,COL63,COL64,COL65,COL66,COL67,COL68,COL69,COL70,COL71,COL72,COL73,COL74,COL75,COL76,COL77,COL78,COL79,COL80,COL81,COL82,COL83,COL84,COL85)

                      VALUES(s.UPLOAD_BATCH_ID,pSessionId, pUser_Aid, a.BATCH_ID, pUpload_Aid,SYSDATE,I+2,pComp_Aid,r.COMP_MID,o.Emp_id,o.EMP_MID,o.EMP_NAME,j.BUSINESS,
                             j.BUSINESS_UNIT_DESC,j.BUSINESS_UNIT,j.DESCRIPTION,j.JOB_BAND,j.GRADE,k.HIRE_DATE_NEW,j.EMAIL_ID,j.EXIT_TYPE,k.DATE_OF_SEPARATION_NEW,j.NOTICE_PERIOD_DAYS,
                             j.PL_TO_BE_ENCASHED,j.TENURE_MONTHS,j.RECOVERY_DAYS,j.COMMENTS,j.COL1,j.COL2,j.COL3,j.COL4,j.COL5,j.COL6,j.COL7,
                             j.COL8,j.COL9,j.COL10,j.COL11,j.COL12,j.COL13,j.COL14,j.COL15,j.COL16,j.COL17,j.COL18,j.COL19,j.COL20,j.COL21,j.COL22,j.COL23,j.COL24,j.COL25,
                             j.COL26,j.COL27,j.COL28,j.COL29,j.COL30,j.COL31,j.COL32,j.COL33,j.COL34,j.COL35,j.COL36,j.COL37,j.COL38,j.COL39,j.COL40,j.COL41,j.COL42,j.COL43,
                             j.COL44,j.COL45,j.COL46,j.COL47,j.COL48,j.COL49,j.COL50,j.COL51,j.COL52,j.COL53,j.COL54,j.COL55,j.COL56,j.COL57,j.COL58,j.COL59,j.COL60,j.COL61,
                             j.COL62,j.COL63,j.COL64,k.VSCHEMA_TRANS_DBLINK);
                    END IF;

                    <<PRINT_ERROR>>
                    /*Inserting Uploaded data as it is in Upload File*/
                    INSERT INTO HR_TEMP_RAW_UPLOAD_NEW (UPLOAD_BATCH_ID,SESSION_ID, USER_AID,BATCH_ID, UPLOAD_AID, UPLOAD_DATE, ERROR_FLAG, ERROR_MSG,ROW_NO,
                                   COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,---col12 to start Clearance
                                   COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,COL37,COL38,COL39,COL40,
                                   COL41,COL42,COL43,COL44,COL45,COL46,COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,COL60,
                                   COL61,COL62,COL63,COL64,COL65,COL66,COL67,COL68,COL69,COL70,COL71,COL72,COL73,COL74,COL75,COL76,COL77,COL78,COL79,COL80,COL81,COL82)
                    VALUES( s.UPLOAD_BATCH_ID,pSessionId, pUser_Aid, a.BATCH_ID, pUpload_Aid, SYSDATE , NVL(k.ERROR_FLAG,'N'),k.ERROR_MSG,I+2,
                            r.COMP_MID,o.EMP_MID,o.EMP_NAME,j.BUSINESS,j.BUSINESS_UNIT_DESC,j.BUSINESS_UNIT,j.DESCRIPTION,j.JOB_BAND,j.GRADE,k.HIRE_DATE_NEW,j.EMAIL_ID,
                            j.EXIT_TYPE,k.DATE_OF_SEPARATION_NEW,j.NOTICE_PERIOD_DAYS,j.PL_TO_BE_ENCASHED,j.TENURE_MONTHS,j.RECOVERY_DAYS,j.COMMENTS,
                            j.COL1,j.COL2,j.COL3,j.COL4,j.COL5,j.COL6,j.COL7,j.COL8,j.COL9,j.COL10,j.COL11,j.COL12,j.COL13,j.COL14,j.COL15,j.COL16,j.COL17,j.COL18,j.COL19,
                            j.COL20,j.COL21,j.COL22,j.COL23,j.COL24,j.COL25,j.COL26,j.COL27,j.COL28,j.COL29,j.COL30,j.COL31,j.COL32,j.COL33,j.COL34,j.COL35,j.COL36,j.COL37,
                            j.COL38,j.COL39,j.COL40,j.COL41,j.COL42,j.COL43,j.COL44,j.COL45,j.COL46,j.COL47,j.COL48,j.COL49,j.COL50,j.COL51,j.COL52,j.COL53,j.COL54,j.COL55,
                            j.COL56,j.COL57,j.COL58,j.COL59,j.COL60,j.COL61,j.COL62,j.COL63,j.COL64);


                 END LOOP;
               --Inserting Upload Summary
             PY_PK_SFTP_STANDARD_UPLOADS.INSERT_UPLOAD_SUMMARY(pComp_Aid ,pAcc_Year ,pUser_Aid ,pSessionId ,pUpload_Aid , 'ADD' , s.UPLOAD_BATCH_ID);

               FOR J IN (SELECT  ROWNUM SRNO,COL1 COMP_AID,COL2 COMP_MID,COL3 EMP_AID,COL4 EMP_MID,COL5 EMP_NAME,COL6 BUSINESS,COL7 BUSINESS_UNIT_DESC,
                                COL8 BUSINESS_UNIT,COL9 DESCRIPTION,COL10 JOB_BAND,COL11 GRADE,COL12 HIRE_DATE,COL13 EMAIL_ID,COL14 EXIT_TYPE,
                                COL15 DATE_OF_SEPARATION,COL16 NOTICE_PERIOD_DAYS,COL17 PL_TO_BE_ENCASHED,COL18 TENURE_MONTHS,COL19 RECOVERY_DAYS,
                                COL20 COMMENTS,COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,COL34,COL35,COL36,
                                COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,
                                COL56,COL57,COL58,COL59,COL60,COL61,COL62,COL63,COL64,COL65,COL66,COL67,COL68,COL69,COL70,COL71,COL72,COL73,COL74,
                                COL75,COL76,COL77,COL78,COL79,COL80,COL81,COL82,COL83,COL84,USER_AID USER_CR,BATCH_ID,COL85 DBLINK_EMP
                         FROM HR_PT_FINAL_UPLOAD_DATA_NEW WHERE UPLOAD_BATCH_ID = s.UPLOAD_BATCH_ID AND UPLOAD_AID = pUpload_Aid AND SESSION_ID = pSessionId )

                LOOP

--                        DELETE FROM EMP_CLEARANCE WHERE COMP_AID = J.COMP_AID AND EMP_AID= J.EMP_AID AND BUSINESS = J.BUSINESS;
               IF J.DBLINK_EMP='DBLINK_ABG_OP_BIRLACHEM_UAT' THEN
                        INSERT INTO EMP_CLEARANCE@DBLINK_ABG_OP_BIRLACHEM_UAT(COMP_AID,EMP_AID,EMP_MID,EMP_NAME,BUSINESS,BUSINESS_UNIT_DESC,BUSINESS_UNIT,DESCRIPTION,
                                                  JOB_BAND,GRADE,HIRE_DATE,EMAIL_ID,EXIT_TYPE,DATE_OF_SEPARATION,NOTICE_PERIOD_DAYS,
                                                  PL_TO_BE_ENCASHED,TENURE_MONTHS,RECOVERY_DAYS,BATCH_ID,USER_CR,DATE_CR,USER_UP,
                                                  DATE_UP,USER_AT,DATE_AT,ROW_NO,COMMENTS,COL1,COL2,COL3,COL4,COL5,COL6,COL7,
                                                  COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,
                                                  COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,
                                                  COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                                                  COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,
                                                  COL60,COL61,COL62,COL63,COL64)
                          VALUES (J.COMP_AID,J.EMP_AID,J.EMP_MID,J.EMP_NAME,J.BUSINESS,J.BUSINESS_UNIT_DESC,J.BUSINESS_UNIT,J.DESCRIPTION,
                                  J.JOB_BAND,J.GRADE,J.HIRE_DATE,J.EMAIL_ID,J.EXIT_TYPE,TO_DATE(J.DATE_OF_SEPARATION),J.NOTICE_PERIOD_DAYS,
                                  J.PL_TO_BE_ENCASHED,J.TENURE_MONTHS,J.RECOVERY_DAYS,J.BATCH_ID,J.USER_CR,SYSDATE,NULL,NULL,NULL,NULL,
                                  J.SRNO,J.COMMENTS,J.COL21,J.COL22,J.COL23,J.COL24,J.COL25,J.COL26,J.COL27,J.COL28,J.COL29,J.COL30,
                                  J.COL31,J.COL32,J.COL33,J.COL34,J.COL35,J.COL36,J.COL37,J.COL38,J.COL39,J.COL40,J.COL41,J.COL42,J.COL43,
                                  J.COL44,J.COL45,J.COL46,J.COL47,J.COL48,J.COL49,J.COL50,J.COL51,J.COL52,J.COL53,J.COL54,J.COL55,J.COL56,
                                  J.COL57,J.COL58,J.COL59,J.COL60,J.COL61,J.COL62,J.COL63,J.COL64,J.COL65,J.COL66,J.COL67,J.COL68,J.COL69,
                                  J.COL70,J.COL71,J.COL72,J.COL73,J.COL74,J.COL75,J.COL76,J.COL77,J.COL78,J.COL79,J.COL80,J.COL81,J.COL82,
                                  J.COL83,J.COL84);

                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT
                        WHERE  EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID AND LEAVE_DATE IS NOT NULL;
                     FETCH curRec INTO k.ChkRecordCount;
                     CLOSE  curRec;
                     
                     
                 IF k.ChkRecordCount=0 THEN
                 update GM_EMP@DBLINK_ABG_OP_BIRLACHEM_UAT set LEAVE_DATE=J.DATE_OF_SEPARATION where EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID;
                 END IF;
               ELSIF J.DBLINK_EMP='DBLINK_ABG_OP_ABGHINDALCO_UAT' THEN 
                                         INSERT INTO EMP_CLEARANCE@DBLINK_ABG_OP_ABGHINDALCO_UAT(COMP_AID,EMP_AID,EMP_MID,EMP_NAME,BUSINESS,BUSINESS_UNIT_DESC,BUSINESS_UNIT,DESCRIPTION,
                                                  JOB_BAND,GRADE,HIRE_DATE,EMAIL_ID,EXIT_TYPE,DATE_OF_SEPARATION,NOTICE_PERIOD_DAYS,
                                                  PL_TO_BE_ENCASHED,TENURE_MONTHS,RECOVERY_DAYS,BATCH_ID,USER_CR,DATE_CR,USER_UP,
                                                  DATE_UP,USER_AT,DATE_AT,ROW_NO,COMMENTS,COL1,COL2,COL3,COL4,COL5,COL6,COL7,
                                                  COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,
                                                  COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,
                                                  COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                                                  COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,
                                                  COL60,COL61,COL62,COL63,COL64)
                          VALUES (J.COMP_AID,J.EMP_AID,J.EMP_MID,J.EMP_NAME,J.BUSINESS,J.BUSINESS_UNIT_DESC,J.BUSINESS_UNIT,J.DESCRIPTION,
                                  J.JOB_BAND,J.GRADE,J.HIRE_DATE,J.EMAIL_ID,J.EXIT_TYPE,TO_DATE(J.DATE_OF_SEPARATION),J.NOTICE_PERIOD_DAYS,
                                  J.PL_TO_BE_ENCASHED,J.TENURE_MONTHS,J.RECOVERY_DAYS,J.BATCH_ID,J.USER_CR,SYSDATE,NULL,NULL,NULL,NULL,
                                  J.SRNO,J.COMMENTS,J.COL21,J.COL22,J.COL23,J.COL24,J.COL25,J.COL26,J.COL27,J.COL28,J.COL29,J.COL30,
                                  J.COL31,J.COL32,J.COL33,J.COL34,J.COL35,J.COL36,J.COL37,J.COL38,J.COL39,J.COL40,J.COL41,J.COL42,J.COL43,
                                  J.COL44,J.COL45,J.COL46,J.COL47,J.COL48,J.COL49,J.COL50,J.COL51,J.COL52,J.COL53,J.COL54,J.COL55,J.COL56,
                                  J.COL57,J.COL58,J.COL59,J.COL60,J.COL61,J.COL62,J.COL63,J.COL64,J.COL65,J.COL66,J.COL67,J.COL68,J.COL69,
                                  J.COL70,J.COL71,J.COL72,J.COL73,J.COL74,J.COL75,J.COL76,J.COL77,J.COL78,J.COL79,J.COL80,J.COL81,J.COL82,
                                  J.COL83,J.COL84);

                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT
                        WHERE  EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID AND LEAVE_DATE IS NOT NULL;
                     FETCH curRec INTO k.ChkRecordCount;
                     CLOSE  curRec;
                     
                     
                 IF k.ChkRecordCount=0 THEN
                 update GM_EMP@DBLINK_ABG_OP_ABGHINDALCO_UAT set LEAVE_DATE=J.DATE_OF_SEPARATION where EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID;
                 END IF;
               ELSE  
                 
                                         INSERT INTO EMP_CLEARANCE(COMP_AID,EMP_AID,EMP_MID,EMP_NAME,BUSINESS,BUSINESS_UNIT_DESC,BUSINESS_UNIT,DESCRIPTION,
                                                  JOB_BAND,GRADE,HIRE_DATE,EMAIL_ID,EXIT_TYPE,DATE_OF_SEPARATION,NOTICE_PERIOD_DAYS,
                                                  PL_TO_BE_ENCASHED,TENURE_MONTHS,RECOVERY_DAYS,BATCH_ID,USER_CR,DATE_CR,USER_UP,
                                                  DATE_UP,USER_AT,DATE_AT,ROW_NO,COMMENTS,COL1,COL2,COL3,COL4,COL5,COL6,COL7,
                                                  COL8,COL9,COL10,COL11,COL12,COL13,COL14,COL15,COL16,COL17,COL18,COL19,COL20,
                                                  COL21,COL22,COL23,COL24,COL25,COL26,COL27,COL28,COL29,COL30,COL31,COL32,COL33,
                                                  COL34,COL35,COL36,COL37,COL38,COL39,COL40,COL41,COL42,COL43,COL44,COL45,COL46,
                                                  COL47,COL48,COL49,COL50,COL51,COL52,COL53,COL54,COL55,COL56,COL57,COL58,COL59,
                                                  COL60,COL61,COL62,COL63,COL64)
                          VALUES (J.COMP_AID,J.EMP_AID,J.EMP_MID,J.EMP_NAME,J.BUSINESS,J.BUSINESS_UNIT_DESC,J.BUSINESS_UNIT,J.DESCRIPTION,
                                  J.JOB_BAND,J.GRADE,J.HIRE_DATE,J.EMAIL_ID,J.EXIT_TYPE,TO_DATE(J.DATE_OF_SEPARATION),J.NOTICE_PERIOD_DAYS,
                                  J.PL_TO_BE_ENCASHED,J.TENURE_MONTHS,J.RECOVERY_DAYS,J.BATCH_ID,J.USER_CR,SYSDATE,NULL,NULL,NULL,NULL,
                                  J.SRNO,J.COMMENTS,J.COL21,J.COL22,J.COL23,J.COL24,J.COL25,J.COL26,J.COL27,J.COL28,J.COL29,J.COL30,
                                  J.COL31,J.COL32,J.COL33,J.COL34,J.COL35,J.COL36,J.COL37,J.COL38,J.COL39,J.COL40,J.COL41,J.COL42,J.COL43,
                                  J.COL44,J.COL45,J.COL46,J.COL47,J.COL48,J.COL49,J.COL50,J.COL51,J.COL52,J.COL53,J.COL54,J.COL55,J.COL56,
                                  J.COL57,J.COL58,J.COL59,J.COL60,J.COL61,J.COL62,J.COL63,J.COL64,J.COL65,J.COL66,J.COL67,J.COL68,J.COL69,
                                  J.COL70,J.COL71,J.COL72,J.COL73,J.COL74,J.COL75,J.COL76,J.COL77,J.COL78,J.COL79,J.COL80,J.COL81,J.COL82,
                                  J.COL83,J.COL84);

                    OPEN curRec FOR
                       SELECT COUNT(1)  FROM GM_EMP
                        WHERE  EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID AND LEAVE_DATE IS NOT NULL;
                     FETCH curRec INTO k.ChkRecordCount;
                     CLOSE  curRec;
                     
                     
                 IF k.ChkRecordCount=0 THEN
                 update GM_EMP set LEAVE_DATE=J.DATE_OF_SEPARATION where EMP_ID=J.EMP_AID AND COMP_ID=J.COMP_AID;
                 END IF;
               END IF;  

                END LOOP;


               PY_PK_SFTP_STANDARD_UPLOADS.COMMIT_ROLLBACK_UPLOADED_DATA(pOperationType, pUser_Aid, pSessionId, pUpload_Aid, pUpload_Batch_Id);


         END IF;

          OPEN Return_Recordset FOR
                SELECT 0 STATUS,s.UPLOAD_BATCH_ID UPLOAD_BATCH_ID,Null ErrMessage FROM DUAL;

          COMMIT;

                OPEN Return_Recordset FOR
                     SELECT 0 STATUS,s.UPLOAD_BATCH_ID UPLOAD_BATCH_ID,'SUCCESS:: Data commited successfully' ErrMessage FROM DUAL;

       EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                k.ERROR_MSG := SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
                PY_PK_ERROR_LOG.UPLOAD_ERROR_LOG(pSessionId, pUser_Aid, 'PY_PK_SFTP_STANDARD_UPLOADS.PRO_EMP_CLEARANCE_UPLOAD' ,k.ERROR_MSG);

              OPEN Return_Recordset FOR
                  SELECT 1 STATUS,'Uploading Failed' UPLOAD_BATCH_ID,k.ERROR_MSG ErrMessage  FROM DUAL;


    END;  

END PY_PK_SFTP_STANDARD_UPLOADS;