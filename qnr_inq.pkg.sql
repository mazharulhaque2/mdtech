create or replace PACKAGE qnr_inq_pkg IS
  v_pkg_name    varchar2 (30) := upper('qnr_inq_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  PROCEDURE qnr_info   (p_locale in varchar2,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_data_entry_categ_flag in list_question_categ.data_entry_categ_flag%type,p_out OUT clob);
  PROCEDURE qnr_by_categ (p_locale in varchar2,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_out OUT clob);
  PROCEDURE qnr_by_categ_patient_info (p_locale in varchar2,p_patient_prev_svc_sn in number,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_name in varchar2,p_age in number,p_gender in varchar2,p_gender_descr in varchar2,p_bmi in varchar2,p_bmi_result in varchar2,p_meds_cnt in number,p_out OUT clob);
  function qnr_response (p_question_sn in question.question_sn%type,p_question_code in question.question_code%type,p_question_descr in question_lang.short_descr%type,p_lang_code in varchar2) return json;
  function hx_qnr_by_categ (p_lang_code in varchar2,p_category_code in varchar2,p_gender in varchar2) return json_list;
  --PROCEDURE qnr_info_init (p_locale in varchar2,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_out OUT clob);
  --procedure load_g0438_json (p_lang_code in list_lang.lang_code%type default 'en');
END qnr_inq_pkg;
/
show errors
create or replace PACKAGE BODY qnr_inq_pkg IS
--  procedure load_g0438_json (p_lang_code in list_lang.lang_code%type default 'en')
--  is
--    v_out clob; --varchar2(32767);
--  begin
--    qnr_inq_pkg.qnr_info_init(p_lang_code,'G0438',v_out);
--    common_pkg.upd_appl_control_value_clob ('AWV','G0438_JSON',v_out);
--  end load_g0438_json;
--  --
--  PROCEDURE qnr_info  (p_locale in varchar2,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_out OUT clob) 
--  as
--    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
--  begin
--    if p_svc_billing_code = 'G0438' then
--      p_out := common_pkg.appl_control_value_clob('AWV','G0438_JSON');
--    end if;
--  END qnr_info;
  --
  PROCEDURE qnr_info   (p_locale in varchar2,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_data_entry_categ_flag in list_question_categ.data_entry_categ_flag%type,p_out OUT clob)
  as
    --This method will return question, question response under a category for a svc billing code
    --
    obj json;
    obj2 json;
    obj3 json;
    obj4 json;
    obj5 json;
    obj6 json;
    obj7 json;
    l_obj json_list;
    l_obj2 json_list;
    l_obj3 json_list;
    l_obj4 json_list;
    l_obj5 json_list;
    l_obj6 json_list;
    --
    obj31 json;
    obj41 json;
    obj51 json;
    l_obj21 json_list;
    l_obj31 json_list;
    l_obj41 json_list;
    --
    obj312 json;
    obj412 json;
    obj512 json;
    l_obj212 json_list;
    l_obj312 json_list;
    l_obj412 json_list;
    --
    obj311 json;
    obj411 json;
    obj511 json;
    l_obj211 json_list;
    l_obj311 json_list;
    l_obj411 json_list;
    --
    obj55 json;
    obj66 json;
    obj77 json;
    l_obj55 json_list;
    l_obj66 json_list;
    --
    obj43 json;
    obj53 json;
    l_obj33 json_list;
    l_obj43 json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --categ grp start================================================================
    l_obj := json_list(); --an empty list obj
    for i in (select distinct qcgl.question_categ_grp_code code
                    ,qcgl.short_descr descr
                    ,qcgl.long_descr
                    ,qcg.order_num
              from list_question_categ qc
                  ,question_categ_lang qcl
                  ,list_question_categ_grp qcg
                  ,question_categ_grp_lang qcgl
                  ,svc_billing_question_categ sbqc
              where qc.question_categ_code = qcl.question_categ_code
              and qcl.lang_code = v_lang_code
              and qc.question_categ_grp_code = qcg.question_categ_grp_code
              and qcg.question_categ_grp_code = qcgl.question_categ_grp_code
              and qcgl.lang_code = v_lang_code
              and qc.question_categ_code = sbqc.question_categ_code
              and sbqc.prev_svc_billing_code = p_svc_billing_code
              and qc.data_entry_categ_flag = p_data_entry_categ_flag
              and (p_question_categ_code is null or qc.question_categ_code = p_question_categ_code)
              --
              and qc.active_flag = 'Y'
              and qcl.active_flag = 'Y'
              and qcg.active_flag = 'Y'
              and qcgl.active_flag = 'Y'
              and sbqc.active_flag = 'Y'
              order by qcg.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('DESCR',i.descr);
      obj2.put('LONG_DESCR',i.long_descr);
      --categ start--------================================
      l_obj2 := json_list(); --an empty list obj
      for j in (select distinct qcl.question_categ_code code
                      ,qcl.short_descr descr
                      ,qcl.long_descr
                      ,qc.trigger_further_categ_flag
                      ,qc.child_categ_avail_flag
                      ,qc.categ_condition_descr
                      ,sbqc.order_num
                from list_question_categ qc
                    ,question_categ_lang qcl
                    ,svc_billing_question_categ sbqc
                where qc.question_categ_code = qcl.question_categ_code
                and qcl.lang_code = v_lang_code
                and qc.question_categ_code = sbqc.question_categ_code
                and sbqc.prev_svc_billing_code = p_svc_billing_code
                and qc.question_categ_grp_code = i.code
                and qc.parent_question_categ_code is null
                and qc.data_entry_categ_flag = p_data_entry_categ_flag
                and (p_question_categ_code is null or qc.question_categ_code = p_question_categ_code)
                --
                and qc.active_flag = 'Y'
                and qcl.active_flag = 'Y'
                and sbqc.active_flag = 'Y'
                order by sbqc.order_num
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('DESCR',j.descr);
        obj3.put('TRIGGER_FURTHER_CATEG',j.trigger_further_categ_flag);
        obj3.put('CHILD_CATEG_AVAIL',j.child_categ_avail_flag);
        if j.trigger_further_categ_flag = 'Y' or j.child_categ_avail_flag = 'Y' then
          --triggered categ by another categ or child categ avail start--------================================
          l_obj21 := json_list(); --an empty list obj
          for jj in (select qcl.question_categ_code code
                          ,qcl.short_descr descr
                          ,qcl.long_descr
                          ,qc.trigger_further_categ_flag
                          ,qc.child_categ_avail_flag
                          ,qc.categ_condition_descr
                    from list_question_categ qc
                        ,question_categ_lang qcl
                    where qc.question_categ_code = qcl.question_categ_code
                    and qcl.lang_code = v_lang_code
                    and qc.parent_question_categ_code = j.code
                    --
                    and qc.active_flag = 'Y'
                    and qcl.active_flag = 'Y'
                    )
          loop
            obj31 := json(); --an empty structure
            obj31.put('CODE',jj.code);
            obj31.put('DESCR',jj.descr);
            obj31.put('TRIGGER_FURTHER_CATEG',jj.trigger_further_categ_flag);
            obj31.put('CHILD_CATEG_AVAIL',jj.child_categ_avail_flag);
            if j.trigger_further_categ_flag = 'Y' then
              obj31.put('CATEG_CONDITION_DESCR',jj.categ_condition_descr);
            end if;

            if jj.child_categ_avail_flag = 'Y' then
              --child/triggered categ have child categ start===============================
              --triggered categ start--------================================
              l_obj211 := json_list(); --an empty list obj
              for jjj in (select qcl.question_categ_code code
                              ,qcl.short_descr descr
                              ,qcl.long_descr
                              ,qc.trigger_further_categ_flag
                              ,qc.child_categ_avail_flag
                        from list_question_categ qc
                            ,question_categ_lang qcl
                        where qc.question_categ_code = qcl.question_categ_code
                        and qcl.lang_code = v_lang_code
                        and qc.parent_question_categ_code = jj.code
                        --
                        and qc.active_flag = 'Y'
                        and qcl.active_flag = 'Y'
                        )
              loop
                obj311 := json(); --an empty structure
                obj311.put('CODE',jjj.code);
                obj311.put('DESCR',jjj.descr);
                obj311.put('TRIGGER_FURTHER_CATEG',jjj.trigger_further_categ_flag);
                obj311.put('CHILD_CATEG_AVAIL',jjj.child_categ_avail_flag);
                --triggered categ question start--------================================
                l_obj311 := json_list(); --an empty list obj
                for kkk in (select q.question_sn code
                                  ,ql.short_descr descr
                                  ,ql.long_descr
                                  ,q.order_num
                                  ,q.triggered_response_code
                            from question q
                                ,question_lang ql
                            where q.question_sn = ql.question_sn
                            and ql.lang_code = v_lang_code
                            and q.question_categ_code = jjj.code
                            and q.conditional_question_flag = 'N'
                            --
                            and q.active_flag = 'Y'
                            and ql.active_flag = 'Y'
                            order by q.order_num
                            )
                loop
                  obj411 := json(); --an empty structure
                  obj411.put('CODE',kkk.code);
                  obj411.put('DESCR',kkk.descr);
                  --triggered categ question response start--------================================
                  l_obj411 := json_list(); --an empty list obj
                  for lll in (select qr.question_response_code code
                                  ,rl.short_descr descr
                                  ,qr.order_num
                                  ,qr.trigger_further_question_flag
                                  ,qr.trigger_further_categ_flag
                                  ,qr.triggered_question_categ_code
                                  ,qr.response_code
                            from question_response qr
                                ,list_response r
                                ,response_lang rl
                            where qr.response_code = r.response_code
                            and r.response_code = rl.response_code
                            and rl.lang_code = v_lang_code
                            and qr.question_sn = kkk.code
                            --
                            and qr.active_flag = 'Y'
                            and r.active_flag = 'Y'
                            and rl.active_flag = 'Y'
                            order by qr.order_num
                            )
                  loop
                    obj511 := json(); --an empty structure
                    obj511.put('CODE',lll.code);
                    obj511.put('DESCR',lll.descr);
                    obj511.put('TRIGGER_FURTHER_QUESTION',lll.trigger_further_question_flag);
                    obj511.put('TRIGGER_FURTHER_CATEG',lll.trigger_further_categ_flag);
                    --
                    if lll.trigger_further_question_flag = 'Y' then
                      --triggered question start--------================================
                      l_obj55 := json_list(); --an empty list obj
                      for mm in (select q.question_sn code
                                      ,ql.short_descr descr
                                      ,ql.long_descr
                                      ,q.order_num
                                from question q
                                    ,question_lang ql
                                where q.question_sn = ql.question_sn
                                and ql.lang_code = v_lang_code
                                and q.parent_question_sn = kkk.code
                                and q.triggered_response_code = lll.response_code
                                --
                                and q.active_flag = 'Y'
                                and ql.active_flag = 'Y'
                                order by q.order_num
                                )
                      loop
                        obj66 := json(); --an empty structure
                        obj66.put('CODE',mm.code);
                        obj66.put('DESCR',mm.descr);
                        --triggered question response start--------================================
                        l_obj66 := json_list(); --an empty list obj
                        for nn in (select qr.question_response_code code
                                        ,rl.short_descr descr
                                        ,qr.order_num
                                        ,qr.trigger_further_question_flag
                                  from question_response qr
                                      ,list_response r
                                      ,response_lang rl
                                  where qr.response_code = r.response_code
                                  and r.response_code = rl.response_code
                                  and rl.lang_code = v_lang_code
                                  and qr.question_sn = mm.code
                                  --
                                  and qr.active_flag = 'Y'
                                  and r.active_flag = 'Y'
                                  and rl.active_flag = 'Y'
                                  order by qr.order_num
                                  )
                        loop
                          obj77 := json(); --an empty structure
                          obj77.put('CODE',nn.code);
                          obj77.put('DESCR',nn.descr);
                          --Append obj5 to the list
                          l_obj66.append(obj77.to_json_value);
                        end loop;
                        --
                        if json_ac.array_count(l_obj66) > 0 then
                          obj66.put('question_response', l_obj66);
                        end if;
                        --triggered question response end--------================================
                        --Append obj4 to the list
                        l_obj55.append(obj66.to_json_value);
                      end loop;
                      --
                      if json_ac.array_count(l_obj55) > 0 then
                        obj511.put('question', l_obj55);
                      end if;
                      --triggered question end--------================================
                    elsif lll.trigger_further_categ_flag = 'Y' then
                      --triggered categ start--------================================
                      l_obj212 := json_list(); --an empty list obj
                      for jj in (select qcl.question_categ_code code
                                      ,qcl.short_descr descr
                                      ,qcl.long_descr
                                      ,qc.categ_condition_descr
                                      ,qc.trigger_further_categ_flag
                                      ,qc.child_categ_avail_flag
                                from list_question_categ qc
                                    ,question_categ_lang qcl
                                where qc.question_categ_code = qcl.question_categ_code
                                and qcl.lang_code = v_lang_code
                                and qc.question_categ_code = lll.triggered_question_categ_code
                                --
                                and qc.active_flag = 'Y'
                                and qcl.active_flag = 'Y'
                                )
                      loop
                        obj312 := json(); --an empty structure
                        obj312.put('CODE',jj.code);
                        obj312.put('DESCR',jj.descr);
                        obj312.put('TRIGGER_FURTHER_CATEG',jj.trigger_further_categ_flag);
                        obj312.put('CHILD_CATEG_AVAIL',jj.child_categ_avail_flag);
                        obj312.put('CATEG_CONDITION_DESCR',jj.categ_condition_descr);
                        --triggered categ question start--------================================
                        l_obj312 := json_list(); --an empty list obj
                        for kk in (select q.question_sn code
                                        ,ql.short_descr descr
                                        ,ql.long_descr
                                        ,q.order_num
                                  from question q
                                      ,question_lang ql
                                  where q.question_sn = ql.question_sn
                                  and ql.lang_code = v_lang_code
                                  and q.question_categ_code = jj.code
                                  --
                                  and q.active_flag = 'Y'
                                  and ql.active_flag = 'Y'
                                  order by q.order_num
                                  )
                        loop
                          obj412 := json(); --an empty structure
                          obj412.put('CODE',kk.code);
                          obj412.put('DESCR',kk.descr);
                          --triggered categ question response start--------================================
                          l_obj412 := json_list(); --an empty list obj
                          for ll in (select qr.question_response_code code
                                          ,rl.short_descr descr
                                          ,qr.order_num
                                          ,qr.trigger_further_question_flag
                                          ,qr.trigger_further_categ_flag
                                          ,qr.triggered_question_categ_code
                                    from question_response qr
                                        ,list_response r
                                        ,response_lang rl
                                    where qr.response_code = r.response_code
                                    and r.response_code = rl.response_code
                                    and rl.lang_code = v_lang_code
                                    and qr.question_sn = kk.code
                                    --
                                    and qr.active_flag = 'Y'
                                    and r.active_flag = 'Y'
                                    and rl.active_flag = 'Y'
                                    order by qr.order_num
                                    )
                          loop
                            obj512 := json(); --an empty structure
                            obj512.put('CODE',ll.code);
                            obj512.put('DESCR',ll.descr);
                            obj512.put('TRIGGER_FURTHER_QUESTION',ll.trigger_further_question_flag);
                            obj512.put('TRIGGER_FURTHER_CATEG',ll.trigger_further_categ_flag);
                            --Append obj5 to the list
                            l_obj412.append(obj51.to_json_value);
                          end loop;
                          --
                          if json_ac.array_count(l_obj412) > 0 then
                            obj412.put('question_response', l_obj412);
                          end if;
                          --triggered categ question response end--------================================
                          --Append obj4 to the list
                          l_obj312.append(obj412.to_json_value);
                        end loop;
                        --
                        if json_ac.array_count(l_obj312) > 0 then
                          obj312.put('question', l_obj312);
                        end if;
                        --triggered categ question end--------================================
                        --Append obj3 to the list
                        l_obj212.append(obj312.to_json_value);
                      end loop;
                      --
                      if json_ac.array_count(l_obj212) > 0 then
                        obj511.put('categ', l_obj212);
                      end if;
                      --triggered categ end--------================================
                    end if;
                    --Append obj5 to the list
                    l_obj411.append(obj511.to_json_value);
                  end loop;
                  --
                  if json_ac.array_count(l_obj411) > 0 then
                    obj411.put('question_response', l_obj411);
                  end if;
                  --triggered categ question response end--------================================
                  --Append obj4 to the list
                  l_obj311.append(obj411.to_json_value);
                end loop;
                --
                if json_ac.array_count(l_obj311) > 0 then
                  obj311.put('question', l_obj311);
                end if;
                --triggered categ question end--------================================
                --Append obj3 to the list
                l_obj211.append(obj311.to_json_value);
              end loop;
              --
              if json_ac.array_count(l_obj211) > 0 then
                obj31.put('categ', l_obj211);
              end if;
              --=====9999999999999999999999999999999999999999999999999999
              --Check if this categ also have any questions under this========********************************************
              --***********question check begin*************************************
              --question start--------================================
              l_obj33 := json_list(); --an empty list obj
              for k3 in (select q.question_sn code
                              ,ql.short_descr descr
                              ,ql.long_descr
                              ,q.order_num
                        from question q
                            ,question_lang ql
                            ,list_question_categ qc
                        where q.question_categ_code = qc.question_categ_code
                        and q.question_sn = ql.question_sn
                        and ql.lang_code = v_lang_code
                        and qc.question_categ_code = jj.code
                        and q.conditional_question_flag = 'N'
                        and q.parent_question_sn is null
                        --
                        and q.active_flag = 'Y'
                        and ql.active_flag = 'Y'
                        and qc.active_flag = 'Y'
                        order by q.order_num
                        )
              loop
                obj43 := json(); --an empty structure
                obj43.put('CODE',k3.code);
                obj43.put('DESCR',k3.descr);
                --question response start--------================================
                l_obj43 := json_list(); --an empty list obj
                for l3 in (select qr.question_response_code code
                                ,rl.short_descr descr
                                ,qr.order_num
                                ,qr.trigger_further_question_flag
                                ,qr.trigger_further_categ_flag
                                ,qr.triggered_question_categ_code
                          from question_response qr
                              ,list_response r
                              ,response_lang rl
                          where qr.response_code = r.response_code
                          and r.response_code = rl.response_code
                          and rl.lang_code = v_lang_code
                          and qr.question_sn = k3.code
                          --
                          and qr.active_flag = 'Y'
                          and r.active_flag = 'Y'
                          and rl.active_flag = 'Y'
                          order by qr.order_num
                          )
                loop
                  obj53 := json(); --an empty structure
                  obj53.put('CODE',l3.code);
                  obj53.put('DESCR',l3.descr);
                  obj53.put('TRIGGER_FURTHER_QUESTION',l3.trigger_further_question_flag);
                  obj53.put('TRIGGER_FURTHER_CATEG',l3.trigger_further_categ_flag);
                  --
                  --Append obj5 to the list
                  l_obj43.append(obj53.to_json_value);
                end loop;
                --
                if json_ac.array_count(l_obj43) > 0 then
                  obj43.put('question_response', l_obj43);
                end if;
                --question response end--------================================
                --Append obj4 to the list
                l_obj33.append(obj43.to_json_value);
              end loop;
              --
              if json_ac.array_count(l_obj33) > 0 then
                obj31.put('question', l_obj33);
              end if;
              --question end--------================================
              --***********question check end*************************************
              --=====9999999999999999999999999999999999999999999999999999
              --triggered categ end--------================================
              --child/triggered categ have child categ end===============================
            else
              --triggered categ by another categ or child categ avail question start--------================================
              l_obj31 := json_list(); --an empty list obj
              for kk in (select q.question_sn code
                              ,ql.short_descr descr
                              ,ql.long_descr
                              ,q.order_num
                        from question q
                            ,question_lang ql
                        where q.question_sn = ql.question_sn
                        and ql.lang_code = v_lang_code
                        and q.question_categ_code = jj.code
                        --
                        and q.active_flag = 'Y'
                        and ql.active_flag = 'Y'
                        order by q.order_num
                        )
              loop
                obj41 := json(); --an empty structure
                obj41.put('CODE',kk.code);
                obj41.put('DESCR',kk.descr);
                --triggered categ by another categ or child categ avail question response start--------================================
                l_obj41 := json_list(); --an empty list obj
                for ll in (select qr.question_response_code code
                                ,rl.short_descr descr
                                ,qr.order_num
                                ,qr.trigger_further_question_flag
                                ,qr.trigger_further_categ_flag
                                ,qr.triggered_question_categ_code
                          from question_response qr
                              ,list_response r
                              ,response_lang rl
                          where qr.response_code = r.response_code
                          and r.response_code = rl.response_code
                          and rl.lang_code = v_lang_code
                          and qr.question_sn = kk.code
                          --
                          and qr.active_flag = 'Y'
                          and r.active_flag = 'Y'
                          and rl.active_flag = 'Y'
                          order by qr.order_num
                          )
                loop
                  obj51 := json(); --an empty structure
                  obj51.put('CODE',ll.code);
                  obj51.put('DESCR',ll.descr);
                  obj51.put('TRIGGER_FURTHER_QUESTION',ll.trigger_further_question_flag);
                  obj51.put('TRIGGER_FURTHER_CATEG',ll.trigger_further_categ_flag);
                  --Append obj5 to the list
                  l_obj41.append(obj51.to_json_value);
                end loop;
                --
                if json_ac.array_count(l_obj41) > 0 then
                  obj41.put('question_response', l_obj41);
                end if;
                --triggered categ by another categ or child categ avail question response end--------================================
                --Append obj4 to the list
                l_obj31.append(obj41.to_json_value);
              end loop;
              --
              if json_ac.array_count(l_obj31) > 0 then
                obj31.put('question', l_obj31);
              end if;
              --triggered categ by another categ or child categ avail question end--------================================
            end if;
            --Append obj3 to the list
            l_obj21.append(obj31.to_json_value);
          end loop;
          --
          if json_ac.array_count(l_obj21) > 0 then
            obj3.put('categ', l_obj21);
          end if;
          --triggered categ by another or child categ avail categ end--------================================
          --Check if this categ also have any questions under this========********************************************
          --***********question check begin*************************************
          --question start--------================================
          l_obj33 := json_list(); --an empty list obj
          for k3 in (select q.question_sn code
                          ,ql.short_descr descr
                          ,ql.long_descr
                          ,q.order_num
                    from question q
                        ,question_lang ql
                        ,list_question_categ qc
                    where q.question_categ_code = qc.question_categ_code
                    and q.question_sn = ql.question_sn
                    and ql.lang_code = v_lang_code
                    and qc.question_categ_code = j.code
                    and q.conditional_question_flag = 'N'
                    and q.parent_question_sn is null
                    --
                    and q.active_flag = 'Y'
                    and ql.active_flag = 'Y'
                    and qc.active_flag = 'Y'
                    order by q.order_num
                    )
          loop
            obj43 := json(); --an empty structure
            obj43.put('CODE',k3.code);
            obj43.put('DESCR',k3.descr);
            --question response start--------================================
            l_obj43 := json_list(); --an empty list obj
            for l3 in (select qr.question_response_code code
                            ,rl.short_descr descr
                            ,qr.order_num
                            ,qr.trigger_further_question_flag
                            ,qr.trigger_further_categ_flag
                            ,qr.triggered_question_categ_code
                      from question_response qr
                          ,list_response r
                          ,response_lang rl
                      where qr.response_code = r.response_code
                      and r.response_code = rl.response_code
                      and rl.lang_code = v_lang_code
                      and qr.question_sn = k3.code
                      --
                      and qr.active_flag = 'Y'
                      and r.active_flag = 'Y'
                      and rl.active_flag = 'Y'
                      order by qr.order_num
                      )
            loop
              obj53 := json(); --an empty structure
              obj53.put('CODE',l3.code);
              obj53.put('DESCR',l3.descr);
              obj53.put('TRIGGER_FURTHER_QUESTION',l3.trigger_further_question_flag);
              obj53.put('TRIGGER_FURTHER_CATEG',l3.trigger_further_categ_flag);
              --
              --Append obj5 to the list
              l_obj43.append(obj53.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj43) > 0 then
              obj43.put('question_response', l_obj43);
            end if;
            --question response end--------================================
            --Append obj4 to the list
            l_obj33.append(obj43.to_json_value);
          end loop;
          --
          if json_ac.array_count(l_obj33) > 0 then
            obj3.put('question', l_obj33);
          end if;
          --question end--------================================
          --***********question check end*************************************
        else
          --question start--------================================
          l_obj3 := json_list(); --an empty list obj
          for k in (select q.question_sn code
                          ,ql.short_descr descr
                          ,ql.long_descr
                          ,q.order_num
                    from question q
                        ,question_lang ql
                        ,list_question_categ qc
                    where q.question_categ_code = qc.question_categ_code
                    and q.question_sn = ql.question_sn
                    and ql.lang_code = v_lang_code
                    and qc.question_categ_code = j.code
                    and q.conditional_question_flag = 'N'
                    and q.parent_question_sn is null
                    --
                    and q.active_flag = 'Y'
                    and ql.active_flag = 'Y'
                    and qc.active_flag = 'Y'
                    order by q.order_num
                    )
          loop
            obj4 := json(); --an empty structure
            obj4.put('CODE',k.code);
            obj4.put('DESCR',k.descr);
            --question response start--------================================
            l_obj4 := json_list(); --an empty list obj
            for l in (select qr.question_response_code code
                            ,rl.short_descr descr
                            ,qr.order_num
                            ,qr.trigger_further_question_flag
                            ,qr.trigger_further_categ_flag
                            ,qr.triggered_question_categ_code
                      from question_response qr
                          ,list_response r
                          ,response_lang rl
                      where qr.response_code = r.response_code
                      and r.response_code = rl.response_code
                      and rl.lang_code = v_lang_code
                      and qr.question_sn = k.code
                      --
                      and qr.active_flag = 'Y'
                      and r.active_flag = 'Y'
                      and rl.active_flag = 'Y'
                      order by qr.order_num
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',l.code);
              obj5.put('DESCR',l.descr);
              obj5.put('TRIGGER_FURTHER_QUESTION',l.trigger_further_question_flag);
              obj5.put('TRIGGER_FURTHER_CATEG',l.trigger_further_categ_flag);
              --
              if l.trigger_further_question_flag = 'Y' then
                --triggered question start--------================================
                l_obj5 := json_list(); --an empty list obj
                for m in (select q.question_sn code
                                ,ql.short_descr descr
                                ,ql.long_descr
                                ,q.order_num
                          from question q
                              ,question_lang ql
                          where q.question_sn = ql.question_sn
                          and ql.lang_code = v_lang_code
                          and q.parent_question_sn = k.code
                          --
                          and q.active_flag = 'Y'
                          and ql.active_flag = 'Y'
                          order by q.order_num
                          )
                loop
                  obj6 := json(); --an empty structure
                  obj6.put('CODE',m.code);
                  obj6.put('DESCR',m.descr);
                  --triggered question response start--------================================
                  l_obj6 := json_list(); --an empty list obj
                  for n in (select qr.question_response_code code
                                  ,rl.short_descr descr
                                  ,qr.order_num
                                  ,qr.trigger_further_question_flag
                            from question_response qr
                                ,list_response r
                                ,response_lang rl
                            where qr.response_code = r.response_code
                            and r.response_code = rl.response_code
                            and rl.lang_code = v_lang_code
                            and qr.question_sn = m.code
                            --
                            and qr.active_flag = 'Y'
                            and r.active_flag = 'Y'
                            and rl.active_flag = 'Y'
                            order by qr.order_num
                            )
                  loop
                    obj7 := json(); --an empty structure
                    obj7.put('CODE',n.code);
                    obj7.put('DESCR',n.descr);
                    --Append obj5 to the list
                    l_obj6.append(obj7.to_json_value);
                  end loop;
                  --
                  if json_ac.array_count(l_obj6) > 0 then
                    obj6.put('question_response', l_obj6);
                  end if;
                  --triggered question response end--------================================
                  --Append obj4 to the list
                  l_obj5.append(obj6.to_json_value);
                end loop;
                --
                if json_ac.array_count(l_obj5) > 0 then
                  obj5.put('question', l_obj5);
                end if;
                --triggered question end--------================================
              elsif l.trigger_further_categ_flag = 'Y' then
                --triggered categ start--------================================
                l_obj21 := json_list(); --an empty list obj
                for jj in (select qcl.question_categ_code code
                                ,qcl.short_descr descr
                                ,qcl.long_descr
                                ,qc.categ_condition_descr
                                ,qc.trigger_further_categ_flag
                                ,qc.child_categ_avail_flag
                          from list_question_categ qc
                              ,question_categ_lang qcl
                          where qc.question_categ_code = qcl.question_categ_code
                          and qcl.lang_code = v_lang_code
                          and qc.question_categ_code = l.triggered_question_categ_code
                          --
                          and qc.active_flag = 'Y'
                          and qcl.active_flag = 'Y'
                          )
                loop
                  obj31 := json(); --an empty structure
                  obj31.put('CODE',jj.code);
                  obj31.put('DESCR',jj.descr);
                  obj31.put('TRIGGER_FURTHER_CATEG',jj.trigger_further_categ_flag);
                  obj31.put('CHILD_CATEG_AVAIL',jj.child_categ_avail_flag);
                  obj31.put('CATEG_CONDITION_DESCR',jj.categ_condition_descr);
                  --triggered categ question start--------================================
                  l_obj31 := json_list(); --an empty list obj
                  for kk in (select q.question_sn code
                                  ,ql.short_descr descr
                                  ,ql.long_descr
                                  ,q.order_num
                            from question q
                                ,question_lang ql
                            where q.question_sn = ql.question_sn
                            and ql.lang_code = v_lang_code
                            and q.question_categ_code = jj.code
                            --
                            and q.active_flag = 'Y'
                            and ql.active_flag = 'Y'
                            order by q.order_num
                            )
                  loop
                    obj41 := json(); --an empty structure
                    obj41.put('CODE',kk.code);
                    obj41.put('DESCR',kk.descr);
                    --triggered categ question response start--------================================
                    l_obj41 := json_list(); --an empty list obj
                    for ll in (select qr.question_response_code code
                                    ,rl.short_descr descr
                                    ,qr.order_num
                                    ,qr.trigger_further_question_flag
                                    ,qr.trigger_further_categ_flag
                                    ,qr.triggered_question_categ_code
                              from question_response qr
                                  ,list_response r
                                  ,response_lang rl
                              where qr.response_code = r.response_code
                              and r.response_code = rl.response_code
                              and rl.lang_code = v_lang_code
                              and qr.question_sn = kk.code
                              --
                              and qr.active_flag = 'Y'
                              and r.active_flag = 'Y'
                              and rl.active_flag = 'Y'
                              order by qr.order_num
                              )
                    loop
                      obj51 := json(); --an empty structure
                      obj51.put('CODE',ll.code);
                      obj51.put('DESCR',ll.descr);
                      obj51.put('TRIGGER_FURTHER_QUESTION',ll.trigger_further_question_flag);
                      obj51.put('TRIGGER_FURTHER_CATEG',ll.trigger_further_categ_flag);
                      --Append obj5 to the list
                      l_obj41.append(obj51.to_json_value);
                    end loop;
                    --
                    if json_ac.array_count(l_obj41) > 0 then
                      obj41.put('question_response', l_obj41);
                    end if;
                    --triggered categ question response end--------================================
                    --Append obj4 to the list
                    l_obj31.append(obj41.to_json_value);
                  end loop;
                  --
                  if json_ac.array_count(l_obj31) > 0 then
                    obj31.put('question', l_obj31);
                  end if;
                  --triggered categ question end--------================================
                  --Append obj3 to the list
                  l_obj21.append(obj31.to_json_value);
                end loop;
                --
                if json_ac.array_count(l_obj21) > 0 then
                  obj5.put('categ', l_obj21);
                end if;
                --triggered categ end--------================================
              end if;
              --Append obj5 to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('question_response', l_obj4);
            end if;
            --question response end--------================================
            --Append obj4 to the list
            l_obj3.append(obj4.to_json_value);
          end loop;
          --
          if json_ac.array_count(l_obj3) > 0 then
            obj3.put('question', l_obj3);
          end if;
          --question end--------================================
        end if;
        --Append obj3 to the list
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('categ', l_obj2);
      end if;
      --categ end--------================================
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('categ_grp', l_obj);
    end if;
    --categ grp end================================================================
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
    --p_out := obj.to_char;
  end qnr_info;
  --
  PROCEDURE qnr_by_categ (p_locale in varchar2,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_out OUT clob)
  as
    obj json;
    obj2 json;
    obj3 json;
    obj4 json;
    --
    l_obj json_list;
    l_obj2 json_list;
    --
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --categ start--------================================
    for i in (select qcl.question_categ_code code
                    ,qcl.short_descr categ_descr
                    ,qcl.long_descr categ_long_descr
                    ,qcgl.long_descr grp_descr
                    ,psbl.short_descr svc_descr
                    ,qc.trigger_further_categ_flag
                    ,qc.child_categ_avail_flag
                    ,qc.categ_condition_descr
                    ,sbqc.order_num
              from list_question_categ qc
                  ,question_categ_lang qcl
                  ,svc_billing_question_categ sbqc
                  ,list_question_categ_grp qcg
                  ,question_categ_grp_lang qcgl
                  ,list_prev_svc_billing psb
                  ,prev_svc_billing_lang psbl
              where qc.question_categ_code = qcl.question_categ_code
              and qcl.lang_code = v_lang_code
              and qc.question_categ_grp_code = qcg.question_categ_grp_code
              and qcg.question_categ_grp_code = qcgl.question_categ_grp_code
              and qcgl.lang_code = v_lang_code
              and sbqc.prev_svc_billing_code = psb.prev_svc_billing_code
              and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
              and psbl.lang_code = v_lang_code
              and qc.question_categ_code = sbqc.question_categ_code
              and sbqc.prev_svc_billing_code = p_svc_billing_code
              and qc.question_categ_code = p_question_categ_code
              --
              and qc.active_flag = 'Y'
              and qcl.active_flag = 'Y'
              and sbqc.active_flag = 'Y'
              and qcg.active_flag = 'Y'
              and qcgl.active_flag = 'Y'
              and psb.active_flag = 'Y'
              and psbl.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('TITLE',i.svc_descr);
      obj2.put('SUB_TITLE1',i.grp_descr);
      obj2.put('SUB_TITLE2',i.categ_descr);
      obj2.put('SUB_TITLE3',i.categ_long_descr);
      --triggered categ question start--------================================
      l_obj := json_list(); --an empty list obj
      for j in (select q.question_sn
                        ,q.QUESTION_CODE code
                        ,ql.short_descr descr
                        ,ql.long_descr
                        ,q.order_num
                        ,q.conditional_question_flag
                        ,q.triggered_response_code
                        ,q.triggered_question_categ_code
                        ,q.triggered_question_code
                        ,q.triggered_other_code
                  from question q
                      ,question_lang ql
                  where q.question_sn = ql.question_sn
                  and ql.lang_code = v_lang_code
                  and q.question_categ_code = i.code
                  --
                  and q.active_flag = 'Y'
                  and ql.active_flag = 'Y'
                  order by q.order_num
                  )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('DESCR',j.descr);
        --triggered categ question response start--------================================
        l_obj2 := json_list(); --an empty list obj
        for k in (select qr.question_response_code code
                        ,rl.short_descr descr
                        ,qr.order_num
                        ,qr.trigger_further_question_flag
                        ,qr.trigger_further_categ_flag
                        ,qr.triggered_question_categ_code
                        ,qr.response_code
                  from question_response qr
                      ,list_response r
                      ,response_lang rl
                  where qr.response_code = r.response_code
                  and r.response_code = rl.response_code
                  and rl.lang_code = v_lang_code
                  and qr.question_sn = j.question_sn
                  --
                  and qr.active_flag = 'Y'
                  and r.active_flag = 'Y'
                  and rl.active_flag = 'Y'
                  order by qr.order_num
                  )
        loop
          obj4 := json(); --an empty structure
          obj4.put('CODE',k.code);
          obj4.put('DESCR',k.descr);
          --Append obj5 to the list
          l_obj2.append(obj4.to_json_value);
        end loop;
        --
        if json_ac.array_count(l_obj2) > 0 then
          obj3.put('question_response', l_obj2);
        end if;
        --triggered categ question response end--------================================
        --Append obj4 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('question', l_obj);
      end if;
    end loop;
    --
    obj.put('categ',obj2);
    --result
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end qnr_by_categ;
  --
  PROCEDURE qnr_by_categ_patient_info (p_locale in varchar2,p_patient_prev_svc_sn in number,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_name in varchar2,p_age in number,p_gender in varchar2,p_gender_descr in varchar2,p_bmi in varchar2,p_bmi_result in varchar2,p_meds_cnt in number,p_out OUT clob)
  as
    obj json;
    obj2 json;
    --
    l_obj json_list;
    --
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --categ start--------================================
    for i in (select qcl.question_categ_code code
                    ,qcl.short_descr categ_descr
                    ,qcl.long_descr categ_long_descr
                    ,qcgl.long_descr grp_descr
                    ,psbl.short_descr svc_descr
                    ,qc.trigger_further_categ_flag
                    ,qc.child_categ_avail_flag
                    ,qc.categ_condition_descr
                    ,sbqc.order_num
              from list_question_categ qc
                  ,question_categ_lang qcl
                  ,svc_billing_question_categ sbqc
                  ,list_question_categ_grp qcg
                  ,question_categ_grp_lang qcgl
                  ,list_prev_svc_billing psb
                  ,prev_svc_billing_lang psbl
              where qc.question_categ_code = qcl.question_categ_code
              and qcl.lang_code = v_lang_code
              and qc.question_categ_grp_code = qcg.question_categ_grp_code
              and qcg.question_categ_grp_code = qcgl.question_categ_grp_code
              and qcgl.lang_code = v_lang_code
              and sbqc.prev_svc_billing_code = psb.prev_svc_billing_code
              and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
              and psbl.lang_code = v_lang_code
              and qc.question_categ_code = sbqc.question_categ_code
              and sbqc.prev_svc_billing_code = p_svc_billing_code
              and qc.question_categ_code = p_question_categ_code
              --
              and qc.active_flag = 'Y'
              and qcl.active_flag = 'Y'
              and sbqc.active_flag = 'Y'
              and qcg.active_flag = 'Y'
              and qcgl.active_flag = 'Y'
              and psb.active_flag = 'Y'
              and psbl.active_flag = 'Y'
              )
    loop
    --Annual Wellness Visit, Initial (Rita Book - 72 y/o, Male/BMI: 28.2(Overweight), Rx Meds Count: 7)
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('TITLE',i.svc_descr);
      obj2.put('SUB_TITLE1',i.grp_descr||' ('||p_name||' - '||p_age||' y/o, '||p_gender_descr||'/BMI: '||p_bmi||'('||p_bmi_result||'), Rx Meds Count: '||p_meds_cnt||')');
      if p_question_categ_code = 'MEDCP' and p_meds_cnt = 0 then
        obj2.put('SUB_TITLE2',i.categ_descr||' - There are no Rx Meds in the system. If Patient is talking meds, this is the last chance to enter them.');
      else
        obj2.put('SUB_TITLE2',i.categ_descr);
      end if;
      obj2.put('SUB_TITLE3',i.categ_long_descr);
      --categ question categ start--------================================
      l_obj := json_list(); --an empty list obj
      for j in (select q.question_sn
                        ,q.QUESTION_CODE code
                        ,ql.short_descr descr
                        ,ql.long_descr
                        ,q.order_num
                        ,q.conditional_question_flag
                        ,q.triggered_response_code
                        ,q.triggered_question_categ_code
                        ,q.triggered_question_code
                        ,q.triggered_other_code
                  from question q
                      ,question_lang ql
                  where q.question_sn = ql.question_sn
                  and ql.lang_code = v_lang_code
                  and q.question_categ_code = i.code
                  and q.question_code <> '1099'
                  --
                  and q.active_flag = 'Y'
                  and ql.active_flag = 'Y'
                  order by q.order_num
                  )
      loop
        if j.conditional_question_flag = 'Y' then
          if j.triggered_other_code is not null then
            if j.triggered_other_code = 'MDC' then
              if p_meds_cnt > 0 then
                l_obj.append(qnr_response(j.question_sn,j.code,j.descr,v_lang_code).to_json_value);
              end if;
            elsif j.triggered_other_code in ('FEM','MAL') then
              if j.triggered_other_code = p_gender then
                l_obj.append(qnr_response(j.question_sn,j.code,j.descr,v_lang_code).to_json_value);
              end if;
            elsif j.triggered_other_code = 'BMI' then
              if p_bmi_result in ('Overweight','Obese') then
                l_obj.append(qnr_response(j.question_sn,j.code,j.descr,v_lang_code).to_json_value);
              end if;
            end if;
          else
            --triggered_response_code, triggered_question_categ_code and triggered_question_code will be not null
            --use these three attributes to find if that response was answered by the beneficiary 
            if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,j.triggered_question_categ_code,j.triggered_question_code,j.triggered_response_code) = 'Y' then
              l_obj.append(qnr_response(j.question_sn,j.code,j.descr,v_lang_code).to_json_value);
            end if;
          end if;
        else --regular question (always include) 
          l_obj.append(qnr_response(j.question_sn,j.code,j.descr,v_lang_code).to_json_value);
        end if;
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('question', l_obj);
      end if;
    end loop;
    --
    obj.put('categ',obj2);
    --result
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end qnr_by_categ_patient_info;
  --This function will return question/response for the categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') only which is
  --controlled by the view. This function is getting called in admin_inq_pkg.
  function hx_qnr_by_categ (p_lang_code in varchar2,p_category_code in varchar2,p_gender in varchar2) return json_list
  as
    l_obj json_list := json_list(); --an empty list obj
  begin
    for j in (select distinct question_sn
                    ,QUESTION_CODE code
                    ,question descr
                    ,question_rpt_descr long_descr
                    ,question_order_num
                    ,conditional_question_flag
                    ,triggered_other_code
              from hx_question_response_vw
              where category_code = p_category_code
              and question_code <> '1099'
              and question_lang_code = p_lang_code
              and response_lang_code = p_lang_code
              and question_categ_lang_code = p_lang_code
              and question_categ_grp_lang_code = p_lang_code
              and question_sub_categ_lang_code = p_lang_code
              order by question_order_num
              )
    loop
      if j.conditional_question_flag = 'Y' then
        if j.triggered_other_code is not null then
          if j.triggered_other_code in ('FEM','MAL') then
            if j.triggered_other_code = p_gender then
              l_obj.append(qnr_response(j.question_sn,j.code,j.descr,p_lang_code).to_json_value);
            end if;
          end if;
        end if;
      else --regular question (always include) 
        l_obj.append(qnr_response(j.question_sn,j.code,j.descr,p_lang_code).to_json_value);
      end if;
    end loop;
    return l_obj;
  end hx_qnr_by_categ;
  --
  function qnr_response (p_question_sn in question.question_sn%type,p_question_code in question.question_code%type,p_question_descr in question_lang.short_descr%type,p_lang_code in varchar2) return json
  is
    obj json;
    obj2 json;
    --
    l_obj json_list;
  begin
    obj := json(); --an empty structure
    obj.put('CODE',p_question_code);
    obj.put('DESCR',p_question_descr);
    ----------================================
    l_obj := json_list(); --an empty list obj
    for i in (select qr.question_response_code code
                    ,rl.short_descr descr
                    ,qr.order_num
                    ,qr.trigger_further_question_flag
                    ,qr.trigger_further_categ_flag
                    ,qr.triggered_question_categ_code
                    ,qr.response_code
              from question_response qr
                  ,list_response r
                  ,response_lang rl
              where qr.response_code = r.response_code
              and r.response_code = rl.response_code
              and rl.lang_code = p_lang_code
              and qr.question_sn = p_question_sn
              --
              and qr.active_flag = 'Y'
              and r.active_flag = 'Y'
              and rl.active_flag = 'Y'
              order by qr.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('DESCR',i.descr);
      --Append obj5 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('question_response', l_obj);
    end if;
    return obj;
  end qnr_response;
END qnr_inq_pkg;
/
show errors