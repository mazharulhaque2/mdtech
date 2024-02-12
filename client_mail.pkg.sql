CREATE OR REPLACE PACKAGE client_mail_pkg IS
  v_pkg_name    varchar2 (30) := upper('client_mail_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  --
  procedure heg_mail  (p_from in varchar2
                      ,p_msg_type in varchar2
                      ,p_name in varchar2
                      ,p_phone in varchar2
                      ,p_zipcode in varchar2 default null
                      ,p_msg in varchar2 default null
                      ,p_attachment_name in varchar2 default null
                      ,p_attachment in blob default null
                      ,p_status out varchar2
                      );
END client_mail_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY client_mail_pkg IS
  --Email proc for health enrollment group
  procedure heg_mail  (p_from in varchar2
                      ,p_msg_type in varchar2
                      ,p_name in varchar2
                      ,p_phone in varchar2
                      ,p_zipcode in varchar2 default null
                      ,p_msg in varchar2 default null
                      ,p_attachment_name in varchar2 default null
                      ,p_attachment in blob default null
                      ,p_status out varchar2
                      )
  is
    v_msg varchar2(1000) := substr(trim(p_msg),1,1000);
    v_html_msg varchar2(2000);
    v_title varchar2(200);
    v_h1 varchar2(200);
    v_p1 varchar2(200);
    v_status_msg varchar2(200);
    v_to varchar2(100) := 'mazharul.haque2@gmail.com'; --admin@healthenrollgroup.com
  begin
    v_proc_name := upper('heg_mail');
    v_input_str := 'p_msg_type: '||p_msg_type||'-'||'p_name: '||p_name||'-'||'p_phone: '||p_phone||'-'||'p_email: '||p_from||'-'||'p_zipcode: '||p_zipcode||'-'||'p_msg: '||p_msg;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    if p_msg_type = 'SPLN' then
      v_title := 'Shop Plans';
      v_h1 := 'Shoping Plans Request';
      v_p1 := 'shop plans';
      v_status_msg := 'Your request has been delivered.';
    elsif p_msg_type = 'CNCT' then
      v_title := 'Contact me';
      v_h1 := 'Contact Request';
      v_p1 := 'request contact';
      v_status_msg := 'Your request has been delivered.';
    elsif p_msg_type = 'CRER' then
      v_title := 'Career';
      v_h1 := 'Career Request';
      v_p1 := 'join healthenrollmentgroup';
      v_status_msg := 'Your request has been delivered.';
    end if;
    --
    v_html_msg := '
              <!DOCTYPE html>
              <html>
              <head>
              <title>'||v_title||'</title>
              </head>
              <body>              
              <h1>'||v_h1||'</h1>
              <p>Hello,</p>
              <p>I like to '||v_p1||'. Below is my contact information:</p>
              <p>Name: '||p_name||'</p>
              <p>
              Email:
              <a href="mailto:'||p_from||'?Subject=Hello" target="_top">'||p_from||'</a>
              </p>
              <p>Phone: '||p_phone||'</p>';
              
      if p_zipcode is not null then
        v_html_msg := v_html_msg||'<p>Zipcode: '||p_zipcode||'</p>';
      end if;
      --
      if v_msg is not null then
        v_html_msg := v_html_msg||'<p>'||v_msg||'</p>';
      end if;
      --
      v_html_msg := v_html_msg||'<p>Sincerely,</p>
              <p>'||p_name||'</p>              
              </body>
              </html>';
      --
      if p_attachment_name is not null then
        if common_pkg.return_file_type(p_attachment_name) in ('PDF','TXT','DOC','DOCX') then
          mail_pkg.send_mail(p_to        => v_to
            ,p_from      => p_from
            ,p_subject   => v_title
            ,p_msg_type  => 'HTML'
            ,p_msg     =>  v_html_msg
            ,p_attach_name => p_attachment_name
            ,p_attach_mime => common_pkg.return_file_content_type(p_attachment_name)
            ,p_attach_blob => p_attachment
            ,p_smtp_host => 'webmail.pamdas.com'
            );
          p_status := v_status_msg;
        else
          p_status := 'Attach file type needs to be either pdf, txt, doc or docx. Please check the file and resubmit.';
        end if;
      else
        mail_pkg.send_mail(p_to        => v_to
            ,p_from      => p_from
            ,p_subject   => v_title
            ,p_msg_type  => 'HTML'
            ,p_msg     =>  v_html_msg
            ,p_attach_name => null
            ,p_attach_mime => null
            ,p_attach_blob => null
            ,p_smtp_host => 'webmail.pamdas.com'
            );
         p_status := v_status_msg;
      end if;
  exception
    when others then
      p_status := 'Technical Error. Please contact customer support.';
      v_err_msg := SUBSTR (SQLERRM,1,1000);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
  end heg_mail;  
END client_mail_pkg;
/
SHOW ERRORS
