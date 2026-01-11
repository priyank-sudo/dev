SET DEFINE OFF;


create or replace PROCEDURE PRO_MAIL_REMINDER_new(pComp_Aid VARCHAR2,pEmp_Aid VARCHAR2 )
/*CREATE BY SAROJ KUMAR GIRI*/
IS
    TYPE refCUR IS REF CURSOR;
    curRec                   refCUR;
    sgPUB_DATE               DATE;
    vPUB_DATE                DATE;
    vSYSDATE                 DATE;
    vNoOfDays                NUMBER(10) DEFAULT 0;
    vDay                     VARCHAR2(20);
    vREMINDER1_DATE          DATE;
    vREMINDER2_DATE          DATE;
    MAILBODY1                LONG;
    SUBJECT                  VARCHAR2(1000);
    vIS_ACCEPTED             CHAR(1);
    vIS_AUTOUPDATED          CHAR(1);
    V_EMP_NAME               VARCHAR2(100);
    PoornataID               VARCHAR2(200);
    v_Mailid                 VARCHAR2(100);
    vMAIL_SEND               CHAR(1);
    v_Mailidcc               VARCHAR2(100);
    V_EMP_NAMEcc             VARCHAR2(100);
    vCompDispCode            VARCHAR2(10);
    vUserName                VARCHAR2(20);
    vPassword                VARCHAR2(10);
    vCOMPDISPCODE1             VARCHAR2(10);
    vCount                   NUMBER(10) DEFAULT 0;
    
BEGIN


       OPEN curRec FOR
       SELECT C.EMAIL,C.IS_ACCEPTED,C.MAIL_SEND,TO_DATE(C.PUB_DATE,'DD-MM-YY'),
       C.IS_AUTOUPDATED,B.COMP_MID||'_'||A.USER_NAME,
       'CO'||LTRIM(TO_CHAR(TO_NUMBER(SUBSTR(A.GRP_COMP_ID,3,6))||TO_NUMBER(SUBSTR(A.COMP_AID,3,6)),'000000')),
       A.USER_NAME,D.EMP_NAME,REMINDER1_DATE,REMINDER2_DATE 
       FROM PI_GM_USERS A,PI_GM_COMP B,PI_GM_TRANS_FNF C,PI_GM_EMPMAST D 
       WHERE A.COMP_AID=B.COMP_ID AND A.GRP_COMP_ID=B.GRP_COMP_ID AND A.COMP_AID=C.COMP_AID AND A.EMP_ID=C.EMP_AID 
       AND A.COMP_AID=D.COMP_AID AND A.EMP_ID=D.EMP_AID AND C.COMP_AID=pComp_Aid AND C.EMP_AID=pEmp_Aid;
       FETCH curRec INTO v_Mailid,vIS_ACCEPTED,vMAIL_SEND,sgPUB_DATE,vIS_AUTOUPDATED,vUserName,vCOMPDISPCODE1,PoornataID,V_EMP_NAME,vREMINDER1_DATE,vREMINDER2_DATE;
       CLOSE curRec;

       OPEN curRec FOR
       SELECT EMP_NAME,CORRESPONDENCE_EMAIL1 FROM PI_GM_EMPMAST A,PI_GM_EMP_ATTRIBUTE_MAST B WHERE A.COMP_AID=B.COMP_AID AND A.EMP_AID=B.EMP_AID
       AND B.ATTB_MID='SPOC' AND B.COMP_AID=pComp_Aid;
       FETCH curRec INTO V_EMP_NAMEcc,v_Mailidcc;
       CLOSE curRec;

       vPUB_DATE:=TO_DATE(sgPUB_DATE);
       /*CREATE BY SAROJ KUMAR GIRI*/ 
      /* HOLIDAY CHECKING START */ 
       ----------------------------
      LOOP
           IF  TRIM(TO_CHAR(TO_DATE(vPUB_DATE),'DD-MON')) IN ('26-JAN','15-AUG','02-OCT','25-DEC','01-MAY') 
