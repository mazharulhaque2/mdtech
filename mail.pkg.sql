create or replace package mail_pkg is
  PROCEDURE send_mail                 (p_to        IN VARCHAR2,
                                       p_cc        IN VARCHAR2 DEFAULT NULL,
                                       p_bcc       IN VARCHAR2 DEFAULT NULL,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_msg_type  IN VARCHAR2,
                                       p_msg       IN VARCHAR2,
                                       p_attach_name IN VARCHAR2 DEFAULT NULL,
                                       p_attach_mime IN VARCHAR2 DEFAULT NULL,
                                       p_attach_blob IN BLOB DEFAULT NULL,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25);
  --
  PROCEDURE send_mail                 (p_to        IN VARCHAR2,
                                       p_cc        IN VARCHAR2 DEFAULT NULL,
                                       p_bcc       IN VARCHAR2 DEFAULT NULL,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_msg_type  IN VARCHAR2,
                                       p_msg       IN VARCHAR2,
                                       p_attach_name IN VARCHAR2 DEFAULT NULL,
                                       p_attach_mime IN VARCHAR2 DEFAULT NULL, --'text/plan' 'image/gif'
                                       p_attach_clob IN CLOB DEFAULT NULL,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25);
  --                                       
  PROCEDURE send_mail                 (p_to        IN VARCHAR2,
                                       p_cc        IN VARCHAR2 DEFAULT NULL,
                                       p_bcc       IN VARCHAR2 DEFAULT NULL,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_html_msg  in clob,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25);
  --                                       
  function get_htp_html_msg   (p_title in varchar2
                          ,p_hdr_msg in varchar2
                          ,p_text_msg in varchar2
                          ,p_img_mime in varchar2 default null
                          ,p_img in blob default null
                          ,p_img_from_file in varchar2 default 'N'
                          ,p_img_file_path varchar2 default null
                          ,p_img_align in varchar2 default null
                          ,p_img_alt in varchar2 default null
                          ) return clob;
  --
  PROCEDURE process_recipients  (p_mail_conn IN OUT UTL_SMTP.connection
                                ,p_list      IN     VARCHAR2);
  --
  function user_email_url (p_application_code in list_application.application_code%type
                          ,p_key_1 in varchar2 default null
                          ,p_key_2 in varchar2 default null
                          ,p_key_3 in varchar2 default null
                          ) return varchar2;
