set define off
CREATE OR REPLACE PACKAGE web_services_pkg
AS
  /*--
  Purpose:    PL/SQL wrapper package for web service calls using UTL_HTTP pkg  
  */
 
  FUNCTION get_clob_from_http_post(p_url    IN VARCHAR2)
  RETURN CLOB;
  -- translate a piece of text
  FUNCTION get_translated_text(
      p_text      IN VARCHAR2,
      p_to_lang   IN VARCHAR2,
      p_from_lang IN VARCHAR2 := NULL,
      p_use_cache IN VARCHAR2 := 'YES')
    RETURN VARCHAR2;
END web_services_pkg;
/
show errors
CREATE OR REPLACE PACKAGE body web_services_pkg
AS
  FUNCTION get_clob_from_http_post(p_url    IN VARCHAR2)
    RETURN CLOB
  AS
    l_request utl_http.req;
    l_response utl_http.resp;
    l_buffer VARCHAR2(32767);
    l_returnvalue CLOB := ' ';
  BEGIN
    /*
    Purpose:    This function takes the service url as input parameter and returns
                the response in a CLOB
    */
    l_request := utl_http.begin_request (p_url);
    DBMS_OUTPUT.PUT_LINE('requested_url is '||p_url);
    l_response := utl_http.get_response (l_request);
    IF l_response.status_code = utl_http.http_ok THEN
      BEGIN
        LOOP
          utl_http.read_text (l_response, l_buffer);
          dbms_lob.writeappend (l_returnvalue, LENGTH(l_buffer), l_buffer);
        END LOOP;
      EXCEPTION
      WHEN utl_http.end_of_body THEN
        NULL;
      END;
    END IF;
    utl_http.end_response (l_response);
    RETURN l_returnvalue;
  END get_clob_from_http_post;
  --
  FUNCTION get_translated_text(
      p_text      IN VARCHAR2,
      p_to_lang   IN VARCHAR2,
      p_from_lang IN VARCHAR2 := NULL,
      p_use_cache IN VARCHAR2 := 'YES')
    RETURN VARCHAR2
    /*Purpose - To translate the given text from one language to other.
                See https://cloud.google.com/translate/v2/using_rest for 
                documentation
    */
  AS
    l_response CLOB;
    l_start_pos pls_integer;
    l_end_pos pls_integer;
    l_returnvalue VARCHAR2(32000) := NULL;
    l_service_url VARCHAR2(2000) := 'https://www.googleapis.com/language/translate/v2?key=';
    l_api_key     CONSTANT VARCHAR2(255) := 'AIzaSyBJ0fWIOcNyTi0X7Z3LVYYa9x-6V5s77i8';--Google API Key
    --
    l_max_text_size   CONSTANT pls_integer   := 32000; -- can be increased up towards 32k, the cache name size (below) must be increased accordingly
  BEGIN
    /*
    Purpose:    This is the main function in this package which translates a given
                piece of text from the given from language to to language and returns
                the string.
    Remarks:    if the "from" language is left blank, Google Translate will attempt
                to autodetect the language
    */
    IF TRIM(p_text)   IS NOT NULL THEN
          
          l_service_url := l_service_url||
                           l_api_key||
                           '&source=' || p_from_lang ||
                           '&target=' || p_to_lang ||
                           '&q='||utl_url.escape (SUBSTR(p_text,1,l_max_text_size), false, 'UTF8');
          
          --Pass the input service url and get the response into CLOB.Google translate
          --API returns the output in the JSON format.
          l_response       := get_clob_from_http_post (l_service_url);
          
          --We have the translated text in CLOB(JSON format).Parse it to get the
          --translated string value into a string variable.
        
          IF l_response    IS NOT NULL THEN
            l_start_pos    := instr(l_response, '"translatedText": "');
            l_start_pos    := l_start_pos + 19;
            l_end_pos      := instr(l_response, '"', l_start_pos);
            l_returnvalue  := SUBSTR(l_response, l_start_pos, l_end_pos - l_start_pos);          
            DBMS_OUTPUT.PUT_LINE('l_returnvalue is '||l_returnvalue);            
          END IF;
        --
        --
    END IF;
    RETURN l_returnvalue;
  END get_translated_text;
  --
END web_services_pkg;
/
show errors