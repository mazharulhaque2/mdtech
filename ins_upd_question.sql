declare
    v_parent_question_sn question.parent_question_sn%type;
    v_question_categ_code list_question_categ.question_categ_code%type;
    v_question_sn question.question_sn%type;
  BEGIN
    --v_proc_name := upper('load_question');
    for i in (select 'BMEDH' question_categ_code,'1039' question_code,18.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Thyroid disorder (Hyperthyroidism)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual
              --
              order by question_categ_code,order_num asc
              )
    loop
      if i.query_type = 'QTN' then
        if i.parent_question_code is not null then
          v_question_categ_code := i.question_categ_code;
          v_parent_question_sn := list_trans_pkg.qtn_sn(v_question_categ_code,i.parent_question_code);
        else
          v_parent_question_sn := null;
        end if;
        --
        begin
          INSERT INTO question  (QUESTION_SN
                                ,QUESTION_CATEG_CODE
                                ,QUESTION_CODE
                                ,question_sub_categ_code
                                ,ORDER_NUM
                                ,CONDITIONAL_QUESTION_FLAG
                                ,PARENT_QUESTION_SN
                                ,triggered_response_code
                                ,triggered_question_categ_code
                                ,triggered_question_code
                                ,triggered_other_code
                                )
                        VALUES (QUESTION_SNG.nextval
                                ,i.QUESTION_CATEG_CODE
                                ,i.QUESTION_CODE
                                ,i.question_sub_categ_code
                                ,i.ORDER_NUM
                                ,i.CONDITIONAL_QUESTION_FLAG
                                ,v_parent_question_sn
                                ,i.triggered_response_code
                                ,i.triggered_question_categ_code
                                ,i.triggered_question_code
                                ,i.triggered_other_code
                                );
        exception 
          when dup_val_on_index then
            update question
            set ORDER_NUM = i.ORDER_NUM
                ,CONDITIONAL_QUESTION_FLAG = i.CONDITIONAL_QUESTION_FLAG
                ,PARENT_QUESTION_SN = v_parent_question_sn
                ,question_sub_categ_code = i.question_sub_categ_code
                ,triggered_response_code = i.triggered_response_code
                ,triggered_question_categ_code = i.triggered_question_categ_code
                ,triggered_question_code = i.triggered_question_code
                ,triggered_other_code = i.triggered_other_code
            where QUESTION_CATEG_CODE = i.QUESTION_CATEG_CODE
            and question_code = i.question_code
            ;
        end;
        begin
          v_question_sn := list_trans_pkg.qtn_sn(i.question_categ_code,i.question_code);
          INSERT INTO question_lang (question_lang_SN
                                          ,question_sn
                                          ,LANG_CODE
                                          ,SHORT_DESCR
                                          ,LONG_DESCR
                                          )
          VALUES (question_lang_SNG.nextval
                  ,v_question_sn
                  ,i.LANG_CODE
                  ,i.SHORT_DESCR
                  ,i.LONG_DESCR
                 );
        exception 
          when dup_val_on_index then
            update question_lang
            set SHORT_DESCR = i.SHORT_DESCR
                ,LONG_DESCR = i.LONG_DESCR
            where question_sn = v_question_sn
            and LANG_CODE = i.LANG_CODE
            ;
        end;
      elsif i.query_type = 'SCR' then
        --for score
        null;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
/