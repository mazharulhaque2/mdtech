CREATE OR REPLACE PACKAGE global_type_pkg IS
  TYPE t_question_response_code_tbl IS TABLE OF question_response.question_response_code%type INDEX BY PLS_INTEGER;
END global_type_pkg;
/
SHOW ERRORS