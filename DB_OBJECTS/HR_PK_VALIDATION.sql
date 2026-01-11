create or replace PACKAGE            "HR_PK_VALIDATION" IS
    TYPE REC IS REF CURSOR;

    -- Returning the Comp_Mid from company Master
    FUNCTION FN_GET_COMP_MID (pComp_Aid VARCHAR2) RETURN VARCHAR2;

    --Returning the COMP_AID
    FUNCTION FN_GET_COMP_AID (pComp_Mid VARCHAR2) RETURN VARCHAR2;
     --Returning the GROUP COMP_AID
    FUNCTION FN_GET_GROUP_COMP_AID (pComp_Aid VARCHAR2) RETURN VARCHAR2;
    --Returning the EMP_AID
    FUNCTION FN_GET_EMP_AID (pComp_AID VARCHAR2, pEmp_Mid  VARCHAR2) RETURN VARCHAR2;
    --Returning the CTC_AID
    FUNCTION FN_GET_CTC_AID (pComp_AID VARCHAR2, pCTC_Mid  VARCHAR2) RETURN VARCHAR2;

    FUNCTION FN_GET_GRADE_AID (pComp_AID VARCHAR2, pGrade_Mid  VARCHAR2) RETURN VARCHAR2;

    FUNCTION FN_GET_BAND_AID (pComp_Aid VARCHAR2, pBand_Mid  VARCHAR2) RETURN VARCHAR2;

    FUNCTION FN_GENERATE_AID (pComp_Aid VARCHAR2, pTable_Name  VARCHAR2, pID NUMBER) RETURN VARCHAR2;
    --Searching Characters Return 1/0
    FUNCTION FN_SEARCH_CHARACTERS (pStringValue VARCHAR2,pSearchCharacters  VARCHAR2) RETURN NUMBER ;
    --Checking Is Date
    FUNCTION FN_IS_DATE(pDateValue VARCHAR2) RETURN NUMBER;
    --Checking Is Number
    FUNCTION FN_IS_NUMBER(pNumberValue VARCHAR2) RETURN NUMBER;
    FUNCTION FN_GET_DEPT_AID (pComp_ID VARCHAR2, pDept_Mid  VARCHAR2) RETURN VARCHAR2;
     FUNCTION FN_GET_ACTIVE_DEPT_AID (pComp_ID VARCHAR2, pDept_Mid  VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_DESGN_ID (pComp_ID VARCHAR2, pDESGN_MID  VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_HOLIDAY_ID (pComp_ID VARCHAR2, pHOLIDAY_NAME  VARCHAR2,pHOLIDAY_DATE VARCHAR2,vLOCATION_ID VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GENERATE_HOLIDAY_ID (pComp_Aid VARCHAR2, pHOLIDAY_NAME VARCHAR2,pID NUMBER) RETURN VARCHAR2;
    FUNCTION FN_GET_STATE_CODE (pState_Mid VARCHAR2) RETURN VARCHAR2;
     FUNCTION FN_GET_ACTIVE_STATE_CODE (pState_Mid VARCHAR2) RETURN VARCHAR2;

    FUNCTION FN_GET_COUNTRY_CODE (pCountry_Mid VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_ACTIVE_COUNTRY_CODE (pCountry_Mid VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_CITY_CODE ( pCity_Mid  VARCHAR2) RETURN VARCHAR2 ;
    FUNCTION FN_GET_LOCATION_ID(pComp_id VARCHAR2,pLocation_Mid VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_ACTIVE_LOCATION_ID(pComp_id VARCHAR2,pLocation_Mid VARCHAR2) RETURN VARCHAR2;

    FUNCTION FN_GET_BAND_ID(pComp_id VARCHAR2,pBand_Mid VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_ALLWDED_AID (pComp_AID VARCHAR2, pCTC_MID  VARCHAR2,pCTC_CATE VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_ALLWDED_TYPE (pComp_AID VARCHAR2, pCTC_MID  VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_BANK_ID(pComp_id VARCHAR2,pBank_Mid VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_GET_BRANCH_ID(pComp_id VARCHAR2,pBranch_Mid VARCHAR2) RETURN VARCHAR2;
    FUNCTION FN_EMAIL(pEmail_id VARCHAR2) RETURN NUMBER;
    FUNCTION  FN_TIME_DIFF(P_TIME_DIFF VARCHAR2)  RETURN NUMBER;
    FUNCTION  FN_VAL_TIME_DIFF(P_TIME_DIFF VARCHAR2)  RETURN NUMBER;
    FUNCTION  FN_VAL_BRANCH_TELL(P_BR_TEL  VARCHAR2) RETURN NUMBER;
    FUNCTION FN_PAN_ISVALID (pPAN_NUMBER VARCHAR2)   RETURN VARCHAR2;
    FUNCTION FN_DATE_VALDATION(P_EFF_DATE_FR  VARCHAR2) RETURN NUMBER;
    FUNCTION FN_GET_PARAMETERS_ID(P_PARA_MID VARCHAR2) RETURN VARCHAR2;
    --CASTING IN DATE REQUIRED FORMAT DD-MMM-YYYY
    FUNCTION FN_CAST_DATE(pRawDateValue VARCHAR2) RETURN VARCHAR2;
    --Get the attribute Master Aid,  Is sub attribute value allow
   PROCEDURE FN_GET_ATTB_AID (pComp_ID VARCHAR2, pATTB_Mid  VARCHAR2,pATTB_AID OUT VARCHAR2,pIsLIST_FLAG OUT VARCHAR2,pACTIVE_FLG OUT VARCHAR2);

   --Generate the SubAttribute Aid
   FUNCTION FN_GENERATE_SUB_ATTB_AID (pComp_Aid VARCHAR2, pATTB_AID VARCHAR2,pID NUMBER ) RETURN VARCHAR2;
   --Get the SubAttribute Aid
   FUNCTION FN_GET_SUB_ATTB_AID (pComp_AID VARCHAR2, pATTB_AID  VARCHAR2,pSUB_ATTB_MID varchar2) RETURN VARCHAR2;

   FUNCTION FN_GET_ATTB_DESC (pComp_Aid VARCHAR2,pATTB_AID VARCHAR2) RETURN VARCHAR2;

   PROCEDURE FN_GET_VALIDATION (pComp_ID VARCHAR2, pATTB_Aid  VARCHAR2,pSUB_ATTB_MID varchar2,pERROR_FLAG OUT VARCHAR2,pERROR_MSG OUT VARCHAR2);

   --Get the fieldnames
   FUNCTION FUNC_FORMAT_COLS(pVIEW_NAME VARCHAR2,pIsWithFormula VARCHAR2) RETURN VARCHAR2;

   FUNCTION FN_GET_ACC_YEAR(pComp_ID VARCHAR2) RETURN VARCHAR2;
   FUNCTION FN_CHK_ACC_NO(pComp_ID VARCHAR2,pEmp_Mid  VARCHAR2,pBANK_ACC_NO VARCHAR2, pBANK_AID VARCHAR2) RETURN NUMBER;
   FUNCTION FN_GET_ACC_SIZE(pComp_ID VARCHAR2, pBANK_AID VARCHAR2) RETURN VARCHAR2;
   FUNCTION FN_CHK_DUL_ACC(pComp_ID VARCHAR2, pBANK_ACC_NO VARCHAR2) RETURN NUMBER ;
   FUNCTION FN_GET_CC_AID (pComp_ID VARCHAR2, pCC_Mid  VARCHAR2) RETURN VARCHAR2;
   FUNCTION FN_GET_SUB_DEPT_AID (pComp_ID VARCHAR2, pSub_Dept_Mid  VARCHAR2) RETURN VARCHAR2;
   FUNCTION FN_CHECK_DATE_FORMAT(PDATE VARCHAR2) RETURN NUMBER;

   /** Added by Vishal Kute for Employee Code**/
   FUNCTION GET_EMPLOYEE_CODE_NEWLY(pComp_ID VARCHAR2,VEMP_MID_LOGIC VARCHAR2,pID NUMBER) RETURN VARCHAR2;

END  HR_PK_VALIDATION;


/


create or replace PACKAGE BODY            "HR_PK_VALIDATION" IS

-- Returning the Comp_Mid from company Master
FUNCTION FN_GET_COMP_MID (pComp_Aid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vComp_Mid           GM_COMP.COMP_MID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT COMP_MID FROM GM_COMP
            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_Aid));
        FETCH curRec INTO vComp_Mid;
        CLOSE  curRec;

        RETURN vComp_Mid;
END FN_GET_COMP_MID;

-- Returning the Comp_Aid from company Master
FUNCTION FN_GET_COMP_AID (pComp_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vComp_Aid           GM_COMP.COMP_ID%TYPE;
BEGIN

    OPEN curRec FOR
        SELECT COMP_ID FROM GM_COMP
        WHERE UPPER(TRIM(COMP_MID)) = UPPER(TRIM(pComp_Mid));
    FETCH curRec INTO vComp_Aid;
    CLOSE  curRec;

    RETURN vComp_Aid;
END FN_GET_COMP_AID;

FUNCTION FN_GET_GROUP_COMP_AID (pComp_Aid VARCHAR2) RETURN VARCHAR2
  AS
  TYPE REF_CUR is ref cursor;
  curRec              REF_CUR;
  vGroup_Comp_ID  VARCHAR2(100);
  BEGIN

      OPEN curRec FOR
          SELECT GRP_COMP_ID FROM GM_COMP
              WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_Aid));
      FETCH curRec INTO vGroup_Comp_ID;
      CLOSE  curRec;

      RETURN vGroup_Comp_ID;
  END FN_GET_GROUP_COMP_AID;
   --Returning the EMP_AID from Employee Master
    FUNCTION FN_GET_ATTB_DESC (pComp_Aid VARCHAR2,pATTB_AID VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vATTB_DESC           PM_EMP_ATTRIBUTE.ATTB_VALUE%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT ATTB_VALUE FROM PM_EMP_ATTRIBUTE
            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM( pComp_Aid))
            AND UPPER(TRIM(ATTB_AID)) =UPPER(TRIM( pATTB_AID))
            AND UPPER(TRIM(SUB_ATTB_AID)) ='SB000000';

        FETCH curRec INTO vATTB_DESC;
        CLOSE  curRec;

        RETURN vATTB_DESC;
    END FN_GET_ATTB_DESC;

    FUNCTION FN_GET_EMP_AID (pComp_AID VARCHAR2, pEmp_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vEmp_Aid            GM_EMP.EMP_ID%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT EMP_ID FROM GM_EMP
                WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_AID)) AND UPPER(TRIM(EMP_MID))= UPPER(TRIM(pEmp_Mid));
        FETCH curRec INTO vEmp_Aid;
        CLOSE  curRec;

        RETURN vEmp_Aid;
    END FN_GET_EMP_AID;

   FUNCTION FN_GET_SUB_ATTB_AID (pComp_AID VARCHAR2, pATTB_AID  VARCHAR2,pSUB_ATTB_MID varchar2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vSUB_ATTB_AID       PM_SUB_ATTRIBUTE.SUB_ATTB_AID%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT SUB_ATTB_AID FROM PM_SUB_ATTRIBUTE
                WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(pComp_AID))
                AND UPPER(TRIM(ATTB_AID))= UPPER(TRIM(pATTB_AID))
                AND UPPER(TRIM(SUB_ATTB_MID))= UPPER(TRIM(pSUB_ATTB_MID))                ;
        FETCH curRec INTO vSUB_ATTB_AID;
        CLOSE  curRec;

        RETURN vSUB_ATTB_AID;
    END FN_GET_SUB_ATTB_AID;

   --Returning the CTC_AID  from CTC allowance Master
    FUNCTION FN_GET_CTC_AID (pComp_AID VARCHAR2, pCTC_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCTC_Aid            CTC_ALLOWANCE_MAST.CTC_CODE%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT CTC_CODE FROM CTC_ALLOWANCE_MAST
                WHERE COMP_ID = pComp_AID AND UPPER(CTC_MID) = UPPER(TRIM(pCTC_Mid));
        FETCH curRec INTO vCTC_Aid;
        CLOSE  curRec;

        RETURN vCTC_Aid;
    END FN_GET_CTC_AID;

    --Get Grade Aid
    FUNCTION FN_GET_GRADE_AID (pComp_AID VARCHAR2, pGrade_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vGrade_Aid           GM_GRADE_MSTR.Grade_Aid%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT GRADE_AID FROM GM_GRADE_MSTR
                WHERE COMP_AID = pComp_AID AND UPPER(TRIM(GRADE_MID)) = UPPER(TRIM(pGrade_Mid));
        FETCH curRec INTO vGrade_Aid;
        CLOSE  curRec;

        RETURN vGrade_Aid;
    END FN_GET_GRADE_AID;

        --Get Grade Aid
    FUNCTION FN_GET_BAND_AID (pComp_Aid VARCHAR2, pBand_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vBand_Aid           GM_BAND.Band_Aid%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT BAND_AID FROM GM_BAND
                WHERE COMP_AID = pComp_Aid AND UPPER(TRIM(BAND_MID)) = UPPER(TRIM(pBand_Mid));
        FETCH curRec INTO vBand_Aid;
        CLOSE  curRec;

        RETURN vBand_Aid;
    END FN_GET_BAND_AID;

    FUNCTION FN_GENERATE_AID (pComp_Aid VARCHAR2, pTable_Name  VARCHAR2 ,pID NUMBER ) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vMaxNumber          NUMBER;
    vMaster_Aid         VARCHAR2(50);
    BEGIN

        IF pTable_Name ='GM_GRADE_MSTR' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(GRADE_AID,3))) GRADE_AID FROM GM_GRADE_MSTR
                    WHERE COMP_AID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'GR'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_DEPTS' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(DEPT_ID,3))) DEPT_ID FROM GM_DEPTS
                    WHERE COMP_ID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'DE'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_DESIGNATIONS' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(DESGN_ID,3))) DESGN_ID FROM GM_DESIGNATIONS
                    WHERE COMPANY_ID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'DG'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_CITY' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(CITY_CODE,3))) CITY_CODE FROM GM_CITY;
                    --WHERE COMPANY_ID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'CI'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_STATE' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(STATE_CODE,3))) STATE_CODE FROM GM_STATE;
                    --WHERE COMPANY_ID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'ST'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

             ELSIF pTable_Name ='GM_BRANCH' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(BR_AID,3))) BR_AID FROM GM_BRANCH
                    WHERE COMP_AID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

        vMaster_Aid := 'BR'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

            ELSIF pTable_Name ='GM_COST_CENTER' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(COST_CENTER_ID,3))) COST_CENTER_ID FROM GM_COST_CENTER
                    WHERE COMP_CODE = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'CC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_EMP' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(EMP_ID,3))) EMP_ID FROM GM_EMP;
            FETCH curRec INTO vMaxNumber;

--            vMaster_Aid := 'EM'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+1,'000000'));
            vMaster_Aid := 'EM'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_BAND' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(BAND_AID,3))) BAND_AID FROM GM_BAND
                    WHERE COMP_AID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'BD'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='GM_COUNTRY' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(COUNTRY_CODE,3))) COUNTRY_CODE FROM GM_COUNTRY;
                    --WHERE COMPANY_ID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'CO'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

             ELSIF pTable_Name ='GM_LOCATIONS' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(LOCATION_ID,3))) LOCATION_ID FROM GM_LOCATIONS
                WHERE COMP_ID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'LC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='PM_EMP_CTC_DEFINE' THEN

