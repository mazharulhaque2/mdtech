declare
    v_question_sn question.question_sn%type;
    v_question_response_code question_response.question_response_code%type;
    v_question_categ_code list_question_categ.question_categ_code%type := '99999';
  BEGIN
    for i in (select 'BMEDH' question_categ_code,'1039' question_code,1 order_num,'CBX' response_code,'TDIS' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Thyroid deficiency' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual
              --
              order by question_categ_code,question_code,order_num
              )
    loop
      v_question_sn := list_trans_pkg.qtn_sn(i.question_categ_code,i.question_code);
      --
        if v_question_categ_code <> i.question_categ_code then
          select max(question_response_code)
          into v_question_response_code
          from question_response
          where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = i.question_categ_code)
          ;
        end if;
        --
        v_question_response_code := v_question_response_code + 1;
        v_question_categ_code := i.question_categ_code;
        --
        begin
          INSERT INTO question_response (QUESTION_RESPONSE_CODE
                                        ,QUESTION_SN
                                        ,RESPONSE_CODE
                                        ,SCORE_VALUE
                                        ,order_num
                                        ,trigger_further_question_flag
                                        ,trigger_further_categ_flag
                                        ,triggered_question_categ_code
                                        ,disease_code
                                        ,symptom_code
                                        ,risk_factor_code
                                        ,disease_level_code
                                        ,em_name_code
                                        )
                                  VALUES(v_question_response_code
                                        ,v_question_sn
                                        ,i.RESPONSE_CODE
                                        ,i.SCORE_VALUE
                                        ,i.order_num
                                        ,i.trigger_further_question_flag
                                        ,i.trigger_further_categ_flag
                                        ,i.triggered_question_categ_code
                                        ,i.disease_code
                                        ,i.symptom_code
                                        ,i.risk_factor_code
                                        ,i.disease_level_code
                                        ,i.em_name_code
                                        );
        exception 
          when others then
            null;
        end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
/