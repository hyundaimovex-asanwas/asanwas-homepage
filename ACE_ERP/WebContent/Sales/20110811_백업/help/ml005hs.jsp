<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 쇼핑몰 요금 결제 Help 
 * 프로그램ID   : ML005H (코드는 대문자)
 * J  S  P      : ml005h (jsp파일명은 소문자로 한다 )
 * 서 블 릿     : Ml005H
 * 작 성 자     : 심동현
 * 작 성 일     : 20010117
 * 기능정의     : 쇼핑몰 관리자 전용 요금결제 help sub
 * [수정일자][수정자] 내용
 * [20110117][심동현] 기존 결제창을 이용한 쇼핑몰 관리자 전용 결제 help sub
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String  dirPath         = request.getContextPath();

    String v_retn_value     = "";
    
    /**
     * 공통 변수 선언
     */
    String c_pay_gubn           = HDUtil.nullCheckStr(request.getParameter("c_pay_gubn"));
    String c_pay_manage_no      = HDUtil.nullCheckStr(request.getParameter("c_pay_manage_no"));
    String c_van_cd             = HDUtil.nullCheckStr(request.getParameter("c_van_cd"));
    String c_pay_amt            = HDUtil.nullCheckStr(request.getParameter("c_pay_amt"));
    String c_acct_join_no       = HDUtil.nullCheckStr(request.getParameter("c_acct_join_no"));
    String c_terminal_id        = HDUtil.nullCheckStr(request.getParameter("c_terminal_id"));
    
    /**
     * 요청변수
     */
    String r_app_type           = HDUtil.nullCheckStr(request.getParameter("r_app_type"));
    String r_card_no            = HDUtil.nullCheckStr(request.getParameter("r_card_no"));
    String r_valid_terms        = HDUtil.nullCheckStr(request.getParameter("r_valid_terms"));
    String r_halbu_terms        = HDUtil.nullCheckStr(request.getParameter("r_halbu_terms"));
    String r_card_way_cd        = HDUtil.nullCheckStr(request.getParameter("r_card_way_cd"));
    String r_agree_no           = HDUtil.nullCheckStr(request.getParameter("r_agree_no"));
    String r_org_agree_date     = HDUtil.nullCheckStr(request.getParameter("r_org_agree_date"));
    String r_remark             = HDUtil.nullCheckStr(request.getParameter("r_remark"));
    
    String r_order_nm           = HDUtil.nullCheckStr(request.getParameter("r_order_nm"));
    String r_order_tel_no       = HDUtil.nullCheckStr(request.getParameter("r_order_tel_no"));
    String r_order_e_mail       = HDUtil.nullCheckStr(request.getParameter("r_order_e_mail"));
    String r_user_key           = HDUtil.nullCheckStr(request.getParameter("r_user_key"));
    
    /**
     * 응답변수
     */
    String s_resp_code          = HDUtil.nullCheckStr(request.getParameter("s_resp_code"));
    String s_van_idx_no         = HDUtil.nullCheckStr(request.getParameter("s_van_idx_no"));
    String s_agree_time         = HDUtil.nullCheckStr(request.getParameter("s_agree_time"));
    
    String s_issue_company_cd   = HDUtil.nullCheckStr(request.getParameter("s_issue_company_cd"));
    String s_issue_company_nm   = HDUtil.nullCheckStr(request.getParameter("s_issue_company_nm"));
    String s_card_join_no       = HDUtil.nullCheckStr(request.getParameter("s_card_join_no"));
    String s_card_company_nm    = HDUtil.nullCheckStr(request.getParameter("s_card_company_nm"));
    String s_agree_no           = HDUtil.nullCheckStr(request.getParameter("s_agree_no"));
    String s_print_cd           = HDUtil.nullCheckStr(request.getParameter("s_print_cd"));
    String s_auto_cd            = HDUtil.nullCheckStr(request.getParameter("s_auto_cd"));
    String s_remark             = HDUtil.nullCheckStr(request.getParameter("s_remark"));
    String s_resp_msg1          = HDUtil.nullCheckStr(request.getParameter("s_resp_msg1"));
    String s_resp_msg2          = HDUtil.nullCheckStr(request.getParameter("s_resp_msg2"));
    
    String s_bank_cd            = HDUtil.nullCheckStr(request.getParameter("s_bank_cd"));
    String s_bank_nm            = HDUtil.nullCheckStr(request.getParameter("s_bank_nm"));
    String s_bank_acct          = HDUtil.nullCheckStr(request.getParameter("s_bank_acct"));
    String s_expire_date        = HDUtil.nullCheckStr(request.getParameter("s_expire_date"));
    String s_order_nm           = HDUtil.nullCheckStr(request.getParameter("s_order_nm"));
    String s_order_tel_no       = HDUtil.nullCheckStr(request.getParameter("s_order_tel_no"));
    String s_order_e_mail       = HDUtil.nullCheckStr(request.getParameter("s_order_e_mail"));
    String s_user_key           = HDUtil.nullCheckStr(request.getParameter("s_user_key"));