--               OR TO_CHAR(vPUB_DATE,'HH24:MI:SS')>='16:00:00' 
               OR TRIM(TO_CHAR(TO_DATE(vPUB_DATE),'DAY')) IN ('SATURDAY','SUNDAY') THEN
              
              vPUB_DATE:=vPUB_DATE+1;
           ELSE
              vPUB_DATE:=vPUB_DATE;
              vCount:=vCount+1;
                 IF TO_CHAR(SYSDATE,'DDMONYYYY')=TO_CHAR(vPUB_DATE,'DDMONYYYY') THEN 
                     vNoOfDays:=vCount;
                  END IF ;
           END IF;
      EXIT WHEN TO_CHAR(SYSDATE,'DDMONYYYY') =TO_CHAR(vPUB_DATE,'DDMONYYYY');
            vPUB_DATE:=vPUB_DATE+1;
      END LOOP;

                 IF vMAIL_SEND='N' THEN
                    
                        SUBJECT:='Full and Final Statement generated for '||V_EMP_NAME||'  ('||PoornataID||') for your acceptance';
                        
                                 MAILBODY1 := MAILBODY1||'<html><BODY>' || '<FONT style="FONT-FAMILY: arial; FONT-SIZE: 12px;">';
                                 MAILBODY1 := MAILBODY1||''||''||'';
                                 MAILBODY1 := MAILBODY1||'';
                                 MAILBODY1 := MAILBODY1||'<P>Dear <b>' || V_EMP_NAME || ',</b> </p>';
                                 MAILBODY1 := MAILBODY1||'<p> Your Full and Final Settlement statement is ready for your review. Please login to portal and accept Full & Final Statement generated.</P>';
                                 MAILBODY1 := MAILBODY1||'<p> Link: <b> https://onex.osourceglobal.com/ABGESS/ </b> </P>';
                                 MAILBODY1 := MAILBODY1||'<p> Company Code:  <b> '|| vCOMPDISPCODE1 || ' </b> </P>';
                                 MAILBODY1 := MAILBODY1||'<p> User Name:  <b> '|| vUserName || ' </b> </P>';
                                 
                                 MAILBODY1 := MAILBODY1||'<p> We would like a confirmation from your end by clicking the “Accept” button if you are satisfied with the payment details. In case you need a correction, you can click “ Reject” and mention the details of correction required in the Remarks section.</P>';
                                                               
                                 MAILBODY1 := MAILBODY1||'<p> Full and Final Settlement will be considered as auto approved if not accepted within 5 days.</P>';
          
--                                 MAILBODY1 := MAILBODY1||'<p> I would like to authorize my employer to credit the Fnull dues to my account.
--                                                              In case the  F&F is a recovery, I will transfer the amount within 7 days 
--                                                              to the account mentioned below. </P>';
          
                                 MAILBODY1 := MAILBODY1||'<p> Note: This is a system generated email from an unmonitored mailbox. </P>';
                                 --MAILBODY1 := MAILBODY1||'<p> Link: <b> https://cs.osourceindia.com/ABGESS_UAT/ </b> </P>';
          
                                 MAILBODY1 := MAILBODY1||'<P><br>Best Regards,</P>';
                                 MAILBODY1 := MAILBODY1||'<P><b>Payroll Team - Osource</b></P>';
                                 MAILBODY1 := MAILBODY1||'</BODY></HTML>';
                                 
                                 PRO_SEND_MAIL_NEW('payroll@osourceindia.com' ,v_Mailid,SUBJECT,MAILBODY1,NULL,NULL); 
                                 UPDATE PI_GM_TRANS_FNF SET MAIL_SEND='Y' WHERE COMP_AID=pComp_Aid AND EMP_AID=pEmp_Aid;
                                 INSERT INTO OSO VALUES(MAILBODY1||'-'||'1');
                                 COMMIT;


                 ELSE
                     
                 IF NVL(vIS_ACCEPTED,'N')='N' AND NVL(vIS_AUTOUPDATED,'N')='N' THEN
