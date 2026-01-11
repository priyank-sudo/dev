create or replace PACKAGE                 "PY_PCK_REPORT_USER" IS
TYPE REC IS REF CURSOR;
       
--        PROCEDURE PRO_SALARY_REGISTER_REPORT(iOperation Varchar2,iComp_Aid varchar2,iAcc_Year Varchar2,iPay_Month Varchar2,iEmp_Aid Varchar2,iUser_Aid Varchar2,iExtraPara1 Varchar2,Return_Recordset OUT REC);
    PROCEDURE PRO_SALARY_REGISTER_REPORT(iOperation Varchar2,iComp_Aid varchar2,iAcc_Year Varchar2,iPay_Month Varchar2,iUser_Aid Varchar2,iExtraPara1 Varchar2,Return_Recordset OUT REC);

END ; 
 
 
 
 /
 
 
 create or replace PACKAGE BODY                       "PY_PCK_REPORT_USER" IS
--    PROCEDURE PRO_SALARY_REGISTER_REPORT(iOperation Varchar2,iComp_Aid varchar2,iAcc_Year Varchar2,iPay_Month Varchar2,iEmp_Aid Varchar2,iUser_Aid Varchar2,iExtraPara1 Varchar2,Return_Recordset OUT REC)
--        IS
--        TYPE Cur_Recordset IS REF CURSOR;
--        Cur_Temp                Cur_Recordset;
--        strSqlQuery             long;
--        strArrearSqlQuery       long;
--        strSubGrandTotalClause  long;
--        strGrandTotalClause     long;
--        strSelectClause         long;
--        strFromClause           long;
--        strWhereClause          long;
--        strGroupByClause        long;
--        strOrderByClause        long;
--        strWhereNullCond        long;
--        strAllowanceMonthly     LONG;
--        strOtherAllowance       LONG;
--        strDeduction            LONG;

--        BEGIN
--             --MASTER COLUMNNS
--             strSqlQuery:='SELECT ';
--             strSelectClause := ' B.EMP_MID AS "EMPLOYEE CODE",B.EMP_NAME AS "EMPLOYEE NAME",TO_CHAR(B.BIRTH_DATE,''DD-MON-YYYY'') AS "BIRTH DATE",TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOIN DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE", NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",NVL(E.PRV_MNTH_ADJUST,0) AS "ARREARS DAYS",B.SEX GENDER,D.DEPT_DESC AS DEPARTMENT, G.GRADE_DESC GRADE, C.DESG_DESC DESIGNATION,L.EMP_LEVEL_DESC AS "LEVEL", H.CC_DESC COSTCENTER,K.CHANNEL_DESC CHANNEL,I.LOC_DESC LOCATION,B.PAN_NUMBER AS "PAN NUMBER", B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",J.BANK_NAME AS "BANK NAME", ';
--             strGroupByClause:= ' B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,C.DESG_DESC,G.GRADE_DESC,D.DEPT_DESC,H.CC_DESC,I.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_CURR_ACCOUNT_NO,B.PAN_NUMBER,J.BANK_NAME, K.CHANNEL_DESC ,E.DAYS_PRESENT,E.PRV_MNTH_ADJUST,L.EMP_LEVEL_DESC,B.BIRTH_DATE,B.SEX,';
--             strOrderByClause:= ' ORDER BY B.EMP_MID ';

