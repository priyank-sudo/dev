create or replace PACKAGE                  "PY_PK_STANDARD_REPORTS" IS
 TYPE REC IS REF CURSOR;

 TYPE arrTyp_Batch_Id IS TABLE OF VARCHAR2(25) INDEX BY PLS_INTEGER;

 FUNCTION GET_CONDITION(pMasterType VARCHAR2,pMultisheetCondition VARCHAR2) RETURN VARCHAR2;

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

 --Reurns Data Set, Data Tables & resp. procedures
 PROCEDURE FILL_REPORT_DATASET(pREPORT_ID VARCHAR2,pRPT_DATASET_ID VARCHAR2,Return_Recordset OUT REC);

 --Fill Batch List
 PROCEDURE FILL_BATCH_LIST(pComp_Aid VARCHAR2,pFrom_Date DATE,pTo_Date DATE,P_SEARCH_COLUMN VARCHAR2,P_SEARCH_VALUE VARCHAR2,Return_Recordset OUT REC);

 --Insert the selected batch data in temporary table
 PROCEDURE INSERT_BATCH_DATA_TEMPORARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportID VARCHAR2,pBatch_Id arrTyp_Batch_Id);

 --Insert the selected batch data in temporary table
 PROCEDURE INSERT_BATCH_DATA_TEMPORARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pBatch_Id arrTyp_Batch_Id,pFilterID VARCHAR2);

 --Insert the Emp List as per Filter data in temporary table
 PROCEDURE INSERT_FILTER_DATA_TEMPORARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsMultipleSheet VARCHAR2,pFilterID VARCHAR2);

 --Return Company Name & Pay Month
 --PROCEDURE RETURN_COMPANY_NAME_PAY_MONTH(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pBatch_Id arrTyp_Batch_Id,pFilterId VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE RETURN_COMPANY_NAME_PAY_MONTH(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
 pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,
 pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);


-- PROCEDURE SALARY_REGISTER_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
-- pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,
-- pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE SALARY_REGISTER_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
                                        pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,
                                        pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);


 PROCEDURE GET_REPORT_DTL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pReportID VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pComp_Name OUT VARCHAR2,pReport_Name OUT VARCHAR2);
 --Generating the salary register Variance report
 PROCEDURE SALARY_REGISTER_VARIANCE_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE TDS_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating PT Report State & Location Wise
 PROCEDURE PT_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating PT Report EMPLOYEE Wise
 PROCEDURE PT_RPT_EMPWISE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating PT Report
 PROCEDURE PF_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating ESIC Report
 PROCEDURE ESIC_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating LWF Report
 PROCEDURE LWF_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating CTC Report Vertical
 PROCEDURE CTC_RPT_VERTICAL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date varchar2,pTo_Date varchar2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Generating CTC Report Horizontal
-- PROCEDURE CTC_RPT_HORIZONTAL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date varchar2,pTo_Date varchar2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

      PROCEDURE CTC_RPT_HORIZONTAL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date varchar2,pTo_Date varchar2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
                                 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);


  PROCEDURE ACTIVE_MASTER_DATA(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date varchar2,pTo_Date varchar2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
                                 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Generating CTC Report
 PROCEDURE ALLOWANCE_DEDUCT_SUMMARY_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Bank Report & Payorder

 PROCEDURE BANK_PAYORDER_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE INVESTMENT_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE INVESTMENT_DECLARATION_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE SALARY_SUMMARY_GRADEWISE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
 pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,
 pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);
 PROCEDURE SALARY_SUMMARY_COSTCENTERWISE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE SALARY_SUMMARY_DEPARTMENTWISE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE LOAN_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE CLAIM_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE LWP_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE BALANCE_TAX_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE EARNING_DEDCUTION_SUMMARY_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE FORM12C_CHECKLIST_RPT (pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE PREVIOUS_EMP_DETAILS_RPT (pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE ESIC_MC_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE ECR_PF_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
-- PROCEDURE PAYSLIP_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pBatch_Id arrTyp_Batch_Id,pFilterId VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE Fillempdetails(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE FILLSALARY_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);

 PROCEDURE FILL_INVESTMENT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);

-- PROCEDURE FILL_INVESTMENT1(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
-- pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,
-- pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE FILL_INVESTMENT1(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);

 PROCEDURE FILL_INVESTMENT2(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);

 PROCEDURE FILL_INVESTMENT_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE NUMTOWORD(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);

 PROCEDURE FILL_TAXSHEET_DETAIL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 --Added By BISHAL KUTE
 PROCEDURE FILL_TAXSHEET_DETAIL_FIRST(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By BISHAL KUTE
 PROCEDURE FILL_TAXSHEET_DETAIL_SECOND(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By BISHAL KUTE
 PROCEDURE FILL_OTHER_INCOME_LOSSES(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By BISHAL KUTE
 PROCEDURE FILL_PREVIOUS_EMPLOYER(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By BISHAL KUTE
 PROCEDURE FILL_DETAILS_OF_PERQUSITE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By VISHAL KUTE
 PROCEDURE FILL_OTHER_CLAIMS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE FILL_LEASE_ACCOMODATION(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By BISHAL KUTE
 PROCEDURE FILL_RENT_PAID_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 --Added By BISHAL KUTE
 PROCEDURE FILL_TAX_DEDUCT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE FILL_TAX_PAYMONTH(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE SALARY_REGISTER_RPT_FORMATTED(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
 pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,
 pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC);
 PROCEDURE SALARY_SUMMARY(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE GET_EMP_DETAIL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE GET_EARNING_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE GET_ARREAR_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);


 PROCEDURE GET_DEDUCTION_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE GET_ALLOW_DEDUC_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMultiSheetCondition VARCHAR2,
 PCURSOR OUT REC);
 PROCEDURE GET_REIMB_EMP_HEADDETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE FILLEMP_INFO(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE GET_EMP_REIMDETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
 pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

 PROCEDURE SALARY_REGISTER_CTC_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
 pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
 pReportType VARCHAR2,pReportID VARCHAR2,
 pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMultiSheetCondition VARCHAR2,
 Return_Recordset OUT REC) ;

 PROCEDURE GET_MONTH_FOR(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pReportID VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pReport_ForMonth OUT VARCHAR2);

 PROCEDURE COMBINE_SALARY_REGISTER_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
 pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,
 pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);
 PROCEDURE BANK_FUNDING_RPT(pComp_Aid VARCHAR2, pAcc_Year VARCHAR2,
            pPay_Month VARCHAR2, pFrom_Date DATE, pTo_Date DATE, pUser_Aid VARCHAR2,
            pSessionId VARCHAR2, pReportType VARCHAR2, pReportID VARCHAR2,
            pIsBatchWiseReport VARCHAR2, pFilterId VARCHAR2,
            pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,
            pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

  PROCEDURE BANK_UPD_RPT(pComp_Aid VARCHAR2, pAcc_Year VARCHAR2, pPay_Month VARCHAR2, pFrom_Date DATE, pTo_Date DATE, pUser_Aid VARCHAR2, pSessionId VARCHAR2, pReportType VARCHAR2, pReportID VARCHAR2, pIsBatchWiseReport VARCHAR2, pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2, Return_Recordset OUT REC);

  PROCEDURE ICICI_BANK_UPD_RPT(pComp_Aid VARCHAR2, pAcc_Year VARCHAR2, pPay_Month VARCHAR2, pFrom_Date DATE, pTo_Date DATE, pUser_Aid VARCHAR2, pSessionId VARCHAR2, pReportType VARCHAR2, pReportID VARCHAR2, pIsBatchWiseReport VARCHAR2, pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2, Return_Recordset OUT REC);

  PROCEDURE STATUTORY_PF_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

  PROCEDURE FILL_LOGO( pComp_Aid VARCHAR2, pAcc_Year VARCHAR2, pPay_Month VARCHAR2, pFrom_Date DATE, pTo_Date DATE, pUser_Aid VARCHAR2, pSessionId VARCHAR2, pReportType VARCHAR2, pReportID VARCHAR2, pIsBatchWiseReport VARCHAR2, pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2, Return_Recordset OUT REC);

    PROCEDURE FILL_LEAVE_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
 pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,
 pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

PROCEDURE MASTER_VARIANCE_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
  pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
  pReportType VARCHAR2,pReportID VARCHAR2,
  pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,
  Return_Recordset OUT REC);

PROCEDURE LWF_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
 pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,
 pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

PROCEDURE WESTIN_PF_REPORT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
 pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,
 pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);

PROCEDURE CTC_RPT_WITH_EMPLOYEE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date varchar2,pTo_Date varchar2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,
                                        pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC);


END PY_PK_STANDARD_REPORTS;


/


create or replace PACKAGE BODY                                             "PY_PK_STANDARD_REPORTS"
IS
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
  BEGIN
    OPEN TEMP_RS FOR
    -- SELECT 'SELECT DISTINCT NVL('||MASTER_COL_NAME||',''OTHERS'') FROM
    -- PY_PT_SAL_HD WHERE COMP_AID = '''||pComp_Aid||''' AND TO_DATE(01||
    -- PAY_MONTH) BETWEEN TO_DATE('''||pFrom_Date||''') AND TO_DATE('''||
    -- pTo_Date||''')'
    SELECT 'SELECT DISTINCT NVL('||MASTER_COL_NAME||
    ',''OTHERS'') FROM PY_GM_EMPMAST WHERE COMP_AID = '''||pComp_Aid||''''
    FROM PY_GM_MASTER_COL_NAME
    WHERE MASTER_TYPE = pMasterType;
    FETCH
      TEMP_RS
    INTO
      vUsedMasterAid;
  CLOSE TEMP_RS;
  vStrQuery :=
  'SELECT DISTINCT SUBSTR(TRANSLATE(MASTER_DESC,'':/?\*[]'''''','' ''),1,30) EXCEL_SHEET_NAME,NVL('''
  ||pIsMultipleSheet||
  ''',''N'') ISMULTISHEET ,MASTER_TYPE , MASTER_AID MASTER_CONDITION_VALUE
--FROM PY_GM_GENERAL_MASTER
FROM PY_VW_GM_GENERAL_MASTER
WHERE  TRIM(MASTER_TYPE) = TRIM('''
  ||pMasterType||''') AND NVL('''||pIsMultipleSheet||
  ''',''N'') = ''Y'' AND DECODE(COMP_AID,''CM000000'','''||pComp_Aid||
  ''', COMP_AID)= '''||pComp_Aid||'''';
  IF(pIsMultipleSheet = 'Y') THEN
    vStrQuery        :=vStrQuery ||' AND MASTER_AID IN ('||vUsedMasterAid||')';
  END IF;
  IF pReportID IN ('RP00000007','RP00000004') THEN
    vStrQuery :=vStrQuery ||' UNION ALL
SELECT DISTINCT '''||
    pReportID||''' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||pMasterType||
    ''' MASTER_TYPE , ''ALL'' MASTER_CONDITION_VALUE FROM DUAL
UNION ALL
SELECT DISTINCT '''
    ||pReportID||'_SUMMARY'' EXCEL_SHEET_NAME, ''Y'' ISMULTISHEET, '''||
    pMasterType||
    ''' MASTER_TYPE , ''SUMMARY'' MASTER_CONDITION_VALUE FROM DUAL';
  ELSIF pReportID IN ('IR000001') THEN
      vStrQuery :=vStrQuery ||' UNION ALL
                                SELECT DISTINCT ''Investment'' EXCEL_SHEET_NAME, ''Y'' ISMULTISHEET,
                                '''||pMasterType||''' MASTER_TYPE , ''I'' MASTER_CONDITION_VALUE FROM DUAL
                                UNION ALL
                                SELECT DISTINCT ''Rent'' EXCEL_SHEET_NAME, ''Y'' ISMULTISHEET,
                                '''||pMasterType||''' MASTER_TYPE , ''R'' MASTER_CONDITION_VALUE FROM DUAL
                                UNION ALL
                                SELECT DISTINCT ''Form 12B'' EXCEL_SHEET_NAME, ''Y'' ISMULTISHEET,
                                '''||pMasterType||''' MASTER_TYPE , ''B'' MASTER_CONDITION_VALUE FROM DUAL
                                UNION ALL
                                SELECT DISTINCT ''Form 12C'' EXCEL_SHEET_NAME, ''Y'' ISMULTISHEET,
                                '''||pMasterType||''' MASTER_TYPE , ''C'' MASTER_CONDITION_VALUE FROM DUAL';
  ELSE
    vStrQuery :=vStrQuery ||' UNION ALL
SELECT DISTINCT '''||
    pReportID||''' EXCEL_SHEET_NAME, ''N'' ISMULTISHEET, '''||pMasterType||
    ''' MASTER_TYPE , ''ALL'' MASTER_CONDITION_VALUE FROM DUAL';
  END IF;
  vStrQuery :=vStrQuery||' ORDER BY 2 DESC';
 COMMIT;
  OPEN Return_Recordset FOR vStrQuery;
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
    SELECT
    --REPLACE(WM_CONCAT(FILTER_COL),',AND',' AND')
    REPLACE(LISTAGG(FILTER_COL,',') WITHIN GROUP (ORDER BY FILTER_COL) ,',AND',' AND')
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
--PROCEDURE SALARY_REGISTER_RPT(
--    pComp_Aid            VARCHAR2,
--    pAcc_Year            VARCHAR2,
--    pPay_Month           VARCHAR2,
--    pFrom_Date           DATE,
--    pTo_Date             DATE,
--    pUser_Aid            VARCHAR2,
--    pSessionId           VARCHAR2,
--    pReportType          VARCHAR2,
--    pReportID            VARCHAR2,
--    pIsBatchWiseReport   VARCHAR2,
--    pFilterId            VARCHAR2,
--    pIsMultipleSheet     VARCHAR2,
--    pMasterType          VARCHAR2,
--    pMultiSheetCondition VARCHAR2,
--    Return_Recordset OUT REC)
--IS
--TYPE Cur_Recordset
--IS
--  REF
--  CURSOR;
--    Cur_Temp Cur_Recordset;
--    strSqlQuery LONG;
--    strSqlQueryOuter LONG;
--    strArrearSqlQuery LONG;
--    strSubGrandTotalClause LONG;
--    strGrandTotalClause LONG;
--    strSelectClause LONG;
--    strFromClause LONG;
--    strWhereClause LONG;
--    strGroupByClause LONG;
--    strOrderByClause LONG;
--    strWhereNullCond LONG;
--    strAllowanceMonthly LONG;
--    strOtherAllowance LONG;
--    strDeduction LONG;
--    strExSelectClause LONG;
--    strExGroupByClause LONG;
--    strSqlQueryFormat LONG;
--    strGetCompName LONG;
--    strGetRptName LONG;
--    strNullHead LONG;
--    vCount NUMBER(10) DEFAULT 1;
--    strDedNullHead LONG;
--    strAllwNullHead LONG;
--    strAllwanceHead LONG;
--    strDeductionHead LONG;
--    -- strNullHead         LONG;
--  BEGIN
--    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
--    pTo_Date,strGetCompName,strGetRptName);
--    vCount :=1;
--    --MASTER COLUMNNS
--    strSqlQuery          :='SELECT * FROM (SELECT ';
--    IF pIsBatchWiseReport = 'Y' THEN
--      strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
--      strExGroupByClause :='A.BATCH_ID, ';
--    END IF;
--    strSelectClause :=
--    '''AC'' "REPORT_HEADER",A.PROCESS_MONTH "PAY MONTH", B.EMP_MID AS "CODE",B.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
--N.ARREAR_DAYS AS "ARREAR DAYS" ,B.CC_DESC "COST CENTER",B.EMP_MGMT_CATE_MID "MGMT/NONMGMT",B.SUB_DEPT_DESC "SUB DEPARTMENT",B.BAND_DESC "SUB LEVEL", B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
--B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",B.PAN_NUMBER AS "PAN NUMBER",'
--    ;
--    strGroupByClause:=
--    'A.PROCESS_MONTH,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,
--B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER,N.ARREAR_DAYS,B.CC_DESC,B.EMP_MGMT_CATE_MID,B.SUB_DEPT_DESC,B.BAND_DESC , '
--    ;
--    strOrderByClause:= ' ORDER BY B.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)'||') '
--    ;--||GET_GROUP_BY_COLS(pMasterType,'N')|
--    FOR I IN
--    (
--      SELECT DISTINCT
--        'ROUND(SUM(CASE WHEN A.ARR_FLAG !=''A'' THEN DECODE(TRIM(F.CTC_MID),'''
--        ||TRIM(B.CTC_MID)
--        ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
--        ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
--        ||'",' FLD_NAME_EAR,
--        '"'
--        ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
--        ||'",' FLD_NAME_EAR_DESC,
--        CASE
--          WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
--          THEN
--            'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''
--            ||TRIM(B.CTC_MID)
--            ||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'
--            ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
--            ||'_ARR'
--            ||'",'
--          ELSE NULL
--        END FLD_NAME_ARR,
--        CASE
--          WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
--          THEN '"'
--            ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
--            ||'_ARR'
--            ||'",'
--          ELSE NULL
--        END FLD_NAME_ARR_DESC,
--        'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''
--        ||TRIM(B.CTC_MID)
--        ||''',NVL(A.AMOUNT,0),0)),2) AS "'
--        ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
--        ||'",' FLD_NAME,
--        '"'
--        ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
--        ||'",' FLD_NAME_DESC,
--        B.DISP_ORDER,
--        B.CTC_TYPE,
--        C.PARA_DESC,
--        NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
--        B.CTC_MID,B.SORT_ORDER
--      FROM
--        PY_VW_PT_SAL_DT A,
--        PY_CTC_ALLOWANCE_MAST B,
--        PY_GM_PARAMETERS C
--      WHERE
--        A.COMP_AID      = B.COMP_ID
--      AND A.ALLWDED_AID =B.CTC_CODE
--      AND B.CTC_CATE_ID = C.PAR_AID
--      AND A.ARR_FLAG   <>'F'
--      AND A.AMOUNT     <>0
--      AND A.COMP_AID    = pComp_Aid
--      AND A.ACC_YEAR    = pAcc_Year
--      AND
--        (
--          TO_DATE(01
--          ||A.PROCESS_MONTH)>=pFrom_Date
--        AND LAST_DAY(TO_DATE(01
--          ||A.PROCESS_MONTH))<=pTo_Date
--        )
--      GROUP BY
--        B.CTC_TYPE,
--        C.PARA_DESC,
--        B.DISP_ORDER,
--        B.CTC_NAME,
--        B.REG_DISP_NAME,
--        B.CTC_MID,B.SORT_ORDER
--      ORDER BY
--        B.CTC_TYPE,
--        B.DISP_ORDER,B.SORT_ORDER
--    )
--  LOOP
--    IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
--      IF TRIM(I.CTC_TYPE)                               = 'A' THEN
--        IF TRIM(I.CTC_MID)                              ='OVT' THEN
--          strAllowanceMonthly                          := strAllowanceMonthly
--          ||
--          'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",'
--          ;
--          strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
--          I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
--          ,' AS ')              +4);
--          strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
--          IF I.FLD_NAME_ARR IS NOT NULL THEN
--            vCount          :=vCount+1;
--            strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
--          END IF;
--        ELSE
--          strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||
--          I.FLD_NAME_ARR;
--          strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
--          I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
--          ,' AS ')              +4);
--          strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
--          IF I.FLD_NAME_ARR IS NOT NULL THEN
--            vCount          :=vCount+1;
--            strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
--          END IF;
--          --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
--        END IF;
--      ELSIF TRIM(I.CTC_TYPE) = 'D' THEN
--        strDeduction        := strDeduction||I.FLD_NAME;
--        strDeductionHead    := strDeductionHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
--        I.FLD_NAME_EAR,' AS ')+4);
--        strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
--        --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
--      END IF;
--      vCount :=vCount+1;
--    END IF;
--  END LOOP;
--  strSqlQueryFormat :=
--  'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,null, null,null,null,null,null,null,null,null,null,null,null'
--  ||strNullHead||
--  ',null,null,null,
--''RH'' REPORT_HEADER1,'''
--  ||strGetCompName||
--  ''', null,null ,null, null,null,null ,null,null,null,null,null, null,null,null,null,null,null'
--  ||strNullHead||
--  ',null,null,null FROM DUAL
--UNION ALL
--SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,null'
--  ||strNullHead||
--  ',null,null,null,
--''RH'' REPORT_HEADER,'''
--  ||strGetRptName||
--  ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null'
--  ||strNullHead||
--  ',null,null,null FROM DUAL
--UNION ALL
--SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null'
--  ||strNullHead||
--  ',null,null,null,
--''DH'' REPORT_HEADER1, ''PAY MONTH'',''CODE'', ''EMPLOYEE NAME'' ,''JOINING DATE'', ''QUIT DATE'',''PRESENT DAYS'',
--''ARREAR DAYS'' ,''COST CENTER'',''MGMT/NONMGMT'',''SUB DEPARTMENT'',''SUB LEVEL'',''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
--''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'','
--  ||REPLACE(strAllwanceHead,'"','''')||'''GROSS EARNING'','||REPLACE(
--  strDeductionHead,'"','''')||
--  '''DEDUCTION'',''NET SALARY'' FROM DUAL UNION ALL ';
--  --  Total Gross ,Deduction and Net Salary
--  strSelectClause:=strSelectClause||strAllowanceMonthly||
--  ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
--  strSelectClause:=strSelectClause||strDeduction||
--  ' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
--  strSelectClause:=strSelectClause||
--  ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
--  --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';
--  strSelectClause :=strSelectClause||
--  ' null "REPORT_HEADER1", null "PAY MONTH1",null "CODE1",null "EMPLOYEE NAME1" ,null "JOINING DATE1", null "QUIT DATE1",null "PRESENT DAYS1",
--null "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB LEVEL1",null "DEPARTMENT1", null "DESIGNATION1",null "GRADE1",null "LOCATION1",
--null "SAVING ACCOUNT1",null "BANK NAME1",null "PAN NUMBER1"'
--  ||strNullHead||
--  ',NULL "GROSS EARNING1",NULL "DEDUCTION1",NULL "NET SALARY1 " ';
--  --strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause
--  -- ))-1);
--  strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
--  strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);--||','||
--  -- GET_GROUP_BY_COLS(pMasterType,'N');
--  strFromClause:=
--  ' FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
--(--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''
--  ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
--  '''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||pPay_Month||
--  ''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
--SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
--WHERE COMP_AID='''
--  ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
--  ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
--  ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
--  ''' AND PAY_MONTH<>ARR_MONTH
--GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N '
--  ;
--  strWhereClause:=
--  ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PROCESS_MONTH=B.PROCESS_MONTH AND B.PAY_MONTH IS NOT NULL
--AND A.COMP_AID = E.COMP_AID (+) AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PROCESS_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
--AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PROCESS_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
--AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID'
--  ;
--  IF TRIM(pIsMultipleSheet) ='Y' THEN
--    strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
--    pMasterType , pMultiSheetCondition),'HD.','B.');
--  END IF;
--  strWhereClause:=strWhereClause||
--  ' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||
--  pFrom_Date||'''))';
--  --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
--  -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
--  -- A.PAY_MONTH='||''''||pPay_Month||'''';
--  strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''||
--  ' AND B.ACC_YEAR = '||''''||pAcc_Year||''''||'';
--  strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
--  pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
--  '''';
--  strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';
--  IF pIsBatchWiseReport='Y' THEN
--    strWhereClause    :=strWhereClause||chr(13)||
--    ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
--    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
--  END IF;
--  /*to generate the report for the Employees as per the Filter ID*/
--  IF pFilterId IS NOT NULL THEN
--    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
--    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
--    pFilterId);
--    --                   strWhereClause:=strWhereClause||chr(13)||' AND
--    -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
--    -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
--    -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
--    -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
--    strWhereClause:=strWhereClause||chr(13)||
--    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
--    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
--    pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
--  END IF;
--  strSqlQuery:=strSqlQueryFormat||strSqlQuery||CHR(13)||strExSelectClause||
--  strSelectClause||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||CHR(13
--  )||strGroupByClause||CHR(13)||strOrderByClause;
--
--  COMMIT;
--  --Finally Return the recordset here
--  OPEN Return_Recordset FOR strSqlQuery ;
--  /*Craete Log */
--  INSERT_REPORT_UPLOAD_LOG
--  (
--    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
--    pSessionId ,pReportType , pReportID,'SUCCESS'
--  )
--  ;
--EXCEPTION
--WHEN OTHERS THEN
--  /*Craete Log*/
--  INSERT_REPORT_UPLOAD_LOG
--  (
--    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
--    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
--  )
--  ;
--END ;



--   PROCEDURE SALARY_REGISTER_RPT(
--              pComp_Aid            VARCHAR2,
--              pAcc_Year            VARCHAR2,
--              pPay_Month           VARCHAR2,
--              pFrom_Date           DATE,
--              pTo_Date             DATE,
--              pUser_Aid            VARCHAR2,
--              pSessionId           VARCHAR2,
--              pReportType          VARCHAR2,
--              pReportID            VARCHAR2,
--              pIsBatchWiseReport   VARCHAR2,
--              pFilterId            VARCHAR2,
--              pIsMultipleSheet     VARCHAR2,
--              pMasterType          VARCHAR2,
--              pMultiSheetCondition VARCHAR2,
--              Return_Recordset OUT REC)
--          IS
--          TYPE Cur_Recordset
--          IS
--            REF
--            CURSOR;
--              Cur_Temp Cur_Recordset;
--              strSqlQuery LONG;
--              strSqlQueryOuter LONG;
--              strArrearSqlQuery LONG;
--              strSubGrandTotalClause LONG;
--              strGrandTotalClause LONG;
--              strSelectClause LONG;
--              strFromClause LONG;
--              strWhereClause LONG;
--              strGroupByClause LONG;
--              strOrderByClause LONG;
--              strWhereNullCond LONG;
--              strAllowanceMonthly LONG;
--              strOtherAllowance LONG;
--              strDeduction LONG;
--              strExSelectClause LONG;
--              strExGroupByClause LONG;
--              strSqlQueryFormat LONG;
--              strGetCompName LONG;
--              strGetRptName LONG;
--              strNullHead LONG;
--              vCount NUMBER(10) DEFAULT 1;
--              strDedNullHead LONG;
--              strAllwNullHead LONG;
--              strAllwanceHead LONG;
--              strDeductionHead LONG;
--              -- strNullHead         LONG;
--            BEGIN
--              PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
--              pTo_Date,strGetCompName,strGetRptName);
--              vCount :=1;
--              --MASTER COLUMNNS
--              strSqlQuery          :='SELECT * FROM (SELECT ';
--              IF pIsBatchWiseReport = 'Y' THEN
--                strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
--                strExGroupByClause :='A.BATCH_ID, ';
--              END IF;
--              strSelectClause :=
--              '''AC'' "REPORT_HEADER",A.PROCESS_MONTH "PAY MONTH", B.EMP_MID AS "CODE",B.EMP_NAME AS "EMPLOYEE NAME",TO_CHAR(D.BIRTH_DATE,''DD-MON-YYYY'') AS "DATE OF BIRTH",D.SEX AS "GENDER",D.EMP_FATHERNAME AS "EMPLOYEE FATHER NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
--          N.ARREAR_DAYS AS "ARREAR DAYS" ,B.CC_DESC "COST CENTER",B.EMP_MGMT_CATE_MID "MGMT/NONMGMT",B.SUB_DEPT_DESC "SUB DEPARTMENT",O.SUB_DEPT_SDESC "SUB CODE", B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
--          B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",D.PPF_NUMBER AS "PF NUMBER",D.UAN_NO AS "UAN NUMBER",B.PAN_NUMBER AS "PAN NUMBER",D.AADHAR_NO AS "AADHAR NUMBER",'
--              ;
--              strGroupByClause:=
--              'A.PROCESS_MONTH,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,
--          B.BANK_ACCOUNT_NO,B.BANK_DESC,D.PPF_NUMBER,D.UAN_NO,B.PAN_NUMBER,D.AADHAR_NO,N.ARREAR_DAYS,B.CC_DESC,B.EMP_MGMT_CATE_MID,B.SUB_DEPT_DESC,O.SUB_DEPT_SDESC , D.BIRTH_DATE,D.SEX ,D.EMP_FATHERNAME ,'
--              ;
--              strOrderByClause:= ' ORDER BY B.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)'||') '
--              ;--||GET_GROUP_BY_COLS(pMasterType,'N')|
--              FOR I IN
--              (
--                SELECT DISTINCT
--                  'ROUND(SUM(CASE WHEN A.ARR_FLAG !=''A'' THEN DECODE(TRIM(F.CTC_MID),'''
--                  ||TRIM(B.CTC_MID)
--                  ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
--                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
--                  ||'",' FLD_NAME_EAR,
--                  '"'
--                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
--                  ||'",' FLD_NAME_EAR_DESC,
--                  CASE
--                    WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
--                    THEN
--                      'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''
--                      ||TRIM(B.CTC_MID)
--                      ||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'
--                      ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
--                      ||'_ARR'
--                      ||'",'
--                    ELSE NULL
--                  END FLD_NAME_ARR,
--                  CASE
--                    WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
--                    THEN '"'
--                      ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
--                      ||'_ARR'
--                      ||'",'
--                    ELSE NULL
--                  END FLD_NAME_ARR_DESC,
--                  'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''
--                  ||TRIM(B.CTC_MID)
--                  ||''',NVL(A.AMOUNT,0),0)),2) AS "'
--                  ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
--                  ||'",' FLD_NAME,
--                  '"'
--                  ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
--                  ||'",' FLD_NAME_DESC,
--                  B.DISP_ORDER,
--                  B.CTC_TYPE,
--                  C.PARA_DESC,
--                  NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
--                  B.CTC_MID
--                FROM
--                  PY_VW_PT_SAL_DT A,
--                  PY_CTC_ALLOWANCE_MAST B,
--                  PY_GM_PARAMETERS C
--                WHERE
--                  A.COMP_AID      = B.COMP_ID
--                AND A.ALLWDED_AID =B.CTC_CODE
--                AND B.CTC_CATE_ID = C.PAR_AID
--                AND A.ARR_FLAG   <>'F'
--                AND A.AMOUNT     <>0
--                AND A.COMP_AID    = pComp_Aid
--                AND A.ACC_YEAR    = pAcc_Year
--                AND
--                  (
--                    TO_DATE(01
--                    ||A.PROCESS_MONTH)>=pFrom_Date
--                  AND LAST_DAY(TO_DATE(01
--                    ||A.PROCESS_MONTH))<=pTo_Date
--                  )
--                GROUP BY
--                  B.CTC_TYPE,
--                  C.PARA_DESC,
--                  B.DISP_ORDER,
--                  B.CTC_NAME,
--                  B.REG_DISP_NAME,
--                  B.CTC_MID
--                ORDER BY
--                  B.CTC_TYPE,
--                  B.DISP_ORDER
--              )
--            LOOP
--              IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
--                IF TRIM(I.CTC_TYPE)                               = 'A' THEN
--                  IF TRIM(I.CTC_MID)                              ='OVT' THEN
--                    strAllowanceMonthly                          := strAllowanceMonthly
--                    ||
--                    'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",'
--                    ;
--                    strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
--                    I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
--                    ,' AS ')              +4);
--                    strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
--                    IF I.FLD_NAME_ARR IS NOT NULL THEN
--                      vCount          :=vCount+1;
--                      strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
--                    END IF;
--                  ELSE
--                    strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||
--                    I.FLD_NAME_ARR;
--                    strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
--                    I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
--                    ,' AS ')              +4);
--                    strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
--                    IF I.FLD_NAME_ARR IS NOT NULL THEN
--                      vCount          :=vCount+1;
--                      strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
--                    END IF;
--                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
--                  END IF;
--                ELSIF TRIM(I.CTC_TYPE) = 'D' THEN
--                  strDeduction        := strDeduction||I.FLD_NAME;
--                  strDeductionHead    := strDeductionHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
--                  I.FLD_NAME_EAR,' AS ')+4);
--                  strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
--                  --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
--                END IF;
--                vCount :=vCount+1;
--              END IF;
--            END LOOP;
--            strSqlQueryFormat :=
--            'SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null,null,null,null,null ,null,null, null,null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
--            ||strNullHead||
--            ',null,null,null,
--          ''RH'' REPORT_HEADER1,'''
--            ||strGetCompName||
--            ''', null,null,null,null,null ,null, null,null,null ,null,null,null,null,null, null,null,null,null,null,null,NULL,NULL,NULL'
--            ||strNullHead||
--            ',null,null,null FROM DUAL
--          UNION ALL
--          SELECT ''X#X#X'' REPORT_HEADER,null,null,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
--            ||strNullHead||
--            ',null,null,null,
--          ''RH'' REPORT_HEADER,'''
--            ||strGetRptName||
--            ''', null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
--            ||strNullHead||
--            ',null,null,null FROM DUAL
--          UNION ALL
--          SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
--            ||strNullHead||
--            ',null,null,null,
--          ''DH'' REPORT_HEADER1, ''PAY MONTH'',''CODE'', ''EMPLOYEE NAME'',''DATE OF BIRTH'',''GENDER'',''EMPLOYEE FATHER NAME'' ,''JOINING DATE'', ''QUIT DATE'',''PRESENT DAYS'',
--          ''ARREAR DAYS'' ,''COST CENTER'',''MGMT/NONMGMT'',''SUB DEPARTMENT'',''SUB CODE'',''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
--          ''SAVING ACCOUNT'',''BANK NAME'',''PF NUMBER'',''UAN NUMBER'',''PAN NUMBER'',''AADHAR NUMBER'','
--            ||REPLACE(strAllwanceHead,'"','''')||'''GROSS EARNING'','||REPLACE(
--            strDeductionHead,'"','''')||
--            '''DEDUCTION'',''NET SALARY'' FROM DUAL UNION ALL ';
--            --  Total Gross ,Deduction and Net Salary
--            strSelectClause:=strSelectClause||strAllowanceMonthly||
--            ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
--            strSelectClause:=strSelectClause||strDeduction||
--            ' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
--            strSelectClause:=strSelectClause||
--            ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
--            --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';
--            strSelectClause :=strSelectClause||
--            ' null "REPORT_HEADER1", null "PAY MONTH1",null "CODE1",null "EMPLOYEE NAME1" ,NULL "DATE OF BIRTH1",NULL "GENDER1",NULL "EMPLOYEE FATHER NAME1", null "JOINING DATE1", null "QUIT DATE1",null "PRESENT DAYS1",
--          null "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB CODE1",null "DEPARTMENT1", null "DESIGNATION1",null "GRADE1",null "LOCATION1",
--          null "SAVING ACCOUNT1",null "BANK NAME1",NULL "PF NUMBER1",NULL "UAN NUMBE1",null "PAN NUMBER1",NULL "AADHAR NUMBER1"'
--            ||strNullHead||
--            ',NULL "GROSS EARNING1",NULL "DEDUCTION1",NULL "NET SALARY1 " ';
--            --strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause
--            -- ))-1);
--            strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
--            strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);--||','||
--            -- GET_GROUP_BY_COLS(pMasterType,'N');
--            strFromClause:=
--            ' FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_GM_EMPMAST D,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
--          (--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''
--            ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
--            '''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||pPay_Month||
--            ''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
--          SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
--          WHERE COMP_AID='''
--            ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
--            ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
--            ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
--            ''' AND PAY_MONTH<>ARR_MONTH
--          GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N,
--          (SELECT  A.COMP_AID ,A.EMP_AID,A.ACC_YEAR,A.PAY_MONTH, SUB_DEPT_SDESC
--           FROM PY_PT_SAL_HD A ,GM_SUB_DEPT B
--             WHERE A.COMP_AID=B.COMP_AID AND A.SUB_DEPT_AID=B.SUB_DEPT_AID
--             AND A.COMP_AID='''||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||'''
--             AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||''') O ';
--            strWhereClause:=
--            ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PROCESS_MONTH=B.PROCESS_MONTH AND B.PAY_MONTH IS NOT NULL
--           AND A.COMP_AID=D.COMP_AID AND A.EMP_AID=D.EMP_AID AND A.COMP_AID = E.COMP_AID (+)
--           AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PROCESS_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
--           AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PROCESS_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
--           AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID AND A.COMP_AID = O.COMP_AID(+)
--           AND A.EMP_AID=O.EMP_AID(+)'
--            ;
--            IF TRIM(pIsMultipleSheet) ='Y' THEN
--              strWhereClause         :=strWhereClause||' AND '||REPLACE(PY_PK_STANDARD_REPORT_COMMON.GET_CONDITION(
--              pMasterType , pMultiSheetCondition),'HD.','B.');
--            END IF;
--            strWhereClause:=strWhereClause||
--            ' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||
--            pFrom_Date||'''))';
--            --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
--            -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
--            -- A.PAY_MONTH='||''''||pPay_Month||'''';
--            strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''||
--            ' AND B.ACC_YEAR = '||''''||pAcc_Year||''''||'';
--            strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
--            pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
--            '''';
--            strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';
--            IF pIsBatchWiseReport='Y' THEN
--              strWhereClause    :=strWhereClause||chr(13)||
--              ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
--              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
--            END IF;
--            /*to generate the report for the Employees as per the Filter ID*/
--            IF pFilterId IS NOT NULL THEN
--              PY_PK_STANDARD_REPORT_COMMON.INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
--              pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
--              pFilterId);
--              --                   strWhereClause:=strWhereClause||chr(13)||' AND
--              -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
--              -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
--              -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
--              -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
--              strWhereClause:=strWhereClause||chr(13)||
--              ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
--              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
--              pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
--            END IF;
--            strSqlQuery:=strSqlQueryFormat||strSqlQuery||CHR(13)||strExSelectClause||
--            strSelectClause||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||CHR(13
--            )||strGroupByClause||CHR(13)||strOrderByClause;
--           DBMS_OUTPUT.PUT_LINE(strSqlQuery);
--            DELETE FROM VAI;
--            INSERT INTO VAI VALUES(strSqlQuery);
--            COMMIT;
--            --Finally Return the recordset here
--            OPEN Return_Recordset FOR strSqlQuery ;
--            /*Craete Log */
--            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
--            (
--              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
--              pSessionId ,pReportType , pReportID,'SUCCESS'
--            )
--            ;
--          EXCEPTION
--          WHEN OTHERS THEN
--            /*Craete Log*/
--            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
--            (
--              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
--              pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
--            )
--            ;
--      END ;
--COMMENTED ON 27-DEC-18

   PROCEDURE SALARY_REGISTER_RPT(
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
          IS
          TYPE Cur_Recordset
          IS
            REF
            CURSOR;
              Cur_Temp Cur_Recordset;
              strSqlQuery LONG;
              strSqlQueryOuter LONG;
              strArrearSqlQuery LONG;
              strSubGrandTotalClause LONG;
              strGrandTotalClause LONG;
              strSelectClause LONG;
              strFromClause LONG;
              strWhereClause LONG;
              strGroupByClause LONG;
              strOrderByClause LONG;
              strWhereNullCond LONG;
              strAllowanceMonthly LONG;
              strOtherAllowance LONG;
              strDeduction LONG;
              strExSelectClause LONG;
              strExGroupByClause LONG;
              strSqlQueryFormat LONG;
              strGetCompName LONG;
              strGetRptName LONG;
              strNullHead LONG;
              vCount NUMBER(10) DEFAULT 1;
              strDedNullHead LONG;
              strAllwNullHead LONG;
              strAllwanceHead LONG;
              strDeductionHead LONG;

              strNULL_VAL    long;
              strCTC_COLUMNS  LONG;
              strDesc           long;
              strHEADER_COL    LONG;
              strNULL          LONG;
              strONNUL          LONG;
              strPIVT           LONG;
              -- strNullHead         LONG;
            BEGIN
              PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
              pTo_Date,strGetCompName,strGetRptName);

              vCount :=1;
              --MASTER COLUMNNS
              strSqlQuery          :='SELECT * FROM (SELECT ';
              IF pIsBatchWiseReport = 'Y' THEN
                strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
                strExGroupByClause :='A.BATCH_ID, ';
              END IF;


                            OPEN Cur_Temp FOR
                                     SELECT
                                    ','||LISTAGG(CTC_COLUMNS , ', ' ) within group ( order by  ROWNUM ),
                                    ','||LISTAGG (SUB_DES , ', ' ) within group ( order by  ROWNUM ),
                                    ','||LISTAGG(NULL_VAL , ', ') within group ( order by  ROWNUM ),
                                    ','||LISTAGG(HEADER_COL , ', ') within group ( order by  ROWNUM ),
                                    LISTAGG(PIVT , ', ') within group ( order by  ROWNUM ),
                                    ','||LISTAGG('NULL ' ||'"'||ROW_NUM||'"' , ', ' ) within group ( order by  ROWNUM )
                                    ,','|| LISTAGG('NULL ' , ', ' ) within group ( order by  ROWNUM )
                                    FROM
                                    (
                                      SELECT SUB_DES,CTC_COLUMNS,
                                              NULL_VAL,HEADER_COL,ROWNUM ROW_NUM ,PIVT
                                      FROM
                                      (

                                         SELECT  A.ATTB_MID
                                         , 'NULL ' || '"'||SUBSTR(REPLACE (A.ATTB_DESC, ' ', '_' ),1,30)||'1'||'"'  SUB_DES
                                         , ''''||A.ATTB_MID ||''''||' '|| '"'||SUBSTR(REPLACE (A.ATTB_DESC, ' ', '_' ),1,30)||'"'  PIVT
                                         , SUBSTR(REPLACE (A.ATTB_DESC, ' ', '_' ),1,30) CTC_COLUMNS
                                         ,NULL|| ' "'||REPLACE(SUBSTR(REPLACE (A.ATTB_DESC, ' ', '_' ),1,30),'''','')||'"' NULL_VAL
                                         ,'''' ||REPLACE(SUBSTR(REPLACE (A.ATTB_DESC, ' ', '_' ),1,30),'''','')||'''' HEADER_COL
                                      FROM PY_GM_EMP_ATTRIBUTE_MAST A
                                      WHERE A.COMP_AID = pComp_Aid
                                      GROUP BY  A.ATTB_MID ,A.ATTB_DESC
                                      ORDER BY  A.ATTB_MID

                                        )
                                        ORDER BY ROW_NUM
                                    );

                                    FETCH Cur_Temp INTO strCTC_COLUMNS ,strDesc ,strNULL_VAL,strHEADER_COL,strPIVT,strNULL, strONNUL;
                                    CLOSE Cur_Temp;
      IF TRIM(strCTC_COLUMNS) = ','  then
        strCTC_COLUMNS:= NULL;
        strDesc  := NULL ;
        strNULL_VAL := NULL ;
        strHEADER_COL := NULL ;
        strPIVT := NULL ;
        strNULL := NULL ;
        strONNUL := NULL ;
      END IF;

              IF pComp_Aid='CM000006' THEN
              strSelectClause :=
              '''AC'' "REPORT_HEADER",A.PROCESS_MONTH "PAY MONTH", B.EMP_MID AS "CODE",B.EMP_NAME AS "EMPLOYEE NAME",TO_CHAR(D.BIRTH_DATE,''DD-MON-YYYY'') AS "DATE OF BIRTH",D.SEX AS "GENDER",D.EMP_FATHERNAME AS "EMPLOYEE FATHER NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
          N.ARREAR_DAYS AS "ARREAR DAYS" ,B.CC_DESC "COST CENTER",B.EMP_MGMT_CATE_MID "MGMT/NONMGMT",B.SUB_DEPT_DESC "SUB DEPARTMENT",O.SUB_DEPT_SDESC "SUB CODE", B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
          B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",D.PPF_NUMBER AS "PF NUMBER",D.UAN_NO AS "UAN NUMBER",B.PAN_NUMBER AS "PAN NUMBER",D.AADHAR_NO AS "AADHAR NUMBER" '|| strCTC_COLUMNS ||','
              ;
              strGroupByClause:=
              'A.PROCESS_MONTH,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,
          B.BANK_ACCOUNT_NO,B.BANK_DESC,D.PPF_NUMBER,D.UAN_NO,B.PAN_NUMBER,D.AADHAR_NO,N.ARREAR_DAYS,B.CC_DESC,B.EMP_MGMT_CATE_MID,B.SUB_DEPT_DESC,O.SUB_DEPT_SDESC , D.BIRTH_DATE,D.SEX ,D.EMP_FATHERNAME '|| strCTC_COLUMNS ||' ,'
              ;
              strOrderByClause:= ' ORDER BY B.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)'||') '
              ;--||GET_GROUP_BY_COLS(pMasterType,'N')|
              FOR I IN
              (
                SELECT DISTINCT
                  'ROUND(SUM(CASE WHEN A.ARR_FLAG !=''A'' THEN DECODE(TRIM(F.CTC_MID),'''
                  ||TRIM(B.CTC_MID)
                  ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
                  ||'",' FLD_NAME_EAR,
                  '"'
                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
                  ||'",' FLD_NAME_EAR_DESC,
                  CASE
                    WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
                    THEN
                      'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''
                      ||TRIM(B.CTC_MID)
                      ||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'
                      ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
                      ||'_ARR'
                      ||'",'
                    ELSE NULL
                  END FLD_NAME_ARR,
                  CASE
                    WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
                    THEN '"'
                      ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
                      ||'_ARR'
                      ||'",'
                    ELSE NULL
                  END FLD_NAME_ARR_DESC,
                  'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''
                  ||TRIM(B.CTC_MID)
                  ||''',NVL(A.AMOUNT,0),0)),2) AS "'
                  ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
                  ||'",' FLD_NAME,
                  '"'
                  ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
                  ||'",' FLD_NAME_DESC,
                  B.DISP_ORDER,
                  B.CTC_TYPE,
                  C.PARA_DESC,
                  NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
                  B.CTC_MID
                FROM
                  PY_VW_PT_SAL_DT A,
                  PY_CTC_ALLOWANCE_MAST B,
                  PY_GM_PARAMETERS C
                WHERE
                  A.COMP_AID      = B.COMP_ID
                AND A.ALLWDED_AID =B.CTC_CODE
                AND B.CTC_CATE_ID = C.PAR_AID
                AND A.ARR_FLAG   <>'F'
                AND A.AMOUNT     <>0
                AND A.COMP_AID    = pComp_Aid
                AND A.ACC_YEAR    = pAcc_Year
                AND
                  (
                    TO_DATE(01
                    ||A.PROCESS_MONTH)>=pFrom_Date
                  AND LAST_DAY(TO_DATE(01
                    ||A.PROCESS_MONTH))<=pTo_Date
                  )
                GROUP BY
                  B.CTC_TYPE,
                  C.PARA_DESC,
                  B.DISP_ORDER,
                  B.CTC_NAME,
                  B.REG_DISP_NAME,
                  B.CTC_MID
                ORDER BY
                  B.CTC_TYPE,
                  B.DISP_ORDER
              )
            LOOP
              IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
                IF TRIM(I.CTC_TYPE)                               = 'A' THEN
                  IF TRIM(I.CTC_MID)                              ='OVT' THEN
                    strAllowanceMonthly                          := strAllowanceMonthly
                    ||
                    'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",'
                    ;
                    strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
                    I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
                    ,' AS ')              +4);
                    strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
                    IF I.FLD_NAME_ARR IS NOT NULL THEN
                      vCount          :=vCount+1;
                      strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
                    END IF;
                  ELSE
                    strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||
                    I.FLD_NAME_ARR;
                    strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
                    I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
                    ,' AS ')              +4);
                    strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
                    IF I.FLD_NAME_ARR IS NOT NULL THEN
                      vCount          :=vCount+1;
                      strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
                    END IF;
                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
                  END IF;
                ELSIF TRIM(I.CTC_TYPE) = 'D' THEN
                  strDeduction        := strDeduction||I.FLD_NAME;
                  strDeductionHead    := strDeductionHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
                  I.FLD_NAME_EAR,' AS ')+4);
                  strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
                  --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
                END IF;
                vCount :=vCount+1;
              END IF;
            END LOOP;
            strSqlQueryFormat :=
            'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null,null,null,null,null ,null,null, null,null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL '||strONNUL||''
            ||strNullHead||
            ',null,null,null,
          ''RH'' REPORT_HEADER1,'''
            ||strGetCompName||
            ''', null,null,null,null,null ,null, null,null,null ,null,null,null,null,null, null,null,null,null,null,null,NULL,NULL,NULL '||strONNUL||''
            ||strNullHead||
            ',null,null,null FROM DUAL
          UNION ALL
          SELECT ''X#X#X'' REPORT_HEADER,null,null,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL '||strONNUL||''
            ||strNullHead||
            ',null,null,null,
          ''RH'' REPORT_HEADER,'''
            ||strGetRptName||
            ''', null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL '||strONNUL||''
            ||strNullHead||
            ',null,null,null FROM DUAL
          UNION ALL
          SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL '||strONNUL||''
            ||strNullHead||
            ',null,null,null,
          ''DH'' REPORT_HEADER1, ''PAY MONTH'',''CODE'', ''EMPLOYEE NAME'',''DATE OF BIRTH'',''GENDER'',''EMPLOYEE FATHER NAME'' ,''JOINING DATE'', ''QUIT DATE'',''PRESENT DAYS'',
          ''ARREAR DAYS'' ,''COST CENTER'',''MGMT/NONMGMT'',''SUB DEPARTMENT'',''SUB CODE'',''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
          ''SAVING ACCOUNT'',''BANK NAME'',''PF NUMBER'',''UAN NUMBER'',''PAN NUMBER'',''AADHAR NUMBER'' '||strHEADER_COL||','
            ||REPLACE(strAllwanceHead,'"','''')||'''GROSS EARNING'','||REPLACE(
            strDeductionHead,'"','''')||
            '''DEDUCTION'',''NET SALARY'' FROM DUAL UNION ALL ';
            --  Total Gross ,Deduction and Net Salary
            strSelectClause:=strSelectClause||strAllowanceMonthly||
            ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
            strSelectClause:=strSelectClause||strDeduction||
            ' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
            strSelectClause:=strSelectClause||
            ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
            --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';
            strSelectClause :=strSelectClause||
            ' null "REPORT_HEADER1", null "PAY MONTH1",null "CODE1",null "EMPLOYEE NAME1" ,NULL "DATE OF BIRTH1",NULL "GENDER1",NULL "EMPLOYEE FATHER NAME1", null "JOINING DATE1", null "QUIT DATE1",null "PRESENT DAYS1",
          null "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB CODE1",null "DEPARTMENT1", null "DESIGNATION1",null "GRADE1",null "LOCATION1",
          null "SAVING ACCOUNT1",null "BANK NAME1",NULL "PF NUMBER1",NULL "UAN NUMBE1",null "PAN NUMBER1",NULL "AADHAR NUMBER1" '||strDesc||''
            ||strNullHead||
            ',NULL "GROSS EARNING1",NULL "DEDUCTION1",NULL "NET SALARY1 " ';
            --strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause
            -- ))-1);
            strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
            strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);--||','||
            -- GET_GROUP_BY_COLS(pMasterType,'N');
            strFromClause:=
            ' FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_GM_EMPMAST D,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
          (--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''
            ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
            '''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||pPay_Month||
            ''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
          SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
          WHERE COMP_AID='''
            ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
            ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
            ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
            ''' AND PAY_MONTH<>ARR_MONTH
          GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N,
          (SELECT  A.COMP_AID ,A.EMP_AID,A.ACC_YEAR,A.PAY_MONTH, SUB_DEPT_SDESC
           FROM PY_PT_SAL_HD A ,GM_SUB_DEPT B
             WHERE A.COMP_AID=B.COMP_AID AND A.SUB_DEPT_AID=B.SUB_DEPT_AID
             AND A.COMP_AID='''||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||'''
             AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||''') O,
             (select "COMP_AID","EMP_AID" '||strNULL_VAL ||' from
            (SELECT COMP_AID  ,EMP_AID ,ATTB_MID,SUB_ATTB_DESC
            FROM PY_GM_EMP_ATTRIBUTE_MAST  )
            PIVOT
            (
            max(SUB_ATTB_DESC) FOR (ATTB_MID) IN ('|| strPIVT ||')
            )) J ';
            strWhereClause:=
            ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PROCESS_MONTH=B.PROCESS_MONTH AND B.PAY_MONTH IS NOT NULL
           AND A.COMP_AID=D.COMP_AID AND A.EMP_AID=D.EMP_AID AND A.COMP_AID = E.COMP_AID (+)
           AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PROCESS_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
           AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PROCESS_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
           AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID AND A.COMP_AID = O.COMP_AID(+)
           AND A.EMP_AID=O.EMP_AID(+) AND B.COMP_AID=J.COMP_AID(+) AND B.EMP_AID=J.EMP_AID(+)'
            ;
            IF TRIM(pIsMultipleSheet) ='Y' THEN
              strWhereClause         :=strWhereClause||' AND '||REPLACE(PY_PK_STANDARD_REPORT_COMMON.GET_CONDITION(
              pMasterType , pMultiSheetCondition),'HD.','B.');
            END IF;
            strWhereClause:=strWhereClause||
            ' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||
            pFrom_Date||'''))';
            --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
            -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
            -- A.PAY_MONTH='||''''||pPay_Month||'''';
            strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''||
            ' AND B.ACC_YEAR = '||''''||pAcc_Year||''''||'';
            strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
            pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
            '''';
            strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';
            IF pIsBatchWiseReport='Y' THEN
              strWhereClause    :=strWhereClause||chr(13)||
              ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
            END IF;
            /*to generate the report for the Employees as per the Filter ID*/
            IF pFilterId IS NOT NULL THEN
              PY_PK_STANDARD_REPORT_COMMON.INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
              pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
              pFilterId);
              --                   strWhereClause:=strWhereClause||chr(13)||' AND
              -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
              -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
              -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
              -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
              strWhereClause:=strWhereClause||chr(13)||
              ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
              pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
            END IF;
--            strSqlQuery:=strSqlQueryFormat||strSqlQuery||CHR(13)||strExSelectClause||
--            strSelectClause||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||CHR(13
--            )||strGroupByClause||CHR(13)||strOrderByClause;

            ELSE


              strSelectClause :=
              '''AC'' "REPORT_HEADER",A.PROCESS_MONTH "PAY MONTH", B.EMP_MID AS "CODE",B.EMP_NAME AS "EMPLOYEE NAME",TO_CHAR(D.BIRTH_DATE,''DD-MON-YYYY'') AS "DATE OF BIRTH",D.SEX AS "GENDER",D.EMP_FATHERNAME AS "EMPLOYEE FATHER NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
          N.ARREAR_DAYS AS "ARREAR DAYS" ,B.CC_DESC "COST CENTER",B.EMP_MGMT_CATE_MID "MGMT/NONMGMT",B.SUB_DEPT_DESC "SUB DEPARTMENT",O.SUB_DEPT_SDESC "SUB CODE", B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
          B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",D.PPF_NUMBER AS "PF NUMBER",D.UAN_NO AS "UAN NUMBER",B.PAN_NUMBER AS "PAN NUMBER",D.AADHAR_NO AS "AADHAR NUMBER",'
              ;
              strGroupByClause:=
              'A.PROCESS_MONTH,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,
          B.BANK_ACCOUNT_NO,B.BANK_DESC,D.PPF_NUMBER,D.UAN_NO,B.PAN_NUMBER,D.AADHAR_NO,N.ARREAR_DAYS,B.CC_DESC,B.EMP_MGMT_CATE_MID,B.SUB_DEPT_DESC,O.SUB_DEPT_SDESC , D.BIRTH_DATE,D.SEX ,D.EMP_FATHERNAME ,'
              ;
              strOrderByClause:= ' ORDER BY B.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)'||') '
              ;--||GET_GROUP_BY_COLS(pMasterType,'N')|
              FOR I IN
              (
                SELECT DISTINCT
                  'ROUND(SUM(CASE WHEN A.ARR_FLAG !=''A'' THEN DECODE(TRIM(F.CTC_MID),'''
                  ||TRIM(B.CTC_MID)
                  ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
                  ||'",' FLD_NAME_EAR,
                  '"'
                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
                  ||'",' FLD_NAME_EAR_DESC,
                  CASE
                    WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
                    THEN
                      'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''
                      ||TRIM(B.CTC_MID)
                      ||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'
                      ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
                      ||'_ARR'
                      ||'",'
                    ELSE NULL
                  END FLD_NAME_ARR,
                  CASE
                    WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
                    THEN '"'
                      ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')
                      ||'_ARR'
                      ||'",'
                    ELSE NULL
                  END FLD_NAME_ARR_DESC,
                  'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''
                  ||TRIM(B.CTC_MID)
                  ||''',NVL(A.AMOUNT,0),0)),2) AS "'
                  ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
                  ||'",' FLD_NAME,
                  '"'
                  ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')
                  ||'",' FLD_NAME_DESC,
                  B.DISP_ORDER,
                  B.CTC_TYPE,
                  C.PARA_DESC,
                  NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
                  B.CTC_MID
                FROM
                  PY_VW_PT_SAL_DT A,
                  PY_CTC_ALLOWANCE_MAST B,
                  PY_GM_PARAMETERS C
                WHERE
                  A.COMP_AID      = B.COMP_ID
                AND A.ALLWDED_AID =B.CTC_CODE
                AND B.CTC_CATE_ID = C.PAR_AID
                AND A.ARR_FLAG   <>'F'
                AND A.AMOUNT     <>0
                AND A.COMP_AID    = pComp_Aid
                AND A.ACC_YEAR    = pAcc_Year
                AND
                  (
                    TO_DATE(01
                    ||A.PROCESS_MONTH)>=pFrom_Date
                  AND LAST_DAY(TO_DATE(01
                    ||A.PROCESS_MONTH))<=pTo_Date
                  )
                GROUP BY
                  B.CTC_TYPE,
                  C.PARA_DESC,
                  B.DISP_ORDER,
                  B.CTC_NAME,
                  B.REG_DISP_NAME,
                  B.CTC_MID
                ORDER BY
                  B.CTC_TYPE,
                  B.DISP_ORDER
              )
            LOOP
              IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
                IF TRIM(I.CTC_TYPE)                               = 'A' THEN
                  IF TRIM(I.CTC_MID)                              ='OVT' THEN
                    strAllowanceMonthly                          := strAllowanceMonthly
                    ||
                    'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",'
                    ;
                    strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
                    I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
                    ,' AS ')              +4);
                    strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
                    IF I.FLD_NAME_ARR IS NOT NULL THEN
                      vCount          :=vCount+1;
                      strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
                    END IF;
                  ELSE
                    strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||
                    I.FLD_NAME_ARR;
                    strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
                    I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
                    ,' AS ')              +4);
                    strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
                    IF I.FLD_NAME_ARR IS NOT NULL THEN
                      vCount          :=vCount+1;
                      strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
                    END IF;
                    --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
                  END IF;
                ELSIF TRIM(I.CTC_TYPE) = 'D' THEN
                  strDeduction        := strDeduction||I.FLD_NAME;
                  strDeductionHead    := strDeductionHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
                  I.FLD_NAME_EAR,' AS ')+4);
                  strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
                  --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
                END IF;
                vCount :=vCount+1;
              END IF;
            END LOOP;
            strSqlQueryFormat :=
            'SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null,null,null,null,null ,null,null, null,null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
            ||strNullHead||
            ',null,null,null,
          ''RH'' REPORT_HEADER1,'''
            ||strGetCompName||
            ''', null,null,null,null,null ,null, null,null,null ,null,null,null,null,null, null,null,null,null,null,null,NULL,NULL,NULL'
            ||strNullHead||
            ',null,null,null FROM DUAL
          UNION ALL
          SELECT ''X#X#X'' REPORT_HEADER,null,null,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
            ||strNullHead||
            ',null,null,null,
          ''RH'' REPORT_HEADER,'''
            ||strGetRptName||
            ''', null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
            ||strNullHead||
            ',null,null,null FROM DUAL
          UNION ALL
          SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,null,NULL,NULL,NULL'
            ||strNullHead||
            ',null,null,null,
          ''DH'' REPORT_HEADER1, ''PAY MONTH'',''CODE'', ''EMPLOYEE NAME'',''DATE OF BIRTH'',''GENDER'',''EMPLOYEE FATHER NAME'' ,''JOINING DATE'', ''QUIT DATE'',''PRESENT DAYS'',
          ''ARREAR DAYS'' ,''COST CENTER'',''MGMT/NONMGMT'',''SUB DEPARTMENT'',''SUB CODE'',''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
          ''SAVING ACCOUNT'',''BANK NAME'',''PF NUMBER'',''UAN NUMBER'',''PAN NUMBER'',''AADHAR NUMBER'','
            ||REPLACE(strAllwanceHead,'"','''')||'''GROSS EARNING'','||REPLACE(
            strDeductionHead,'"','''')||
            '''DEDUCTION'',''NET SALARY'' FROM DUAL UNION ALL ';
            --  Total Gross ,Deduction and Net Salary
            strSelectClause:=strSelectClause||strAllowanceMonthly||
            ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
            strSelectClause:=strSelectClause||strDeduction||
            ' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
            strSelectClause:=strSelectClause||
            ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
            --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';
            strSelectClause :=strSelectClause||
            ' null "REPORT_HEADER1", null "PAY MONTH1",null "CODE1",null "EMPLOYEE NAME1" ,NULL "DATE OF BIRTH1",NULL "GENDER1",NULL "EMPLOYEE FATHER NAME1", null "JOINING DATE1", null "QUIT DATE1",null "PRESENT DAYS1",
          null "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB CODE1",null "DEPARTMENT1", null "DESIGNATION1",null "GRADE1",null "LOCATION1",
          null "SAVING ACCOUNT1",null "BANK NAME1",NULL "PF NUMBER1",NULL "UAN NUMBE1",null "PAN NUMBER1",NULL "AADHAR NUMBER1"'
            ||strNullHead||
            ',NULL "GROSS EARNING1",NULL "DEDUCTION1",NULL "NET SALARY1 " ';
            --strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause
            -- ))-1);
            strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
            strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);--||','||
            -- GET_GROUP_BY_COLS(pMasterType,'N');
            strFromClause:=
            ' FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_GM_EMPMAST D,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
          (--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''
            ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
            '''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||pPay_Month||
            ''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
          SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
          WHERE COMP_AID='''
            ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
            ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
            ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
            ''' AND PAY_MONTH<>ARR_MONTH
          GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N,
          (SELECT  A.COMP_AID ,A.EMP_AID,A.ACC_YEAR,A.PAY_MONTH, SUB_DEPT_SDESC
           FROM PY_PT_SAL_HD A ,GM_SUB_DEPT B
             WHERE A.COMP_AID=B.COMP_AID AND A.SUB_DEPT_AID=B.SUB_DEPT_AID
             AND A.COMP_AID='''||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||'''
             AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||''') O ';
            strWhereClause:=
            ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PROCESS_MONTH=B.PROCESS_MONTH AND B.PAY_MONTH IS NOT NULL
           AND A.COMP_AID=D.COMP_AID AND A.EMP_AID=D.EMP_AID AND A.COMP_AID = E.COMP_AID (+)
           AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PROCESS_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
           AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PROCESS_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
           AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID AND A.COMP_AID = O.COMP_AID(+)
           AND A.EMP_AID=O.EMP_AID(+) AND A.PAY_MONTH=O.PAY_MONTH (+)'
            ;
            IF TRIM(pIsMultipleSheet) ='Y' THEN
              strWhereClause         :=strWhereClause||' AND '||REPLACE(PY_PK_STANDARD_REPORT_COMMON.GET_CONDITION(
              pMasterType , pMultiSheetCondition),'HD.','B.');
            END IF;
            strWhereClause:=strWhereClause||
            ' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||
            pFrom_Date||'''))';
            --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
            -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
            -- A.PAY_MONTH='||''''||pPay_Month||'''';
            strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''||
            ' AND B.ACC_YEAR = '||''''||pAcc_Year||''''||'';
            strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
            pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
            '''';
            strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';
            IF pIsBatchWiseReport='Y' THEN
              strWhereClause    :=strWhereClause||chr(13)||
              ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
            END IF;
            /*to generate the report for the Employees as per the Filter ID*/
            IF pFilterId IS NOT NULL THEN
              PY_PK_STANDARD_REPORT_COMMON.INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
              pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
              pFilterId);
              --                   strWhereClause:=strWhereClause||chr(13)||' AND
              -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
              -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
              -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
              -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
              strWhereClause:=strWhereClause||chr(13)||
              ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
              pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
            END IF;
            END IF;
            strSqlQuery:=strSqlQueryFormat||strSqlQuery||CHR(13)||strExSelectClause||
            strSelectClause||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||CHR(13
            )||strGroupByClause||CHR(13)||strOrderByClause;

--           DBMS_OUTPUT.PUT_LINE(strSqlQuery);
            DELETE FROM VAI;
            INSERT INTO VAI VALUES(strSqlQuery);
            COMMIT;
            --Finally Return the recordset here
            OPEN Return_Recordset FOR strSqlQuery ;
            /*Craete Log */
            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
            (
              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
              pSessionId ,pReportType , pReportID,'SUCCESS'
            )
            ;
          EXCEPTION
          WHEN OTHERS THEN
            /*Craete Log*/
            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
            (
              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
              pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
            )
            ;
      END ;







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
PROCEDURE SALARY_REGISTER_VARIANCE_RPT(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSqlQueryOuter LONG;
    strArrearSqlQuery LONG;
    strSubGrandTotalClause LONG;
    strGrandTotalClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strWhereNullCond LONG;
    strAllowanceMonthly LONG;
    strOtherAllowance LONG;
    strDeduction LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    vPrev_Pay_Month VARCHAR2(10);
    strWhereClauseCurrMonth LONG;
    strWhereClausePrvMonth LONG;
    strMainQuery LONG;
    strMainSelect LONG;
    strSqlQuery1 LONG;
    strSqlQuery2 LONG;
    strAllowanceVariance LONG;
    strDeductionVariance LONG;
    strSelectVariance LONG;
    strFromVariance LONG;
    strWhereVariance LONG;
    strArrAllowanceVariance LONG;
    strVarianceGrossEarn LONG;
    strVarianceTotDeduct LONG;
    strVarianceNetSalary LONG;
    strHeaderField LONG;
    strCompName LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    vCount NUMBER(12,2);
  BEGIN
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
    pTo_Date,strGetCompName,strGetRptName);
    --Inserting data into Temporary tables
    --            IF pIsBatchWiseReport = 'Y' THEN
    --                INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,
    -- pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
    -- pIsMultipleSheet);
    --            END IF;
    vPrev_Pay_Month:=TO_CHAR(to_date(01||pPay_Month)-1,'MON YYYY');
    --MASTER COLUMNNS
    --            strSqlQuery:='SELECT * FROM (SELECT ''AC'' "REPORT_SECTION",'
    -- ;
    strGroupByClause:= ' GROUP BY ';
    strSelectClause :=strSelectClause ||
    ' ''AC'' REPORT_HEADER,VW.EMP_MID AS "CODE",VW.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(VW.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(VW.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",
TO_CHAR(VW.ARREAR_DAYS) AS "ARREAR DAYS" ,VW.CC_DESC "COST CENTER",VW.EMP_MGMT_CATE_MID "MGMT/NONMGMT",
VW.SUB_DEPT_DESC "SUB DEPARTMENT",VW.BAND_DESC "SUB CODE",VW.DEPT_DESC AS "DEPARTMENT", VW.DESG_DESC AS "DESIGNATION",VW.GRADE_DESC AS "GRADE",VW.LOC_DESC AS "LOCATION",
TO_CHAR(VW.BANK_ACCOUNT_NO) AS "SAVING ACCOUNT",VW.BANK_DESC AS "BANK NAME",TO_CHAR(VW.PAN_NUMBER) AS "PAN NUMBER"'
    ;
    vCount:=0;
    FOR I IN
    (
      SELECT DISTINCT
        VW.ALLWDED_AID,
        VW.ALLWDED_MID,
        REPLACE(ALLWDED_DESC,'''','') ALLWDED_DESC,
        'ROUND(SUM( CASE WHEN TRIM(VW.ALLWDED_MID)='''
        ||VW.ALLWDED_MID
        ||''' AND PAY_MONTH='''
        ||pPay_Month
        ||''' THEN VW.AMOUNT ELSE 0 END),2) AS "'
        ||REPLACE(ALLWDED_DESC,'''','')
        ||'"' current_month,
        'ROUND(SUM( CASE WHEN TRIM(VW.ALLWDED_MID)='''
        ||VW.ALLWDED_MID
        ||''' AND PAY_MONTH='''
        ||vPrev_Pay_Month
        ||''' THEN VW.AMOUNT ELSE 0 END),2) AS "OLD '
        ||REPLACE(ALLWDED_DESC,'''','')
        ||'"' PRE_current_month,
        'ROUND(SUM( CASE WHEN TRIM(VW.ALLWDED_MID)='''
        ||VW.ALLWDED_MID
        ||''' AND PAY_MONTH='''
        ||pPay_Month
        ||
        ''' THEN VW.AMOUNT ELSE 0 END),2) - ROUND(SUM( CASE WHEN TRIM(VW.ALLWDED_MID)='''
        ||VW.ALLWDED_MID
        ||''' AND PAY_MONTH='''
        ||vPrev_Pay_Month
        ||''' THEN VW.AMOUNT ELSE 0 END),2) AS "Difference '
        ||REPLACE(ALLWDED_DESC,'''','')
        ||'"' diff_current_month ,
        ADD_MONTHS(pTo_Date,-1) ,
        pTo_Date,
        VW.CTC_TYPE
      FROM
        PY_VW_EMPLOYEE_SALARY VW
      WHERE
        LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS(pTo_Date,-1) AND pTo_Date
      ORDER BY
        VW.CTC_TYPE,
        VW.ALLWDED_AID
    )
  LOOP
    vCount          :=vCount+1;
    strSelectClause :=strSelectClause ||','|| SUBSTR(I.current_month,1,instr(
    I.current_month,' AS '))||' "'||vCount ||'_1",'|| SUBSTR(
    I.PRE_current_month ,1,instr(I.PRE_current_month ,' AS '))||' "'||vCount ||
    '_2",'|| SUBSTR(I.diff_current_month,1 ,instr(I.diff_current_month ,' AS ')
    ) ||' "'||vCount ||'_3"' ;
    strHeaderField:= strHeaderField ||',' || REPLACE(SUBSTR(I.current_month,
    instr(I.current_month,' AS ')                                         +4),'"','''')||' "'||vCount ||'_1",'||
    REPLACE(SUBSTR(I.PRE_current_month ,instr(I.PRE_current_month ,' AS ')+4),
    '"','''') ||' "'||vCount ||'_2",'||
    REPLACE(SUBSTR(I.diff_current_month ,instr(I.diff_current_month ,' AS ')+4)
    ,'"','''') ||' "'||vCount ||'_3"';
    strCompName:=strCompName ||',null "'||vCount||'_11",null "'||vCount||
    '_21" ,null "'||vCount||'_31"';
  END LOOP;
  strSelectClause :=strSelectClause ||
  ',NULL REPORT_HEADER1, NULL "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",
NULL "SUB CODE1", NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName;
  strSqlQuery:=
  'SELECT ''X#X#X'' REPORT_HEADER, NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" ,NULL "COST CENTER",NULL "MGMT/NONMGMT",NULL "SUB DEPARTMENT",NULL "SUB CODE",
NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||'
,''RH'' REPORT_HEADER1, '''
  ||strGetCompName||
  ''' "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB CODE1",
NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||
  ' FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" ,NULL "COST CENTER",NULL "MGMT/NONMGMT",NULL "SUB DEPARTMENT",NULL "SUB CODE",
NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||'
,''RH'' REPORT_HEADER1, '''
  ||strGetRptName||
  ''' "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" ,NULL "COST CENTER1",NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB CODE1",
NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||
  ' FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" ,NULL "COST CENTER",NULL "MGMT/NONMGMT",NULL "SUB DEPARTMENT",NULL "SUB CODE",
NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||
  '
,''DH'' REPORT_HEADER1, ''CODE'' "CODE1",''EMPLOYEE NAME'' "EMPLOYEE NAME1" ,''JOINING DATE'' "JOINING DATE1",''QUIT DATE'' "QUIT DATE1",
''ARREAR DAYS'' "ARREAR DAYS1" , ''COST CENTER'' "COST CENTER1",''MGMT/NONMGMT'' "MGMT/NONMGMT1",
''SUB DEPARTMENT'' "SUB DEPARTMENT1",''SUB CODE'' "SUB CODE1",
''DEPARTMENT'' "DEPARTMENT1", ''DESIGNATION'' "DESIGNATION1",''GRADE'' "GRADE1",''LOCATION'' "LOCATION1",
''SAVING ACCOUNT'' "SAVING ACCOUNT1",''BANK NAME'' "BANK NAME1",''PAN NUMBER'' "PAN NUMBER1"'
  ||strHeaderField||
  ' FROM DUAL
UNION ALL
SELECT * FROM (SELECT '
  ;
  strFromClause :=' FROM PY_VW_EMPLOYEE_SALARY VW';
  strWhereClause:=' WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS('''||pTo_Date
  ||''',-1) AND '''|| pTo_Date || '''';
  --              IF pIsBatchWiseReport='Y' THEN
  --               strWhereClause:=strWhereClause||chr(13)||' AND VW.BATCH_ID
  -- IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''||
  -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
  --            END IF;
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    --                   strWhereClause:=strWhereClause||chr(13)||' AND
    -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
    -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
    -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
    -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  IF TRIM(pIsMultipleSheet) ='Y' THEN
    strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
    pMasterType , pMultiSheetCondition),'HD.','VW.');
  END IF;
  strGroupByClause:= strGroupByClause ||
  ' VW.EMP_MID,VW.EMP_NAME,VW.JOIN_DATE,VW.LEAVE_DATE,VW.ARREAR_DAYS, VW.DEPT_DESC,VW.DESG_DESC,VW.GRADE_DESC,VW.LOC_DESC,
VW.BANK_ACCOUNT_NO,VW.BANK_DESC,VW.PAN_NUMBER,VW.CC_DESC,VW.EMP_MGMT_CATE_MID,VW.SUB_DEPT_DESC,VW.BAND_DESC order by "CODE")'
  ;
  --             strGroupByClause:=strGroupByClause||chr(13)||') UNION ALL
  -- SELECT DISTINCT ''RH'' ,';
  --
  --            IF pIsBatchWiseReport = 'Y' THEN
  --                strGroupByClause:=strGroupByClause||chr(13)||'NULL,';
  --            END IF;
  --             strGroupByClause:=strGroupByClause||chr(13)||''''||
  -- strGetCompName||''',NULL,NULL,NULL,NULL,
  --                                NULL, NULL, NULL,NULL,NULL,NULL,NULL'||
  -- strCompName||' FROM DUAL UNION ALL SELECT DISTINCT ''RH'' ,';
  --            IF pIsBatchWiseReport = 'Y' THEN
  --                strGroupByClause:=strGroupByClause||chr(13)||'NULL,';
  --            END IF;
  --             strGroupByClause:=strGroupByClause||chr(13)||''''||
  -- strGetRptName ||''',NULL,NULL,NULL,
  --                                NULL, NULL, NULL,NULL,NULL,NULL,NULL,NULL'|
  -- |strCompName||' FROM DUAL UNION ALL SELECT ''DH'' ,''CODE'',''EMPLOYEE
  -- NAME'' ,''JOINING DATE'',''QUIT DATE'',
  --                                ''ARREAR DAYS'' , ''DEPARTMENT'', ''
  -- DESIGNATION'',''GRADE'',''LOCATION'',''SAVING ACCOUNT'',''BANK NAME'',''
  -- PAN NUMBER'''|| strHeaderField ||' FROM DUAL ORDER BY 1 DESC,2';
  --
  strMainQuery:= strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strGroupByClause;

  COMMIT;
  --Finally Return the recordset here
  OPEN Return_Recordset FOR strMainQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM||
    DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
  )
  ;
END ;
PROCEDURE TDS_RPT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --            INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,
      -- pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
      -- pReportID,pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    strSelect :=
    'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''', null,null ,null, null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,
''RH'' REPORT_HEADER,'''
    ||strGetRptName||
    ''', null,null ,null, null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,
''DH'' REPORT_HEADER1, ''CODE'', ''EMPLOYEE NAME'',''PAN NUMBER'' ,''TDS'', ''EDUCATION CESS'',''TOTAL TAX DEDUCTED''
FROM DUAL UNION ALL '
    ;
    strSelect := strSelect||'SELECT * FROM ( SELECT ''AC'' "REPORT_HEADER",  ';
    strSelect := strSelect||strBatchSelect||
    ' EMP_MID "CODE",EMP_NAME "EMPLOYEE NAME",PAN_NUMBER "PAN NUMBER",ROUND(SUM(AMOUNT)*100/103) "TDS",SUM(AMOUNT)-ROUND(SUM(AMOUNT)*100/103) "EDUCATION CESS",SUM(AMOUNT) "TOTAL TAX DEDUCTED",
NULL "REPORT_HEADER1",NULL  "CODE1",NULL "EMPLOYEE NAME1",NULL "PAN NUMBER1",NULL "TDS1",NULL "EDUCATION CESS1",
NULL "TOTAL TAX DEDUCTED1" '
    ;
    strFrom  := ' FROM PY_VW_EMPLOYEE_SALARY A';
    strWhere := ' WHERE A.ALLWDED_MID=''INT'' AND A.PAY_MONTH IS NOT NULL AND '
    ;
    strWhere := strWhere || ' A.COMP_ID='''||pComp_Aid||''' AND A.ACC_YEAR='''
    ||pAcc_Year||''' ';
    strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
    ''' AND A.PROC_DATE<='''||pTo_Date||''' ';
    strWhere := strWhere ||strBatchWhere;
    IF TRIM
      (
        pIsMultipleSheet
      )
               ='Y' THEN
      strWhere:=strWhere||' AND '||REPLACE
      (
        GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','A.'
      )
      ;
    END IF;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      strWhere:=strWhere||chr
      (
        13
      )
      ||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy := ' GROUP BY ';
    strGroupBy := strGroupBy||strBatchGroupBy|| ' EMP_MID,EMP_NAME,PAN_NUMBER';
    strOrderBy := ' ORDER BY ';
    strOrderBy := strOrderBy||strBatchOrderBy||' EMP_MID) ';
    strUnion1  :='UNION ALL SELECT '||strBatchSelect||
    '''DH'' "REPORT_HEADER",''TOTAL'' "CODE",''TOTAL COUNT ''||COUNT(DISTINCT EMP_MID) "EMPLOYEE NAME",NULL "PAN NUMBER",SUM(ROUND(AMOUNT*100/103)) "TDS",SUM(ROUND(AMOUNT-AMOUNT*100/103)) "EDUCATION CESS",SUM(AMOUNT) "TOTAL TAX DEDUCTED",
NULL "REPORT_HEADER1",NULL  "CODE1",NULL "EMPLOYEE NAME1",NULL "PAN NUMBER1",NULL "TDS1",NULL "EDUCATION CESS1",
NULL "TOTAL TAX DEDUCTED1"'
    ;
    strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||NVL
    (
      REPLACE(strBatchGroupBy,',',' '),'1'
    )
    ;
    strSqlQuery:=strSelect||CHR
    (
      13
    )
    ||strFrom||CHR
    (
      13
    )
    ||strWhere||CHR
    (
      13
    )
    ||strGroupBy||CHR
    (
      13
    )
    ||strOrderBy||CHR
    (
      13
    )
    ||strUnion1;


    OPEN Return_Recordset FOR strSqlQuery;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE PT_RPT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect1 LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
  BEGIN

    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --            INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,
      -- pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
      -- pReportID,pIsMultipleSheet,pFilterId);
      strBatchSelect := 'BATCH_ID,';
      strBatchSelect1:='DECODE(ROW_NO,2,NULL,BATCH_ID) BATCH_ID,';
      strBatchWhere  :=
      ' AND BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    IF pReportType             ='Excel' THEN
      IF pMultiSheetCondition != 'SUMMARY' THEN
        strSelect             :=
        'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,
''RH'' REPORT_HEADER1,'''
        ||strGetCompName||
        ''', null,null ,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,
''RH'' REPORT_HEADER,'''
        ||strGetRptName||
        ''', null,null ,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null,null,
''DH'' REPORT_HEADER,  ''EMPLOYEE CODE'',''EMPLOYEE NAME'',''STATE NAME'',''LOCATION NAME'',''PROFESSION TAX''  FROM DUAL UNION ALL '
        ;
        strSelect := strSelect||'SELECT REPORT_HEADER, '||strBatchSelect1||
        ' "EMPLOYEE CODE",EMP_NAME "EMPLOYEE NAME",DECODE(ROW_NO,2,NULL,STATE_NAME) "STATE NAME",DECODE(ROW_NO,2,TO_CHAR(PT_AMT),LOC_DESC) "LOCATION NAME","PROFESSION TAX" ,
NULL "REPORT_HEADER1",NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1",NULL "STATE NAME1",NULL "LOCATION NAME1",NULL "PROFESSION TAX1"
FROM ( SELECT ''AC'' REPORT_HEADER,'
        ;
        strSelect := strSelect||strBatchSelect||
        ' 1 ROW_NO,A.EMP_MID "EMPLOYEE CODE",A.EMP_NAME,A.STATE_NAME, A.LOC_DESC,A.AMOUNT PT_AMT,NULL PT,A.AMOUNT "PROFESSION TAX"'
        ;
        strFrom  := ' FROM PY_VW_EMPLOYEE_SALARY A ';
        strWhere := ' WHERE TRIM(ALLWDED_MID)=''PRT''';
        strWhere := strWhere || ' AND A.COMP_ID='''||pComp_Aid||
        ''' AND A.ACC_YEAR='''||pAcc_Year||''' ';
        strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
        ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
        ''' AND A.PAY_DATE IS NOT NULL';
        IF TRIM
          (
            pIsMultipleSheet
          )
                   ='Y' THEN
          strWhere:=strWhere||' AND '||REPLACE
          (
            GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','A.'
          )
          ;
        END IF;
        strWhere := strWhere ||strBatchWhere;
        /*to generate the report for the Employees as per the Filter ID*/
        IF pFilterId IS NOT NULL THEN
          INSERT_FILTER_DATA_TEMPORARY
          (
            pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
            pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
          )
          ;
          strWhere:=strWhere||chr
          (
            13
          )
          ||
          ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
          ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||
          ''' AND REPORT_AID='''||pReportID||''' AND COMP_AID='''||pComp_Aid||
          ''')';
        END IF;
        strGroupBy := ' UNION ALL SELECT ''DH'' REPORT_HEADER, ';
        strGroupBy := strGroupBy||strBatchSelect||
        ' 2 ROW_NO,TO_CHAR(COUNT(DISTINCT A.EMP_AID)) NO_EMP,NULL,A.STATE_NAME, A.LOC_DESC,A.AMOUNT PT_AMT,A.AMOUNT,SUM(A.AMOUNT) TOTAL '
        ;
        strGroupBy := strGroupBy||strFrom||strWhere||' GROUP BY' ||
        strBatchGroupBy||' A.STATE_NAME,A.LOC_DESC,A.AMOUNT ';
        strOrderBy := 'ORDER BY ';
        strOrderBy := strOrderBy||strBatchOrderBy||
        ' STATE_NAME,LOC_DESC,PT_AMT,ROW_NO)';
        strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy||strOrderBy;

      ELSE
        strSelect :=
        'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,
''RH'' REPORT_HEADER1,'''
        ||strGetCompName||
        ''', null,null ,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,
''RH'' REPORT_HEADER,'''
        ||strGetRptName||
        ''', null,null ,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null,
''DH'' REPORT_HEADER,  ''STATE NAME'',''Professional Tax'',''No.of Employees'',''Amount''  FROM DUAL UNION ALL '
        ;
        strSelect :=strSelect|| 'SELECT REPORT_HEADER, '||strBatchSelect1||
        ' DECODE(ROW_NUM,1,STATE_NAME,NULL) "STATE NAME",PT_AMT "Professional Tax",NO_EMP "No.of Employees",AMT "Amount"
,NULL "REPORT_HEADER1",NULL "STATE NAME1",NULL "Professional Tax1",NULL "No.of Employees1",NULL "Amount1"  FROM (
SELECT * FROM (
SELECT DISTINCT STATE_NAME,''AC'' REPORT_HEADER,3 ROW_NUM,'
        ;
        strSelect := strSelect||strBatchSelect||
        ' TO_CHAR(AMOUNT) PT_AMT,TO_CHAR(COUNT(EMP_MID)) NO_EMP,TO_CHAR(SUM(AMOUNT)) AMT'
        ;
        strFrom  := ' FROM PY_VW_EMPLOYEE_SALARY A ';
        strWhere := ' WHERE TRIM(ALLWDED_MID)=''PRT''';
        strWhere := strWhere || ' AND A.COMP_ID='''||pComp_Aid||
        ''' AND A.ACC_YEAR='''||pAcc_Year||''' ';
        strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
        ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
        ''' AND A.PAY_DATE IS NOT NULL';
        strWhere := strWhere ||strBatchWhere;
        /*to generate the report for the Employees as per the Filter ID*/
        IF pFilterId IS NOT NULL THEN
          INSERT_FILTER_DATA_TEMPORARY
          (
            pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
            pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
          )
          ;
          strWhere:=strWhere||chr
          (
            13
          )
          ||
          ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
          ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||
          ''' AND REPORT_AID='''||pReportID||''' AND COMP_AID='''||pComp_Aid||
          ''')';
        END IF;
        strGroupBy := ' GROUP BY ';
        strGroupBy := strGroupBy||strBatchSelect||
        ' STATE_NAME,AMOUNT UNION ALL SELECT DISTINCT STATE_NAME,''DH'' REPORT_HEADER,4 ROW_NUM, '
        ||strBatchSelect||
        ' ''TOTAL'',TO_CHAR(COUNT(EMP_MID)),TO_CHAR(SUM(AMOUNT)) "PROFESSION TAX" '
        ;
        strGroupBy := strGroupBy||strFrom||strWhere||' GROUP BY' ||
        strBatchGroupBy||
        ' STATE_NAME UNION ALL SELECT DISTINCT STATE_NAME,''RH'' REPORT_HEADER,1 ROW_NUM, '
        ;
        strGroupBy := strGroupBy||strBatchSelect||' NULL,NULL,NULL ';
        strGroupBy := strGroupBy||strFrom||strWhere||' GROUP BY'||
        strBatchGroupBy||
        ' STATE_NAME
UNION ALL
SELECT DISTINCT STATE_NAME,''DH'' REPORT_HEADER,2 ROW_NUM,'
        ;
        strGroupBy := strGroupBy||strBatchSelect||
        ' ''Professional Tax'',''No.of Employees'',''Amount'' ';
        strGroupBy := strGroupBy||strFrom||strWhere|| ' GROUP BY'||
        strBatchGroupBy||' STATE_NAME) ';
        strOrderBy := 'ORDER BY ';
        strOrderBy := strOrderBy||strBatchOrderBy||' STATE_NAME,ROW_NUM)';
        strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
      END IF;


      OPEN Return_Recordset FOR strSqlQuery;
    ELSIF pReportType='View' THEN
      OPEN Return_Recordset FOR
      SELECT "EMPLOYEE CODE",
      EMP_NAME "EMPLOYEE NAME",
      DECODE
      (
        ROW_NO,2,NULL,STATE_NAME
      )
      "STATE NAME",
      DECODE
      (
        ROW_NO,2,TO_CHAR(PT_AMT),LOC_DESC
      )
      "LOCATION NAME",
      "PROFESSION TAX"
      FROM
      (
        SELECT
          'AC' REPORT_HEADER,
          1 ROW_NO,
          A.EMP_MID "EMPLOYEE CODE",
          A.EMP_NAME,
          A.STATE_NAME,
          A.LOC_DESC,
          A.AMOUNT PT_AMT,
          NULL PT,
          A.AMOUNT "PROFESSION TAX"
        FROM
          PY_VW_EMPLOYEE_SALARY A
        WHERE
          TRIM(ALLWDED_MID)       ='PRT'
        AND A.COMP_ID             ='CM000001'
        AND A.ACC_YEAR            ='AY201213'
        AND A.PROC_DATE          >='01-MAY-12'
        AND LAST_DAY(A.PROC_DATE)<='31-MAY-12'
        AND A.PAY_DATE           IS NOT NULL
      UNION ALL
      SELECT
        'DH' REPORT_HEADER,
        2 ROW_NO,
        TO_CHAR(COUNT(DISTINCT A.EMP_AID)) NO_EMP,
        NULL,
        A.STATE_NAME,
        A.LOC_DESC,
        A.AMOUNT PT_AMT,
        A.AMOUNT,
        SUM(A.AMOUNT) TOTAL
      FROM
        PY_VW_EMPLOYEE_SALARY A
      WHERE
        TRIM(ALLWDED_MID)       ='PRT'
      AND A.COMP_ID             ='CM000001'
      AND A.ACC_YEAR            ='AY201213'
      AND A.PROC_DATE          >='01-MAY-12'
      AND LAST_DAY(A.PROC_DATE)<='31-MAY-12'
      AND A.PAY_DATE           IS NOT NULL
      GROUP BY
        A.STATE_NAME,
        A.LOC_DESC,
        A.AMOUNT
      ORDER BY
        STATE_NAME,
        LOC_DESC,
        PT_AMT,
        ROW_NO
      )
      ;
    ELSE
      OPEN Return_Recordset FOR
      --        SELECT "EMPLOYEE CODE",EMP_NAME ,DECODE(ROW_NO,2,NULL,
      -- STATE_NAME) "STATE NAME",DECODE(ROW_NO,2,TO_CHAR(PT_AMT),LOC_DESC) "
      -- LOCATION NAME","PROFESSION TAX"
      --                         FROM (
      --                         SELECT 'AC' REPORT_HEADER, 1 ROW_NO,A.EMP_MID
      -- "EMPLOYEE CODE",A.EMP_NAME,A.STATE_NAME, A.LOC_DESC,A.AMOUNT PT_AMT,
      -- NULL PT,A.AMOUNT "PROFESSION TAX"
      --                         FROM PY_VW_EMPLOYEE_SALARY A  WHERE TRIM(
      -- ALLWDED_MID)='PRT' AND A.COMP_ID=pComp_Aid
      --                         AND A.ACC_YEAR=pAcc_Year  AND A.PROC_DATE>=
      -- pFrom_Date AND LAST_DAY(A.PROC_DATE)<=pTo_Date AND A.PAY_DATE IS NOT
      -- NULL
      --                         UNION ALL
      --                         SELECT 'DH' REPORT_HEADER,  2 ROW_NO,TO_CHAR(
      -- COUNT(DISTINCT A.EMP_AID)) NO_EMP,NULL,A.STATE_NAME, A.LOC_DESC,
      -- A.AMOUNT PT_AMT,A.AMOUNT,SUM(A.AMOUNT) TOTAL
      --                         FROM PY_VW_EMPLOYEE_SALARY A
      --                         WHERE TRIM(ALLWDED_MID)='PRT' AND A.COMP_ID=
      -- pComp_Aid AND A.ACC_YEAR=pAcc_Year  AND A.PROC_DATE>=pFrom_Date
      --                         AND LAST_DAY(A.PROC_DATE)<=pTo_Date AND
      -- A.PAY_DATE IS NOT NULL
      --                         GROUP BY A.STATE_NAME,A.LOC_DESC,A.AMOUNT
      --                         ORDER BY  STATE_NAME,LOC_DESC,PT_AMT,ROW_NO);
      SELECT BATCH_ID,
      LOC_DESC,
      "PROFESSION TAX",
      "NO. OF EMPLOYEES",
      "TOTAL AMOUNT" FROM
      (
        SELECT
          A.BATCH_ID,
          UPPER(A.LOC_DESC) LOC_DESC,
          A.AMOUNT "PROFESSION TAX",
          COUNT(DISTINCT A.EMP_AID) "NO. OF EMPLOYEES",
          A.STATE_NAME,
          SUM(A.AMOUNT) "TOTAL AMOUNT"
        FROM
          PY_VW_EMPLOYEE_SALARY A
        WHERE
          TRIM(ALLWDED_MID)       ='PRT'
        AND A.COMP_ID             =pComp_Aid
        AND A.ACC_YEAR            =pAcc_Year
        AND A.PROC_DATE          >=pFrom_Date
        AND LAST_DAY(A.PROC_DATE)<=pTo_Date
        AND A.PAY_DATE           IS NOT NULL
        GROUP BY
          A.STATE_NAME,
          A.LOC_DESC,
          A.AMOUNT,
          A.BATCH_ID
        ORDER BY
          STATE_NAME,
          LOC_DESC,
          "PROFESSION TAX"
      )
      ;
    END IF;
    --strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
    --        strSqlQuery:=strSqlQuery||strUnion1||strUnion2||strOrderBy;
    --        strSqlQuery:=strSqlQuery||strUnion1||strOrderBy||strUnion2;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE PT_RPT_EMPWISE
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'BATCH_ID,';
      strBatchWhere  :=
      ' AND BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    strSelect :=
    'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,null,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''', null,null ,null, null,null,null  FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null,
''RH'' REPORT_HEADER,'''
    ||strGetRptName||
    ''', null,null ,null, null,null,null  FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,
''DH'' REPORT_HEADER1, ''STATE NAME'', ''LOCATION NAME'',''CODE'' ,''EMPLOYEE NAME'', ''PROFESSION TAX'',''NO. OF EMPLOYEES'',
''TOTAL AMOUNT'' FROM DUAL UNION ALL '
    ;
    --        strSelect :=strSelect||'SELECT ''AC'' "REPORT_HEADER", "STATE
    -- NAME", LOC_DESC "LOCATION NAME", "CODE", "EMPLOYEE NAME","PROFESSION TAX
    -- ","NO. OF EMPLOYEES","TOTAL AMOUNT",NULL "REPORT_HEADER1",
    --        "STATE NAME1","LOCATION NAME1","CODE1","EMPLOYEE NAME1","
    -- PROFESSION TAX1","NO. OF EMPLOYEES1","TOTAL AMOUNT1" FROM ( ';
    strSelect := strSelect||
    'SELECT ''AC'' "REPORT_HEADER",STATE_NAME "STATE NAME",NVL(HEADER,LOC_DESC) LOC_DESC, EMP_MID "CODE",EMP_NAME "EMPLOYEE NAME",'
    ||strBatchSelect||
    '"PROFESSION TAX","NO. OF EMPLOYEES","TOTAL AMOUNT",
"HEADER","STATE NAME1","LOCATION NAME1","CODE1","EMPLOYEE NAME1","PROFESSION TAX1","NO. OF EMPLOYEES1","TOTAL AMOUNT1" FROM ((SELECT ''AC'' "REPORT_HEADER",A.STATE_NAME,'
    ;
    strSelect := strSelect||strBatchSelect||
    ' A.LOC_DESC,EMP_MID,EMP_NAME,A.AMOUNT "PROFESSION TAX",COUNT(DISTINCT A.EMP_AID)  "NO. OF EMPLOYEES",SUM(A.AMOUNT) "TOTAL AMOUNT",
NULL "HEADER",NULL "STATE NAME1", NULL "LOCATION NAME1",NULL "CODE1",NULL "EMPLOYEE NAME1",NULL "PROFESSION TAX1" ,NULL  "NO. OF EMPLOYEES1",NULL "TOTAL AMOUNT1"'
    ;
    strFrom  := ' FROM PY_VW_EMPLOYEE_SALARY A';
    strWhere := ' WHERE TRIM(ALLWDED_MID)=''PRT''';
    strWhere := strWhere || ' AND A.COMP_ID='''||pComp_Aid||
    ''' AND A.ACC_YEAR='''||pAcc_Year||''' ';
    strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
    ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
    ''' AND A.PAY_DATE IS NOT NULL';
    strWhere := strWhere ||strBatchWhere;
    IF TRIM
      (
        pIsMultipleSheet
      )
               ='Y' THEN
      strWhere:=strWhere||' AND '||REPLACE
      (
        GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','A.'
      )
      ;
    END IF;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      strWhere:=strWhere||chr
      (
        13
      )
      ||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy := CHR
    (
      13
    )
    ||' GROUP BY ';
    strGroupBy := strGroupBy||strBatchGroupBy||
    ' A.STATE_NAME,A.COMP_ID,A.LOC_DESC,A.AMOUNT,EMP_MID,EMP_NAME';
    strOrderBy := CHR
    (
      13
    )
    ||') ORDER BY ';
    strOrderBy := strOrderBy||strBatchOrderBy||
    ' STATE_NAME,LOC_DESC,"PROFESSION TAX"';
    strUnion1:=CHR
    (
      13
    )
    ||' UNION ALL SELECT ''AC'' "REPORT_HEADER", A.STATE_NAME,'||strBatchSelect
    ||
    ' A.LOC_DESC,NULL,NULL,NULL "PROFESSION TAX",COUNT(DISTINCT A.EMP_AID)  "NO. OF EMPLOYEES",SUM(A.AMOUNT) "TOTAL AMOUNT",
NULL "HEADER",NULL "STATE NAME1", NULL "LOCATION NAME1",NULL "CODE1",NULL "EMPLOYEE NAME1",NULL "PROFESSION TAX1" ,NULL  "NO. OF EMPLOYEES1",NULL "TOTAL AMOUNT1"'
    ;
    strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
    ' A.STATE_NAME,A.COMP_ID,A.LOC_DESC';
    strUnion2:=CHR
    (
      13
    )
    ||
    ') UNION ALL SELECT ''DH'' "REPORT_HEADER",NULL STATE_NAME, ''GRAND TOTAL'' LOC_DESC,NULL,NULL,'
    ||REPLACE
    (
      TRIM(strBatchSelect),'BATCH_ID,','NULL,'
    )
    ||
    ' NULL "PROFESSION TAX",COUNT(DISTINCT A.EMP_AID)  "NO. OF EMPLOYEES",SUM(A.AMOUNT) "TOTAL AMOUNT",
NULL "HEADER",NULL "STATE NAME1", NULL "LOCATION NAME1",NULL "CODE1",NULL "EMPLOYEE NAME1",NULL "PROFESSION TAX1" ,NULL  "NO. OF EMPLOYEES1",NULL "TOTAL AMOUNT1"'
    ;
    --        strUnion2:=') UNION ALL SELECT  ''GRAND TOTAL'' LOC_DESC,NULL,
    -- NULL "PROFESSION TAX",COUNT(A.AMOUNT) "NO. OF EMPLOYEES",SUM(A.AMOUNT) "
    -- TOTAL AMOUNT"';
    strUnion2  :=strUnion2||strFrom||strWhere||' GROUP BY  A.COMP_ID ';
    strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy;
    --        strSqlQuery:=strSqlQuery||strUnion1||strUnion2||strOrderBy;
    strSqlQuery:=strSqlQuery||strUnion1||strOrderBy||strUnion2;
    OPEN Return_Recordset FOR strSqlQuery;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE PF_RPT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    strOrderBy LONG;
    strWhereCon LONG;
    strGroupBy LONG;
  BEGIN
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      NULL;
    END IF;
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    IF pReportType         ='Crystal' OR pReportType='View' THEN
      strSqlQuery         := 'SELECT B.COMP_NAME,';
      IF pIsBatchWiseReport='Y' THEN
        strSqlQuery       := strSqlQuery|| ' A.BATCH_ID,';
      END IF;
      strSqlQuery := strSqlQuery||
      ' A.PAY_MONTH,A.CODE,A.NAME "EMPLOYEE NAME",TO_DATE(TO_CHAR(A.JOIN_DATE,''DD-MON-YYYY'')) "JOIN DATE",PF_AC "PROVIDEND FUND ACCOUNT NO"'
      ;
      strSqlQuery := strSqlQuery ||
      ' ,SUM(A.EDLI_SAL) "E.D.L.I. SALARY",SUM(A.BAS) "BASIC SALARY",SUM(A.SPF) "EMPLOYEE CONTRIBUTION",SUM(A.EPF) "EMPLOYER PF",SUM(A.PEN) "EMPLOYERS PENSION FUND"'
      ;
      strSqlQuery := strSqlQuery ||
      ' ,SUM(A.TOT) "TOTAL AMOUNT",SUM(A.PFA) "ADMINISTRATIVE CHARGES",SUM(A.INF) "INSURANCE FUND",SUM(A.INA) "ADMIN CHARGES TO INSURANCE",TO_CHAR(C.PAID_DAYS) "PRESENT DAYS" '
      ;
      --             IF TRIM(pIsMultipleSheet) ='Y' THEN
      --                   strWhereCon:=' AND '||REPLACE(GET_CONDITION(
      -- pMasterType , pMultiSheetCondition),'HD.','C.');
      --
      --              END IF;
      strOrderBy :=
      ' ORDER BY B.COMP_NAME,A.PAY_MONTH,A.CODE,A.NAME ,A.JOIN_DATE ,PF_AC';
    ELSE
      strSqlQuery         := 'SELECT ';
      IF pIsBatchWiseReport='Y' THEN
        strSqlQuery       := strSqlQuery|| ' A.BATCH_ID,';
      END IF;
      strSqlQuery :=
      'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,null, null,null,null,null,null,null,null,
''RH'' REPORT_HEADER1,'''
      ||strGetCompName||
      ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,
''RH'' REPORT_HEADER,'''
      ||strGetRptName||
      ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,
''DH'' REPORT_HEADER1,  ''EMPLOYEE CODE'',''EMPLOYEE NAME'',''JOIN DATE'',''PROVIDEND FUND ACCOUNT NO'',''PRESENT DAYS'',
''E.D.L.I. SALARY'',''BASIC SALARY'',''EMPLOYEE CONTRIBUTION'',''EMPLOYER PF'',
''EMPLOYERS PENSION FUND'',''TOTAL AMOUNT'',''ADMINISTRATIVE CHARGES'',''INSURANCE FUND'',''ADMIN CHARGES TO INSURANCE''  FROM DUAL UNION ALL SELECT * FROM (SELECT '
      ;
      strSqlQuery := strSqlQuery||
      ' A.PAY_MONTH,A.CODE,A.NAME "EMPLOYEE NAME",TO_DATE(TO_CHAR(A.JOIN_DATE,''DD-MON-YYYY'')) "JOIN DATE",PF_AC "PROVIDEND FUND ACCOUNT NO",C.PAID_DAYS "PRESENT DAYS" '
      ;
      strSqlQuery := strSqlQuery ||
      ' ,SUM(A.EDLI_SAL) "E.D.L.I. SALARY",SUM(A.BAS) "BASIC SALARY",SUM(A.SPF) "EMPLOYEE CONTRIBUTION",SUM(A.EPF) "EMPLOYER PF",SUM(A.PEN) "EMPLOYERS PENSION FUND"'
      ;
      strSqlQuery := strSqlQuery ||
      ' ,SUM(A.TOT) "TOTAL AMOUNT",SUM(A.PFA) "ADMINISTRATIVE CHARGES",SUM(A.INF) "INSURANCE FUND",SUM(A.INA) "ADMIN CHARGES TO INSURANCE"'
      ;
      strSqlQuery := strSqlQuery ||
      ' ,NULL "REPORT HEADER1", NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1",NULL "JOIN DATE1",NULL "PROVIDEND FUND ACCOUNT NO1",NULL "PRESENT DAYS1",NULL "E.D.L.I. SALARY1",'
      ;
      strSqlQuery := strSqlQuery ||
      '  NULL "BASIC SALARY1",NULL "EMPLOYEE CONTRIBUTION1",NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",NULL "ADMIN CHARGES TO INSURANCE1"'
      ;
      IF TRIM
        (
          pIsMultipleSheet
        )
                    ='Y' THEN
        strWhereCon:=' AND '||REPLACE
        (
          GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','C.'
        )
        ;
      END IF;
      strOrderBy :=
      ' ORDER BY B.COMP_NAME,A.PAY_MONTH,A.CODE,A.NAME ,A.JOIN_DATE ,PF_AC)';
    END IF;
    strSqlQuery := strSqlQuery ||
    '    FROM PY_VW_PF_STATMENT A, PY_GM_COMP B,PY_PT_SAL_HD C';
    strSqlQuery := strSqlQuery ||
    '    WHERE A.COMP_AID=B.COMP_ID AND A.COMP_AID=C.COMP_AID AND A.EMP_AID=C.EMP_AID AND A.ACC_YEAR=C.ACC_YEAR AND A.PAY_MONTH=C.PAY_MONTH AND A.COMP_AID='''
    ||trim
    (
      pComp_Aid
    )
    ||''' ';
    strSqlQuery := strSqlQuery || '    AND TO_DATE(01||A.PAY_MONTH)>='''||
    pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
    ''' ';
    IF pIsBatchWiseReport='Y' THEN
      strWhereCon       := strWhereCon||
      '  AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
    END IF;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      strWhereCon:=strWhereCon||chr
      (
        13
      )
      ||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy          := ' GROUP BY ';
    IF pIsBatchWiseReport='Y' THEN
      strGroupBy        := strGroupBy || ' A.BATCH_ID,';
    END IF;
    strGroupBy := strGroupBy ||
    ' B.COMP_NAME,A.PAY_MONTH,A.CODE,A.NAME ,A.JOIN_DATE ,PF_AC,C.PAID_DAYS ';
    strSqlQuery:=strSqlQuery||strWhereCon||strGroupBy||strOrderBy;

  OPEN Return_Recordset FOR strSqlQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END;
PROCEDURE ESIC_RPT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
  BEGIN
    --Inserting data into Temporary tables
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    IF pReportType='Excel' THEN
      strSelect  := strSelect||
      'SELECT ''X#X#X'' REPORT_HEADER1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
''RH'' REPORT_HEADER,'''
      ||strGetCompName||
      ''',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
''RH'' REPORT_HEADER,'''
      ||strGetRptName||
      ''',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
''DH'' REPORT_HEADER, ''CODE'',''ESIC NO'',''EMPLOYEE NAME'',''JOIN DATE'',''LOCATION'',''PRESENT DAYS'',''GROSS EARNING'',
''ESIC EMPLOYEE'',''ESIC EMPLOYER'',''TOTAL'' FROM DUAL UNION ALL'
      ;
      strSelect := strSelect||
      ' SELECT REPORT_HEADER, "CODE","ESIC NO","EMPLOYEE NAME","JOIN DATE",LOCATION,"PRESENT DAYS","GROSS EARNING",
"ESIC EMPLOYEE","ESIC EMPLOYER",TOTAL,
NULL "1",NULL "2",NULL "3",NULL "4",NULL "5",NULL "6",NULL "7",NULL "8",NULL "9",NULL "10",NULL "11" FROM (
SELECT * FROM (SELECT ''AC'' REPORT_HEADER,1 ROWNO,'
      ;
      strSelect := strSelect||strBatchSelect||
      ' COMP_NAME,EMP_MID "CODE",ESIC_NO "ESIC NO",EMP_NAME "EMPLOYEE NAME",TO_CHAR(JOIN_DATE,''DD-MON-YYYY'') "JOIN DATE",LOC_DESC LOCATION,NVL(PAID_DAYS,0) "PRESENT DAYS",SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL'
      ;
      strFrom  := ' FROM PY_VW_ESIC_STATEMENT A';
      strWhere := ' WHERE ';
      strWhere := strWhere || ' A.COMP_ID='''||pComp_Aid||
      ''' AND A.ACC_YEAR='''||pAcc_Year||''' ';
      strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
      ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
      /*to generate the report for the Employees as per the Filter ID*/
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY
        (
          pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
          pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
        )
        ;
        strWhere:=strWhere||chr
        (
          13
        )
        ||
        ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      strGroupBy := ' GROUP BY ';
      strGroupBy := strGroupBy||strBatchGroupBy||
      ' COMP_NAME,EMP_MID ,EMP_NAME ,LOC_DESC,PAID_DAYS,JOIN_DATE,ESIC_NO';
      strUnion1:=' UNION ALL SELECT '||strBatchSelect||
      '''DH'' REPORT_HEADER,2 ROWNO,COMP_NAME,''Total'' CODE,NULL "ESIC NO",NULL "EMPLOYEE NAME",NULL "JOIN DATE",LOC_DESC LOCATION,0 "PRESENT DAYS",SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL'
      ;
      strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
      ' COMP_NAME, LOC_DESC';
      strUnion2:=' UNION ALL SELECT '||REPLACE
      (
        strBatchSelect,'A.BATCH_ID','NULL'
      )
      ||
      '''DH'' REPORT_HEADER,3 ROWNO,COMP_NAME,''Grand Total'' CODE,NULL "ESIC NO",null "EMPLOYEE NAME",NULL "JOIN DATE",NULL LOCATION,0 "PRESENT DAYS",SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL'
      ;
      strUnion2     :=strUnion2||strFrom||strWhere||' GROUP BY  COMP_NAME';
      strOrderBy    := ') ORDER BY ';
      strOrderBy    := strOrderBy||strBatchOrderBy||' LOCATION,ROWNO)';
    ELSIF pReportType='Crystal' OR pReportType='View' THEN
      strSelect     :=
      'SELECT COMP_ID COMP_AID,ACC_YEAR,PAY_MONTH, EMP_AID,"CODE","EMPLOYEE NAME" NAME,LOC_AID,DECODE(ROWNO,2,''Total'',DECODE(ROWNO,3,''Grand Total'',LOCATION)) LOC_DESC,CC_AID,CC_DESC,DEPT_AID,BR_NAME,STATE_AID,STATE_NAME STATE_DESC,TO_CHAR("PRESENT DAYS") DAY_PRESENT,
TO_CHAR("GROSS EARNING") WAGES,TO_CHAR("ESIC EMPLOYEE") ESIC,TO_CHAR("ESIC EMPLOYER") ER_ESIC,TO_CHAR(TOTAL) TOTAL_ESIC,ROWNO,COMP_NAME,"ESIC NUMBER","JOINING DATE" FROM (
SELECT * FROM (
SELECT '
      ;
      strSelect := strSelect||strBatchSelect||
      ' 1 ROWNO,COMP_NAME, COMP_ID,ACC_YEAR,PAY_MONTH,EMP_AID,EMP_MID "CODE",ESIC_NO "ESIC NUMBER",EMP_NAME "EMPLOYEE NAME",TO_CHAR(JOIN_DATE,''DD-MON-YYYY'')"JOINING DATE",LOC_AID,LOC_DESC LOCATION,CC_AID,CC_DESC,DEPT_AID,BR_DESC BR_NAME,STATE_AID,STATE_NAME,NVL(PAID_DAYS,0) "PRESENT DAYS",
SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",
SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL'
      ;
      strFrom  := ' FROM PY_VW_ESIC_STATEMENT A';
      strWhere := ' WHERE ';
      strWhere := strWhere || ' A.COMP_ID='''||pComp_Aid||
      ''' AND A.ACC_YEAR='''||pAcc_Year||''' ';
      strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
      ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||''' ';
      strWhere     := strWhere ||strBatchWhere;
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY
        (
          pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
          pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
        )
        ;
        strWhere:=strWhere||chr
        (
          13
        )
        ||
        ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      strGroupBy := ' GROUP BY ';
      strGroupBy := strGroupBy||strBatchGroupBy||
      ' COMP_NAME,COMP_ID,EMP_MID ,EMP_NAME ,LOC_DESC,PAID_DAYS ,ACC_YEAR,PAY_MONTH,EMP_AID,LOC_AID,CC_AID,CC_DESC,DEPT_AID,BR_DESC,STATE_AID,STATE_NAME,ESIC_NO,JOIN_DATE'
      ;
      strUnion1:=' UNION ALL SELECT '||strBatchSelect||
      ' 2 ROWNO, NULL COMP_NAME,NULL COMP_ID,NULL ACC_YEAR,NULL PAY_MONTH,NULL EMP_AID,NULL CODE,NULL ESIC_NO,NULL "EMPLOYEE NAME", NULL JOIN_DATE,NULL LOC_AID,LOC_DESC LOCATION,NULL CC_AID,NULL CC_DESC,NULL DEPT_AID,NULL BR_NAME,NULL STATE_AID,NULL STATE_NAME,null "PRESENT DAYS",
SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",
SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL'
      ;
      strUnion1:= strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
      ' COMP_ID, LOC_DESC,ACC_YEAR ,PAY_MONTH,LOC_AID,COMP_NAME';
      strUnion2:=' UNION ALL SELECT '||strBatchSelect||
      ' 3 ROWNO,null COMP_NAME,null COMP_ID,null ACC_YEAR,null PAY_MONTH,null EMP_AID,NULL CODE, NULL ESIC_NO,NULL "EMPLOYEE NAME",NULL JOIN_DATE,NULL LOC_AID,NULL LOCATION,NULL CC_AID,NULL CC_DESC,NULL DEPT_AID,NULL BR_NAME,NULL STATE_AID,NULL STATE_NAME,0 "PRESENT DAYS",SUM(WAGES) "GROSS EARNING",
SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL'
      ;
      strUnion2  := strUnion2|| strFrom||strWhere;
      strOrderBy := ') ORDER BY ';
      strOrderBy := strOrderBy||strBatchOrderBy||' LOCATION,ROWNO)';
      --                OPEN Return_Recordset for
      --                SELECT COMP_ID COMP_AID,ACC_YEAR,PAY_MONTH, EMP_AID,"
      -- CODE","EMPLOYEE NAME" NAME,LOC_AID,LOCATION LOC_DESC,CC_AID,CC_DESC,
      -- DEPT_AID,BR_NAME,STATE_AID,STATE_NAME STATE_DESC,TO_CHAR("PRESENT DAYS
      -- ") DAY_PRESENT,
      --                TO_CHAR("GROSS EARNING") WAGES,TO_CHAR("ESIC EMPLOYEE")
      -- ESIC,TO_CHAR("ESIC EMPLOYER") ER_ESIC,TO_CHAR(TOTAL) TOTAL_ESIC,ROWNO
      -- FROM (
      --                SELECT * FROM (
      ----                    SELECT  distinct 0 ROWNO, COMP_ID,ACC_YEAR,
      -- PAY_MONTH,null EMP_AID,null  "CODE",null "EMPLOYEE NAME",LOC_AID,
      -- LOC_DESC LOCATION,null CC_AID
      ----                    ,null CC_DESC,null DEPT_AID,null BR_NAME
      ----                    ,null STATE_AID,null STATE_NAME,null "PRESENT
      -- DAYS",null  "GROSS EARNING",null "ESIC EMPLOYEE",null "ESIC EMPLOYER",
      -- null  TOTAL
      ----                    FROM PY_VW_ESIC_STATEMENT A WHERE  A.COMP_ID='
      -- CM000001' AND A.ACC_YEAR='AY201213'  AND A.PROC_DATE>='01-MAY-12' AND
      -- LAST_DAY(A.PROC_DATE)<='31-MAY-12' and LOC_AID IS NOT NULL
      ----                     union all
      --                     SELECT  1 ROWNO, COMP_ID,ACC_YEAR,PAY_MONTH,
      -- EMP_AID,EMP_MID "CODE",EMP_NAME "EMPLOYEE NAME",LOC_AID,LOC_DESC
      -- LOCATION,CC_AID,CC_DESC,DEPT_AID,BR_DESC BR_NAME,STATE_AID,STATE_NAME,
      -- NVL(PAID_DAYS,0) "PRESENT DAYS",
      --                    SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC
      -- EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",
      --                    SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL FROM
      -- PY_VW_ESIC_STATEMENT A WHERE  A.COMP_ID='CM000001' AND A.ACC_YEAR='
      -- AY201213'  AND A.PROC_DATE>='01-MAY-12' AND LAST_DAY(A.PROC_DATE)<='31
      -- -MAY-12'  GROUP BY  COMP_ID,EMP_MID ,EMP_NAME ,LOC_DESC,PAID_DAYS ,
      -- ACC_YEAR,PAY_MONTH,EMP_AID,LOC_AID,CC_AID,CC_DESC,DEPT_AID,BR_DESC,
      -- STATE_AID,STATE_NAME
      --                    UNION ALL
      --                    SELECT  2 ROWNO, NULL COMP_NAME,NULL ACC_YEAR,NULL
      -- PAY_MONTH,NULL EMP_AID,NULL CODE,NULL "EMPLOYEE NAME",NULL LOC_AID,
      -- LOC_DESC LOCATION,NULL CC_AID,NULL CC_DESC,NULL DEPT_AID,NULL BR_NAME,
      -- NULL STATE_AID,'Total' STATE_NAME,0 "PRESENT DAYS",
      --                    SUM(WAGES) "GROSS EARNING",SUM(ESIC_EMPLOYEE) "ESIC
      -- EMPLOYEE",SUM(ESIC_EMPLOYER) "ESIC EMPLOYER",
      --                    SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL FROM
      -- PY_VW_ESIC_STATEMENT A WHERE  A.COMP_ID='CM000001' AND A.ACC_YEAR='
      -- AY201213'  AND A.PROC_DATE>='01-MAY-12' AND LAST_DAY(A.PROC_DATE)<='31
      -- -MAY-12'  GROUP BY  COMP_ID, LOC_DESC,ACC_YEAR ,PAY_MONTH,LOC_AID
      --                    UNION ALL
      --                    SELECT  3 ROWNO,null COMP_ID,null ACC_YEAR,null
      -- PAY_MONTH,null EMP_AID,NULL CODE,NULL "EMPLOYEE NAME",NULL LOC_AID,
      -- NULL LOCATION,NULL CC_AID,NULL CC_DESC,NULL DEPT_AID,NULL BR_NAME,NULL
      -- STATE_AID,'Grand Total' STATE_NAME,0 "PRESENT DAYS",SUM(WAGES) "GROSS
      -- EARNING",
      --                    SUM(ESIC_EMPLOYEE) "ESIC EMPLOYEE",SUM(
      -- ESIC_EMPLOYER) "ESIC EMPLOYER",SUM(ESIC_EMPLOYEE+ESIC_EMPLOYER) TOTAL
      -- FROM PY_VW_ESIC_STATEMENT A WHERE  A.COMP_ID='CM000001' AND A.ACC_YEAR
      -- ='AY201213'  AND A.PROC_DATE>='01-MAY-12' AND LAST_DAY(A.PROC_DATE)<='
      -- 31-MAY-12'
      --                    ) ORDER BY  LOCATION,ROWNO
      --                    );
      --
      --
    END IF;
    strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy;
    strSqlQuery:=strSqlQuery||strUnion1||strUnion2||strOrderBy;


  OPEN Return_Recordset FOR strSqlQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END;
PROCEDURE LWF_RPT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
  BEGIN
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      NULL;
    END IF;
    OPEN Return_Recordset FOR
    SELECT 'LWF REPORT UNDER DEVELOPMENT' MESSAGE FROM DUAL;
  END;
  --    PROCEDURE CTC_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month
  -- VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId
  -- VARCHAR2,pReportType VARCHAR2,pIsBatchWiseReport VARCHAR2,v
  -- arrTyp_Batch_Id,Return_Recordset OUT REC)
PROCEDURE CTC_RPT_VERTICAL
  (
    pComp_Aid            VARCHAR2,
    pAcc_Year            VARCHAR2,
    pPay_Month           VARCHAR2,
    pFrom_Date           VARCHAR2,
    pTo_Date             VARCHAR2,
    pUser_Aid            VARCHAR2,
    pSessionId           VARCHAR2,
    pReportType          VARCHAR2,
    pReportID            VARCHAR2,
    pIsBatchWiseReport   VARCHAR2,
    pFilterId            VARCHAR2,
    pIsMultipleSheet     VARCHAR2,
    pMasterType          VARCHAR2,
    pMultiSheetCondition VARCHAR2,
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strCTC_COLUMNS LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strSQLClause LONG;
    strOrderByClause LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --        Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      NULL;
    END IF;
    --        OPEN Return_Recordset for
    --            SELECT 'DS' REPORT_SECTION,B.EMP_MID "Employee Id",B.EMP_NAME
    -- "Employee Name", TO_CHAR(B.JOIN_DATE,'DD-MON-YYYY') "Joining Date",
    --                  CTC_NAME "Allowance Name", TO_CHAR(A.EFF_DATE_FR, 'DD-
    -- MON-YYYY') "CTC Effective From Date",TO_CHAR(A.EFF_DATE_TO, 'DD-MON-YYYY
    -- ') "CTC Effective To Date",
    --                 A.AMOUNT "CTC Amount",CTC_CATE_ID_DESC "Allowance
    -- Category"
    --              FROM PY_PM_EMPCTCDTL A, PY_GM_EMPMAST B, PY_VW_PM_ALLWDED C
    --                WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID
    --                      AND A.COMP_AID = C.COMP_ID AND A.ALLWDED_AID =
    -- C.CTC_CODE
    --                      AND A.COMP_AID = pComp_Aid
    ----                      AND A.EFF_DATE_FR >= pFrom_Date AND NVL(
    -- A.EFF_DATE_TO,pTo_Date) <= pTo_Date
    --                         AND pFrom_Date between A.EFF_DATE_FR and NVL(
    -- A.EFF_DATE_TO,pTo_Date)
    --                       and A.EFF_DATE_TO is null
    --            ORDER BY "Employee Id", REV_NO,"Allowance Category",CTC_CODE;
    strSQLClause:=
    ' SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null,null,null,null,null,null,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''',null ,null,null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null,null,null,null,null,null,
''RH'' REPORT_HEADER, '''
    ||strGetRptName||
    ''',null,null,null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null,null,null,null,null,null,
''DH'' REPORT_HEADER1, ''Employee Id'',''Employee Name'' ,''Joining Date'',''Quit Date'', ''Allowance Name'',''CTC Effective From Date'',
''CTC Effective To Date'',''CTC Amount'',''Allowance Category''
FROM DUAL
UNION ALL '
    ;
    strSelectClause :=
    ' SELECT ''AC'' "REPORT HEADER",EMP_MID "EMPLOYEE CODE",EMP_NAME "EMPLOYEE NAME", JOIN_DATE "JOIN DATE",LEAVE_DATE,CTC_NAME "ALLOWANCE NAME",EFF_DATE_FR "CTC EFFECTIVE FROM DATE",
EFF_DATE_TO "CTC EFFECTIVE TO DATE",AMOUNT "CTC AMOUNT",CTC_CATE_ID_DESC "ALLOWANCE CATEGORY",
NULL "REPORT HEADER1",NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME", NULL "JOIN DATE1",NULL "LEAVE DATE1",NULL "ALLOWANCE NAME1",NULL "CTC EFFECTIVE FROM DATE1",
NULL "CTC EFFECTIVE TO DATE1",NULL "CTC AMOUNT1",NULL "ALLOWANCE CATEGORY1"
FROM
(
SELECT B.EMP_MID ,B.EMP_NAME , TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') JOIN_DATE ,
C.CTC_NAME , TO_CHAR(A.EFF_DATE_FR, ''DD-MON-YYYY'') EFF_DATE_FR,TO_CHAR(A.EFF_DATE_TO, ''DD-MON-YYYY'') EFF_DATE_TO,
A.AMOUNT ,C.CTC_CATE_ID_DESC ,B.LEAVE_DATE'
    ;
    strFromClause:=
    ' FROM PY_PM_EMPCTCDTL A, PY_GM_EMPMAST B, PY_VW_PM_ALLWDED C ';
    strWhereClause :=
    ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID
AND A.COMP_AID = C.COMP_ID AND A.ALLWDED_AID = C.CTC_CODE
AND A.COMP_AID = '''
    ||pComp_Aid||'''
AND A.COMP_AID = '''||pComp_Aid||
    ''' AND A.EFF_DATE_TO IS NULL
AND NVL(B.LEAVE_DATE,'''||
    pTo_Date||''') BETWEEN TO_DATE('''||pFrom_Date||''') AND TO_DATE('''||
    pTo_Date||''')';
    -- strWhereClause:=strWhereClause||' AND TO_DATE(01||B.PROCESS_MONTH)>='''|
    -- |pFrom_Date||''' AND LAST_DAY(TO_DATE(01||B.PROCESS_MONTH))<='''||
    -- pTo_Date||'''';
    IF TRIM
      (
        pIsMultipleSheet
      )
                     ='Y' THEN
      strWhereClause:=strWhereClause||' AND '||REPLACE
      (
        GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','B.'
      )
      ;
    END IF;
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      --                   strWhereClause:=strWhereClause||chr(13)||' AND
      -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''|
      -- |pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
      -- ||(CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE
      -- pReportID END)||''' AND COMP_AID='''||pComp_Aid||''')';
      strWhereClause:=strWhereClause||chr
      (
        13
      )
      ||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strOrderByClause:=
    ' ORDER BY B.EMP_MID, A.REV_NO,C.CTC_CODE,C.CTC_CATE_ID_DESC) ';
    strSQLClause :=strSQLClause||strSelectClause||strFromClause||strWhereClause
    ||strOrderByClause;
    OPEN Return_Recordset FOR strSQLClause;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
--PROCEDURE CTC_RPT_HORIZONTAL
--  (
--    pComp_Aid            VARCHAR2,
--    pAcc_Year            VARCHAR2,
--    pPay_Month           VARCHAR2,
--    pFrom_Date           VARCHAR2,
--    pTo_Date             VARCHAR2,
--    pUser_Aid            VARCHAR2,
--    pSessionId           VARCHAR2,
--    pReportType          VARCHAR2,
--    pReportID            VARCHAR2,
--    pIsBatchWiseReport   VARCHAR2,
--    pFilterId            VARCHAR2,
--    pIsMultipleSheet     VARCHAR2,
--    pMasterType          VARCHAR2,
--    pMultiSheetCondition VARCHAR2,
--    Return_Recordset OUT REC
--  )
--IS
--TYPE Cur_Recordset
--IS
--  REF
--  CURSOR;
--    Cur_Temp Cur_Recordset;
--    strSqlQuery LONG;
--    strSelect LONG;
--    strFrom LONG;
--    strWhere LONG;
--    strGroupBy LONG;
--    strOrderBy LONG;
--    strCTC_COLUMNS LONG;
--    strCTC_CATE LONG;
--    strNULL_VAL LONG;
--    strNULL LONG;
--    strHEADER_COL LONG;
--    strGetCompName LONG;
--    strGetRptName LONG;
--  BEGIN
--    GET_REPORT_DTL
--    (
--      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
--      strGetCompName,strGetRptName
--    )
--    ;
--    --        Inserting data into Temporary tables
--    IF pIsBatchWiseReport = 'Y' THEN
--      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
--      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
--      -- pIsMultipleSheet,pFilterId);
--      NULL;
--    END IF;
--
--    OPEN Cur_Temp FOR
--    SELECT
--           --WM_CONCAT(CTC_COLUMNS), WM_CONCAT(CTC_CATE),WM_CONCAT(NULL_VAL),WM_CONCAT(HEADER_COL), WM_CONCAT('NULL ' ||'"'||ROW_NUM||'"')
--      LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
--      LISTAGG(CTC_CATE,',') WITHIN GROUP (ORDER BY ROWNUM),
--      LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
--      LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM),
--      LISTAGG('NULL ' ||'"'||ROW_NUM||'"',',') WITHIN GROUP (ORDER BY ROWNUM)
--    FROM
--    (
--      SELECT CTC_COLUMNS,
--             DECODE(ROW_NUMBER() OVER (PARTITION BY CTC_CATE ORDER BY CTC_CATE) ,1,CTC_CATE,'NULL') CTC_CATE,
--             NULL_VAL,HEADER_COL,ROWNUM ROW_NUM
--      FROM
--        (
--          SELECT DISTINCT
--            'SUM(DECODE(TRIM(CTC_MID),'''||B.CTC_MID||''',AMOUNT,0)) "'||SUBSTR(B.CTC_NAME,1,30)||'"' CTC_COLUMNS,
--            B.SORT_ORDER,' '''||C.CTC_CATE_ID_MID||'''' CTC_CATE ,NULL|| ' "'||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')
--            ||'"' NULL_VAL,''''
--            ||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')||'''' HEADER_COL
--          FROM PY_PM_EMPCTCDTL A,PY_CTC_ALLOWANCE_MAST B,PY_VW_PM_ALLWDED C
--          WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_aID =B.CTC_CODE
--            AND A.COMP_AID = pComp_Aid AND A.EFF_DATE_TO IS NULL
--            AND B.COMP_ID = C.COMP_ID  AND B.CTC_CODE = C.CTC_CODE
--          ORDER BY CTC_CATE,SORT_ORDER
--        )
--    );
--    FETCH Cur_Temp INTO strCTC_COLUMNS,strCTC_CATE,strNULL_VAL,strHEADER_COL,strNULL;
--    CLOSE Cur_Temp;
--
--    strSelect:='SELECT
--    ''X#X#X'' REPORT_HEADER1, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
--              NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--              ||strNULL||
--    ',''RH'' REPORT_HEADER, '''||strGetCompName||
--                ''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
--                NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--                ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||
--                ' FROM DUAL
--                UNION ALL
--SELECT ''X#X#X'' REPORT_HEADER1, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
--              NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--              ||strNULL||
--    ',''RH'' REPORT_HEADER, '''
--    ||strGetRptName||
--    ''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
--NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--    ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||
--    ' FROM DUAL
--UNION ALL
--SELECT ''X#X#X'' REPORT_HEADER, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
--              NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--              ||strNULL||
--',''OXO'' REPORT_HEADER,NULL "Employee Id",NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--    ||strCTC_CATE||' FROM DUAL UNION ALL ';
--    strSelect:=strSelect||
--    'SELECT
--    ''X#X#X'' REPORT_HEADER, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
--              NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
--              ||strNULL||
--    ',''DH'' REPORT_HEADER, ''Employee Id'',''Employee Name'', ''Gender'', ''Joining Date'', ''Quit Date'',
--''CTC Effective From Date'',''CTC Effective To Date'','
--    ||strHEADER_COL||' FROM DUAL ';
--    strSelect:=strSelect||
--    ' UNION ALL SELECT * FROM(
--    SELECT ''XD'' REPORT_HEADER1, B.EMP_MID "Employee Id",B.EMP_NAME "Employee Name", B.SEX "Gender", TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') "Joining Date", TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') "Quit Date",
--TO_CHAR(A.EFF_DATE_FR, ''DD-MON-YYYY'') "CTC Effective From Date",TO_CHAR(A.EFF_DATE_TO, ''DD-MON-YYYY'') "CTC Effective To Date",'
--    ;
--
--    strSelect:=strSelect||strCTC_COLUMNS
--    ||',NULL REPORT_HEADER, NULL "Employee Id1",NULL "Employee Name1", NULL "Gender1", NULL "Joining Date1", NULL "Quit Date1",
--    NULL "CTC Effective From Date1",NULL "CTC Effective To Date1",'||strNULL;
--
--    strFrom  :=' FROM PY_PM_EMPCTCDTL A,PY_GM_EMPMAST B, PY_VW_PM_ALLWDED C ';
--    strWhere :=
--    ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.COMP_AID = C.COMP_ID AND A.ALLWDED_AID = C.CTC_CODE '
--    ;
--    strWhere:= strWhere||' AND A.EFF_DATE_TO IS NULL AND A.COMP_AID = '''||
--    pComp_Aid||''' ';
--    --strWhere:=strWhere||' AND B.PAY_MONTH IS NOT NULL AND TO_DATE(01||
--    -- B.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||
--    -- B.PROCESS_MONTH))<='''||pTo_Date||'''';
--    IF TRIM(pIsMultipleSheet) ='Y' THEN
--      strWhere               :=strWhere||' AND '||REPLACE(GET_CONDITION(
--      pMasterType , pMultiSheetCondition),'HD.','B.');
--    END IF;
--    IF pFilterId IS NOT NULL THEN
--      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
--      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
--      ,pFilterId);
--      --                   strWhere:=strWhere||chr(13)||' AND A.EMP_AID IN (
--      -- SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''
--      -- ' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN
--      -- TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||'''
--      -- AND COMP_AID='''||pComp_Aid||''')';
--      strWhere:=strWhere||chr(13)||
--      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
--      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
--      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
--    END IF;
--    strGroupBy:=
--    ' GROUP BY B.EMP_MID ,B.EMP_NAME , B.SEX , B.JOIN_DATE, B.LEAVE_DATE,A.EFF_DATE_FR ,A.EFF_DATE_TO'
--    ;
--    strOrderBy :=' ORDER BY B.EMP_MID)';
--    strSqlQuery:= strSelect||CHR(13)||strFrom||CHR(13)||strWhere||CHR(13)||
--    strGroupBy||CHR(13)||strOrderBy;
--
--
--    OPEN Return_Recordset FOR strSqlQuery;
--    /*Craete Log */
--    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
--    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
--  EXCEPTION
--  WHEN OTHERS THEN
--    /*Craete Log */
--    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
--    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
--    SQLERRM);
--  END;




  PROCEDURE CTC_RPT_HORIZONTAL(

        pComp_Aid            VARCHAR2,
        pAcc_Year            VARCHAR2,
        pPay_Month           VARCHAR2,
        pFrom_Date           VARCHAR2,
        pTo_Date             VARCHAR2,
        pUser_Aid            VARCHAR2,
        pSessionId           VARCHAR2,
        pReportType          VARCHAR2,
        pReportID            VARCHAR2,
        pIsBatchWiseReport   VARCHAR2,
        pFilterId            VARCHAR2,
        pIsMultipleSheet     VARCHAR2,
        pMasterType          VARCHAR2,
        pMultiSheetCondition VARCHAR2,
        Return_Recordset OUT REC
      )
    IS
    TYPE Cur_Recordset
    IS
      REF
      CURSOR;
        Cur_Temp Cur_Recordset;
        strSqlQuery LONG;
        strSelect LONG;
        strFrom LONG;
        strWhere LONG;
        strGroupBy LONG;
        strOrderBy LONG;
        strCTC_COLUMNS LONG;
        strCTC_CATE LONG;
        strNULL_VAL LONG;
        strNULL LONG;
        strHEADER_COL LONG;
        strGetCompName LONG;
        strGetRptName LONG;
      BEGIN
        PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL
        (
          pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
          strGetCompName,strGetRptName
        )
        ;
        --        Inserting data into Temporary tables
        IF pIsBatchWiseReport = 'Y' THEN
          --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
          -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
          -- pIsMultipleSheet,pFilterId);
          NULL;
        END IF;

        OPEN Cur_Temp FOR
        SELECT --WM_CONCAT(CTC_COLUMNS), WM_CONCAT(CTC_CATE),WM_CONCAT(NULL_VAL),WM_CONCAT(HEADER_COL), WM_CONCAT('NULL ' ||'"'||ROW_NUM||'"')
                 LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(CTC_CATE,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG('NULL ' ||'"'||ROW_NUM||'"',',') WITHIN GROUP (ORDER BY ROWNUM)
        FROM
        (
          SELECT CTC_COLUMNS,
                 DECODE(ROW_NUMBER() OVER (PARTITION BY CTC_CATE ORDER BY CTC_CATE) ,1,CTC_CATE,'NULL') CTC_CATE,
                 NULL_VAL,HEADER_COL,ROWNUM ROW_NUM
          FROM
            (
              SELECT DISTINCT
                'SUM(DECODE(TRIM(CTC_MID),'''||B.CTC_MID||''',AMOUNT,0)) "'||SUBSTR(B.CTC_NAME,1,30)||'"' CTC_COLUMNS,
                B.SORT_ORDER,' '''||C.CTC_CATE_ID_MID||'''' CTC_CATE ,NULL|| ' "'||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')
                ||'"' NULL_VAL,''''
                ||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')||'''' HEADER_COL
              FROM PY_PM_EMPCTCDTL A,PY_CTC_ALLOWANCE_MAST B,PY_VW_PM_ALLWDED C
              WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_aID =B.CTC_CODE
                AND A.COMP_AID = pComp_Aid AND A.EFF_DATE_TO IS NULL
                AND B.COMP_ID = C.COMP_ID  AND B.CTC_CODE = C.CTC_CODE
              ORDER BY CTC_CATE,SORT_ORDER
            )
        );
        FETCH Cur_Temp INTO strCTC_COLUMNS,strCTC_CATE,strNULL_VAL,strHEADER_COL,strNULL;
        CLOSE Cur_Temp;

        strSelect:='SELECT
        ''X#X#X'' REPORT_HEADER1, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
                  ||strNULL||
        ',''RH'' REPORT_HEADER, '''||strGetCompName||
                    ''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                    NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
                    ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||
                    ' FROM DUAL
                    UNION ALL
    SELECT ''X#X#X'' REPORT_HEADER1, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
                  ||strNULL||
        ',''RH'' REPORT_HEADER, '''
        ||strGetRptName||
        ''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
    NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
        ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||
        ' FROM DUAL
    UNION ALL
    SELECT ''X#X#X'' REPORT_HEADER, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
                  ||strNULL||
    ',''OXO'' REPORT_HEADER,NULL "Employee Id",NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
        ||strCTC_CATE||' FROM DUAL UNION ALL ';
        strSelect:=strSelect||
        'SELECT
        ''X#X#X'' REPORT_HEADER, NULL "Employee Id", NULL "Employee Name",NULL "Gender", NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER", NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
                  ||strNULL||
        ',''DH'' REPORT_HEADER, ''Employee Id'',''Employee Name'', ''Gender'', ''PHONE NUMBER'', ''AADHAR NUMBER'',''PF NUMBER'', ''UAN NUMBER'', ''Joining Date'', ''Quit Date'',
    ''CTC Effective From Date'',''CTC Effective To Date'','
        ||strHEADER_COL||' FROM DUAL ';
        strSelect:=strSelect||
        ' UNION ALL SELECT * FROM(
        SELECT ''XD'' REPORT_HEADER1, B.EMP_MID "Employee Id",B.EMP_NAME "Employee Name", B.SEX "Gender", NULL "PHONE NUMBER",B.AADHAR_NO "AADHAR NUMBER",B.PPF_NUMBER "PF NUMBER", B.UAN_NO "UAN NUMBER", TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') "Joining Date", TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') "Quit Date",
    TO_CHAR(A.EFF_DATE_FR, ''DD-MON-YYYY'') "CTC Effective From Date",TO_CHAR(A.EFF_DATE_TO, ''DD-MON-YYYY'') "CTC Effective To Date",'
        ;

        strSelect:=strSelect||strCTC_COLUMNS
        ||',NULL REPORT_HEADER, NULL "Employee Id1",NULL "Employee Name1", NULL "Gender1", NULL "PHONE NUMBER1", NULL "AADHAR NUMBER1", NULL "PF NUMBER1", NULL "UAN NUMBER1",NULL "Joining Date1", NULL "Quit Date1",
        NULL "CTC Effective From Date1",NULL "CTC Effective To Date1",'||strNULL;

        strFrom  :=' FROM PY_PM_EMPCTCDTL A,PY_GM_EMPMAST B, PY_VW_PM_ALLWDED C ';
        strWhere :=
        ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.COMP_AID = C.COMP_ID AND A.ALLWDED_AID = C.CTC_CODE '
        ;
        strWhere:= strWhere||' AND A.EFF_DATE_TO IS NULL AND A.COMP_AID = '''||
        pComp_Aid||''' ';
        --strWhere:=strWhere||' AND B.PAY_MONTH IS NOT NULL AND TO_DATE(01||
        -- B.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||
        -- B.PROCESS_MONTH))<='''||pTo_Date||'''';
        IF TRIM(pIsMultipleSheet) ='Y' THEN
          strWhere               :=strWhere||' AND '||REPLACE(PY_PK_STANDARD_REPORT_COMMON.GET_CONDITION(
          pMasterType , pMultiSheetCondition),'HD.','B.');
        END IF;
        IF pFilterId IS NOT NULL THEN
          PY_PK_STANDARD_REPORT_COMMON.INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
          ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
          ,pFilterId);
          --                   strWhere:=strWhere||chr(13)||' AND A.EMP_AID IN (
          -- SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''
          -- ' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN
          -- TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||'''
          -- AND COMP_AID='''||pComp_Aid||''')';
          strWhere:=strWhere||chr(13)||
          ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
          ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
          pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
        END IF;
        strGroupBy:=
        ' GROUP BY B.EMP_MID ,B.EMP_NAME , B.SEX , B.JOIN_DATE, B.LEAVE_DATE, B.PPF_NUMBER,
 B.UAN_NO, B.AADHAR_NO, A.EFF_DATE_FR ,A.EFF_DATE_TO'
        ;
        strOrderBy :=' ORDER BY B.EMP_MID)';
        strSqlQuery:= strSelect||CHR(13)||strFrom||CHR(13)||strWhere||CHR(13)||
        strGroupBy||CHR(13)||strOrderBy;


        OPEN Return_Recordset FOR strSqlQuery;
        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
        pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
      EXCEPTION
      WHEN OTHERS THEN
        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
        pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
        SQLERRM);
  END CTC_RPT_HORIZONTAL;



 PROCEDURE ACTIVE_MASTER_DATA(
        pComp_Aid            VARCHAR2,
        pAcc_Year            VARCHAR2,
        pPay_Month           VARCHAR2,
        pFrom_Date           VARCHAR2,
        pTo_Date             VARCHAR2,
        pUser_Aid            VARCHAR2,
        pSessionId           VARCHAR2,
        pReportType          VARCHAR2,
        pReportID            VARCHAR2,
        pIsBatchWiseReport   VARCHAR2,
        pFilterId            VARCHAR2,
        pIsMultipleSheet     VARCHAR2,
        pMasterType          VARCHAR2,
        pMultiSheetCondition VARCHAR2,
        Return_Recordset OUT REC
      )
    IS
    TYPE Cur_Recordset
    IS
      REF
      CURSOR;
        Cur_Temp Cur_Recordset;
        strSqlQuery LONG;
        strSelect LONG;
        strFrom LONG;
        strWhere LONG;
        strGroupBy LONG;
        strOrderBy LONG;
        strCTC_COLUMNS LONG;
        strCTC_CATE LONG;
        strNULL_VAL LONG;
        strNULL LONG;
        strHEADER_COL LONG;
        strGetCompName LONG;
        strGetRptName LONG;
      BEGIN
        PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL
        (
          pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
          strGetCompName,strGetRptName
        )
        ;
        --        Inserting data into Temporary tables
        IF pIsBatchWiseReport = 'Y' THEN
          --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
          -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
          -- pIsMultipleSheet,pFilterId);
          NULL;
        END IF;

        OPEN Cur_Temp FOR
        SELECT --WM_CONCAT(CTC_COLUMNS), WM_CONCAT(CTC_CATE),WM_CONCAT(NULL_VAL),WM_CONCAT(HEADER_COL), WM_CONCAT('NULL ' ||'"'||ROW_NUM||'"')
                 LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(CTC_CATE,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG('NULL ' ||'"'||ROW_NUM||'"',',') WITHIN GROUP (ORDER BY ROWNUM)
        FROM
        (
          SELECT CTC_COLUMNS,
                 DECODE(ROW_NUMBER() OVER (PARTITION BY CTC_CATE ORDER BY CTC_CATE) ,1,CTC_CATE,'NULL') CTC_CATE,
                 NULL_VAL,HEADER_COL,ROWNUM ROW_NUM
          FROM
            (
              SELECT DISTINCT
                'SUM(DECODE(TRIM(CTC_MID),'''||B.CTC_MID||''',AMOUNT,0)) "'||SUBSTR(B.CTC_NAME,1,30)||'"' CTC_COLUMNS,
                B.SORT_ORDER,' '''||C.CTC_CATE_ID_MID||'''' CTC_CATE ,NULL|| ' "'||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')
                ||'"' NULL_VAL,''''
                ||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')||'''' HEADER_COL
              FROM PY_PM_EMPCTCDTL A,PY_CTC_ALLOWANCE_MAST B,PY_VW_PM_ALLWDED C
              WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_aID =B.CTC_CODE
                AND A.COMP_AID = pComp_Aid AND A.EFF_DATE_TO IS NULL
                AND B.COMP_ID = C.COMP_ID  AND B.CTC_CODE = C.CTC_CODE
              ORDER BY CTC_CATE,SORT_ORDER
            )
        );
        FETCH Cur_Temp INTO strCTC_COLUMNS,strCTC_CATE,strNULL_VAL,strHEADER_COL,strNULL;
        CLOSE Cur_Temp;

        strSelect:='SELECT
        ''X#X#X'' REPORT_HEADER1, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'
                  ||strNULL||
        ',''RH'' REPORT_HEADER, '''||strGetCompName||
                    ''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                    NULL "CTC Effective From Date",NULL "CTC Effective To Date",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'
                    ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||
                    ' FROM DUAL
                    UNION ALL
    SELECT ''X#X#X'' REPORT_HEADER1, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'
                  ||strNULL||
        ',''RH'' REPORT_HEADER, '''
        ||strGetRptName||
        ''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
    NULL "CTC Effective From Date",NULL "CTC Effective To Date",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'
        ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||
        ' FROM DUAL
    UNION ALL
    SELECT ''X#X#X'' REPORT_HEADER, NULL "Employee Id", NULL "Employee Name",NULL "Gender",NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'
                  ||strNULL||
    ',''OXO'' REPORT_HEADER,NULL "Employee Id",NULL "Employee Name",NULL "Gender",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER",NULL,NULL, NULL "UAN NUMBER",NULL "Joining Date",NULL "Quit Date",NULL "CTC Effective From Date",NULL "CTC Effective To Date",'
        ||strCTC_CATE||' FROM DUAL UNION ALL ';
        strSelect:=strSelect||
        'SELECT
        ''X#X#X'' REPORT_HEADER, NULL "Employee Id", NULL "Employee Name",NULL "Gender", NULL "PHONE NUMBER", NULL "AADHAR NUMBER", NULL "PF NUMBER", NULL "UAN NUMBER", NULL "Joining Date",NULL "Quit Date",
                  NULL "CTC Effective From Date",NULL "CTC Effective To Date",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'
                  ||strNULL||
        ',''DH'' REPORT_HEADER, ''Employee Code'',''Employee Name'',  ''Join Date'',
         ''DESIGNATION_CODE'', ''DEPARTMENT_CODE'', ''GRADE_CODE'', ''BAND_CODE'', ''COSTCENTER_CODE'',
         ''GENDER'', ''OFFICIAL_EMAIL_ADDRESS'', ''BIRTH_DATE'', ''PAN_NUMBER'', ''BANK_CODE'', ''BANK_ACCOUNT_NO'',
        ''PHONE NUMBER'', ''AADHAR NUMBER'',
        ''PF NUMBER'', ''UAN NUMBER'', ''Quit Date'',
    ''CTC Effective From Date'',''CTC Effective To Date'',
        '||strHEADER_COL||' , ''GROSS'',''CTC'' FROM DUAL ';
        strSelect:=strSelect||
        ' UNION ALL SELECT * FROM(
        SELECT ''XD'' REPORT_HEADER1, B.EMP_MID "Employee Id",B.EMP_NAME "Employee Name", TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') "Joining Date",
         B.DESG_DESC "DESIGNATION_CODE",B.DEPT_DESC "DEPARTMENT_CODE",B.GRADE_DESC "GRADE_CODE",
         B.BAND_DESC "BAND_CODE",B.CC_DESC "COSTCENTER_CODE",B.SEX "GENDER",B.CORRESPONDENCE_EMAIL1 "OFFICIAL_EMAIL_ADDRESS",
        B.BIRTH_DATE "BIRTH_DATE",B.PAN_NUMBER "PAN_NUMBER",B.BANK_DESC "BANK_CODE",B.BANK_ACCOUNT_NO "BANK_ACCOUNT_NO",
        NULL "PHONE NUMBER",B.AADHAR_NO "AADHAR NUMBER",B.PPF_NUMBER "PF NUMBER", B.UAN_NO "UAN NUMBER",
        TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') "Quit Date",
    TO_CHAR(A.EFF_DATE_FR, ''DD-MON-YYYY'') "CTC Effective From Date",TO_CHAR(A.EFF_DATE_TO, ''DD-MON-YYYY'') "CTC Effective To Date",'
        ;

        strSelect:=strSelect||strCTC_COLUMNS
        ||' ,SUM(CASE WHEN CTC_MID IN(''BAS'',''HRA'',''CNN'',''SPA'',''PA'',''FLXP'',''STI'',''LTE'',''ATTR'',''PET'',''COMI'') THEN AMOUNT ELSE 0 END) "GROSS",
    SUM(CASE WHEN CTC_MID IN(''PERBNA'',''GRT'',''EXG'',''ESE'',''SPE'',''LTA'',''BAS'',''HRA'',''CNN'',''SPA'',''PA'',''FLXP'',''STI'',''LTE'',''ATTR'',''PET'',''COMI'') THEN AMOUNT ELSE 0 END)  "CTC",
    NULL REPORT_HEADER,  NULL "Employee Code1",NULL "Employee Name1",NULL "Joining Date1",NULL DESIGNATION_CODE1,
          NULL DEPARTMENT_CODE1,NULL GRADE_DESC1,NULL "BAND_DESC1",NULL "CC_DESC1",
          NULL "Gender1",NULL "CORRESPONDENCE_EMAIL11",NULL "BIRTH_DATE1",NULL "PAN_NUMBER1",NULL "BANK_DESC1",
          NULL "BANK_ACCOUNT_NO1", NULL "PHONE NUMBER1", NULL "AADHAR NUMBER1", NULL "PF NUMBER1", NULL "UAN NUMBER1", NULL "Quit Date1",
          NULL "CTC Effective From Date1",NULL "CTC Effective To Date1",NULL "GROSS1",
    NULL "CTC1",'||strNULL;

        strFrom  :=' FROM PY_PM_EMPCTCDTL A,PY_GM_EMPMAST B, PY_VW_PM_ALLWDED C ';
        strWhere :=
        ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.COMP_AID = C.COMP_ID AND A.ALLWDED_AID = C.CTC_CODE   AND B.LEAVE_DATE IS NULL '
        ;
        strWhere:= strWhere||' AND A.EFF_DATE_TO IS NULL AND A.COMP_AID = '''||
        pComp_Aid||''' ';
        --strWhere:=strWhere||' AND B.PAY_MONTH IS NOT NULL AND TO_DATE(01||
        -- B.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||
        -- B.PROCESS_MONTH))<='''||pTo_Date||'''';
        IF TRIM(pIsMultipleSheet) ='Y' THEN
          strWhere               :=strWhere||' AND '||REPLACE(PY_PK_STANDARD_REPORT_COMMON.GET_CONDITION(
          pMasterType , pMultiSheetCondition),'HD.','B.');
        END IF;
        IF pFilterId IS NOT NULL THEN
          PY_PK_STANDARD_REPORT_COMMON.INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
          ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
          ,pFilterId);
          --                   strWhere:=strWhere||chr(13)||' AND A.EMP_AID IN (
          -- SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''
          -- ' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN
          -- TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||'''
          -- AND COMP_AID='''||pComp_Aid||''')';
          strWhere:=strWhere||chr(13)||
          ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
          ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
          pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
        END IF;
        strGroupBy:=
        ' GROUP BY B.EMP_MID ,B.EMP_NAME , B.SEX , B.JOIN_DATE, B.LEAVE_DATE, B.PPF_NUMBER,  B.DESG_DESC ,
    B.DEPT_DESC ,
    B.BAND_DESC,
    B.GRADE_DESC ,
    B.CC_DESC ,
    B.CORRESPONDENCE_EMAIL1 ,
    B.BIRTH_DATE ,
    B.PAN_NUMBER ,
    B.BANK_DESC ,
    B.BANK_ACCOUNT_NO,B.UAN_NO, B.AADHAR_NO, A.EFF_DATE_FR ,A.EFF_DATE_TO'
        ;
        strOrderBy :=' ORDER BY B.EMP_MID)';
        strSqlQuery:= strSelect||CHR(13)||strFrom||CHR(13)||strWhere||CHR(13)||
        strGroupBy||CHR(13)||strOrderBy;
--    DBMS_OUTPUT.PUT_LINE(strSqlQuery);

        OPEN Return_Recordset FOR strSqlQuery;
        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
        pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
      EXCEPTION
      WHEN OTHERS THEN
        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
        pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
        SQLERRM);
  END ACTIVE_MASTER_DATA;




PROCEDURE ALLOWANCE_DEDUCT_SUMMARY_RPT(
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
IS
  strSqlQuery LONG;
  strSelect LONG;
  strFrom LONG;
  strWhere LONG;
  strGroupBy LONG;
  strOrderBy LONG;
  strBatchSelect LONG;
  /*for batch wise report*/
  strBatchWhere LONG;
  /*    -||-      */
  strBatchGroupBy LONG;
  /*    -||-      */
  strBatchOrderBy LONG;
  /*    -||-      */
  strUnion1 LONG;
  /* UNION QUERY 1*/
  strUnion2 LONG;
  /* UNION QUERY 2*/
  strBatchForRH LONG;
  strBatchForDH LONG;
  strGetCompName VARCHAR2(4000);
  strGetRptName  VARCHAR2(4000);
  strSelectClause LONG;
BEGIN
  GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date
  ,strGetCompName,strGetRptName);
  --Inserting data into Temporary tables
  IF pIsBatchWiseReport = 'Y' THEN
    --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
    -- ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
    -- pIsMultipleSheet,pFilterId);
    NULL;
    NULL;
    strBatchForRH  :='NULL,';
    strBatchForDH  :='''BATCH ID'',';
    strBatchSelect := 'BATCH_ID,';
    strBatchWhere  :=
    ' AND BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
    ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
    strBatchGroupBy := ' BATCH_ID,';
    strBatchOrderBy := ' BATCH_ID,';
  END IF;
  IF pReportType='Excel' THEN
    --        strSelect := 'SELECT "REPORT_HEADER",'||REPLACE(strBatchSelect,''
    -- '','"') ||'"PAY MONTH","ALLOWANCE DESCRIPTION", "AMOUNT" FROM
    --                            (
    --                            SELECT "REPORT_HEADER", PAY_MONTH "PAY MONTH"
    -- ,'||REPLACE(strBatchSelect,',',' ')||' '||REPLACE(strBatchSelect,'''','"
    -- ')||'ALLWDED_DESC "ALLOWANCE DESCRIPTION", AMOUNT "AMOUNT" FROM (SELECT
    -- ''AC'' "REPORT_HEADER", ';
    strSelectClause :=
    'SELECT ''X#X#X'' REPORT_HEADER, null, null,null ,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''', null, null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null, null,null,
''RH'' REPORT_HEADER,'''
    ||strGetRptName||
    ''', null, null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null ,null, null,
''DH'' REPORT_HEADER1, ''PAY MONTH'',''ALLOWANCE DESCRIPTION '' ,''AMOUNT'' FROM DUAL UNION ALL '
    ;
    strSelect :=' SELECT * FROM (SELECT 1 ROWNO,''AC'' "REPORT_HEADER", ';
    strSelect := strSelect||strBatchSelect||
    ' PAY_MONTH,ALLWDED_DESC,SUM(AMOUNT) AMOUNT,CTC_TYPE,
NULL "REPORT_HEADER1",NULL "PAY_MONTH1",NULL "ALLWDED_DESC1",NULL "AMOUNT1" '
    ;
    strFrom  := ' FROM PY_VW_EMPLOYEE_SALARY A';
    strWhere := ' WHERE ';
    strWhere := strWhere || ' A.COMP_ID='''||pComp_Aid||''' AND A.ACC_YEAR='''
    ||pAcc_Year||''' AND ARR_FLAG<>''F'' ';
    strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
    ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
    ''' AND A.PAY_MONTH IS NOT NULL';
    strWhere := strWhere ||strBatchWhere;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      strWhere:=strWhere||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy := ' GROUP BY ';
    strGroupBy := strGroupBy||strBatchGroupBy||
    ' PAY_MONTH,ALLWDED_DESC,CTC_TYPE';
    strUnion1:=' UNION ALL SELECT 2 ROWNO,''DH'' "REPORT_HEADER", '||
    strBatchSelect||
    ' PAY_MONTH,''TOTAL OF ''||DECODE(CTC_TYPE,''A'',''ALLOWANCES'',''DEDUCTIONS'') ALLWDED_DESC,SUM(AMOUNT),CTC_TYPE,
NULL "REPORT_HEADER1",NULL "PAY_MONTH1",NULL "ALLWDED_DESC1",NULL "AMOUNT1" '
    ;
    strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
    ' CTC_TYPE,PAY_MONTH';
    strUnion2:=' UNION ALL SELECT ''DH'' "REPORT_HEADER",NULL,'||strBatchSelect
    ||
    '''NET SALARY'' ALLWDED_DESC,SUM(DECODE(CTC_TYPE,''A'',AMOUNT,0))-SUM(DECODE(CTC_TYPE,''D'',AMOUNT,0)),
NULL "REPORT_HEADER1",NULL "PAY_MONTH1",NULL "ALLWDED_DESC1",NULL "AMOUNT1" '
    ;
    strUnion2:=strUnion2||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
    ' PAY_MONTH';
    strOrderBy := ') ORDER BY ';
    strOrderBy := strOrderBy||'CTC_TYPE,ROWNO';
    strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy;
    strSqlQuery:=strSqlQuery||strUnion1||strOrderBy;
    strSqlQuery:=strSelectClause||
    'SELECT "REPORT_HEADER",PAY_MONTH,ALLWDED_DESC, AMOUNT,
"REPORT_HEADER1","PAY_MONTH1","ALLWDED_DESC1","AMOUNT1" FROM ('
    || strSqlQuery||') '||strUnion2;
  ELSE
    strSqlQuery:=
    'SELECT ALLWDED_DESC "ALLOWANCE DESCRIPTION", AMOUNT "AMOUNT"
FROM (SELECT  PAY_MONTH,CTC_TYPE,ALLWDED_DESC,SUM(AMOUNT) AMOUNT,NVL(A.SORT_ORDER,9999999) SORT_ORDER
FROM PY_VW_EMPLOYEE_SALARY A WHERE  A.COMP_ID='''
    ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||
    ''' AND ARR_FLAG<>''F''
AND A.PROC_DATE>='''||
    pFrom_Date||''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
    ''' AND A.PAY_MONTH IS NOT NULL
GROUP BY  PAY_MONTH,CTC_TYPE,ALLWDED_DESC,A.SORT_ORDER
UNION ALL
SELECT  PAY_MONTH,CTC_TYPE,''TOTAL OF ''||DECODE(CTC_TYPE,''A'',''ALLOWANCES'',''DEDUCTIONS'') ALLWDED_DESC,SUM(AMOUNT),NULL
FROM PY_VW_EMPLOYEE_SALARY A
WHERE  A.COMP_ID='''
    ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||
    ''' AND ARR_FLAG<>''F''
AND A.PROC_DATE>='''||
    pFrom_Date||''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
    ''' AND A.PAY_MONTH IS NOT NULL
GROUP BY  PAY_MONTH,CTC_TYPE
UNION ALL
SELECT PAY_MONTH,NULL,''NET SALARY'' ALLWDED_DESC,SUM(DECODE(CTC_TYPE,''A'',AMOUNT,0))-SUM(DECODE(CTC_TYPE,''D'',AMOUNT,0)) ,NULL
FROM PY_VW_EMPLOYEE_SALARY A
WHERE  A.COMP_ID='''
    ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||
    ''' AND ARR_FLAG<>''F''
AND A.PROC_DATE>='''||
    pFrom_Date||''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
    ''' AND A.PAY_MONTH IS NOT NULL
GROUP BY  PAY_MONTH)
ORDER BY  TO_DATE(01||PAY_MONTH),CTC_TYPE,SORT_ORDER,ALLWDED_DESC '
    ;
  END IF;

  OPEN Return_Recordset FOR strSqlQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END;
PROCEDURE BANK_PAYORDER_RPT(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strGetCompName VARCHAR2(4000);
    strGetRptName  VARCHAR2(4000);
    vPrev_Pay_Month LONG;
    strSqlQuery LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strMainQuery LONG;
    strBatchQuery LONG;
    strHeadQuery LONG;
    strSelectClauseBatch LONG;
    vFlag           VARCHAR2(1);
    strReportHeader VARCHAR2(4000);
    strHeaderGroupByClause LONG;
  BEGIN
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
    pTo_Date,strGetCompName,strGetRptName);
    IF pIsBatchWiseReport = 'Y' THEN
      strBatchQuery      :='NULL,';
      strHeadQuery       :='"BATCH ID",';
    END IF;
    --Inserting data into Temporary tables
    --            IF pIsBatchWiseReport = 'Y' THEN
    --                INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,
    -- pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
    -- pReportID,pIsMultipleSheet);
    --            END IF;
    vPrev_Pay_Month:=TO_CHAR(to_date(01||pPay_Month)-1,'MON YYYY');
    --MASTER COLUMNNS
    IF pMultiSheetCondition != 'SUMMARY' THEN
      --
      strSqlQuery:='SELECT ''X#X#X'' REPORT_SECTION,'||REPLACE(strBatchQuery,
      ',',' ')||strHeadQuery||
      'NULL comp_name,NULL a,NULL b,NULL c,
''RH'' REPORT_SECTION,'
      ||REPLACE(strBatchQuery,',',' ')||strHeadQuery||''''|| strGetCompName ||
      ''' comp_name,NULL a,NULL b,NULL c FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_SECTION,'
      ||strBatchQuery||
      'NULL ,NULL,NULL,NULL,
''RH'' REPORT_SECTION,'
      ||strBatchQuery||''''|| strGetRptName ||
      ''' ,NULL,NULL,NULL FROM DUAL
UNION ALL
SELECT * FROM ( SELECT REPORT_SECTION,'
      ||strHeadQuery||'"CODE","NAME","ACCOUNT NO.","AMOUNT",REPORT_SECTION1,'||
      strHeadQuery||
      '"CODE1","NAME1","ACCOUNT NO.1",TO_CHAR("AMOUNT1") "AMOUNT1" FROM (SELECT  DISTINCT 2 ROW_NUM,''X#X#X'' REPORT_SECTION ,'
      ;
      --strSqlQuery:='SELECT ';
      IF pIsBatchWiseReport  = 'Y' THEN
        strSelectClauseBatch:= 'A.BATCH_ID AS "BATCH ID", ';
        strGroupByClause    :=strGroupByClause ||'A.BATCH_ID, ';
      END IF;
      --            IF pIsBatchWiseReport = 'Y' THEN
      --               strExSelectClause:='A.BATCH_ID AS "BATCH ID", ';
      --               strExGroupByClause:='A.BATCH_ID, ';
      --            END IF;
      strSelectClause :=REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
      'BANK_AID,null,''BANK NAME : '' || DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC) "CODE",NULL "NAME",NULL "ACCOUNT NO.",NULL "AMOUNT",
''RH'' REPORT_SECTION1 ,'
      ||REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
      'BANK_AID aid,null,''BANK NAME : '' || DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC) "CODE1",NULL "NAME1",NULL "ACCOUNT NO.1",NULL "AMOUNT1"'
      ;
      strFromClause :=' FROM PY_PT_SAL_HD A';
      strWhereClause:=' WHERE COMP_AID='''||pComp_Aid||''' AND ACC_YEAR='''||
      pAcc_Year||''' AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||
      ''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date ||
      '''
AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0'
      ;
      --strWhereClause:=' WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS('''||
      -- pTo_Date||''',-1) AND '''|| pTo_Date || '''';
      IF pIsBatchWiseReport='Y' THEN
        strWhereClause    :=strWhereClause||chr(13)||
        ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
      END IF;
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
        pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
        pIsMultipleSheet,pFilterId);
        strWhereClause:=strWhereClause||chr(13)||
        ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      IF TRIM(pIsMultipleSheet) ='Y' THEN
        strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION
        (pMasterType , pMultiSheetCondition),'HD.','A.');
      END IF;
      strGroupByClause:=
      ' UNION ALL SELECT DISTINCT 2 ROW_NUM,''X#X#X'' REPORT_SECTION ,'||
      REPLACE(REPLACE(strHeadQuery,',',' '),'"','''')||' '||strHeadQuery||
      'A.BANK_AID,null a,NULL b, NULL c,NULL d,NULL e,''DH'' REPORT_SECTION1 ,'
      ||REPLACE(REPLACE(strHeadQuery,',',' '),'"','''')||' '||strHeadQuery||
      'A.BANK_AID ,''BANK NAME'',''CODE'', ''NAME'',''ACCOUNT NO.'',''AMOUNT'' FROM PY_PT_SAL_HD A'
      ||strWhereClause||
      '
UNION ALL
SELECT 4 ROW_NUM,''AC'' REPORT_SECTION ,'
      ||strSelectClauseBatch||
      'bank_aid,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,''PAYORDER'',A.BANK_DESC) "BANK NAME",A.EMP_MID "CODE",A.EMP_NAME "NAME",A.BANK_ACCOUNT_NO "ACCOUNT NO.",A.TNET_AMT "AMOUNT",
null REPORT_SECTION1 ,'
      ||strSelectClauseBatch||
      'bank_aid aid,null "BANK NAME1",null "CODE1",null "NAME1",null "ACCOUNT NO.1",null "AMOUNT1"
FROM PY_PT_SAL_HD A '
      || strWhereClause ||
      ' UNION ALL
SELECT DISTINCT 6 ROW_NUM, ''AC'' REPORT_SECTION ,'
      ||strBatchQuery||
      ' BANK_AID ,null a ,NULL b,NULL c,NULL d,NULL e,null REPORT_SECTION1 ,'||
      strBatchQuery||' BANK_AID aid,null aa,NULL bb,NULL cc,NULL dd,NULL ee '||
      strFromClause||strWhereClause||
      '
UNION ALL
SELECT DISTINCT 5 ROW_NUM,
''DH'' REPORT_SECTION1 ,BANK_AID aid, NULL a,''HEAD COUNT : '' || COUNT(A.EMP_MID),NULL b,NULL b,SUM(A.TNET_AMT) "AMOUNT1"
,null REPORT_SECTION ,BANK_AID, NULL,null,NULL,NULL,null "AMOUNT"'
      ||strFromClause||strWhereClause||
      ' group by BANK_AID
)
ORDER BY BANK_AID,ROW_NUM,REPORT_SECTION1 DESC
)'
      ;
      strHeaderGroupByClause:=
      ' UNION ALL SELECT DISTINCT 2 ROW_NUM,''DH'' REPORT_SECTION ,'||REPLACE(
      REPLACE(strHeadQuery,',',' '),'"','''')||' '||strHeadQuery||
      'A.BANK_AID,''BANK NAME'',''CODE'', ''NAME'',''ACCOUNT NO.'',''AMOUNT''  FROM PY_PT_SAL_HD A'
      ||strWhereClause||
      '
UNION ALL
SELECT 4 ROW_NUM,null REPORT_SECTION ,'
      ||strSelectClauseBatch||
      'bank_aid,null "BANK NAME",null "CODE",null "NAME",null "ACCOUNT NO.",null "AMOUNT"
FROM PY_PT_SAL_HD A '
      || strWhereClause ||
      ' UNION ALL
SELECT DISTINCT 6 ROW_NUM, null REPORT_SECTION ,'
      ||strBatchQuery||' BANK_AID,null,NULL,NULL,NULL,NULL '||strFromClause||
      strWhereClause||
      '
UNION ALL
SELECT DISTINCT 5 ROW_NUM, ''DH'' REPORT_SECTION ,BANK_AID, NULL,''HEAD COUNT : '' || COUNT(A.EMP_MID),NULL,NULL,TO_CHAR(SUM(A.TNET_AMT)) "AMOUNT" '
      ||strFromClause||strWhereClause||
      ' group by BANK_AID
)
ORDER BY BANK_AID,ROW_NUM,REPORT_SECTION DESC
)'
      ;
      strReportHeader:='SELECT ''RH'' REPORT_SECTION,'||REPLACE(strBatchQuery,
      ',',' ')||strHeadQuery||''''|| strGetCompName ||
      ''' comp_name,NULL a,NULL b,NULL c FROM DUAL
UNION ALL
SELECT ''RH'' REPORT_SECTION,'
      ||strBatchQuery||''''|| strGetRptName ||
      ''' ,NULL,NULL,NULL FROM DUAL
UNION ALL
SELECT * FROM ( SELECT REPORT_SECTION,'
      ||strHeadQuery||
      '"CODE","NAME","ACCOUNT NO.",TO_CHAR("AMOUNT") "AMOUNT" FROM (SELECT  DISTINCT 2 ROW_NUM,''RH'' REPORT_SECTION ,'
      ||REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
      'BANK_AID,null,''BANK NAME : '' || DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC) "CODE",NULL "NAME",NULL "ACCOUNT NO.",NULL "AMOUNT"
'
      ||strFromClause||strWhereClause||strHeaderGroupByClause;
      strMainQuery:= strSqlQuery||strSelectClause||strFromClause||
      strWhereClause||strGroupByClause;
    ELSE
      strSqlQuery:='SELECT ''X#X#X'' REPORT_SECTION,'||REPLACE(strBatchQuery,
      ',',' ')||strHeadQuery||''''|| strGetCompName ||
      ''' CN ,NULL A,NULL B,
''RH'' REPORT_SECTION1,'
      ||REPLACE(strBatchQuery,',',' ')||strHeadQuery||''''|| strGetCompName ||
      ''' CN1,NULL A1,NULL B1 FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_SECTION,'
      ||strBatchQuery||''''|| strGetRptName ||
      ''' ,NULL,NULL,
''RH'' REPORT_SECTION1,'
      ||strBatchQuery||''''|| strGetRptName ||
      ''' ,NULL,NULL FROM DUAL
UNION ALL
SELECT ''X#X#X'' ,NULL,NULL,NULL,''DH'' ,''BANK NAME'',''HEAD COUNT'',''NET'' FROM DUAL
UNION ALL
SELECT * FROM ( SELECT REPORT_SECTION,'
      ||strHeadQuery||
      '"BANK NAME","HEAD COUNT","NET"
,REPORT_SECTION1,'
      ||strHeadQuery||
      '"BANK NAME1","HEAD COUNT1","NET1" FROM (SELECT  ''AC'' REPORT_SECTION ,'
      ;
      --strSqlQuery:='SELECT ';
      IF pIsBatchWiseReport  = 'Y' THEN
        strSelectClauseBatch:= 'A.BATCH_ID AS "BATCH ID", ';
        strGroupByClause    :=strGroupByClause ||'A.BATCH_ID, ';
      END IF;
      --            IF pIsBatchWiseReport = 'Y' THEN
      --               strExSelectClause:='A.BATCH_ID AS "BATCH ID", ';
      --               strExGroupByClause:='A.BATCH_ID, ';
      --            END IF;
      strSelectClause :=REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
      ' DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC) "BANK NAME",COUNT(A.EMP_MID) "HEAD COUNT",SUM(A.TNET_AMT) "NET",
NULL REPORT_SECTION1,'
      ||REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
      ' NULL "BANK NAME1",NULL "HEAD COUNT1",NULL "NET1"';
      strFromClause :=' FROM PY_PT_SAL_HD A';
      strWhereClause:=' WHERE COMP_AID='''||pComp_Aid||''' AND ACC_YEAR='''||
      pAcc_Year||''' AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||
      ''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date ||
      '''
AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0'
      ;
      --strWhereClause:=' WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS('''||
      -- pTo_Date||''',-1) AND '''|| pTo_Date || '''';
      IF pIsBatchWiseReport='Y' THEN
        strWhereClause    :=strWhereClause||chr(13)||
        ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
      END IF;
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
        pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
        pIsMultipleSheet,pFilterId);
        strWhereClause:=strWhereClause||chr(13)||
        ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      strGroupByClause:=
      ' GROUP BY BANK_AID,DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC)
ORDER BY 1
)UNION ALL
SELECT ''DH'' "REPORT_HEADER",''TOTAL'' "TOTAL1", COUNT(EMP_MID) "HEAD COUNT1",SUM(TNET_AMT) "NET1",
null "REPORT_HEADER1",null, null "HEAD COUNT",null "NET" '

      ||strFromClause||strWhereClause||')';

      strHeaderGroupByClause:=
      ' GROUP BY BANK_AID,DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC)
ORDER BY 1
)UNION ALL
SELECT ''DH'' "REPORT_HEADER",''TOTAL'', TO_CHAR(COUNT(EMP_MID)) "HEAD COUNT",TO_CHAR(SUM(TNET_AMT)) "NET" '
      ||strFromClause||strWhereClause||')';
      strReportHeader:='SELECT ''RH'' REPORT_SECTION,'||REPLACE(strBatchQuery,
      ',',' ')||strHeadQuery||''''|| strGetCompName ||
      ''' CN,NULL A,NULL B FROM DUAL
UNION ALL
SELECT ''RH'' REPORT_SECTION,'
      ||strBatchQuery||''''|| strGetRptName ||
      ''' ,NULL,NULL FROM DUAL
UNION ALL
SELECT ''DH'' ,''BANK NAME'',''HEAD COUNT'',''NET'' FROM DUAL
UNION ALL
SELECT * FROM ( SELECT REPORT_SECTION,'
      ||strHeadQuery||
      '"BANK NAME","HEAD COUNT","NET" FROM (SELECT  NULL REPORT_SECTION , '
      ||REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
      ' NULL "BANK NAME",NULL "HEAD COUNT",NULL "NET"'
      ||strFromClause||strWhereClause||strHeaderGroupByClause;
      strMainQuery:= strSqlQuery||strSelectClause||strFromClause||
      strWhereClause||strGroupByClause;

    END IF;
    --        strMainQuery:= strSqlQuery||strSelectClause||strFromClause||
    -- strWhereClause||strGroupByClause;

    OPEN Return_Recordset FOR strMainQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
  END ;
PROCEDURE INVESTMENT_RPT(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strInvestments LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strBatchSelect LONG;
    strBatchWhere LONG;
    strBatchGroupBy LONG;
    strBatchOrderBy LONG;
    strInvestHeads LONG;
    strNullHead LONG;
    strSqlQuery1 LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    vCount NUMBER;
    str12CHead LONG;
    strSelectClause1 LONG;
    strSelectClause2 LONG;
    strselect LONG;
    vCount1 NUMBER;
    strInvestmentsDesc LONG;
  BEGIN
    vCount1:= 1;
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
    pTo_Date,strGetCompName,strGetRptName);
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --            --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,
      -- pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
      -- pIsMultipleSheet);
      strBatchSelect := 'BATCH_ID,';
      strBatchWhere  :=
      ' AND BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    strInvestHeads := ' ,''AC'' REPORT_HEADER1,'||REPLACE(strBatchSelect,
    'BATCH_ID','NULL "BATCH_ID"')||
    ' NULL "CODE", NULL "EMPLOYEE NAME",NULL "JOIN DATE",NULL "LEAVE DATE",NULL "PAN NUMBER",NULL "DESIGNATION",NULL "DEPARTMENT",NULL "BRANCH",NULL "LOCATION"'
    ;
    strSqlQuery     :='SELECT ';
    strSelectClause :=
    'NULL "REPORT_HEADER",TO_CHAR(C.EMP_MID) "CODE",C.EMP_NAME "EMPLOYEE NAME",TO_CHAR(C.JOIN_DATE,''DD-MON-YYYY'') "JOIN DATE",TO_CHAR(LEAVE_DATE,''DD-MON-YYYY'') "LEAVE DATE",PAN_NUMBER "PAN NUMBER",DESG_DESC "DESIGNATION",DEPT_DESC "DEPARTMENT",BR_DESC "BRANCH",LOC_DESC "LOCATION"'
    ;
    strGroupByClause:=
    'TO_CHAR(C.EMP_MID),C.EMP_NAME,C.EMP_AID,C.JOIN_DATE,LEAVE_DATE,PAN_NUMBER,BANK_ACCOUNT_NO,GRADE_DESC,DESG_DESC,DEPT_DESC,BR_DESC,LOC_DESC,BANK_DESC,CC_DESC,CHANNEL_DESC '
    ;
    -- strOrderByClause:= ' ORDER BY C.EMP_MID ';
    FOR I IN
    (
      SELECT DISTINCT
        ',ROUND(SUM(DECODE(TRIM(B.INV_MID),'''
        ||TRIM(PM.INV_MID)
        ||''',A.DEC_AMOUNT,0)),2) AS "DECLARE AMT"' INV_DECLARE ,
        ',ROUND(SUM(DECODE(TRIM(B.INV_MID),'''
        ||TRIM(PM.INV_MID)
        ||''',A.SUP_AMOUNT,0)),2) AS "SUPPORT AMT" ' INV_SUPPORT,
        PM.INV_DESC
      FROM
        PY_PT_INVESTMENT PT,
        PY_PM_INVESTMENT PM
      WHERE
        PT.COMP_AID                    =PM.COMP_AID
      AND PT.INV_AID                   =PM.INV_AID
      AND PT.COMP_AID                  =pComp_Aid
      AND PT.ACC_YEAR                  =pAcc_Year
      AND PM.EFF_FROM_DATE            <=pFrom_Date
      AND NVL(PM.EFF_TO_DATE,pTo_Date)>=pTo_Date
      ORDER BY
        PM.INV_DESC
    )
  LOOP
    IF TRIM(INSTR(strSelectClause,TRIM(I.INV_DECLARE)))=0 THEN
      strInvestHeads := strInvestHeads||',''DECLARE AMOUNT'' AS "'||TRIM(SUBSTR(I.INV_DESC,1,30))
                                      ||'", ''SUPPORT AMOUNT'' AS "'||TRIM(SUBSTR(I.INV_DESC,1,29))||' " ';

      strInvestments := strInvestments ||I.INV_DECLARE||I.INV_SUPPORT||CHR(13);
      --                             strInvestmentsDesc :=strInvestmentsDesc||'
      -- ,"'||TRIM(SUBSTR(I.INV_DESC,1,30))||vCount1||'"' ;
      strInvestmentsDesc :=strInvestmentsDesc||',"'||TRIM(SUBSTR(I.INV_DESC,1,30))
                                             ||'_DECLARE"' ;

      strInvestmentsDesc :=strInvestmentsDesc||',"'||TRIM(SUBSTR(I.INV_DESC,1,30))||'_SUPPORT"' ;

      strNullHead:= strNullHead||',NULL "'||vCount1||'_1"';
      vCount1    :=vCount1+1;
      --                              strInvestmentsDesc :=strInvestmentsDesc||
      -- ',"'||TRIM(SUBSTR(I.INV_DESC,1,30))||vCount1||'"';
      strNullHead:= strNullHead ||',NULL "'||vCount1||'_1"';
    END IF;
    --                         vCount1:=vCount1-1;
    vCount1 :=vCount1+1;
  END LOOP;

  strSqlQuery1 := 'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null,null,null,null,null,null'
                  ||strNullHead||',
                  ''RH'' REPORT_HEADER1,'''||strGetCompName||''',null ,null,null,null,null,null,null,null'
                  ||STRNULLHEAD||
                  ' FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null,null,null,null,null,null'
                  ||strNullHead||',
                  ''RH'' REPORT_HEADER, '''||strGetRptName||''',null,null,null,null,null,null,null,null'
                  ||strNullHead||
                  ' FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null,null,null,null,null,null'
                  ||strNullHead||
                  ',''DH'' REPORT_HEADER1, ''EMPLOYEE CODE'',''EMPLOYEE NAME'' ,''JOIN DATE'', ''LEAVE DATE'',''PAN NUMBER'',
                  ''DESIGNATION'',''DEPARTMENT'',''BRANCH'',''LOCATION'''
                  ||REPLACE(strInvestmentsDesc,'"','''')||'
                  FROM DUAL
                  UNION ALL ';

  strSelectClause1 := ' ''X#X#X'' "REPORT_HEADER",NULL "CODE1", NULL "EMPLOYEE NAME1",NULL "JOIN DATE1",NULL "LEAVE DATE1",
                        NULL "PAN NUMBER1",NULL "DESIGNATION1",NULL "DEPARTMENT1",NULL "BRANCH1",NULL "LOCATION1" '
                        ||STRNULLHEAD||'';

  strSelectClause2 := ' ,NULL "REPORT_HEADER",NULL "CODE1", NULL "EMPLOYEE NAME1",NULL "JOIN DATE1",NULL "LEAVE DATE1",
                          NULL "PAN NUMBER1",NULL "DESIGNATION1",NULL "DEPARTMENT1",NULL "BRANCH1",NULL "LOCATION1" '
                          ||STRNULLHEAD||'';
  --  Total Gross ,Deduction and Net Salary
  strSelectClause:=strSelectClause||strInvestments;

  strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause))-1);

  strGroupByClause:=' GROUP BY '||strBatchGroupBy||TRIM(strGroupByClause);

  STRFROMCLAUSE   :=' FROM PY_PT_INVESTMENT A,PY_PM_INVESTMENT B, PY_GM_EMPMAST C ';

  strWhereClause:=' WHERE A.COMP_AID=B.COMP_AID AND A.INV_AID=B.INV_AID AND A.COMP_AID=C.COMP_AID AND A.EMP_AID=C.EMP_AID ' ;
--  strWhereClause:=strWhereClause||  ' AND (C.LEAVE_DATE IS NULL OR (C.LEAVE_DATE >= '''||pFrom_Date||'''))';
  strWhereClause:=strWhereClause||' AND A.COMP_AID = '''||pComp_Aid||''' AND A.ACC_YEAR = '''||pAcc_Year||'''
                                    AND NVL(B.EFF_TO_DATE,'''||pFrom_Date||''')>='''||pFrom_Date||'''';
--  strWhereClause := strWhereClause || 'AND TO_DATE(01||C.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||C.PROCESS_MONTH))<='''||pTo_Date||  ''' ';
  IF TRIM(pIsMultipleSheet) ='Y' THEN
    strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION( pMasterType , pMultiSheetCondition),'HD.','C.');
  END IF;

  IF PISBATCHWISEREPORT='Y' THEN
    strWhereClause    :=strWhereClause||chr(13)|| ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT
                                      WHERE USER_AID='''||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
  END IF;
  /*to generate the report for the Employees as per the Filter ID*/
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,   pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||  ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST
                                               WHERE USER_AID='''  ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||'''
                                               AND REPORT_AID='''||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  --strInvestHeads:=strInvestHeads||' FROM DUAL';
  strSqlQuery:=strSqlQuery1||' SELECT '||strSelectClause1||strInvestHeads||' FROM DUAL'||CHR(13)||' UNION ALL '||CHR(13)||strSqlQuery||strBatchSelect||CHR(13)||
  strSelectClause||strSelectClause2||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||CHR(13)||strGroupByClause||CHR(13)||strOrderByClause;

   --Finally Return the recordset here
  OPEN Return_Recordset FOR strSqlQuery ;
  --select strSqlQuery from dual ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END ;
PROCEDURE INVESTMENT_DECLARATION_RPT
  (
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
    Return_Recordset OUT REC
  )
IS
    TYPE Cur_Recordset
    IS  REF  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery         LONG;
    strSelectClause     LONG;
    strFromClause       LONG;
    strWhereClause      LONG;
    strGroupByClause    LONG;
    strOrderByClause    LONG;
    strInvestments      LONG;
    strExSelectClause   LONG;
    strExGroupByClause  LONG;
    strBatchSelect      LONG;
    strBatchWhere       LONG;
    strBatchGroupBy     LONG;
    strBatchOrderBy     LONG;
    strInvestHeads      LONG;
    strWithInvQuery     LONG;
    strInvestmentQuery  LONG;
    strWithF12BQuery    LONG;
    strF12BQuery        LONG;
    strWithF12CQuery    LONG;
    strF12CQuery        LONG;
    strWithRentQuery    LONG;
    strRentQuery        LONG;
    strMainQuery        LONG;
    strHeaderMainQuery  LONG;
    vFirstDateFY        DATE;
    vLastDateFY         DATE;
    strCompQuery        LONG;
    strGetCompName      VARCHAR2(4000);
    strGetRptName VARCHAR2(4000);
  BEGIN
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName);

    strWithInvQuery:='WITH WITH_INVEST AS (SELECT COMP_AID,EMP_AID ';
    FOR I IN (SELECT DISTINCT INV_AID,TRIM(INV_MID) INV_MID,
                     TRIM(INV_DESC) INV_DESC
              FROM PY_VW_PT_INVESTMENT
              WHERE COMP_AID   = pComp_Aid
              AND ACC_YEAR = pAcc_Year
              AND INV_MID IS NOT NULL
              ORDER BY INV_AID)
    LOOP

    strWithInvQuery:=strWithInvQuery|| ',' ||'SUM(DECODE(INV_MID,'''||I.INV_MID
                    ||''',DEC_AMOUNT,0)) "'|| I.INV_MID ||' DECLARE AMOUNT"
                    ,SUM(DECODE(INV_MID,'''||I.INV_MID||''',SUP_AMOUNT,0)) "'
                    || I.INV_MID || ' SUPPORT AMOUNT"';

    strInvestmentQuery := strInvestmentQuery|| ',NVL(B."'||I.INV_MID||
                    ' DECLARE AMOUNT",0) AS "'||I.INV_MID||' DECLARE AMOUNT",
                    NVL(B."'||I.INV_MID|| ' SUPPORT AMOUNT",0) AS "'
                    ||I.INV_MID|| ' SUPPORT AMOUNT"';

    strHeaderMainQuery := strHeaderMainQuery||','''||I.INV_DESC||
                    ' DECLARE AMOUNT'', '''||I.INV_DESC|| ' SUPPORT AMOUNT''';

    strCompQuery:= strCompQuery||',NULL, NULL';

  END LOOP;

  strWhereClause := strWhereClause ||
                    ' WHERE HD.COMP_AID = B.COMP_AID(+) AND HD.EMP_AID = B.EMP_AID(+)
                    AND HD.COMP_AID = C.COMP_AID(+) AND HD.EMP_AID = C.EMP_AID(+)
                    AND HD.COMP_AID = D.COMP_AID(+) AND HD.EMP_AID = D.EMP_AID(+)
                    AND HD.COMP_AID = E.COMP_AID(+) AND HD.EMP_AID = E.EMP_AID(+)
                    AND HD.COMP_AID  = '''
                    ||pComp_Aid||'''';

  IF TRIM (pIsMultipleSheet)='Y' THEN
    strWhereClause:=strWhereClause||' AND '||GET_CONDITION(pMasterType , pMultiSheetCondition);
  END IF;

  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
    );

    strWhereClause:=strWhereClause||chr(13)||
                    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
                    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
                    pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;

  strWithInvQuery:=strWithInvQuery ||
                    ' FROM PY_VW_PT_INVESTMENT WHERE COMP_AID  = '''||pComp_Aid||
                    ''' AND ACC_YEAR = '''||pAcc_Year ||''' GROUP BY COMP_AID, EMP_AID ),';
                    --F12B Previous Employer Details

  strWithF12BQuery :='WITH_F12B AS (SELECT COMP_AID,EMP_AID ';

  FOR I IN(SELECT DISTINCT ALLWDED_AID, TRIM(CTC_MID) CTC_MID , TRIM(CTC_NAME) CTC_NAME
            FROM PY_VW_PT_F12B
            WHERE COMP_AID   = pComp_Aid AND ACC_YEAR = pAcc_Year
              AND CTC_MID IS NOT NULL
            ORDER BY ALLWDED_AID)
  LOOP
    strWithF12BQuery:=strWithF12BQuery|| ',' ||'SUM(DECODE(CTC_NAME,'''||
                    I.CTC_NAME||''',AMOUNT,0)) "'|| I.CTC_MID ||' AMOUNT"';
                    strF12BQuery:=strF12BQuery|| ',NVL(D."'|| I.CTC_MID ||
                    ' AMOUNT",0) AS "'|| I.CTC_MID ||' AMOUNT"';

    strHeaderMainQuery := strHeaderMainQuery||','''||I.CTC_MID||' AMOUNT''';

    strCompQuery       := strCompQuery||',NULL';
  END LOOP;

  strWithF12BQuery:=strWithF12BQuery ||
                    ' FROM PY_VW_PT_F12B WHERE COMP_AID  = '''||pComp_Aid||''' AND ACC_YEAR = '''
                    ||pAcc_Year ||''' GROUP BY COMP_AID, EMP_AID ),';
  --F12B Other Income Details
  strWithF12CQuery :='WITH_F12C AS (SELECT COMP_AID,EMP_AID ';

  FOR I IN (SELECT DISTINCT F12C_AID, TRIM(F12C_MID) F12C_MID, TRIM(F12C_DESC) F12C_DESC
            FROM PY_VW_PT_F12C
            WHERE COMP_AID    = pComp_Aid AND ACC_YEAR  = pAcc_Year
              AND F12C_MID IS NOT NULL
            ORDER BY F12C_AID )
  LOOP
    strWithF12CQuery:=strWithF12CQuery|| ',' ||'SUM(DECODE(F12C_AID,'''||
                      I.F12C_MID||''',AMOUNT,0)) "'|| I.F12C_MID ||' AMOUNT"';
                      strF12CQuery:=strF12CQuery|| ',NVL(E."'|| I.F12C_MID ||
                      ' AMOUNT",0) AS "'|| I.F12C_MID ||' AMOUNT"';

    strHeaderMainQuery := strHeaderMainQuery||','''||I.F12C_DESC||' AMOUNT"''';

    strCompQuery       := strCompQuery||', NULL';
  END LOOP;

  strHeaderMainQuery := strHeaderMainQuery||',null';

  strCompQuery       := strCompQuery||',NULL';

  strWithF12CQuery   :=strWithF12CQuery ||
                      ' FROM PY_VW_PT_F12C WHERE COMP_AID  = '''||pComp_Aid||''' AND ACC_YEAR = '''
                      ||pAcc_Year ||''' GROUP BY COMP_AID, EMP_AID ),';

  --Rent Details
  strWithRentQuery :='WITH_RENT AS (SELECT COMP_AID,EMP_AID ';

  FOR I IN (SELECT DISTINCT PAY_MONTH, TO_NUMBER(MONTH_SEQ) MONTH_SEQ
            FROM PY_VW_PT_RENT
            WHERE COMP_AID   = pComp_Aid AND ACC_YEAR = pAcc_Year
            ORDER BY MONTH_SEQ)
  LOOP

    strWithRentQuery:=strWithRentQuery|| ',' ||'SUM(DECODE(PAY_MONTH,'''||
                        I.PAY_MONTH||''',DEC_AMT,0)) "'|| I.PAY_MONTH||
                        ' DECLARE AMOUNT"
                        ,SUM(DECODE(PAY_MONTH,'''
                        ||I.PAY_MONTH||''',SUP_AMT,0)) "'|| I.PAY_MONTH|| ' SUPPORT AMOUNT"';

    strRentQuery := strRentQuery|| ',NVL(C."'||I.PAY_MONTH ||
                        ' DECLARE AMOUNT",0) AS "'||I.PAY_MONTH ||
                        ' DECLARE AMOUNT", NVL(C."'|| I.PAY_MONTH ||
                        ' SUPPORT AMOUNT",0) AS "'|| I.PAY_MONTH || ' SUPPORT AMOUNT"';

    strHeaderMainQuery := strHeaderMainQuery||','''||I.PAY_MONTH ||
                        ' DECLARE AMOUNT'', '''|| I.PAY_MONTH || ' SUPPORT AMOUNT''';

    strCompQuery:= strCompQuery||',NULL, NULL';
  END LOOP;

  strWithRentQuery:=strWithRentQuery|| ','||'SUM(NVL(DEC_AMT,0)) "TOTAL DECLARE AMOUNT" ,
                                             SUM(NVL(SUP_AMT,0)) "TOTAL SUPPORT AMOUNT"';

  strRentQuery := strRentQuery||',NVL(C."TOTAL DECLARE AMOUNT",0) "TOTAL DECLARE AMOUNT" ,
                                  NVL(C."TOTAL SUPPORT AMOUNT",0) "TOTAL SUPPORT AMOUNT"';

  strHeaderMainQuery := strHeaderMainQuery||',''TOTAL DECLARE AMOUNT'',''TOTAL SUPPORT AMOUNT''';

  strCompQuery    := strCompQuery||',NULL, NULL';

  strWithRentQuery:=strWithRentQuery ||
                          ' FROM PY_VW_PT_RENT WHERE COMP_AID  = '''||pComp_Aid||''' AND ACC_YEAR = '''
                          ||pAcc_Year ||''' GROUP BY COMP_AID, EMP_AID )';
  --SELECT REPORT_SECTION,"EMPLOYEE CODE","EMPLOYEE NAME" ,"JOIN DATE","LEAVE
  -- DATE", "PAN NUMBER","BANK ACCOUNT NO","GRADE","DESIGNATION","DEPARTMENT","
  -- BRANCH","LOCATION"'||replace(replace(strHeaderMainQuery,'"',''),'''','"')|
  -- | '
  --                        FROM (
  strMainQuery :='SELECT
                  ''X#X#X'' REPORT_SECTION1,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL'||strCompQuery||
                  ',''RH'' REPORT_SECTION1,'''||strGetCompName||
                  ''',NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL'||strCompQuery||
                  ' FROM DUAL
                  UNION ALL
                  SELECT
                  ''X#X#X'' REPORT_SECTION1,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL'||strCompQuery||
                  ',''RH'' REPORT_SECTION1,'''
                  ||strGetRptName||''',NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL'||
                  strCompQuery||
                  ' FROM DUAL
                  UNION ALL
                  SELECT ''AC'' REPORT_SECTION, TO_CHAR(HD.EMP_MID) "EMPLOYEE CODE",HD.EMP_NAME "EMPLOYEE NAME",TO_CHAR(HD.JOIN_DATE,''DD-MON-YYYY'') "JOIN DATE",TO_CHAR(HD.LEAVE_DATE,''DD-MON-YYYY'') "LEAVE DATE"
                  ,HD.PAN_NUMBER "PAN NUMBER",HD.BANK_ACCOUNT_NO "BANK ACCOUNT NO",HD.GRADE_DESC "GRADE",HD.DESG_DESC "DESIGNATION",HD.DEPT_DESC "DEPARTMENT",HD.BR_DESC "BRANCH"
                  ,HD.LOC_DESC "LOCATION"'
                  || strInvestmentQuery||strF12BQuery||strF12CQuery||',null' ||strRentQuery||
                  ',NULL REPORT_SECTION1,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL'||strCompQuery||
                  ' FROM PY_GM_EMPMAST HD, WITH_INVEST B, WITH_RENT C,WITH_F12B D,WITH_F12C E'
                  ||strWhereClause||
                  ' UNION ALL
                  SELECT  ''X#X#X'' REPORT_SECTION1,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL'||strCompQuery||
                  ',''DH'' REPORT_SECTION,''EMPLOYEE CODE'',''EMPLOYEE NAME'' ,''JOIN DATE'',''LEAVE DATE'', ''PAN NUMBER'',''BANK ACCOUNT NO'',''GRADE'',''DESIGNATION'',''DEPARTMENT'',''BRANCH'',''LOCATION'''
                  ||strHeaderMainQuery||
                  ' FROM DUAL
                  ORDER BY 1 DESC,2' ;



  strSqlQuery:= strWithInvQuery|| strWithF12BQuery|| strWithF12CQuery||
                strWithRentQuery|| strMainQuery;
  --Finally Return the recordset here

  OPEN Return_Recordset FOR strSqlQuery ;
  --select strSqlQuery from dual ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END ;
PROCEDURE SALARY_SUMMARY_GRADEWISE
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
    strSelectClause LONG;
    strSelectQuery LONG;
    strHeaderField LONG;
    strCompName LONG;
    strTotalQuery LONG;
    vCount NUMBER
    (
      12,2
    )
    ;
    strHead LONG;
    strSelectQuery1 LONG;
    strHead1 LONG;
    strTotalQuery1 LONG;
    strHeaderField1 LONG;
    strCompName1 LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    vCount:=0;
    FOR I IN
    (
      SELECT DISTINCT
        VW.ALLWDED_AID,
        VW.ALLWDED_MID,
        ALLWDED_DESC,
        'ROUND(SUM( CASE WHEN VW.CTC_TYPE=''A'' AND TRIM(VW.ALLWDED_MID)='''
        ||VW.ALLWDED_MID
        ||''' AND VW.PAY_MONTH='''
        ||pPay_Month
        ||''' THEN VW.AMOUNT ELSE 0 END),2) AS "'
        ||
        CASE
          WHEN LENGTH(ALLWDED_DESC) > 13
          THEN SUBSTR(ALLWDED_DESC,0,13)
          ELSE ALLWDED_DESC
        END
        ||'"' EARNINGS,
        'ROUND(SUM( CASE WHEN VW.CTC_TYPE=''D'' AND TRIM(VW.ALLWDED_MID)='''
        ||VW.ALLWDED_MID
        ||''' AND VW.PAY_MONTH='''
        ||pPay_Month
        ||''' THEN VW.AMOUNT ELSE 0 END),2) AS "'
        ||
        CASE
          WHEN LENGTH(ALLWDED_DESC) > 13
          THEN SUBSTR(ALLWDED_DESC,0,13)
          ELSE ALLWDED_DESC
        END
        ||'"' DEDUCTIONS,
        ADD_MONTHS(pTo_Date,-1) ,
        pTo_Date,
        VW.CTC_TYPE
      FROM
        PY_VW_EMPLOYEE_SALARY VW
      WHERE
        LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS(pTo_Date,-1) AND pTo_Date
      ORDER BY
        VW.CTC_TYPE,
        VW.ALLWDED_AID
    )
  LOOP
    IF I.EARNINGS    IS NOT NULL OR I.DEDUCTIONS IS NOT NULL THEN
      vCount         :=vCount+1;
      strSelectQuery :=strSelectQuery ||','|| SUBSTR
      (
        I.EARNINGS,1,instr(I.EARNINGS,' AS ')
      )
      ||' "'||vCount||'_1"' ;
      strSelectQuery1:=strSelectQuery1||','|| SUBSTR
      (
        I.DEDUCTIONS,1,instr(I.DEDUCTIONS,' AS ')
      )
      ||' "'||vCount||'_2"';
      strHead      :=strHead|| ',"'||vCount||'_1"';
      strHead1     :=strHead1|| ',"'||vCount||'_2"';
      strTotalQuery:=strTotalQuery||','|| SUBSTR
      (
        I.EARNINGS,1,instr(I.EARNINGS,' AS ')
      )
      ;
      strTotalQuery1:=strTotalQuery1||','|| SUBSTR
      (
        I.DEDUCTIONS,1,instr(I.DEDUCTIONS,' AS ')
      )
      ;
      strHeaderField:= strHeaderField ||',' || REPLACE
      (
        SUBSTR(I.EARNINGS,instr(I.EARNINGS,' AS ')+4),'"',''''
      )
      ;
      strHeaderField1:= strHeaderField1 ||',' || REPLACE
      (
        SUBSTR(I.DEDUCTIONS,instr(I.DEDUCTIONS,' AS ')+4),'"',''''
      )
      ;
      strCompName :=strCompName ||',null "'||vCount||'_3"';
      strCompName1:=strCompName1 ||',null "'||vCount||'_4"';
    END IF;
  END LOOP;
  strSqlQuery:=
  'SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" , NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||',null "GROSS EARNING"'||strCompName1||
  ',null "GROSS DEDUCTION",null "NET SALARY"
,''RH'' REPORT_HEADER1,'''
  ||strGetCompName||
  ''' "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" , NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||',null "GROSS EARNING1"'||strCompName1||
  ',null "GROSS DEDUCTION1",null "NET SALARY1" FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" , NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||',null "GROSS EARNING"'||strCompName1||
  ',null "GROSS DEDUCTION",null "NET SALARY"
,''RH'' REPORT_HEADER1,'''
  ||strGetRptName||
  ''' "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" , NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||',null "GROSS EARNING1"'||strCompName1||
  ',null "GROSS DEDUCTION1",null "NET SALARY1" FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" , NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||',null "GROSS EARNING"'||strCompName1||
  ',null "GROSS DEDUCTION",null "NET SALARY"
,''DH'' REPORT_HEADER1, ''CODE'',''EMPLOYEE NAME'' ,''JOINING DATE'',''QUIT DATE'',
''PRESENT DAYS'' , ''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'''
  ||strHeaderField||',''GROSS EARNING'''||strHeaderField1||
  ',''GROSS DEDUCTION'',''NET SALARY'' FROM DUAL
UNION ALL '
  ;
  --
  strSqlQuery:=strSqlQuery||chr
  (
    13
  )
  ||
  'SELECT * FROM (SELECT REPORT_HEADER, "CODE","EMPLOYEE NAME" ,"JOINING DATE","QUIT DATE",
"ARREAR DAYS" , "DEPARTMENT", "DESIGNATION","GRADE","LOCATION",
"SAVING ACCOUNT","BANK NAME","PAN NUMBER"'
  ||strHead||',"GROSS EARNING"'||strHead1||
  ',"GROSS DEDUCTION","NET SALARY","REPORT_HEADER1", "CODE1","EMPLOYEE NAME1" ,"JOINING DATE1","QUIT DATE1",
"ARREAR DAYS1" , "DEPARTMENT1", "DESIGNATION1","GRADE1","LOCATION1",
"SAVING ACCOUNT1","BANK NAME1","PAN NUMBER1"'
  ||REPLACE
  (
    strCompName,'null',''
  )
  || ',"GROSS EARNING1"'||REPLACE
  (
    strCompName1,'null',''
  )
  ||
  ', "GROSS DEDUCTION1","NET SALARY1" FROM (SELECT 1 ROW_NUM ,''AC'' REPORT_HEADER,'
  ;
  strGroupByClause:= ' GROUP BY ';
  strSelectClause :=
  ' VW.EMP_MID AS "CODE",VW.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(VW.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(VW.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",
TO_CHAR(P.DAYS_PRESENT) AS "ARREAR DAYS" , VW.DEPT_DESC AS "DEPARTMENT", VW.DESG_DESC AS "DESIGNATION",VW.GRADE_DESC AS "GRADE",VW.LOC_DESC AS "LOCATION",
TO_CHAR(VW.BANK_CURR_ACCOUNT_NO) AS "SAVING ACCOUNT",VW.BANK_DESC AS "BANK NAME",TO_CHAR(VW.PAN_NUMBER) AS "PAN NUMBER"'
  ;
  strSelectClause := strSelectClause||strSelectQuery||
  ',SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,0)) AS "GROSS EARNING"'||
  strSelectQuery1||
  ', SUM(DECODE(VW.CTC_TYPE,''D'',VW.AMOUNT,0)) AS "GROSS DEDUCTION", SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,VW.AMOUNT*-1)) AS "NET SALARY",NULL REPORT_HEADER1,NULL "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" , NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||',NULL "GROSS EARNING1"'||strCompName1||
  ',NULL "GROSS DEDUCTION1",NULL "NET SALARY1"';
  strFromClause:=' FROM PY_VW_EMPLOYEE_SALARY VW,PY_PT_PRESENT P';
  --            strWhereClause:=' WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS(
  -- '''||pTo_Date||''',-1) AND '''|| pTo_Date || '''';
  strWhereClause:=
  ' WHERE VW.COMP_ID=P.COMP_AID
AND VW.ACC_YEAR=P.ACC_YEAR
AND VW.PAY_MONTH=P.PAY_MONTH
AND VW.EMP_AID=P.EMP_AID
AND VW.COMP_ID='''
  ||pComp_Aid||''' AND VW.ACC_YEAR='''||pAcc_Year||
  '''  AND TO_DATE(01||VW.PROCESS_MONTH)>='''||pFrom_Date||
  '''
AND LAST_DAY(TO_DATE(01||VW.PROCESS_MONTH))<='''||
  pTo_Date || '''';
  strGroupByClause:= strGroupByClause ||
  ' VW.EMP_MID,VW.EMP_NAME,VW.JOIN_DATE,VW.LEAVE_DATE,P.DAYS_PRESENT, VW.DEPT_DESC,VW.DESG_DESC,VW.GRADE_DESC,VW.LOC_DESC,
VW.BANK_CURR_ACCOUNT_NO,VW.BANK_DESC,VW.PAN_NUMBER '
  ;
  strSqlQuery:= strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strGroupByClause||'';
  strSqlQuery:= strSqlQuery||
  'UNION ALL
SELECT * FROM (
SELECT  2 ROW_NUM,
''DH'' REPORT_HEADER,NULL AS "CODE",NULL AS "EMPLOYEE NAME" ,NULL AS "JOINING DATE",NULL AS "QUIT DATE",
NULL AS "ARREAR DAYS" , VW.DEPT_DESC AS "DEPARTMENT", NULL AS "DESIGNATION",NULL AS "GRADE",NULL AS "LOCATION",
NULL AS "SAVING ACCOUNT",NULL AS "BANK NAME",''TOTAL'' AS "PAN NUMBER"'
  ||strSelectQuery||
  ',SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,0)) AS "GROSS EARNING"'||
  strSelectQuery1||
  ', SUM(DECODE(VW.CTC_TYPE,''D'',VW.AMOUNT,0)) AS "GROSS DEDUCTION", SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,VW.AMOUNT*-1)) AS "NET SALARY",NULL REPORT_HEADER1,NULL AS "CODE1",NULL AS "EMPLOYEE NAME1" ,NULL AS "JOINING DATE1",NULL AS "QUIT DATE1",
NULL AS "ARREAR DAYS1" , NULL AS "DEPARTMENT1", NULL AS "DESIGNATION1",NULL AS "GRADE1",NULL AS "LOCATION1",
NULL AS "SAVING ACCOUNT1",NULL AS "BANK NAME1",NULL AS "PAN NUMBER1"'
  ||strCompName||',NULL "GROSS EARNING1"'||strCompName1||
  ',NULL "GROSS DEDUCTION1",NULL "NET SALARY1"'||strFromClause||strWhereClause
  ||
  'GROUP BY VW.DEPT_DESC order by VW.DEPT_DESC))
ORDER BY GRADE,ROW_NUM)'
  ;
  OPEN Return_Recordset FOR strSqlQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END;
PROCEDURE SALARY_SUMMARY_COSTCENTERWISE
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
  BEGIN
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    --
    --        IF pReportType='Excel' THEN
    --
    --            strSelect := 'SELECT * FROM (SELECT ';
    --            strSelect := strSelect||strBatchSelect||' COMP_NAME,
    -- PROCESS_MONTH,CC_MID,CC_DESC "COST CENTER",to_char(COUNT(DISTINCT
    -- EMP_AID)) "No. Of Employees",SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT)
    -- "Gross Deduction", SUM(TNET_AMT) "Net Amount"';
    --
    --        ELSE
    --
    --            strSelect := 'SELECT * FROM (SELECT ';
    --            strSelect := strSelect||strBatchSelect||' COMP_NAME,
    -- PROCESS_MONTH,CC_MID,CC_DESC "COST CENTER",to_char(COUNT(DISTINCT
    -- EMP_AID)) "No. Of Employees",SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT)
    -- "Gross Deduction", SUM(TNET_AMT) "Net Amount"';
    --
    --
    --        END IF;
    strSelect := 'SELECT * FROM (SELECT ';
    strSelect := strSelect||strBatchSelect||
    ' COMP_NAME,PROCESS_MONTH,CC_MID,CC_DESC "COST CENTER",to_char(COUNT(DISTINCT EMP_AID)) "No. Of Employees",SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT) "Gross Deduction", SUM(TNET_AMT) "Net Amount"'
    ;
    strFrom  := ' FROM PY_PT_SAL_HD A,PY_GM_COMP B';
    strWhere := ' WHERE A.COMP_AID=B.COMP_ID AND ';
    strWhere := strWhere || ' A.COMP_AID='''||pComp_Aid||''' AND A.ACC_YEAR='''
    ||pAcc_Year||''' ';
    strWhere := strWhere || ' AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||''' ';
    strWhere := strWhere ||strBatchWhere;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      strWhere:=strWhere||chr
      (
        13
      )
      ||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy := ' GROUP BY ';
    strGroupBy := strGroupBy||strBatchGroupBy||
    ' COMP_NAME,COMP_MID,PROCESS_MONTH,CC_MID,CC_DESC';
    strOrderBy := ' ORDER BY ';
    strOrderBy := strOrderBy||strBatchOrderBy||' CC_MID )';
    strUnion1  :=' UNION ALL SELECT '||strBatchSelect||
    '  COMP_NAME,PROCESS_MONTH,''TOTAL'' CC_MID,NULL CC_DESC,to_char(COUNT(DISTINCT EMP_AID)) "No. Of Employees",SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT) "Gross Deduction", SUM(TNET_AMT) "Net Amount"'
    ;
    strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
    ' COMP_NAME, PROCESS_MONTH';
    strUnion2:=' ';
    --        strOrderBy := ') ORDER BY ';
    --        strOrderBy := strOrderBy||strBatchOrderBy||' LOCATION';
    strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
    strSqlQuery:=strSqlQuery||strUnion1||strUnion2;
--


    OPEN Return_Recordset FOR strSqlQuery;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE SALARY_SUMMARY_DEPARTMENTWISE
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
    strSelectClause LONG;
    strSelectQuery LONG;
    strHeaderField LONG;
    strCompName LONG;
    strTotalQuery LONG;
    vCount NUMBER
    (
      12,2
    )
    ;
    strHead LONG;
    strSelectQuery1 LONG;
    strHead1 LONG;
    strTotalQuery1 LONG;
    strHeaderField1 LONG;
    strCompName1 LONG;
    STRTEST LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    vCount:=0;
    --                 SELECT DISTINCT VW.ALLWDED_AID, VW.ALLWDED_MID,
    -- ALLWDED_DESC,
    --                        'ROUND(SUM( CASE WHEN VW.CTC_TYPE=''A'' AND TRIM(
    -- VW.ALLWDED_MID)='''||VW.ALLWDED_MID||''' AND VW.PAY_MONTH='''||
    -- pPay_Month||''' THEN VW.AMOUNT ELSE 0 END),2) AS "'||CASE WHEN LENGTH(
    -- ALLWDED_DESC) > 13 THEN substr(ALLWDED_DESC,0,13) ELSE ALLWDED_DESC END|
    -- |'"' EARNINGS,
    --                         'ROUND(SUM( CASE WHEN VW.CTC_TYPE=''D'' AND TRIM
    -- (VW.ALLWDED_MID)='''||VW.ALLWDED_MID||''' AND VW.PAY_MONTH='''||
    -- pPay_Month||''' THEN VW.AMOUNT ELSE 0 END),2) AS "'||CASE WHEN LENGTH(
    -- ALLWDED_DESC) > 13 THEN substr(ALLWDED_DESC,0,13) ELSE ALLWDED_DESC END|
    -- |'"' DEDUCTIONS,
    --                        ADD_MONTHS(pTo_Date,-1) , pTo_Date,VW.CTC_TYPE
    --                        FROM PY_VW_EMPLOYEE_SALARY VW
    --                        WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS(
    -- pTo_Date,-1) AND pTo_Date
    --                        order by VW.CTC_TYPE,VW.ALLWDED_AID
    FOR I IN
    (
      SELECT DISTINCT
        VW.ALLWDED_AID,
        VW.ALLWDED_MID,
        ALLWDED_DESC,
        DECODE(CTC_TYPE,'A',
        'ROUND(SUM( DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,0)),2) AS "'
        ||ALLWDED_DESC
        ||'"') EARNINGS,
        DECODE(CTC_TYPE,'D',
        'ROUND(SUM(DECODE(VW.CTC_TYPE,''D'',VW.AMOUNT,0)),2) AS "'
        ||ALLWDED_DESC
        ||'"') DEDUCTIONS,
        ADD_MONTHS(pTo_Date,-1) ,
        pTo_Date,
        VW.CTC_TYPE
      FROM
        PY_VW_EMPLOYEE_SALARY VW
      WHERE
        VW.COMP_ID   =pComp_Aid
      AND VW.ACC_YEAR=pAcc_Year
      AND TO_DATE(01
        ||VW.PROCESS_MONTH)>=pFrom_Date
      AND LAST_DAY(TO_DATE(01
        ||VW.PROCESS_MONTH))<=pTo_Date
        --                        WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS(
        -- pTo_Date,-1) AND pTo_Date
      ORDER BY
        VW.CTC_TYPE,
        VW.ALLWDED_AID
    )
  LOOP
    vCount           :=vCount+1;
    IF I.EARNINGS    IS NOT NULL THEN
      strSelectQuery :=strSelectQuery ||','|| SUBSTR
      (
        I.EARNINGS,1,instr(I.EARNINGS,' AS ')
      )
      ||' "'||vCount||'_1"' ;
      strHead      :=strHead|| ',"'||vCount||'_1"';
      strTotalQuery:=strTotalQuery||','|| SUBSTR
      (
        I.EARNINGS,1,instr(I.EARNINGS,' AS ')
      )
      ;
      strHeaderField:= strHeaderField ||',' || REPLACE
      (
        SUBSTR(I.EARNINGS,instr(I.EARNINGS,' AS ')+4),'"',''''
      )
      ;
      strCompName:=strCompName ||',null "'||vCount||'_3"';
    END IF;
    IF I.DEDUCTIONS  IS NOT NULL THEN
      strSelectQuery1:=strSelectQuery1||','|| SUBSTR
      (
        I.DEDUCTIONS,1,instr(I.DEDUCTIONS,' AS ')
      )
      ||' "'||vCount||'_2"';
      strHead1      :=strHead1|| ',"'||vCount||'_2"';
      strTotalQuery1:=strTotalQuery1||','|| SUBSTR
      (
        I.DEDUCTIONS,1,instr(I.DEDUCTIONS,' AS ')
      )
      ;
      strHeaderField1:= strHeaderField1 ||',' || REPLACE
      (
        SUBSTR(I.DEDUCTIONS,instr(I.DEDUCTIONS,' AS ')+4),'"',''''
      )
      ;
      strCompName1:=strCompName1 ||',null "'||vCount||'_4"';
    END IF;
  END LOOP;
  strSqlQuery:=
  'SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" , NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",NULL "Cost Center", NULL "Band",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||',null "GROSS EARNING"'||strCompName1||
  ',null "GROSS DEDUCTION",null "NET SALARY"
,''RH'' REPORT_HEADER1,'''
  ||strGetCompName||
  ''' "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" , NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",NULL "Cost Center1", NULL "Band1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||',null "GROSS EARNING1"'||strCompName1||
  ',null "GROSS DEDUCTION1",null "NET SALARY1" FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" , NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION", NULL "Cost Center",NULL "Band",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||',null "GROSS EARNING"'||strCompName1||
  ',null "GROSS DEDUCTION",null "NET SALARY"
,''RH'' REPORT_HEADER1,'''
  ||REPLACE
  (
    strGetRptName,'MASTER',pMasterType
  )
  ||
  ''' "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" , NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1", NULL "Cost Center1", NULL "Band1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||',null "GROSS EARNING1"'||strCompName1||
  ',null "GROSS DEDUCTION1",null "NET SALARY1" FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL "CODE",NULL "EMPLOYEE NAME" ,NULL "JOINING DATE",NULL "QUIT DATE",
NULL "ARREAR DAYS" , NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",NULL "Cost Center", NULL "Band",
NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER"'
  ||strCompName||',null "GROSS EARNING"'||strCompName1||
  ',null "GROSS DEDUCTION",null "NET SALARY"
,''DH'' REPORT_HEADER1, ''CODE'',''EMPLOYEE NAME'' ,''JOINING DATE'',''QUIT DATE'',
''PRESENT DAYS'' , ''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',''Cost Center'',''Band'',
''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'''
  ||strHeaderField||',''GROSS EARNING'''||strHeaderField1||
  ',''GROSS DEDUCTION'',''NET SALARY'' FROM DUAL
UNION ALL '
  ;
  --
  strSqlQuery:=strSqlQuery||chr
  (
    13
  )
  ||
  'SELECT * FROM (SELECT REPORT_HEADER, "CODE","EMPLOYEE NAME" ,"JOINING DATE","QUIT DATE",
"ARREAR DAYS" , "DEPARTMENT", "DESIGNATION","GRADE","LOCATION", "Cost Center", "Band",
"SAVING ACCOUNT","BANK NAME","PAN NUMBER"'
  ||strHead||',"GROSS EARNING"'||strHead1||
  ',"GROSS DEDUCTION","NET SALARY","REPORT_HEADER1", "CODE1","EMPLOYEE NAME1" ,"JOINING DATE1","QUIT DATE1",
"ARREAR DAYS1" , "DEPARTMENT1", "DESIGNATION1","GRADE1","LOCATION1", "Cost Center1", "Band1",
"SAVING ACCOUNT1","BANK NAME1","PAN NUMBER1"'
  ||REPLACE
  (
    strCompName,'null',''
  )
  || ',"GROSS EARNING1"'||REPLACE
  (
    strCompName1,'null',''
  )
  ||
  ', "GROSS DEDUCTION1","NET SALARY1" FROM (SELECT 1 ROW_NUM ,''AC'' REPORT_HEADER,'
  ;
  strGroupByClause:= ' GROUP BY ';
  strSelectClause :=
  ' VW.EMP_MID AS "CODE",VW.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(VW.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(VW.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",
TO_CHAR(P.DAYS_PRESENT) AS "ARREAR DAYS" , VW.DEPT_DESC AS "DEPARTMENT", VW.DESG_DESC AS "DESIGNATION",VW.GRADE_DESC AS "GRADE",VW.LOC_DESC AS "LOCATION",VW.CC_DESC  "Cost Center", BAND_DESC "Band",
TO_CHAR(VW.BANK_CURR_ACCOUNT_NO) AS "SAVING ACCOUNT",VW.BANK_DESC AS "BANK NAME",TO_CHAR(VW.PAN_NUMBER) AS "PAN NUMBER"'
  ;
  strSelectClause := strSelectClause||strSelectQuery||
  ',SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,0)) AS "GROSS EARNING"'||
  strSelectQuery1||
  ', SUM(DECODE(VW.CTC_TYPE,''D'',VW.AMOUNT,0)) AS "GROSS DEDUCTION", SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,VW.AMOUNT*-1)) AS "NET SALARY",NULL REPORT_HEADER1,NULL "CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOINING DATE1",NULL "QUIT DATE1",
NULL "ARREAR DAYS1" , NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",NULL "Cost Center1", NULL "Band1",
NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1"'
  ||strCompName||',NULL "GROSS EARNING1"'||strCompName1||
  ',NULL "GROSS DEDUCTION1",NULL "NET SALARY1"';
  strFromClause:=' FROM PY_VW_EMPLOYEE_SALARY VW,PY_PT_PRESENT P';
  --            strWhereClause:=' WHERE LAST_DAY(PROC_DATE) BETWEEN ADD_MONTHS(
  -- '''||pTo_Date||''',-1) AND '''|| pTo_Date || '''';
  strWhereClause:=
  ' WHERE VW.COMP_ID=P.COMP_AID
AND VW.ACC_YEAR=P.ACC_YEAR
AND VW.PAY_MONTH=P.PAY_MONTH
AND VW.EMP_AID=P.EMP_AID
AND VW.COMP_ID='''
  ||pComp_Aid||''' AND VW.ACC_YEAR='''||pAcc_Year||
  '''  AND TO_DATE(01||VW.PROCESS_MONTH)>='''||pFrom_Date||
  '''
AND LAST_DAY(TO_DATE(01||VW.PROCESS_MONTH))<='''||
  pTo_Date || '''';
  --              IF pIsBatchWiseReport='Y' THEN
  --               strWhereClause:=strWhereClause||chr(13)||' AND VW.BATCH_ID
  -- IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''||
  -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
  --            END IF;
  IF TRIM
    (
      pIsMultipleSheet
    )
                   ='Y' THEN
    strWhereClause:=strWhereClause||' AND '||REPLACE
    (
      GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','VW.'
    )
    ;
  END IF;
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
    )
    ;
    strWhereClause:=strWhereClause||chr
    (
      13
    )
    ||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strGroupByClause:= strGroupByClause ||
  ' VW.EMP_MID,VW.EMP_NAME,VW.JOIN_DATE,VW.LEAVE_DATE,P.DAYS_PRESENT, VW.DEPT_DESC,VW.DESG_DESC,VW.GRADE_DESC,VW.LOC_DESC,
VW.BANK_CURR_ACCOUNT_NO,VW.BANK_DESC,VW.PAN_NUMBER ,VW.CC_DESC,VW.BAND_DESC'
  ;
  strSqlQuery:= strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strGroupByClause||'';
  strSqlQuery:= strSqlQuery||
  ' UNION ALL
SELECT * FROM (
SELECT  2 ROW_NUM,
''DH'' REPORT_HEADER,'
  ||GET_SELECT_COLS
  (
    pMasterType,'Y'
  )
  ||strSelectQuery||
  ',SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,0)) AS "GROSS EARNING"'||
  strSelectQuery1||
  ', SUM(DECODE(VW.CTC_TYPE,''D'',VW.AMOUNT,0)) AS "GROSS DEDUCTION", SUM(DECODE(VW.CTC_TYPE,''A'',VW.AMOUNT,VW.AMOUNT*-1)) AS "NET SALARY",NULL REPORT_HEADER1,NULL AS "CODE1",NULL AS "EMPLOYEE NAME1" ,NULL AS "JOINING DATE1",NULL AS "QUIT DATE1",
NULL AS "ARREAR DAYS1" , NULL AS "DEPARTMENT1", NULL AS "DESIGNATION1",NULL AS "GRADE1",NULL AS "LOCATION1", NULL "Cost Center1",NULL "Band1",
NULL AS "SAVING ACCOUNT1",NULL AS "BANK NAME1",NULL AS "PAN NUMBER1"'
  ||strCompName||',NULL "GROSS EARNING1"'||strCompName1||
  ',NULL "GROSS DEDUCTION1",NULL "NET SALARY1"'||strFromClause||strWhereClause
  ||'GROUP BY '||REPLACE
  (
    GET_GROUP_BY_COLS(pMasterType,'N'),'.HD','.VW'
  )
  ||' order by '||REPLACE
  (
    GET_GROUP_BY_COLS(pMasterType,'N'),'.HD','.VW'
  )
  ||'))
ORDER BY '||GET_ORDER_BY_COLS
  (
    pMasterType
  )
  ||',ROW_NUM)';
  STRTEST:= GET_SELECT_COLS
  (
    pMasterType,'Y'
  )
  ||strSelectQuery;
  OPEN Return_Recordset FOR strSqlQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END;
PROCEDURE LOAN_REPORT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
    strSelectClause LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    strSelectClause :=
    'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,null, null,null,null,null,null,null,null,null,null,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,null,
''RH'' REPORT_HEADER,'''
    ||strGetRptName||
    ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,null,
''DH'' REPORT_HEADER1, ''EMP CODE'', ''EMPLOYEE NAME'',''LOAN DESCRIPTION'' ,''LOAN TAKEN MONTH'', ''LOAN AMOUNT'',
''LOAN EMI AMOUNT'' ,''LOAN PRIN AMOUNT'', ''LOAN INT AMOUNT'',''EMI TILL DATE'',''PRIN TILL AMOUNT'',
''INT TILL AMOUNT'',''OPEN BALANCE'',''EMI AMOUNT'',''PRIN AMOUNT'',''INT AMOUNT'',''CLOSE BAL AMOUNT'' FROM DUAL UNION ALL '
    ;
    strSelect := 'SELECT * FROM (SELECT ';
    strSelect := strSelect||strBatchSelect||
    '''AC'' "REPORT_HEADER", C.EMP_MID "EMP CODE",C.EMP_NAME "EMPLOYEE NAME",E.LOAN_DESC,B.DED_START_MONTH "LOAN TAKEN MONTH",B.AMOUNT "LOAN AMOUNT",B.EMI_AMOUNT "LOAN EMI AMOUNT",B.PRI_AMOUNT "LOAN PRIN AMOUNT"'
    ;
    strSelect := strSelect||
    ',B.INT_AMOUNT "LOAN INT AMOUNT",NVL(D.EMI_AMOUNT_TILL,0) "EMI TILL DATE",NVL(D.PRI_AMOUNT_TILL,0) "PRIN TILL DATE",NVL(D.INT_AMOUNT_TILL,0) "INT TILL DATE",OPEN_BAL_AMT "OPEN BALANCE", A.EMI_AMOUNT "EMI AMOUNT",A.PRI_AMOUNT "PRIN AMOUNT",A.INT_AMOUNT "INT AMOUNT",A.CLOSE_BAL_AMT "CLOSE BAL AMOUNT",
NULL "REPORT_HEADER1", NULL "EMP CODE1",NULL "EMPLOYEE NAME1",NULL,NULL "LOAN TAKEN MONTH1",
NULL "LOAN AMOUNT1",NULL "LOAN EMI AMOUNT1",NULL "LOAN PRIN AMOUNT1",NULL "LOAN INT AMOUNT1",NULL "EMI TILL DATE1",
NULL "PRIN TILL DATE1",NULL "INT TILL DATE1",NULL "OPEN BALANCE1", NULL "EMI AMOUNT1",
NULL "PRIN AMOUNT1",NULL "INT AMOUNT1",NULL "CLOSE BAL AMOUNT1"'
    ;
    strFrom :=
    ' FROM PY_LT_EMPLOAN_SHEDULE A, PY_LT_LOAN_DISBURSE B , PY_GM_EMPMAST C, PY_GM_LOAN_TYPE E'
    ;
    strFrom := strFrom||
    ',(SELECT COMP_AID, LOAN_AID, EMP_AID, LOAN_REF_NO, SUM(OPEN_BAL_AMT) OPEN_BAL_AMT_TILL, SUM(EMI_AMOUNT) EMI_AMOUNT_TILL, SUM(PRI_AMOUNT) PRI_AMOUNT_TILL, SUM(INT_AMOUNT) INT_AMOUNT_TILL, SUM(CLOSE_BAL_AMT) CLOSE_BAL_AMT_TILL
FROM PY_LT_EMPLOAN_SHEDULE WHERE TO_DATE(01||PAY_MONTH)<'''
    ||TO_DATE
    (
      01||pPAY_MONTH
    )
    ||''' GROUP BY COMP_AID, LOAN_AID, EMP_AID, LOAN_REF_NO) D';
    strWhere :=
    ' WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND A.LOAN_AID=B.LOAN_AID AND A.LOAN_REF_NO=B.LOAN_REF_NO '
    ;
    strWhere := strWhere ||
    ' AND A.COMP_AID=C.COMP_AID AND A.EMP_AID=C.EMP_aID';
    strWhere := strWhere ||
    ' AND A.COMP_AID=D.COMP_AID(+) AND A.EMP_AID=D.EMP_AID(+) AND A.LOAN_AID=D.LOAN_AID(+) AND A.LOAN_REF_NO=D.LOAN_REF_NO(+)'
    ;
    strWhere := strWhere ||
    ' AND A.COMP_AID=E.COMP_AID AND A.LOAN_AID=E.LOAN_AID';
    strWhere := strWhere || ' AND A.COMP_AID='''||pComp_Aid||
    ''' AND A.PAY_MONTH='''||TRIM
    (
      pPay_Month
    )
    ||''' ';
    strWhere := strWhere ||strBatchWhere;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      --            strWhere:=strWhere||chr(13)||'  AND A.EMP_AID IN (SELECT
      -- EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND
      -- SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN TRIM(
      -- pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||''' AND
      -- COMP_AID='''||pComp_Aid||''')';
      strWhere:=strWhere||chr
      (
        13
      )
      ||
      '  AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy := '';
    strOrderBy := ' ORDER BY ';
    strOrderBy := strOrderBy||strBatchOrderBy||' C.EMP_MID, E.LOAN_DESC)';
    strUnion1  :=
    ' UNION ALL SELECT ''DH'' "REPORT_HEADER",NULL EMP_MID ,''TOTAL EMP # ''||COUNT(DISTINCT C.EMP_NAME) ,NULL LOAN_DESC,NULL DED_START_MONTH ,SUM(B.AMOUNT) "LOAN AMOUNT",SUM(B.EMI_AMOUNT) "LOAN EMI AMOUNT",SUM(B.PRI_AMOUNT) "LOAN PRIN AMOUNT"'
    ;
    strUnion1:=strUnion1||
    ' ,SUM(B.INT_AMOUNT) "LOAN INT AMOUNT",SUM(D.EMI_AMOUNT_TILL) "EMI TILL DATE",SUM(D.PRI_AMOUNT_TILL) "PRIN TILL DATE",SUM(D.INT_AMOUNT_TILL) "INT TILL DATE",SUM(OPEN_BAL_AMT) "OPEN BALANCE", SUM(A.EMI_AMOUNT) "EMI AMOUNT",SUM(A.PRI_AMOUNT) "PRIN AMOUNT",SUM(A.INT_AMOUNT) "INT AMOUNT",SUM(A.CLOSE_BAL_AMT) "CLOSE BAL AMOUNT",
NULL "REPORT_HEADER1", NULL "EMP CODE1",NULL "EMPLOYEE NAME1",NULL,NULL "LOAN TAKEN MONTH1",
NULL "LOAN AMOUNT1",NULL "LOAN EMI AMOUNT1",NULL "LOAN PRIN AMOUNT1",NULL "LOAN INT AMOUNT1",NULL "EMI TILL DATE1",
NULL "PRIN TILL DATE1",NULL "INT TILL DATE1",NULL "OPEN BALANCE1", NULL "EMI AMOUNT1",
NULL "PRIN AMOUNT1",NULL "INT AMOUNT1",NULL "CLOSE BAL AMOUNT1"'
    ;
    strUnion1:=strUnion1||strFrom||strWhere;
    strUnion2:=' ';
    --        strOrderBy := ') ORDER BY ';
    --        strOrderBy := strOrderBy||strBatchOrderBy||' LOCATION';
    strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
    strSqlQuery:=strSelectClause||strSqlQuery||strUnion1||strUnion2;


    OPEN Return_Recordset FOR strSqlQuery;

    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE CLAIM_REPORT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    strSqlQuery :=
    'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,null, null,null,null,null,null,null,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''', null,null ,null, null,null,null ,null, null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null, null,null,null,null,null,null,
''RH'' REPORT_HEADER,'''
    ||strGetRptName||
    ''', null,null ,null, null,null,null ,null, null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,
''DH'' REPORT_HEADER1, ''EMP CODE'', ''EMP NAME'',''PAY MONTH'' ,''CLAIM TYPE'', ''CLAIM DATE'',''CLAIM AMOUNT'',''REJECT AMOUNT'',
''APPROVE AMOUNT'' ,''SUPPORT AMOUNT'', ''TDS AMOUNT'',''TAXABLE AMOUNT'',
''TAXFREE AMOUNT'',''CREDITABLE'' FROM DUAL UNION ALL '
    ;
    strSelect := ' SELECT * FROM (SELECT ''AC'' "REPORT HEADER",';
    strSelect := strSelect||strBatchSelect||
    ' C.EMP_MID "EMP CODE",C.EMP_NAME "EMP NAME",A.PAY_MONTH "PAY MONTH",B.PARA_DESC "CLAIM TYPE",TO_CHAR(A.CLAIM_DATE,''DD-MM-YYYY'') "CLAIM DATE",A.CLAIM_AMT "CLAIM_AMT",A.REJECT_AMT "REJECT AMOUNT",'
    ;
    strSelect := strSelect||
    'A.APPROVE_AMT "APPROVE AMOUNT",A.SUPP_AMT "SUPPORT AMOUNT",A.TDS_AMT "TDS AMOUNT",A.TAXABLE_AMT "TAXABLE AMOUNT",A.TAXFREE_AMT "TAXFREE AMOUNT",A.CREDITABLE "CREDITABLE",
NULL "REPORT HEADER1",NULL "EMP CODE1",NULL "EMP NAME1",NULL "PAY MONTH1",NULL "CLAIM TYPE1",NULL "CLAIM DATE1",NULL "CLAIM_AMT1",NULL "REJECT AMOUNT1",NULL "APPROVE AMOUNT1",
NULL "SUPPORT AMOUNT1",NULL "TDS AMOUNT1",NULL "TAXABLE AMOUNT1",NULL "TAXFREE AMOUNT1",NULL "CREDITABLE1"'  ;
    strFrom  := ' FROM PY_PT_CLAIMS_DT A, PY_GM_PARAMETERS B, PY_GM_EMPMAST C';
--    strWhere := ' WHERE A.CLAIM_TYPE=B.PAR_AID AND A.COMP_AID=C.COMP_AID AND A.EMP_AID=C.EMP_AID AND A.PAY_MONTH=C.PROCESS_MONTH AND C.PAY_MONTH IS NOT NULL';
    strWhere := ' WHERE A.CLAIM_TYPE=B.PAR_AID AND A.COMP_AID=C.COMP_AID AND A.EMP_AID=C.EMP_AID AND (TO_DATE(01||A.PAY_MONTH) BETWEEN '''||pFrom_Date||''' AND '''||pTo_Date||''')';
    strWhere := strWhere || ' AND A.COMP_AID='''||pComp_Aid||''' AND A.ACC_YEAR='''||pACC_YEAR||''' ';
    strWhere := strWhere ||strBatchWhere;
    IF TRIM
      (
        pIsMultipleSheet
      )
               ='Y' THEN
      strWhere:=strWhere||' AND '||REPLACE
      (
        GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','C.'
      )
      ;
    END IF;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      --            strWhere:=strWhere||chr(13)||'  AND A.EMP_AID IN (SELECT
      -- EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND
      -- SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN TRIM(
      -- pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||''' AND
      -- COMP_AID='''||pComp_Aid||''')';
      strWhere:=strWhere||chr
      (
        13
      )
      ||
      '  AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy := ' ';
    strOrderBy := ' ORDER BY ';
    strOrderBy := strOrderBy||strBatchOrderBy||
    ' C.EMP_MID,A.CLAIM_DATE,B.PARA_DESC)';
    strUnion1:=' ';
    strUnion2:=' ';
    --        strOrderBy := ') ORDER BY ';
    --        strOrderBy := strOrderBy||strBatchOrderBy||' LOCATION';
    strSqlQuery:=strSqlQuery||strSelect||strFrom||strWhere||strGroupBy||
    strOrderBy;
    strSqlQuery:=strSqlQuery||strUnion1||strUnion2;
    OPEN Return_Recordset FOR strSqlQuery;



    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE LWP_REPORT
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strselectClause LONG;
    strSqlQuery1 LONG;
    strGetCompName LONG;
    strGetRptName LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    IF pReportType='Excel' THEN
      strSelect  := 'SELECT ';
      strSelect  := strSelect||strBatchSelect||
      '''AC'' REPORT_HEADER, B.EMP_MID "EMP CODE",B.EMP_NAME "EMPLOYEE NAME", A.PAY_MONTH "PAY MONTH",A.REC_MONTH "ARREAR MONTH",TO_CHAR(A.EFF_FROM_DATE) "FROM DATE",TO_CHAR(A.EFF_TO_DATE) "TO DATE",C.PARA_DESC "ABSENT TYPE",to_char(A.DAYS_ABSENT) "DAYS" '
      ;
      --            strFrom := ' FROM PY_PT_ABSENT A, PY_PT_SAL_HD B,
      -- PY_GM_PARAMETERS C';
      --            strWhere := ' WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=
      -- B.EMP_AID AND A.PAY_MONTH=B.PROCESS_MONTH AND A.ABSENT_TYPE=C.PAR_AID
      -- AND B.PAY_MONTH IS NOT NULL';
      strFrom  := ' FROM PY_PT_ABSENT A, PY_GM_EMPMAST B, PY_GM_PARAMETERS C';
      strWhere :=
      ' WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND A.ABSENT_TYPE=C.PAR_AID '
      ;
      strWhere := strWhere || ' AND A.COMP_AID='''||pComp_Aid||
      ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
      ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
      IF TRIM
        (
          pIsMultipleSheet
        )
                 ='Y' THEN
        strWhere:=strWhere||' AND '||REPLACE
        (
          GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','B.'
        )
        ;
      END IF;
      strselectClause :=strselectClause||
      '  ,NULL "REPORT_HEADER1",NULL "EMP CODE1",NULL "EMPLOYEE NAME1", NULL "PAY MONTH1",NULL "ARREAR MONTH1",NULL "FROM DATE1",NULL "TO DATE1",NULL "ABSENT TYPE1",NULL "DAYS1" '
      ;
    ELSE
      strSelect := 'SELECT ';
      strSelect := strSelect||
      ' B.EMP_MID "EMP CODE",B.EMP_NAME "EMPLOYEE NAME", A.PAY_MONTH "PAY MONTH",A.REC_MONTH "ARREAR MONTH",A.EFF_FROM_DATE "FROM DATE",A.EFF_TO_DATE "TO DATE",C.PARA_DESC "ABSENT TYPE",to_char(A.DAYS_ABSENT) "DAYS" '
      ;
      --            strFrom := ' FROM PY_PT_ABSENT A, PY_PT_SAL_HD B,
      -- PY_GM_PARAMETERS C';
      --            strWhere := ' WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=
      -- B.EMP_AID AND A.PAY_MONTH=B.PROCESS_MONTH AND A.ABSENT_TYPE=C.PAR_AID
      -- AND B.PAY_MONTH IS NOT NULL';
      strFrom  := ' FROM PY_PT_ABSENT A, PY_GM_EMPMAST B, PY_GM_PARAMETERS C';
      strWhere :=
      ' WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND A.ABSENT_TYPE=C.PAR_AID '
      ;
      strWhere := strWhere || ' AND A.COMP_AID='''||pComp_Aid||
      ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
      ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
    END IF;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
      )
      ;
      --            strWhere:=strWhere||chr(13)||'  AND A.EMP_AID IN (SELECT
      -- EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND
      -- SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN TRIM(
      -- pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||''' AND
      -- COMP_AID='''||pComp_Aid||''')';
      strWhere:=strWhere||chr
      (
        13
      )
      ||
      '  AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strSqlQuery1 :=
    'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null,null,null,null,null,
''RH'' REPORT_HEADER1,'''
    ||strGetCompName||
    ''',null ,null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null,null,null,null,null,
''RH'' REPORT_HEADER, '''
    ||strGetRptName||
    ''',null,null,null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null,null,null,null,null,
''DH'' REPORT_HEADER1, ''EMP CODE'',''EMPLOYEE NAME'' ,''PAY MONTH'', ''ARREAR MONTH'',''FROM DATE'',
''TO DATE'',''ABSENT TYPE'',''DAYS''  FROM DUAL UNION ALL '
    ;
    strGroupBy := '';
    strOrderBy := ' ORDER BY ';
    strOrderBy := strOrderBy||strBatchOrderBy||
    ' B.EMP_MID,TO_DATE(01||A.PAY_MONTH),TO_DATE(01||A.REC_MONTH),A.EFF_FROM_DATE)'
    ;
    strUnion1:=' ';
    strUnion2:=' ';
    --        strOrderBy := ') ORDER BY ';
    --        strOrderBy := strOrderBy||strBatchOrderBy||' LOCATION';
    IF pReportType='Crystal' OR pReportType='View' THEN
      strSqlQuery:='SELECT * FROM ('||strSelect||strFrom||strWhere||strGroupBy
      ||strOrderBy;
    ELSE
      strSqlQuery:=strSqlQuery1||'SELECT * FROM ('||strSelect||strselectClause
      ||strFrom||strWhere||strGroupBy||strOrderBy;
    END IF;
    strSqlQuery:=strSqlQuery||strUnion1||strUnion2;


    OPEN Return_Recordset FOR strSqlQuery;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE BALANCE_TAX_REPORT--(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month
  -- VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId
  -- VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport
  -- VARCHAR2,pIsMultipleSheet  arrTyp_Batch_Id,pFilterId VARCHAR2,
  -- Return_Recordset OUT REC)
  (
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
    Return_Recordset OUT REC
  )
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSelect LONG;
    strFrom LONG;
    strWhere LONG;
    strGroupBy LONG;
    strOrderBy LONG;
    strBatchSelect LONG;
    /*for batch wise report*/
    strBatchWhere LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1 LONG;
    /* UNION QUERY 1*/
    strUnion2 LONG;
    /* UNION QUERY 2*/
    strGetCompName LONG;
    strGetRptName LONG;
    strSelectClause LONG;
    strSqlQuery1 LONG;
    strHeadClause LONG;
  BEGIN
    GET_REPORT_DTL
    (
      pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
      strGetCompName,strGetRptName
    )
    ;
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'A.BATCH_ID,';
      strBatchWhere  :=
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
      strBatchGroupBy := ' A.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;
    IF pReportType   ='Excel' THEN
      strHeadClause :=
      'SELECT ''AC'' "REPORT_HEADER",EMP_MID "EMPLOYEE CODE",EMP_NAME "EMPLOYEE NAME",COLUMN3 "BALANACE TAX AMOUNT" '
      ;
      strSelect := strSelect||strBatchSelect||
      'FROM (SELECT EMP_MID,EMP_NAME,COLUMN3 FROM  (SELECT  A.EMP_MID ,A.EMP_NAME ,A.COLUMN3  '
      ;
      strFrom  := ' FROM PY_VW_TAXSHEET A,PY_PT_SAL_HD B';
      strWhere :=
      ' WHERE  A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND A.PROCESS_MONTH=B.PROCESS_MONTH AND A.COMP_AID='''
      ||pComp_Aid||
      ''' AND UPPER(A.DESCRIPTION)=''BALANCE TAX PAYABLE'' AND A.COLUMN3<>0 AND NVL(TO_DATE(01||A.PAY_MONTH),TO_DATE(01||A.PROCESS_MONTH))>='''
      ||pFrom_Date||
      ''' AND NVL(LAST_DAY(TO_DATE(01||A.PAY_MONTH)),LAST_DAY(TO_DATE(01||A.PROCESS_MONTH)))<='''
      ||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
      IF TRIM
        (
          pIsMultipleSheet
        )
                 ='Y' THEN
        strWhere:=strWhere||' AND '||REPLACE
        (
          GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','B.'
        )
        ;
      END IF;
      /*to generate the report for the Employees as per the Filter ID*/
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY
        (
          pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
          pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
        )
        ;
        --            strWhere:=strWhere||chr(13)||'  AND A.EMP_AID IN (SELECT
        -- EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND
        -- SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN TRIM(
        -- pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||''' AND
        -- COMP_AID='''||pComp_Aid||''')';
        strWhere:=strWhere||chr
        (
          13
        )
        ||
        '  AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      strGroupBy := '';
      strOrderBy := ' ORDER BY ';
      strOrderBy := strOrderBy||strBatchOrderBy||' EMP_MID))';
      strUnion1  :=
      ' UNION ALL SELECT ''DH'' "REPORT_HEADER", ''TOTAL'' EMP_MID , TO_CHAR(COUNT(*)) EMP_NAME,SUM(COLUMN3) COLUMN3,NULL,NULL,NULL,NULL '
      ;
      strUnion1    :=strUnion1||strFrom||strWhere;
      strUnion2    :=' ';
      strSqlQuery1 :=
      'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,
''RH'' REPORT_HEADER1,'''
      ||strGetCompName||
      ''',null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null,null,
''RH'' REPORT_HEADER, '''
      ||strGetRptName||
      ''',null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null,null,null,
''DH'' REPORT_HEADER1, ''EMPLOYEE CODE'',''EMPLOYEE NAME'' ,''BALANACE TAX AMOUNT'' FROM DUAL UNION ALL '
      ;
      strSelectClause :=strSelectClause||
      ' ,NULL "REPORT_HEADER1",NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1",NULL "BALANACE TAX AMOUNT1" '
      ;
    ELSIF pReportType='Crystal' OR pReportType='View' THEN
      strHeadClause :=
      'SELECT EMP_MID "EMPLOYEE CODE",EMP_NAME "EMPLOYEE NAME",COLUMN3 "BALANACE TAX AMOUNT" '
      ;
      strSelect := strSelect||strBatchSelect||
      'FROM (SELECT EMP_MID,EMP_NAME,COLUMN3 FROM  (SELECT  A.EMP_MID ,A.EMP_NAME ,A.COLUMN3  '
      ;
      strFrom  := ' FROM PY_VW_TAXSHEET A,PY_PT_SAL_HD B';
      strWhere :=
      ' WHERE  A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND A.PROCESS_MONTH=B.PROCESS_MONTH AND A.COMP_AID='''
      ||pComp_Aid||
      ''' AND UPPER(A.DESCRIPTION)=''BALANCE TAX PAYABLE'' AND A.COLUMN3<>0 AND NVL(TO_DATE(01||A.PAY_MONTH),TO_DATE(01||A.PROCESS_MONTH))>='''
      ||pFrom_Date||
      ''' AND NVL(LAST_DAY(TO_DATE(01||A.PAY_MONTH)),LAST_DAY(TO_DATE(01||A.PROCESS_MONTH)))<='''
      ||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
      --        IF TRIM(pIsMultipleSheet) ='Y' THEN
      --                   strWhere:=strWhere||' AND '||REPLACE(GET_CONDITION(
      -- pMasterType , pMultiSheetCondition),'HD.','B.');
      --
      --
      --         END IF;
      /*to generate the report for the Employees as per the Filter ID*/
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY
        (
          pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
          pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
        )
        ;
        --            strWhere:=strWhere||chr(13)||'  AND A.EMP_AID IN (SELECT
        -- EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND
        -- SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN TRIM(
        -- pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||''' AND
        -- COMP_AID='''||pComp_Aid||''')';
        strWhere:=strWhere||chr
        (
          13
        )
        ||
        '  AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      strGroupBy := '';
      strOrderBy := ' ORDER BY ';
      strOrderBy := strOrderBy||strBatchOrderBy||' EMP_MID))';
      strUnion1  :=
      ' UNION ALL SELECT ''TOTAL'' EMP_MID , TO_CHAR(COUNT(*)) EMP_NAME,SUM(COLUMN3) COLUMN3 '
      ;
      strUnion1:=strUnion1||strFrom||strWhere;
      strUnion2:=' ';
      --         strSqlQuery1 := 'SELECT '''||strGetCompName||''',null,null
      -- FROM DUAL
      --                      UNION ALL
      --                          SELECT '''||strGetRptName||''',null,null FROM
      -- DUAL
      --                      UNION ALL
      --                          SELECT ''EMPLOYEE CODE'',''EMPLOYEE NAME'' ,'
      -- 'BALANACE TAX AMOUNT'' FROM DUAL UNION ALL ';
      --         strSelectClause :=strSelectClause||' ,NULL "REPORT_HEADER1",
      -- NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1",NULL "BALANACE TAX AMOUNT1
      -- " ';
     END IF;
    strSqlQuery:=strSqlQuery1||strHeadClause||strSelectClause||strSelect||
    strFrom||strWhere||strGroupBy||strOrderBy;
    strSqlQuery:=strSqlQuery||strUnion1||strUnion2;
    OPEN Return_Recordset FOR strSqlQuery;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'SUCCESS'
    )
    ;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
    )
    ;
  END;
PROCEDURE EARNING_DEDCUTION_SUMMARY_RPT
  (
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
    pMultiSheetCondition VARCHAR2,
    Return_Recordset OUT REC
  )
IS
  strSqlQuery LONG;
  strSelect LONG;
  strFrom LONG;
  strWhere LONG;
  strGroupBy LONG;
  strOrderBy LONG;
  strBatchSelect LONG;
  /*for batch wise report*/
  strBatchWhere LONG;
  /*    -||-      */
  strBatchGroupBy LONG;
  /*    -||-      */
  strBatchOrderBy LONG;
  /*    -||-      */
  strUnion1 LONG;
  /* UNION QUERY 1*/
  strUnion2 LONG;
  /* UNION QUERY 2*/
BEGIN
  --Inserting data into Temporary tables
  IF pIsBatchWiseReport = 'Y' THEN
    --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
    -- ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
    -- pIsMultipleSheet,pFilterId);
    strBatchSelect := 'BATCH_ID,';
    strBatchWhere  :=
    ' AND BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
    ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
    strBatchGroupBy := ' BATCH_ID,';
    strBatchOrderBy := ' ,BATCH_ID,';
  END IF;
  strSelect := 'SELECT * FROM (SELECT';
  strSelect := strSelect||strBatchSelect||
  ' ALLWDED_DESC "EARN / DEDUCTION DESCRIPTION",DECODE(CTC_TYPE,''A'',''Earn'',''Dedn'') CTC_TYPE,SUM(DECODE(CTC_TYPE,''A'',AMOUNT,0)) EARNING,SUM(DECODE(CTC_TYPE,''D'',AMOUNT,0)) DEDUCTION,NULL "NET PAY" ,COUNT(DISTINCT EMP_AID) "EMP COUNT",A.GL_CODE "ACC CODE"'
  ;
  strFrom  := ' FROM PY_VW_EMPLOYEE_SALARY A';
  strWhere := ' WHERE ';
  strWhere := strWhere || ' A.COMP_ID='''||pComp_Aid||''' AND A.ACC_YEAR='''||
  pAcc_Year||''' AND ARR_FLAG<>''F'' ';
  strWhere := strWhere || ' AND A.PROC_DATE>='''||pFrom_Date||
  ''' AND LAST_DAY(A.PROC_DATE)<='''||pTo_Date||
  ''' AND A.PAY_MONTH IS NOT NULL';
  strWhere := strWhere ||strBatchWhere;
  /*to generate the report for the Employees as per the Filter ID*/
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY
    (
      pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId
    )
    ;
    strWhere:=strWhere||chr
    (
      13
    )
    ||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strGroupBy := ' GROUP BY ';
  strGroupBy := strGroupBy||strBatchGroupBy||
  ' PAY_MONTH,CTC_TYPE,ALLWDED_DESC,A.SORT_ORDER,A.GL_CODE';
  strUnion1:=' UNION ALL SELECT '||strBatchSelect||
  '''GRAND TOTAL'',NULL,SUM(DECODE(CTC_TYPE,''A'',AMOUNT,0)) EARNING,SUM(DECODE(CTC_TYPE,''D'',AMOUNT,0)) DEDUCTION,NULL NET_PAY,COUNT(DISTINCT EMP_AID) EMP_COUNT,NULL ACC_CD'
  ;
  strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||
  ' A.COMP_ID';
  strUnion2  :=' ';
  strOrderBy := ' ORDER BY ';
  strOrderBy := strOrderBy||' CTC_TYPE DESC,SORT_ORDER ASC '||strBatchOrderBy||
  ',ALLWDED_DESC)';
  strSqlQuery:=strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
  strSqlQuery:=strSqlQuery||strUnion1;
  OPEN Return_Recordset FOR strSqlQuery;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
END;
PROCEDURE FORM12C_CHECKLIST_RPT
  (
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
    Return_Recordset OUT REC
  )
AS
  STR1              LONG;
  STR2              LONG;
  STR3              LONG;
  STR4              LONG;
  V_NO              NUMBER;
  V_NO2             NUMBER;
  strBatchSelect    LONG;
  strBatchWhere     LONG;
  strBatchGroupBy   LONG;
  strBatchOrderBy   LONG;
  strBatchC         LONG;
  strBatchI         LONG;
  strBatchSelect2   LONG;
  strBatchSelect3   LONG;
  strEMPSelect      LONG;
  strNullHead       LONG;
  strSqlQuery       LONG;
  strGetCompName    LONG;
  strGetRptName     LONG;
  vCount            NUMBER;
  str12CHead        LONG;
  strSelectClause   LONG;
  strOrderByClause  LONG;
  strselect         LONG;
  strFromClause     LONG;
  strWhereClause    LONG;
  strGroupByClause  LONG;
BEGIN
  GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,
                strGetCompName,strGetRptName);

  IF pIsBatchWiseReport = 'Y' THEN
    --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
    -- ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
    -- pIsMultipleSheet,pFilterId);
    strBatchC      := ' BATCH_ID VARCHAR2(100), ';
    strBatchI      := 'BATCH_ID,' ;
    strBatchSelect := 'BATCH_ID,';

    strBatchWhere  := ' AND T1.BATCH_ID IN (
                      SELECT BT.BATCH_ID
                      FROM PY_GTMP_BATCH_ID BT
                      WHERE USER_AID='''||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';

    strBatchGroupBy := ' BATCH_ID,';
    strBatchOrderBy := ' BATCH_ID,';
    strBatchSelect2 := 'T1.BATCH_ID,';
    strBatchSelect3 := '''TOTAL''  BATCH_ID,';
    strEMPSelect    := '''''  EMP_ID ,';
  ELSE
    strEMPSelect := '''DH'' REPORT_HEADER,''TOTAL''  EMP_ID ,';
  END IF;

  STR1   :='';
  V_NO2  :=0;
  vCount :=1;
  STR1   :='  SELECT ''AC'' REPORT_HEADER,'||strBatchSelect||'
              EMP_MID "EMPLOYEE CODE", EMP_NAME "EMPLOYEE NAME",
              TO_CHAR(JOIN_DATE) "JOIN DATE" ,LOC_DESC "LOCATION NAME" ';

  SELECT COUNT(DISTINCT T1.F12C_AID) INTO V_NO
  FROM PY_PT_F12C T1
  JOIN PY_PM_FORM12C T2
  ON(T1.F12C_AID=T2.F12C_AID);

  FOR I IN(SELECT DISTINCT T1.F12C_AID, F12C_MID, SUBSTR(T2.F12C_DESC,1,30) F12C_DESC
          FROM PY_PT_F12C T1 JOIN PY_PM_FORM12C T2 ON
          (T1.F12C_AID=T2.F12C_AID) ORDER BY F12C_AID)
  LOOP

    STR1:=STR1||',MAX(DECODE(F12C_AID,'''||I.F12C_AID||''',AMOUNT,0))'
              ||'"'||TRIM(I.F12C_MID)||'"'||'';

    STR3:=STR3||',SUM('||'"'||TRIM(I.F12C_MID)||'"'||') '
              ||'"'||TRIM(I.F12C_MID)||'"'||' ';

    IF(V_NO2 =(V_NO-1)) THEN
      STR2        :=  STR2||'MAX(DECODE(F12C_AID,'''||I.F12C_AID||''',AMOUNT,0))'||'';
      str12CHead  :=  str12CHead||''||''''||I.F12C_DESC||''''||',';
      strNullHead :=  strNullHead||',NULL "'||vCount||'_1"';
    ELSE
      STR2 :=STR2||'MAX(DECODE(F12C_AID,'''||I.F12C_AID||''',AMOUNT,0))'||'+'||'';
      str12CHead := str12CHead||''||''''||I.F12C_DESC||''''||',';
      strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
    END IF;

    V_NO2  :=V_NO2 +1;
    vCount :=vCount+1;
  END LOOP;
--       str12CHead :=str12CHead ||'''total''';
--       strNullHead:=strNullHead|| ',null "TOTAL"';
  strSqlQuery := 'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null'||
                          strNullHead||',null,
                          ''RH'' REPORT_HEADER1,'''||
                          strGetCompName||''',null ,null, null'||
                          strNullHead||',null FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null'||
                          strNullHead||',null,
                          ''RH'' REPORT_HEADER, '''||REPLACE(strGetRptName,'''','')||''',
                          null,null,null'||
                          strNullHead||',null FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null'
                          ||strNullHead||',null,
                          ''DH'' REPORT_HEADER1, ''EMPLOYEE CODE'',''EMPLOYEE NAME'' ,
                          ''JOIN DATE'', ''LOCATION NAME'','
                          ||REPLACE(str12CHead,'"','''')||'''TOTAL'' FROM DUAL
                  UNION ALL ';

  strSelectClause :=',NULL "REPORT_HEADER1",NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1" ,
                      NULL "JOIN DATE1",NULL "LOCATION NAME1"'
                      ||strNullHead||',NULL "TOTAL1" ';

  STR1:=STR1||', '||STR2||' TOTAL '||strSelectClause||
              ' FROM(SELECT '||strBatchSelect2||
                      ' T3.EMP_MID,T3.EMP_NAME,T3.JOIN_DATE,T3.LOC_DESC,T1.F12C_AID,
                        T2.F12C_DESC ,(T1.AMOUNT) AMOUNT
                        FROM  PY_PT_F12C T1 LEFT OUTER JOIN PY_PM_FORM12C T2
                        ON(T1.F12C_AID=T2.F12C_AID) JOIN PY_GM_EMPMAST T3
                        ON(T1.COMP_AID=T3.COMP_AID AND T1.EMP_AID=T3.EMP_AID) ';

  strWhereClause :=' WHERE T1.COMP_AID='''||pComp_Aid||'''
                      AND T1.ACC_YEAR = '''||pAcc_Year||''''||strBatchWhere||' ';

  IF TRIM(pIsMultipleSheet) ='Y' THEN
      strWhereClause :=strWhereClause||' AND '||REPLACE(GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','T3.');
  END IF;

  IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
      pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
      pFilterId);

      strWhereClause:=strWhereClause||chr(13)||
                      ' AND A.EMP_AID IN (SELECT EMP_AID
                        FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||'''
                        AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
                        pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;

  strGroupByClause :=' GROUP BY'||strBatchGroupBy||' EMP_MID, EMP_NAME, JOIN_DATE,LOC_DESC';

  STR1 :=STR1||strWhereClause;

  strOrderByClause:= ' ORDER BY 3)) ';

  STR4 := strSqlQuery||'SELECT * FROM ('||STR1||') '||strGroupByClause||' UNION '||' SELECT '||
          strBatchSelect3||strEMPSelect||''''' EMP_NAME ,'''' JOIN_DATE ,'''' LOC_DESC '
          ||STR3||',SUM(TOTAL) TOTAL '||strSelectClause||' FROM ('||STR1 ||') '||strGroupByClause||
          strOrderByClause||'';


OPEN RETURN_RECORDSET FOR STR4 ;


INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date
,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END;
PROCEDURE PREVIOUS_EMP_DETAILS_RPT(
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
AS
        STR1 LONG;
        STR2 LONG;
        STR3 LONG;
        STR4 LONG;
        V_NO  NUMBER;
        V_NO2 NUMBER;
        strBatchSelect LONG;
        strBatchWhere LONG;
        strBatchGroupBy LONG;
        strBatchOrderBy LONG;
        strBatchC LONG;
        strBatchI LONG;
        strBatchSelect2 LONG;
        strBatchSelect3 LONG;
        strEMPSelect LONG;
        vCount NUMBER;
        str12BHead LONG;
        strSelectClause LONG;
        strOrderByClause LONG;
        strselect LONG;
        strNullHead LONG;
        strSqlQuery LONG;
        strGetCompName LONG;
        strGetRptName LONG;
        strWhereClause LONG;
        strGroupByClause LONG;
  BEGIN

      GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);

      IF pIsBatchWiseReport = 'Y' THEN

          strBatchC       := ' BATCH_ID VARCHAR2(100), ';
          strBatchI       := ' BATCH_ID,' ;
          strBatchSelect  := ' BATCH_ID,';
          strBatchWhere   := ' AND T1.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
                               ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
          strBatchGroupBy := ' BATCH_ID,';
          strBatchOrderBy := ' BATCH_ID,';
          strBatchSelect2 := ' T1.BATCH_ID,';
          strBatchSelect3 := ' ''TOTAL''  BATCH_ID,';
          strEMPSelect    := ' ''''  EMP_ID ,';
      ELSE
          strEMPSelect := ' ''DH'' REPORT_HEADER, ''TOTAL''  EMP_ID ,';
      END IF;

      V_NO2  :=0;
      vCount :=1;

      STR1   :=' SELECT ''AC'' REPORT_HEADER, '||strBatchSelect||' EMP_MID "EMPLOYEE CODE", EMP_NAME "EMPLOYEE NAME",
                 TO_CHAR(JOIN_DATE) "JOIN DATE",LOC_DESC "LOCATION NAME" ';

      SELECT COUNT(DISTINCT ALLWDED_AID)
        INTO V_NO
      FROM PY_PT_F12B A,PY_CTC_ALLOWANCE_MAST B
      WHERE A.COMP_AID     =B.COMP_ID
        AND A.ALLWDED_AID=B.CTC_CODE;

      FOR I IN
      (
        SELECT DISTINCT ALLWDED_AID,SUBSTR(REPLACE(B.CTC_NAME,'''',''),1,30) CTC_NAME
        FROM PY_PT_F12B A,PY_CTC_ALLOWANCE_MAST B
        WHERE A.COMP_AID     =B.COMP_ID
          AND A.ALLWDED_AID=B.CTC_CODE
      )
      LOOP
          STR1:=STR1||',TO_CHAR(MAX(DECODE(ALLWDED_AID,'''||I.ALLWDED_AID||''',AMOUNT,0)))'||'"'||I.CTC_NAME||'"'||'';
          STR3:=STR3||',TO_CHAR(SUM('||'"'||I.CTC_NAME||'"'||')) '||'"'||I.CTC_NAME||'"'||' ';
          IF(V_NO2=(V_NO)+1) THEN
            STR2 :=STR2||'MAX(DECODE(ALLWDED_AID,'''||I.ALLWDED_AID||''',AMOUNT,0))'||'';
            str12BHead := str12BHead||''||''''||I.CTC_NAME||''''||',';
            strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
          ELSE
            STR2:=STR2||' + '||'MAX(DECODE(ALLWDED_AID,'''||I.ALLWDED_AID||''',AMOUNT,0))';
            str12BHead := str12BHead||''||''''||I.CTC_NAME||''''||',';
            strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
          END IF;
          V_NO2  :=V_NO2  +1;
          vCount :=vCount +1;
      END LOOP;

      strSqlQuery := '  SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null'||strNullHead||',null,
                        ''RH'' REPORT_HEADER1,'''||strGetCompName||''',null ,null, null'||strNullHead||',null FROM DUAL
                        UNION ALL
                        SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null' ||strNullHead|| ',null,
                        ''RH'' REPORT_HEADER, '''||strGetRptName||''',null,null,null'||strNullHead||',null  FROM DUAL
                        UNION ALL
                        SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null'||strNullHead||',null,
                        ''DH'' REPORT_HEADER1, ''EMPLOYEE CODE'',''EMPLOYEE NAME'' ,''JOIN DATE'', ''LOCATION NAME'',
                        ' ||REPLACE(str12BHead,'"','''')||'''TOTAL'' FROM DUAL UNION ALL ';

      strSelectClause := ',NULL "REPORT_HEADER1",NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1" ,NULL "JOIN DATE1",NULL "LOCATION NAME1,"
                         '||strNullHead||',NULL "TOTAL1" ';

      strOrderByClause:= ' ORDER BY 3) ';


--          STR1 :=STR1||', '||STR2||' TOTAL '||strSelectClause ;
      STR1 :=STR1||', Amount TOTAL '||strSelectClause ;

      STR1 :=STR1|| ' FROM(
          SELECT '||strBatchSelect2||' T3.EMP_MID,T3.EMP_NAME,T3.JOIN_DATE,T3.LOC_DESC,T1.ALLWDED_AID,T2.CTC_NAME ,SUM(T1.AMOUNT) AMOUNT
          FROM  PY_PT_F12B T1
          LEFT OUTER JOIN PY_CTC_ALLOWANCE_MAST T2
          ON(T1.ALLWDED_AID=T2.CTC_CODE)
          JOIN PY_GM_EMPMAST T3
          ON(T1.COMP_AID=T3.COMP_AID AND T1.EMP_AID=T3.EMP_AID ) '  ;

      strWhereClause :=' WHERE T1.COMP_AID='''||pComp_Aid|| ''' AND T1.ACC_YEAR = '''||pAcc_Year||''''||strBatchWhere||' ';

  IF TRIM(pIsMultipleSheet) ='Y' THEN
    strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
    pMasterType , pMultiSheetCondition),'HD.','T3.');
  END IF;
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,  pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet, pFilterId);
    --                   strWhereClause:=strWhereClause||chr(13)||' AND
    -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
    -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
    -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
    -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
    strWhereClause:=strWhereClause||chr(13)||' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID=''' ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
--  strWhereClause:=strWhereClause|| ' AND T3.PAY_MONTH IS NOT NULL AND TO_DATE(01||T3.PROCESS_MONTH)>='''||  pFrom_Date||''' AND LAST_DAY(TO_DATE(01||T3.PROCESS_MONTH))<='''||pTo_Date|| ''')';

  strGroupByClause :=strGroupByClause || 'GROUP BY'||strBatchGroupBy||' EMP_MID, EMP_NAME, JOIN_DATE,LOC_DESC,ALLWDED_AID,CTC_NAME )';

  Str1 :=Str1||Strwhereclause||Strgroupbyclause;

  STR4 :=strSqlQuery||'SELECT * FROM ( '||STR1||' UNION '||STR1 || strOrderByClause||'';


  OPEN RETURN_RECORDSET FOR STR4 ;

  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END;
PROCEDURE ESIC_MC_RPT(
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
AS
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strSQLQuery LONG;
  strGetCompName LONG;
  strGetRptName LONG;
BEGIN
  GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date
  ,strGetCompName,strGetRptName);
  strSqlQuery :=
  'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null,null,null,
''RH'' REPORT_HEADER1,'''
  ||strGetCompName||
  ''',null ,null, null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null,null,null,null,null,
''RH'' REPORT_HEADER, '''
  ||strGetRptName||
  ''',null,null,null,null,null  FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null,null,null,
''DH'' REPORT_HEADER1, ''IP Number (10 Digits)'',''IP Name'' ,''No of Present Days'', ''Total Monthly Wages'',
''Reason Code For 0 Working Days'',''Last Working Day'' FROM DUAL UNION ALL '
  ;
  strSelectClause :=
  'SELECT ''AC'' "REPORT_HEADER",A.ESIC_NO as "IP Number (10 Digits)",A.EMP_NAME as "IP Name",B.DAYS_PRESENT as "No of Present Days",SUM(NVL(D.AMOUNT,0)) as "Total Monthly Wages",
0 as "Reason Code For 0 Working Days",TO_CHAR(A.LEAVE_DATE,''dd-mm-yyyy'') as "Last Working Day",
NULL "REPORT_HEADER",NULL as "IP Number (10 Digits)",NULL as "IP Name",NULL as "No of Present Days",
NULL as "Total Monthly Wages",NULL as "Reason Code For 0 Working Days",NULL as "Last Working Day"   '
  ;
  strFromClause :=
  'FROM PY_GM_EMPMAST A,PY_PT_PRESENT B,PY_CTC_ALLOWANCE_MAST C,PY_VW_PT_SAL_DT D,
(SELECT DISTINCT EMP_AID FROM PY_VW_PT_SAL_DT A,PY_CTC_ALLOWANCE_MAST B
WHERE A.COMP_AID=B.COMP_ID AND A.ALLWDED_aID=B.CTC_CODE AND TRIM(B.CTC_MID)=''ESI''
AND TO_DATE(01||A.PROCESS_MONTH)>='''
  ||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
  '''
--AND A.PAY_MONTH='''||pPay_Month||
  '''
AND A.ACC_YEAR='''||pAcc_Year||
  ''' AND A.COMP_AID='''||pComp_Aid||''') E ';
  strWhereClause :=
  'WHERE A.COMP_AID=B.COMP_AID AND A.COMP_AID=C.COMP_ID AND A.COMP_AID=D.COMP_AID AND C.CTC_CODE = D.ALLWDED_AID
AND A.EMP_AID=B.EMP_AID AND A.EMP_AID=D.EMP_AID AND B.PAY_MONTH=D.PAY_MONTH AND B.ACC_YEAR=D.ACC_YEAR
--                        AND D.PROCESS_MONTH='''
  ||pPay_Month||'''
AND D.ACC_YEAR='''||pAcc_Year||
  ''' AND C.ESIC_FLAG=1
AND C.CTC_TYPE=''A'' AND A.COMP_AID='''
  ||pComp_Aid||''' AND A.EMP_AID=E.EMP_AID ';
  strWhereClause:=strWhereClause||' AND TO_DATE(01||D.PROCESS_MONTH)>='''||
  pFrom_Date||''' AND LAST_DAY(TO_DATE(01||D.PROCESS_MONTH))<='''||pTo_Date||
  '''';
  IF TRIM(pIsMultipleSheet) ='Y' THEN
    strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
    pMasterType , pMultiSheetCondition),'HD.','T3.');
  END IF;
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    --                   strWhereClause:=strWhereClause||chr(13)||' AND
    -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
    -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
    -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
    -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strGroupByClause :='GROUP BY A.ESIC_NO,A.EMP_NAME,B.DAYS_PRESENT,LEAVE_DATE '
  ;
  strSQLQuery :=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strGroupByClause;
  OPEN RETURN_RECORDSET FOR strSQLQuery;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED '||SQLERRM);
END;
PROCEDURE ECR_PF_RPT(
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
AS
  strGetCompName LONG;
  strGetRptName LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strSQLClause LONG;
  strGroupClause LONG;
BEGIN
  GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date
  ,strGetCompName,strGetRptName);
  IF pReportType  ='Excel' OR pReportType='View' THEN
    strSQLClause :=
    ' SELECT ''X#X#X'' "REPORT_HEADER", NULL "Member ID",NULL "Member Name",NULL "EPF Wages",NULL "EPS Wages",NULL "EPF_SHARE",NULL "EPF_REMITTED",
NULL "EPS_SHARE",  NULL "EPS_REMITTED",NULL "DIFF_EPF_EPS_SHARE" ,NULL "DIFF_EPF_EPS_REMITTED" ,NULL "NCP Days",NULL "Refund Of Advances",
NULL "Arrear EPF Wages",NULL "Arrear EPF EE Share",NULL "Arrear EPF ER Share",NULL "Arrear EPS Share",NULL "Father/Husband Name",
NULL "Relation With Member",NULL "Date Of Birth",NULL "Gender",NULL  "Date Of Joining EPF",NULL "Date Of Joining EPS",
NULL "Date Of Exit From EPF", NULL "Date Of Exit From EPS" ,NULL "Reason For Leaving",
''RH'' "REPORT_HEADER1",'''
    ||strGetCompName||
    ''' "Member ID1",NULL "Member Name1",NULL "EPF Wages1",NULL "EPS Wages1",NULL "EPF_SHARE1",NULL "EPF_REMITTED1",
NULL "EPS_SHARE1",  NULL "EPS_REMITTED",NULL "DIFF_EPF_EPS_SHARE" ,NULL "DIFF_EPF_EPS_REMITTED" ,NULL "NCP Days",NULL "Refund Of Advances",
NULL "Arrear EPF Wages",NULL "Arrear EPF EE Share",NULL "Arrear EPF ER Share",NULL "Arrear EPS Share",NULL "Father/Husband Name",
NULL "Relation With Member",NULL "Date Of Birth",NULL "Gender",NULL  "Date Of Joining EPF",NULL "Date Of Joining EPS",
NULL "Date Of Exit From EPF", NULL "Date Of Exit From EPS" ,NULL "Reason For Leaving" FROM DUAL UNION ALL
SELECT ''X#X#X'' "REPORT_HEADER", NULL "Member ID",NULL "Member Name",NULL "EPF Wages",NULL "EPS Wages",NULL "EPF_SHARE",NULL "EPF_REMITTED",
NULL "EPS_SHARE",  NULL "EPS_REMITTED",NULL "DIFF_EPF_EPS_SHARE" ,NULL "DIFF_EPF_EPS_REMITTED" ,NULL "NCP Days",NULL "Refund Of Advances",
NULL "Arrear EPF Wages",NULL "Arrear EPF EE Share",NULL "Arrear EPF ER Share",NULL "Arrear EPS Share",NULL "Father/Husband Name",
NULL "Relation With Member",NULL "Date Of Birth",NULL "Gender",NULL  "Date Of Joining EPF",NULL "Date Of Joining EPS",
NULL "Date Of Exit From EPF", NULL "Date Of Exit From EPS" ,NULL "Reason For Leaving",
''RH'' "REPORT_HEADER1",'''
    ||strGetRptName||
    ''' "Member ID",NULL "Member Name",NULL "EPF Wages",NULL "EPS Wages",NULL "EPF_SHARE",NULL "EPF_REMITTED",
NULL "EPS_SHARE",  NULL "EPS_REMITTED",NULL "DIFF_EPF_EPS_SHARE" ,NULL "DIFF_EPF_EPS_REMITTED" ,NULL "NCP Days",NULL "Refund Of Advances",
NULL "Arrear EPF Wages",NULL "Arrear EPF EE Share",NULL "Arrear EPF ER Share",NULL "Arrear EPS Share",NULL "Father/Husband Name",
NULL "Relation With Member",NULL "Date Of Birth",NULL "Gender",NULL  "Date Of Joining EPF",NULL "Date Of Joining EPS",
NULL "Date Of Exit From EPF", NULL "Date Of Exit From EPS" ,NULL "Reason For Leaving" FROM DUAL UNION ALL
SELECT ''X#X#X'' "REPORT_HEADER", NULL "Member ID",NULL "Member Name",NULL "EPF Wages",NULL "EPS Wages",NULL "EPF_SHARE",NULL "EPF_REMITTED",
NULL "EPS_SHARE",  NULL "EPS_REMITTED",NULL "DIFF_EPF_EPS_SHARE" ,NULL "DIFF_EPF_EPS_REMITTED" ,NULL "NCP Days",NULL "Refund Of Advances",
NULL "Arrear EPF Wages",NULL "Arrear EPF EE Share",NULL "Arrear EPF ER Share",NULL "Arrear EPS Share",NULL "Fathers/Husbands Name",
NULL "Relation With Member",NULL "Date Of Birth",NULL "Gender",NULL  "Date Of Joining EPF",NULL "Date Of Joining EPS",
NULL "Date Of Exit From EPF", NULL "Date Of Exit From EPS" ,NULL "Reason For Leaving",
''DH'' "REPORT_HEADER1", ''Member ID'',''Member Name'', ''EPF Wages'', ''EPS Wages'', ''EPF_SHARE'', ''EPF_REMITTED'',
''EPS_SHARE'',   ''EPS_REMITTED'', ''DIFF_EPF_EPS_SHARE'' , ''DIFF_EPF_EPS_REMITTED'' , ''NCP Days'', ''Refund Of Advances'',
''Arrear EPF Wages'', ''Arrear EPF EE Share'', ''Arrear EPF ER Share'', ''Arrear EPS Share'', ''Father/Husband Name'',
''Relation With Member'', ''Date Of Birth'', ''Gender'',  ''Date Of Joining EPF'', ''Date Of Joining EPS'',
''Date Of Exit From EPF'',  ''Date Of Exit From EPS'' , ''Reason For Leaving'' FROM DUAL UNION ALL '
    ;
    strSelectClause :=
    '  SELECT * FROM (SELECT ''AC'' "REPORT_HEADER",SUBSTR(C.PPF_NUMBER,10,10) "Member ID", C.EMP_NAME "Member Name",
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0)) "EPF Wages",
CASE
WHEN SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))>=SUM(D.EDLI_LIMIT) THEN
SUM(D.EDLI_LIMIT)
ELSE
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))
END "EPS Wages",
SUM(DECODE( TRIM(B.CTC_MID),''SPF'' ,A.AMOUNT,0)) "EPF_SHARE",
SUM(DECODE( TRIM(B.CTC_MID),''SPF'' ,A.AMOUNT,0)) "EPF_REMITTED",
ROUND(
CASE
WHEN SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))>=SUM(D.EDLI_LIMIT) THEN
SUM(D.EDLI_LIMIT)
ELSE
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))
END
* SUM(D.EMPLOYER_PENSION_PCT/100)) "EPS_SHARE",
ROUND(
CASE
WHEN SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))>=SUM(D.EDLI_LIMIT) THEN
SUM(D.EDLI_LIMIT)
ELSE
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))
END
* SUM(D.EMPLOYER_PENSION_PCT/100)) "EPS_REMITTED",
(SUM(DECODE( TRIM(B.CTC_MID),''SPF'' ,A.AMOUNT,0))
-
ROUND(
CASE
WHEN SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))>=SUM(D.EDLI_LIMIT) THEN
SUM(D.EDLI_LIMIT)
ELSE
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))
END
* SUM(D.EMPLOYER_PENSION_PCT/100))) "DIFF_EPF_EPS_SHARE",
(SUM(DECODE( TRIM(B.CTC_MID),''SPF'' ,A.AMOUNT,0))
-
ROUND(
CASE
WHEN SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))>=SUM(D.EDLI_LIMIT) THEN
SUM(D.EDLI_LIMIT)
ELSE
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,A.AMOUNT,0))
END
* SUM(D.EMPLOYER_PENSION_PCT/100))) "DIFF_EPF_EPS_REMITTED",
NVL(E.DAYS_ABSENT,0) "NCP Days",0 "Refund Of Advances",
NVL(sum(F.AMOUNT),0) "Arrear EPF Wages",
NVL(SUM(F.AMOUNT)*SUM(D.EMPLOYEE_PF_PCT)/100,0) "Arrear EPF EE Share",
NVL(sum(F.AMOUNT)-(SUM(F.AMOUNT)*SUM(D.EMPLOYEE_PF_PCT)/100),0) "Arrear EPF ER Share",
CASE
WHEN SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,F.AMOUNT,0))>=SUM(D.EDLI_LIMIT) THEN
SUM(D.EDLI_LIMIT)
ELSE
SUM(DECODE( TRIM(B.CTC_MID),''BAS'' ,F.AMOUNT,0))
END "Arrear EPS Share",
C.EMP_FATHERNAME "Father/Husband Name",
DECODE(C.EMP_FATHERNAME,NULL,NULL,''F'') "Relation With Member",
TO_CHAR(C.BIRTH_DATE,''DD-MON-YYYY'') "Date Of Birth",C.SEX "Gender",TO_CHAR(C.JOIN_DATE,''DD-MON-YYYY'') "Date Of Joining EPF",
TO_CHAR(C.JOIN_DATE,''DD-MON-YYYY'') "Date Of Joining EPS",TO_CHAR(C.LEAVE_DATE,''DD-MON-YYYY'') "Date Of Exit From EPF",
TO_CHAR(C.LEAVE_DATE,''DD-MON-YYYY'') "Date Of Exit From EPS" ,'''' "Reason For Leaving",
''DH'' "REPORT_HEADER1", NULL "Member ID1",NULL "Member Name1",NULL "EPF Wages1",NULL "EPS Wages1",NULL "EPF_SHARE1",NULL "EPF_REMITTED1",
NULL "EPS_SHARE1",  NULL "EPS_REMITTED1",NULL "DIFF_EPF_EPS_SHARE1" ,NULL "DIFF_EPF_EPS_REMITTED1" ,NULL "NCP Days1",NULL "Refund Of Advances1",
NULL "Arrear EPF Wages1",NULL "Arrear EPF EE Share1",NULL "Arrear EPF ER Share1",NULL "Arrear EPS Share1",NULL "Father/Husband Name1",
NULL "Relation With Member1",NULL "Date Of Birth1",NULL "Gender1",NULL  "Date Of Joining EPF1",NULL "Date Of Joining EPS1",
NULL "Date Of Exit From EPF1", NULL "Date Of Exit From EPS1" ,NULL "Reason For Leaving1" '
    ;
    strFromClause :=
    ' FROM
(SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,ALLWDED_AID,SUM(AMOUNT) AMOUNT
FROM PY_VW_PT_SAL_DT
WHERE COMP_AID='''
    ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||''' AND PAY_MONTH='''||
    pPay_Month||
    ''' AND TRIM(ARR_FLAG)<>''A''
GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,ALLWDED_AID) A,
PY_CTC_ALLOWANCE_MAST B, PY_PT_SAL_HD C,
(SELECT DISTINCT A.COMP_AID,A.ACC_YEAR,A.PAY_MONTH,A.EMP_AID,A.ALLWDED_AID,
B.EDLI_LIMIT,B.EMPLOYEE_PF_PCT,B.EMPLOYER_PENSION_PCT,B.INSURANCE_FUND_PCT,B.INSURANCE_ADMIN_PCT,B.PF_ADMIN_PCT
FROM PY_VW_PT_SAL_DT A,PY_PM_EMPPF B,PY_CTC_ALLOWANCE_MAST C
WHERE A.COMP_AID=B.COMP_AID
AND A.COMP_AID=C.COMP_ID AND A.ALLWDED_AID=C.CTC_CODE
AND A.COMP_AID='''
    ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||''' AND A.PAY_MONTH='''||
    pPay_Month||
    '''
AND TRIM(C.CTC_MID)=''SPF'' AND B.EFF_DATE_TO IS NULL) D,
(SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT
FROM PY_PT_ABSENT
WHERE COMP_AID='''
    ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||''' AND PAY_MONTH='''||
    pPay_Month||
    ''' AND PAY_MONTH=NVL(REC_MONTH,PAY_MONTH)
GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID) E,
(SELECT A.COMP_AID,A.ACC_YEAR,A.PAY_MONTH,A.EMP_AID,A.ALLWDED_AID,SUM(AMOUNT) AMOUNT
FROM PY_VW_PT_SAL_DT A,PY_CTC_ALLOWANCE_MAST B
WHERE A.COMP_AID=B.COMP_ID(+) AND A.ALLWDED_AID=B.CTC_CODE(+)
AND A.COMP_AID='''
    ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||''' AND A.PAY_MONTH='''||
    pPay_Month||
    ''' AND TRIM(A.ARR_FLAG)=''A''
AND TRIM(B.CTC_MID)=''BAS''
GROUP BY A.COMP_AID,A.ACC_YEAR,A.PAY_MONTH,A.EMP_AID,A.ALLWDED_AID) F  '
    ;
    strWhereClause :=
    ' WHERE A.COMP_AID=B.COMP_ID(+) AND A.ALLWDED_AID=B.CTC_CODE(+)
AND A.COMP_AID=C.COMP_AID(+) AND A.EMP_AID=C.EMP_AID(+) AND A.PAY_MONTH=C.PROCESS_MONTH(+)
AND A.COMP_AID=E.COMP_AID(+) AND A.ACC_YEAR=E.ACC_YEAR(+) AND A.PAY_MONTH=E.PAY_MONTH(+) AND A.EMP_AID=E.EMP_AID(+)
AND A.COMP_AID=F.COMP_AID(+) AND A.ACC_YEAR=F.ACC_YEAR(+) AND A.PAY_MONTH=F.PAY_MONTH(+) AND A.EMP_AID=F.EMP_AID(+) AND A.ALLWDED_AID=F.ALLWDED_AID(+)
AND A.COMP_AID=D.COMP_AID(+) AND A.ACC_YEAR=D.ACC_YEAR(+) AND A.PAY_MONTH=D.PAY_MONTH(+) AND A.EMP_AID=D.EMP_AID(+) AND A.ALLWDED_AID=D.ALLWDED_AID(+)
AND A.COMP_AID='''
    ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||''' AND A.PAY_MONTH='''||
    pPay_Month||''' AND C.PAY_MONTH IS NOT NULL';
    IF TRIM(pIsMultipleSheet) ='Y' THEN
      strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
      pMasterType , pMultiSheetCondition),'HD.','C.');
    END IF;
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      --                   strWhereClause:=strWhereClause||chr(13)||' AND
      -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''|
      -- |pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
      -- ||(CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE
      -- pReportID END)||''' AND COMP_AID='''||pComp_Aid||''')';
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupClause :=
    ' GROUP BY C.EMP_NAME,C.JOIN_DATE,C.PPF_NUMBER,E.DAYS_ABSENT,C.EMP_FATHERNAME,C.BIRTH_DATE,C.SEX,C.JOIN_DATE,C.LEAVE_DATE
HAVING SUM(DECODE(TRIM(B.CTC_MID),''SPF'',A.AMOUNT,0))>0) '
    ;
    strSQLClause :=strSQLClause||strSelectClause||strFromClause||strWhereClause
    ||strGroupClause;

    OPEN RETURN_RECORDSET FOR strSQLClause;
  ELSE
    OPEN RETURN_RECORDSET FOR
    SELECT * FROM
    (
      SELECT
        SUBSTR(C.PPF_NUMBER,10,10)
        ||'#~#'
        || C.EMP_NAME
        ||'#~#'
        || SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))
        ||'#~#'
        ||
        CASE
          WHEN SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))>=SUM(
            D.EDLI_LIMIT)
          THEN SUM(D.EDLI_LIMIT)
          ELSE SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))
        END
        ||'#~#'
        || SUM(DECODE( TRIM(B.CTC_MID),'SPF' ,A.AMOUNT,0))
        ||'#~#'
        || SUM(DECODE( TRIM(B.CTC_MID),'SPF' ,A.AMOUNT,0))
        ||'#~#'
        || ROUND(
          CASE
            WHEN SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))>=SUM(
              D.EDLI_LIMIT)
            THEN SUM(D.EDLI_LIMIT)
            ELSE SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))
          END * SUM(D.EMPLOYER_PENSION_PCT/100))
        ||'#~#'
        || ROUND(
          CASE
            WHEN SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))>=SUM(
              D.EDLI_LIMIT)
            THEN SUM(D.EDLI_LIMIT)
            ELSE SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))
          END * SUM(D.EMPLOYER_PENSION_PCT/100))
        ||'#~#'
        || (SUM(DECODE( TRIM(B.CTC_MID),'SPF' ,A.AMOUNT,0)) - ROUND(
          CASE
            WHEN SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))>=SUM(
              D.EDLI_LIMIT)
            THEN SUM(D.EDLI_LIMIT)
            ELSE SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))
          END * SUM(D.EMPLOYER_PENSION_PCT/100)))
        ||'#~#'
        || (SUM(DECODE( TRIM(B.CTC_MID),'SPF' ,A.AMOUNT,0)) - ROUND(
          CASE
            WHEN SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))>=SUM(
              D.EDLI_LIMIT)
            THEN SUM(D.EDLI_LIMIT)
            ELSE SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,A.AMOUNT,0))
          END * SUM(D.EMPLOYER_PENSION_PCT/100)))
        ||'#~#'
        || NVL(E.DAYS_ABSENT,0)
        ||'#~#'
        ||0
        ||'#~#'
        || NVL(SUM(F.AMOUNT),0)
        ||'#~#'
        || NVL(SUM(F.AMOUNT)*SUM(D.EMPLOYEE_PF_PCT)/100,0)
        ||'#~#'
        || NVL(SUM(F.AMOUNT)-(SUM(F.AMOUNT)*SUM(D.EMPLOYEE_PF_PCT)/100),0)
        ||'#~#'
        ||
        CASE
          WHEN SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,F.AMOUNT,0))>=SUM(
            D.EDLI_LIMIT)
          THEN SUM(D.EDLI_LIMIT)
          ELSE SUM(DECODE( TRIM(B.CTC_MID),'BAS' ,F.AMOUNT,0))
        END
        ||'#~#'
        || C.EMP_FATHERNAME
        ||'#~#'
        || DECODE(C.EMP_FATHERNAME,NULL,NULL,'F')
        ||'#~#'
        || TO_CHAR(C.BIRTH_DATE,'DD-MON-YYYY')
        ||'#~#'
        ||C.SEX
        ||'#~#'
        ||TO_CHAR(C.JOIN_DATE,'DD-MON-YYYY')
        ||'#~#'
        || TO_CHAR(C.JOIN_DATE,'DD-MON-YYYY')
        ||'#~#'
        ||TO_CHAR(C.LEAVE_DATE,'DD-MON-YYYY')
        ||'#~#'
        || TO_CHAR(C.LEAVE_DATE,'DD-MON-YYYY')
        ||'#~#'
        ||'' " "
      FROM
        (
          SELECT
            COMP_AID,
            ACC_YEAR,
            PAY_MONTH,
            EMP_AID,
            ALLWDED_AID,
            SUM(AMOUNT) AMOUNT
          FROM
            PY_VW_PT_SAL_DT
          WHERE
            COMP_AID         =pComp_Aid
          AND ACC_YEAR       =pAcc_Year
          AND PAY_MONTH      =pPay_Month
          AND TRIM(ARR_FLAG)<>'A'
          GROUP BY
            COMP_AID,
            ACC_YEAR,
            PAY_MONTH,
            EMP_AID,
            ALLWDED_AID
        )
        A,
        PY_CTC_ALLOWANCE_MAST B,
        PY_GM_EMPMAST C,
        (
          SELECT DISTINCT
            A.COMP_AID,
            A.ACC_YEAR,
            A.PAY_MONTH,
            A.EMP_AID,
            A.ALLWDED_AID,
            B.EDLI_LIMIT,
            B.EMPLOYEE_PF_PCT,
            B.EMPLOYER_PENSION_PCT,
            B.INSURANCE_FUND_PCT,
            B.INSURANCE_ADMIN_PCT,
            B.PF_ADMIN_PCT
          FROM
            PY_VW_PT_SAL_DT A,
            PY_PM_EMPPF B,
            PY_CTC_ALLOWANCE_MAST C
          WHERE
            A.COMP_AID       =B.COMP_AID
          AND A.COMP_AID     =C.COMP_ID
          AND A.ALLWDED_AID  =C.CTC_CODE
          AND A.COMP_AID     =pComp_Aid
          AND A.ACC_YEAR     =pAcc_Year
          AND A.PAY_MONTH    =pPay_Month
          AND TRIM(C.CTC_MID)='SPF'
          AND B.EFF_DATE_TO IS NULL
        )
        D,
        (
          SELECT
            COMP_AID,
            ACC_YEAR,
            PAY_MONTH,
            EMP_AID,
            SUM(DAYS_ABSENT) DAYS_ABSENT
          FROM
            PY_PT_ABSENT
          WHERE
            COMP_AID   =pComp_Aid
          AND ACC_YEAR =pAcc_Year
          AND PAY_MONTH=pPay_Month
          AND PAY_MONTH=NVL(REC_MONTH,PAY_MONTH)
          GROUP BY
            COMP_AID,
            ACC_YEAR,
            PAY_MONTH,
            EMP_AID
        )
        E,
        (
          SELECT
            A.COMP_AID,
            A.ACC_YEAR,
            A.PAY_MONTH,
            A.EMP_AID,
            A.ALLWDED_AID,
            SUM(AMOUNT) AMOUNT
          FROM
            PY_VW_PT_SAL_DT A,
            PY_CTC_ALLOWANCE_MAST B
          WHERE
            A.COMP_AID        =B.COMP_ID(+)
          AND A.ALLWDED_AID   =B.CTC_CODE(+)
          AND A.COMP_AID      =pComp_Aid
          AND A.ACC_YEAR      =pAcc_Year
          AND A.PAY_MONTH     =pPay_Month
          AND TRIM(A.ARR_FLAG)='A'
          AND TRIM(B.CTC_MID) ='BAS'
          GROUP BY
            A.COMP_AID,
            A.ACC_YEAR,
            A.PAY_MONTH,
            A.EMP_AID,
            A.ALLWDED_AID
        )
        F
      WHERE
        A.COMP_AID     =B.COMP_ID(+)
      AND A.ALLWDED_AID=B.CTC_CODE(+)
      AND A.COMP_AID   =C.COMP_AID(+)
      AND A.EMP_AID    =C.EMP_AID(+)
      AND A.COMP_AID   =E.COMP_AID(+)
      AND A.ACC_YEAR   =E.ACC_YEAR(+)
      AND A.PAY_MONTH  =E.PAY_MONTH(+)
      AND A.EMP_AID    =E.EMP_AID(+)
      AND A.COMP_AID   =F.COMP_AID(+)
      AND A.ACC_YEAR   =F.ACC_YEAR(+)
      AND A.PAY_MONTH  =F.PAY_MONTH(+)
      AND A.EMP_AID    =F.EMP_AID(+)
      AND A.ALLWDED_AID=F.ALLWDED_AID(+)
      AND A.COMP_AID   =D.COMP_AID(+)
      AND A.ACC_YEAR   =D.ACC_YEAR(+)
      AND A.PAY_MONTH  =D.PAY_MONTH(+)
      AND A.EMP_AID    =D.EMP_AID(+)
      AND A.ALLWDED_AID=D.ALLWDED_AID(+)
      AND A.COMP_AID   =pComp_Aid
      AND A.ACC_YEAR   =pAcc_Year
      AND A.PAY_MONTH  =pPay_Month
      GROUP BY
        C.EMP_NAME,
        C.JOIN_DATE,
        C.PPF_NUMBER,
        E.DAYS_ABSENT,
        C.EMP_FATHERNAME,
        C.BIRTH_DATE,
        C.SEX,
        C.JOIN_DATE,
        C.LEAVE_DATE
      HAVING
        SUM(DECODE(TRIM(B.CTC_MID),'SPF',A.AMOUNT,0))>0
    )
    ;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED '||SQLERRM);
END;
PROCEDURE Fillempdetails(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
  BEGIN
    strSqlQuery     := 'SELECT ';
    strSelectClause :=
    'A.EMP_NAME,A.EMP_MID,A.PAN_NUMBER,A.PPF_NUMBER,TO_CHAR (A.JOIN_DATE, ''dd-Mon-yyyy'') AS JOIN_DATE,A.GRADE_DESC,A.LOC_DESC,A.DEPT_DESC,A.DESG_DESC,A.EMP_AID,A.COMP_AID,B.COMP_NAME,B.COMP_ADDR,A.BANK_ACCOUNT_NO AS BANK_ACC,A.BANK_DESC'
    ;
    strFromClause := ' FROM PY_GM_EMPMAST A,PY_GM_COMP B';
    strWhereClause:=' WHERE A.COMP_AID = B.COMP_ID AND A.COMP_AID = '||''''||
    PCOMP_AID||''''||'';

    strWhereClause:=strWhereClause||' AND (A.LEAVE_DATE IS NULL OR (A.LEAVE_DATE >= TO_DATE(01||'''||pPay_Month||'''))) ';

    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      (
        CASE
        WHEN TRIM(pFilterId)='EMPLOYEE' THEN
          'RP0000TEMP'
        ELSE
          pReportID
        END)||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
    OPEN Return_Recordset FOR strSqlQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
  END Fillempdetails;
PROCEDURE FILLSALARY_DETAILS(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery     :='SELECT ';
  strSelectClause :=
  'EMP_AID,COMP_AID,ACC_YEAR,ALLWDED_AID,ALLWDED_DESC,
DECODE (APR, 0, ''-'', TO_CHAR (APR, ''99999999.99'')) APR,
DECODE (MAY, 0, ''-'', TO_CHAR (MAY, ''99999999.99'')) MAY,
DECODE (JUN, 0, ''-'', TO_CHAR (JUN, ''99999999.99'')) JUN,
DECODE (JUL, 0, ''-'', TO_CHAR (JUL, ''99999999.99'')) JUL,
DECODE (AUG, 0, ''-'', TO_CHAR (AUG, ''99999999.99'')) AUG,
DECODE (SEP, 0, ''-'', TO_CHAR (SEP, ''99999999.99'')) SEP,
DECODE (OCT, 0, ''-'', TO_CHAR (OCT, ''99999999.99'')) OCT,
DECODE (NOV, 0, ''-'', TO_CHAR (NOV, ''99999999.99'')) NOV,
DECODE (DEC, 0, ''-'', TO_CHAR (DEC, ''99999999.99'')) DEC,
DECODE (JAN, 0, ''-'', TO_CHAR (JAN, ''99999999.99'')) JAN,
DECODE (FEB, 0, ''-'', TO_CHAR (FEB, ''99999999.99'')) FEB,
DECODE (MAR, 0, ''-'', TO_CHAR (MAR, ''99999999.99'')) MAR,
DECODE (TOTAL, 0, ''-'', TO_CHAR (TOTAL, ''99999999.99'')) TOTAL,ALLWDED_TYPE,PAY_MONTH'
  ;
  strFromClause := ' FROM   PY_PT_PAYSLIP_DATA A';
  strWhereClause:=' WHERE COMP_AID = '||''''||PCOMP_AID||''''||
  'AND ACC_YEAR = '||''''||PACC_YEAR||''''||'AND PAY_MONTH = '||''''||
  PPAY_MONTH||''''||'';
  strOrderByClause:= 'ORDER BY COMP_AID,EMP_AID,ALLWDED_TYPE,SORT_ORDER';
  --        strOrderByClause:=' ORDER BY ALLWDED_TYPE';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILLSALARY_DETAILS;
PROCEDURE FILL_INVESTMENT(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery     :='SELECT ';
  strSelectClause :=
  'F16_AID,DESCRIPTION,TO_CHAR(COLUMN3)COLUMN3,EMP_AID,COMP_AID';
  strFromClause := ' FROM PY_PT_TAXDETAILS A';
  strWhereClause:=
  ' WHERE SUBSRNO1 IN (2, 6) AND (COLUMN3 <> 0 OR COLUMN3 IS NULL) AND COMP_AID = '
  ||''''||PCOMP_AID||''''||'AND ACC_YEAR = '||''''||PACC_YEAR||''''||
  'AND PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
  strOrderByClause:=
  ' ORDER BY COMP_AID ASC,ACC_YEAR ASC,PAY_MONTH ASC,EMP_AID ASC';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_INVESTMENT;
PROCEDURE FILL_INVESTMENT1(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery     :='SELECT ';
  strSelectClause :=
  'F16_AID,DESCRIPTION,TO_CHAR(COLUMN3)COLUMN3,EMP_AID,COMP_AID';
  strFromClause := ' FROM PY_PT_TAXDETAILS A';
  strWhereClause:=
  ' WHERE SUBSRNO1 IN (8, 9, 10) AND (COLUMN3 <> 0 OR COLUMN3 IS NULL) AND COMP_AID = '
  ||''''||PCOMP_AID||''''||'AND ACC_YEAR = '||''''||PACC_YEAR||''''||
  'AND PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
  strOrderByClause:=
  ' ORDER BY COMP_AID ASC,ACC_YEAR ASC,PAY_MONTH ASC,EMP_AID ASC';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_INVESTMENT1;
PROCEDURE FILL_INVESTMENT2(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery     :='SELECT ';
  strSelectClause :=
  'F16_AID,DESCRIPTION,TO_CHAR(COLUMN3)COLUMN3,EMP_AID,COMP_AID';
  strFromClause := ' FROM PY_PT_TAXDETAILS A';
  strWhereClause:=
  ' WHERE SUBSRNO1 IN (12, 13, 14) AND (COLUMN3 <> 0 OR COLUMN3 IS NULL) AND COMP_AID = '
  ||''''||PCOMP_AID||''''||'AND ACC_YEAR = '||''''||PACC_YEAR||''''||
  'AND PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
  strOrderByClause:=
  ' ORDER BY COMP_AID ASC,ACC_YEAR ASC,PAY_MONTH ASC,EMP_AID ASC';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_INVESTMENT2;
PROCEDURE FILL_INVESTMENT_DETAILS(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
  strLastMonthYr VARCHAR2(20);
  vSHOW_PROMISE  CHAR(1);
BEGIN
  OPEN Return_Recordset FOR
  SELECT TO_CHAR(EFF_TO_DATE,'MON YYYY') FROM PY_GM_ACCT_YEARS WHERE COMP_ID=
  pCOMP_AID AND YEAR_ID                                                     =
  pACC_YEAR AND IS_YEAR_OPEN                                                =
  'Y';
  FETCH
    Return_Recordset
  INTO
    strLastMonthYr;
CLOSE Return_Recordset;
SELECT
  DECODE(pPAY_MONTH,strLastMonthYr,'N','Y')
INTO
  vSHOW_PROMISE
FROM
  DUAL;
strSqlQuery   :='SELECT * FROM (';
strFromClause :=' FROM PY_REPORT_MONTHLY_INV_DT A';
strWhereClause:=' WHERE A.COMP_AID = '||''''||PCOMP_AID||''''||
'AND A.ACC_YEAR = '||''''||PACC_YEAR||''' AND A.PAY_MONTH='''||pPay_Month||
''' ';
IF pFilterId IS NOT NULL THEN
  INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
  pFilterId);
  strWhereClause:=strWhereClause||chr(13)||
  ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
  pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
  (
    CASE
    WHEN TRIM(pFilterId)='EMPLOYEE' THEN
      'RP0000TEMP'
    ELSE
      pReportID
    END)||''' AND COMP_AID='''||pComp_Aid||''')';
END IF;
strSelectClause:=
'SELECT COMP_AID,ACC_YEAR,EMP_AID,INV_DESC AS DESCRIPTION,
TO_CHAR(NVL (DECLARATION, 0),''9999999990.00'') DECLARATION,
TO_CHAR(NVL (SUPPORT, 0),''9999999990.00'') SUPPORT,SECTION,decode(trim(SECTION),''80 D'',''B'',''80 E'',''C'',''OTHER INVESTMENTS'',''D'',
''80 DD'',''E'',''80 G'',''F'',''24 (2)'',''G'',''A'') SEQ'
;
strSelectClause:=strSelectClause||
' ,TO_CHAR(NVL (PROM_AMOUNT, 0),''9999999990.00'') PROM_AMOUNT,'''||
vSHOW_PROMISE||''' SHOW_PROMISE';
strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
' UNION ALL ';
strSelectClause:=
' SELECT COMP_AID,ACC_YEAR,EMP_AID,SECTION||'' Total'' TOTAL,
TO_CHAR(NVL (SUM(DECLARATION), 0),''9999999990.00'') DECLARATION,
TO_CHAR(NVL (SUM(SUPPORT), 0),''9999999990.00'') SUPPORT,SECTION,DECODE(TRIM(SECTION),''80 D'',''B1'',''80 E'',''C1'',''OTHER INVESTMENTS'',''D1'',''80 DD'',''E1'',
''80 G'',''F1'',''24 (2)'',''G1'',''A1'') SEQ'
;
strSelectClause:=strSelectClause||
' ,TO_CHAR(NVL (SUM(PROM_AMOUNT), 0),''9999999990.00'') PROM_AMOUNT,'''||
vSHOW_PROMISE||''' SHOW_PROMISE';
strGroupByClause:='GROUP BY COMP_AID,EMP_AID,ACC_YEAR,SECTION';
strSqlQuery     :=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
strGroupByClause||' UNION ALL ';
strSelectClause:=
' SELECT COMP_AID,ACC_YEAR,EMP_AID,''Grand Total'' TOTAL,
TO_CHAR(NVL (SUM(DECLARATION), 0),''9999999990.00'') DECLARATION,
TO_CHAR(NVL (SUM(SUPPORT), 0),''9999999990.00'') SUPPORT,NULL SECTION,''Z'' SEQ'
;
strSelectClause:=strSelectClause||
' ,TO_CHAR(NVL (SUM(PROM_AMOUNT), 0),''9999999990.00'') PROM_AMOUNT,'''||
vSHOW_PROMISE||''' SHOW_PROMISE';
strGroupByClause:=' GROUP BY COMP_AID,EMP_AID,ACC_YEAR';
strOrderByClause:=' ORDER BY SEQ';
strSqlQuery     :=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
strGroupByClause||')'||strOrderByClause;
OPEN Return_Recordset FOR strSqlQuery ;
/*Craete Log */
INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date
,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_INVESTMENT_DETAILS;
PROCEDURE NUMTOWORD(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_RS CUR;
    VNUM NUMBER(20);
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    V_MONTH VARCHAR2(20);
  BEGIN
    V_MONTH        :=TO_CHAR(SUBSTR(PPAY_MONTH,0,3));
    strSqlQuery    :='SElECT';
    strSelectClause:=' NUM_TO_WORDS_NEW(TO_NUMBER('||V_MONTH||
    ')) WORDS,emp_aid,comp_aid';
    strFromClause :=' FROM PY_PT_PAYSLIP_DATA A';
    strWhereClause:=' WHERE COMP_AID = '||''''||PCOMP_AID||''''||
    'AND ACC_YEAR = '||''''||PACC_YEAR||''''||' AND PAY_MONTH = '||''''||
    PPAY_MONTH||''''||'AND ALLWDED_TYPE =''E1'' ';
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      (
        CASE
        WHEN TRIM(pFilterId)='EMPLOYEE' THEN
          'RP0000TEMP'
        ELSE
          pReportID
        END)||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
    OPEN Return_Recordset FOR strSqlQuery;
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
  END NUMTOWORD;
  --    PROCEDURE FILL_TAXSHEET_DETAIL(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,
  -- pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,
  --                                    pSessionId VARCHAR2,pReportType
  -- VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2
  -- ,
  --                                    pIsMultipleSheet VARCHAR2,
  -- pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC)
PROCEDURE FILL_TAXSHEET_DETAIL(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' COMP_AID,PAY_MONTH,EMP_AID,SRNO,TO_CHAR(SUBSRNO1) AS SUBSRNO1 ,DESCRIPTION,
TO_CHAR(NVL (COLUMN1, 0),''9999999990.00'') GROSS,
TO_CHAR(NVL (COLUMN2, 0),''9999999990.00'') NON_TAX,
TO_CHAR(NVL (COLUMN3, 0),''9999999990.00'') TOTAL,
TO_CHAR(NVL (COLUMN4, 0),''9999999990.00'') ACTUAL,
TO_CHAR(NVL (COLUMN5, 0),''9999999990.00'') MONTH_TAX'
  ;
  strFromClause :=' FROM PY_PT_TAXDETAILS A';
  strWhereClause:=' WHERE COMP_AID = '||''''||PCOMP_AID||''''||
  'AND ACC_YEAR = '||''''||PACC_YEAR||''''||' AND PAY_MONTH = '||''''||
  PPAY_MONTH||''' ';
  strOrderByClause:=' ORDER BY COMP_AID,EMP_AID,SRNO,SUBSRNO1';
  IF pFilterId    IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
  --    OPEN PCURSOR FOR
  --        SELECT   COMP_AID,PAY_MONTH,EMP_AID,SRNO,TO_CHAR(SUBSRNO1) AS
  -- SUBSRNO1 ,DESCRIPTION,
  --            TO_CHAR(NVL (COLUMN1, 0),'9999999990.00') GROSS,
  --            TO_CHAR(NVL (COLUMN2, 0),'9999999990.00') NON_TAX,
  --            TO_CHAR(NVL (COLUMN3, 0),'9999999990.00') TOTAL,
  --            TO_CHAR(NVL (COLUMN4, 0),'9999999990.00') ACTUAL,
  --            TO_CHAR(NVL (COLUMN5, 0),'9999999990.00') MONTH_TAX
  --        FROM   PY_PT_TAXDETAILS
  --        WHERE    EMP_AID IN ('EM000092','EM000093')
  --            AND COMP_AID=PCOMP_AID
  --            AND ACC_YEAR=PACC_YEAR
  --            AND PAY_MONTH=PPAY_MONTH
  --        ORDER BY COMP_AID,EMP_AID,SRNO,SUBSRNO1;
  /*following code commented by sanjev*/
  --                      SELECT   COMP_AID,
  --                        PAY_MONTH,
  --                        EMP_AID,
  --                        SRNO,
  --                        TO_CHAR(SUBSRNO1) AS SUBSRNO1 ,
  --                        DESCRIPTION,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN1, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN1, 0), '
  -- 99999999999999.99'))
  --                           GROSS,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN2, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN2, 0), '
  -- 99999999999999.99'))
  --                           NON_TAX,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN3, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN3, 0), '
  -- 99999999999999.99'))
  --                           TOTAL,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN4, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN4, 0), '
  -- 99999999999999.99'))
  --                           ACTUAL,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN5, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN5, 0), '
  -- 99999999999999.99'))
  --                           MONTH_TAX
  --                     FROM   PY_PT_TAXDETAILS
  --                        WHERE   SUBSRNO1 < 2
  --                        AND EMP_AID=PEMP_AID
  --                        AND COMP_AID=PCOMP_AID
  --                        AND ACC_YEAR=PACC_YEAR
  --                        AND PAY_MONTH=PPAY_MONTH
  --                   UNION
  --               SELECT   COMP_AID,
  --                        PAY_MONTH,
  --                        EMP_AID,
  --                        SRNO,
  --                        TO_CHAR(SUBSRNO1) AS SUBSRNO1 ,
  --                        DESCRIPTION,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN1, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN1, 0), '
  -- 99999999999999.99'))
  --                           GROSS,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN2, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN2, 0), '
  -- 99999999999999.99'))
  --                           NON_TAX,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN3, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN3, 0), '
  -- 99999999999999.99'))
  --                           TOTAL,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN4, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN4, 0), '
  -- 99999999999999.99'))
  --                           ACTUAL,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN5, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN5, 0), '
  -- 99999999999999.99'))
  --                           MONTH_TAX
  --                     FROM   PY_PT_TAXDETAILS
  --                        WHERE   SUBSRNO1 >= 2 AND SUBSRNO1 <= 37
  --                        AND EMP_AID=PEMP_AID
  --                        AND COMP_AID=PCOMP_AID
  --                        AND ACC_YEAR=PACC_YEAR
  --                        AND PAY_MONTH=PPAY_MONTH
  --               UNION
  --               SELECT   COMP_AID,
  --                        PAY_MONTH,
  --                        EMP_AID,
  --                        SRNO,
  --                        TO_CHAR(SUBSRNO1) AS SUBSRNO1 ,
  --                        DESCRIPTION,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN1, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN1, 0), '
  -- 99999999999999.99'))
  --                           GROSS,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN2, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN2, 0), '
  -- 99999999999999.99'))
  --                           NON_TAX,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN3, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN3, 0), '
  -- 99999999999999.99'))
  --                           TOTAL,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN4, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN4, 0), '
  -- 99999999999999.99'))
  --                           ACTUAL,
  --                        DECODE (TRIM (TO_CHAR (NVL (COLUMN5, 0), '
  -- 99999999999999.99')),
  --                                '.00', '0.00',
  --                                TO_CHAR (NVL (COLUMN5, 0), '
  -- 99999999999999.99'))
  --                           MONTH_TAX
  --                     FROM   PY_PT_TAXDETAILS
  --                        WHERE   SUBSRNO1 >= 37
  --                        AND EMP_AID=PEMP_AID
  --                        AND COMP_AID=PCOMP_AID
  --                        AND ACC_YEAR=PACC_YEAR
  --                        AND PAY_MONTH=PPAY_MONTH
  --               ORDER BY   SRNO ASC;
END FILL_TAXSHEET_DETAIL;
PROCEDURE FILL_TAXSHEET_DETAIL_FIRST(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' COMP_AID,PAY_MONTH,EMP_AID,SRNO,TO_CHAR(SUBSRNO1) AS SUBSRNO1 ,DESCRIPTION,
TO_CHAR(NVL (COLUMN1, 0),''9999999990.00'') GROSS,
TO_CHAR(NVL (COLUMN2, 0),''9999999990.00'') NON_TAX,
TO_CHAR(NVL (COLUMN3, 0),''9999999990.00'') TOTAL,
TO_CHAR(NVL (COLUMN4, 0),''9999999990.00'') ACTUAL,
TO_CHAR(NVL (COLUMN5, 0),''9999999990.00'') MONTH_TAX'
  ;
  strFromClause :=' FROM PY_PT_TAXDETAILS A';
  strWhereClause:=' WHERE SUBSRNO1 < 2 AND COMP_AID = '||''''||PCOMP_AID||''''
  ||'AND ACC_YEAR = '||''''||PACC_YEAR||''''||' AND PAY_MONTH = '||''''||
  PPAY_MONTH||''' ';
  strOrderByClause:=' ORDER BY SRNO ASC';
  IF pFilterId    IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
  --        OPEN PCURSOR FOR
  --
  --                      SELECT   COMP_AID,PAY_MONTH,EMP_AID,SRNO,TO_CHAR(
  -- SUBSRNO1) AS SUBSRNO1 ,DESCRIPTION,
  --                        TO_CHAR(NVL (COLUMN1, 0),'9999999990.00') GROSS,
  --                        TO_CHAR(NVL (COLUMN2, 0),'9999999990.00') NON_TAX,
  --                        TO_CHAR(NVL (COLUMN3, 0),'9999999990.00') TOTAL,
  --                        TO_CHAR(NVL (COLUMN4, 0),'9999999990.00') ACTUAL,
  --                        TO_CHAR(NVL (COLUMN5, 0),'9999999990.00') MONTH_TAX
  --                     FROM   PY_PT_TAXDETAILS
  --                        WHERE   SUBSRNO1 < 2
  --                        AND EMP_AID IN ('EM000092','EM000093')
  --                        AND COMP_AID=PCOMP_AID
  --                        AND ACC_YEAR=PACC_YEAR
  --                        AND PAY_MONTH=PPAY_MONTH
  --                     ORDER BY   SRNO ASC;
END FILL_TAXSHEET_DETAIL_FIRST;
PROCEDURE FILL_TAXSHEET_DETAIL_SECOND(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' COMP_AID,PAY_MONTH,EMP_AID,SRNO,TO_CHAR(SUBSRNO1) AS SUBSRNO1 ,DESCRIPTION,
TO_CHAR(NVL (COLUMN1, 0),''9999999990.00'') GROSS,
TO_CHAR(NVL (COLUMN2, 0),''9999999990.00'') NON_TAX,
TO_CHAR(NVL (COLUMN3, 0),''9999999990.00'') TOTAL,
TO_CHAR(NVL (COLUMN4, 0),''9999999990.00'') ACTUAL,
TO_CHAR(NVL (COLUMN5, 0),''9999999990.00'') MONTH_TAX'
  ;
  strFromClause :=' FROM PY_PT_TAXDETAILS A';
  strWhereClause:=' WHERE SUBSRNO1 >= 2  AND COMP_AID = '||''''||PCOMP_AID||
  ''''||'AND ACC_YEAR = '||''''||PACC_YEAR||''''||' AND PAY_MONTH = '||''''||
  PPAY_MONTH||''' ';
  strOrderByClause:=' ORDER BY COMP_AID,EMP_AID,SRNO,SUBSRNO1';
  IF pFilterId    IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_TAXSHEET_DETAIL_SECOND;
--for other income losses
PROCEDURE FILL_OTHER_INCOME_LOSSES(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' A.COMP_AID,A.ACC_YEAR,A.EMP_AID,A.AMOUNT,A.SUPPORT_AMT,B.F12C_DESC';
  strFromClause :=' FROM PY_PT_F12C_MONTHLY A,PY_PM_FORM12C B';
  strWhereClause:=
  ' WHERE A.COMP_AID=B.COMP_AID AND A.F12C_AID = B.F12C_AID AND A.COMP_AID = '
  ||''''||PCOMP_AID||''''||'AND A.ACC_YEAR = '||''''||PACC_YEAR||''' ';
  strWhereClause:=strWhereClause||' AND A.PROCESS_MONTH='''||pPay_Month||'''';
  IF pFilterId  IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_OTHER_INCOME_LOSSES;
--for previous employer
PROCEDURE FILL_PREVIOUS_EMPLOYER(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' A.COMP_AID,A.ACC_YEAR,A.EMP_AID,A.AMOUNT,A.TAXABLE,B.CTC_TYPE,B.CTC_NAME DESCRIPTION '
  ;
  strFromClause :=' FROM PY_PT_F12B_MONTHLY A, PY_CTC_ALLOWANCE_MAST B';
  strWhereClause:=
  ' WHERE A.COMP_AID=B.COMP_ID AND A.ALLWDED_AID=B.CTC_CODE AND A.COMP_AID = '
  ||''''||PCOMP_AID||''''||'AND A.ACC_YEAR = '||''''||PACC_YEAR||''' ';
  strWhereClause  :=strWhereClause||' AND A.PROCESS_MONTH='''||pPay_Month||'''';
  strOrderByClause:=
  ' ORDER BY A.COMP_AID ASC,A.ACC_YEAR ASC,A.EMP_AID ASC,B.CTC_TYPE ASC';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_PREVIOUS_EMPLOYER;
--for details of perqusite
PROCEDURE FILL_DETAILS_OF_PERQUSITE(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=' COMP_AID,EMP_AID,PAY_MONTH,TAXDT_AID,DESCRIPTION,COLUMN1 '
  ;
  strFromClause :=' FROM PY_PT_TAXDETAILS_DT A';
  strWhereClause:=' WHERE TAXDT_AID=''PERQ'' AND COMP_AID = '||''''||PCOMP_AID
  ||''''||'AND PAY_MONTH = '||''''||pPay_Month||''' ';
  strOrderByClause:=' ORDER BY EMP_AID ASC';
  IF pFilterId    IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_DETAILS_OF_PERQUSITE;
--for details of other claims
PROCEDURE FILL_OTHER_CLAIMS(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' A.COMP_AID,A.EMP_AID,A.PAY_MONTH,A.CLAIM_AMT,B.PARA_DESC  ';
  strFromClause :=' FROM PY_PT_CLAIMS_DT A, PY_GM_PARAMETERS B';
  strWhereClause:=
  ' WHERE A.CLAIM_TYPE = B.PAR_AID AND TO_DATE(01||A.PAY_MONTH) <= '||''''||
  pFrom_Date||''''||'AND A.COMP_AID = '||''''||PCOMP_AID||''' ';
  strOrderByClause:=' ORDER BY A.EMP_AID';
  IF pFilterId    IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_OTHER_CLAIMS;
--for lease accomodation
PROCEDURE FILL_LEASE_ACCOMODATION(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' COMP_AID,EMP_AID,PAY_MONTH,RENT_TYPE,METRO_YN,EFF_FR_DATE, EFF_TO_DATE ,DEC_AMT '
  ;
  strFromClause :=' FROM PY_PT_RENT_MONTHLY A, PY_GM_PARAMETERS B';
  strWhereClause:=
  ' WHERE TRIM(A.RENT_TYPE)=TRIM(B.PAR_AID) AND TRIM(UPPER(B.PARA_DESC))=''LEASE'' AND A.ACC_YEAR = '
  ||''''||pAcc_Year||''''||'AND A.COMP_AID = '||''''||PCOMP_AID||''' ';
  strWhereClause  :=strWhereClause||' AND A.PROCESS_MONTH='''||pPay_Month||'''';
  strOrderByClause:=
  ' ORDER BY TO_DATE(''1 ''||PAY_MONTH),EFF_FR_DATE, EFF_TO_DATE';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_LEASE_ACCOMODATION;
--for rent paid details
PROCEDURE FILL_RENT_PAID_DETAILS(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' A.COMP_AID,A.EMP_AID,A.PAY_MONTH,A.RENT_TYPE,DECODE(A.METRO_YN,''Y'',''METRO'',''N'',''NOVN-METRO'') METRO_YN,A.EFF_FR_DATE,A.EFF_TO_DATE ,A.DEC_AMT,A.SUP_AMT '
  ;
  strFromClause :=' FROM PY_PT_RENT_MONTHLY A, PY_GM_PARAMETERS B';
  strWhereClause:=
  ' WHERE TRIM(A.RENT_TYPE)=TRIM(B.PAR_AID) AND TRIM(UPPER(B.PARA_DESC))=''EMPLOYEE'' AND A.ACC_YEAR = '
  ||''''||pAcc_Year||''''||'AND A.COMP_AID = '||''''||PCOMP_AID||''' ';
  strWhereClause  :=strWhereClause||' AND A.PROCESS_MONTH='''||pPay_Month||'''';
  strOrderByClause:=
  ' ORDER BY TO_DATE(''1 ''||PAY_MONTH),EFF_FR_DATE, EFF_TO_DATE ';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||
  strOrderByClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_RENT_PAID_DETAILS;
--for tax deduct
PROCEDURE FILL_TAX_DEDUCT(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
BEGIN
  strSqlQuery    :='SELECT';
  strSelectClause:=
  ' COMP_AID, ACC_YEAR, EMP_AID, DESCRIPTION, ROUND(APR) APR, ROUND(MAY) MAY, ROUND(JUN) JUN, ROUND(JUL) JUL, ROUND(AUG) AUG,
    ROUND(SEP) SEP,ROUND(OCT) OCT, ROUND(NOV) NOV, ROUND(DEC) DEC, ROUND(JAN) JAN, ROUND(FEB) FEB, ROUND(MAR) MAR,(APR+MAY+JUN+JUL+AUG+SEP+OCT+NOV+DEC+JAN+FEB+MAR) TOTAL'
  ;
  strFromClause :=' FROM PY_VW_EMP_ITAX_DT A';
  strWhereClause:=' WHERE  A.ACC_YEAR = '||''''||pAcc_Year||''''||
  'AND A.COMP_AID = '||''''||PCOMP_AID||''' ';
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_TAX_DEDUCT;
PROCEDURE FILL_TAX_PAYMONTH(
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
IS
  strSqlQuery LONG;
  strSelectClause LONG;
  strFromClause LONG;
  strWhereClause LONG;
  strGroupByClause LONG;
  strOrderByClause LONG;
  vMostSrCiti VARCHAR2(150);
  vSrCiti     VARCHAR2(150);
  --vEXEMPT_LIMIT           PY_GM_EXEMPT_MAST.EXEMPT_LIMIT%TYPE;
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_FIRST CUR;
    TEMP_SECOND CUR;
  BEGIN
    OPEN TEMP_FIRST FOR
    SELECT A.EXEMPT_LIMIT
    FROM PY_GM_EXEMPT_MAST A,
    PY_GM_PARAMETERS B,
    PY_GM_PARAMETERS C
    WHERE A.PARA_AID=B.PAR_AID AND A.EXEMPT_MODE=C.PAR_AID AND A.COMP_AID=
    pComp_Aid
    AND TRIM(UPPER(B.PARA_MID)) ='SCITIZEN_AGE'
    AND TO_DATE(01||pPay_Month) BETWEEN EFF_DATE_FR AND NVL(EFF_DATE_TO,
    LAST_DAY(TO_DATE(01||pPay_Month)));
    FETCH
      TEMP_FIRST
    INTO
      vSrCiti;
  CLOSE TEMP_FIRST;
  vSrCiti:=NVL(vSrCiti,100);
  --             vEXEMPT_LIMIT := NVL(vEXEMPT_LIMIT,0);
  OPEN TEMP_SECOND FOR
  SELECT A.EXEMPT_LIMIT
  FROM PY_GM_EXEMPT_MAST A,
  PY_GM_PARAMETERS B,
  PY_GM_PARAMETERS C
  WHERE A.PARA_AID=B.PAR_AID AND A.EXEMPT_MODE=C.PAR_AID AND A.COMP_AID=
  pComp_Aid
  AND TRIM(UPPER(B.PARA_MID)) ='MSCITIZEN_AGE'
  AND TO_DATE(01||pPay_Month) BETWEEN EFF_DATE_FR AND NVL(EFF_DATE_TO,LAST_DAY(
  TO_DATE(01||pPay_Month)));
  FETCH
    TEMP_SECOND
  INTO
    vMostSrCiti;
  CLOSE TEMP_SECOND;
  vMostSrCiti    := NVL(vMostSrCiti,100);
  strSqlQuery    :='SELECT ';
  strSelectClause:=
  'A.COMP_AID COMP_AID,A.EMP_AID EMP_AID,A.PAN_NUMBER PAN_NUMBER,
CASE WHEN TRUNC(MONTHS_BETWEEN ('''
  ||pFrom_Date||''', NVL(Birth_Date,'''||pFrom_Date||''')) / 12) > '||vSrCiti||
  ' AND TRUNC(MONTHS_BETWEEN ('''||pFrom_Date||''', NVL(Birth_Date,'''||
  pFrom_Date||''')) / 12) < '||vMostSrCiti||
  ' THEN B.PARA_DESC||''/Sr. Citizen''
WHEN MONTHS_BETWEEN ('''
  ||pFrom_Date||''', NVL(Birth_Date,'''||pFrom_Date||''')) / 12 > '||
  vMostSrCiti||' THEN ''Most/Sr. Citizen'' ELSE B.PARA_DESC END SEX,'||''''||
  pPay_Month||''''||'PAY_MONTH,TO_CHAR(TO_NUMBER(SUBSTR('||''''||pAcc_Year||
  ''''||',3,4))+1)ACC_YEAR';
  strFromClause:=
  ' FROM PY_GM_EMPMAST A, (SELECT B.PARA_MID,B.PARA_DESC
FROM PY_GM_PARAMETER_GRPS A, PY_GM_PARAMETERS B
WHERE A.PARA_GRP_ID=B.PARA_GRP_ID
AND TRIM(UPPER(A.PARA_GRP_MID)) =''SLABTYPE'') B'
  ;
  strWhereClause:=' WHERE A.SEX=B.PARA_MID AND A.COMP_AID = '||''''||PCOMP_AID
  ||''' ';
  --            strSqlQuery:='SELECT';
  --            strSelectClause:=' COMP_AID,EMP_AID,PAN_NUMBER,SEX,'||''''||
  -- pPay_Month||''''||'PAY_MONTH,TO_CHAR(TO_NUMBER(SUBSTR('||''''||pAcc_Year||
  -- ''''||',3,4))+1)ACC_YEAR';
  --            strFromClause:=' FROM PY_GM_EMPMAST A';
  --            strWhereClause:=' WHERE  A.COMP_AID = '||''''||PCOMP_AID||''' '
  -- ;
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END FILL_TAX_PAYMONTH;
PROCEDURE SALARY_REGISTER_RPT_FORMATTED(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSqlQueryOuter LONG;
    strArrearSqlQuery LONG;
    strSubGrandTotalClause LONG;
    strGrandTotalClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strWhereNullCond LONG;
    strAllowanceMonthly LONG;
    strOtherAllowance LONG;
    strDeduction LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
  BEGIN
    --Inserting data into Temporary tables
    --            IF pIsBatchWiseReport = 'Y' THEN
    --               INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,
    -- pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
    -- pReportID,pBatch_Id,pFilterId);
    --            END IF;
    --MASTER COLUMNNS
    strSqlQuery          :='SELECT ';
    IF pIsBatchWiseReport = 'Y' THEN
      strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
      strExGroupByClause :='A.BATCH_ID, ';
    END IF;
    strSelectClause :=
    '''DS'' REPORT_SECTION ,A.PROCESS_MONTH "PAY MONTH", HD.EMP_MID AS "CODE",HD.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(HD.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(HD.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
N.ARREAR_DAYS AS "ARREAR DAYS" , HD.DEPT_DESC AS "DEPARTMENT", HD.DESG_DESC AS "DESIGNATION",HD.GRADE_DESC AS "GRADE",HD.LOC_DESC AS "LOCATION",
HD.BANK_CURR_ACCOUNT_NO AS "SAVING ACCOUNT",HD.BANK_DESC AS "BANK NAME",HD.PAN_NUMBER AS "PAN NUMBER",'
    ;
    strGroupByClause:=
    'A.PROCESS_MONTH,HD.EMP_MID,HD.EMP_NAME,HD.JOIN_DATE,HD.LEAVE_DATE,E.DAYS_PRESENT,HD.DEPT_DESC, HD.DESG_DESC,HD.GRADE_DESC,HD.LOC_DESC,
HD.BANK_CURR_ACCOUNT_NO,HD.BANK_DESC,HD.PAN_NUMBER,N.ARREAR_DAYS, '
    ;
    strOrderByClause:= ' ORDER BY HD.EMP_MID,TO_DATE(01||A.PROCESS_MONTH) ';
    FOR I IN
    (
      SELECT DISTINCT
        'ROUND(SUM(CASE WHEN A.ARR_FLAG <>''A'' THEN DECODE(TRIM(F.CTC_MID),'''
        ||TRIM(B.CTC_MID)
        ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
        ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30)
        ||'",' FLD_NAME_EAR,
        '"'
        ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30)
        ||'",' FLD_NAME_EAR_DESC,
        CASE
          WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
          THEN
            'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''
            ||TRIM(B.CTC_MID)
            ||''',NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'
            ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26)
            ||'_ARR'
            ||'",'
          ELSE NULL
        END FLD_NAME_ARR,
        CASE
          WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0
          THEN '"'
            ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26)
            ||'_ARR'
            ||'",'
          ELSE NULL
        END FLD_NAME_ARR_DESC,
        'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''
        ||TRIM(B.CTC_MID)
        ||''',NVL(A.AMOUNT,0),0)),2) AS "'
        ||SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30)
        ||'",' FLD_NAME,
        '"'
        ||SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30)
        ||'",' FLD_NAME_DESC,
        B.DISP_ORDER,
        B.CTC_TYPE,
        C.PARA_DESC,
        NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
        B.CTC_MID
      FROM
        PY_VW_PT_SAL_DT A,
        PY_CTC_ALLOWANCE_MAST B,
        PY_GM_PARAMETERS C
      WHERE
        A.COMP_AID      = B.COMP_ID
      AND A.ALLWDED_AID =B.CTC_CODE
      AND B.CTC_CATE_ID = C.PAR_AID
      AND A.ARR_FLAG   <>'F'
      AND A.AMOUNT     <>0
      AND A.COMP_AID    = pComp_Aid
      AND A.ACC_YEAR    = pAcc_Year
      AND
        (
          TO_DATE(01
          ||A.PROCESS_MONTH)>=pFrom_Date
        AND LAST_DAY(TO_DATE(01
          ||A.PROCESS_MONTH))<=pTo_Date
        )
      GROUP BY
        B.CTC_TYPE,
        C.PARA_DESC,
        B.DISP_ORDER,
        B.CTC_NAME,
        B.REG_DISP_NAME,
        B.CTC_MID
      ORDER BY
        B.CTC_TYPE,
        B.DISP_ORDER
    )
  LOOP
    IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
      IF TRIM(I.CTC_TYPE)                               = 'A' THEN
        IF TRIM(I.CTC_MID)                              ='OVT' THEN
          strAllowanceMonthly                          := strAllowanceMonthly
          ||
          'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",'
          ;
        ELSE
          strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||
          I.FLD_NAME_ARR;
          --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
        END IF;
      ELSIF TRIM(I.CTC_TYPE) = 'D' THEN
        strDeduction        := strDeduction||I.FLD_NAME;
        --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
      END IF;
    END IF;
  END LOOP;
  --  Total Gross ,Deduction and Net Salary
  strSelectClause:=strSelectClause||strAllowanceMonthly||
  ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
  strSelectClause:=strSelectClause||strDeduction||
  ' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
  strSelectClause:=strSelectClause||
  ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
  --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';
  strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause))
  -1);
  strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
  strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);
  strFromClause:=
  ' FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD HD,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
(--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''
  ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
  '''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||pPay_Month||
  ''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
WHERE COMP_AID='''
  ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
  ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
  ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
  ''' AND PAY_MONTH<>ARR_MONTH
GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N '
  ;
  strWhereClause:=
  ' WHERE A.COMP_AID = HD.COMP_AID AND A.EMP_AID = HD.EMP_AID AND A.ACC_YEAR=HD.ACC_YEAR AND A.PROCESS_MONTH=HD.PROCESS_MONTH
AND A.COMP_AID = E.COMP_AID (+) AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PROCESS_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PROCESS_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID '
  ;
  strWhereClause:=strWhereClause||
  ' AND A.ARR_FLAG<>''F'' AND (HD.LEAVE_DATE IS NULL OR (HD.LEAVE_DATE >= '''||
  pFrom_Date||'''))';
  --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
  -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
  -- A.PAY_MONTH='||''''||pPay_Month||'''';
  strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''||
  ' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||'';
  strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
  pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
  '''';
  strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';
  IF pIsBatchWiseReport='Y' THEN
    strWhereClause    :=strWhereClause||chr(13)||
    ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
  END IF;
  /*to generate the report for the Employees as per the Filter ID*/
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    (
      CASE
      WHEN TRIM(pFilterId)='EMPLOYEE' THEN
        'RP0000TEMP'
      ELSE
        pReportID
      END)||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  IF pIsMultipleSheet ='Y' THEN
    strWhereClause   :=strWhereClause||' AND '||GET_CONDITION(pMasterType ,
    pMultiSheetCondition);
  END IF;
  strSqlQuery:=strSqlQuery||CHR(13)||strExSelectClause||strSelectClause||CHR(13
  )||strFromClause||CHR(13)||strWhereClause||' '||CHR(13)||strGroupByClause||
  CHR(13)||strOrderByClause;
  --Finally Return the recordset here
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END ;
PROCEDURE SALARY_SUMMARY(
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
IS
TYPE Cur_Recordset
IS
  REF  CURSOR;
  Cur_Temp Cur_Recordset;
    strSqlQuery     LONG;
    strSelect       LONG;
    strFrom         LONG;
    strWhere        LONG;
    strGroupBy      LONG;
    strOrderBy      LONG;
    strBatchSelect  LONG;
    /*for batch wise report*/
    strBatchWhere   LONG;
    /*    -||-      */
    strBatchGroupBy LONG;
    /*    -||-      */
    strBatchOrderBy LONG;
    /*    -||-      */
    strUnion1       LONG;
    /* UNION QUERY 1*/
    strUnion2       LONG;
    /* UNION QUERY 2*/
    strGetCompName  LONG;
    strGetRptName   LONG;
    vMasterType     VARCHAR2(500);
  BEGIN
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
                   pTo_Date,strGetCompName,strGetRptName);

    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
      -- pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
      -- pIsMultipleSheet,pFilterId);
      strBatchSelect := 'HD.BATCH_ID,';
      strBatchWhere  := ' AND HD.BATCH_ID IN (SELECT BT.BATCH_ID
                          FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''||pUser_Aid||'''
                          AND SESSION_ID='''||pSessionId||''' )';

      strBatchGroupBy := ' HD.BATCH_ID,';
      strBatchOrderBy := ' BATCH_ID,';
    END IF;

    IF pReportType='Excel' THEN
      strSelect  := 'SELECT * FROM (SELECT ''AC'' REPORT_SECTION, ';

      strSelect  := strSelect||strBatchSelect||' COMP_NAME "Company",
                    PROCESS_MONTH "Process Month",COUNT(DISTINCT EMP_AID) "No. Of Employees",
                    SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT) "Gross Deduction", SUM(TNET_AMT) "Net Amount",
                    NULL "REPORT_SECTION1", NULL "Company1",NULL  "Process Month1",NULL "No. Of Employees1",
                    NULL "Gross Salary1", NULL "Gross Deduction1", NULL "Net Amount1" ';

      strFrom  := ' FROM PY_PT_SAL_HD HD,PY_GM_COMP B';
      strWhere := ' WHERE HD.COMP_AID=B.COMP_ID AND ';
      strWhere := strWhere || ' HD.COMP_AID='''||pComp_Aid|| '''
                    AND HD.ACC_YEAR='''||pAcc_Year||''' ';

      strWhere := strWhere || ' AND TO_DATE(01||HD.PROCESS_MONTH)>='''||pFrom_Date||'''
                    AND LAST_DAY(TO_DATE(01||HD.PROCESS_MONTH))<='''||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
      /*to generate the report for the Employees as per the Filter ID*/

      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
                    pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
                    pIsMultipleSheet,pFilterId);

        strWhere:=strWhere||chr(13)||
                    ' AND HD.EMP_AID IN (SELECT EMP_AID
                      FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||'''
                      AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||pReportID||'''
                      AND COMP_AID='''||pComp_Aid||''')';
      END IF;

      IF pIsMultipleSheet ='Y' THEN
        strWhere :=strWhere||' AND '||GET_CONDITION(pMasterType ,pMultiSheetCondition);
      END IF;

      strGroupBy := ' GROUP BY ';
      strGroupBy := strGroupBy||strBatchGroupBy||' COMP_NAME,COMP_MID,PROCESS_MONTH,'
                      ||GET_GROUP_BY_COLS(pMasterType,'N');
      strOrderBy := ' ORDER BY ';
      strOrderBy := strOrderBy||strBatchOrderBy||GET_GROUP_BY_COLS(pMasterType,'N')||' )';

      strUnion1:= ' UNION ALL SELECT ''DH'' REPORT_SECTION, '||strBatchSelect||
                  ' null  COMP_NAME,''TOTAL'' PROCESS_MONTH,COUNT(DISTINCT EMP_AID) "No. Of Employees",
                  SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT) "Gross Deduction", SUM(TNET_AMT) "Net Amount",
                  NULL "REPORT_SECTION1", NULL "Company1",NULL  "Process Month1",NULL "No. Of Employees1",
                  NULL "Gross Salary1", NULL "Gross Deduction1", NULL "Net Amount1" ';

      strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||' COMP_NAME, PROCESS_MONTH';

      strUnion2   :=' ';

      strSqlQuery := 'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null,
                             ''RH'' REPORT_HEADER1,'''||strGetCompName||
                             ''', null,null ,null,null,null FROM DUAL
                      UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null,
                             ''RH'' REPORT_HEADER,'''||UPPER(REPLACE(strGetRptName,'TESTING',pMasterType))||
                             ''', null,null ,null,null,null FROM DUAL
                      UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null,null,null,
                              ''DH'' REPORT_HEADER,  ''Company'',''Process Month'',
                              ''No. Of Employees'',''Gross Salary'',''Gross Deduction'',
                              ''Net Amount''  FROM DUAL UNION ALL ';

      strSqlQuery:=strSqlQuery||strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
      strSqlQuery:=strSqlQuery||strUnion1||strUnion2;
    ELSE

      strSqlQuery:='';

      vMasterType:=REPLACE(upper(trim(pMasterType)),'--SELECT--',' ' );

      strSelect  := 'SELECT * FROM (SELECT ';

      strSelect  := strSelect||NVL(SUBSTR(GET_GROUP_BY_COLS(vMasterType,'Y'),1,
                    INSTR(GET_GROUP_BY_COLS(vMasterType,'Y'),' AS')),''' ''')||
                    ' "MASTER_TYPE", COUNT(DISTINCT EMP_AID) "No. Of Employees",
                    SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT) "Deductions", SUM(TNET_AMT) "Net Amount"'
                    ||', '''||REPLACE(vMasterType,'_',' ')||''' "MASTER_NAME"';

      strFrom  := ' FROM PY_PT_SAL_HD HD,PY_GM_COMP B';
      strWhere := ' WHERE HD.COMP_AID=B.COMP_ID AND ';
      strWhere := strWhere || ' HD.COMP_AID='''||pComp_Aid||
                  ''' AND HD.ACC_YEAR='''||pAcc_Year||''' ';
      strWhere := strWhere || ' AND TO_DATE(01||HD.PROCESS_MONTH)>='''||pFrom_Date||'''
                                AND LAST_DAY(TO_DATE(01||HD.PROCESS_MONTH))<='''||pTo_Date||''' ';
      strWhere := strWhere ||strBatchWhere;
      /*to generate the report for the Employees as per the Filter ID*/
      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
        pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
        pIsMultipleSheet,pFilterId);

        strWhere:=strWhere||chr(13)||' AND HD.EMP_AID IN (
                  SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||'''
                  AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||pReportID||'''
                  AND COMP_AID='''||pComp_Aid||''')';
      END IF;
      --            IF pIsMultipleSheet ='Y' THEN
      --                strWhere:=strWhere||' AND '||GET_CONDITION(vMasterType
      -- , pMultiSheetCondition);
      --            END IF;
      strGroupBy := ' GROUP BY ';
      strGroupBy := strGroupBy||strBatchGroupBy||' COMP_NAME,COMP_MID,PROCESS_MONTH,'||GET_GROUP_BY_COLS(vMasterType,'N');
      strOrderBy := ' ORDER BY ';
      strOrderBy := strOrderBy||strBatchOrderBy||GET_GROUP_BY_COLS(vMasterType,'N')||' )';
      --            strUnion1:=' UNION ALL SELECT null  COMP_NAME,''TOTAL''
      -- PROCESS_MONTH,COUNT(DISTINCT EMP_AID) "No. Of Employees",SUM(TSAL_AMT)
      -- "Gross Salary", SUM(TDED_AMT) "Gross Deduction", SUM(TNET_AMT) "Net
      -- Amount",
      --                        NULL "REPORT_SECTION1", NULL "Company1",NULL  "
      -- Process Month1",NULL "No. Of Employees1",
      --                        NULL "Gross Salary1", NULL "Gross Deduction1",
      -- NULL "Net Amount1" ';
      --            strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||
      -- strBatchGroupBy||' COMP_NAME, PROCESS_MONTH';
      strUnion1:= ' UNION ALL SELECT ''TOTAL'' "MASTER_TYPE",COUNT(DISTINCT EMP_AID) "No. Of Employees",
                  SUM(TSAL_AMT) "Gross Salary", SUM(TDED_AMT) "Gross Deduction", SUM(TNET_AMT) "Net Amount"'
                  ||', '''||REPLACE(vMasterType,'_',' ')||''' "MASTER_NAME"';

      strUnion1:=strUnion1||strFrom||strWhere||' GROUP BY '||strBatchGroupBy||' COMP_NAME, PROCESS_MONTH';

      strUnion2:= NULL;

      strSqlQuery:=strSqlQuery||strSelect||strFrom||strWhere||strGroupBy||strOrderBy;
      strSqlQuery:=strSqlQuery||strUnion1||strUnion2;
      --    DELETE FROM VAI;



    END IF;
    --        strOrderBy := ') ORDER BY ';
    --        strOrderBy := strOrderBy||strBatchOrderBy||' LOCATION';





    OPEN Return_Recordset FOR strSqlQuery;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
  END;

  PROCEDURE GET_EMP_DETAIL(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
  BEGIN
    strSqlQuery     := 'SELECT ';
    strSelectClause :=
    'TRIM(A.COMP_MID) COMP_MID, TRIM(A.COMP_NAME) COMP_NAME, TRIM(A.CORP_ADDR) COMP_ADDRESS,
TRIM(B.EMP_MID) EMP_MID , TRIM(B.EMP_NAME) EMP_NAME, TO_CHAR(D.JOIN_DATE,''DD/MM/YYYY'') JOIN_DATE , TO_CHAR(D.LEAVE_DATE,''DD/MM/YYYY'') LEAVE_DATE,
D.GRADE_DESC, D.DESG_DESC, D.DEPT_DESC, D.LOC_DESC, D.STATE_NAME "STATE_DESC",D.BR_DESC "BR_NAME", D.CC_DESC, D.CHANNEL_DESC, D.BAND_MID "BANK NAME", D.BAND_DESC, NULL "ETYPE_DESC",
D.ESIC_NO, D.PPF_NUMBER, D.BANK_ACCOUNT_NO,
TO_CHAR(TSAL_AMT,''99999999.99'') GROSS_EARNING , TO_CHAR(TDED_AMT,''99999999.99'') GROSS_DEDUCTION,
TO_CHAR(TNET_AMT,''99999999.99'') NET_SALARY , TO_CHAR(NVL(PAID_DAYS,0),''09.99'') PAID_DAYS , TO_CHAR(NVL(ABSENT,0),''09.99'') LWP ,
''00.00'' ARREAR_DAYS, NUMBER_TO_WORDS_PIP(TNET_AMT) NET_SAL_WORDS
,B.PAN_NUMBER,B.EMP_AID EMP_AID,A.COMP_ID COMP_AID,D.PAY_MONTH PAY_MONTH, D.BANK_DESC "BNK_NAME", TO_CHAR(NVL(D.LEAVE_AV,0),''09.99'') ABSENT'
    ;
    strFromClause := '  FROM PY_GM_COMP A, PY_GM_EMPMAST B,  PY_PT_SAL_HD D ';
    strWhereClause:=
    ' WHERE A.COMP_ID = B.COMP_AID AND A.COMP_ID = D.COMP_AID AND B.EMP_AID = D.EMP_AID  AND B.COMP_AID = '
    ||''''||PCOMP_AID||''''||'AND D.ACC_YEAR = '||''''||PACC_YEAR||''''||
    'AND D.PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      strWhereClause:=strWhereClause||chr(13)||
      ' AND B.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      (
        CASE
        WHEN TRIM(pFilterId)='EMPLOYEE' THEN
          'RP0000TEMP'
        ELSE
          pReportID
        END)||''' AND B.COMP_AID='''||pComp_Aid||''')';
    END IF;
    strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;

    OPEN Return_Recordset FOR strSqlQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);

  END;

PROCEDURE GET_EARNING_DETAILS(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
  BEGIN
    strSqlQuery     := 'SELECT ';
    strSelectClause :=
    ' A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,B.CTC_NAME ALLWDED_DESC,A.PAY_MONTH,A.ACC_YEAR,
TO_CHAR(SUM(DECODE(A.ARR_FLAG,''A'',0,A.AMOUNT)),''99999999.99'') ACTUAL,
TO_CHAR(SUM(DECODE(A.ARR_FLAG,''A'',A.AMOUNT,0)),''99999999.99'')  ARRAMT,
SUM(A.AMOUNT) EARNED'
    ;
    strFromClause := '  FROM   PY_VW_PT_SAL_DT A, PY_CTC_ALLOWANCE_MAST B';
    strWhereClause:=
    '  WHERE   A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID = B.CTC_CODE
AND B.CTC_TYPE = ''A'' AND NVL (A.ARR_FLAG, ''X'') != ''F''  AND A.COMP_AID = '
    ||''''||PCOMP_AID||''''||'AND A.ACC_YEAR = '||''''||PACC_YEAR||''''||
    'AND A.PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      (
        CASE
        WHEN TRIM(pFilterId)='EMPLOYEE' THEN
          'RP0000TEMP'
        ELSE
          pReportID
        END)||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strWhereClause:=strWhereClause||chr(13)||
    ' GROUP BY A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,B.CTC_NAME,A.PAY_MONTH,A.ACC_YEAR ORDER BY A.ALLWDED_AID'
    ;
    strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
    OPEN Return_Recordset FOR strSqlQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
    --           OPEN PCURSOR FOR
    --             SELECT   A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,B.CTC_NAME
    -- ALLWDED_DESC,A.PAY_MONTH,A.ACC_YEAR,
    --                                    TO_CHAR(SUM(DECODE(A.ARR_FLAG,'A',0,
    -- A.AMOUNT)),'99999999.99') ACTUAL,
    --                                    TO_CHAR(SUM(DECODE(A.ARR_FLAG,'A',
    -- A.AMOUNT,0)),'99999999.99')  ARRAMT,
    --                                    SUM(A.AMOUNT) EARNED
    --                             FROM   PY_VW_PT_SAL_DT A, CTC_ALLOWANCE_MAST
    -- B
    --                            WHERE   A.COMP_AID = B.COMP_ID AND
    -- A.ALLWDED_AID = B.CTC_CODE
    --                                    AND B.CTC_TYPE = 'A' AND NVL (
    -- A.ARR_FLAG, 'X') != 'F'
    --                                    AND A.COMP_AID = pComp_Aid AND
    -- A.ACC_YEAR = pAcc_Year AND A.PAY_MONTH = pPay_Month AND A.EMP_AID =
    -- pEMP_AID
    --                   GROUP BY A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,
    -- B.CTC_NAME,A.PAY_MONTH,A.ACC_YEAR
    --                   ORDER BY A.ALLWDED_AID;
    --
  END;
PROCEDURE GET_ARREAR_DETAILS(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
  BEGIN
    strSqlQuery     := 'SELECT ';
    strSelectClause :=
    ' A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,B.CTC_NAME ALLWDED_DESC,A.PAY_MONTH,A.ACC_YEAR,
TO_CHAR(SUM(DECODE(A.ARR_FLAG,''A'',0,A.AMOUNT)),''99999999.99'') ACTUAL,
TO_CHAR(SUM(DECODE(A.ARR_FLAG,''A'',A.AMOUNT,0)),''99999999.99'') ARRAMT,
TO_CHAR(SUM(A.AMOUNT),''999999999999.99'') EARNED'
    ;
    strFromClause := '  FROM   PY_VW_PT_SAL_DT A, PY_CTC_ALLOWANCE_MAST B';
    strWhereClause:=
    '  WHERE   A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID = B.CTC_CODE
AND B.CTC_TYPE = ''A'' AND NVL (A.ARR_FLAG, ''X'') = ''A''  AND A.COMP_AID = '
    ||''''||PCOMP_AID||''''||'AND A.ACC_YEAR = '||''''||PACC_YEAR||''''||
    'AND A.PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      (
        CASE
        WHEN TRIM(pFilterId)='EMPLOYEE' THEN
          'RP0000TEMP'
        ELSE
          pReportID
        END)||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strWhereClause:=strWhereClause||chr(13)||
    ' GROUP BY A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,B.CTC_NAME,A.PAY_MONTH,A.ACC_YEAR HAVING   SUM (A.AMOUNT) <> 0
ORDER BY A.ALLWDED_AID'
    ;
    strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
    OPEN Return_Recordset FOR strSqlQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
    --           OPEN PCURSOR FOR
    --                 SELECT   A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,B.CTC_NAME
    -- ALLWDED_DESC,A.PAY_MONTH,A.ACC_YEAR,
    --                                            TO_CHAR(SUM(DECODE(A.ARR_FLAG
    -- ,'A',0,A.AMOUNT)),'99999999.99') ACTUAL,
    --                                            TO_CHAR(SUM(DECODE(A.ARR_FLAG
    -- ,'A',A.AMOUNT,0)),'99999999.99') ARRAMT,
    --                                            TO_CHAR(SUM(A.AMOUNT),'
    -- 999999999999.99') EARNED
    --                                     FROM   PY_VW_PT_SAL_DT A,
    -- CTC_ALLOWANCE_MAST B
    --                                    WHERE   A.COMP_AID = B.COMP_ID AND
    -- A.ALLWDED_AID = B.CTC_CODE
    --                                            AND B.CTC_TYPE = 'A' AND NVL
    -- (A.ARR_FLAG, 'X') = 'A'
    --                                            AND A.COMP_AID =pComp_Aid AND
    -- A.ACC_YEAR =pAcc_Year AND A.PAY_MONTH =pPay_Month AND A.EMP_AID =
    -- pEMP_AID
    --                           GROUP BY A.COMP_AID,A.EMP_AID, A.ALLWDED_AID,
    -- B.CTC_NAME,A.PAY_MONTH,A.ACC_YEAR
    --                           HAVING   SUM (A.AMOUNT) <> 0
    --                           ORDER BY A.ALLWDED_AID;
  END;
PROCEDURE GET_DEDUCTION_DETAILS(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    strSqlQuery LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
  BEGIN
    strSqlQuery     := 'SELECT ';
    strSelectClause :=
    ' A.ALLWDED_AID,SUM(A.AMOUNT) AMOUNT,B.CTC_NAME ALLWDED_DESC,A.ACC_YEAR,A.PAY_MONTH,A.COMP_AID,A.EMP_AID EMP_AID,TRIM (E.EMP_MID) EMP_MID,
TRIM (C.COMP_MID) COMP_MID'
    ;
    strFromClause:=
    '  FROM   PY_VW_PT_SAL_DT A, PY_CTC_ALLOWANCE_MAST B, PY_GM_COMP C, PY_GM_EMPMAST E'
    ;
    strWhereClause:=
    '  WHERE  A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID = B.CTC_CODE AND B.CTC_TYPE = ''D''
AND  C.COMP_ID = E.COMP_AID
AND A.COMP_AID = E.COMP_AID AND A.EMP_AID = E.EMP_AID AND A.COMP_AID = '
    ||''''||PCOMP_AID||''''||'AND A.ACC_YEAR = '||''''||PACC_YEAR||''''||
    'AND A.PAY_MONTH = '||''''||PPAY_MONTH||''''||'';
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      --           strWhereClause:=strWhereClause||chr(13)||' AND A.EMP_AID IN
      -- (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||'
      -- '' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN
      -- TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||'''
      -- AND COMP_AID='''||pComp_Aid||''')';
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strWhereClause:=strWhereClause||chr(13)||
    ' GROUP BY   A.COMP_AID,A.EMP_AID,A.ALLWDED_AID,B.CTC_NAME,A.ACC_YEAR,A.PAY_MONTH,E.EMP_MID, C.COMP_MID
HAVING   SUM (A.AMOUNT) <> 0
ORDER BY   A.ALLWDED_AID, B.CTC_NAME'
    ;
    strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause;
    OPEN Return_Recordset FOR strSqlQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
    --             OPEN PCURSOR FOR
    --             SELECT A.ALLWDED_AID,SUM(A.AMOUNT) AMOUNT,B.CTC_NAME
    -- ALLWDED_DESC,A.ACC_YEAR,A.PAY_MONTH,A.COMP_AID,A.EMP_AID EMP_AID,TRIM (
    -- E.EMP_MID) EMP_MID,
    --                                  TRIM (C.COMP_MID) COMP_MID
    --                           FROM   PY_VW_PT_SAL_DT A, CTC_ALLOWANCE_MAST B
    -- , PY_GM_COMP C, PY_GM_EMPMAST E
    --                          WHERE  A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID
    -- = B.CTC_CODE AND B.CTC_TYPE = 'D'
    --                                AND  C.COMP_ID = E.COMP_AID
    --                                AND A.COMP_AID = E.COMP_AID AND A.EMP_AID
    -- = E.EMP_AID
    --                                AND A.COMP_AID = pComp_Aid AND A.EMP_AID
    -- = pEmp_Aid AND A.ACC_YEAR = pAcc_Year AND A.PAY_MONTH =pPay_Month
    --                       GROUP BY   A.COMP_AID,A.EMP_AID,A.ALLWDED_AID,
    -- B.CTC_NAME,A.ACC_YEAR,A.PAY_MONTH,E.EMP_MID, C.COMP_MID
    --                       HAVING   SUM (A.AMOUNT) <> 0
    --                       ORDER BY   A.ALLWDED_AID, B.CTC_NAME;
  END;

PROCEDURE GET_ALLOW_DEDUC_DETAILS(
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
    pMultiSheetCondition VARCHAR2,
    PCURSOR OUT REC)
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    strSqlQuery LONG;
  BEGIN
    --        strSqlQuery:='SELECT ALLWDED_DESC "ALLOWANCE DESCRIPTION", AMOUNT
    -- "AMOUNT"
    --                        FROM (SELECT  PAY_MONTH,CTC_TYPE,ALLWDED_DESC,SUM
    -- (AMOUNT) AMOUNT,NVL(A.SORT_ORDER,9999999) SORT_ORDER
    --                        FROM PY_VW_EMPLOYEE_SALARY A WHERE  A.COMP_ID='''
    -- ||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||''' AND ARR_FLAG<>''F''
    --                        AND A.PROC_DATE>='''||pFrom_Date||''' AND
    -- LAST_DAY(A.PROC_DATE)<='''||pTo_Date||''' AND A.PAY_MONTH IS NOT NULL
    --                        GROUP BY  PAY_MONTH,CTC_TYPE,ALLWDED_DESC,
    -- A.SORT_ORDER
    --                        UNION ALL
    --                        SELECT  PAY_MONTH,CTC_TYPE,''TOTAL OF ''||DECODE(
    -- CTC_TYPE,''A'',''ALLOWANCES'',''DEDUCTIONS'') ALLWDED_DESC,SUM(AMOUNT),
    -- NULL
    --                        FROM PY_VW_EMPLOYEE_SALARY A
    --                        WHERE  A.COMP_ID='''||pComp_Aid||''' AND
    -- A.ACC_YEAR='''||pAcc_Year||''' AND ARR_FLAG<>''F''
    --                        AND A.PROC_DATE>='''||pFrom_Date||''' AND
    -- LAST_DAY(A.PROC_DATE)<='''||pTo_Date||''' AND A.PAY_MONTH IS NOT NULL
    --                        GROUP BY  PAY_MONTH,CTC_TYPE
    --                        UNION ALL
    --                        SELECT PAY_MONTH,NULL,''NET SALARY'' ALLWDED_DESC
    -- ,SUM(DECODE(CTC_TYPE,''A'',AMOUNT,0))-SUM(DECODE(CTC_TYPE,''D'',AMOUNT,0
    -- )) ,NULL
    --                        FROM PY_VW_EMPLOYEE_SALARY A
    --                        WHERE  A.COMP_ID='''||pComp_Aid||''' AND
    -- A.ACC_YEAR='''||pAcc_Year||''' AND ARR_FLAG<>''F''
    --                        AND A.PROC_DATE>='''||pFrom_Date||''' AND
    -- LAST_DAY(A.PROC_DATE)<='''||pTo_Date||''' AND A.PAY_MONTH IS NOT NULL
    --                        GROUP BY  PAY_MONTH)
    --                        ORDER BY  TO_DATE(01||PAY_MONTH),CTC_TYPE,
    -- SORT_ORDER,ALLWDED_DESC ';
    --
    --
    --
    --        OPEN PCURSOR FOR strSqlQuery ;
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
  END;
PROCEDURE GET_REIMB_EMP_HEADDETAILS(
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
IS
TYPE CUR
IS
  REF
  CURSOR;
    TEMP_rs CUR;
    ChkNum NUMBER(10);
  BEGIN
    OPEN TEMP_rs FOR
    SELECT COUNT(*)
    FROM py_GM_REIMB_MASTER A,
    py_PT_REIMB_CTL_DT B
    WHERE A.COMP_AID   = B.COMP_AID
    AND A.ALLWDED_AID  = B.ALLWDED_AID
    AND A.PAYMODE_FLAG = 'R'
    AND B.ACC_YEAR     =pAcc_Year
    --AND B.EMP_AID=pEmp_Aid
    AND B.COMP_AID =pComp_Aid
    AND B.PAY_MONTH=pPay_Month ;
    FETCH
      TEMP_rs
    INTO
      ChkNum;
  CLOSE TEMP_rs;
  IF ChkNum>0 THEN
    OPEN Return_Recordset FOR
    SELECT A.REIMB_DESC,
    A.PAYMODE_FLAG,
    B.COMP_AID,
    B.ACC_YEAR,
    B.EMP_AID,
    B.PAY_MONTH,
    TO_CHAR(B.OPEN_ELIGIBLITY)OPEN_ELIGIBLITY,
    TO_CHAR(B.MONTH_ELIGIBLITY)MONTH_ELIGIBLITY,
    TO_CHAR(B.SUPPORT_SUBMIT)SUPPORT_SUBMIT,
    TO_CHAR(B.ELIGIBLITY_CF)ELIGIBLITY_CF,
    TO_CHAR(B.SUPPORT_CF)SUPPORT_CF
    FROM py_GM_REIMB_MASTER A,
    py_PT_REIMB_CTL_DT B
    WHERE A.COMP_AID   = B.COMP_AID
    AND A.ALLWDED_AID  = B.ALLWDED_AID
    AND A.PAYMODE_FLAG = 'R'
    AND B.ACC_YEAR     =pAcc_Year
    --AND B.EMP_AID=pEmp_Aid
    AND B.COMP_AID =pComp_Aid
    AND B.PAY_MONTH=pPay_Month ;
  ELSE
    OPEN Return_Recordset FOR
    SELECT NULL REIMB_DESC ,
    NULL PAYMODE_FLAG,
    NULL COMP_AID,
    NULL ACC_YEAR,
    NULL EMP_AID,
    pPay_Month PAY_MONTH,
    NULL OPEN_ELIGIBLITY,
    NULL MONTH_ELIGIBLITY,
    NULL SUPPORT_SUBMIT,
    NULL ELIGIBLITY_CF,
    NULL SUPPORT_CF
    FROM DUAL;
    --                         FROM   py_GM_REIMB_MASTER A, py_PT_REIMB_CTL_DT
    -- B
    --                       WHERE       A.COMP_AID = B.COMP_AID
    --                                  AND A.ALLWDED_AID = B.ALLWDED_AID
    --                              AND A.PAYMODE_FLAG = 'R'
    --                              AND B.ACC_YEAR=pAcc_Year
    --                              AND B.EMP_AID=pEmp_Aid
    --                              AND B.COMP_AID=pComp_Aid
    --                              AND B.PAY_MONTH=pPay_Month ;
  END IF;
END GET_REIMB_EMP_HEADDETAILS;
PROCEDURE FILLEMP_INFO(
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
IS
BEGIN
  OPEN Return_Recordset FOR
  SELECT
  A.EMP_NAME,
  A.EMP_MID,
  A.PAN_NUMBER,
  A.PPF_NUMBER,
  TO_CHAR (A.JOIN_DATE, 'dd-Mon-yyyy')
AS
  JOIN_DATE,
  A.GRADE_DESC,
  A.LOC_DESC,
  A.DEPT_DESC,
  A.DESG_DESC,
  A.EMP_AID,
  A.COMP_AID,
  B.COMP_NAME,
  B.COMP_ADDR,
  A.BANK_CURR_ACCOUNT_NO
AS
  BANK_ACC,
  A.BANK_DESC FROM PY_GM_EMPMAST A,
  PY_GM_COMP B
  WHERE A.COMP_AID=pComp_Aid
  AND A.COMP_AID  =B.COMP_ID;
END FILLEMP_INFO;
PROCEDURE GET_EMP_REIMDETAILS(
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
IS
BEGIN
  OPEN Return_Recordset FOR
  SELECT COMP_AID,
  ACC_YEAR,
  EMP_AID,
  ALLWDED_AID,
  ALLWDED_TYPE,
  ALLWDED_DESC,
  (
    CASE
    WHEN TO_CHAR(APR)='0'THEN
      '-'
    ELSE
      TO_CHAR(APR)
    END) APR,
  (
    CASE
    WHEN TO_CHAR(MAY)='0'THEN
      '-'
    ELSE
      TO_CHAR(MAY)
    END) MAY,
  (
    CASE
    WHEN TO_CHAR(JUN)='0'THEN
      '-'
    ELSE
      TO_CHAR(JUN)
    END) JUN,
  (
    CASE
    WHEN TO_CHAR(JUL)='0'THEN
      '-'
    ELSE
      TO_CHAR(JUL)
    END) JUL,
  (
    CASE
    WHEN TO_CHAR(AUG)='0'THEN
      '-'
    ELSE
      TO_CHAR(AUG)
    END) AUG,
  (
    CASE
    WHEN TO_CHAR(SEP)='0'THEN
      '-'
    ELSE
      TO_CHAR(SEP)
    END) SEP,
  (
    CASE
    WHEN TO_CHAR(OCT)='0'THEN
      '-'
    ELSE
      TO_CHAR(OCT)
    END) OCT,
  (
    CASE
    WHEN TO_CHAR(NOV)='0'THEN
      '-'
    ELSE
      TO_CHAR(NOV)
    END) NOV,
  (
    CASE
    WHEN TO_CHAR(DEC)='0'THEN
      '-'
    ELSE
      TO_CHAR(DEC)
    END) DEC,
  (
    CASE
    WHEN TO_CHAR(JAN)='0'THEN
      '-'
    ELSE
      TO_CHAR(JAN)
    END) JAN,
  (
    CASE
    WHEN TO_CHAR(FEB)='0'THEN
      '-'
    ELSE
      TO_CHAR(FEB)
    END) FEB,
  (
    CASE
    WHEN TO_CHAR(MAR)='0'THEN
      '-'
    ELSE
      TO_CHAR(MAR)
    END) MAR,
  (
    CASE
    WHEN TO_CHAR(TOTAL)='0'THEN
      '-'
    ELSE
      TO_CHAR(TOTAL)
    END) TOTAL
  FROM PY_VW_REPORT_REIMB_SLIP
  WHERE COMP_AID=pComp_Aid
  AND ACC_YEAR  =pAcc_Year;
  --AND EMP_AID=pEmp_Aid;
END GET_EMP_REIMDETAILS;

PROCEDURE SALARY_REGISTER_CTC_RPT(
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
    pMultiSheetCondition VARCHAR2,
    Return_Recordset OUT REC)
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSqlQueryOuter LONG;
    strArrearSqlQuery LONG;
    strSubGrandTotalClause LONG;
    strGrandTotalClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strWhereNullCond LONG;
    strAllowanceMonthly LONG;
    strOtherAllowance LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strArrMonth LONG;
    strArrMonthHead LONG;
    strNullHead LONG;
    strHeaderQuery LONG;
    vFlag VARCHAR(1);
    strAllwanceHead LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    vCount NUMBER(12,2);
    strDeduction LONG;
    strDeductionHead LONG;
    strArrear LONG;
    strArrearHead LONG;
    strQuery LONG;
    strNullHeadArr LONG;
    strReimbHead LONG;
    strReimb LONG;
  BEGIN
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
    pTo_Date,strGetCompName,strGetRptName);
    --MASTER COLUMNNS
    IF pIsBatchWiseReport = 'Y' THEN
      strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
      strExGroupByClause :='A.BATCH_ID, ';
    END IF;
    vCount:=0;
    FOR I IN
    (
      SELECT DISTINCT
        '"'
        ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30)
        ||'",' FLD_NAME_EAR_DESC,
        CASE
          WHEN B.CTC_TYPE                                                ='A'
          AND SUM(DECODE(C.PARA_MID,'REIMBURSEMENT',0,NVL(A.AMOUNT,1))) <>0
          THEN
            'ROUND(SUM(CASE WHEN A.ARR_FLAG <>''A'' AND M.PARA_MID<>''REIMBURSEMENT'' THEN DECODE(TRIM(F.CTC_MID),'''
            ||TRIM(B.CTC_MID)
            ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
            ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30)
            ||'",'
          ELSE NULL
        END FLD_NAME_EAR,
        CASE
          WHEN B.CTC_TYPE                                                ='D'
          AND SUM(DECODE(C.PARA_MID,'REIMBURSEMENT',0,NVL(A.AMOUNT,1))) <>0
          THEN
            'ROUND(SUM(CASE WHEN A.ARR_FLAG <>''A'' AND M.PARA_MID<>''REIMBURSEMENT'' THEN DECODE(TRIM(F.CTC_MID),'''
            ||TRIM(B.CTC_MID)
            ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
            ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30)
            ||'",'
          ELSE NULL
        END FLD_NAME_DED,
        CASE
          WHEN SUM(DECODE(C.PARA_MID,'REIMBURSEMENT',NVL(A.AMOUNT,1),0)) <>0
          THEN
            'ROUND(SUM(CASE WHEN A.ARR_FLAG <>''A'' AND M.PARA_MID=''REIMBURSEMENT'' THEN DECODE(TRIM(F.CTC_MID),'''
            ||TRIM(B.CTC_MID)
            ||''',NVL(A.AMOUNT,0),0) END),2) AS "'
            ||SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30)
            ||'",'
          ELSE NULL
        END FLD_NAME_REIMB,
        'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''
        ||TRIM(B.CTC_MID)
        ||''',NVL(A.AMOUNT,0),0)),2) AS "'
        ||SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30)
        ||'",' FLD_NAME,
        '"'
        ||SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30)
        ||'",' FLD_NAME_DESC,
        B.DISP_ORDER,
        B.CTC_TYPE,
        C.PARA_DESC,
        NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
        B.CTC_MID
      FROM
        PY_VW_PT_SAL_DT A,
        PY_CTC_ALLOWANCE_MAST B,
        PY_GM_PARAMETERS C,
        PY_PT_REIMB_CTL_DT D
      WHERE
        A.COMP_AID      = B.COMP_ID
      AND A.ALLWDED_AID =B.CTC_CODE
      AND B.CTC_CATE_ID = C.PAR_AID
      AND A.COMP_AID    = D.COMP_AID
      AND A.ARR_FLAG   <>'F'
      AND A.AMOUNT     <>0
      AND A.COMP_AID    = pComp_Aid
      AND A.ACC_YEAR    = pAcc_Year
      AND
        (
          TO_DATE(01
          ||A.PROCESS_MONTH)>=pFrom_Date
        AND LAST_DAY(TO_DATE(01
          ||A.PROCESS_MONTH))<=pTo_Date
        )
      GROUP BY
        B.CTC_TYPE,
        C.PARA_DESC,
        B.DISP_ORDER,
        B.CTC_NAME,
        B.REG_DISP_NAME,
        B.CTC_MID
      ORDER BY
        B.CTC_TYPE,
        B.DISP_ORDER
    )
  LOOP
    vCount                :=vCount+1;
    IF I.FLD_NAME_EAR     IS NOT NULL THEN
      strAllowanceMonthly := strAllowanceMonthly ||SUBSTR(I.FLD_NAME_EAR,1,
      instr(I.FLD_NAME_EAR,' AS '))||',';
      strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
      I.FLD_NAME_EAR,' AS ')+4);
      strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
    END IF;
    IF I.FLD_NAME_DED IS NOT NULL THEN
      strDeduction    := strDeduction ||SUBSTR(I.FLD_NAME_DED,1,INSTR(
      I.FLD_NAME_DED,' AS ')) ||',' ;
      strDeductionHead:= strDeductionHead||SUBSTR(I.FLD_NAME_DED,INSTR(
      I.FLD_NAME_DED,' AS ')+4);
      strNullHead:= strNullHead||',NULL "'||vCount||'_2"';
    END IF;
    IF I.FLD_NAME_REIMB IS NOT NULL THEN
      strReimb          := strReimb ||SUBSTR(I.FLD_NAME_REIMB,1,INSTR(
      I.FLD_NAME_REIMB,' AS ')) ||',' ;
      strReimbHead:= strReimbHead||SUBSTR(I.FLD_NAME_REIMB,INSTR(
      I.FLD_NAME_REIMB,' AS ')+4);
      strNullHead:= strNullHead||',NULL "'||vCount||'_3"';
    END IF;
  END LOOP;
  strHeaderQuery:=strAllwanceHead||'"GROSS EARNING",'||strDeductionHead||
  '"DEDUCTION","NET SALARY", '||strReimbHead||'"TOTAL REIMB"';
  strQuery:=strAllowanceMonthly||
  ' CASE WHEN SUM(DECODE(A.ARR_FLAG,''A'',0,A.AMOUNT))<>0 AND SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) <>0 AND SUM(DECODE(M.PARA_MID,''REIMBURSEMENT'',0,NVL(A.AMOUNT,1))) <>0 THEN SUM(A.AMOUNT) END AS "GROSS EARNING" ,'
  ||strDeduction||
  ' CASE WHEN SUM(DECODE(M.PARA_MID,''REIMBURSEMENT'',0,NVL(A.AMOUNT,1))) <>0 THEN SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) END AS "DEDUCTION" ,SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",'
  ||strReimb||
  ' SUM(DECODE(M.PARA_MID,''REIMBURSEMENT'',A.AMOUNT,0)) AS "TOTAL REIMB",';
  strNullHead:=strNullHead||
  ',null "GROSS EARNING1",null "DEDUCTION1",null "NET SALARY1",null "TOTAL REIMB1"'
  ;
  strHeaderQuery:=REPLACE(strHeaderQuery,',,',',');
  strQuery      :=REPLACE(strQuery,',,',',');
  strNullHead   :=REPLACE(strNullHead,',,',',');
  strSqlQuery   :=
  'SELECT ''X#X#X'' REPORT_HEADER,NULL, null,null ,null, null,null ,null,null, null,null,null,null,null,null'
  ||strNullHead||strNullHeadArr||
  ',
''RH'' REPORT_HEADER1,'''||
  strGetCompName||
  ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null'||
  strNullHead||strNullHeadArr||
  ' FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,NULL, null,null ,null, null,null,null ,null, null,null,null,null,null,null'
  ||strNullHead||strNullHeadArr||
  ',
''RH'' REPORT_HEADER,'''||
  strGetRptName||
  ''', null,null ,null, null,null,null ,null, null,null,null,null,null,null'||
  strNullHead||strNullHeadArr||
  ' FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null'
  ||strNullHead||strNullHeadArr||
  ',
''DH'' REPORT_HEADER1, ''PAY MONTH'', ''CODE'',''EMPLOYEE NAME'' ,''JOINING DATE'', ''QUIT DATE'',''PRESENT DAYS'',
''ARREAR DAYS'' '
  ||REPLACE(strArrMonthHead,'"','''')||
  ',''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'','
  ||REPLACE(strHeaderQuery,'"','''')||' FROM DUAL UNION ALL ';
  --||replace(strArrearHead,'"','''')
  strSelectClause :='SELECT * FROM (SELECT ''AC'' REPORT_HEADER,';
  strSelectClause := strSelectClause||
  'A.PROCESS_MONTH "PAY MONTH", B.EMP_MID AS "CODE",B.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
N.ARREAR_DAYS AS "ARREAR DAYS" '
  ||strArrMonthHead||
  ', B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
B.BANK_CURR_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",B.PAN_NUMBER AS "PAN NUMBER",'
  ;
  strGroupByClause:=
  'A.PROCESS_MONTH,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,
B.BANK_CURR_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER,N.ARREAR_DAYS, '
  ;
  strOrderByClause:= ' ORDER BY B.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)) ';
  strSelectClause :=strSelectClause||strQuery;
  strSelectClause :=strSelectClause||
  'null REPORT_HEADER1,null "PAY MONTH1", null "CODE1",null "EMPLOYEE NAME1" ,null "JOINING DATE1",null "QUIT DATE1",null "PRESENT DAYS1",
null "ARREAR DAYS1" '
  ||strNullHead||strNullHeadArr||
  ', null "DEPARTMENT1", null "DESIGNATION1",null "GRADE1",null "LOCATION1",
null "SAVING ACCOUNT1",null "BANK NAME1",null "PAN NUMBER1",'
  ;
  strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause))
  -1);
  strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
  strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1)||strArrMonthHead;
  strFromClause:=
  ' FROM VW_REIMB_DTL A,PY_GM_EMPMAST B,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
(SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS'
  ||strArrMonth||
  ' FROM PY_PT_ARR_DAYS_DT A
WHERE COMP_AID='''
  ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
  ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
  ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
  ''' AND PAY_MONTH<>ARR_MONTH
GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N '
  ;
  strWhereClause:=
  ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID
AND A.COMP_AID = E.COMP_AID (+) AND A.ACC_YEAR=E.ACC_YEAR (+) AND A.PROCESS_MONTH=E.PAY_MONTH (+) AND A.EMP_AID = E.EMP_AID (+)
AND A.COMP_AID = N.COMP_AID (+) AND A.ACC_YEAR=N.ACC_YEAR (+) AND A.PROCESS_MONTH=N.PAY_MONTH (+) AND A.EMP_AID = N.EMP_AID (+)
AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)  AND F.CTC_CATE_ID = M.PAR_AID '
  ;
  strWhereClause:=strWhereClause||
  ' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||
  pFrom_Date||'''))';
  --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
  -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
  -- A.PAY_MONTH='||''''||pPay_Month||'''';
  strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''||
  ' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||'';
  strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
  pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
  '''';
  strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';
  IF pIsBatchWiseReport='Y' THEN
    strWhereClause    :=strWhereClause||chr(13)||
    ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
  END IF;
  /*to generate the report for the Employees as per the Filter ID*/
  IF pFilterId IS NOT NULL THEN
    INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
    pFilterId);
    --                   strWhereClause:=strWhereClause||chr(13)||' AND
    -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
    -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
    -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
    -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
    strWhereClause:=strWhereClause||chr(13)||
    ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
    ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
    pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
  END IF;
  strSqlQuery:=strSqlQuery||CHR(13)||strExSelectClause||strSelectClause||CHR(13
  )||strFromClause||CHR(13)||strWhereClause||' '||CHR(13)||strGroupByClause||
  CHR(13)||strOrderByClause;
  --
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM)
  ;
END;

PROCEDURE GET_MONTH_FOR(
    pComp_Aid            VARCHAR2,
    pAcc_Year            VARCHAR2,
    pReportID            VARCHAR2,
    pPay_Month           VARCHAR2,
    pFrom_Date           DATE,
    pTo_Date             DATE,
    pReport_ForMonth OUT VARCHAR2)
IS
TYPE REC
IS
  REF
  CURSOR;
    Temp_Rec REC;
    strRpt_Name PY_GM_REPORT_MASTER.REPORT_NAME%TYPE;
  BEGIN
    IF pPay_Month IN ('QUARTERLY I','QUARTERLY II','QUARTERLY III',
      'QUARTERLY IV','YEARLY','DATE WISE REPORT') THEN
      pReport_ForMonth:= 'FOR '||pPay_Month||CHR(13)||'FROM : '||TO_CHAR(
      pFrom_Date,'DD-MON-YYYY')||' TO : '||TO_CHAR(pTo_Date,'DD-MON-YYYY');
      IF pPay_Month      ='YEARLY' THEN
        pReport_ForMonth:= 'FOR THE YEAR '||SUBSTR(pAcc_Year,3,LENGTH(pAcc_Year
        )-4)||'-'||SUBSTR(pAcc_Year,7,2);
      END IF;
    ELSE
      pReport_ForMonth:= 'FOR THE MONTH OF '||pPay_Month;
    END IF;
  END;

PROCEDURE REIMB_REG_RPT(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strGetCompName LONG;
    strGetRptName LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strCTC_COLUMNS LONG;
    strCTC_CATE LONG;
    strNULL_VAL LONG;
    Strheader_Col Long;
    strNULL_COLUMNS LONG;
    strSEQ_COL LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strSqlQuery LONG;
  BEGIN



    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
    pTo_Date,strGetCompName,strGetRptName);
    IF pIsBatchWiseReport = 'Y' THEN
      strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
      strExGroupByClause :='A.BATCH_ID, ';
    End If;
    strSelectClause :=
    '  SELECT * FROM ( SELECT ''AC'' "REPORT_HEADER",D.EMP_MID AS "CODE",D.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(D.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",TO_CHAR(D.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
N.ARREAR_DAYS AS "ARREAR DAYS" , D.DEPT_DESC AS "DEPARTMENT", D.DESG_DESC AS "DESIGNATION",D.GRADE_DESC AS "GRADE",D.LOC_DESC AS "LOCATION",
D.BANK_CURR_ACCOUNT_NO AS "SAVING ACCOUNT",D.BANK_DESC AS "BANK NAME",D.PAN_NUMBER AS "PAN NUMBER",'
    ;
    strGroupByClause:=
    'D.EMP_MID,D.EMP_NAME,D.JOIN_DATE,D.LEAVE_DATE,E.DAYS_PRESENT,D.DEPT_DESC, D.DESG_DESC,D.GRADE_DESC,D.LOC_DESC,
D.BANK_CURR_ACCOUNT_NO,D.BANK_DESC,D.PAN_NUMBER,N.ARREAR_DAYS, '
    ;
    strOrderByClause:= ' ORDER BY D.EMP_MID )';




    OPEN Cur_Temp FOR
    SELECT
    --WM_CONCAT(CTC_COLUMNS),WM_CONCAT(CTC_CATE),WM_CONCAT(NULL_VAL),WM_CONCAT(HEADER_COL),WM_CONCAT(SEQ_NO),SUBSTR(WM_CONCAT(SRNO),-1)
    LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
    LISTAGG(CTC_CATE,',') WITHIN GROUP (ORDER BY ROWNUM),
    LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
    LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM),
    LISTAGG(SEQ_NO,',') WITHIN GROUP (ORDER BY ROWNUM),
    SUBSTR(LISTAGG(SRNO,',') WITHIN GROUP (ORDER BY ROWNUM),-1)
    FROM
    (
      SELECT
        CTC_COLUMNS,
        DECODE(ROW_NUMBER() OVER (PARTITION BY CTC_CATE ORDER BY CTC_CATE) ,1,
        CTC_CATE,'NULL') CTC_CATE,
        NULL_VAL,
        HEADER_COL ,
        'NULL "'
        ||ROW_NUMBER() OVER (ORDER BY CTC_CATE)
        ||'_1"' SEQ_NO,
        ROW_NUMBER() OVER (ORDER BY CTC_CATE) SRNO
      FROM
        (
          SELECT DISTINCT
            'TO_CHAR(SUM(DECODE(TRIM(CTC_MID),'''
            ||B.CTC_MID
            ||''',AMOUNT,0))) "'
            ||SUBSTR(B.CTC_NAME,1,26)
            ||'_CTC"' CTC_COLUMNS,
            B.SORT_ORDER,
            ' '''
            ||C.PARA_MID
            ||'''' CTC_CATE ,
            'NULL as "'
            ||SUBSTR(B.CTC_NAME,1,30)
            ||'1"' NULL_VAL,
            ''''
            ||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')
            ||'''' HEADER_COL
          FROM
            VIEW_REIMB_SAL_DT A,
            PY_CTC_ALLOWANCE_MAST B,
            PY_GM_PARAMETERS C
          WHERE
            A.COMP_AID      =B.COMP_ID
          AND A.ALLWDED_AID =B.CTC_CODE
          AND B.CTC_CATE_ID = C.PAR_AID
          AND A.COMP_AID    = pComp_Aid
          AND A.ACC_YEAR    = pAcc_Year
          AND A.ARR_FLAG   <>'F'
          AND C.PARA_MID    ='REIMBURSEMENT'
          AND
            (
              TO_DATE(01
              ||A.PROCESS_MONTH)>=pFrom_Date
            AND LAST_DAY(TO_DATE(01
              ||A.PROCESS_MONTH))<=pTo_Date
            )
          GROUP BY
            B.SORT_ORDER,
            B.CTC_MID,
            B.CTC_NAME,
            C.PARA_MID
        )
    )
    ;
    FETCH
      Cur_Temp
    INTO
      strCTC_COLUMNS,
      strCTC_CATE,
      strNULL_VAL,
      strHEADER_COL,
      strNULL_COLUMNS,
      strSEQ_COL;
    CLOSE Cur_Temp;
    strSqlQuery :=
    'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null ,null,null, null,null,null,null,null,null,'
    ||strNULL_COLUMNS||
    ',null,
''RH'' REPORT_HEADER1,'''||
    strGetCompName||
    ''', null,null ,null, null,null,null ,null, null,null,null,null,null,'||
    strNULL_COLUMNS||
    ',null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null, null,null,null,null,null,null,'
    ||strNULL_COLUMNS||
    ',null,
''RH'' REPORT_HEADER,'''||
    strGetRptName||
    ''', null,null ,null, null,null,null ,null, null,null,null,null,null,'||
    strNULL_COLUMNS||
    ',null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,'
    ||strNULL_COLUMNS||
    ',null,
''DH'' REPORT_HEADER1, ''CODE'', ''EMPLOYEE NAME'' ,''JOINING DATE'', ''QUIT DATE'',''PRESENT DAYS'',
''ARREAR DAYS'' ,''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'','
    ||REPLACE(strHEADER_COL,'"','''')||',''TOTAL'' FROM DUAL UNION ALL';
    strFromClause:=
    ' FROM VIEW_REIMB_SAL_DT A,PY_CTC_ALLOWANCE_MAST B,PY_GM_PARAMETERS C,PY_PT_SAL_HD D,PY_PT_PRESENT E,
(SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
WHERE COMP_AID='''
    ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
    ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
    ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
    ''' AND PAY_MONTH<>ARR_MONTH
GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N '
    ;
    strWhereClause:=
    ' WHERE A.COMP_AID = B.COMP_ID AND A.ALLWDED_AID = B.CTC_CODE
AND B.CTC_CATE_ID = C.PAR_AID
AND A.COMP_AID=D.COMP_AID AND A.EMP_AID=D.EMP_AID AND A.ACC_YEAR=D.ACC_YEAR AND A.PROCESS_MONTH=D.PROCESS_MONTH AND D.PAY_MONTH IS NOT NULL
AND A.COMP_AID=E.COMP_AID(+) AND A.EMP_AID=E.EMP_AID(+) AND A.ACC_YEAR=E.ACC_YEAR(+) AND A.PROCESS_MONTH=E.PAY_MONTH(+)
AND A.COMP_AID=N.COMP_AID(+) AND A.EMP_AID=N.EMP_AID(+) AND A.ACC_YEAR=N.ACC_YEAR(+) AND A.PROCESS_MONTH=N.PAY_MONTH(+)'
    ;
    IF TRIM(pIsMultipleSheet) ='Y' THEN
      strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
      pMasterType , pMultiSheetCondition),'HD.','D.');
    END IF;
    strSelectClause:=strSelectClause||strCTC_COLUMNS||
    '  ,TO_CHAR(SUM(DECODE(TRIM(PARA_MID),''REIMBURSEMENT'',AMOUNT,0))) "TOTAL",
null "REPORT_HEADER1",null AS "CODE1",null AS "EMPLOYEE NAME1" ,null AS "JOINING DATE1",null AS "QUIT DATE1",null AS "PRESENT DAYS1",null AS "ARREAR DAYS1" ,
null AS "DEPARTMENT1", null AS "DESIGNATION1",null AS "GRADE1",null AS "LOCATION1",null AS "SAVING ACCOUNT1",null AS "BANK NAME1",null AS "PAN NUMBER1",
'
    ||strNULL_VAL||',null "TOTAL1" ';
    strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
    strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);
    strWhereClause:=strWhereClause||
    ' AND A.ARR_FLAG<>''F'' AND (D.LEAVE_DATE IS NULL OR (D.LEAVE_DATE >= '''||
    pFrom_Date||'''))';
    strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''||pComp_Aid||''''
    ||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||'';
    strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
    pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
    '''';
    strWhereClause:=strWhereClause||
    ' AND A.PAY_MONTH IS NOT NULL AND C.PARA_DESC=''REIMBURSEMENT''';
    IF pIsBatchWiseReport='Y' THEN
      strWhereClause    :=strWhereClause||chr(13)||
      ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
    END IF;
    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
      ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
      ,pFilterId);
      --                   strWhereClause:=strWhereClause||chr(13)||' AND
      -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''|
      -- |pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
      -- ||(CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE
      -- pReportID END)||''' AND COMP_AID='''||pComp_Aid||''')';
      strWhereClause:=strWhereClause||chr(13)||
      ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strSqlQuery:=strSqlQuery||strExSelectClause||strSelectClause||CHR(13)||
    strFromClause||CHR(13)||strWhereClause||' '||CHR(13)||strGroupByClause||CHR
    (13)||strOrderByClause;

    OPEN Return_Recordset FOR strSqlQuery ;
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM);
  END;

PROCEDURE PROC_GEN_VARIANCE_DATA(
    pComp_Aid  VARCHAR2,
    pAcc_Year  VARCHAR2,
    pPay_Month VARCHAR2,
    pFrom_Date DATE,
    pTo_Date   DATE,
    pUser_Aid  VARCHAR2
    ,
    pSessionId        VARCHAR2,
    pReportId         VARCHAR2,
    pTable_Name       VARCHAR2,
    pPayMonth_FLDName VARCHAR2,
    pRPTVarianceCols  VARCHAR2,
    pVarianceInsQuery VARCHAR2)
IS
  --,'pTable_Name'     --this parameter is the table name for which Variance is
  -- to be found
  --,'pPayMonth_FLDName'    --this parameter is the column name of PAY_MONTH
  -- field in the above table name
  --,pRPTVarianceCols   --this parameter is the fields against which variance
  -- is to be found
  --,pVarianceInsQuery               --this parameter contains Select Query for
  -- which data is to be directly inserted into  PY_PT_VARIANCE_TAB
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSqlQueryOuter LONG;
    strArrearSqlQuery LONG;
    strSubGrandTotalClause LONG;
    strGrandTotalClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strWhereNullCond LONG;
    strAllowanceMonthly LONG;
    strOtherAllowance LONG;
    strDeduction LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strSqlQueryFormat LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    strNullHead LONG;
    vCount NUMBER(10) DEFAULT 1;
    strDedNullHead LONG;
    strAllwNullHead LONG;
    strAllwanceHead LONG;
    strDeductionHead LONG;
    pReportFields LONG;
    vDISP_FIELDS LONG;
    vSRNO VARCHAR2(50);
    vDISP_FIELDS_DESC LONG;
    vDISP_SRNO LONG;
  BEGIN
    SELECT
--      REPLACE (WM_CONCAT(DISP_FEILDS_DESC),',',' ') DISP_FEILDS_DESC,
--      REPLACE (WM_CONCAT(DISP_FEILDS),',WHEN',' WHEN') DISP_FEILDS,
--      REPLACE (WM_CONCAT(DISP_SRNO),',',' ') DISP_SRNO
      REPLACE (LISTAGG(DISP_FEILDS_DESC,',') WITHIN GROUP (ORDER BY ROWNUM),',',' ') DISP_FEILDS_DESC,
      REPLACE (LISTAGG(DISP_FEILDS,',') WITHIN GROUP (ORDER BY ROWNUM),',WHEN',' WHEN') DISP_FEILDS,
      REPLACE (LISTAGG(DISP_SRNO,',') WITHIN GROUP (ORDER BY ROWNUM),',',' ') DISP_SRNO
    INTO
      vDISP_FIELDS_DESC,
      vDISP_FIELDS,
      vDISP_SRNO
    FROM
      (
        SELECT
          'WHEN COLUMN_NAME = '''
          ||SUBSTR(COL_DESC,1,DECODE(INSTR(COL_DESC,'"'),0,LENGTH(COL_DESC),
          INSTR(COL_DESC,'"')-2))
          ||''' THEN '''
          ||REPLACE(SUBSTR(COL_DESC,INSTR(COL_DESC,'"')),'"','')
          ||'''' DISP_FEILDS_DESC ,
          'WHEN COLUMN_NAME = '''
          ||SUBSTR(COL_DESC,1,DECODE(INSTR(COL_DESC,'"'),0,LENGTH(COL_DESC),
          INSTR(COL_DESC,'"')-2))
          ||''' THEN '
          ||DECODE(INSTR(COL_DESC,'DATE'),0,SUBSTR(COL_DESC,1,DECODE(INSTR(
          COL_DESC,'"'),0,LENGTH(COL_DESC),INSTR(COL_DESC,'"')-2)),'TO_CHAR('
          ||SUBSTR(COL_DESC,1,DECODE(INSTR(COL_DESC,'"'),0,LENGTH(COL_DESC),
          INSTR(COL_DESC,'"')-2))
          ||',''DD-MON-YYYY'')') DISP_FEILDS ,
          SRNO ,
          'WHEN COLUMN_NAME = '''
          ||SUBSTR(COL_DESC,1,DECODE(INSTR(COL_DESC,'"'),0,LENGTH(COL_DESC),
          INSTR(COL_DESC,'"')-2))
          ||''' THEN '
          ||SRNO DISP_SRNO
        FROM
          (
            SELECT
              REGEXP_SUBSTR(pRPTVarianceCols,'[^[,]+',1,LEVEL) COL_DESC,
              LEVEL SRNO
            FROM
              DUAL CONNECT BY REGEXP_SUBSTR(pRPTVarianceCols,'[^[,]+',1,LEVEL)
              IS NOT NULL
          )
      );
    strSqlQuery:=
    'INSERT INTO PY_PT_VARIANCE_TAB(USER_AID, SESSION_ID, REPORT_ID, COMP_AID, ACC_YEAR, EMP_AID, PAY_MONTH, COL_NAME, COL_VALUE,SRNO)'
    ;
    IF trim(pVarianceInsQuery) IS NULL AND trim(pTable_Name) IS NOT NULL THEN
      strSelectClause          :=' SELECT '''||pUSER_AID||''', '''||pSessionId
      ||''','''||pReportId||
      ''',COMP_AID,ACC_YEAR,EMP_AID,PROCESS_MONTH,MASTER_COLS, MASTER_DATA,DISP_SRNO FROM ('
      ;
      strSelectClause:=strSelectClause||
      '     SELECT COMP_AID,ACC_YEAR,EMP_AID, '||pPayMonth_FLDName;
      strSelectClause:=strSelectClause||' ,CASE '||vDISP_FIELDS_DESC ||
      ' END MASTER_COLS';
      strSelectClause:=strSelectClause||' ,CASE '||vDISP_FIELDS ||
      ' END MASTER_DATA';
      strSelectClause:=strSelectClause||' ,CASE '||vDISP_SRNO ||
      ' END DISP_SRNO';
      strFromClause:=' FROM '||pTable_Name||' A';
      strFromClause:=strFromClause||
      ' CROSS JOIN (
SELECT column_name
FROM user_tab_columns COLS
WHERE table_name = '''
      ||pTable_Name||
      '''
AND TRIM(column_name) IN (SELECT TRIM(UPPER(SUBSTR(COL_DESC,1,DECODE(INSTR(COL_DESC,''"''),0,LENGTH(COL_DESC),INSTR(COL_DESC,''"'')-2))))
FROM  (SELECT REGEXP_SUBSTR('''
      ||pRPTVarianceCols||
      ''',''[^[,]+'',1,LEVEL)  COL_DESC
FROM DUAL CONNECT BY REGEXP_SUBSTR('''
      ||pRPTVarianceCols||''',''[^[,]+'',1,LEVEL) IS NOT NULL)))';
      strWhereClause:= ' WHERE A.COMP_AID='''||pComp_Aid||''' AND A.'||
      pPayMonth_FLDName||' IN ('''||TO_CHAR(ADD_MONTHS(pFrom_Date,-1),
      'MON YYYY')||''','''||TO_CHAR(pTo_Date,'MON YYYY')||''') ';
      strWhereClause:= strWhereClause||' )';
      --                strOrderByClause:=' ORDER BY COMP_AID,ACC_YEAR,EMP_AID,
      -- PROCESS_MONTH';
      strSqlQuery:=strSqlQueryFormat||strSqlQuery||CHR(13)||strExSelectClause||
      strSelectClause||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||
      CHR(13)||strGroupByClause||strOrderByClause;
    ELSE
      strWhereClause:= ' WHERE COMP_AID='''||pComp_Aid||''' AND '||
      pPayMonth_FLDName||' IN ('''||TO_CHAR(ADD_MONTHS(pFrom_Date,-1),
      'MON YYYY')||''','''||TO_CHAR(pTo_Date,'MON YYYY')||''') ';
      strSqlQuery:=strSqlQuery||CHR(13)||pVarianceInsQuery||CHR(13)||
      strWhereClause;
    END IF;
    EXECUTE IMMEDIATE strSqlQuery;
    COMMIT;
  END;
PROCEDURE MASTER_CTC_VARIANCE_RPT(
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
IS
  vRPTVarianceCols  VARCHAR2(2000);
  vVarianceInsQuery VARCHAR2(2000);
  vPrvPay_Month     DATE;
  strSelect LONG;
  strExSelectClause LONG;
  strExGroupByClause LONG;
  strSqlQueryFormat LONG;
  strGetCompName LONG;
  strGetRptName LONG;
BEGIN
  PY_PK_STANDARD_REPORTS.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,
  pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);
  vPrvPay_Month:=ADD_MONTHS(TO_DATE(01||pPay_Month),-1);
  DELETE
  FROM
    PY_PT_VARIANCE_TAB
  WHERE
    USER_AID   = pUser_Aid
  AND REPORT_ID=pReportID;
  --Maaster Data
  vRPTVarianceCols :=
  'EMP_NAME "EMPLOYEE NAME",JOIN_DATE "JOINING DATE",LEAVE_DATE "QUIT DATE",DESG_DESC "DESIGNATION",GRADE_DESC "GRADE",DEPT_DESC "DEPARTMENT",CC_DESC "COST CENTER",LOC_DESC "LOCATION",BANK_ACCOUNT_NO "SAVING ACCOUNT NO",BANK_DESC "BANK NAME"'
  ;
  PROC_GEN_VARIANCE_DATA(pComp_Aid,pAcc_Year,pPay_Month,pFrom_Date,pTo_Date,
  pUser_Aid,pSessionId,pReportId
  ,'PY_PT_SAL_HD' --this parameter is the table name for which Variance is to
  -- be found
  ,'PROCESS_MONTH' --this parameter is the column name of PAY_MONTH field in
  -- the above table name
  ,vRPTVarianceCols --this parameter is the fields against which variance is to
  -- be found
  ,NULL ); --this parameter contains Select Query for which data is to be
  -- directly inserted into  PY_PT_VARIANCE_TAB
  --Present Days Data
  vVarianceInsQuery:='SELECT '''||pUSER_AID||''','''||pSessionId||''','''||
  pReportID||
  ''',COMP_AID,ACC_YEAR,EMP_AID,PAY_MONTH,''PRESENT DAYS'',DAYS,''B''||1 FROM PY_PT_ARR_DAYS_DT'
  ;
  PROC_GEN_VARIANCE_DATA(pComp_Aid,pAcc_Year,pPay_Month,pFrom_Date,pTo_Date,
  pUser_Aid,pSessionId,pReportId,NULL,'PAY_MONTH',NULL,vVarianceInsQuery );
  --ctc data
  vVarianceInsQuery:='SELECT '''||pUSER_AID||''','''||pSessionId||''','''||
  pReportID||
  ''',COMP_AID,ACC_YEAR,EMP_AID,PAY_MONTH,ALLWDED_DESC,AMOUNT,''C''||SORT_ORDER FROM PY_CTC_VARIANCE'
  ;
  PROC_GEN_VARIANCE_DATA(pComp_Aid,pAcc_Year,pPay_Month,pFrom_Date,pTo_Date,
  pUser_Aid,pSessionId,pReportId,NULL,'PAY_MONTH',NULL,vVarianceInsQuery );
  strSelect :=
  ' SELECT ''AC'' REPORT_HEADER,EMP_MID "EMPLOYEE CODE",EMP_NAME "EMPLOYEE NAME",COL_NAME "HEADS",PREV_DATA "'
  ||TO_CHAR(vPrvPay_Month,'MON YYYY')||'",CUR_DATA "'||pPay_Month||
  '",DECODE(PREV_DATA,CUR_DATA,NULL,''CHANGE'') VARIANCE,
NULL REPORT_HEADER1,NULL ,NULL,NULL,NULL,NULL,NULL
FROM( SELECT B.EMP_MID,B.EMP_NAME,A.COL_NAME,MAX(DECODE(A.PAY_MONTH,'''
  ||TO_CHAR(vPrvPay_Month,'MON YYYY')||
  ''',A.COL_VALUE,NULL)) PREV_DATA,MAX(DECODE(A.PAY_MONTH,'''||pPay_Month||
  ''',A.COL_VALUE,NULL)) CUR_DATA
FROM PY_PT_VARIANCE_TAB A, PY_GM_EMPMAST B
WHERE A.USER_AID ='''
  ||pUser_Aid||'''  AND A.SESSION_ID='''||pSessionId||''' AND REPORT_ID='''||
  pReportID||'''
AND A.COMP_AID ='''||pComp_Aid
  ||''' AND A.ACC_YEAR='''||pAcc_Year||
  '''
AND A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND COL_NAME IS NOT NULL
GROUP BY EMP_MID,EMP_NAME,COL_NAME,SRNO
ORDER BY EMP_MID,SRNO)'
  ;
  strSqlQueryFormat :=
  'SELECT ''X#X#X'' REPORT_HEADER, null,null ,null,null,null,null,
''RH'' REPORT_HEADER1,'''
  ||strGetCompName||
  ''', null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null, null, null,
''RH'' REPORT_HEADER,'''
  ||strGetRptName||
  ''', null,null,null,null,null FROM DUAL
UNION ALL
SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null,null ,null,
''DH'' REPORT_HEADER1,''EMPLOYEE CODE'', ''EMPLOYEE NAME'',''HEADS'','''
  ||TO_CHAR(vPrvPay_Month,'MON YYYY')||''', '''||pPay_Month||
  ''' ,''VARIANCE''
FROM DUAL UNION ALL ';
  strSqlQueryFormat :=strSqlQueryFormat||strSelect;
  OPEN Return_Recordset FOR strSqlQueryFormat ;
  /*Craete Log */
  PY_PK_STANDARD_REPORTS.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,
  pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
  pReportID,'SUCCESS');
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log */
  PY_PK_STANDARD_REPORTS.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,
  pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,
  pReportID,'FAILED :'||SQLERRM);
END;

PROCEDURE COMBINE_SALARY_REGISTER_RPT(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery LONG;
    strSqlQueryOuter LONG;
    strArrearSqlQuery LONG;
    strSubGrandTotalClause LONG;
    strGrandTotalClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strOrderByClause LONG;
    strWhereNullCond LONG;
    strAllowanceMonthly LONG;
    strOtherAllowance LONG;
    strDeduction LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strSqlQueryFormat LONG;
    strGetCompName LONG;
    strGetRptName LONG;
    strNullHead LONG;
    vCount NUMBER(10) DEFAULT 1;
    strDedNullHead LONG;
    strAllwNullHead LONG;
    strAllwanceHead LONG;
    strDeductionHead LONG;
    -- strNullHead         LONG;
  BEGIN

    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);

    vCount :=1;

    --MASTER COLUMNNS
    strSqlQuery          :='SELECT * FROM (SELECT ';

    IF pIsBatchWiseReport = 'Y' THEN
      strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
      strExGroupByClause :='A.BATCH_ID, ';
    END IF;

    strSelectClause :=' ''AC'' "REPORT_HEADER",A.PROCESS_MONTH "PAY MONTH",o.COMP_MID "COMPANY CODE", B.EMP_MID AS "CODE",
                      B.EMP_NAME AS "EMPLOYEE NAME" ,TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') AS "JOINING DATE",
                      TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') AS "QUIT DATE",NVL(E.DAYS_PRESENT,0) AS "PRESENT DAYS",
                      N.ARREAR_DAYS AS "ARREAR DAYS" ,B.CC_DESC "COST CENTER",B.EMP_MGMT_CATE_MID "MGMT/NONMGMT",
                      B.SUB_DEPT_DESC "SUB DEPARTMENT",B.BAND_DESC "SUB CODE", B.DEPT_DESC AS "DEPARTMENT",
                      B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
                      B.BANK_ACCOUNT_NO AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",B.PAN_NUMBER AS "PAN NUMBER",';

    Strgroupbyclause:='A.PROCESS_MONTH,o.COMP_MID,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,E.DAYS_PRESENT,
                       B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_DESC,
                       B.PAN_NUMBER,N.ARREAR_DAYS,B.CC_DESC,B.EMP_MGMT_CATE_MID,B.SUB_DEPT_DESC,B.BAND_DESC ,';

    strOrderByClause:= ' ORDER BY B.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)'||') ';--||GET_GROUP_BY_COLS(pMasterType,'N')|

    FOR I IN
    (
      Select Distinct 'ROUND(SUM(CASE WHEN A.ARR_FLAG !=''A'' THEN DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',
                       NVL(A.AMOUNT,0),0) END),2)
                       AS "'||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')||'",
                       ' FLD_NAME_EAR,'"'||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')||'",' FLD_NAME_EAR_DESC,
                        CASE
                        WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0 THEN
                            'ROUND(SUM(CASE WHEN A.ARR_FLAG =''A'' THEN DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',
                            NVL(A.AMOUNT,0),0) ELSE 0 END),2) AS "'
                            ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')||'_ARR'||'",'
                        ELSE NULL
                        END FLD_NAME_ARR,
                        CASE
                          WHEN SUM(DECODE(A.ARR_FLAG,'A',A.AMOUNT,0))<>0 THEN
                          '"'||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,26),'''','')||'_ARR'||'",'
                          ELSE NULL
                        END FLD_NAME_ARR_DESC,
                        'ROUND(SUM(DECODE(TRIM(F.CTC_MID),'''||TRIM(B.CTC_MID)||''',NVL(A.AMOUNT,0),0)),2) AS "'
                        ||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')||'",' FLD_NAME,
                        '"'||REPLACE(SUBSTR(TRIM(NVL(B.REG_DISP_NAME,B.CTC_NAME)),1,30),'''','')||'",' FLD_NAME_DESC,
                        B.DISP_ORDER,
                        B.CTC_TYPE,
                        C.PARA_DESC,
                        NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
                        B.CTC_MID
                  FROM
                    PY_VW_PT_SAL_DT A,
                    PY_CTC_ALLOWANCE_MAST B,
                    PY_GM_PARAMETERS C
                  WHERE
                    A.COMP_AID      = B.COMP_ID
                  AND A.ALLWDED_AID =B.CTC_CODE
                  AND B.CTC_CATE_ID = C.PAR_AID
                  AND A.ARR_FLAG   <>'F'
                  AND A.AMOUNT     <>0
                  AND A.ACC_YEAR    = pAcc_Year
                  AND
                    (
                      TO_DATE(01
                      ||A.PROCESS_MONTH)>=pFrom_Date
                    AND LAST_DAY(TO_DATE(01
                      ||A.PROCESS_MONTH))<=pTo_Date
                    )
                  GROUP BY
                    B.CTC_TYPE,
                    C.PARA_DESC,
                    B.DISP_ORDER,
                    B.CTC_NAME,
                    B.REG_DISP_NAME,
                    B.CTC_MID
                  ORDER BY
                    B.CTC_TYPE,
                    B.DISP_ORDER
    )
  LOOP
    IF TRIM(INSTR(strSelectClause,TRIM(I.FLD_NAME_EAR)))=0 THEN
      IF TRIM(I.CTC_TYPE)                               = 'A' THEN
        IF TRIM(I.CTC_MID)                              ='OVT' THEN

          strAllowanceMonthly   := strAllowanceMonthly ||
                                    'ROUND(SUM(DECODE(TRIM(F.CTC_MID),''OVT'',NVL(A.AMOUNT,0),0)),2) AS "OVER TIME",';
          strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
          I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
          ,' AS ')              +4);
          strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
          IF I.FLD_NAME_ARR IS NOT NULL THEN
            vCount          :=vCount+1;
            strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
          END IF;
        ELSE
          strAllowanceMonthly := strAllowanceMonthly ||I.FLD_NAME_EAR||
          I.FLD_NAME_ARR;
          strAllwanceHead:= strAllwanceHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
          I.FLD_NAME_EAR,' AS ')+4)||SUBSTR(I.FLD_NAME_ARR,instr(I.FLD_NAME_ARR
          ,' AS ')              +4);
          strNullHead       := strNullHead||',NULL "'||vCount||'_1"';
          IF I.FLD_NAME_ARR IS NOT NULL THEN
            vCount          :=vCount+1;
            strNullHead     := strNullHead||',NULL "'||vCount||'_1"';
          END IF;
          --strSqlQuery:=strSqlQuery||I.FLD_NAME_EAR_DESC||I.FLD_NAME_ARR_DESC;
        END IF;
      ELSIF TRIM(I.CTC_TYPE) = 'D' THEN
        strDeduction        := strDeduction||I.FLD_NAME;
        strDeductionHead    := strDeductionHead||SUBSTR(I.FLD_NAME_EAR,INSTR(
        I.FLD_NAME_EAR,' AS ')+4);
        strNullHead:= strNullHead||',NULL "'||vCount||'_1"';
        --strSqlQuery:=strSqlQuery||I.FLD_NAME_DESC;
      END IF;
      vCount :=vCount+1;
    END IF;
  END LOOP;

    Strsqlqueryformat :=
                       'SELECT ''X#X#X'' REPORT_HEADER, null,null,null ,null, null,null ,null,null,
                        null,null,null,null,null,null,null,null,null,null,null'||strNullHead||',null,null,null,
                        ''RH'' REPORT_HEADER1,'''||strGetCompName||''', null,null ,null, null,null,null,null ,
                        null,null,null,null,null, null,null,null,null,null,null'||strNullHead||',null,null,null FROM DUAL
                        UNION ALL
                        SELECT ''X#X#X'' REPORT_HEADER, null,null,null ,null, null,null,null ,null,
                        null,null,null,null,null,null,null,null,null,null,null' ||strNullHead||',null,null,null,
                        ''RH'' REPORT_HEADER,'''||strGetRptName||''', null,null ,null, null,null,null,null ,null,
                        null,null,null,null,null,null,null,null,null,null'||strNullHead||',null,null,null FROM DUAL
                        UNION ALL
                        SELECT ''X#X#X'' REPORT_HEADER,null,null, null,null ,null, null,null,null ,
                        null, null,null,null,null,null,null,null,null,null,null'||strNullHead||',null,null,null,
                       ''DH'' REPORT_HEADER1, ''PAY MONTH'',''COMPANY COE'',''CODE'', ''EMPLOYEE NAME'' ,''JOINING DATE'',
                        ''QUIT DATE'',''PRESENT DAYS'', ''ARREAR DAYS'' ,''COST CENTER'',''MGMT/NONMGMT'',''SUB DEPARTMENT'',
                        ''SUB CODE'',''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
                        ''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'',
                        '||Replace(Strallwancehead,'"','''')||'''GROSS EARNING'','||Replace(
                         strDeductionHead,'"','''')||
                        '''DEDUCTION'',''NET SALARY'' FROM DUAL UNION ALL  ';
                        --  Total Gross ,Deduction and Net Salary
                        strSelectClause:=strSelectClause||strAllowanceMonthly||
                        ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS EARNING",';
                        strSelectClause:=strSelectClause||strDeduction||
                        ' SUM(DECODE(F.CTC_TYPE,''D'',A.AMOUNT,0)) AS "DEDUCTION",';
                        strSelectClause:=strSelectClause||
                        ' SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,A.AMOUNT*-1)) AS "NET SALARY",';
  --strSqlQuery:=strSqlQuery||'"GROSS EARNING","DEDUCTION","NET SALARY"';
  Strselectclause :=Strselectclause||
                      ' null "REPORT_HEADER1", null "PAY MONTH1",null "COMPANY CODE1",null "CODE1",null "EMPLOYEE NAME1" ,
                        null "JOINING DATE1", null "QUIT DATE1",null "PRESENT DAYS1",null "ARREAR DAYS1" ,NULL "COST CENTER1",
                        NULL "MGMT/NONMGMT1",NULL "SUB DEPARTMENT1",NULL "SUB CODE1",null "DEPARTMENT1", null "DESIGNATION1",
                        null "GRADE1",null "LOCATION1",
                        null "SAVING ACCOUNT1",null "BANK NAME1",null "PAN NUMBER1"'
  ||strNullHead||
                      ',NULL "GROSS EARNING1",NULL "DEDUCTION1",NULL "NET SALARY1 " ';
                      --strSelectClause:=SUBSTR(TRIM(strSelectClause),1,LENGTH(TRIM(strSelectClause
                      -- ))-1);
                      strGroupByClause:=' GROUP BY '||strExGroupByClause||SUBSTR(TRIM(
                      strGroupByClause),1,LENGTH(TRIM(strGroupByClause))-1);--||','||
                      -- GET_GROUP_BY_COLS(pMasterType,'N');
  strFromClause:=
                      ' FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_CTC_ALLOWANCE_MAST F, PY_PT_PRESENT E,PY_GM_PARAMETERS M,
                    (--SELECT COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID,SUM(DAYS_ABSENT) DAYS_ABSENT FROM PY_PT_ABSENT WHERE COMP_AID='''
                      ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
                      '''  AND PAY_MONTH<>REC_MONTH AND PAY_MONTH='''||pPay_Month||
                      ''' GROUP BY COMP_AID,ACC_YEAR,PAY_MONTH,EMP_AID
                    SELECT A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID,SUM(DAYS) ARREAR_DAYS FROM PY_PT_ARR_DAYS_DT A
                    WHERE COMP_AID='''
                      ||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||
                      ''' AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||
                      ''' AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||
                      ''' AND PAY_MONTH<>ARR_MONTH
                    GROUP BY A.COMP_AID,A.ACC_YEAR, PAY_MONTH,A.EMP_AID) N , py_gm_comp o'
                      ;
  strWhereClause:=
                      ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID
                      AND A.ACC_YEAR=B.ACC_YEAR
                      AND A.PROCESS_MONTH=B.PROCESS_MONTH
                      AND B.PAY_MONTH IS NOT NULL
                      AND A.COMP_AID = E.COMP_AID (+)
                      AND A.ACC_YEAR=E.ACC_YEAR (+)
                      AND A.PROCESS_MONTH=E.PAY_MONTH (+)
                      AND A.EMP_AID = E.EMP_AID (+)
                      AND A.COMP_AID = N.COMP_AID (+)
                      AND A.ACC_YEAR=N.ACC_YEAR (+)
                      AND A.PROCESS_MONTH=N.PAY_MONTH (+)
                      AND A.EMP_AID = N.EMP_AID (+)
                      AND A.COMP_AID = F.COMP_ID (+)
                      AND A.ALLWDED_AID =F.CTC_CODE (+)
                      AND F.CTC_CATE_ID = M.PAR_AID
                      And A.Comp_Aid = O.Comp_Id ';

                      IF TRIM(pIsMultipleSheet) ='Y' THEN
                        strWhereClause         :=strWhereClause||' AND '||REPLACE(GET_CONDITION(
                        pMasterType , pMultiSheetCondition),'HD.','B.');
                      END IF;

                    strWhereClause:=strWhereClause||
                                  ' AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||
                                  pFrom_Date||'''))';
                                  --                strWhereClause:=strWhereClause||' AND A.COMP_AID = '||''''|
                                  -- |pComp_Aid||''''||' AND A.ACC_YEAR = '||''''||pAcc_Year||''''||' AND
                                  -- A.PAY_MONTH='||''''||pPay_Month||'''';
                                  strWhereClause:=strWhereClause||'  AND B.ACC_YEAR = '||''''||pAcc_Year||''''||'';
                                  strWhereClause:=strWhereClause||' AND TO_DATE(01||A.PROCESS_MONTH)>='''||
                                  pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||
                                  '''';
                                  strWhereClause      :=strWhereClause||' AND A.PAY_MONTH IS NOT NULL';

                  IF pIsBatchWiseReport='Y' THEN
                                  strWhereClause    :=strWhereClause||chr(13)||
                                  ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
                                  ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
                  END IF;

  /*to generate the report for the Employees as per the Filter ID*/
                  IF pFilterId IS NOT NULL THEN
                                INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
                                pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,
                                pFilterId);
    --                   strWhereClause:=strWhereClause||chr(13)||' AND
    -- A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||
    -- pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(
    -- CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID
    -- END)||''' AND COMP_AID='''||pComp_Aid||''')';
                               strWhereClause:=strWhereClause||chr(13)||
                              ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
                              ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
                              pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
                  END IF;


  strSqlQuery:=strSqlQueryFormat||strSqlQuery||CHR(13)||strExSelectClause||
  strSelectClause||CHR(13)||strFromClause||CHR(13)||strWhereClause||' '||CHR(13
  )||strGroupByClause||CHR(13)||strOrderByClause;



  --Finally Return the recordset here
  OPEN Return_Recordset FOR strSqlQuery ;
  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  )
  ;
EXCEPTION
WHEN OTHERS THEN
  /*Craete Log*/
  INSERT_REPORT_UPLOAD_LOG
  (
    pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
  )
  ;
End ;
-----------------------------------------------------
PROCEDURE BANK_FUNDING_RPT(
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
IS
  TYPE Cur_Recordset IS REF CURSOR;
  Cur_Temp Cur_Recordset;
  strGetCompName            VARCHAR2(4000);
  strGetRptName             VARCHAR2(4000);
  vPrev_Pay_Month           LONG;
  strSqlQuery               LONG;
  strExSelectClause         LONG;
  strExGroupByClause        LONG;
  strSelectClause           LONG;
  strFromClause             LONG;
  strWhereClause            LONG;
  strGroupByClause          LONG;
  strMainQuery              LONG;
  strBatchQuery             LONG;
  strHeadQuery              LONG;
  strSelectClauseBatch      LONG;
  vFlag                     VARCHAR2(1);
  strReportHeader           VARCHAR2(4000);
  strHeaderGroupByClause    LONG;
  strOrderByClause          LONG;
BEGIN

    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);

    IF pReportType ='Excel' THEN

        strSqlQuery :='SELECT ''X#X#X'' REPORT_HEADER1,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,
                      ''RH'' REPORT_HEADER,'''||strGetCompName||''' comp_name,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null
                      FROM DUAL
                      UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER1,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,
                      ''RH'' REPORT_HEADER,'''||strGetRptName||''',null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null
                      FROM DUAL
                      UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER1,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,null,null,
                      null,
                      ''DH'' REPORT_HEADER,''COMPANY NAME'',''CODE'',
                      ''EMPLOYEE NAME'' ,''JOINING DATE'', ''QUIT DATE'',
                      ''PRESENT DAYS'',''DESIGNATION'',''LOCATION'',
                      ''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'',
                      ''BASIC SALARY'',''GROSS EARNING'',''PF BASE AMOUNT'',
                      ''PF EMPLOYER_CONTRI'',''EMPLOYER LWF'',''TOTAL'',
                      ''SERVICE_TAX'',''EDU_CESS'',''SEC CESS'',
                      ''GRAND TOTAL''
                      FROM DUAL
                      UNION ALL ';

        strSelectClause :='SELECT  REPORT_HEADER,"COMPANY NAME","CODE",
                            "EMPLOYEE NAME","JOINING DATE","QUIT DATE",
                            "PRESENT DAYS","DESIGNATION","LOCATION",
                            "SAVING ACCOUNT","BANK NAME","PAN NUMBER",
                            ROUND("BASIC SALARY",2) "BASIC SALARY",ROUND("GROSS EARNING",2),ROUND("PF BASE AMOUNT",2),
                            ROUND("PF EMPLOYER CONTRI",2),ROUND("EMPLOYER LWF ",2),ROUND("TOTAL",2),
                            ROUND("SERVICE TAX",2),ROUND("EDU CESS",2),ROUND("SEC CESS",2),
                            ROUND("GRAND TOTAL",2),
                            null,null,null,
                            null,null,null,
                            null,null,null,
                            null,null,null,
                            null,null,null,
                            null,null,null,
                            null,null,null,
                            null
                          FROM (
                            WITH A AS
                            (
                            SELECT  A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,
                              A.ACC_YEAR, B.EMP_MID ,B.EMP_NAME  ,
                              TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') JOIN_DATE,TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') LEAVE_DATE,B.PAID_DAYS,
                              B.DESG_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,
                              B.BANK_DESC,B.PAN_NUMBER,ROUND(SUM(CASE WHEN A.ARR_FLAG !=''A'' THEN DECODE(TRIM(F.CTC_MID),''BAS'',NVL(A.AMOUNT,0),0) END),2) AS "BASIC_SALARY",
                              SUM(DECODE(TRIM(F.CTC_MID),''LWF'',NVL(A.AMOUNT,0),0))LWF,SUM(DECODE(F.CTC_TYPE,''A'',A.AMOUNT,0)) AS "GROSS_EARNING"
                            FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_CTC_ALLOWANCE_MAST F
                            WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PROCESS_MONTH=B.PROCESS_MONTH AND B.PAY_MONTH IS NOT NULL
                              AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+) AND A.ARR_FLAG<>''F''
                              AND A.ARR_FLAG<>''F'' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= '''||pFrom_Date||'''))
                              AND A.COMP_AID = '''||pComp_Aid||''' AND B.ACC_YEAR = '''||pAcc_Year||'''
                              AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||'''
                              AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||''' AND A.PAY_MONTH IS NOT NULL
                            GROUP BY A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,A.ACC_YEAR,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,
                              B.LEAVE_DATE,B.PAID_DAYS,B.DESG_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER
                            ),';

        strSelectClause := strSelectClause||
                            ' B AS
                            (
                            SELECT A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,
                              A.ACC_YEAR,SUM(DECODE(TRIM(A.ALLWDED_AID),''PF_BASIS'',NVL(A.AMOUNT,0),0)) AS "PF_BASIS",
                              ROUND(SUM(DECODE(TRIM(F.CTC_MID),''SPF'',NVL(A.AMOUNT,0),0))+SUM(DECODE(TRIM(F.CTC_MID),''INF'',NVL(A.AMOUNT,0),0))+
                              SUM(DECODE(TRIM(F.CTC_MID),''INA'',NVL(A.AMOUNT,0),0))+SUM(DECODE(TRIM(F.CTC_MID),''PFA'',NVL(A.AMOUNT,0),0)),0) AS "SPE"
                            FROM PY_PT_EMPPF A,PY_CTC_ALLOWANCE_MAST F
                            WHERE A.COMP_AID = '''||pComp_Aid||''' AND A.ACC_YEAR = '''||pAcc_Year||'''
                              AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||'''
                              AND A.PAY_MONTH IS NOT NULL AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)
                            GROUP BY A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,A.ACC_YEAR
                            )';

        strSelectClause := strSelectClause||
                             'SELECT ''AC'' REPORT_HEADER,COMP_NAME "COMPANY NAME",EMP_MID AS "CODE",EMP_NAME AS "EMPLOYEE NAME" ,JOIN_DATE AS "JOINING DATE",
                              LEAVE_DATE  AS "QUIT DATE",PAID_DAYS AS "PRESENT DAYS",
                              DESG_DESC "DESIGNATION",LOC_DESC "LOCATION",BANK_ACCOUNT_NO "SAVING ACCOUNT",
                              BANK_DESC "BANK NAME",PAN_NUMBER "PAN NUMBER",
                              BASIC_SALARY "BASIC SALARY",GROSS_EARNING "GROSS EARNING",PF_BASIS "PF BASE AMOUNT",
                              SPE "PF EMPLOYER CONTRI",LWF "EMPLOYER LWF ",TOTAL,
                              SERVICE_TAX "SERVICE TAX",ROUND(SERVICE_TAX*0.02,2) "EDU CESS",ROUND(SERVICE_TAX*0.01,2) "SEC CESS",
                              TOTAL +SERVICE_TAX +ROUND(SERVICE_TAX*0.02,2)+ROUND(SERVICE_TAX*0.01,2) "GRAND TOTAL"
                              FROM
                              (
                              SELECT C.COMP_NAME,A.EMP_MID,A.EMP_NAME,A.JOIN_DATE,
                              A.LEAVE_DATE,A.PAID_DAYS,A.DESG_DESC,
                              A.LOC_DESC,A.BANK_ACCOUNT_NO,A.BANK_DESC,
                              A.PAN_NUMBER,BASIC_SALARY,GROSS_EARNING,
                              NVL(PF_BASIS,0) PF_BASIS,NVL(SPE,0) SPE,NVL(LWF,0) LWF,
                              NVL(GROSS_EARNING,0)+NVL(SPE,0)+NVL(LWF,0) TOTAL,ROUND((NVL(GROSS_EARNING,0)+NVL(SPE,0)+NVL(LWF,0))*0.12,2) SERVICE_TAX
                              FROM A,B,PY_GM_COMP C
                              WHERE A.COMP_AID = B.COMP_AID(+) AND A.EMP_AID = B.EMP_AID(+)
                              AND A.ACC_YEAR=B.ACC_YEAR(+) AND A.PROCESS_MONTH=B.PROCESS_MONTH(+)
                              AND A.COMP_AID=C.COMP_ID
                              ORDER BY A.EMP_MID,TO_DATE(01||A.PROCESS_MONTH))';

        strSelectClause := strSelectClause||
                              'UNION ALL
                              SELECT ''DH'' REPORT_HEADER,NULL "COMPANY NAME",TO_CHAR(COUNT(EMP_MID)) AS "CODE",NULL AS "EMPLOYEE NAME" ,NULL AS "JOINING DATE",
                              NULL  AS "QUIT DATE",NULL AS "PRESENT DAYS",
                              NULL "DESIGNATION",NULL "LOCATION",NULL "SAVING ACCOUNT",
                              NULL "BANK NAME",NULL "PAN NUMBER",
                              SUM(BASIC_SALARY) "BASIC SALARY",SUM(GROSS_EARNING) "GROSS EARNING",SUM(PF_BASIS) "PF BASE AMOUNT",
                              SUM(SPE) "PF EMPLOYER CONTRI",SUM(LWF) "EMPLOYER LWF ",SUM(TOTAL) TOTAL,
                              SUM(SERVICE_TAX) "SERVICE TAX",SUM(ROUND(SERVICE_TAX*0.02,2)) "EDU CESS",SUM(ROUND(SERVICE_TAX*0.01,2)) "SEC CESS",
                              SUM(TOTAL +SERVICE_TAX +ROUND(SERVICE_TAX*0.02,2)+ROUND(SERVICE_TAX*0.01,2)) "GRAND TOTAL"
                              FROM
                              (
                              SELECT C.COMP_NAME,A.EMP_MID,A.EMP_NAME,A.JOIN_DATE,
                              A.LEAVE_DATE,A.PAID_DAYS,A.DESG_DESC,
                              A.LOC_DESC,A.BANK_ACCOUNT_NO,A.BANK_DESC,
                              A.PAN_NUMBER,BASIC_SALARY,GROSS_EARNING,
                              NVL(PF_BASIS,0) PF_BASIS,NVL(SPE,0) SPE,NVL(LWF,0) LWF,
                              NVL(GROSS_EARNING,0)+NVL(SPE,0)+NVL(LWF,0) TOTAL,ROUND((NVL(GROSS_EARNING,0)+NVL(SPE,0)+NVL(LWF,0))*0.12,2) SERVICE_TAX
                              FROM A,B,PY_GM_COMP C
                              WHERE A.COMP_AID = B.COMP_AID(+) AND A.EMP_AID = B.EMP_AID(+)
                              AND A.ACC_YEAR=B.ACC_YEAR(+) AND A.PROCESS_MONTH=B.PROCESS_MONTH(+)
                              AND A.COMP_AID=C.COMP_ID ))';


       -- strOrderByClause:= ' ORDER BY A.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)'||')) ';

--    strSqlQuery:=strSqlQuery||CHR(13)||strSelectClause||CHR(13)||strOrderByClause;
      strSqlQuery:=strSqlQuery||CHR(13)||strSelectClause;


    OPEN Return_Recordset FOR strSqlQuery ;

  ELSE

    OPEN Return_Recordset FOR
    SELECT "EMPLOYEE NAME","JOINING DATE","QUIT DATE","PRESENT DAYS","DESIGNATION","LOCATION",
              "SAVING ACCOUNT","BANK NAME","PAN NUMBER",ROUND("BASIC SALARY",2) "BASIC SALARY",
              ROUND("GROSS EARNING",2) "GROSS EARNING",ROUND("PF BASE AMOUNT",2) "PF BASE AMOUNT",
              ROUND("PF EMPLOYER CONTRI",2) "PF EMPLOYER CONTRI",ROUND("EMPLOYER LWF ",2) "EMPLOYER LWF",
              ROUND("TOTAL",2) "TOTAL",ROUND("SERVICE TAX",2) "SERVICE TAX",ROUND("EDU CESS",2) "EDU CESS",
              ROUND("SEC CESS",2) "SEC CESS",ROUND("GRAND TOTAL",2) "GRAND TOTAL"
      FROM (
        WITH A
        AS
        (
          SELECT  A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,A.ACC_YEAR, B.EMP_MID ,B.EMP_NAME  ,
                  TO_CHAR(B.JOIN_DATE,'DD-MON-YYYY') JOIN_DATE,
                  TO_CHAR(B.LEAVE_DATE,'DD-MON-YYYY') LEAVE_DATE,
                  B.PAID_DAYS,B.DESG_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER,
                  ROUND(SUM(CASE WHEN A.ARR_FLAG !='A' THEN DECODE(TRIM(F.CTC_MID),'BAS',NVL(A.AMOUNT,0),0) END),2) AS "BASIC_SALARY",
                  SUM(DECODE(TRIM(F.CTC_MID),'LWF',NVL(A.AMOUNT,0),0))LWF,
                  SUM(DECODE(F.CTC_TYPE,'A',A.AMOUNT,0)) AS "GROSS_EARNING"
          FROM PY_VW_PT_SAL_DT A,PY_PT_SAL_HD B,PY_CTC_ALLOWANCE_MAST F
          WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PROCESS_MONTH=B.PROCESS_MONTH AND B.PAY_MONTH IS NOT NULL
            AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+) AND A.ARR_FLAG<>'F'
            AND A.ARR_FLAG<>'F' AND (B.LEAVE_DATE IS NULL OR (B.LEAVE_DATE >= pFrom_Date))
            AND A.COMP_AID = pComp_Aid AND B.ACC_YEAR = pAcc_Year
            AND TO_DATE(01||A.PROCESS_MONTH)>=pFrom_Date
            AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<=pTo_Date AND A.PAY_MONTH IS NOT NULL
          GROUP BY A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,A.ACC_YEAR,B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,
                   B.LEAVE_DATE,B.PAID_DAYS,B.DESG_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER
        ), B AS
        (
          SELECT A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,A.ACC_YEAR,SUM(DECODE(TRIM(A.ALLWDED_AID),'PF_BASIS',NVL(A.AMOUNT,0),0)) AS "PF_BASIS",
                   ROUND(SUM(DECODE(TRIM(F.CTC_MID),'SPF',NVL(A.AMOUNT,0),0))+SUM(DECODE(TRIM(F.CTC_MID),'INF',NVL(A.AMOUNT,0),0))+
                   SUM(DECODE(TRIM(F.CTC_MID),'INA',NVL(A.AMOUNT,0),0))+SUM(DECODE(TRIM(F.CTC_MID),'PFA',NVL(A.AMOUNT,0),0)),0) AS "SPE"
          FROM PY_PT_EMPPF A,PY_CTC_ALLOWANCE_MAST F
          WHERE A.COMP_AID = pComp_Aid AND A.ACC_YEAR = pAcc_Year
            AND TO_DATE(01||A.PROCESS_MONTH)>=pFrom_Date AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<=pTo_Date
            AND A.PAY_MONTH IS NOT NULL AND A.COMP_AID = F.COMP_ID (+) AND A.ALLWDED_AID =F.CTC_CODE (+)
          GROUP BY A.COMP_AID,A.EMP_AID,A.PROCESS_MONTH,A.ACC_YEAR
        )SELECT EMP_MID AS "CODE",EMP_NAME AS "EMPLOYEE NAME" ,
              JOIN_DATE AS "JOINING DATE",LEAVE_DATE  AS "QUIT DATE",PAID_DAYS AS "PRESENT DAYS",
              DESG_DESC "DESIGNATION",LOC_DESC "LOCATION",BANK_ACCOUNT_NO "SAVING ACCOUNT",
              BANK_DESC "BANK NAME",PAN_NUMBER "PAN NUMBER",
              BASIC_SALARY "BASIC SALARY",GROSS_EARNING "GROSS EARNING",PF_BASIS "PF BASE AMOUNT",
              SPE "PF EMPLOYER CONTRI",LWF "EMPLOYER LWF ",TOTAL,
              SERVICE_TAX "SERVICE TAX",
              ROUND(SERVICE_TAX*0.02,2) "EDU CESS",
              ROUND(SERVICE_TAX*0.01,2) "SEC CESS",
              TOTAL +SERVICE_TAX +ROUND(SERVICE_TAX*0.02,2)+ROUND(SERVICE_TAX*0.01,2) "GRAND TOTAL"
        FROM
        (
        SELECT A.EMP_MID,A.EMP_NAME,A.JOIN_DATE,A.LEAVE_DATE,A.PAID_DAYS,
        A.DESG_DESC,A.LOC_DESC,A.BANK_ACCOUNT_NO,A.BANK_DESC,A.PAN_NUMBER,
        BASIC_SALARY,GROSS_EARNING,NVL(PF_BASIS,0) PF_BASIS,NVL(SPE,0) SPE,NVL(LWF,0) LWF,
        GROSS_EARNING+SPE+LWF TOTAL,
        ROUND((NVL(GROSS_EARNING,0)+NVL(SPE,0)+NVL(LWF,0))*0.12,2) SERVICE_TAX
      FROM A,B
      WHERE A.COMP_AID = B.COMP_AID(+) AND A.EMP_AID = B.EMP_AID(+) AND A.ACC_YEAR=B.ACC_YEAR(+) AND A.PROCESS_MONTH=B.PROCESS_MONTH(+)
   ORDER BY A.EMP_MID,TO_DATE(01||A.PROCESS_MONTH)));

 END IF;

  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');

  EXCEPTION
    WHEN OTHERS THEN
      /*Craete Log*/
      INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
      pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
      SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END ;

PROCEDURE BANK_UPD_RPT(
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
IS
TYPE Cur_Recordset
IS
  REF
  CURSOR;
    Cur_Temp Cur_Recordset;
    strGetCompName VARCHAR2(4000);
    strGetRptName  VARCHAR2(4000);
    vPrev_Pay_Month LONG;
    strSqlQuery LONG;
    strExSelectClause LONG;
    strExGroupByClause LONG;
    strSelectClause LONG;
    strFromClause LONG;
    strWhereClause LONG;
    strGroupByClause LONG;
    strMainQuery LONG;
    strBatchQuery LONG;
    strHeadQuery LONG;
    strSelectClauseBatch LONG;
    vFlag           VARCHAR2(1);
    strReportHeader VARCHAR2(4000);
    strHeaderGroupByClause LONG;
  BEGIN
    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
    pTo_Date,strGetCompName,strGetRptName);

  IF pReportType             ='Excel' THEN

    IF pIsBatchWiseReport = 'Y' THEN
      strBatchQuery      :='NULL,';
      strHeadQuery       :='"BATCH ID",';
    END IF;

    vPrev_Pay_Month:=TO_CHAR(to_date(01||pPay_Month)-1,'MON YYYY');

    IF pMultiSheetCondition != 'SUMMARY' THEN
      --

    strSqlQuery:='SELECT ''X#X#X'' REPORT_SECTION, NULL, NULL ,NULL ,NULL , NULL, NULL,
                         ''RH'' REPORT_SECTION,'''--||REPLACE(strBatchQuery,',',' ')||strHeadQuery||''''
                          || strGetCompName ||''' comp_name,NULL ,NULL ,NULL , NULL,NULL  FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' REPORT_SECTION, NULL, NULL ,NULL ,NULL , NULL, NULL,
                         ''RH'' REPORT_SECTION,'''--||REPLACE(strBatchQuery,',',' ')||strHeadQuery||''''
                        || strGetRptName ||''' comp_name,NULL ,NULL ,NULL , NULL,NULL  FROM DUAL
                  UNION ALL
                  SELECT NULL, NULL, NULL ,NULL ,NULL , NULL, NULL,
                         NULL REPORT_SECTION,NULL comp_name,NULL ,NULL ,NULL , NULL,NULL  FROM DUAL
                  UNION ALL
                  SELECT DISTINCT ''X#X#X'' REPORT_SECTION, NULL, NULL ,NULL ,NULL , NULL, NULL,
                                  ''DH'' REPORT_SECTION ,''EMPLOYEE_CODE'' "EMPLOYEE_CODE",
                                    ''EMPLOYEE_NAME'' "EMPLOYEE_NAME",''BANK_NAME'' BANK_NAME,
                                    ''ACCOUNT_NO'' "ACCOUNT_NO",''IFSC_CODE'' "IFSC_CODE",''NET_SALARY'' "NET_SALARY" FROM DUAL
                  UNION ALL';

    strSqlQuery:=strSqlQuery||' SELECT REPORT_SECTION,EMPLOYEE_CODE,EMPLOYEE_NAME,
                          BANK_NAME,ACCOUNT_NO,IFSC_CODE,NET_SALARY,
                          NULL , NULL, NULL ,NULL ,NULL , NULL, NULL FROM (SELECT * FROM ( SELECT REPORT_SECTION,EMPLOYEE_CODE,EMPLOYEE_NAME,
                          BANK_NAME,ACCOUNT_NO,IFSC_CODE,NET_SALARY
                    FROM ( ';

--                    SELECT DISTINCT ''AC'' REPORT_SECTION ,NULL "EMPLOYEE_CODE",
--                                    NULL "EMPLOYEE_NAME",NULL BANK_NAME,
--                                    NULL "ACCOUNT_NO",NULL "IFSC_CODE",NULL "NET_SALARY"
--                                    ,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,''PAYORDER'',A.BANK_DESC)||''_0'' "BANK_DESC"

    strFromClause :=' FROM PY_PT_SAL_HD A, (SELECT * FROM PY_GM_EMP_ATTRIBUTE_MAST WHERE ATTB_MID=''IFSC'')  B';

    strWhereClause:=' WHERE A.EMP_AID=B.EMP_AID(+)
                        AND A.COMP_AID='''||pComp_Aid||''' AND A.ACC_YEAR='''||pAcc_Year||'''
                        AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||'''
                        AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date ||'''
                        AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0';

      IF pIsBatchWiseReport='Y' THEN
        strWhereClause    :=strWhereClause||chr(13)||' AND A.BATCH_ID IN (SELECT BT.BATCH_ID
                            FROM PY_GTMP_BATCH_ID BT
                            WHERE USER_AID='''||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
      END IF;

      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
        pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
        pIsMultipleSheet,pFilterId);

        strWhereClause:=strWhereClause||chr(13)||
                        ' AND A.EMP_AID IN (SELECT EMP_AID
                        FROM PY_GTMP_EMP_LIST
                        WHERE USER_AID='''||pUSER_AID||''' AND SESSION_ID='''||pSessionId||'''
                        AND REPORT_AID='''||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;

      IF TRIM(pIsMultipleSheet) ='Y' THEN
        strWhereClause :=strWhereClause||' AND '||REPLACE(GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','A.');
      END IF;

--      strSqlQuery:=strSqlQuery||strFromClause||strWhereClause;

--      strSqlQuery:=strSqlQuery||' UNION ALL ';

--    strSqlQuery  :=strSqlQuery||strFromClause||strFromClause;

    strSelectClause:=' SELECT REPORT_SECTION , EMPLOYEE_CODE,EMPLOYEE_NAME, BANK_NAME,
                              ACCOUNT_NO,IFSC_CODE, NET_SALARY NET_SALARY,BANK_DESC
                       FROM (
                       SELECT ''AC'' REPORT_SECTION ,A.EMP_MID "EMPLOYEE_CODE",A.EMP_NAME "EMPLOYEE_NAME",
                              DECODE(trim(A.BANK_ACCOUNT_NO),NULL,''PAYORDER'',A.BANK_DESC) "BANK_NAME",
                              A.BANK_ACCOUNT_NO "ACCOUNT_NO",B.ATTB_VALUE "IFSC_CODE",A.TNET_AMT "NET_SALARY",
                              DECODE(trim(A.BANK_ACCOUNT_NO),NULL,''PAYORDER'',A.BANK_DESC)||''_2'' "BANK_DESC"';

    strSelectClause:=strSelectClause||strFromClause||strWhereClause;

    strSelectClause:=strSelectClause||')
                         ) ORDER BY EMPLOYEE_CODE) UNION ALL
                     SELECT distinct ''DH'' REPORT_SECTION ,to_char(COUNT(EMP_MID)) "EMPLOYEE_CODE", null "EMPLOYEE_NAME"
            ,null BANK_NAME,null "ACCOUNT_NO",NULL "IFSC_CODE",SUM(TNET_AMT) "NET_SALARY"
           FROM
      (
          SELECT ''AC'' REPORT_SECTION ,A.EMP_MID ,A.EMP_NAME "EMPLOYEE_NAME"
                ,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,''PAYORDER'',A.BANK_DESC) "BANK_NAME"
                ,A.BANK_ACCOUNT_NO "ACCOUNT_NO.",B.ATTB_VALUE "IFSC CODE",A.TNET_AMT
                ,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,''PAYORDER'',A.BANK_DESC) BANK_NAME1';

    strSelectClause:=strSelectClause||strFromClause||strWhereClause;

      strGroupByClause:=' ORDER BY A.EMP_MID)) ';

      strMainQuery:= strSqlQuery--||strFromClause||strWhereClause
                    ||strSelectClause
--      ||strFromClause||strWhereClause
      ||strGroupByClause;--||strGroupByClause;

    ELSE

    strSqlQuery:='SELECT ''X#X#X'' REPORT_SECTION,'||REPLACE(strBatchQuery,',',' ')
                          ||strHeadQuery||''''|| strGetCompName ||''' CN ,NULL A,NULL B,
                          ''RH'' REPORT_SECTION1,'||REPLACE(strBatchQuery,',',' ')
                          ||strHeadQuery||''''|| strGetCompName ||''' CN1,NULL A1,NULL B1
                  FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' REPORT_SECTION,'||strBatchQuery||''''
                          || strGetRptName ||''' ,NULL,NULL,
                          ''RH'' REPORT_SECTION1,'||strBatchQuery||''''
                          || strGetRptName ||''' ,NULL,NULL
                  FROM DUAL
                  UNION ALL
                  SELECT ''X#X#X'' ,NULL,NULL,NULL,''DH'' ,''BANK NAME'',
                          ''HEAD COUNT'',''NET SALARY''
                  FROM DUAL
                  UNION ALL
                  SELECT * FROM (
                  SELECT REPORT_SECTION,'||strHeadQuery||'"BANK NAME","HEAD COUNT","NET SALARY"
                        ,REPORT_SECTION1,'||strHeadQuery||'"BANK NAME1","HEAD COUNT1","NET SALARY1"
                  FROM (
                  SELECT  ''AC'' REPORT_SECTION ,';

      IF pIsBatchWiseReport  = 'Y' THEN
        strSelectClauseBatch:= 'A.BATCH_ID AS "BATCH ID", ';
        strGroupByClause    :=strGroupByClause ||'A.BATCH_ID, ';
      END IF;

      strSelectClause :=REPLACE(strBatchQuery,',',' ') ||strHeadQuery||
                        ' DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC) "BANK NAME"
                        ,COUNT(A.EMP_MID) "HEAD COUNT",SUM(A.TNET_AMT) "NET SALARY",
                        NULL REPORT_SECTION1,'||REPLACE(strBatchQuery,',',' ')
                        ||strHeadQuery||' NULL "BANK NAME1",NULL "HEAD COUNT1",NULL "NET SALARY1"';

      strFromClause :=' FROM PY_PT_SAL_HD A';
      strWhereClause:=' WHERE COMP_AID='''||pComp_Aid||''' AND ACC_YEAR='''||pAcc_Year||'''
                          AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||'''
                          AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date ||'''
                          AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0';

      IF pIsBatchWiseReport='Y' THEN
        strWhereClause    :=strWhereClause||chr(13)||
        ' AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' )';
      END IF;

      IF pFilterId IS NOT NULL THEN
        INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,
        pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,
        pIsMultipleSheet,pFilterId);

        strWhereClause:=strWhereClause||chr(13)||
        ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
        ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''
        ||pReportID||''' AND COMP_AID='''||pComp_Aid||''')';
      END IF;

      strGroupByClause:=' GROUP BY BANK_AID,DECODE(trim(A.BANK_DESC),NULL,''PAYORDER'',A.BANK_DESC)
                          ORDER BY 1
                          )UNION ALL
                          SELECT ''X#X#X'' "REPORT_HEADER",''TOTAL'',
                                  COUNT(EMP_MID) "HEAD COUNT",SUM(TNET_AMT) "NET SALARY",
                                  ''DH'' "REPORT_HEADER1",''TOTAL'' "TOTAL1",
                                  TO_CHAR(COUNT(EMP_MID)) "HEAD COUNT1",TO_CHAR(SUM(TNET_AMT)) "NET SALARY1" ';

      strMainQuery:= strSqlQuery||strSelectClause||strFromClause||
                     strWhereClause||strGroupByClause||strFromClause||
                     strWhereClause||')';

    END IF;

    OPEN Return_Recordset FOR strMainQuery ;
  ELSE

    OPEN Return_Recordset FOR
    SELECT * FROM ( SELECT EMPLOYEE_CODE,EMPLOYEE_NAME,
                          BANK_NAME,ACCOUNT_NO,IFSC_CODE,NET_SALARY
                    FROM ( SELECT NULL "EMPLOYEE_CODE",
                                    NULL "EMPLOYEE_NAME",NULL BANK_NAME,
                                    NULL "ACCOUNT_NO",NULL "IFSC_CODE",NULL "NET_SALARY"
                                    ,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,'PAYORDER',A.BANK_DESC)||'_0' "BANK_DESC"
                                    FROM PY_PT_SAL_HD A, (SELECT * FROM PY_GM_EMP_ATTRIBUTE_MAST WHERE ATTB_MID='IFSC')  B
                                    WHERE A.EMP_AID=B.EMP_AID(+)
                        AND A.COMP_AID=pComp_Aid AND A.ACC_YEAR=pAcc_Year
                        AND TO_DATE(01||A.PROCESS_MONTH)>=pFrom_Date
                        AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<=pTo_Date
                        AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0 AND NVL(A.BANK_AID,'OTHERS') = DECODE('ALL','ALL',NVL(A.BANK_AID,'OTHERS'),'ALL' )
                        UNION ALL
                       SELECT  EMPLOYEE_CODE,EMPLOYEE_NAME, BANK_NAME,
                              ACCOUNT_NO,IFSC_CODE, TO_CHAR(NET_SALARY) NET_SALARY,BANK_DESC
                       FROM (
                       SELECT A.EMP_MID "EMPLOYEE_CODE",A.EMP_NAME "EMPLOYEE_NAME",
                              DECODE(trim(A.BANK_ACCOUNT_NO),NULL,'PAYORDER',A.BANK_DESC) "BANK_NAME",
                              A.BANK_ACCOUNT_NO "ACCOUNT_NO",B.ATTB_VALUE "IFSC_CODE",A.TNET_AMT "NET_SALARY",
                              DECODE(trim(A.BANK_ACCOUNT_NO),NULL,'PAYORDER',A.BANK_DESC)||'_2' "BANK_DESC"
                              FROM PY_PT_SAL_HD A, (SELECT * FROM PY_GM_EMP_ATTRIBUTE_MAST WHERE ATTB_MID='IFSC')  B
                              WHERE A.EMP_AID=B.EMP_AID(+)
                        AND A.COMP_AID=pComp_Aid AND A.ACC_YEAR=pAcc_Year
                        AND TO_DATE(01||A.PROCESS_MONTH)>=pFrom_Date
                        AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<=pTo_Date
                        AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0 AND NVL(A.BANK_AID,'OTHERS') = DECODE('ALL','ALL',NVL(A.BANK_AID,'OTHERS'),'ALL' )
                        UNION ALL
                     SELECT to_char(COUNT(EMP_MID)) "EMPLOYEE_CODE", null "EMPLOYEE_NAME"
            ,null BANK_NAME,null "ACCOUNT_NO",NULL "IFSC_CODE",SUM(TNET_AMT) "NET_SALARY"
            ,BANK_NAME||'_3' "BANK_DESC"
      FROM
      (
          SELECT A.EMP_MID ,A.EMP_NAME "EMPLOYEE_NAME"
                ,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,'PAYORDER',A.BANK_DESC) "BANK_NAME"
                ,A.BANK_ACCOUNT_NO "ACCOUNT_NO.",B.ATTB_VALUE "IFSC CODE",A.TNET_AMT
                ,DECODE(trim(A.BANK_ACCOUNT_NO),NULL,'PAYORDER',A.BANK_DESC) BANK_NAME1 FROM PY_PT_SAL_HD A, (SELECT * FROM PY_GM_EMP_ATTRIBUTE_MAST WHERE ATTB_MID='IFSC')  B WHERE A.EMP_AID=B.EMP_AID(+)
                        AND A.COMP_AID=pComp_Aid AND A.ACC_YEAR=pAcc_Year
                        AND TO_DATE(01||A.PROCESS_MONTH)>=pFrom_Date
                        AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<=pTo_Date
                        AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0 AND NVL(A.BANK_AID,'OTHERS') = DECODE('ALL','ALL',NVL(A.BANK_AID,'OTHERS'),'ALL' )) GROUP BY BANK_NAME1
                         )
                         ) ORDER BY BANK_DESC);

  END IF;


    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log*/
    INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
    pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
    SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
  END ;

------------------------------------------
PROCEDURE ICICI_BANK_UPD_RPT(
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
IS
  TYPE Cur_Recordset IS REF CURSOR;
  Cur_Temp Cur_Recordset;
  strGetCompName            VARCHAR2(4000);
  strGetRptName             VARCHAR2(4000);
  strSqlQuery               LONG;
  strSelectClause           LONG;
  strFromClause             LONG;
  strWhereClause            LONG;
  strGroupByClause          LONG;
  strMainQuery              LONG;
  strBatchQuery             LONG;
  strHeadQuery              LONG;
  strSelectClauseBatch      LONG;
  strOrderByClause          LONG;
BEGIN

  GET_REPORT_DTL(pComp_Aid , pAcc_Year , pReportID
                , pPay_Month , pFrom_Date , pTo_Date
                , strGetCompName , strGetRptName);

  IF pReportType='Excel' THEN

      IF pIsBatchWiseReport = 'Y' THEN
        strBatchQuery := 'NULL,';
        strHeadQuery  := '"BATCH ID",';
      END IF;

      strSqlQuery := 'SELECT ''RH'' REPORT_SECTION,';
      strSqlQuery := strSqlQuery || REPLACE(strBatchQuery,',',' ') || strHeadQuery ;
      strSqlQuery := strSqlQuery || '''' || strGetCompName || ''' comp_name';
      strSqlQuery := strSqlQuery || ' ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL';
      strSqlQuery := strSqlQuery || ' ,NULL ,';
      strSqlQuery := strSqlQuery || REPLACE(strBatchQuery,',',' ') || strHeadQuery ;
      strSqlQuery := strSqlQuery || ' NULL ,NULL ,NULL ,NULL ,NULL,NULL,NULL FROM DUAL';
      strSqlQuery := strSqlQuery || ' UNION ALL ';
      strSqlQuery := strSqlQuery || ' SELECT ''X#X#X'' REPORT_SECTION,';
      strSqlQuery := strSqlQuery || strBatchQuery || 'NULL,NULL,NULL,NULL,NULL,NULL,NULL,';
      strSqlQuery := strSqlQuery || '''RH'' REPORT_SECTION,' || strBatchQuery ;
      strSqlQuery := strSqlQuery || '''' || UPPER(strGetRptName);
      strSqlQuery := strSqlQuery || ''' ,NULL,NULL,NULL,NULL,NULL,NULL FROM DUAL ';
      strSqlQuery := strSqlQuery || ' UNION ALL ';
      strSqlQuery := strSqlQuery || ' SELECT ''RH'' REPORT_SECTION,' ;
      strSqlQuery := strSqlQuery || strBatchQuery || 'NULL,NULL,NULL,NULL,NULL,NULL,NULL,';
      strSqlQuery := strSqlQuery || ' NULL,' || strBatchQuery ;
      strSqlQuery := strSqlQuery || ' NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM DUAL ';
      strSqlQuery := strSqlQuery || ' UNION ALL ';
      strSqlQuery := strSqlQuery || ' SELECT ''X#X#X'' REPORT_SECTION ,' ;
      strSqlQuery := strSqlQuery || strBatchQuery || 'NULL,NULL,NULL,NULL,NULL,NULL,NULL,';
      strSqlQuery := strSqlQuery || ' ''DH'' REPORT_SECTION,' || strBatchQuery ;
      strSqlQuery := strSqlQuery || ' ''ACCOUNT_NO'',''CUR_CODE'',''SOL_ID'',';
      strSqlQuery := strSqlQuery || ' ''CR_DR'',''TRAN_AMT'',''TRAN_PART'',';
      strSqlQuery := strSqlQuery || ' ''ACCOUNT_NAME'' FROM DUAL ';
      strSqlQuery := strSqlQuery || ' UNION ALL ';

      IF pIsBatchWiseReport  = 'Y' THEN
        strSelectClauseBatch := 'A.BATCH_ID AS "BATCH ID", ';
        strGroupByClause     := ' GROUP BY A.BATCH_ID, ';
      END IF;

      strSelectClause := strSelectClause || 'SELECT REPORT_SECTION, ACCOUNT_NO, ';
      strSelectClause := strSelectClause || 'CUR_CODE,SOL_ID ,CR_DR,TRAN_AMT , ';
      strSelectClause := strSelectClause || 'TRAN_PART, ACCOUNT_NAME, NULL , NULL';
      strSelectClause := strSelectClause || ',NULL ,NULL ,NULL ,NULL,NULL,NULL  ';
      strSelectClause := strSelectClause || 'FROM ( SELECT ''AC'' REPORT_SECTION,';
      strSelectClause := strSelectClause || strSelectClauseBatch ;
      strSelectClause := strSelectClause || ' BANK_ACCOUNT_NO ACCOUNT_NO,';
      strSelectClause := strSelectClause || ' ''INR'' CUR_CODE,EMP_MID SOL_ID';
      strSelectClause := strSelectClause || ' ,''C'' CR_DR,TNET_AMT TRAN_AMT ,';
      strSelectClause := strSelectClause || ' PAY_MONTH TRAN_PART, EMP_NAME ACCOUNT_NAME,';
      strSelectClause := strSelectClause || ' null ,'||strBatchQuery;
      strSelectClause := strSelectClause || ' NULL ,NULL ,NULL ,NULL ,NULL,NULL,NULL ';
      strSelectClause := strSelectClause || strFromClause||strWhereClause;

      strFromClause := ' FROM PY_PT_SAL_HD A ';

      strWhereClause := ' WHERE A.COMP_AID='''||pComp_Aid;
      strWhereClause := strWhereClause || ''' AND A.ACC_YEAR='''||pAcc_Year;
      strWhereClause := strWhereClause || ''' AND TO_DATE(''01''||A.PROCESS_MONTH)';
      strWhereClause := strWhereClause || ' >= '''||pFrom_Date;
      strWhereClause := strWhereClause || ''' AND LAST_DAY(TO_DATE(''01''||A.PROCESS_MONTH))';
      strWhereClause := strWhereClause || ' <='''||pTo_Date ;
      strWhereClause := strWhereClause || ''' AND A.PAY_MONTH IS NOT NULL';
      strWhereClause := strWhereClause || ' AND A.TNET_AMT<>0 AND TRIM(A.BANK_MID)=''006'' ';

      IF pIsBatchWiseReport='Y' THEN
        strWhereClause := strWhereClause || chr(13) || ' AND A.BATCH_ID IN ';
        strWhereClause := strWhereClause || ' (SELECT BT.BATCH_ID ';
        strWhereClause := strWhereClause || ' FROM PY_GTMP_BATCH_ID BT ';
        strWhereClause := strWhereClause || ' WHERE USER_AID=''' || pUSER_AID ;
        strWhereClause := strWhereClause || ''' AND SESSION_ID=''' || pSessionId ;
        strWhereClause := strWhereClause || ''' )';
      END IF;

      strOrderByClause := ' ORDER BY BANK_ACCOUNT_NO,EMP_MID)';

      strMainQuery:= strSqlQuery||strSelectClause||strFromClause||strWhereClause||strGroupByClause||strOrderByClause;

      OPEN Return_Recordset FOR strMainQuery ;
  ELSE

  OPEN Return_Recordset FOR
    SELECT SUBSTR(BANK_ACCOUNT_NO,1,4) "Branch Code", EMP_MID "ECN",EMP_NAME "EMPLOYEE NAME",TNET_AMT AMOUNT,BANK_ACCOUNT_NO "PPA NUMBER"
          FROM PY_PT_SAL_HD A  WHERE A.COMP_AID=pComp_Aid AND A.ACC_YEAR=pAcc_Year
          AND TO_DATE('01'||A.PROCESS_MONTH) >= pFrom_Date
          AND LAST_DAY(TO_DATE('01'||A.PROCESS_MONTH)) <=pTo_Date
          AND A.PAY_MONTH IS NOT NULL AND A.TNET_AMT<>0
          AND TRIM(A.BANK_MID)='006'
    order by BANK_ACCOUNT_NO,EMP_MID;

  END IF;

  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
  pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');

  EXCEPTION
    WHEN OTHERS THEN
      /*Craete Log*/
      INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,
      pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||
      SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END ;

PROCEDURE STATUTORY_PF_RPT
  (
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
    Return_Recordset OUT REC
  )
  IS
    TYPE Cur_Recordset IS REF CURSOR;
    Cur_Temp Cur_Recordset;
    strSqlQuery          LONG;
    strGetCompName       LONG;
    strGetRptName        LONG;
    strOrderBy           LONG;
    strWhereCon          LONG;
    strGroupBy           LONG;
    strSqlFromQuery      LONG;
    strSqlWhereQuery     LONG;
    strSqlUnionQuery     LONG;
    strSqlUnionQueryTotal LONG;
    strUnionGroupBy       LONG;
    strUnionOrderBy       LONG;
    vEMPLOYEE_CONTRIBUTION NUMBER(18,2);
    vEMPLOYER_PF           NUMBER(18,2);
    vEMPLOYERS_PENSION_FUND NUMBER(18,2);
    vVPF                    NUMBER(18,2);
    vADMIN_CHARGES          NUMBER(18,2);
    vINSURANCE_FUND         NUMBER(18,2);
    vADMIN_CHARGES_INSURANCE NUMBER(18,2);
    vTOTAL                   NUMBER(18,2);
   BEGIN
    --Inserting data into Temporary tables
    IF pIsBatchWiseReport = 'Y' THEN
      NULL;
    END IF;

    GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);

    IF pReportType ='Crystal' OR pReportType='View' THEN
        strSqlQuery         := 'SELECT B.COMP_NAME,';
        IF pIsBatchWiseReport='Y' THEN
            strSqlQuery       := strSqlQuery|| ' A.BATCH_ID,';
        END IF;

        strSqlQuery := strSqlQuery||' A.PAY_MONTH,A.CODE,A.NAME "EMPLOYEE NAME",
                                      PF_AC "PROVIDEND FUND ACCOUNT NO",D.REGION "REGION",D.FUNCTION "FUNCTION" ';

        strSqlQuery := strSqlQuery ||' ,SUM(A.BAS) "BASIC SALARY",SUM(A.EDLI_SAL) "E.D.L.I. SALARY",SUM(A.SPF) "EMPLOYEE CONTRIBUTION",
                                        SUM(A.EPF) "EMPLOYER PF",SUM(A.PEN) "EMPLOYERS PENSION FUND",SUM(A.VPF) "VPF"';

        strSqlQuery := strSqlQuery ||' ,SUM(A.TOT) "TOTAL AMOUNT",SUM(A.PFA) "ADMINISTRATIVE CHARGES",SUM(A.INF) "INSURANCE FUND",
                                        SUM(A.INA) "ADMIN CHARGES TO INSURANCE",TO_CHAR(C.PAID_DAYS) "PRESENT DAYS" ';

        strOrderBy :=' ORDER BY B.COMP_NAME,A.PAY_MONTH,A.CODE,A.NAME ,A.JOIN_DATE ,PF_AC';
    ELSE

      strSqlQuery         := 'SELECT ';
      IF pIsBatchWiseReport='Y' THEN
        strSqlQuery       := strSqlQuery|| ' A.BATCH_ID,';
      END IF;
      strSqlQuery :=' SELECT ''X#X#X'' REPORT_HEADER, null,null,null, null,null ,null,null, null,null,null,null,null,null,null, null,
                              ''RH'' REPORT_HEADER1,'''||strGetCompName||''', null,null ,null, null,null,null ,null, null,null,null,null,null,null,null
                      FROM DUAL UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null, null,
                      ''RH'' REPORT_HEADER,'''||strGetRptName||''', null,null ,null, null,null,null ,null, null,null,null,null,null,null, null
                      FROM DUAL UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER,null, null,null ,null, null,null,null ,null, null,null,null,null,null,null,null,
                      ''DH'' REPORT_HEADER1,  ''EMPLOYEE CODE'',''EMPLOYEE NAME'',''PROVIDEND FUND ACCOUNT NO'',''REGION'',''BUSINESS'',
                      ''BASIC SALARY'',''E.D.L.I. SALARY'',''EMPLOYEE CONTRIBUTION'',''EMPLOYER PF'',''EMPLOYERS PENSION FUND'',''VPF'',
                      ''TOTAL AMOUNT'',''ADMINISTRATIVE CHARGES'',''INSURANCE FUND'',''ADMIN CHARGES TO INSURANCE''
                      FROM DUAL UNION ALL ' ;

        strSqlQuery := strSqlQuery ||' SELECT PAY_MONTH,CODE "EMPLOYEE CODE",EMPLOYEE_NAME "EMPLOYEE NAME"
                                        ,PF_AC "PROVIDEND FUND ACCOUNT NO",REGION "REGION",FUNCTION "FUNCTION"  ,
                                        BASIC "BASIC SALARY",EDLI_SAL "E.D.L.I. SALARY",EMPLOYEE_CONTRIBUTION "EMPLOYEE CONTRIBUTION",
                                        EMPLOYER_PF "EMPLOYER PF",EMPLOYERS_PENSION_FUND "EMPLOYERS PENSION FUND",VPF "VPF"  ,
                                        TOTAL_AMOUNT "TOTAL AMOUNT",ADMIN_CHARGES "ADMINISTRATIVE CHARGES",INSURANCE_FUND "INSURANCE FUND",
                                        ADMIN_CHARGES_INSURANCE "ADMIN CHARGES TO INSURANCE",
                                        NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                                        ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                                        NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                                        NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                                        NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                                        NULL "ADMIN CHARGES TO INSURANCE1" FROM ( ';
         strSqlQuery := strSqlQuery ||' SELECT * FROM ( SELECT * FROM ( ';

         strSqlQuery := strSqlQuery ||' SELECT A.PAY_MONTH,A.CODE,A.NAME "EMPLOYEE_NAME"
                                        ,PF_AC "PF_AC",D.REGION "REGION",D.FUNCTION "FUNCTION"  ,
                                        SUM(A.BAS) BASIC,SUM(A.EDLI_SAL) EDLI_SAL,SUM(A.SPF) "EMPLOYEE_CONTRIBUTION",
                                        SUM(A.EPF) "EMPLOYER_PF",SUM(A.PEN) "EMPLOYERS_PENSION_FUND",SUM(A.VPF) "VPF"  ,
                                        SUM(A.TOT) "TOTAL_AMOUNT",SUM(A.PFA) "ADMIN_CHARGES",SUM(A.INF) "INSURANCE_FUND",
                                        SUM(A.INA) "ADMIN_CHARGES_INSURANCE" ,D.REGION||''_1'' REGIONWISE ';
      IF TRIM(pIsMultipleSheet)='Y' THEN
        strWhereCon:=' AND '||REPLACE(GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','C.' ) ;
      END IF;

      strOrderBy :=' ORDER BY B.COMP_NAME,A.PAY_MONTH,A.CODE,
                      A.NAME ,PF_AC)';
      END IF;

    strSqlFromQuery := strSqlFromQuery ||' FROM PY_VW_PF_STATMENT A, PY_GM_COMP B,PY_PT_SAL_HD C,PY_VW_EMPLOYEE_ATTR_MASTER D ';
    strSqlWhereQuery := strSqlWhereQuery ||' WHERE A.COMP_AID=B.COMP_ID AND A.COMP_AID=C.COMP_AID
                                              AND A.EMP_AID=C.EMP_AID AND A.ACC_YEAR=C.ACC_YEAR
                                              AND A.PAY_MONTH=C.PAY_MONTH
                                              AND A.COMP_AID=D.COMP_AID(+) AND A.EMP_AID=D.EMP_AID(+)
                                              AND A.COMP_AID='''||trim(pComp_Aid)||''' ';
    strSqlWhereQuery := strSqlWhereQuery ||'  AND TO_DATE(01||A.PAY_MONTH)>='''||pFrom_Date||'''
                                    AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<='''||pTo_Date||''' ';

    IF pIsBatchWiseReport='Y' THEN
      strWhereCon       := strWhereCon||
      '  AND A.BATCH_ID IN (SELECT BT.BATCH_ID FROM PY_GTMP_BATCH_ID BT WHERE USER_AID='''
      ||pUser_Aid||''' AND SESSION_ID='''||pSessionId||''' )';
    END IF;

    /*to generate the report for the Employees as per the Filter ID*/
    IF pFilterId IS NOT NULL THEN
      INSERT_FILTER_DATA_TEMPORARY
      (
        pComp_Aid ,pAcc_Year ,pPay_Month ,
        pFrom_Date ,pTo_Date ,pUser_Aid ,
        pSessionId ,pReportType ,pReportID,
        pIsMultipleSheet,pFilterId
      ) ;

      strWhereCon:=strWhereCon||chr(13 )
      ||' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
      ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
      pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
    END IF;
    strGroupBy          := ' GROUP BY ';
    IF pIsBatchWiseReport='Y' THEN
      strGroupBy        := strGroupBy || ' A.BATCH_ID,';
    END IF;
    strGroupBy := strGroupBy ||
    ' B.COMP_NAME,A.PAY_MONTH,A.CODE,A.NAME ,PF_AC,D.REGION,D.FUNCTION  ';


    strSqlUnionQuery := 'SELECT ''DH'' PAY_MONTH,TO_CHAR(COUNT(*)) CODE,NULL "EMPLOYEE_NAME",NULL "PF_AC",
                          D.REGION "REGION",NULL "FUNCTION" ,
                          SUM(A.BAS) BASIC,SUM(A.EDLI_SAL) EDLI_SAL,SUM(A.SPF) "EMPLOYEE_CONTRIBUTION",
                          SUM(A.EPF) "EMPLOYER_PF",SUM(A.PEN) "EMPLOYERS_PENSION_FUND",SUM(A.VPF) "VPF"  ,
                          SUM(A.TOT) "TOTAL_AMOUNT",SUM(A.PFA) "ADMIN_CHARGES",SUM(A.INF) "INSURANCE_FUND",
                          SUM(A.INA) "ADMIN_CHARGES_INSURANCE" ,D.REGION||''_2'' REGIONWISE  ';

    strUnionGroupBy := strUnionGroupBy ||' GROUP BY D.REGION ';

    strSqlUnionQueryTotal := ' SELECT ''DH'' PAY_MONTH,TO_CHAR(COUNT(*)) CODE,NULL "EMPLOYEE_NAME",NULL "PF_AC",
                                NULL "REGION",NULL "FUNCTION" ,
                                SUM(A.BAS) BASIC,SUM(A.EDLI_SAL) EDLI_SAL,SUM(A.SPF) "EMPLOYEE_CONTRIBUTION",
                                SUM(A.EPF) "EMPLOYER_PF",SUM(A.PEN) "EMPLOYERS_PENSION_FUND",SUM(A.VPF) "VPF"  ,
                                SUM(A.TOT) "TOTAL_AMOUNT",SUM(A.PFA) "ADMIN_CHARGES",SUM(A.INF) "INSURANCE_FUND",
                                SUM(A.INA) "ADMIN_CHARGES_INSURANCE" ,NULL||''_3'' REGIONWISE  ';

    strUnionOrderBy := ' ) REGIONWISE )';

    OPEN Cur_Temp FOR
    SELECT SUM(A.SPF) "EMPLOYEE_CONTRIBUTION",
      SUM(A.EPF) "EMPLOYER_PF",SUM(A.PEN) "EMPLOYERS_PENSION_FUND",SUM(A.VPF) "VPF"  ,
      SUM(A.PFA) "ADMIN_CHARGES",SUM(A.INF) "INSURANCE_FUND",
      SUM(A.INA) "ADMIN_CHARGES_INSURANCE"
      FROM PY_VW_PF_STATMENT A, PY_GM_COMP B,PY_PT_SAL_HD C,PY_VW_EMPLOYEE_ATTR_MASTER D
      WHERE A.COMP_AID=B.COMP_ID AND A.COMP_AID=C.COMP_AID
      AND A.EMP_AID=C.EMP_AID AND A.ACC_YEAR=C.ACC_YEAR
      AND A.PAY_MONTH=C.PAY_MONTH
      AND A.COMP_AID=D.COMP_AID(+) AND A.EMP_AID=D.EMP_AID(+)
      AND A.COMP_AID=trim(pComp_Aid)   AND TO_DATE(01||A.PAY_MONTH)>=pFrom_Date
      AND LAST_DAY(TO_DATE(01||A.PAY_MONTH))<=pTo_Date;
     FETCH Cur_Temp INTO vEMPLOYEE_CONTRIBUTION,vEMPLOYER_PF,vEMPLOYERS_PENSION_FUND,vVPF,
                         vADMIN_CHARGES,vINSURANCE_FUND,vADMIN_CHARGES_INSURANCE;
      CLOSE Cur_Temp;

      vTOTAL := vEMPLOYEE_CONTRIBUTION + vVPF+vEMPLOYER_PF+vADMIN_CHARGES+vEMPLOYERS_PENSION_FUND+vINSURANCE_FUND+vADMIN_CHARGES_INSURANCE;

    IF pMultiSheetCondition != 'REGION_WISE' THEN
        strSqlQuery:=strSqlQuery||strSqlFromQuery||strSqlWhereQuery||strWhereCon||strGroupBy||strOrderBy
                  ||'UNION ALL '||
                 strSqlUnionQuery||strSqlFromQuery||strSqlWhereQuery||strWhereCon||strUnionGroupBy
                  ||'UNION ALL '||
                  strSqlUnionQueryTotal||strSqlFromQuery||strSqlWhereQuery||strWhereCon
                  ||strUnionOrderBy||' UNION ALL '||
                  ' SELECT NULL,NULL "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,NULL "PROVIDEND FUND ACCOUNT NO",NULL "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                      UNION ALL
                      SELECT NULL,''EMPLOYERS SHARE CONT  TO PF+VPF'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,''A/C. NO. - 1'' "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vEMPLOYEE_CONTRIBUTION + vVPF)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                      UNION ALL
                      SELECT NULL,''EMPLOYERS SHARE CONT TO PF'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,''A/C. NO. - 1'' "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vEMPLOYER_PF)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                      UNION ALL
                      SELECT NULL,''ADMIN CHARGES'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,''A/C. NO. - 2'' "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vADMIN_CHARGES)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                            UNION ALL
                      SELECT NULL,''EMPLOYERS SHARE CONT TO PEN.'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,''A/C. NO. - 10'' "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vEMPLOYERS_PENSION_FUND)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                      UNION ALL
                       SELECT NULL,''INSURANCE FUND'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,''A/C. NO. - 21'' "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vINSURANCE_FUND)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                       UNION ALL
                       SELECT NULL,''ADMIN TO INSU.FUND'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,''A/C. NO. - 22'' "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vADMIN_CHARGES_INSURANCE)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual
                       UNION ALL
                      SELECT ''DH'' "REPORT_HEADER",''TOTAL'' "EMPLOYEE CODE",NULL "EMPLOYEE NAME"
                      ,NULL "PROVIDEND FUND ACCOUNT NO",'''||TO_CHAR(vTOTAL)||''' "REGION",NULL "FUNCTION"  ,
                      NULL "BASIC SALARY",NULL "E.D.L.I. SALARY",NULL "EMPLOYEE CONTRIBUTION",
                      NULL "EMPLOYER PF",NULL "EMPLOYERS PENSION FUND",NULL "VPF"  ,
                      NULL "TOTAL AMOUNT",NULL "ADMINISTRATIVE CHARGES",NULL "INSURANCE FUND",
                      NULL "ADMIN CHARGES TO INSURANCE",
                      NULL PAY_MONTH1,NULL "EMPLOYEE CODE1",NULL "EMPLOYEE NAME1"
                      ,NULL "PROVIDEND FUND ACCOUNT NO1",NULL "REGION1",NULL "FUNCTION1"  ,
                      NULL "BASIC SALARY1",NULL "E.D.L.I. SALARY1",NULL "EMPLOYEE CONTRIBUTION1",
                      NULL "EMPLOYER PF1",NULL "EMPLOYERS PENSION FUND1",NULL "VPF1"  ,
                      NULL "TOTAL AMOUNT1",NULL "ADMINISTRATIVE CHARGES1",NULL "INSURANCE FUND1",
                      NULL "ADMIN CHARGES TO INSURANCE1"
                      FROM dual ';

     ELSE

         strSqlQuery:=strSqlQuery||strSqlFromQuery||strSqlWhereQuery||strWhereCon||strGroupBy||strOrderBy
                  ||'UNION ALL '||
                  strSqlUnionQueryTotal||strSqlFromQuery||strSqlWhereQuery||strWhereCon
                  ||strUnionOrderBy;
     END IF;

  OPEN Return_Recordset FOR strSqlQuery;

  /*Craete Log */
  INSERT_REPORT_UPLOAD_LOG
  ( pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
    pSessionId ,pReportType , pReportID,'SUCCESS'
  );

  EXCEPTION
  WHEN OTHERS THEN
    /*Craete Log */
    INSERT_REPORT_UPLOAD_LOG
    ( pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
      pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM||CHR(13)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()
    );

  END;

   PROCEDURE FILL_LOGO( pComp_Aid VARCHAR2, pAcc_Year VARCHAR2, pPay_Month VARCHAR2, pFrom_Date DATE, pTo_Date DATE, pUser_Aid VARCHAR2, pSessionId VARCHAR2, pReportType VARCHAR2, pReportID VARCHAR2, pIsBatchWiseReport VARCHAR2, pFilterId VARCHAR2, pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2, Return_Recordset OUT REC)
     IS
     STRSQL       VARCHAR2(1000);
     REPORT_ID    VARCHAR2(20);
    BEGIN

    IF pReportID='RP00000030' THEN
        REPORT_ID:='TRP0000001';
    ELSIF pReportID='RP00000023' THEN
        REPORT_ID:='TRP0000002';
    ELSIF pReportID='RP00000024' THEN
        REPORT_ID:='TRP0000003';
    ELSIF pReportID='RP00000034' THEN
        REPORT_ID:='TRP0000004';
    END IF;

--
--         STRSQL:=  'SELECT REPORT_AID,REPORT_NAME,FOLDER_PATH,POWEREDBY_LOGO,POWEREDBY_LOGO_PATH,CLIENT_LOGO,CLIENT_LOGO_PATH,
--                    SIGN_LOGO,SIGN_LOGO_PATH ,POWEREDBY_IMG,CLIENT_IMG,SIGN_IMG,COMP_AID
--                    FROM VW_COMP_IMAGES_SETTING
--                    WHERE COMP_AID='''||pComp_Aid||''' AND REPORT_AID='''||REPORT_ID||'''';
--
--        OPEN Return_Recordset FOR STRSQL;

        OPEN Return_Recordset FOR
          SELECT A.REPORT_AID,A.REPORT_NAME,A.FOLDER_PATH,A.POWEREDBY_LOGO,A.POWEREDBY_LOGO_PATH,A.CLIENT_LOGO,A.CLIENT_LOGO_PATH,
                    A.SIGN_LOGO,A.SIGN_LOGO_PATH ,A.POWEREDBY_IMG,A.CLIENT_IMG,A.SIGN_IMG,B.COMP_AID,B.EMP_AID
        FROM VW_COMP_IMAGES_SETTING A,PY_GM_EMPMAST B
        WHERE A.COMP_AID(+)=B.COMP_AID
        AND B.COMP_AID=pComp_Aid AND NVL(A.REPORT_AID,REPORT_ID)=REPORT_ID;


    END  FILL_LOGO;

  PROCEDURE FILL_LEAVE_DETAILS(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date DATE,pTo_Date DATE,
 pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,
 pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC)
    IS
      TYPE CUR IS REF CURSOR;
      TEMP_RS CUR;
      strSqlQuery             long;
      strSelectClause         long;
      strFromClause           long;
      strWhereClause          long;
      strGroupByClause        long;
      strOrderByClause        long;
    BEGIN

       strSqlQuery:=   'SELECT ';
        strSelectClause :='A.COMP_AID,A.EMP_AID,NVL(SUM(B.LEAVE_AV),0) LEAVE_AV,C.PARA_MID LEAVE_TYPE,NVL(SUM(B.OPEN_BAL),0) OPEN_BAL,
               NVL(SUM(B.ENT),0) ENT,NVL(SUM(B.CLOSING_BAL),0) CLOSING_BAL';
        strFromClause:= ' FROM PY_PT_SAL_HD A,PY_PT_LEAVE_BAL B,PY_VW_PARAMETER_MASTER C ';
        strWhereClause:=' WHERE A.COMP_AID=B.COMP_AID(+) AND A.ACC_YEAR=B.ACC_YEAR(+) AND A.PAY_MONTH=B.PAY_MONTH(+) AND A.EMP_AID=B.EMP_AID(+)
                            AND B.LEAVE_TYPE=C.PAR_AID(+)
                            AND A.COMP_AID = '||''''||PCOMP_AID||''''||' AND A.ACC_YEAR = '||''''||PACC_YEAR||''''||'
                            AND A.PAY_MONTH = '||''''||PPAY_MONTH||''''||' ';

        IF pFilterId IS NOT NULL THEN
            INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date
            ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet
            ,pFilterId);
            strWhereClause:=strWhereClause||chr(13)||
            ' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''
            ||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||
            (
            CASE
            WHEN TRIM(pFilterId)='EMPLOYEE' THEN
              'RP0000TEMP'
            ELSE
              pReportID
            END)||''' AND COMP_AID='''||pComp_Aid||''')';
        END IF;

        strSqlQuery:=strSqlQuery||strSelectClause||strFromClause||strWhereClause||' GROUP BY A.COMP_AID,A.EMP_AID,C.PARA_MID';


        OPEN Return_Recordset FOR strSqlQuery ;

    END FILL_LEAVE_DETAILS;

---- NEW Report Master Variance report
----01-Dec-2018 nitin patil
PROCEDURE MASTER_VARIANCE_RPT(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,
                                  pFrom_Date DATE,pTo_Date DATE,pUser_Aid VARCHAR2,pSessionId VARCHAR2,
                                  pReportType VARCHAR2,pReportID VARCHAR2,
                                  pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2,pMasterType VARCHAR2, pMultiSheetCondition VARCHAR2,
                                  Return_Recordset OUT REC)
    IS
    vRPTVarianceCols VARCHAR2(2000);
    vVarianceInsQuery VARCHAR2(2000);
    vGetPrevMonth Varchar(20);
    strSelect    LONG;
    strExSelectClause       LONG;
    strSqlQueryFormat       LONG;
    strGetCompName          LONG;
    strGetRptName           LONG;

    BEGIN

        PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);

        DELETE FROM PY_PT_VARIANCE_TAB WHERE USER_AID= pUser_Aid AND REPORT_ID=pReportID;

        Select UPPER(to_char(to_date(to_char(ADD_MONTHS(TO_Date(01||pPay_Month),-1),'YYYY-MM'),'yyyy-mm'),'Mon yyyy')) into vGetPrevMonth from dual ;
  --      Delete from vai;
  --      Insert into vai values ('New report 1')  ;

       Strselect :='Select ''AC'' REPORT_HEADER,
                          PM.EMPLOYEE_CODE ,PM.EMPLOYEE_NAME ,TO_CHAR(PM.JOINING_DATE),TO_CHAR(PM.QUIT_DATE),PM.DESIGNATION,PM.GRADE,
                          PM.DEPARTMENT,PM.LOCATION,PM.STATE,PM.SAVING_ACOUNT,PM.BANK_NAME ,PM.EMPLOYEE_FATHER_NAME,PM.SEX,TO_CHAR(PM.BIRTH_DATE),PM.PAN_NUMBER,PM.PPF_NUMBER,PM.ESIC_NUMBER,
                          PM.EMAIL_ID , PM.OFFICIAL_EMAIL_ID,
                          CM.EMPLOYEE_CODE ,CM.EMPLOYEE_NAME ,TO_CHAR(CM.JOINING_DATE) ,TO_CHAR(CM.QUIT_DATE),CM.DESIGNATION,CM.GRADE,
                          CM.DEPARTMENT,CM.LOCATION,CM.STATE,CM.SAVING_ACOUNT,CM.BANK_NAME ,CM.EMPLOYEE_FATHER_NAME,CM.SEX,TO_CHAR(CM.BIRTH_DATE),CM.PAN_NUMBER,CM.PPF_NUMBER,CM.ESIC_NUMBER,
                          CM.EMAIL_ID , CM.OFFICIAL_EMAIL_ID
                          ,CASE WHEN TRIM(TO_CHAR(PM.EMPLOYEE_CODE)) = TRIM(TO_CHAR(CM.EMPLOYEE_CODE)) THEN ''TRUE'' ELSE ''FALSE'' End EMPLOYEE_CODE
                          ,CASE WHEN TRIM(TO_CHAR(PM.EMPLOYEE_NAME)) = TRIM(TO_CHAR(CM.EMPLOYEE_NAME)) THEN ''TRUE'' ELSE ''FALSE'' End EMPLOYEE_NAME
                          ,CASE WHEN NVL(TO_DATE(PM.JOINING_DATE),null) = NVL(TO_DATE(CM.JOINING_DATE),null) THEN ''TRUE'' ELSE ''FALSE'' End JOINING_DATE
                          ,CASE WHEN NVL(TO_CHAR(PM.QUIT_DATE),''NA'') = nvl(TO_CHAR(CM.QUIT_DATE),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End QUIT_DATE
                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.DESIGNATION)),''NA'') = NVL(TRIM(TO_CHAR(CM.DESIGNATION)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End DESIGNATION
                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.GRADE)),''NA'') = nvl(TRIM(TO_CHAR(CM.GRADE)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End GRADE
                          ,CASE WHEN nvl(TRIM(TO_CHAR(PM.DEPARTMENT)),''NA'') = NVL(TRIM(TO_CHAR(CM.DEPARTMENT)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End DEPARTMENT
                          ,CASE WHEN NVL(TO_CHAR(PM.LOCATION),''NA'') = NVL(TO_CHAR(CM.LOCATION),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End LOCATION
                          ,CASE WHEN NVL(TO_CHAR(PM.STATE),''NA'') = nvl(TO_CHAR(CM.STATE),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End STATE
                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.SAVING_ACOUNT)),''NA'') = NVL(TRIM(TO_CHAR(CM.SAVING_ACOUNT)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End SAVING_ACOUNT

                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.BANK_NAME)),''NA'') = nvl(TRIM(TO_CHAR(CM.BANK_NAME)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End BANK_NAME
                          ,CASE WHEN nvl(TRIM(TO_CHAR(PM.EMPLOYEE_FATHER_NAME)),''NA'') = NVL(TRIM(TO_CHAR(CM.EMPLOYEE_FATHER_NAME)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End EMPLOYEE_FATHER_NAME
                          ,CASE WHEN NVL(TO_CHAR(PM.SEX),''NA'') = NVL(TO_CHAR(CM.SEX),''NA'') THEN ''TRUE'' ELSE ''FALSE''   End SEX
                          ,CASE WHEN NVL(TO_CHAR(PM.BIRTH_DATE),''NA'') = nvl(TO_CHAR(CM.BIRTH_DATE),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End BIRTH_DATE
                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.PAN_NUMBER)),''NA'') = NVL(TRIM(TO_CHAR(CM.PAN_NUMBER)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End PAN_NUMBER

                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.PPF_NUMBER)),''NA'') = nvl(TRIM(TO_CHAR(CM.PPF_NUMBER)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End PPF_NUMBER
                          ,CASE WHEN nvl(TRIM(TO_CHAR(PM.ESIC_NUMBER)),''NA'') = NVL(TRIM(TO_CHAR(CM.ESIC_NUMBER)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End ESIC_NUMBER
                          ,CASE WHEN NVL(TO_CHAR(PM.EMAIL_ID),''NA'') = NVL(TO_CHAR(CM.EMAIL_ID),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End EMAIL_ID
                          ,CASE WHEN NVL(TRIM(TO_CHAR(PM.OFFICIAL_EMAIL_ID)),''NA'') = NVL(TRIM(TO_CHAR(CM.OFFICIAL_EMAIL_ID)),''NA'') THEN ''TRUE'' ELSE ''FALSE'' End OFFICIAL_EMAIL_ID ,
                          null REPORT_HEADER,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,
                          null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,
                          null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,
                          null,null,null,null,null ,null, null,null,null ,null, null,null,NULL

                        FROM (
                        SELECT A.COMP_AID, A.EMP_MID EMPLOYEE_CODE ,B.EMP_NAME EMPLOYEE_NAME ,B.JOIN_DATE JOINING_DATE ,B.LEAVE_DATE QUIT_DATE,B.DESG_DESC DESIGNATION,A.GRADE_DESC GRADE,
                        B.DEPT_DESC DEPARTMENT,B.LOC_DESC LOCATION,A.STATE_NAME STATE,B.BANK_ACCOUNT_NO SAVING_ACOUNT,B.BANK_DESC BANK_NAME ,
                        B.EMP_FATHERNAME EMPLOYEE_FATHER_NAME, A.SEX,B.BIRTH_DATE BIRTH_DATE,A.PAN_NUMBER,A.PPF_NUMBER,A.ESIC_No ESIC_NUMBER,
                        B.CORRESPONDENCE_EMAIL1 EMAIL_ID , B.CORRESPONDENCE_EMAIL2 OFFICIAL_EMAIL_ID
                        FROM py_gm_empmast A, PY_Pt_sal_HD B
                        Where A.EMP_AID = B.EMP_AID and A.COMP_AID =B.COMP_AID
                        And PROCESS_MONTH ='''||vGetPrevMonth||'''
                        Group by A.COMP_AID,
                        A.EMP_MID ,B.EMP_NAME ,b.JOIN_DATE ,b.LEAVE_DATE ,b.DESG_DESC ,a.GRADE_DESC ,b.DEPT_DESC ,b.LOC_DESC ,A.STATE_NAME ,b.BANK_ACCOUNT_NO ,b.BANK_DESC ,
                        b.EMP_FATHERNAME , A.SEX,b.BIRTH_DATE ,A.PAN_NUMBER,A.PPF_NUMBER,A.ESIC_No ,b.CORRESPONDENCE_EMAIL1 ,b.CORRESPONDENCE_EMAIL2
                        Order by A.EMP_MID )PM FULL OUTER JOIN
                        (
                        SELECT A.COMP_AID,A.EMP_MID EMPLOYEE_CODE ,B.EMP_NAME EMPLOYEE_NAME ,B.JOIN_DATE JOINING_DATE ,B.LEAVE_DATE QUIT_DATE,B.DESG_DESC DESIGNATION,A.GRADE_DESC GRADE,
                        B.DEPT_DESC DEPARTMENT,B.LOC_DESC LOCATION,A.STATE_NAME STATE,B.BANK_ACCOUNT_NO SAVING_ACOUNT,B.BANK_DESC BANK_NAME ,
                        B.EMP_FATHERNAME EMPLOYEE_FATHER_NAME, A.SEX,B.BIRTH_DATE BIRTH_DATE,A.PAN_NUMBER,A.PPF_NUMBER,A.ESIC_No ESIC_NUMBER,
                        B.CORRESPONDENCE_EMAIL1 EMAIL_ID , B.CORRESPONDENCE_EMAIL2 OFFICIAL_EMAIL_ID
                        FROM
                        py_gm_empmast A, PY_Pt_sal_HD B
                        Where A.EMP_AID = B.EMP_AID and A.COMP_AID =B.COMP_AID
                        And PROCESS_MONTH ='''||pPay_Month||'''
                        Group by A.COMP_AID,
                        A.EMP_MID ,B.EMP_NAME ,b.JOIN_DATE ,b.LEAVE_DATE ,b.DESG_DESC ,a.GRADE_DESC ,b.DEPT_DESC ,b.LOC_DESC ,A.STATE_NAME ,b.BANK_ACCOUNT_NO ,b.BANK_DESC ,
                        b.EMP_FATHERNAME , A.SEX,b.BIRTH_DATE ,A.PAN_NUMBER,A.PPF_NUMBER,A.ESIC_No ,b.CORRESPONDENCE_EMAIL1 ,b.CORRESPONDENCE_EMAIL2
                        Order by A.EMP_MID )CM  ON PM.EMPLOYEE_CODE = CM.EMPLOYEE_CODE and PM.COMP_AID =CM.COMP_AID
                        WHERE PM.COMP_AID ='''||pComp_Aid||''' ';

        strSqlQueryFormat := 'SELECT ''X#X#X'' REPORT_HEADER,
                              null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                              null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                              null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                              ''RH'' REPORT_HEADER1,'''||strGetCompName||''',
                              null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                              null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                              null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
                           FROM DUAL
                    UNION ALL
                        SELECT ''X#X#X'' REPORT_HEADER,
                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                ''RH'' REPORT_HEADER,'''||strGetRptName||''',
                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
                                FROM DUAL

                         UNION ALL
                                SELECT ''X#X#X'' REPORT_HEADER,
                                '''|| vGetPrevMonth ||' MASTER'',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                '''|| pPay_Month ||' MASTER'',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                ''VARIANCE'',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                ''DH'' REPORT_HEADER,
                                '''|| vGetPrevMonth ||' MASTER'',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                '''|| pPay_Month ||' MASTER'',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
                                ''VARIANCE'',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,Null
                                FROM DUAL
                    UNION ALL
                        SELECT ''X#X#X'' REPORT_HEADER,null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,
                              null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,
                              null,null,null,null,null ,null, null,null,null ,null, null,null,null,null,null,
                              null,null,null,null,null ,null, null,null,null ,null, null,null,
                              ''DH'' REPORT_HEADER1,''EMPLOYEE_CODE'' ,''EMPLOYEE_NAME'',''JOINING_DATE '',''QUIT_DATE'',''DESIGNATION'',''GRADE'',''DEPARTMENT'',''LOCATION'',''STATE'',''SAVING_ACOUNT'',
                              ''BANK_NAME '',''EMPLOYEE_FATHER_NAME'',''SEX'',''BIRTH_DATE'',''PAN_NUMBER'',''PPF_NUMBER'',''ESIC_NUMBER'',''EMAIL_ID '', ''OFFICIAL_EMAIL_ID'',
                              ''EMPLOYEE_CODE '',''EMPLOYEE_NAME '',''JOINING_DATE '',''QUIT_DATE'',''DESIGNATION'',''GRADE'',''DEPARTMENT'',''LOCATION'',''STATE'',''SAVING_ACOUNT'',
                              ''BANK_NAME '',''EMPLOYEE_FATHER_NAME'',''SEX'',''BIRTH_DATE'',''PAN_NUMBER'',''PPF_NUMBER'',''ESIC_NUMBER'',''EMAIL_ID '', ''OFFICIAL_EMAIL_ID '',
                              ''EMPLOYEE_CODE '',''EMPLOYEE_NAME '',''JOINING_DATE '',''QUIT_DATE'',''DESIGNATION'',''GRADE'',''DEPARTMENT'',''LOCATION'',''STATE'',''SAVING_ACOUNT'',
                              ''BANK_NAME '',''EMPLOYEE_FATHER_NAME'',''SEX'',''BIRTH_DATE'',''PAN_NUMBER'',''PPF_NUMBER'',''ESIC_NUMBER'',''EMAIL_ID '', ''OFFICIAL_EMAIL_ID ''
                              FROM DUAL UNION ALL ' ;

Delete from vai;


       strSqlQueryFormat :=strSqlQueryFormat||strSelect ;

      Insert into vai values(strSqlQueryFormat);
      commit ;
      OPEN Return_Recordset FOR strSqlQueryFormat ;


     /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
        EXCEPTION
        WHEN OTHERS THEN
        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM);

   END;

PROCEDURE LWF_REPORT(
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
          IS
          TYPE Cur_Recordset
          IS
            REF
            CURSOR;
              Cur_Temp Cur_Recordset;
              strSqlQuery LONG;
              strSqlQueryOuter LONG;
              strArrearSqlQuery LONG;
              strSubGrandTotalClause LONG;
              strGrandTotalClause LONG;
              strSelectClause LONG;
              strFromClause LONG;
              strWhereClause LONG;
              strGroupByClause LONG;
              strOrderByClause LONG;
              strWhereNullCond LONG;
              strAllowanceMonthly LONG;
              strOtherAllowance LONG;
              strDeduction LONG;
              strExSelectClause LONG;
              strExGroupByClause LONG;
              strSqlQueryFormat LONG;
              strGetCompName LONG;
              strGetRptName LONG;
              strNullHead LONG;
              vCount NUMBER(10) DEFAULT 1;
              strDedNullHead LONG;
              strAllwNullHead LONG;
              strAllwanceHead LONG;
              strDeductionHead LONG;
              -- strNullHead         LONG;
            BEGIN
              PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
              pTo_Date,strGetCompName,strGetRptName);
              vCount :=1;
              --MASTER COLUMNNS
--              strSqlQuery          :='SELECT * FROM (SELECT ';
--              IF pIsBatchWiseReport = 'Y' THEN
--                strExSelectClause  :='A.BATCH_ID AS "BATCH ID", ';
--                strExGroupByClause :='A.BATCH_ID, ';
--              END IF;
              strSelectClause :=
              'SELECT * FROM (SELECT ''AC'' "REPORT_HEADER","PAY_MONTH","CODE","EMPLOYEE NAME","JOINING DATE","CIRCLE","LOCATION","STATE",LWFE "LABOUR WELFARE FUND EMPLOYEE",
                                     LWFER "LABOUR WELFARE FUND EMPLOYER",(LWFE+LWFER) "TOTAL",
                                     null "REPORT_HEADER1", null "PAY MONTH1",null "CODE1",null "EMPLOYEE NAME1",NULL "JOINING DATE1" ,NULL "CIRCLE1", NULL "LOCATION1" ,null "STATE1",
                                     null "LABOUR WELFARE FUND EMPLOYEE1",null "LABOUR WELFARE FUND EMPLOYER1",null "TOTAL1"
                                     FROM
                                    (SELECT B.PAY_MONTH "PAY_MONTH",A.EMP_MID "CODE",A.EMP_NAME "EMPLOYEE NAME",TO_CHAR(A.JOIN_DATE,''DD-MON-YYYY'') "JOINING DATE",C.CIRCLE "CIRCLE",A.LOC_DESC "LOCATION",
                                     A.STATE_NAME "STATE",ROUND(SUM(DECODE(TRIM(B.CTC_MID),''LWF'',NVL(B.AMOUNT,0),0)),2) AS "LWFE",
                                   (

                                     CASE
                                     WHEN A.STATE_NAME IN(''Kerala'')
                                     THEN ROUND(SUM(DECODE(TRIM(B.CTC_MID),''LWF'',NVL(B.AMOUNT*1,0),0)),2)
                                     WHEN A.STATE_NAME in(''Haryana'',''Delhi'',''Gujarat'',''Karnataka'',''Punjab'',''Tamil Nadu'')
                                     THEN ROUND(SUM(DECODE(TRIM(B.CTC_MID),''LWF'',NVL(B.AMOUNT*2,0),0)),2)

                                     WHEN A.STATE_NAME in(''Maharashtra'',''Goa'',''Madhya Pradesh'')
                                     THEN ROUND(SUM(DECODE(TRIM(B.CTC_MID),''LWF'',NVL(B.AMOUNT*3,0),0)),2)
                                     WHEN A.STATE_NAME in(''Punjab'')
                                     THEN ROUND(SUM(DECODE(TRIM(B.CTC_MID),''LWF'',NVL(B.AMOUNT*4,0),0)),2)
                                     WHEN A.STATE_NAME IN(''West Bengal'')
                                     THEN ROUND(SUM(DECODE(TRIM(B.CTC_MID),''LWF'',NVL(B.AMOUNT*5,0),0)),2)

                                         END) AS "LWFER"


                                     FROM PY_GM_EMPMAST A,
                                          PY_VW_PT_SAL_DT B,
                                          (SELECT A.COMP_AID,C.EMP_AID,SUB_ATTB_DESC AS CIRCLE
                                                  FROM GM_ATTRIBUTE A,
                                                       PM_SUB_ATTRIBUTE B,
                                                       PM_EMP_ATTRIBUTE C

                                                  WHERE B.COMP_AID  =B.COMP_AID
                                                        AND A.ATTB_AID    =B.ATTB_AID
                                                        AND B.COMP_AID    =C.COMP_AID
                                                        AND B.ATTB_AID    =C.ATTB_AID
                                                        AND B.SUB_ATTB_AID=C.SUB_ATTB_AID
                                                        AND A.ATTB_MID    =''CIRCLE''
                                                        AND A.COMP_AID    ='''||pComp_Aid||''' ) C

                                                  WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.COMP_AID = C.COMP_AID(+) AND A.EMP_AID = C.EMP_AID(+)
                                                        AND B.PAY_MONTH  IS NOT NULL AND B.ARR_FLAG    <>''F'' AND (A.LEAVE_DATE IS NULL OR (A.LEAVE_DATE  >= '''||pFrom_Date||'''))
                                                        AND A.COMP_AID     = '''||pComp_Aid||''' AND B.ACC_YEAR     = '''||pAcc_Year||''' AND TO_DATE(01||B.PROCESS_MONTH)>='''||pFrom_Date||'''
                                                        AND LAST_DAY(TO_DATE(01||B.PROCESS_MONTH))<='''||pTo_Date ||''' AND B.PAY_MONTH      IS NOT NULL

                                                  GROUP BY B.PAY_MONTH,A.EMP_MID,A.EMP_NAME,A.JOIN_DATE,C.CIRCLE,A.LOC_DESC,A.STATE_NAME )

                                                  WHERE  STATE IN(''Haryana'',''Punjab'',''Kerala'',''Maharashtra'',''Gujarat'',''West Bengal'',''Madhya Pradesh'',''Goa'',''Karnataka'',''Delhi'',''Tamil Nadu'') and LWFER<>0 )';

 strSqlQuery :='SELECT ''X#X#X'' REPORT_HEADER1,null,null,null,null,null,null,null,null,null,null,
                      ''RH'' REPORT_HEADER,'''||strGetCompName||''' ,null,null,null,null,null,null,null,null,null
                      FROM DUAL

                      UNION ALL

                      SELECT ''X#X#X'' REPORT_HEADER1,null,null,null,null,null,null,null,null,null,null,
                      ''RH'' REPORT_HEADER,'''||strGetRptName||''',null,null,null,null,null,null,null,null,null
                      FROM DUAL

                      UNION ALL

                      SELECT ''X#X#X'' REPORT_HEADER1,null,null,null,null,null,null,null,null,null,null,
                      ''DH'' REPORT_HEADER,''PAY_MONTH'',''CODE'',
                      ''EMPLOYEE NAME'' ,''JOINING DATE'', ''CIRCLE'',
                      ''LOCATION'',''STATE'',''LABOUR WELFARE FUND EMPLOYEE'',
                      ''LABOUR WELFARE FUND EMPLOYER'',''TOTAL''
                      FROM DUAL
                      UNION ALL ';



            strSqlQuery:=strSqlQuery||strSelectClause;

            Delete from vai;
            insert into vai values(strSqlQuery);
            COMMIT;
            --Finally Return the recordset here
            OPEN Return_Recordset FOR strSqlQuery ;
            /*Craete Log */
            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
            (
              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
              pSessionId ,pReportType , pReportID,'SUCCESS'
            )
            ;
          EXCEPTION
          WHEN OTHERS THEN
            /*Craete Log*/
            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
            (
              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
              pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
            )
            ;
      END ;


         PROCEDURE WESTIN_PF_REPORT(
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
      IS
      TYPE Cur_Recordset
      IS
        REF
        CURSOR;
          Cur_Temp Cur_Recordset;
          Strselect          LONG;
          StrselectTAB          LONG;
          StrselectTAB1         LONG;
          StrselectTAB2         LONG;
          Strcasecluse1       LONG;
          Strcasecluse2       LONG;
          Strsubquery        LONG;
          Strfrom            LONG;
          Strwhere           LONG;
          Strgroupby         LONG;
          Strorderby         LONG;
          strSqlQuery        CLOB;
          StrFormatting      LONG;
          NULL_VAL LONG;
          HEADER_COL LONG;
          strTOTAL          LONG;
          strHEADER_COL_SUM     LONG;
          strHEADER_COL_SUM1    LONG;
          strGetCompName        LONG;
          strGetRptName         LONG;

          strCTC_COLUMNS        LONG;
          strCTC_CATE           LONG;
          strNULL_VAL           LONG;
          strHEADER_COL         LONG;
          strNULL               LONG;
          strCTC_DED            LONG;


           vEDLI_LIMIT           NUMBER(13,2);
          vEMPLOYEE_PF_PCT      NUMBER(13,2);
          vEMPLOYER_PENSION_PCT NUMBER(13,2);
          vINSURANCE_FUND_PCT   NUMBER(13,2);
          vINSURANCE_ADMIN_PCT  NUMBER(13,2);
          vPF_ADMIN_PCT         NUMBER(13,2);
          vEMPR_PF_PCT          NUMBER(13,2);
          vEMP_PF_AMT           NUMBER(13,2);
          vEMPR_PF_AMT          NUMBER(13,2);
          vPENSION_AGE          NUMBER(2):=58;

        BEGIN

            PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,
            pTo_Date,strGetCompName,strGetRptName);


           OPEN Cur_Temp FOR
             SELECT EDLI_LIMIT, EMPLOYEE_PF_PCT, EMPLOYER_PENSION_PCT, INSURANCE_FUND_PCT,
                 INSURANCE_ADMIN_PCT,PF_ADMIN_PCT,EMPR_PF_PCT , EMP_PF_AMT ,EMPR_PF_AMT
            FROM PY_PM_EMPPF A,PY_VW_GM_PARAMETERS B,PY_VW_GM_PARAMETERS C
            WHERE COMP_AID=pComp_Aid AND TO_DATE(01||pPay_Month) BETWEEN EFF_DATE_FR AND NVL(EFF_DATE_TO,TO_DATE(01||pPay_Month))
                AND A.EMP_PF_LOGIC_AID=B.PAR_AID AND B.PARA_GRP_MID='PFTYPCAL'
             AND A.EMPR_PF_LOGIC_AID=C.PAR_AID AND C.PARA_GRP_MID='PFTYPCAL';
          FETCH Cur_Temp INTO vEDLI_LIMIT, vEMPLOYEE_PF_PCT, vEMPLOYER_PENSION_PCT, vINSURANCE_FUND_PCT,
                 vINSURANCE_ADMIN_PCT,vPF_ADMIN_PCT,vEMPR_PF_PCT,vEMP_PF_AMT,vEMPR_PF_AMT;
          CLOSE Cur_Temp;

            OPEN Cur_Temp FOR

        SELECT   LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(HEADER_COL_SUM,',') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG(HEADER_COL_SUM,'+') WITHIN GROUP (ORDER BY ROWNUM),
                 LISTAGG('NULL ' ||'"'||ROW_NUM||'"',',') WITHIN GROUP (ORDER BY ROWNUM)
        FROM
        (
          SELECT CTC_COLUMNS,NULL_VAL,HEADER_COL,ROWNUM ROW_NUM,HEADER_COL_SUM
          FROM
            (

             SELECT B.CTC_MID,
                 'ROUND(CASE WHEN D.CTC_MID='''
                  ||TRIM(B.CTC_MID)
                  ||''' THEN A.AMOUNT ELSE 0 END,0) AS "'
                  ||REPLACE(SUBSTR(NVL(B.REG_DISP_NAME,B.CTC_NAME),1,30),'''','')
                  ||'"'CTC_COLUMNS,
                  ' '''||D.CTC_CATE_ID_MID||'''' CTC_CATE ,NULL|| ' "'||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')
                ||'"' NULL_VAL,''''
                ||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')||'''' HEADER_COL ,
                'ROUND(SUM('||'"'||REPLACE(SUBSTR(B.CTC_NAME,1,30),'''','')||'"'||'),0)' HEADER_COL_SUM,
                  B.SORT_ORDER,
                  B.CTC_TYPE,
                  C.PARA_DESC,
                  NVL(B.REG_DISP_NAME,B.CTC_NAME) CTC_NAME,
                  B.CTC_MID
                FROM
                  PY_PT_SAL_DT A,
                  PY_CTC_ALLOWANCE_MAST B,
                  PY_VW_PM_ALLWDED D,
                  PY_GM_PARAMETERS C
                WHERE
                  A.COMP_AID      = B.COMP_ID
                AND A.ALLWDED_AID =B.CTC_CODE
                AND B.COMP_ID=D.COMP_ID
                AND B.CTC_CODE=D.CTC_CODE
                AND B.CTC_CATE_ID = C.PAR_AID
--                AND B.CTC_TYPE='A'
                AND A.ARR_FLAG   <>'F'
                AND A.AMOUNT     <>0
                AND A.COMP_AID    = pComp_Aid
                AND A.ACC_YEAR    = pAcc_Year
--                AND (TO_DATE(01||A.PROCESS_MONTH)>=pFrom_Date  AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<=pTo_Date)
--                AND B.CTC_MID NOT IN ('BAS','DA','PRINLOAN')
                 AND D.CTC_MID IN ('BAS','ATTR','CNN','DA','HRA','INC','OTR','SPA')
                AND A.AMOUNT > 0
                GROUP BY
                  B.CTC_TYPE,
                  C.PARA_DESC,
                  B.SORT_ORDER,
                  B.CTC_NAME,
                  B.REG_DISP_NAME,
                  B.CTC_MID,
                  D.CTC_CATE_ID_MID
                ORDER BY
                  B.CTC_TYPE,
                  B.SORT_ORDER
            )
            ORDER BY ROW_NUM
        );
        FETCH Cur_Temp INTO strCTC_COLUMNS,strNULL_VAL,strHEADER_COL,strHEADER_COL_SUM,strHEADER_COL_SUM1,strNULL;
        CLOSE Cur_Temp;

          StrFormatting:='SELECT ''X#X#X'' REPORT_HEADER,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'||strNULL||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
                      ,''RH'' REPORT_HEADER1,'''||strGetCompName||''',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'||strNULL||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM DUAL
                      UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'||strNULL||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
                      ,''RH'' REPORT_HEADER1,'''||strGetRptName||''',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'||strNULL||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM DUAL
                      UNION ALL
                      SELECT ''X#X#X'' REPORT_HEADER,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'||strNULL||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
                      ,''DH'' REPORT_HEADER1,''CODE'',''EMPLOYEE NAME'',''JOIN DATE'',''DATE OF BIRTH'',''DATE OF EXIT'',''GENDER'',''PROVIDENT FUND ACCOUNT NO'',''FATHER/HUSBAND NAME'','||REPLACE(strHEADER_COL,'"','''')||',
                      ''GROSS'',''E.D.L.I.SALARY'',''BASIC SALARY'',''EMPLOYEE CONTRIBUTION'',''EMPLOYER CONTRIBUTION PF'',''PENSION FUND'',''TOTAL AMOUNT'',''ADMINISTRATIVE CHARGES'',
                      ''INSUARANCE FUND'',''ADMIN CHARGES TO INSURANCE'',''Pension(for IW 1.16%)'',''TOTAL''
                      FROM DUAL
                      UNION ALL
                      ';

              Strselect:='SELECT ''AC'' REPORT_HEADER,EMP_MID,EMP_NAME,JOIN_DATE,BIRTH_DATE,LEAVE_DATE,GENDER,PPF_NUMBER,EMP_FATHERNAME,'||strHEADER_COL_SUM||',
--                            ROUND(SUM("BASIC SALARY"),0)+ROUND(SUM("HOUSE RENT ALLOW"),0)+ROUND(SUM("CONVEYANCE ALLOWANCE"),0)+ROUND(SUM("SPECIAL ALLOWANCE"),0)+ROUND(SUM("INCENTIVE"),0)+ROUND(SUM("OTHER EARNING"),0)+ROUND(SUM("ATTIRE REIMBURSEMENT"),0)+ROUND(SUM("DEARNESS ALLOWANCE"),0) GROSS,
                            '||strHEADER_COL_SUM1||' AS GROSS,
                            EDLI_SAL,BASIC,SPF,EMPLOYERS_CONTRIBUTION_PF,PENSION_FUND,SPF+EMPLOYERS_CONTRIBUTION_PF+PENSION_FUND TOTAL_AMOUNT--,ADMN_CHARGES_FOR_E_P_F
                          ,BASIC*0.5/100 "ADMINISTRATIVE CHARGES","INSURANCE FUND",VOLUNTARY_PF,0 "Pension(for IW)",SPF+EMPLOYERS_CONTRIBUTION_PF+PENSION_FUND+BASIC*0.5/100+"INSURANCE FUND"+VOLUNTARY_PF TOTAL--,ADMIN_CHARGES_INSURANCE_FUND
                  ,NULL REPORT_HEADER1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'||strNULL||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
                  FROM(
                  SELECT  B.EMP_MID,B.EMP_NAME,TO_CHAR(TO_DATE(B.JOIN_DATE),''DD-MON-YY'') JOIN_DATE,TO_CHAR(TO_DATE(B.BIRTH_DATE),''DD-MON-YY'') BIRTH_DATE,TO_CHAR(TO_DATE(B.LEAVE_DATE),''DD-MON-YY'') LEAVE_DATE,B.SEX GENDER,--PRESENT_DAYS,ARR_DAYS,
                  B.EMP_FATHERNAME,B.PPF_NUMBER,B.CC_DESC,B.DEPT_DESC,B.DESG_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER,
                  '||strCTC_COLUMNS||',--TSAL_AMT GROSS ,TDED_AMT DEDUCTION,TNET_AMT NET,
                  BASIC ,
                  EDLI_SAL,SPF,PENSION_FUND,EMPLOYERS_CONTRIBUTION_PF--,ADMN_CHARGES_FOR_E_P_F
                  ,"ADMINISTRATIVE CHARGES","INSURANCE FUND",VOLUNTARY_PF--ADMIN_CHARGES_INSURANCE_FUND
                  ';

          Strfrom:='FROM PY_PT_SAL_DT A,PY_GM_EMPMAST B,PY_PT_SAL_HD HD,PY_CTC_ALLOWANCE_MAST D,
              (SELECT COMP_AID, PAY_MONTH , EMP_AID, CASE WHEN PAY_MONTH<>ARR_MONTH THEN DAYS ELSE 0 END ARR_DAYS,CASE WHEN PAY_MONTH=ARR_MONTH THEN DAYS ELSE 0 END PRESENT_DAYS
              FROM PY_PT_ARR_DAYS_DT WHERE COMP_AID = '''||pComp_Aid||''' AND ACC_YEAR   ='''||pAcc_Year||''' AND PAY_MONTH='''||pPay_Month||''') PD,
              (SELECT EMP_MID "EMPLOYEE CODE",EMP_NAME "EMPLOYEE NAME",COMP_AID,EMP_AID,PAY_MONTH,
              birth_DATE "BIRTH DATE",TODAY "YEAR", year "age",JOIN_DATE "DOJ",PPF_NUMBER "PF NUMBER" ,UAN_NO ,EMP_FATHERNAME ,--DAYS,
              SUM(BASIC) BASIC,SUM(EDLI_SAL) EDLI_SAL,SUM(PENSION_WAGES) PENSION_WAGES, SUM(PF_WAGES) PF_WAGES,SUM(SPF)SPF,SUM(EMPLOYERS_CONTRIBUTION_PF) EMPLOYERS_CONTRIBUTION_PF,SUM(PENSION_FUND) PENSION_FUND,(SUM(SPF)+SUM(EMPLOYERS_CONTRIBUTION_PF)+SUM(PENSION_FUND)) "GROSS",
              SUM(ADMINISTRATIVE_CHARGES) "ADMINISTRATIVE CHARGES",SUM(INSURANCE_FUND) "INSURANCE FUND",SUM(ADMIN_CHARGES_INSURANCE_FUND) "ADMIN_CHARGES_INSURANCE_FUND", SUM(VOLUNTARY_PF) VOLUNTARY_PF
              FROM (
              SELECT B.EMP_MID  ,B.EMP_NAME  ,TO_CHAR(b.birth_date,''DD-MON-YYYY'') "BIRTH_DATE",TO_CHAR(sysdate,''DD-MON-YYYY'') "TODAY",
               A.COMP_AID,A.EMP_AID,A.PAY_MONTH,FLOOR((LAST_DAY(TO_DATE(01||'''||pPay_Month||''')) - B.BIRTH_DATE)/365) "YEAR",TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') JOIN_DATE,
              B.PPF_NUMBER ,E.UAN_NO,E.EMP_FATHERNAME, --,AR.DAYS "DAYS",
              SUM(A.AMOUNT) BASIC,LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''') EDLI_SAL

                  ,CASE WHEN G.PARA_MID=''12PERBOT'' THEN
                            CASE WHEN FLOOR((LAST_DAY(TO_DATE(01||'''||pPay_Month||''')) - B.BIRTH_DATE)/365) >= '||vPENSION_AGE||'  THEN  0
                            ELSE LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''')  END
                        WHEN G.PARA_MID=''780BOTH'' THEN
                            CASE WHEN FLOOR((LAST_DAY(TO_DATE(01||'''||pPay_Month||''')) - B.BIRTH_DATE)/365) >= '||vPENSION_AGE||' THEN  0
                            ELSE LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''')  END
                   END   "PENSION_WAGES",

               CASE WHEN G.PARA_MID=''12PERBOT'' THEN  SUM(A.AMOUNT)
                    WHEN G.PARA_MID=''780BOTH''  THEN   LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''')
               ELSE   SUM(A.AMOUNT) END    "PF_WAGES" ,

              CASE WHEN G.PARA_MID=''12PERBOT'' THEN ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0)
                   WHEN G.PARA_MID=''780BOTH''  THEN CASE WHEN SUM(A.AMOUNT)>= '''||vEDLI_LIMIT||''' THEN '||vEMP_PF_AMT||'
               ELSE ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0) END
                   WHEN SUM(A.AMOUNT)>= '''||vEDLI_LIMIT||''' THEN '||vEMP_PF_AMT||'
                   ELSE ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0) END "SPF",
            --  ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0)
            CASE WHEN G.PARA_MID=''12PERBOT'' THEN ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0)
                   WHEN G.PARA_MID=''780BOTH'' THEN CASE WHEN SUM(A.AMOUNT)>= '''||vEDLI_LIMIT||''' THEN '||vEMPR_PF_AMT||'
                                                ELSE ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0) END
                   WHEN SUM(A.AMOUNT)>= '''||vEDLI_LIMIT||''' THEN '||vEMPR_PF_AMT||'
                   ELSE ROUND(SUM(A.AMOUNT) * ('''||vEMPLOYEE_PF_PCT||'''/100),0) END - CASE WHEN  FLOOR((LAST_DAY(TO_DATE(01||'''||pPay_Month||''')) - B.BIRTH_DATE)/365) >= '''||vPENSION_AGE||''' THEN 0
              ELSE ROUND(LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''') * ('''||vEMPLOYER_PENSION_PCT||'''/100),0) END "EMPLOYERS_CONTRIBUTION_PF",

           --   CASE WHEN FLOOR((LAST_DAY(TO_DATE(01||'''||pPay_Month||''')) - B.BIRTH_DATE)/365) >= '''||vPENSION_AGE ||''' THEN 0 ELSE ROUND(LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''') * ('''||vEMPLOYER_PENSION_PCT||'''/100),0) END "PENSION_FUND",
            CASE WHEN FLOOR((LAST_DAY(TO_DATE(01||'''||pPay_Month||''')) - B.BIRTH_DATE)/365) >= '''||vPENSION_AGE ||''' THEN 0 ELSE
              CASE WHEN AR.PAY_MONTH = AR.ARR_MONTH THEN  ROUND(LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''') * ('''||vEMPLOYER_PENSION_PCT||'''/100),0)
                ELSE NVL(( ROUND(LEAST( (SELECT  SUM(A.AMOUNT) FROM PY_PT_SAL_DT A, PY_CTC_ALLOWANCE_MAST C
                                      WHERE  A.COMP_AID=C.COMP_ID AND A.ALLWDED_AID=C.CTC_CODE AND PAY_MONTH  = AR.ARR_MONTH
                                          AND COMP_AID = '''||trim(pComp_Aid)||''' AND ACC_YEAR= '''||trim(pAcc_Year)||'''
                                          AND C.CTC_TYPE = ''A''  AND NVL(C.PF_FLAG,0) =''1''), '''||vEDLI_LIMIT||''')* ('||vEMPLOYER_PENSION_PCT||'/100),0)
                        - ROUND( '''||vEDLI_LIMIT||''' * ('''||vEMPLOYER_PENSION_PCT||'''/100),0) ),0)

             END
             END "PENSION_FUND",
              ROUND(SUM(A.AMOUNT) * ('''||vPF_ADMIN_PCT||'''/100),2) "ADMINISTRATIVE_CHARGES",
              ROUND(LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''') * ('''||vINSURANCE_FUND_PCT||'''/100),2) "INSURANCE_FUND",
              ROUND(LEAST(SUM(A.AMOUNT),'''||vEDLI_LIMIT||''') * ('''||vINSURANCE_ADMIN_PCT||'''/100),2) "ADMIN_CHARGES_INSURANCE_FUND"
              ,NVL(H.VPF_AMOUNT,0) "VOLUNTARY_PF" --, case when A.arr_flag=''A'' AND FUNC_CHK_NEW_JOINEE(A.COMP_AID  ,A.EMP_AID,'''||trim(pPay_Month)||''',E.JOIN_DATE)=''Y'' THEN ''ARREAR'' ELSE NULL END   REMARK

              FROM PY_PT_SAL_DT A,PY_PT_SAL_HD B,PY_CTC_ALLOWANCE_MAST C  , PY_GM_PARAMETERS G , PY_GM_EMPMAST E,
                     (SELECT COMP_AID, PAY_MONTH ,EMP_AID, ARR_MONTH,DAYS FROM  PY_PT_ARR_DAYS_DT WHERE COMP_AID = '''||trim(pComp_Aid)||''' AND ACC_YEAR='''||trim(pAcc_Year)||''' ) AR,
                    (select  DT.EMP_AID, DT.PAY_MONTH, DT.COMP_AID, DT.ALLWDED_AID, DT.AMOUNT  VPF_AMOUNT ,ACC_YEAR from PY_PT_SAL_DT DT, PY_CTC_ALLOWANCE_MAST AW
            where   DT.COMP_AID= '''||trim(pComp_Aid)||'''  AND DT.PAY_MONTH='''||trim(pPay_Month)||''' AND AW.CTC_MID  =''VPF'' AND DT.ALLWDED_AID = AW.CTC_CODE(+)  AND DT.COMP_AID =AW.COMP_ID(+) ) H
            WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID AND A.ACC_YEAR=B.ACC_YEAR AND A.PAY_MONTH=B.PAY_MONTH
                                             AND AR.COMP_AID = A.COMP_AID  AND  AR.EMP_AID  = A.EMP_AID
                                          AND AR.PAY_MONTH = A.PAY_MONTH AND AR.ARR_MONTH = A.ARR_MONTH
                                           AND A.COMP_AID=C.COMP_ID AND A.ALLWDED_AID=C.CTC_CODE AND E.EMP_AID = B.EMP_AID
                          AND  E.PF_CALCULATION_TYPE=G.PAR_AID(+)   AND C.CTC_TYPE =''A''  AND NVL(C.PF_FLAG,0) =''1''
                          AND  A.COMP_AID=H.COMP_AID(+) AND A.EMP_AID = H.EMP_AID(+) AND A.PAY_MONTH=H.PAY_MONTH(+)
                                           AND A.COMP_AID='''||trim(pComp_Aid)||''' AND A.ACC_YEAR='''||trim(pAcc_Year)||'''
                                           AND TO_DATE(01||A.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||A.PROCESS_MONTH))<='''||pTo_Date||'''
                       GROUP BY B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.PPF_NUMBER,AR.DAYS,B.BIRTH_DATE ,G.PARA_MID , H.VPF_AMOUNT
                          ,E.EMP_FATHERNAME,E.UAN_NO,AR.PAY_MONTH ,A.COMP_AID,A.EMP_AID,A.PAY_MONTH, AR.ARR_MONTH
--                          case when A.arr_flag=''A'' AND FUNC_CHK_NEW_JOINEE(A.COMP_AID  ,A.EMP_AID,'''||trim(pPay_Month)||''',E.JOIN_DATE)=''Y'' THEN ''ARREAR'' ELSE NULL END
                          HAVING SUM(A.AMOUNT) <> 0
             )
             GROUP BY EMP_MID ,EMP_NAME ,COMP_AID,EMP_AID,PAY_MONTH,
              birth_DATE ,TODAY , year ,JOIN_DATE ,PPF_NUMBER  ,UAN_NO ,EMP_FATHERNAME
             ) PF,
                        (SELECT COMP_ID,PAY_MONTH,EMP_AID,ESIC_FLAG,SUM(WAGES) WAGES,ESIC_EMPLOYER
                        FROM PY_VW_ESIC_STATEMENT
                        WHERE PAY_MONTH='''||pPay_Month||''' AND COMP_ID    ='''||pComp_Aid||'''
                        AND ACC_YEAR='''||pAcc_Year||'''
                        GROUP BY COMP_ID,PAY_MONTH,EMP_AID,ESIC_FLAG,ESIC_EMPLOYER
                        ) K
                        ';

         Strwhere:='WHERE A.COMP_AID=B.COMP_AID
                        AND A.EMP_AID=B.EMP_AID
                        AND A.COMP_AID=PD.COMP_AID
                        AND A.EMP_AID=PD.EMP_AID
                        AND A.COMP_AID=D.COMP_ID
                        AND A.ALLWDED_AID=D.CTC_CODE
                        AND A.COMP_AID=HD.COMP_AID
                        AND A.EMP_AID=HD.EMP_AID
                        AND A.PAY_MONTH=HD.PAY_MONTH
                        AND A.COMP_AID=PF.COMP_AID
                        AND A.EMP_AID=PF.EMP_AID
                        AND A.PAY_MONTH=PF.PAY_MONTH
                        AND A.COMP_AID=K.COMP_ID(+)
                        AND A.EMP_AID=K.EMP_AID(+)
                        AND A.COMP_AID=PF.COMP_AID
                        AND A.COMP_AID='''||pComp_Aid||'''
                        AND A.ACC_YEAR='''||pAcc_Year||'''
                        AND A.PAY_MONTH='''||pPay_Month||'''
                        ';

          Strgroupby:=' GROUP BY B.EMP_MID,B.EMP_NAME,B.JOIN_DATE,B.LEAVE_DATE,B.SEX,B.PPF_NUMBER,B.EMP_FATHERNAME,B.BIRTH_DATE--,PRESENT_DAYS,ARR_DAYS
                       ,B.CC_DESC,B.DEPT_DESC,B.DESG_DESC,B.LOC_DESC,B.BANK_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER,
                        TSAL_AMT ,TDED_AMT ,TNET_AMT, K.ESIC_FLAG,K.WAGES,K.ESIC_EMPLOYER,A.EMP_AID,SPF,BASIC,EDLI_SAL,PENSION_FUND,EMPLOYERS_CONTRIBUTION_PF--,ADMN_CHARGES_FOR_E_P_F
                        ,"ADMINISTRATIVE CHARGES","INSURANCE FUND",VOLUNTARY_PF--,ADMIN_CHARGES_INSURANCE_FUND
                        ,D.CTC_MID,A.AMOUNT--,EDLI_SAL,SPF,ADMN_CHARGES_FOR_E_P_F
                        ORDER BY B.EMP_MID)
                        GROUP BY EMP_MID,EMP_NAME,JOIN_DATE,LEAVE_DATE,GENDER,PPF_NUMBER,EMP_FATHERNAME,BIRTH_DATE,
                        BASIC,EDLI_SAL,SPF,PENSION_FUND,EMPLOYERS_CONTRIBUTION_PF--,ADMN_CHARGES_FOR_E_P_F
                        ,"ADMINISTRATIVE CHARGES","INSURANCE FUND",VOLUNTARY_PF
                        ';

--          strSqlQuery:=StrFormatting||Strselect||Strfrom||Strwhere||Strgroupby;

             strSqlQuery:=StrFormatting||Strselect||Strfrom||Strwhere||Strgroupby;--|| ' UNION ALL ' ||strTOTAL||Strfrom||Strwhere||Strgroupby ;

          OPEN Return_Recordset FOR strSqlQuery ;


--            DBMS_OUTPUT.PUT_LINE(Strcasecluse1)    ;
--            DBMS_OUTPUT.PUT_LINE(Strcasecluse2)    ;
--            DBMS_OUTPUT.PUT_LINE(strSqlQuery)    ;
                DELETE FROM VAI;
                INSERT INTO VAI VALUES(strSqlQuery);
                COMMIT;
               /*Craete Log */
            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
            (
              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
              pSessionId ,pReportType , pReportID,'SUCCESS'
            )
            ;
          EXCEPTION
          WHEN OTHERS THEN
            /*Craete Log*/
            PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG
            (
              pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,
              pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM
            )
            ;

END WESTIN_PF_REPORT;

   PROCEDURE CTC_RPT_WITH_EMPLOYEE(pComp_Aid VARCHAR2,pAcc_Year VARCHAR2,pPay_Month VARCHAR2,pFrom_Date varchar2,pTo_Date varchar2,pUser_Aid VARCHAR2,pSessionId VARCHAR2,pReportType VARCHAR2,pReportID VARCHAR2,pIsBatchWiseReport VARCHAR2,pFilterId VARCHAR2,pIsMultipleSheet VARCHAR2, pMasterType VARCHAR2,pMultiSheetCondition VARCHAR2,Return_Recordset OUT REC)

    IS
    TYPE Cur_Recordset IS REF CURSOR;
    Cur_Temp                Cur_Recordset;

    strSqlQuery     LONG;
    strSelect       LONG;
    strFrom         LONG;
    strWhere        LONG;
    strGroupBy      LONG;
    strOrderBy      LONG;

    strCTC_COLUMNS  LONG;
    strCTC_CATE     LONG;
    strNULL_VAL     LONG;
    strHEADER_COL   LONG;
    strGetCompName  long;
    strGetRptName   long;
    vFlag           VARCHAR2(1);


    BEGIN


        PY_PK_STANDARD_REPORT_COMMON.GET_REPORT_DTL(pComp_Aid,pAcc_Year,pReportID,pPay_Month ,pFrom_Date ,pTo_Date,strGetCompName,strGetRptName);


        --        Inserting data into Temporary tables
        IF pIsBatchWiseReport = 'Y' THEN
        --INSERT_BATCH_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId);
        NULL;
        END IF;

        OPEN Cur_Temp FOR
        SELECT --WM_CONCAT(CTC_COLUMNS),WM_CONCAT(CTC_CATE),WM_CONCAT(NULL_VAL),WM_CONCAT(HEADER_COL)
          LISTAGG(CTC_COLUMNS,',') WITHIN GROUP (ORDER BY ROWNUM),
          LISTAGG(CTC_CATE,',') WITHIN GROUP (ORDER BY ROWNUM),
          LISTAGG(NULL_VAL,',') WITHIN GROUP (ORDER BY ROWNUM),
          LISTAGG(HEADER_COL,',') WITHIN GROUP (ORDER BY ROWNUM)
        FROM (
        SELECT CTC_COLUMNS,DECODE(ROW_NUMBER() OVER (PARTITION BY CTC_CATE ORDER BY CTC_CATE) ,1,CTC_CATE,'NULL') CTC_CATE,replace(NULL_VAL||'"'||rownum||'"','""','_') NULL_VAL,HEADER_COL FROM(
        SELECT DISTINCT 'SUM(DECODE(TRIM(CTC_MID),'''||B.CTC_MID||''',AMOUNT,0)) "'||SUBSTR(B.CTC_NAME,1,30)||'"' CTC_COLUMNS,B.SORT_ORDER,' '''||C.CTC_CATE_ID_MID||'''' CTC_CATE ,NULL || ' "'||SUBSTR(B.CTC_NAME,1,13)||'"' NULL_VAL,''''||REPLACE(B.CTC_NAME,'''','')||'''' HEADER_COL
        FROM PY_PM_EMPCTCDTL A, PY_CTC_ALLOWANCE_MAST B, PY_VW_PM_ALLWDED C
        WHERE A.COMP_AID=B.COMP_ID AND A.ALLWDED_aID=B.CTC_CODE AND A.COMP_AID=pComp_Aid AND A.EFF_DATE_TO IS NULL
        AND B.COMP_ID=C.COMP_ID AND B.CTC_CODE=C.CTC_CODE
        ORDER BY CTC_CATE,SORT_ORDER
        ));
        FETCH Cur_Temp INTO strCTC_COLUMNS,strCTC_CATE,strNULL_VAL,strHEADER_COL;
        CLOSE Cur_Temp;
        --

        --        strSelect:='SELECT ''X#X#X'' REPORT_HEADER, '''||strGetCompName||''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
        --                    NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
        --                                NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||' FROM DUAL
        --                    UNION ALL
        --                    SELECT ''X#X#X'' REPORT_HEADER, '''||strGetRptName||''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
        --                    NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
        --                                NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||' FROM DUAL
        --                    UNION ALL
        --                    SELECT ''X#X#X'' REPORT_HEADER,NULL "Employee Id",NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
        --                                NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",'||strCTC_CATE||' FROM DUAL UNION ALL ';
        --
        --        strSelect:=strSelect||'SELECT ''X#X#X'' REPORT_HEADER, ''Employee Id'',''Employee Name'', ''Gender'', ''Joining Date'', ''Quit Date'',
        --                    ''CTC Effective From Date'',''CTC Effective To Date'', ''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
        --                                ''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'',' ||strHEADER_COL||' FROM DUAL ';
        --***************************
        strSelect:='SELECT ''X#X#X'' REPORT_HEADER, null "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
            NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
                        NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||',''RH'' REPORT_HEADER, '''||strGetCompName||''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
            NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
                        NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||' FROM DUAL
            UNION ALL
            SELECT ''X#X#X'' REPORT_HEADER, null "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
            NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
                        NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||',''RH'' REPORT_HEADER, '''||strGetRptName||''' "Employee Id", NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",
            NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
                        NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||' FROM DUAL
            UNION ALL
            SELECT ''X#X#X'' REPORT_HEADER,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL , NULL , NULL ,NULL ,NULL ,
                        NULL ,NULL ,NULL ,' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||',''OXO'' REPORT_HEADER,NULL "Employee Id",NULL "Employee Name",NULL "Gender",NULL "Joining Date",NULL "Quit Date",NULL "CTC Effective From Date",NULL "CTC Effective To Date", NULL "DEPARTMENT", NULL "DESIGNATION",NULL "GRADE",NULL "LOCATION",
                        NULL "SAVING ACCOUNT",NULL "BANK NAME",NULL "PAN NUMBER",'||strCTC_CATE||' FROM DUAL UNION ALL ';

        strSelect:=strSelect||'SELECT ''X#X#X'' REPORT_HEADER,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL , NULL , NULL ,NULL ,NULL ,
                        NULL ,NULL ,NULL ,' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "')||',''DH'' REPORT_HEADER, ''Employee Id'',''Employee Name'', ''Gender'', ''Joining Date'', ''Quit Date'',
                        ''CTC Effective From Date'',''CTC Effective To Date'', ''DEPARTMENT'', ''DESIGNATION'',''GRADE'',''LOCATION'',
                        ''SAVING ACCOUNT'',''BANK NAME'',''PAN NUMBER'',' ||strHEADER_COL||' FROM DUAL ';

        --**************************
        strSelect:=strSelect||' UNION ALL SELECT * FROM(SELECT ''XD'' REPORT_HEADER, B.EMP_MID "Employee Id",B.EMP_NAME "Employee Name", B.SEX "Gender", TO_CHAR(B.JOIN_DATE,''DD-MON-YYYY'') "Joining Date", TO_CHAR(B.LEAVE_DATE,''DD-MON-YYYY'') "Quit Date",
         TO_CHAR(A.EFF_DATE_FR, ''DD-MON-YYYY'') "CTC Effective From Date",TO_CHAR(A.EFF_DATE_TO, ''DD-MON-YYYY'') "CTC Effective To Date", B.DEPT_DESC AS "DEPARTMENT", B.DESG_DESC AS "DESIGNATION",B.GRADE_DESC AS "GRADE",B.LOC_DESC AS "LOCATION",
                        TO_CHAR(B.BANK_CURR_ACCOUNT_NO) AS "SAVING ACCOUNT",B.BANK_DESC AS "BANK NAME",TO_CHAR(B.PAN_NUMBER) AS "PAN NUMBER",';
        --*******************



        --********************
        strSelect:=strSelect||strCTC_COLUMNS||',NULL REPORT_HEADER1, NULL "Employee Id1",NULL "Employee Name1", NULL "Gender1", NULL "Joining Date1", NULL "Quit Date1",
         NULL "CTC Effective From Date1",NULL "CTC Effective To Date1", NULL "DEPARTMENT1", NULL "DESIGNATION1",NULL "GRADE1",NULL "LOCATION1",
                        NULL "SAVING ACCOUNT1",NULL "BANK NAME1",NULL "PAN NUMBER1",' ||REPLACE(REPLACE(strNULL_VAL,'''','"'),' "','NULL "');
        strFrom:=' FROM PY_PM_EMPCTCDTL A, PY_PT_SAL_HD B, PY_VW_PM_ALLWDED C ';
        strWhere:= ' WHERE A.COMP_AID = B.COMP_AID AND A.EMP_AID = B.EMP_AID AND A.COMP_AID = C.COMP_ID AND A.ALLWDED_AID = C.CTC_CODE ';
        strWhere:= strWhere||' AND A.EFF_DATE_TO IS NULL AND A.COMP_AID = '''||pComp_Aid||''' ';
        strWhere:=strWhere||' AND TO_DATE(01||B.PROCESS_MONTH)>='''||pFrom_Date||''' AND LAST_DAY(TO_DATE(01||B.PROCESS_MONTH))<='''||pTo_Date||'''';
        IF TRIM(pIsMultipleSheet) ='Y' THEN
           strWhere:=strWhere||' AND '||REPLACE(PY_PK_STANDARD_REPORT_COMMON.GET_CONDITION(pMasterType , pMultiSheetCondition),'HD.','B.');

        END IF;

        IF pFilterId IS NOT NULL THEN
        PY_PK_STANDARD_REPORT_COMMON.INSERT_FILTER_DATA_TEMPORARY(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType ,pReportID,pIsMultipleSheet,pFilterId);
        --               strWhere:=strWhere||chr(13)||' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||(CASE WHEN TRIM(pFilterId)='EMPLOYEE' THEN 'RP0000TEMP' ELSE pReportID END)||''' AND COMP_AID='''||pComp_Aid||''')';
         strWhere:=strWhere||chr(13)||' AND A.EMP_AID IN (SELECT EMP_AID FROM PY_GTMP_EMP_LIST WHERE USER_AID='''||pUSER_AID||''' AND SESSION_ID='''||pSessionId||''' AND REPORT_AID='''||pReportID ||''' AND COMP_AID='''||pComp_Aid||''')';
        END IF;

        strGroupBy:=' GROUP BY B.EMP_MID ,B.EMP_NAME , B.SEX , B.JOIN_DATE, B.LEAVE_DATE,A.EFF_DATE_FR ,A.EFF_DATE_TO, B.DEPT_DESC, B.DESG_DESC,B.GRADE_DESC ,B.LOC_DESC,
                        B.BANK_CURR_ACCOUNT_NO,B.BANK_DESC,B.PAN_NUMBER';
        strOrderBy:=' ORDER BY B.EMP_MID)';

        strSqlQuery:= strSelect||CHR(13)||strFrom||CHR(13)||strWhere||CHR(13)||strGroupBy||CHR(13)||strOrderBy;



        OPEN Return_Recordset for strSqlQuery;

        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'SUCCESS');
        EXCEPTION
        WHEN OTHERS THEN
        /*Craete Log */
        PY_PK_STANDARD_REPORT_COMMON.INSERT_REPORT_UPLOAD_LOG(pComp_Aid ,pAcc_Year ,pPay_Month ,pFrom_Date ,pTo_Date ,pUser_Aid ,pSessionId ,pReportType , pReportID,'FAILED :'||SQLERRM);

    END;

End  PY_PK_STANDARD_REPORTS;