--            OPEN curRec FOR
--            SELECT TO_NUMBER(MAX(SUBSTR(EMP_CTC_ID,3))) EMP_CTC_ID FROM PM_EMP_CTC_DEFINE;
--            --WHERE COMP_ID = pComp_Aid;
--            FETCH curRec INTO vMaxNumber;

--            vMaster_Aid := 'EC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

            OPEN curRec FOR
            SELECT TO_NUMBER(MAX(SUBSTR(EMP_CTC_ID,11))) EMP_CTC_ID
            FROM PM_EMP_CTC_DEFINE
            WHERE SUBSTR(EMP_CTC_ID,3,8)=TRIM(TO_CHAR(SYSDATE,'DDMMYYYY'));
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'EC'||TO_CHAR(SYSDATE,'DDMMYYYY')||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

        ELSIF pTable_Name ='HR_PT_EMP_OTC_DEFINE' THEN

--            OPEN curRec FOR
--            SELECT TO_NUMBER(MAX(SUBSTR(REV_NO,3))) REVISION_NO FROM HR_PT_EMP_OTC_DEFINE;
--            --WHERE COMP_ID = pComp_Aid;
--            FETCH curRec INTO vMaxNumber;

--        vMaster_Aid := 'EC'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

           OPEN curRec FOR
            SELECT TO_NUMBER(MAX(SUBSTR(REV_NO,11))) REVISION_NO FROM HR_PT_EMP_OTC_DEFINE
            WHERE SUBSTR(REV_NO,3,8)=TRIM(TO_CHAR(SYSDATE,'DDMMYYYY'));
            FETCH curRec INTO vMaxNumber;

          vMaster_Aid := 'OC'||TO_CHAR(SYSDATE,'DDMMYYYY')||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));


         ELSIF pTable_Name ='GM_BANK' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(BANK_AID,3))) BANK_AID FROM GM_BANK
                    WHERE COMP_AID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'BK'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

          ELSIF pTable_Name ='GM_ATTRIBUTE' THEN

          OPEN curRec FOR
           SELECT TO_NUMBER(MAX(SUBSTR(ATTB_AID,3))) ATTB_AID FROM GM_ATTRIBUTE
           WHERE COMP_AID = pComp_Aid;
          FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'AM'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));
        ELSIF pTable_Name ='GM_SUB_DEPT' THEN

            OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(SUB_DEPT_AID,3))) SUB_DEPT_AID FROM GM_SUB_DEPT
                    WHERE COMP_AID = pComp_Aid;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'SD'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));
        ELSE

            vMaster_Aid := 'NA';
        END IF ;
         CLOSE curRec;

        RETURN vMaster_Aid;
    END FN_GENERATE_AID;

    --Searching Characters Return 1/0  1 for exist and 0 not found
    FUNCTION FN_SEARCH_CHARACTERS (pStringValue VARCHAR2,pSearchCharacters  VARCHAR2) RETURN NUMBER
    AS
    BEGIN
        FOR I IN 0..LENGTH(pSearchCharacters)
        LOOP
           IF INSTR(pStringValue, SUBSTR(pSearchCharacters,I,1))>0 THEN
            RETURN 1;
           END IF;
        END LOOP;

        RETURN 0;
    END FN_SEARCH_CHARACTERS;

    FUNCTION FN_IS_DATE(pDateValue VARCHAR2) RETURN NUMBER
    AS
    vChkDate        DATE;
    BEGIN

        vChkDate := TO_DATE(pDateValue);
        RETURN 1;

      EXCEPTION
         WHEN OTHERS THEN
            RETURN 0;
    END FN_IS_DATE;

    FUNCTION FN_IS_NUMBER(pNumberValue VARCHAR2) RETURN NUMBER
    AS
    vChkNumber        NUMBER;
    BEGIN

        vChkNumber := TO_NUMBER(pNumberValue);
        RETURN 1;

      EXCEPTION
         WHEN OTHERS THEN
            RETURN 0;
    END FN_IS_NUMBER;

       FUNCTION FN_GET_DEPT_AID (pComp_ID VARCHAR2, pDept_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vDAept_Aid           GM_DEPTS.DEPT_ID%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT DEPT_ID FROM GM_DEPTS
                WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_ID)) AND UPPER(TRIM(DEPT_MID)) = UPPER(TRIM(pDept_Mid));
        FETCH curRec INTO vDAept_Aid;
        CLOSE  curRec;

        RETURN vDAept_Aid;
    END FN_GET_DEPT_AID;


      FUNCTION FN_GET_ACTIVE_DEPT_AID (pComp_ID VARCHAR2, pDept_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vDAept_Aid           GM_DEPTS.DEPT_ID%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT DEPT_ID FROM GM_DEPTS
                WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_ID)) AND UPPER(TRIM(DEPT_MID)) = UPPER(TRIM(pDept_Mid)) AND ACTIVE='1';
        FETCH curRec INTO vDAept_Aid;
        CLOSE  curRec;

        RETURN vDAept_Aid;
    END FN_GET_ACTIVE_DEPT_AID;

   PROCEDURE FN_GET_ATTB_AID (pComp_ID VARCHAR2, pATTB_Mid  VARCHAR2,pATTB_AID OUT VARCHAR2,pIsLIST_FLAG OUT VARCHAR2,pACTIVE_FLG OUT VARCHAR2)
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vATTB_Aid           GM_ATTRIBUTE.ATTB_MID%TYPE;
    vIsLIST_FLAG        GM_ATTRIBUTE.LIST_FLAG%TYPE;
    vACTIVE_FLG         GM_ATTRIBUTE.ACTIVE_FLG%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT ATTB_AID, NVL(LIST_FLAG,'N') LIST_FLAG,ACTIVE_FLG FROM GM_ATTRIBUTE
                WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(pComp_ID)) AND UPPER(TRIM(ATTB_MID)) = UPPER(TRIM(pATTB_Mid));
        FETCH curRec INTO vATTB_Aid,vIsLIST_FLAG,vACTIVE_FLG;
        CLOSE  curRec;

        pATTB_AID       := vATTB_Aid;
        pIsLIST_FLAG    := NVL(vIsLIST_FLAG,'N');
        pACTIVE_FLG     := vACTIVE_FLG;

    END FN_GET_ATTB_AID;

    PROCEDURE FN_GET_VALIDATION (pComp_ID VARCHAR2, pATTB_Aid  VARCHAR2,pSUB_ATTB_MID varchar2,pERROR_FLAG OUT VARCHAR2,pERROR_MSG OUT VARCHAR2)
   AS

    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vATTB_Aid           GM_ATTRIBUTE.ATTB_MID%TYPE;
    vIsLIST_FLAG        GM_ATTRIBUTE.LIST_FLAG%TYPE;
    vDATA_TYPE           GM_ATTRIBUTE.DATA_TYPE%TYPE;
    v_VALIDATION        GM_ATTRIBUTE.VALIDATION%TYPE;
    v_VALIDATION_SUMMARY GM_ATTRIBUTE.VALIDATION_SUMMARY%TYPE;
    v_DATA_LIMIT        GM_ATTRIBUTE.DATA_LIMIT%TYPE;
    vERROR_FLAG         GM_ATTRIBUTE.ACTIVE_FLG%TYPE;
   vERROR_MSG         GM_ATTRIBUTE.VALIDATION_SUMMARY%TYPE;


    BEGIN

        vERROR_FLAG := 'N';
        vERROR_MSG  :=NULL;

      OPEN curRec FOR
        select DATA_TYPE,VALIDATION, VALIDATION_SUMMARY, DATA_LIMIT FROM GM_ATTRIBUTE
            WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(pComp_ID))
            AND UPPER(TRIM(ATTB_AID)) = UPPER(TRIM(pATTB_Aid));
        FETCH curRec INTO vDATA_TYPE,v_VALIDATION,v_VALIDATION_SUMMARY,v_DATA_LIMIT;
       CLOSE  curRec;

          IF NVL(LENGTH(TRIM(NVL(pSUB_ATTB_MID,' '))),0)>v_DATA_LIMIT THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='SUB Attribue value should not be greater than '||v_DATA_LIMIT;
       END IF;

        IF UPPER(TRIM(vDATA_TYPE))= 'TEXT' THEN
           IF  HR_PK_VALIDATION.FN_SEARCH_CHARACTERS(TRIM(pSUB_ATTB_MID),v_VALIDATION) = 1  THEN
                vERROR_FLAG:='Y';
                vERROR_MSG:='Special Character '||v_VALIDATION||' are not allowed';
           END IF;
        END IF;

         IF UPPER(TRIM(vDATA_TYPE)) ='NUMBER' THEN
           IF HR_PK_VALIDATION.FN_IS_NUMBER (pSUB_ATTB_MID) =  0 THEN
              vERROR_FLAG:='Y';
              vERROR_MSG:='It should be numeric value';
           END IF;
         END IF;

         IF UPPER(TRIM(vDATA_TYPE)) ='DATE' THEN
             IF HR_PK_VALIDATION.FN_IS_DATE(pSUB_ATTB_MID) = 0 THEN
               vERROR_FLAG:='Y';
               vERROR_MSG:='It should be date format as DD-MMM-YYYY';
             --  GOTO PRINT_ERROR;
               END IF;
          END IF;

          pERROR_FLAG:= vERROR_FLAG;
          pERROR_MSG:=vERROR_MSG;

    END FN_GET_VALIDATION;


    FUNCTION FN_GET_DESGN_ID (pComp_ID VARCHAR2, pDESGN_MID  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vDESGN_ID          GM_DEPTS.DEPT_ID%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT DESGN_ID FROM GM_DESIGNATIONS
                WHERE COMPANY_ID = pComp_ID AND UPPER(DESGN_MID) = UPPER(TRIM(pDESGN_MID));
        FETCH curRec INTO vDESGN_ID;
        CLOSE  curRec;

        RETURN vDESGN_ID;
    END FN_GET_DESGN_ID;

    FUNCTION FN_GET_HOLIDAY_ID (pComp_ID VARCHAR2, pHOLIDAY_NAME  VARCHAR2,pHOLIDAY_DATE VARCHAR2 ,vLOCATION_ID VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vHOLIDAY_ID          GM_HOLIDAYS.HOLIDAY_ID%TYPE;
    BEGIN

     IF( UPPER(TRIM(vLOCATION_ID))='ALL')  THEN
         OPEN curRec FOR
            SELECT  HOLIDAY_ID FROM GM_HOLIDAYS
            WHERE UPPER(TRIM(COMP_ID)) = UPPER(TRIM(pComp_ID)) AND UPPER(HOLIDAY_NAME) = UPPER(TRIM(pHOLIDAY_NAME)) and to_date(HOLIDAY_DATE)=TO_DATE(pHOLIDAY_DATE)
            AND UPPER(TRIM(LOCATION_ID)) IN (SELECT UPPER(TRIM(LOCATION_ID)) FROM GM_LOCATIONS WHERE UPPER(TRIM(COMP_ID))= UPPER(TRIM(pComp_ID)))
            GROUP BY HOLIDAY_ID;
        FETCH curRec INTO vHOLIDAY_ID;
        CLOSE  curRec;

    ELSE

        OPEN curRec FOR
            SELECT HOLIDAY_ID FROM GM_HOLIDAYS

                WHERE COMP_ID = pComp_ID AND UPPER(HOLIDAY_NAME) = UPPER(TRIM(pHOLIDAY_NAME)) and to_date(HOLIDAY_DATE)=TO_DATE(pHOLIDAY_DATE) AND UPPER(TRIM(LOCATION_ID))=UPPER(TRIM(vLOCATION_ID)) ;
        FETCH curRec INTO vHOLIDAY_ID;
        CLOSE  curRec;

    END IF;

        RETURN vHOLIDAY_ID;
    END FN_GET_HOLIDAY_ID;

FUNCTION FN_GENERATE_HOLIDAY_ID (pComp_Aid VARCHAR2, pHOLIDAY_NAME VARCHAR2 ,pID NUMBER) RETURN VARCHAR2

AS
TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
 vMaxNumber          NUMBER;
VHolidayCount NUMBER;
vMaster_Aid   VARCHAR2(50);
BEGIN

SELECT COUNT(1) INTO   VHolidayCount FROM  GM_HOLIDAYS WHERE   UPPER(TRIM(HOLIDAY_NAME))=UPPER(TRIM(pHOLIDAY_NAME));

IF  (VHolidayCount >0)
THEN

SELECT  HOLIDAY_ID INTO vMaster_Aid  FROM GM_HOLIDAYS WHERE   UPPER(TRIM(HOLIDAY_NAME))=UPPER(TRIM(pHOLIDAY_NAME)) GROUP BY HOLIDAY_ID;

ELSE
  OPEN curRec FOR
                SELECT TO_NUMBER(MAX(SUBSTR(HOLIDAY_ID,3))) HOLIDAY_ID FROM GM_HOLIDAYS
                    ;
            FETCH curRec INTO vMaxNumber;

            vMaster_Aid := 'HL'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));