--               --Salary Register Allowance column
--             IF iOperation<>'F' THEN
--                   FOR I IN (SELECT DISTINCT 'ROUND(SUM(DECODE(TRIM(F.ALLWDED_MID),'''||TRIM(ALLWDED_MID)||''',NVL(A.AMOUNT,0),0)),2) AS "'||SUBSTR(TRIM(ALLWDED_DESC),1,30)||'",' FLD_NAME,B.ALLWDED_MID,SUBSTR(TRIM(B.ALLWDED_DESC),1,30) ALLWDED_DESC,B.SORT_ORDER,B.ALLWDED_TYPE,C.PARA_DESC  FROM PT_SAL_DT A,PM_ALLWDED B,GM_PARA C
--                                WHERE A.COMP_AID = B.COMP_AID AND A.ALLWDED_AID =B.ALLWDED_AID AND B.ALLWDED_CAT = C.PARA_AID AND A.ARR_FLAG<>'F' AND A.AMOUNT<>0
--                                      AND A.COMP_AID = iComp_Aid AND A.ACC_YEAR = iAcc_Year AND A.PAY_MONTH = iPay_Month
--                                ORDER BY B.ALLWDED_TYPE,C.PARA_DESC,B.SORT_ORDER,ALLWDED_DESC
--                             )
--                         LOOP
--                             IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME)))=0 THEN
--                                IF TRIM(I.ALLWDED_TYPE) = 'A' Then
--                                    strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME;
--                                ELSIF TRIM(I.ALLWDED_TYPE) = 'D' Then
--                                    strDeduction := strDeduction||I.FLD_NAME;
--                                END IF;
--                             END IF;
--                         END LOOP;
--            ELSE
--                FOR I IN (SELECT DISTINCT 'ROUND(SUM(DECODE(TRIM(F.ALLWDED_MID),'''||TRIM(ALLWDED_MID)||''',NVL(A.AMOUNT,0),0)),2) AS "'||SUBSTR(TRIM(ALLWDED_DESC),1,30)||'",' FLD_NAME,B.ALLWDED_MID,SUBSTR(TRIM(B.ALLWDED_DESC),1,30) ALLWDED_DESC,B.SORT_ORDER,B.ALLWDED_TYPE,C.PARA_DESC  FROM PT_SAL_DT A,PM_ALLWDED B,GM_PARA C
--                        WHERE A.COMP_AID = B.COMP_AID AND A.ALLWDED_AID =B.ALLWDED_AID AND B.ALLWDED_CAT = C.PARA_AID AND A.ARR_FLAG='F' AND A.AMOUNT<>0
--                              AND A.COMP_AID = iComp_Aid AND A.ACC_YEAR = iAcc_Year AND A.PAY_MONTH = iPay_Month
--                        ORDER BY B.ALLWDED_TYPE,C.PARA_DESC,B.SORT_ORDER,ALLWDED_DESC
--                     )
--                 LOOP
--                         LOOP
--                             IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME)))=0 THEN
--                                IF TRIM(I.ALLWDED_TYPE) = 'A' Then
--                                    strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME;
--                                ELSIF TRIM(I.ALLWDED_TYPE) = 'D' Then
--                                    strDeduction := strDeduction||I.FLD_NAME;
--                                END IF;
--                             END IF;
--                         END LOOP;
--                 END LOOP;
--
--            END IF;

--         --  Total Gross ,Deduction and Net Salary
--           strSelectClause:=strSelectClause||strAllowanceMonthly||' SUM(CASE WHEN TRIM(M.PARA_DESC)=''ALLOWANCE MONTHLY'' AND F.ALLWDED_TYPE=''A'' THEN NVL(A.AMOUNT,0) ELSE 0 END) AS "GROSS SALARY", ';
--           strSelectClause:=strSelectClause||strOtherAllowance||' SUM(DECODE(F.ALLWDED_TYPE,''A'',A.AMOUNT,0)) AS "TOTAL EARNING",';
--           strSelectClause:=strSelectClause||strDeduction||' SUM(DECODE(F.ALLWDED_TYPE,''D'',A.AMOUNT,0)) AS "TOTAL DEDUCTION",';
--           strSelectClause:=strSelectClause||' SUM(DECODE(F.ALLWDED_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';

--           strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause))-1);
--           strGroupByClause:=' GROUP BY '||SUBSTR(TRIM(strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);
--
--           strFromClause:= ' FROM PT_SAL_DT A,GM_EMPMAST B,GM_DESG C,GM_DEPT D,PM_ALLWDED F, GM_GRADE G, GM_COSTCENTRE H, GM_LOCN I,GM_BANK J, GM_CHANNEL K ,PT_PRESENT E,VW_EMPLOYEE_ATTR_MASTER L,GM_PARA M,PT_SAL_HD O ';
--           strWhereClause:=' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID
--                                 AND O.COMP_AID = C.COMP_AID (+) AND O.DESG_AID = C.DESG_AID (+)
--                                 AND O.COMP_AID = D.COMP_AID (+) AND O.DEPT_AID = D.DEPT_AID (+)
--                                 AND O.COMP_AID = G.COMP_AID (+) AND O.EMP_GRADE= G.GRADE_AID (+)
--                                 AND O.COMP_AID = H.COMP_AID (+) AND O.CC_AID= H.CC_AID (+)
--                                 AND O.COMP_AID = I.COMP_AID (+) AND O.LOC_AID= I.LOC_AID  (+)
--                                 AND A.COMP_AID = E.COMP_AID (+) AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PAY_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
--                                 AND A.COMP_AID = O.COMP_AID AND A.ACC_YEAR=O.ACC_YEAR AND A.PAY_MONTH=O.PAY_MONTH  AND A.EMP_AID = O.EMP_AID
--                                 AND A.COMP_AID = F.COMP_AID (+) AND A.ALLWDED_AID =F.ALLWDED_AID (+)  AND F.ALLWDED_CAT = M.PARA_AID
--                                 AND O.COMP_AID = J.COMP_AID (+) AND O.BANK_AID =J.BANK_AID (+)
--                                 AND O.COMP_AID = K.COMP_AID (+) AND O.CHANNEL_AID = K.CHANNEL_AID (+)
--                                 AND O.COMP_AID = L.COMP_AID (+) AND O.EMP_AID = L.EMP_AID (+) ';
--                --For FNF data
--                IF iOperation<>'F' THEN
--                    strWhereClause:=strWhereClause||' AND A.ARR_FLAG<>''F'' ';
--                ELSE
--                    strWhereClause:=strWhereClause||' AND A.ARR_FLAG=''F'' ';
--                END IF;
--                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||iComp_Aid||''''||' AND A.ACC_YEAR = '||''''||iAcc_Year||''''||' AND A.PAY_MONTH='||''''||iPay_Month||'''';

--            strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||' '||strGroupByClause||strOrderByClause;

----                    INSERT INTO TEMP_QUERY VALUES(strSqlQuery);
----                    COMMIT;

--            --Finally Return the recordset here
--            OPEN Return_Recordset FOR strSqlQuery ;
--
--        END PRO_SALARY_REGISTER_REPORT;

        PROCEDURE PRO_SALARY_REGISTER_REPORT(iOperation Varchar2,iComp_Aid varchar2,iAcc_Year Varchar2,iPay_Month Varchar2,iUser_Aid Varchar2,iExtraPara1 Varchar2,Return_Recordset OUT REC)
        IS
        TYPE Cur_Recordset IS REF CURSOR;
        Cur_Temp                Cur_Recordset;
        strSqlQuery             long;
        strSqlQueryOuter        long;
        strArrearSqlQuery       long;
        strSubGrandTotalClause  long;
        strGrandTotalClause     long;
        strSelectClause         long;
        strFromClause           long;
        strWhereClause          long;
        strGroupByClause        long;
        strOrderByClause        long;
        strWhereNullCond        long;
        strAllowanceMonthly     LONG;
        strOtherAllowance       LONG;
        strDeduction            LONG;
        strUNION1            LONG;
         
         VBATCH_ID            VARCHAR2(12); ---BATCH PROCESSING CHANGES ADDED BY ANISH BHOIL ON 06TH JAN 2020, REQUESTED BY RAJESH SIR,VINIT SIR. 
         Type Recordset Is Ref Cursor;
         temp_cur           Recordset;
         RS_Temp           Recordset;

        BEGIN
             
             
            OPEN RS_Temp FOR
                  SELECT MAX(BATCH_ID) FROM PY_PM_MONTH_STATUS WHERE COMP_AID=iComp_Aid AND PAY_MONTH=iPay_Month;
              FETCH RS_Temp INTO vBATCH_ID; ---BATCH PROCESSING CHANGES ADDED BY ANISH BHOIL ON 06TH JAN 2020, REQUESTED BY RAJESH SIR,VINIT SIR.
            CLOSE RS_Temp;
             
             --MASTER COLUMNNS

            strSqlQuery:='SELECT ';
            strSelectClause := 'O.COMP_NAME "COMPANY NAME",B.EMP_MID AS "CODE",B.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
                                N.ARREAR_DAYS AS "ARREAR DAYS" ,B.CC_DESC "COST CENTER",B.EMP_MGMT_CATE_MID "MGMT/NONMGMT",B.SUB_DEPT_DESC "SUB DEPARTMENT",B.BAND_DESC "SUB LEVEL", B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
                                B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",B.PAN_NUMBER AS "PAN NUMBER",';
            strGroupByClause:= 'O.COMP_NAME,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,
                                B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER,N.ARREAR_DAYS,B.CC_DESC,B.EMP_MGMT_CATE_MID,B.SUB_DEPT_DESC,B.BAND_DESC, ';
            strOrderByClause:= ' ORDER BY B.EMP_MID ';
          
               --Salary Register Allowance column
             IF IOPERATION<>'F' THEN
             /*COMMENTED BY SATISH DATAED AS ON 17-OCT-2013
                  FOR I IN (SELECT DISTINCT 'ROUND(SUM(CASE WHEN A.ARR_FLAG <>''A'' THEN DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',NVL(A.AMOUNT,0),0) END),2) AS "'||SUBSTR(B.CTC_NAME,1,30)||'",' FLD_NAME_EAR,
                                '"'||SUBSTR(B.CTC_NAME,1,30)||'",' FLD_NAME_EAR_DESC,
                                CASE WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0 THEN 'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'||SUBSTR(B.CTC_NAME,1,26)||'_ARR'||'",' ELSE NULL END FLD_NAME_ARR,
                                 CASE WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0 THEN '"'||SUBSTR(B.CTC_NAME,1,26)||'_ARR'||'",' ELSE NULL END FLD_NAME_ARR_DESC,
                                'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''||TRIM(CTC_MID)||''',NVL(A.AMOUNT,0),0)),2) AS "'||SUBSTR(TRIM(CTC_NAME),1,30)||'",' FLD_NAME,'"'||SUBSTR(TRIM(CTC_NAME),1,30)||'",' FLD_NAME_DESC,
                                 B.DISP_ORDER,B.CTC_TYPE,C.PARA_DESC,B.CTC_NAME,B.CTC_MID
                                 FROM PY_PT_SAL_DT A,PY_CTC_ALLOWANCE_MAST B,PY_GM_PARAMETERS C
                                WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID =B.CTC_CODE AND B.CTC_CATE_ID = C.PAR_AID AND A.ARR_FLAG<>'F' AND A.AMOUNT<>0
                                        AND A.COMP_AID = iComp_Aid AND A.ACC_YEAR = iAcc_Year AND A.PAY_MONTH = iPay_Month
                                GROUP BY B.CTC_TYPE,C.PARA_DESC,B.DISP_ORDER,B.CTC_NAME,B.CTC_MID
                                ORDER BY B.CTC_TYPE,B.DISP_ORDER
                             )*/
                   FOR I IN (SELECT DISTINCT 'ROUND(SUM(CASE WHEN A.ARR_FLAG <>''A'' THEN DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',NVL(A.AMOUNT,0),0) END),2) AS "'||SUBSTR(B.REG_DISP_NAME,1,30)||'",' FLD_NAME_EAR,
                                '"'||SUBSTR(B.REG_DISP_NAME,1,30)||'",' FLD_NAME_EAR_DESC,
                                CASE WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0 THEN 'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'||SUBSTR(B.REG_DISP_NAME,1,26)||'_ARR'||'",' ELSE NULL END FLD_NAME_ARR,
                                 CASE WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0 THEN '"'||SUBSTR(B.REG_DISP_NAME,1,26)||'_ARR'||'",' ELSE NULL END FLD_NAME_ARR_DESC,
                                'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''||TRIM(CTC_MID)||''',NVL(A.AMOUNT,0),0)),2) AS "'||SUBSTR(TRIM(REG_DISP_NAME),1,30)||'",' FLD_NAME,'"'||SUBSTR(TRIM(REG_DISP_NAME),1,30)||'",' FLD_NAME_DESC,
                                 B.DISP_ORDER,B.CTC_TYPE,C.PARA_DESC,B.REG_DISP_NAME,B.CTC_MID
                                 FROM PY_PT_SAL_DT A,PY_CTC_ALLOWANCE_MAST B,PY_GM_PARAMETERS C
                                WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID =B.CTC_CODE AND B.CTC_CATE_ID = C.PAR_AID AND A.ARR_FLAG<>'F' AND A.AMOUNT<>0
                                        AND A.COMP_AID = iComp_Aid AND A.ACC_YEAR = iAcc_Year AND A.PAY_MONTH = iPay_Month
                                GROUP BY B.CTC_TYPE,C.PARA_DESC,B.DISP_ORDER,B.REG_DISP_NAME,B.CTC_MID
                                ORDER BY B.CTC_TYPE,B.DISP_ORDER
                             )
                         LOOP
                             IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
                                IF TRIM(I.CTC_TYPE) = 'A' Then
                                   IF TRIM(I.CTC_MID)='OVT' THEN
                                      strAllowanceMonthly := strAllowanceMonthly ||'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",';
                                   ELSE
                                     strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||I.FLD_NAME_ARR;
                                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
                                   END IF;
                                ELSIF TRIM(I.CTC_TYPE) = 'D' Then
                                    strDeduction := strDeduction||I.FLD_NAME;
                                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
                                END IF;
                             END IF;
                         END LOOP;
            ELSE
                FOR I IN (SELECT DISTINCT 'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''||TRIM(CTC_MID)||''',NVL(A.AMOUNT,0),0)),2) AS "'||SUBSTR(TRIM(CTC_NAME),1,30)||'",' FLD_NAME,
                                '"'||SUBSTR(TRIM(CTC_NAME),1,30)||'",' FLD_NAME_DESC,
                                  B.CTC_MID,SUBSTR(TRIM(B.CTC_NAME),1,30) CTC_NAME,B.SORT_ORDER,B.CTC_TYPE,C.PARA_DESC
                             FROM PY_PT_SAL_DT A,PY_CTC_ALLOWANCE_MAST B,PY_GM_PARAMETERS C
                            WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID =B.CTC_MID AND B.CTC_CATE_ID = C.PAR_AID AND A.ARR_FLAG='F' AND A.AMOUNT<>0
                              AND A.COMP_AID = iComp_Aid AND A.ACC_YEAR = iAcc_Year AND A.PAY_MONTH = iPay_Month
                        ORDER BY B.CTC_TYPE,B.DISP_ORDER
                     )
                 LOOP
                     IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME)))=0 THEN
                             IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME)))=0 THEN
                                IF TRIM(I.CTC_TYPE) = 'A' Then
                                    strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME;
                                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
                                ELSIF TRIM(I.CTC_TYPE) = 'D' Then
                                    strDeduction := strDeduction||I.FLD_NAME;
                                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
                                END IF;
                             END IF;
                     END IF;
                 END LOOP;

            END IF;

         --  Total Gross ,Deduction and Net Salary
           strSelectClause:=strSelectClause||strAllowanceMonthly||' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
           strSelectClause:=strSelectClause||strDeduction||' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
           strSelectClause:=strSelectClause||' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
           --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';

           strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause))-1);
           strGroupByClause:=' GROUP BY '||SUBSTR(TRIM(strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);

           strFromClause:= ' FROM PY_PT_SAL_DT A,PY_GM_EMPMAST B,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,PY_GM_COMP O,
                                (--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''||iComp_Aid||''' AND ACC_YEAR='''||iAcc_Year||'''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||iPay_Month||''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
                                --UNION ALL
                                SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
                                WHERE COMP_AID='''||iComp_Aid||''' AND ACC_YEAR='''||iAcc_Year||''' AND PAY_MONTH='''||iPay_Month||''' AND PAY_MONTH<>ARR_MONTH
                                GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N ';
           strWhereClause:=' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID  AND A.BATCH_ID='''||VBATCH_ID||''' 
                                 AND A.COMP_AID = E.COMP_AID (+) AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PAY_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
                                 AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PAY_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
                                 AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID AND A.COMP_AID=O.COMP_ID ';
---BATCH PROCESSING CHANGES ADDED BY ANISH BHOIL ON 06TH JAN 2020, REQUESTED BY RAJESH SIR,VINIT SIR.
                --For FNF data
                IF iOperation<>'F' THEN
                    strWhereClause:=strWhereClause||' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= TO_DATE(01||'''||iPay_Month||''')))';
                ELSE
                    strWhereClause:=strWhereClause||' AND A.ARR_FLAG=''F'' ';
                END IF;
                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||iComp_Aid||''''||' AND A.ACC_YEAR = '||''''||iAcc_Year||''''||' AND A.PAY_MONTH='||''''||iPay_Month||'''';

            strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||' '||strGroupByClause||strOrderByClause;
            
            DELETE FROM VAI;
            INSERT INTO VAI VALUES(strSqlQuery); 
            COMMIT;
            
            
            
            --Finally Return the recordset here
            OPEN Return_Recordset FOR strSqlQuery ;

        END ;

END;
 