end mail_pkg;
/
show errors
--
create or replace package body mail_pkg is
  function user_email_url (p_application_code in list_application.application_code%type
                          ,p_key_1 in varchar2 default null
                          ,p_key_2 in varchar2 default null
                          ,p_key_3 in varchar2 default null
                          ) return varchar2
  is
    v_db_name varchar2(30) := upper(sys_context('userenv','db_name'));
    v_url varchar2(2000);
  begin
    if v_db_name = 'APPSPROD' then
      if p_application_code = 'CPMT' then
        v_url := 'https://www.cryptomyte.com/#/member/reset/key';
      end if;
    elsif v_db_name = 'APPSDEV' then
      if p_application_code = 'CPMT' then
        v_url := 'https://cryptomyte.pamdas.com/#/member/reset/key';
      end if;
    elsif v_db_name = 'ORCL' then
      if p_application_code = 'CPMT' then
        v_url := 'http://127.0.0.1:34931/#/member/reset/key';
      end if;
    end if;
    --
    if p_key_1 is not null then
      v_url := v_url||'/'||p_key_1;
    end if;
    --
    if p_key_2 is not null then
      v_url := v_url||'/'||p_key_2;
    end if;
    --
    if p_key_3 is not null then
      v_url := v_url||'/'||p_key_3;
    end if;
    return v_url;
  end user_email_url;
  --
  PROCEDURE process_recipients  (p_mail_conn IN OUT UTL_SMTP.connection
                                ,p_list      IN     VARCHAR2)
  AS
    l_tab common_pkg.t_split_array;
  BEGIN
    IF TRIM(p_list) IS NOT NULL THEN
      l_tab := common_pkg.split_text(p_list);
      FOR i IN 1 .. l_tab.COUNT LOOP
        UTL_SMTP.rcpt(p_mail_conn, TRIM(l_tab(i)));
      END LOOP;
    END IF;
  END;
  --
  function get_htp_html_msg   (p_title in varchar2
                          ,p_hdr_msg in varchar2
                          ,p_text_msg in varchar2
                          ,p_img_mime in varchar2 default null
                          ,p_img in blob default null
                          ,p_img_from_file in varchar2 default 'N'
                          ,p_img_file_path varchar2 default null
                          ,p_img_align in varchar2 default null
                          ,p_img_alt in varchar2 default null
                          ) return clob
  is
    l_thePage       htp.htbuf_arr;
    l_lines         NUMBER DEFAULT 99999999;
    g_clob             CLOB;
    param_val   owa.vc_arr;
    v_img_url   varchar2(32767);
  BEGIN
    if owa.num_cgi_vars is null then
      param_val (1) := 1;
      owa.init_cgi_env (param_val);
    end if;
    --
    htp.p('<!DOCTYPE html>'); --print the exact word
    HTP.HTMLOPEN;           -- generates <HTML>
    HTP.HEADOPEN;           -- generates <HEAD>
    HTP.TITLE(p_title);     -- generates <TITLE>Hello</TITLE>
    HTP.HEADCLOSE;          -- generates </HEAD>
    HTP.BODYOPEN;           -- generates <BODY>
    HTP.HEADER(1, p_hdr_msg); -- generates <H1>Hello</H1>
    if p_img_mime is not null then
      if p_img_from_file = 'Y' then
        v_img_url := p_img_file_path;
      else
        v_img_url := common_pkg.return_img_data_url(p_img,p_img_mime);
      end if;
      htp.img(v_img_url,p_img_align,p_img_alt);
    end if;
    htp.br;
    htp.br;
    htp.br;
    htp.p('<p>');
    htp.p(p_text_msg);
    htp.p('</p>');
    htp.print;
    HTP.BODYCLOSE;          -- generates </BODY>
    HTP.HTMLCLOSE;          -- generates </HTML>
    --    
    owa.get_page( l_thePage, l_lines );
    FOR i IN 1 .. l_lines LOOP
      IF (i=1) THEN
        g_clob := l_thePage(i);
      else
        dbms_lob.writeappend( g_clob, LENGTH(l_thePage(i)), l_thePage(i));
      end if;
    END LOOP;
    return g_clob;
  end get_htp_html_msg;
  --
  PROCEDURE send_mail                 (p_to        IN VARCHAR2,
                                       p_cc        IN VARCHAR2 DEFAULT NULL,
                                       p_bcc       IN VARCHAR2 DEFAULT NULL,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_msg_type  IN VARCHAR2,
                                       p_msg       IN VARCHAR2,
                                       p_attach_name IN VARCHAR2 DEFAULT NULL,
                                       p_attach_mime IN VARCHAR2 DEFAULT NULL,
                                       p_attach_blob IN BLOB DEFAULT NULL,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25)
  AS
    l_mail_conn   UTL_SMTP.connection;
    l_boundary    VARCHAR2(50) := '----=*#abc1234321cba#*=';
    v_user      VARCHAR2(30) := 'admin@pamdas.com'; -- login to the SMTP server name
    v_pass      VARCHAR2(20) := 'Pamdas1'; -- login to the SMTP server password
    l_content_type varchar2(100);
    l_step        PLS_INTEGER  := 12000; -- make sure you set a multiple of 3 not higher than 24573
  BEGIN
    l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
    UTL_SMTP.helo(l_mail_conn, p_smtp_host);
    UTL_SMTP.command(l_mail_conn, 'AUTH LOGIN' ); -- the SMTP server log check
    UTL_SMTP.command(l_mail_conn,UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(v_user))));
    UTL_SMTP.command(l_mail_conn,UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(v_pass))));

    UTL_SMTP.mail(l_mail_conn, p_from);
    --will handle multiple or single receipent
    process_recipients(l_mail_conn, p_to);
    process_recipients(l_mail_conn, p_cc);
    process_recipients(l_mail_conn, p_bcc);
    --
    UTL_SMTP.open_data(l_mail_conn);
    
    --UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'To: ' || p_to || utl_tcp.crlf);
    --
    IF TRIM(p_cc) IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, 'CC: ' || REPLACE(p_cc, ',', ';') || UTL_TCP.crlf);
    END IF;
    IF TRIM(p_bcc) IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, 'BCC: ' || REPLACE(p_bcc, ',', ';') || UTL_TCP.crlf);
    END IF;
    --
    UTL_SMTP.write_data(l_mail_conn, 'From: ' || p_from || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Subject: ' || p_subject || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Reply-To: ' || p_from || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'MIME-Version: 1.0' || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: multipart/alternative; boundary="' || l_boundary || '"' || utl_tcp.crlf || utl_tcp.crlf);
    
    if upper(p_msg_type) = 'TEXT' then
      l_content_type := 'Content-Type: text/plain; charset="iso-8859-1"'|| utl_tcp.crlf || utl_tcp.crlf;
    elsif upper(p_msg_type) = 'HTML' then
      l_content_type := 'Content-Type: text/html; charset="iso-8859-1"'|| utl_tcp.crlf || utl_tcp.crlf;
    end if;
    --
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, l_content_type);
    UTL_SMTP.write_data(l_mail_conn, p_msg);
    UTL_SMTP.write_data(l_mail_conn, utl_tcp.crlf || utl_tcp.crlf);
    --
    IF p_attach_name IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_mail_conn, 'Content-Type: ' || p_attach_mime || '; name="' || p_attach_name || '"' || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_mail_conn, 'Content-Transfer-Encoding: base64' || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_mail_conn, 'Content-Disposition: attachment; filename="' || p_attach_name || '"' || UTL_TCP.crlf || UTL_TCP.crlf);
      --
      FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(p_attach_blob) - 1 )/l_step) LOOP
        UTL_SMTP.write_data(l_mail_conn, UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(DBMS_LOB.substr(p_attach_blob, l_step, i * l_step + 1))));
      END LOOP;
      --
      UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
    END IF;
    --
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || '--' || utl_tcp.crlf);
    UTL_SMTP.close_data(l_mail_conn);
  
    UTL_SMTP.quit(l_mail_conn);
  END;
  --
  PROCEDURE send_mail                 (p_to        IN VARCHAR2,
                                       p_cc        IN VARCHAR2 DEFAULT NULL,
                                       p_bcc       IN VARCHAR2 DEFAULT NULL,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_msg_type  IN VARCHAR2,
                                       p_msg       IN VARCHAR2,
                                       p_attach_name IN VARCHAR2 DEFAULT NULL,
                                       p_attach_mime IN VARCHAR2 DEFAULT NULL,
                                       p_attach_clob IN CLOB DEFAULT NULL,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25)
  AS
    l_mail_conn   UTL_SMTP.connection;
    l_boundary    VARCHAR2(50) := '----=*#abc1234321cba#*=';
    v_user      VARCHAR2(30) := 'admin@pamdas.com'; -- login to the SMTP server name
    v_pass      VARCHAR2(20) := 'Pamdas1'; -- login to the SMTP server password
    l_content_type varchar2(100);
    l_step        PLS_INTEGER  := 12000; -- make sure you set a multiple of 3 not higher than 24573
  BEGIN
    l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
    UTL_SMTP.helo(l_mail_conn, p_smtp_host);
    UTL_SMTP.command(l_mail_conn, 'AUTH LOGIN' ); -- the SMTP server log check
    UTL_SMTP.command(l_mail_conn,UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(v_user))));
    UTL_SMTP.command(l_mail_conn,UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(v_pass))));

    UTL_SMTP.mail(l_mail_conn, p_from);
    --will handle multiple or single receipent
    process_recipients(l_mail_conn, p_to);
    process_recipients(l_mail_conn, p_cc);
    process_recipients(l_mail_conn, p_bcc);
    --  
    UTL_SMTP.open_data(l_mail_conn);
    
    --UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'To: ' || p_to || utl_tcp.crlf);
    --
    IF TRIM(p_cc) IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, 'CC: ' || REPLACE(p_cc, ',', ';') || UTL_TCP.crlf);
    END IF;
    IF TRIM(p_bcc) IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, 'BCC: ' || REPLACE(p_bcc, ',', ';') || UTL_TCP.crlf);
    END IF;
    --
    UTL_SMTP.write_data(l_mail_conn, 'From: ' || p_from || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Subject: ' || p_subject || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Reply-To: ' || p_from || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'MIME-Version: 1.0' || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: multipart/alternative; boundary="' || l_boundary || '"' || utl_tcp.crlf || utl_tcp.crlf);
    
    if upper(p_msg_type) = 'TEXT' then
      l_content_type := 'Content-Type: text/plain; charset="iso-8859-1"'|| utl_tcp.crlf || utl_tcp.crlf;
    elsif upper(p_msg_type) = 'HTML' then
      l_content_type := 'Content-Type: text/html; charset="iso-8859-1"'|| utl_tcp.crlf || utl_tcp.crlf;
    end if;
    --
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || utl_tcp.crlf);
    UTL_SMTP.write_data(l_mail_conn, l_content_type);
    UTL_SMTP.write_data(l_mail_conn, p_msg);
    UTL_SMTP.write_data(l_mail_conn, utl_tcp.crlf || utl_tcp.crlf);
    --
    IF p_attach_name IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_mail_conn, 'Content-Type: ' || p_attach_mime || '; name="' || p_attach_name || '"' || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_mail_conn, 'Content-Disposition: attachment; filename="' || p_attach_name || '"' || UTL_TCP.crlf || UTL_TCP.crlf);
      --
      FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(p_attach_clob) - 1 )/l_step) LOOP
        UTL_SMTP.write_data(l_mail_conn, DBMS_LOB.substr(p_attach_clob, l_step, i * l_step + 1));
      END LOOP;
      --
      UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
    END IF;
    --
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || '--' || utl_tcp.crlf);
    UTL_SMTP.close_data(l_mail_conn);
  
    UTL_SMTP.quit(l_mail_conn);
  END;
  --
  PROCEDURE send_mail                 (p_to        IN VARCHAR2,
                                       p_cc        IN VARCHAR2 DEFAULT NULL,
                                       p_bcc       IN VARCHAR2 DEFAULT NULL,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_html_msg  in clob,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25)
  AS
    l_mail_conn   UTL_SMTP.connection;
    l_boundary    varchar2(50) := '----=*#abc1234321cba#*=';
    v_user        varchar2(30) := 'admin@pamdas.com'; -- login to the SMTP server name --'admin@pamdas.com' --admin@cryptomyte.com
    v_pass        varchar2(20) := 'Pamdas1'; -- login to the SMTP server password --'Pamdas1'--Cryptomyte1
    l_offset      number;
    l_ammount     number;
    l_body_html   clob := empty_clob;     --This LOB will be the email message
    l_temp        varchar2 (32767) default null;
  BEGIN
    l_mail_conn := utl_smtp.open_connection( p_smtp_host, p_smtp_port );
    utl_smtp.helo( l_mail_conn, p_smtp_host );
    UTL_SMTP.command(l_mail_conn, 'AUTH LOGIN' ); -- the SMTP server log check
    UTL_SMTP.command(l_mail_conn,UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(v_user))));
    UTL_SMTP.command(l_mail_conn,UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(v_pass))));
    utl_smtp.mail( l_mail_conn, p_from );
    --will handle multiple or single receipent
    process_recipients(l_mail_conn, p_to);
    process_recipients(l_mail_conn, p_cc);
    process_recipients(l_mail_conn, p_bcc);
    --  
    --l_temp := l_temp || 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS')|| utl_tcp.crlf;
    l_temp := l_temp || 'MIME-Version: 1.0' ||  utl_tcp.crlf;
    l_temp := l_temp || 'To: ' || p_to || utl_tcp.crlf;
    --
    IF TRIM(p_cc) IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, 'CC: ' || REPLACE(p_cc, ',', ';') || UTL_TCP.crlf);
    END IF;
    IF TRIM(p_bcc) IS NOT NULL THEN
      UTL_SMTP.write_data(l_mail_conn, 'BCC: ' || REPLACE(p_bcc, ',', ';') || UTL_TCP.crlf);
    END IF;
    --
    l_temp := l_temp || 'From: ' || p_from || utl_tcp.crlf;
    l_temp := l_temp || 'Subject: ' || p_subject || utl_tcp.crlf;
    l_temp := l_temp || 'Reply-To: ' || p_from ||  utl_tcp.crlf;
    l_temp := l_temp || 'Content-Type: multipart/alternative; boundary=' || chr(34) || l_boundary ||  chr(34) || utl_tcp.crlf;

    ----------------------------------------------------
    -- Write the headers
    dbms_lob.createtemporary( l_body_html, false, 10 );
    dbms_lob.write(l_body_html,length(l_temp),1,l_temp);
    ----------------------------------------------------
    -- Write the HTML boundary
    l_temp   := utl_tcp.crlf||utl_tcp.crlf||'--' || l_boundary || utl_tcp.crlf;
    l_temp   := l_temp || 'content-type: text/html; charset="iso-8859-1' ||utl_tcp.crlf || utl_tcp.crlf;
    l_offset := dbms_lob.getlength(l_body_html) + 1;
    dbms_lob.write(l_body_html,length(l_temp),l_offset,l_temp);
    ----------------------------------------------------
    -- Write the HTML portion of the message
    l_offset := dbms_lob.getlength(l_body_html) + 1;
    dbms_lob.write(l_body_html,length(p_html_msg),l_offset,p_html_msg);
    ----------------------------------------------------
    -- Write the final html boundary
    l_temp   := utl_tcp.crlf || '--' ||  l_boundary || '--' || chr(13);
    l_offset := dbms_lob.getlength(l_body_html) + 1;
    dbms_lob.write(l_body_html,length(l_temp),l_offset,l_temp);
    ----------------------------------------------------
    -- Send the email in 1900 byte chunks to UTL_SMTP
    l_offset  := 1;
    l_ammount := 1900;
    utl_smtp.open_data(l_mail_conn);
    while l_offset < dbms_lob.getlength(l_body_html) loop
        utl_smtp.write_data(l_mail_conn,dbms_lob.substr(l_body_html,l_ammount,l_offset));
        l_offset  := l_offset + l_ammount ;
        l_ammount := least(1900,dbms_lob.getlength(l_body_html) - l_ammount);
    end loop;
    utl_smtp.close_data(l_mail_conn);
    utl_smtp.quit( l_mail_conn );
    dbms_lob.freetemporary(l_body_html);        
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20101,SQLERRM);
  END;
end mail_pkg;
/
show errors