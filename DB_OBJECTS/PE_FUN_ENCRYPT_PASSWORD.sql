create or replace FUNCTION              "PE_FUN_ENCRYPT_PASSWORD" (PString VARCHAR2) RETURN VARCHAR IS
	VReturnString VARCHAR2(100);
	I NUMBER(3);
BEGIN
   FOR I IN 1 .. LENGTH(PString) LOOP
   	   IF ASCII(SUBSTR(PString,I,1))>=251 THEN
   	   	   VReturnString := VReturnString || CHR(1);
	   ELSE
	   	   VReturnString := VReturnString || CHR(ASCII(SUBSTR(PString,I,1))+5);
	   END IF;
   END LOOP;
   RETURN VReturnString;
END;