END IF;

RETURN NVL(vMaster_Aid,'NA');

END FN_GENERATE_HOLIDAY_ID;


FUNCTION FN_GET_STATE_CODE (pState_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vSTATE_CODE           GM_STATE.STATE_CODE%TYPE;
BEGIN

    OPEN curRec FOR
        SELECT STATE_CODE FROM GM_STATE
            WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(pState_Mid));
    FETCH curRec INTO vSTATE_CODE;
    CLOSE  curRec;

    RETURN vSTATE_CODE;
END FN_GET_STATE_CODE;


FUNCTION FN_GET_ACTIVE_STATE_CODE (pState_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vSTATE_CODE           GM_STATE.STATE_CODE%TYPE;
BEGIN

      OPEN curRec FOR
          SELECT STATE_CODE FROM GM_STATE
              WHERE UPPER(TRIM(STATE_MID)) = UPPER(TRIM(pState_Mid)) AND ACTIVE_FLG='1';
      FETCH curRec INTO vSTATE_CODE;
      CLOSE  curRec;

      RETURN vSTATE_CODE;
END FN_GET_ACTIVE_STATE_CODE;

FUNCTION FN_GET_COUNTRY_CODE (pCountry_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCOUNTRY_CODE           GM_COUNTRY.COUNTRY_CODE%TYPE;
    BEGIN

        OPEN curRec FOR
            SELECT COUNTRY_CODE FROM GM_COUNTRY
                WHERE  UPPER(TRIM(COUNTRY_MID)) = UPPER(TRIM(pCountry_Mid));
        FETCH curRec INTO vCOUNTRY_CODE;
        CLOSE  curRec;

        RETURN vCOUNTRY_CODE;
    END FN_GET_COUNTRY_CODE;

    --- ADEDD BY VINAYAK PATIL FOR ACTIVE COUNTRY CODE             START
FUNCTION FN_GET_ACTIVE_COUNTRY_CODE (pCountry_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCOUNTRY_CODE           GM_COUNTRY.COUNTRY_CODE%TYPE;
BEGIN
        --                  SELECT COUNT (COUNTRY_CODE) INTO vCOUNT
        --                  FROM GM_COUNTRY
        --                  WHERE  UPPER(TRIM(COUNTRY_MID)) = UPPER(TRIM(pCountry_Mid)) AND ACTIVE_FLG='1';

        --          INSERT INTO TEMP VALUES(vCOUNT);
        --          COMMIT;


        OPEN curRec FOR
        SELECT COUNTRY_CODE FROM GM_COUNTRY
        WHERE  UPPER(TRIM(COUNTRY_MID)) = UPPER(TRIM(pCountry_Mid)) AND ACTIVE_FLG='1';
    FETCH curRec INTO vCOUNTRY_CODE;
    CLOSE  curRec;

    RETURN vCOUNTRY_CODE;
END FN_GET_ACTIVE_COUNTRY_CODE;
    --- ADEDD BY VINAYAK PATIL FOR ACTIVE COUNTRY CODE             END
FUNCTION FN_GET_CITY_CODE ( pCity_Mid  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCITY_CODE           GM_CITY.CITY_CODE%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT CITY_CODE FROM GM_CITY
            WHERE   UPPER(TRIM(CITY_MID)) = UPPER(TRIM(pCity_Mid));
        FETCH curRec INTO vCITY_CODE;
        CLOSE  curRec;

        RETURN vCITY_CODE;
END FN_GET_CITY_CODE;


  FUNCTION FN_GET_LOCATION_ID(pComp_id VARCHAR2,pLocation_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vLocation_Id           GM_LOCATIONS.LOCATION_ID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT LOCATION_ID FROM GM_LOCATIONS
                WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(pLocation_Mid)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(pComp_id));
        FETCH curRec INTO vLocation_Id;
        CLOSE  curRec;

        RETURN vLocation_Id;
END  FN_GET_LOCATION_ID;


 FUNCTION FN_GET_ACTIVE_LOCATION_ID(pComp_id VARCHAR2,pLocation_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vLocation_Id           GM_LOCATIONS.LOCATION_ID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT LOCATION_ID FROM GM_LOCATIONS
                WHERE UPPER(TRIM(LOCATION_MID)) = UPPER(TRIM(pLocation_Mid)) AND UPPER(TRIM(COMP_ID))=UPPER(TRIM(pComp_id)) AND ACTIVE_FLG='1';
        FETCH curRec INTO vLocation_Id;
        CLOSE  curRec;

        RETURN vLocation_Id;
END FN_GET_ACTIVE_LOCATION_ID;


 FUNCTION FN_GET_BAND_ID(pComp_id VARCHAR2,pBand_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vBand_Aid           GM_BAND.BAND_AID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT BAND_AID FROM GM_BAND
                WHERE  COMP_AID=TRIM(pComp_id) AND  UPPER(TRIM(Band_Mid)) = UPPER(TRIM(pBand_Mid));
        FETCH curRec INTO vBand_Aid;
        CLOSE  curRec;

        RETURN vBand_Aid;
END FN_GET_BAND_ID;

FUNCTION FN_GET_ALLWDED_AID (pComp_AID VARCHAR2, pCTC_MID  VARCHAR2,pCTC_CATE VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCTC_CODE            CTC_ALLOWANCE_MAST.CTC_CODE%TYPE;
    /*pCTC_CATE--> ALL->All Allowances & Deductions, OTC->OTHER THAN CTC, CTC->All except OTHER THAN CTC */
BEGIN

        IF TRIM(UPPER(pCTC_CATE)) IN ('ALL','OTC') THEN
            OPEN curRec FOR
            SELECT CTC_CODE FROM CTC_ALLOWANCE_MAST A, GM_PARAMETERS B
            WHERE A.CTC_CATE_ID=B.PAR_AID AND TRIM(UPPER(B.PARA_DESC))=DECODE(pCTC_CATE,'OTC','OTHER THAN CTC','ALL',TRIM(UPPER(B.PARA_DESC)))
            AND UPPER(TRIM(A.COMP_ID)) = UPPER(TRIM(pComp_AID)) AND UPPER(TRIM(A.CTC_MID)) = UPPER(TRIM(pCTC_MID));
        ELSE
            OPEN curRec FOR
            SELECT CTC_CODE FROM CTC_ALLOWANCE_MAST A, GM_PARAMETERS B
            WHERE A.CTC_CATE_ID=B.PAR_AID AND TRIM(UPPER(B.PARA_DESC))<>'OTHER THAN CTC'
            AND UPPER(TRIM(A.COMP_ID)) = UPPER(TRIM(pComp_AID)) AND UPPER(TRIM(A.CTC_MID)) = UPPER(TRIM(pCTC_MID)) AND NVL(TRIM(UPPER(SALARY_FLG)),'Y')='Y';
        END IF;
        FETCH curRec INTO vCTC_CODE;
        CLOSE  curRec;

        RETURN vCTC_CODE;
END FN_GET_ALLWDED_AID;

FUNCTION FN_GET_ALLWDED_TYPE (pComp_AID VARCHAR2, pCTC_MID  VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCTC_TYPE            CTC_ALLOWANCE_MAST.CTC_TYPE%TYPE;
BEGIN


        OPEN curRec FOR
        SELECT CTC_TYPE
        FROM CTC_ALLOWANCE_MAST A, GM_PARAMETERS B
        WHERE A.CTC_CATE_ID=B.PAR_AID
          AND TRIM(UPPER(B.PARA_DESC))<>'OTHER THAN CTC'
          AND UPPER(TRIM(A.COMP_ID)) = UPPER(TRIM(pComp_AID))
          AND UPPER(TRIM(A.CTC_MID)) = UPPER(TRIM(pCTC_MID))
          AND NVL(TRIM(UPPER(SALARY_FLG)),'Y')='Y';

        FETCH curRec INTO vCTC_TYPE;
        CLOSE  curRec;

        RETURN vCTC_TYPE;
END FN_GET_ALLWDED_TYPE;

FUNCTION FN_GET_BANK_ID(pComp_id VARCHAR2,pBank_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vBank_Id           gm_bank.BANK_AID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT BANK_AID FROM gm_bank
                WHERE  COMP_AID = pComp_id AND UPPER( TRIM(Bank_Mid)) =UPPER( TRIM(pBank_Mid));
        FETCH curRec INTO vBank_Id;
        CLOSE  curRec;

        RETURN vBank_Id;
END FN_GET_BANK_ID;


FUNCTION FN_GET_BRANCH_ID(pComp_id VARCHAR2,pBranch_Mid VARCHAR2) RETURN VARCHAR2
    AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vBranch_Id           gm_branch.BR_AID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT BR_AID FROM gm_branch
                WHERE  COMP_AID = pComp_id AND UPPER(TRIM(BR_MID))= UPPER(TRIM(pBranch_Mid));
        FETCH curRec INTO vBranch_Id;
        CLOSE  curRec;

        RETURN vBranch_Id;
END FN_GET_BRANCH_ID;

FUNCTION FN_EMAIL(pEmail_id VARCHAR2) RETURN NUMBER
    AS
    V_NO NUMBER;

BEGIN
--      SELECT CASE WHEN REGEXP_LIKE(pEmail_id, '^([[:alnum:]]+(_?|\.))[[:alnum:]]*@[[:alnum:]]+(\.([[:alnum:]]+)){1,2}$') THEN 0 ELSE 1 END AS OUTPUT INTO V_NO FROM DUAL;
--      SELECT CASE WHEN REGEXP_LIKE(pEmail_id, '^([[:alnum:]]+(-*|_*|\.))+[[:alnum:]]*@[[:alnum:]]+(\.([[:alnum:]]+)){1,5}$') THEN 0 ELSE 1 END AS OUTPUT INTO V_NO FROM DUAL;
        SELECT CASE WHEN REGEXP_LIKE(pEmail_id ,'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN 0 ELSE 1 END AS OUTPUT INTO V_NO FROM DUAL;

      RETURN V_NO;
END FN_EMAIL;

FUNCTION  FN_TIME_DIFF(P_TIME_DIFF VARCHAR2)  RETURN NUMBER AS

    V_TIME_DIFF NUMBER(4,2);
    V_NO NUMBER;
BEGIN

    V_TIME_DIFF:=TO_NUMBER(TRIM(P_TIME_DIFF));
    V_NO:= 0;
   RETURN V_NO;
   EXCEPTION WHEN OTHERS THEN

    V_NO:=1;
    RETURN V_NO;

END FN_TIME_DIFF;


FUNCTION  FN_VAL_TIME_DIFF(P_TIME_DIFF VARCHAR2)  RETURN NUMBER AS

    V_TIME_DIFF VARCHAR2(100);
    V_NO NUMBER;

    V_SIGN VARCHAR2(1);

BEGIN

   SELECT SUBSTR(TRIM(P_TIME_DIFF),1,1)  INTO V_SIGN FROM DUAL;

   IF(V_SIGN='-') THEN

   V_TIME_DIFF:= SUBSTR(TRIM(P_TIME_DIFF),2);

   ELSE

   V_TIME_DIFF:= TRIM(P_TIME_DIFF);

   END IF;

   IF(LENGTH(V_TIME_DIFF)<=2) THEN

   SELECT CASE WHEN REGEXP_LIKE(V_TIME_DIFF,'^[[:digit:]]+$') THEN 0 ELSE 1 END AS OUTPUT  INTO V_NO FROM DUAL;

   ELSIF (LENGTH(V_TIME_DIFF)=3) THEN

   SELECT CASE WHEN REGEXP_LIKE(V_TIME_DIFF,'^([[:digit:]]{2})([.]{1})$') THEN 0 ELSE 1 END AS OUTPUT INTO V_NO FROM DUAL;


   ELSE

   SELECT CASE WHEN REGEXP_LIKE(V_TIME_DIFF,'^([[:digit:]]{1,2})([.]{1})[[:digit:]]+$') THEN 0 ELSE 1 END AS OUTPUT INTO V_NO FROM DUAL;

   END IF;


   RETURN V_NO;

 END  FN_VAL_TIME_DIFF;


FUNCTION  FN_VAL_BRANCH_TELL(P_BR_TEL  VARCHAR2) RETURN NUMBER
    AS
    V_NO NUMBER;
BEGIN

        IF( LENGTH(TRIM(P_BR_TEL)) >=16 ) THEN
            V_NO:=1;
        ELSE
            SELECT CASE WHEN REGEXP_LIKE(P_BR_TEL,'^[[:digit:]]+$') THEN 0 ELSE 1  END AS OUTPUT INTO V_NO FROM DUAL;
        END IF;

        RETURN V_NO;
END FN_VAL_BRANCH_TELL;

FUNCTION FN_PAN_ISVALID (pPAN_NUMBER VARCHAR2)
    RETURN VARCHAR2
    AS
        TYPE REC IS REF CURSOR;
        TEMP_CUR            REC;
        VFIRST_FIVE         NUMBER;
        VMID_FOUR           NUMBER;
        VLAST_CHAR          CHAR(1);
        VFIFTH_CHAR         CHAR(1);
        vCheckSpaceCnt      NUMBER;
        excFIRST_FIVE       EXCEPTION;
        EXCPAN_LENGTH       EXCEPTION;
        excMID_FOUR         EXCEPTION;
        vError_msg          VARCHAR2(2000);

BEGIN

          IF LENGTH(PPAN_NUMBER)<>10 THEN
             RAISE EXCPAN_LENGTH;
          END IF;

          OPEN TEMP_CUR FOR
           SELECT INSTR(TRIM(PPAN_NUMBER),' ') SPACE_COUNT FROM DUAL;
          FETCH TEMP_CUR INTO vCheckSpaceCnt;
          CLOSE TEMP_CUR;

          IF NVL(vCheckSpaceCnt,0)!=0 THEN
              RETURN '1-Space character not allowed in Pan Number';
          END IF;

          OPEN TEMP_CUR FOR
           SELECT LENGTH(TRIM(TRANSLATE(SUBSTR(PPAN_NUMBER,1,5),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',' '))) FROM DUAL;
           FETCH TEMP_CUR INTO VFIRST_FIVE;
           CLOSE TEMP_CUR;

          IF VFIRST_FIVE IS NOT NULL THEN
             RAISE excFIRST_FIVE;
          END IF;

          OPEN TEMP_CUR FOR
           SELECT LENGTH(TRIM(TRANSLATE(SUBSTR(PPAN_NUMBER,6,4),'0123456789',' '))) FROM DUAL;
           FETCH TEMP_CUR INTO VMID_FOUR;
           CLOSE TEMP_CUR;

          IF VMID_FOUR IS NOT NULL THEN
             RAISE excMID_FOUR;
          END IF;

         VFIFTH_CHAR :=SUBSTR(PPAN_NUMBER,4,1);

         IF VFIFTH_CHAR<>'P' THEN
            RETURN '1-Fourth character must be ''P'' in Pan Number';
         END IF;


         VLAST_CHAR :=SUBSTR(PPAN_NUMBER,10,1);

         IF VLAST_CHAR NOT IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z') THEN

            RETURN '1-Last Character Must Be Alphabets in Pan Number';
         END IF;

            RETURN '0-SUCCESS';

          EXCEPTION
          WHEN EXCPAN_LENGTH THEN
            RETURN '1-Pan Number must be 10 character';

          WHEN excFIRST_FIVE THEN
            RETURN '1-First five character must be alphabets in PAN number';

          WHEN excMID_FOUR THEN
            RETURN '1-Sixth to nineth characters must be number in PAN Number';

          WHEN OTHERS THEN
            RETURN '1-'||SQLERRM;
END FN_PAN_ISVALID;


FUNCTION FN_DATE_VALDATION(P_EFF_DATE_FR  VARCHAR2) RETURN NUMBER
AS

  V_NO NUMBER;
BEGIN

 SELECT CASE WHEN REGEXP_LIKE(P_EFF_DATE_FR,'^([[:digit:]]{1,2})([/]{1})([[:digit:]]{1,2})([/]{1})([[:digit:]]{4})$') THEN 0 ELSE 1 END AS OUTPUT
        INTO V_NO
 FROM DUAL;

 RETURN V_NO;

END FN_DATE_VALDATION;

FUNCTION FN_GET_PARAMETERS_ID(P_PARA_MID VARCHAR2) RETURN VARCHAR2
    AS
    V_NO NUMBER;
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vPAR_AID            GM_PARAMETERS.PAR_AID%TYPE;
BEGIN

                OPEN curRec FOR
                    SELECT PAR_AID FROM GM_PARAMETERS
                        WHERE  UPPER(TRIM(PARA_MID)) = UPPER(TRIM(P_PARA_MID));
                FETCH curRec INTO vPAR_AID;
                CLOSE  curRec;

                RETURN vPAR_AID;
END FN_GET_PARAMETERS_ID;

 FUNCTION FN_CAST_DATE(pRawDateValue VARCHAR2) RETURN VARCHAR2
   AS
    vDateValue   VARCHAR2(11);
    BEGIN

       --Accept only DD-MM-YYYY or DD/MM/YYYY or DD-MMM-YYYY
       IF  LENGTH(pRawDateValue)IN (10,11) THEN
            vDateValue:= REPLACE(pRawDateValue,'/','-');
            RETURN  CASE WHEN LENGTH(vDateValue)=10 THEN TO_CHAR(TO_DATE(vDateValue, 'DD-MM-YYYY'),'DD-MON-RRRR')
                         ELSE TO_CHAR(TO_DATE(vDateValue, 'DD-MON-YYYY'),'DD-MON-RRRR')
                    END;
        ELSE
            RETURN TO_CHAR(TO_DATE(SUBSTR(pRawDateValue,1,10), 'YYYY-MM-DD'),'DD-MON-RRRR');
       END IF;


EXCEPTION
  WHEN OTHERS THEN
       RETURN pRawDateValue;
END FN_CAST_DATE;

    --Generating Sub Attribute Aid
FUNCTION FN_GENERATE_SUB_ATTB_AID (pComp_Aid VARCHAR2, pATTB_AID VARCHAR2,pID NUMBER ) RETURN VARCHAR2
        AS
        TYPE REF_CUR is ref cursor;
        curRec                  REF_CUR;
        vMaxNumber              NUMBER;
        vMaster_Aid             VARCHAR2(50);
BEGIN

          OPEN curRec FOR
             SELECT TO_NUMBER(MAX(SUBSTR(SUB_ATTB_AID,3))) SUB_ATTB_AID FROM PM_SUB_ATTRIBUTE
             WHERE COMP_AID = pComp_Aid AND ATTB_AID = pATTB_AID;
          FETCH curRec INTO vMaxNumber;

          vMaster_Aid := 'SB'||TRIM(TO_CHAR(NVL(vMaxNumber,0)+pID,'000000'));

          RETURN NVL(vMaster_Aid,'SB000000');

END FN_GENERATE_SUB_ATTB_AID;

FUNCTION FUNC_FORMAT_COLS(pVIEW_NAME VARCHAR2,pIsWithFormula VARCHAR2) RETURN VARCHAR2 AS
    vStrColumns LONG;
    /*this function returns formatted columns for Excel*/
BEGIN

   FOR I IN (SELECT DATA_TYPE,COLUMN_NAME,TABLE_NAME, COLUMN_ID
                  FROM USER_TAB_COLS WHERE TRIM(UPPER(TABLE_NAME))=TRIM(UPPER(pVIEW_NAME)) ORDER BY COLUMN_ID)
        LOOP

            IF pIsWithFormula='Y' THEN
                IF I.DATA_TYPE IN ('CHAR','VARCHAR2') THEN
                    vStrColumns:= vStrColumns||',''=TEXT("''||'||TRIM(I.COLUMN_NAME)||'||''","''||lpad(''0'',LENGTH(TRIM('||I.COLUMN_NAME||')),''0'')||''")'''||TRIM(I.COLUMN_NAME);
                ELSIF I.DATA_TYPE ='DATE' THEN
                   vStrColumns:= vStrColumns||',''=TEXT("''||'||TRIM(I.COLUMN_NAME)||'||''","DD-MMM-YYYY")'''||TRIM(I.COLUMN_NAME);
                ELSE
                    vStrColumns:= vStrColumns||', '||I.COLUMN_NAME;
                END IF;
            ELSE
                IF I.DATA_TYPE ='DATE' THEN
                    vStrColumns:= vStrColumns||',TO_CHAR('||TRIM(I.COLUMN_NAME)||',''DD-MON-YYYY'') '||TRIM(I.COLUMN_NAME);
                ELSE
                    vStrColumns:= vStrColumns||', '||I.COLUMN_NAME;
                END IF;
            END IF;
        END LOOP;

        vStrColumns:=SUBSTR(vStrColumns,2);

        RETURN vStrColumns;
END FUNC_FORMAT_COLS;


FUNCTION FN_GET_ACC_YEAR(pComp_ID VARCHAR2) RETURN VARCHAR2 AS
        TYPE CUR IS REF CURSOR;
        TEMP_RS CUR;
        vYearID varchar2(50);
BEGIN
        OPEN TEMP_RS FOR
        SELECT YEAR_ID FROM GM_ACCT_YEARS WHERE COMP_ID = pComp_id AND IS_YEAR_OPEN = 'Y' --AND FROM_DATE=
--            (SELECT MAX(FROM_DATE) FROM GM_ACCT_YEARS WHERE COMP_ID = pComp_id AND  IS_YEAR_OPEN='Y')
         ;
        FETCH TEMP_RS INTO vYearID;
        CLOSE TEMP_RS;

        RETURN vYearID;

END FN_GET_ACC_YEAR;

     --Added by vishal kute
FUNCTION FN_CHK_ACC_NO(pComp_ID VARCHAR2,pEmp_Mid  VARCHAR2,pBANK_ACC_NO VARCHAR2, pBANK_AID VARCHAR2) RETURN NUMBER AS
        TYPE CUR IS REF CURSOR;
        TEMP_VAL CUR;
        vVALID_ACC number(10);
BEGIN
        OPEN TEMP_VAL FOR
            SELECT COUNT(1) FROM GM_BANK
            WHERE TRIM(COMP_AID)=TRIM(pComp_ID)
            AND TRIM(BANK_AID)=TRIM(pBANK_AID)
            AND ACCOUNTNO_DIGITS>=NVL(LENGTH(TRIM(pBANK_ACC_NO)),0);
        FETCH TEMP_VAL INTO vVALID_ACC;
        CLOSE TEMP_VAL;

        RETURN vVALID_ACC;
END FN_CHK_ACC_NO;

FUNCTION FN_GET_ACC_SIZE(pComp_ID VARCHAR2, pBANK_AID VARCHAR2) RETURN VARCHAR2 AS
        TYPE CUR IS REF CURSOR;
        TEMP_VAL CUR;
        vACC_SIZE varchar2(30);
BEGIN
        OPEN TEMP_VAL FOR
            SELECT ACCOUNTNO_DIGITS FROM GM_BANK
            WHERE  TRIM(COMP_AID)=TRIM(pComp_ID) AND TRIM(BANK_AID)=TRIM(pBANK_AID);
        FETCH  TEMP_VAL INTO  vACC_SIZE;
        CLOSE TEMP_VAL;

        RETURN vACC_SIZE;

END FN_GET_ACC_SIZE;

FUNCTION FN_CHK_DUL_ACC(pComp_ID VARCHAR2, pBANK_ACC_NO VARCHAR2) RETURN NUMBER AS
        vCNT NUMBER(5);
BEGIN
        SELECT COUNT(1) INTO vCNT FROM GM_EMP
        WHERE  TRIM(COMP_ID)=TRIM(pComp_ID)
        AND TRIM(bank_acc_no)=TRIM(pBANK_ACC_NO);

        RETURN vCNT;
END FN_CHK_DUL_ACC;

FUNCTION FN_GET_CC_AID (pComp_ID VARCHAR2, pCC_Mid  VARCHAR2) RETURN VARCHAR2 AS
    TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vCC_Aid             GM_COST_CENTER.COST_CENTER_ID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT COST_CENTER_ID FROM GM_COST_CENTER
                WHERE UPPER(TRIM(COMP_CODE)) = UPPER(TRIM(pComp_ID)) AND UPPER(TRIM(COST_CODE)) = UPPER(TRIM(pCC_Mid));
        FETCH curRec INTO vCC_Aid;
        CLOSE  curRec;

        RETURN vCC_Aid;
END FN_GET_CC_AID;

FUNCTION FN_GET_SUB_DEPT_AID (pComp_ID VARCHAR2, pSub_Dept_Mid  VARCHAR2) RETURN VARCHAR2 AS
   TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    vSub_Dept_Aid          GM_SUB_DEPT.SUB_DEPT_AID%TYPE;
BEGIN

        OPEN curRec FOR
            SELECT SUB_DEPT_AID FROM GM_SUB_DEPT
                WHERE UPPER(TRIM(COMP_AID)) = UPPER(TRIM(pComp_ID)) AND UPPER(TRIM(SUB_DEPT_MID)) = UPPER(TRIM(pSub_Dept_Mid));
        FETCH curRec INTO vSub_Dept_Aid;
        CLOSE  curRec;

        RETURN vSub_Dept_Aid;
END FN_GET_SUB_DEPT_AID;
 FUNCTION FN_CHECK_DATE_FORMAT(pDATE VARCHAR2) RETURN NUMBER
 IS

 pValue  NUMBER(10);

    BEGIN

      FOR I IN (SELECT ROWNUM SRNO,FORMAT,LENGTH(FORMAT) FORMAT_LENGTH FROM (
                SELECT REGEXP_SUBSTR(pDATE,'[^/-]+',1,LEVEL) FORMAT FROM DUAL CONNECT BY REGEXP_SUBSTR(pDATE,'[^/-]+',1,LEVEL) IS NOT NULL))
         LOOP

           IF I.SRNO='1' AND I.FORMAT_LENGTH<>'2' THEN
              pValue :=0;
           ELSIF I.SRNO='2' AND (I.FORMAT_LENGTH<'2' OR I.FORMAT_LENGTH >'3') THEN
              pValue :=0;
           ELSIF I.SRNO='3' AND I.FORMAT_LENGTH<>'4' THEN
              pValue :=0;
           END IF;

         END LOOP;

       RETURN NVL(pValue,1);

END FN_CHECK_DATE_FORMAT;

 /** Added by Vishal Kute for Employee Code**/
FUNCTION GET_EMPLOYEE_CODE_NEWLY(PCOMP_ID VARCHAR2,VEMP_MID_LOGIC VARCHAR2,pID NUMBER) RETURN VARCHAR2
IS
 TYPE REF_CUR is ref cursor;
    curRec              REF_CUR;
    VMAXNUMBER          NUMBER;
    vMaster_Aid         VARCHAR2(50);
   BEGIN
      OPEN CURREC FOR
           SELECT MAX(TO_NUMBER(SUBSTR(TRANSLATE(UPPER(EMP_MID),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-_\/','X'),
                                      INSTR(TRANSLATE(UPPER(EMP_MID),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-_\/','X'),'X',-1)+1)))
                            FROM GM_EMP
                            WHERE COMP_ID=PCOMP_ID AND TRIM(UPPER(SUBSTR(EMP_MID,1,LENGTH(VEMP_MID_LOGIC))))=VEMP_MID_LOGIC;
           FETCH CURREC INTO VMAXNUMBER;


          VMASTER_AID:= TRIM(VEMP_MID_LOGIC||TRIM(NVL(VMAXNUMBER,1)+pID));

          CLOSE curRec;

        RETURN vMaster_Aid;
END GET_EMPLOYEE_CODE_NEWLY;

END HR_PK_VALIDATION;