//    StringUtil.printMsg("======================= 응답 받은 내역 Start ==================", this);
//    StringUtil.printMsg("c_pay_gubn", c_pay_gubn, this);
//    StringUtil.printMsg("c_pay_manage_no", c_pay_manage_no, this);
//    StringUtil.printMsg("c_van_cd", c_van_cd, this);
//    StringUtil.printMsg("c_pay_amt", c_pay_amt, this);
//    StringUtil.printMsg("c_acct_join_no", c_acct_join_no, this);
//    StringUtil.printMsg("c_terminal_id", c_terminal_id, this);
//
//    StringUtil.printMsg("r_app_type", r_app_type, this);
//    StringUtil.printMsg("r_card_no", r_card_no, this);
//    StringUtil.printMsg("r_valid_terms", r_valid_terms, this);
//    StringUtil.printMsg("r_halbu_terms", r_halbu_terms, this);
//    StringUtil.printMsg("r_card_way_cd", r_card_way_cd, this);
//    StringUtil.printMsg("r_agree_no", r_agree_no, this);
//    StringUtil.printMsg("r_org_agree_date", r_org_agree_date, this);
//    StringUtil.printMsg("r_remark", r_remark, this);
//    
//    StringUtil.printMsg("r_order_nm", r_order_nm, this);
//    StringUtil.printMsg("r_order_tel_no", r_order_tel_no, this);
//    StringUtil.printMsg("r_order_e_mail", r_order_e_mail, this);
//    StringUtil.printMsg("r_user_key", r_user_key, this);
//
//    StringUtil.printMsg("s_resp_code", s_resp_code, this);
//    StringUtil.printMsg("s_van_idx_no", s_van_idx_no, this);
//    StringUtil.printMsg("s_agree_time", s_agree_time, this);
//    StringUtil.printMsg("s_issue_company_cd", s_issue_company_cd, this);
//    StringUtil.printMsg("s_issue_company_nm", s_issue_company_nm, this);
//    StringUtil.printMsg("s_card_join_no", s_card_join_no, this);
//    StringUtil.printMsg("s_card_company_nm", s_card_company_nm, this);
//    StringUtil.printMsg("s_agree_no", s_agree_no, this);
//    StringUtil.printMsg("s_print_cd", s_print_cd, this);
//    StringUtil.printMsg("s_auto_cd", s_auto_cd, this);
//    StringUtil.printMsg("s_remark", s_remark, this);
//    StringUtil.printMsg("s_resp_msg1", s_resp_msg1, this);
//    StringUtil.printMsg("s_resp_msg2", s_resp_msg2, this);
//    
//    StringUtil.printMsg("s_bank_cd", s_bank_cd, this);
//    StringUtil.printMsg("s_bank_nm", s_bank_nm, this);
//    StringUtil.printMsg("s_bank_acct", s_bank_acct, this);
//    StringUtil.printMsg("s_expire_date", s_expire_date, this);
//    StringUtil.printMsg("s_order_nm", s_order_nm, this);
//    StringUtil.printMsg("s_order_tel_no", s_order_tel_no, this);
//    StringUtil.printMsg("s_order_e_mail", s_order_e_mail, this);
//    StringUtil.printMsg("s_user_key", s_user_key, this);
//    StringUtil.printMsg("======================= 응답 받은 내역 End ==================", this);
    
    
    //가상계좌 및 계좌이체
    if(c_pay_gubn.equals("020") || c_pay_gubn.equals("030")){
        v_retn_value = c_pay_manage_no + ":"
                     + c_pay_gubn + ":"
                     + r_order_nm + ":"
                     + s_order_tel_no + ":"
                     + s_order_e_mail + ":"
                     + c_pay_amt + ":"
                     + c_terminal_id + ":"
                     + s_van_idx_no + ":"
                     + c_acct_join_no + ":"
                     + s_agree_time + ":"
                     + s_order_nm + ":"
                     + c_pay_amt + ":"
                     + s_bank_cd + ":"
                     + s_bank_nm + ":"
                     + s_bank_acct + ":"
                     + s_expire_date;
        
        out.println("v_retn_value : " + v_retn_value);
        out.println("<script language=javascript>\n");
        if(s_resp_code.equals("0000"))
            out.println("    parent.fnAccountSuccess('"+ c_pay_gubn +"' , '"+ s_resp_code + "', '"+ v_retn_value + "');\n");
        else
            out.println("    parent.fnAccountSuccess('"+ c_pay_gubn +"' , '"+ s_resp_code + "', '"+ s_resp_msg1 + "');\n");
        out.println("</script>\n");
        
    //카드결제
    } else if(c_pay_gubn.equals("040")){
        v_retn_value = c_pay_manage_no + ":"
                     + c_pay_gubn + ":"
                     + c_pay_amt + ":"
                     + r_card_no + ":"
                     + r_valid_terms + ":"
                     + r_halbu_terms + ":"
                     + "N" + ":"
                     + r_card_way_cd + ":"
                     + c_van_cd + ":"
                     + s_van_idx_no + ":"
                     + c_terminal_id + ":"
                     + s_card_join_no + ":";
        if(r_app_type.equals("1100"))
            v_retn_value += "Y" + ":";
        else
            v_retn_value += "N" + ":";
       
        v_retn_value += "20" + s_agree_time + ":"
                     + s_agree_no + ":";
                    
        if(r_app_type.equals("1100"))
            v_retn_value += ":";
        else
            v_retn_value += r_org_agree_date + ":";
        
        v_retn_value += s_card_company_nm + ":"
                     + s_issue_company_cd + ":"
                     + s_issue_company_nm;
        
        out.println("v_retn_value : " + v_retn_value);
        out.println("<script language=javascript>\n");
        if(s_resp_code.equals("0000"))
            out.println("    parent.fnAccountSuccess('"+ c_pay_gubn +"' , '"+ s_resp_code + "', '"+ v_retn_value + "');\n");
        else
            out.println("    parent.fnAccountSuccess('"+ c_pay_gubn +"' , '"+ s_resp_code + "', '"+ s_resp_msg1 + "');\n");
        out.println("</script>\n");
    
    //가상계좌 응답
    } else if(c_pay_gubn.equals("021")){
%>
<html>
    <head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
     
    <%=HDConstant.COMMENT_START%>
    <object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
        <param name="SyncLoad"  value="false">
    </object>
    <object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
        <param name="ServerIP"   value="">
        <param name="Action"     value="">
        <param name="KeyName"    value="">
        <param name="KeyValue"   value="">
        <param name="Parameters" value="">
    </object>
    <%=HDConstant.COMMENT_END%>
    </head>   
    <script language="javascript">
        function fnApply() {
        	try(
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_pay_manage_no=<%=c_pay_manage_no%>"
                        + ",v_pay_amt=<%=c_pay_amt%>";

            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Ml005H",
                "JSP(I:NOACCOUNT_REPLY=ds_master)",
                v_param);
            tr_post(tr_save);
            }
            catch(e){alert(e.description);}
        }
        
        fnApply();
    </script>

</html>

<%
    } else {
        StringUtil.printMsg("======================= 알수 없는 결제수단 Start ==================", this);
        StringUtil.printMsg("c_pay_gubn", c_pay_gubn, this);
        StringUtil.printMsg("======================= 알수 없는 결제수단 End ==================", this);
    }
%>
