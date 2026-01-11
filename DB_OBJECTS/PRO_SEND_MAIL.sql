create or replace PROCEDURE PRO_SEND_MAIL(Sender in varchar2,Recipient varchar2,Subj in varchar2,BODY in varchar2,cc_recipient in varchar2)
IS

  Connection UTL_SMTP.connection ;
  v_reply UTL_SMTP.REPLY ;
  Message VARCHAR2(32767) ;
  crlf VARCHAR2(2):=chr(13)||chr(10);
  
BEGIN
DELETE FROM VAI;
INSERT INTO VAI VALUES(BODY);
COMMIT;

    Connection := UTL_SMTP.open_connection('pop.osourceindia.com',7725) ;
    v_reply := UTL_SMTP.HELO(Connection,'pop.osourceindia.com') ;
    
    utl_smtp.command( CONNECTION, 'AUTH LOGIN');
    utl_smtp.command( CONNECTION, utl_raw.cast_to_varchar2( utl_encode.base64_encode( utl_raw.cast_to_raw( 'osource.pip@osourceindia.com' ))) );
    utl_smtp.command( CONNECTION, utl_raw.cast_to_varchar2( utl_encode.base64_encode( utl_raw.cast_to_raw(  'Secure!@#2017' ))) );
    
    v_reply := UTL_SMTP.MAIL(Connection,Sender);
    v_reply := UTL_SMTP.rcpt(Connection,Recipient);
    
    IF cc_recipient is not null then
      UTL_SMTP.rcpt(Connection,cc_recipient);
    END IF;
    
    Message :='From: '||sender||crlf||
               'To: '||recipient||crlf||
               'Cc: '||cc_recipient||crlf||
               'Subject: '||subj||crlf||
               ''||crlf||
               BODY;
    
    UTL_SMTP.DATA(Connection,'MIME-Version: 1.0'||crlf||'Content-type: text/html' || crlf||Message);
    UTL_SMTP.QUIT(Connection);
    
    Exception
    when utl_smtp.invalid_operation then DBMS_OUTPUT.PUT_LINE ('INVALID OPERATION');
    WHEN UTL_SMTP.TRANSIENT_ERROR THEN DBMS_OUTPUT.PUT_LINE ('TEMP EMAIL ISSUE');
    WHEN UTL_SMTP.PERMANENT_ERROR THEN DBMS_OUTPUT.PUT_LINE ('PERMANENT');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE (SQLCODE || SQLERRM);
END;