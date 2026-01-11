create or replace FUNCTION                    "PASSWORDENCRYPT_DECRYPTS" (p_word IN VARCHAR2)
    RETURN VARCHAR2
    IS
    v_num NUMBER(5);
    v_word VARCHAR2(20);
    v_len NUMBER(5);
    v_cnt NUMBER(2);
    v_chr VARCHAR2(1);
    v_new VARCHAR2(20);
    BEGIN

     v_len := LENGTH(p_word);
     FOR v_cnt IN 1..v_len LOOP
      v_chr := SUBSTR(p_word,v_cnt,1);
      v_num := 256-ASCII(v_chr);
      v_word := CHR(v_num);
      v_new := CONCAT(v_new,v_word);
     END LOOP;

     RETURN v_new;
    END PasswordEncrypt_DecryptS; 
 
 
 
 
 
 
 
 
 
 
 
 
 