INSERT INTO OSO VALUES(vNoOfDays);
COMMIT;


                           IF vNoOfDays=2 AND vREMINDER1_DATE IS NULL THEN
                            
                               SUBJECT:='Reminder 1: Full and Final Statement generated for  '||V_EMP_NAME||'  ('||PoornataID||')  for your acceptance';  
                                           MAILBODY1 := MAILBODY1||'<html><BODY>' || '<FONT style="FONT-FAMILY: arial; FONT-SIZE: 12px;">';
                                           MAILBODY1 := MAILBODY1||''||''||'';
                                           MAILBODY1 := MAILBODY1||'';
                                           MAILBODY1 := MAILBODY1||'<P>Dear <b>' || V_EMP_NAME || ',</b> </p>';
                                           MAILBODY1 := MAILBODY1||'<p> Your Full and Final Settlement statement is ready for your review and was released for review on 
                                                                        '''||sgPUB_DATE||'''. Please login to portal and accept Full & Final Statement generated.</P>';
                                           MAILBODY1 := MAILBODY1||'<p> Link: <b> https://onex.osourceglobal.com/ABGESS/ </b> </P>';
                                           MAILBODY1 := MAILBODY1||'<p> Company Code:  <b> '|| vCOMPDISPCODE1 || ' </b> </P>';
                                           MAILBODY1 := MAILBODY1||'<p> User Name:  <b> '|| vUserName || ' </b> </P>';
                                           
                                           MAILBODY1 := MAILBODY1||'<p> We would like a confirmation from your end by clicking the “Accept” button if 
                                                                        you are satisfied with the payment details. In case you need a correction, 
                                                                        you can click “ Reject” and mention the details of correction required in the Remarks section.</P>';
                                                                         
--                                           MAILBODY1 := MAILBODY1||'<p> Non-confirmation of the Full & Final settlement with 5 days of 
--                                                                        receipt of the email will be construed as a deemed acceptance</P>';
                    
                                           MAILBODY1 := MAILBODY1||'<p> Full and Final Settlement will be considered as auto approved if not accepted within 5 days from Release Date. </P>';
                    
                                           MAILBODY1 := MAILBODY1||'<p> Note: This is a system generated email from an unmonitored mailbox. </P>';
                                           --MAILBODY1 := MAILBODY1||'<p> Link: <b> https://cs.osourceindia.com/ABGESS_UAT/ </b> </P>';
                    
                                           MAILBODY1 := MAILBODY1||'<P><br>Best Regards,</P>';
                                           MAILBODY1 := MAILBODY1||'<P><b>Payroll Team - Osource</b></P>';
                                           MAILBODY1 := MAILBODY1||'</BODY></HTML>';
                                           
                                           PRO_SEND_MAIL_NEW('payroll@osourceindia.com' ,v_Mailid,SUBJECT,MAILBODY1,NULL,NULL);
                                           PRO_DATE_REMINDER(pComp_Aid,pEmp_Aid,vNoOfDays);
                                           INSERT INTO OSO VALUES(MAILBODY1||'-'||'2');
                                           COMMIT;

                           ELSIF vNoOfDays=4 AND vREMINDER2_DATE IS NULL THEN
       
                               SUBJECT:='Final Reminder: Full and Final Statement generated for  '||V_EMP_NAME||'  ('||PoornataID||')  for your acceptance';   
                                           
                                           MAILBODY1 := MAILBODY1||'<html><BODY>' || '<FONT style="FONT-FAMILY: arial; FONT-SIZE: 12px;">';
                                           MAILBODY1 := MAILBODY1||''||''||'';
                                           MAILBODY1 := MAILBODY1||'';
                                           MAILBODY1 := MAILBODY1||'<P>Dear <b>' || V_EMP_NAME || ',</b> </p>';
                                           MAILBODY1 := MAILBODY1||'<p> Your Full and Final Settlement statement is ready for your review and was released for review on 
                                                                        '''||sgPUB_DATE||'''. Please login to portal and accept Full & Final Statement generated.</P>';
                                           MAILBODY1 := MAILBODY1||'<p> Link: <b> https://onex.osourceglobal.com/ABGESS/ </b> </P>';
                                           MAILBODY1 := MAILBODY1||'<p> Company Code:  <b> '|| vCOMPDISPCODE1 || ' </b> </P>';
                                           MAILBODY1 := MAILBODY1||'<p> User Name:  <b> '|| vUserName || ' </b> </P>';
                                           
                                           MAILBODY1 := MAILBODY1||'<p> We would like a confirmation from your end by clicking the “Accept” button
                                                                        if you are satisfied with the payment details. In case you need a correction,
                                                                        you can click “ Reject” and mention the details of correction required in the Remarks section.</P>';
--                                                                         
--                                           MAILBODY1 := MAILBODY1||'<p> Non-confirmation of the Full & Final settlement with 5 days of 
--                                                                        receipt of the email will be construed as a deemed acceptance</P>';
                    
                                           MAILBODY1 := MAILBODY1||'<p> Full and Final Settlement will be considered as auto approved if not accepted within 5 days from Release Date. </P>';
                    
                                           MAILBODY1 := MAILBODY1||'<p> Note: This is a system generated email from an unmonitored mailbox. </P>';
                                           --MAILBODY1 := MAILBODY1||'<p> Link: <b> https://cs.osourceindia.com/ABGESS_UAT/ </b> </P>';
                    
                                           MAILBODY1 := MAILBODY1||'<P><br>Best Regards,</P>';
                                           MAILBODY1 := MAILBODY1||'<P><b>Payroll Team - Osource</b></P>';
                                           MAILBODY1 := MAILBODY1||'</BODY></HTML>';
                                           
                                           PRO_SEND_MAIL_NEW('payroll@osourceindia.com' ,v_Mailid,SUBJECT,MAILBODY1,NULL,NULL);
                                           PRO_DATE_REMINDER(pComp_Aid,pEmp_Aid,vNoOfDays);
                                           INSERT INTO OSO VALUES(MAILBODY1||'-'||'3');
                                           COMMIT;
                                           
                                           INSERT INTO OSO VALUES(vNoOfDays);
                                           COMMIT;
                           ELSIF vNoOfDays>=5  THEN /* ADD BY SAROJ KUMAR GIRI  Don't change*/ 
                           
                                 SUBJECT:='Full and Final Statement generated for  '||V_EMP_NAME||'  ('||PoornataID||')';   
                                           
                                           MAILBODY1 := MAILBODY1||'<html><BODY>' || '<FONT style="FONT-FAMILY: arial; FONT-SIZE: 12px;">';
                                           MAILBODY1 := MAILBODY1||''||''||'';
                                           MAILBODY1 := MAILBODY1||'';
                                           MAILBODY1 := MAILBODY1||'<P>Dear <b>' || V_EMP_NAME || ',</b> </p>';
                                           MAILBODY1 := MAILBODY1||'<p> Your Full and Final Settlement statement was released for review on '''||sgPUB_DATE||'''.</P>';
--                                           MAILBODY1 := MAILBODY1||'<p> The employee had not responded to the F&F uploaded on to the portal.  
--                                                                        As per process the F&F is auto approved post sending scheduled reminders. </P>';
                                           --MAILBODY1 := MAILBODY1||'<p> Link: <b> https://onex.osourceglobal.com/ABGESS/ </b> </P>';
                                           --MAILBODY1 := MAILBODY1||'<p> User ID:  <b> '|| vUserName || ' </b> </P>';
                                           
                                           --MAILBODY1 := MAILBODY1||'<p> We would like a confirmation from your end by clicking the 
                                              --                          “confirm” button below and if you are satisfied with the payment details.
                                              --                           In case you feel a correction, if required, you can click “ Need correction” 
                                              --                           and mention the details of correction required in the Remarks section.</P>';
                                                                         
                                           --MAILBODY1 := MAILBODY1||'<p> Non-confirmation of the Full & Final settlement with 5 days of 
                                             --                           receipt of the email will be construed as a deemed acceptance</P>';
                    
                                           --MAILBODY1 := MAILBODY1||'<p> I would like to authorize my employer to credit the Fnull dues to my account.
                                             --                           In case the  F&F is a recovery, I will transfer the amount within 7 days 
                                               --                         to the account mentioned below. </P>';
                    
                                           MAILBODY1 := MAILBODY1||'<p> Since you did not accept Full and Final Settlement within 5 days from Release Date, it is considered as auto approved. </P>';
                                           MAILBODY1 := MAILBODY1||'<p> Note: This is a system generated email from an unmonitored mailbox. </P>';
                                           --MAILBODY1 := MAILBODY1||'<p> Link: <b> https://cs.osourceindia.com/ABGESS_UAT/ </b> </P>';
                    
                                           MAILBODY1 := MAILBODY1||'<P><br>Best Regards,</P>';
                                           MAILBODY1 := MAILBODY1||'<P><b>Payroll Team - Osource</b></P>';
                                           MAILBODY1 := MAILBODY1||'</BODY></HTML>';
                                           
                                           PRO_SEND_MAIL_NEW('payroll@osourceindia.com' ,v_Mailidcc,SUBJECT,MAILBODY1,v_Mailid,'Kamlakar.Ambre@osourceindia.com');
                                           PRO_DATE_REMINDER(pComp_Aid,pEmp_Aid,vNoOfDays); 
                                           INSERT INTO OSO VALUES(MAILBODY1||'-'||'4');
                                           COMMIT;

                                           
                           END IF;
                      END IF;
                  END IF;
                  
END PRO_MAIL_REMINDER_new;

/

SHOW ERROR;