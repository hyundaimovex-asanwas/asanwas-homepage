<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : �ſ�ī�� ���� Help 
 * ���α׷�ID   : RV005H (�ڵ�� �빮��)
 * J  S  P      : rv005h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��     : Rv005H
 * �� �� ��     : �迵��
 * �� �� ��     : 2006-06-28
 * �������     : �ſ�ī�� ����
 * [��������][������] ����
 * [20091221][�ڰ汹] �������Ա� �κ� �Աݳ��� ��ȸ�ؼ� ���� �� ���� �ϴ� ȭ������ ����
 * [20091228][�ɵ���] ȭ��/�׸��� ������, ��ũ��Ʈ ����

 * [20111102][�ɵ���] ������ "ac" ��ü�� �� 7��   ���θ� �� ����â�� �� �ֱ� ���̱���...(__)
 * [20111102][�ɵ���] 0�������  			�����ڵ� AC001 > 020 
 * [20111102][�ɵ���] 1������ü				�����ڵ� AC001 > 030 
 * [20111102][�ɵ���] 2EDI ī��				�����ڵ� AC001 > 040 
 * [20111102][�ɵ���] 3��ǰ��				�����ڵ� AC001 > 060 
 * [20111102][�ɵ���] 4�������Ա�			�����ڵ� AC001 > 080 
 * [20111102][�ɵ���] 5��Ÿ��ü				�����ڵ� AC001 > 090 
 * [20111102][�ɵ���] 6KCP �¶��� �ſ�ī��	�����ڵ� AC001 > 051 ���ͳ�(ī)2- ��ȭ���� > ��������
 * [20111102][�ɵ���] �� �������� ���� 		�����ڵ� AC001 > 050 ���ͳ�(ī) - �������� > ��������
 * [20140121][�ɵ���] �ý��� ����
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String  dirPath         = request.getContextPath();
    String  v_card_no       = HDUtil.nullCheckStr(request.getParameter("v_card_no"));       //������ ī���ȣ
    String  v_expire_year   = HDUtil.nullCheckStr(request.getParameter("v_expire_year"));   //ī�� ��ȿ��
    String  v_expire_month  = HDUtil.nullCheckStr(request.getParameter("v_expire_month"));  //ī�� ��ȿ��
    String  v_auth_no       = HDUtil.nullCheckStr(request.getParameter("v_auth_no"));       //�����ι�ȣ
    String  v_org_date      = HDUtil.nullCheckStr(request.getParameter("v_org_date"));      //���ŷ�����

    int     c_pay_amt       = HDUtil.nullCheckNum(request.getParameter("v_account_amt"));   //�ݾ�
    int     TR_SID 	 	    = HDUtil.nullCheckNum(request.getParameter("TR_SID"));
    String  v_client_cd     = HDUtil.nullCheckStr(request.getParameter("v_client_cd"));     //�븮���ڵ�
    String  v_goods_nm      = HDUtil.nullCheckStr(request.getParameter("v_goods_nm"));      //��ǰ��

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");

    String firstday = m_today.format(date.getTime()).substring(0,8);
    String totDay = m_today.format(date.getTime());           

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>- ��ݰ��� â�Դϴ� -</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
    <script language="javascript">
        var v_job = "H";
        
        var v_plan_pay_date = "";       //�Աݿ�������

        /* ���� �׸�
         * array
         * 0 : ������� ��ü
         * 1 : ������ü (������) �� �¶��� �ſ�ī��
         * 2 : �ſ�ī�� EDI
         * 3 : ��ǰ�ǰ���
         * 4 : �������Ա�
         * 5 : ��Ÿ��ü
         * 6 : �ſ�ī�� Online
         */		
        subimg__a_url = new Array();
        subimg__url = new Array();
        subimg__a_url[0] = new Image();
        subimg__a_url[1] = new Image();
        subimg__a_url[2] = new Image();
        subimg__a_url[3] = new Image();
        subimg__a_url[4] = new Image();
        subimg__a_url[5] = new Image();
        subimg__a_url[6] = new Image();
        
        subimg__url[0] = new Image();
        subimg__url[1] = new Image();
        subimg__url[2] = new Image();
        subimg__url[3] = new Image();
        subimg__url[4] = new Image();
        subimg__url[5] = new Image();
        subimg__url[6] = new Image();
    
        subimg__a_url[0].src="<%=dirPath%>/Sales/images/ac_01_on.gif";
        subimg__a_url[1].src="<%=dirPath%>/Sales/images/ac_02_on.gif";
        subimg__a_url[2].src="<%=dirPath%>/Sales/images/ac_03_on.gif";
        subimg__a_url[3].src="<%=dirPath%>/Sales/images/ac_04_on.gif";
        subimg__a_url[4].src="<%=dirPath%>/Sales/images/ac_05_on.gif";
        subimg__a_url[5].src="<%=dirPath%>/Sales/images/ac_06_on.gif";
		subimg__a_url[6].src="<%=dirPath%>/Sales/images/ac_07_on.gif";

        subimg__url[0].src="<%=dirPath%>/Sales/images/ac_01.gif";
        subimg__url[1].src="<%=dirPath%>/Sales/images/ac_02.gif";
        subimg__url[2].src="<%=dirPath%>/Sales/images/ac_03.gif";
        subimg__url[3].src="<%=dirPath%>/Sales/images/ac_04.gif";
        subimg__url[4].src="<%=dirPath%>/Sales/images/ac_05.gif";
        subimg__url[5].src="<%=dirPath%>/Sales/images/ac_06.gif";
        subimg__url[6].src="<%=dirPath%>/Sales/images/ac_07.gif";
                
        var sub_click_img = 9;
        
        //���� ��� ��� ���� ����
        var common_card_term_id  = "";   //�ܸ��� ���̵�
        var common_acct_term_id  = "";   //������ü �� ������� ���̵�
        var common_acct_join_no = "";    //������ü �� ������� ������ ID
        
        //���� ���� ���
        var c_pay_gubn          = "";   //��������
        var c_pay_manage_no     = "";   //���� ������ȣ
        var c_van_cd            = "";   //van ����
        var c_pay_amt           = "";   //�ŷ��ݾ�
        var c_acct_join_no      = "";   //������ ID
        var c_terminal_id       = "";   //�ܸ��� ���̵�
        
        //������� / ������ü ���� ���� ���� ���� ����
        //��û
        var r_order_nm          = "";   //�ֹ��ڸ�
        var r_order_tel_no      = "";   //�ֹ��� ��ȭ��ȣ
        var r_order_e_mail      = "";   //�ֹ��� E-mail
        var r_user_key          = "";   //����� KEY
        
        //������ �ŷ����� SID
        var TR_SID          	= "";   //������ŷ�SID
        //����
        var s_bank_cd           = "";   //�����ڵ�
        var s_bank_nm           = "";   //�����
        var s_order_nm          = "";   //�ֹ��ڸ�
        var s_order_tel_no      = "";   //�ֹ��� ��ȭ��ȣ
        var s_order_e_mail      = "";   //�ֹ��� E-mail
        var s_user_key          = "";   //����� KEY
        
        //�ſ�ī�� ���� ���� ���� ���� ����
        //��û����
        var r_card_no           = "";   //ī���ȣ
        var r_valid_terms       = "";   //��ȿ�Ⱓ
        var r_halbu_terms       = "";   //�Һα���
        var r_card_way_cd       = "";   //10:KeyIn, 20:Swipe
        var r_agree_no          = "";   //���ι�ȣ ��ҽ�
        var r_org_agree_date    = "";   //�ŷ����� ��ҽ�
        
        //���亯��
        var s_resp_code         = "";   //�����ڵ�
        var s_van_idx_no        = "";   //�ŷ�������ȣ
        var s_agree_time        = "";   //�ŷ������Ͻÿ���

        var s_issue_company_cd  = "";   //ī��� �ڵ�
        var s_issue_company_nm  = "";   //ī����
        var s_card_join_no      = "";   //��������ȣ
        var s_card_company_nm   = "";   //���Ի��
        var s_agree_no          = "";   //���ι�ȣ
        var s_print_cd          = "";   //����Ʈ�ڵ�
        var s_auto_cd           = "";   //�ڵ���ü����
        var s_remark            = "";   //��������� Field
        var s_resp_msg1         = "";
        var s_resp_msg2         = "";
        
       	<%// Tab Image Control%>
        function fnOnChangTab(tab_idx){
            if(tab_idx==2 && c_pay_amt<1000){
                alert("�ſ�ī�� ������ 1,000�� �̻󿡼��� �����մϴ�.");
                return;
            }
            if(tab_idx==4){
	            c_pay_date1.text='<%=firstday%>';
				   
	        	//2007-06-11 ���¹�ȣ  by �ɵ��� 
	        	//2009-12-28 �Աݳ��� �� �������� �ٲ�鼭 ���̻� �ʿ����.
				//���¹�ȣ [AC021]
				//dstype=5 : detail_nm�� �����ָ鼭 '��ü'
	            //codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC021&s_item1=Y";
	            //codeDs1.Reset();
            }
           
           
    
            for(var i=0; i<document.all("ac").length; i++){
                if(i==tab_idx){
                    document.all("ac")[i].style.display = "inline";
                    for(var j=0; j<getObjectList("ac_btn_"+i).length; j++)
                        getObjectList("ac_btn_"+i)[j].style.display = "inline";
                } else {
                    document.all("ac")[i].style.display = "none";
                    for(var j=0; j<getObjectList("ac_btn_"+i).length; j++)
                        getObjectList("ac_btn_"+i)[j].style.display = "none";
                }
            }
        }
        
        function changesub (no) {
            for (i=0; i<=6;i++){
                if(eval("document.images.ac_"+i)!=undefined){
                    obj = eval("document.images.ac_"+i);
                    if (i == no)
                        obj.src = subimg__a_url[i].src;
                    else
                        obj.src = subimg__url[i].src;
                }
            }
        }
    
        function changesubclick (no) {
            if(no==2 && c_pay_amt<1000) return;
            
            sub_click_img = no;
            for (i=0; i<=6;i++){
                if(eval("document.images.ac_"+i)!=undefined){
                    obj = eval("document.images.ac_"+i);
                    if (i == no)
                      obj.src = subimg__a_url[i].src;
                    else
                      obj.src = subimg__url[i].src;
                }
            }
        }
        
        function changesubout (no) {
            changesubclick(sub_click_img);
        }

        /*
         * �Է� �Ķ����
         * ���� : 
         *  - 0 : �븮���ڵ�
         *  - 1 : �����ݾ�
         *  - 2 : ��ǰ��
         */
        var strParam = new Array();
        strParam=window.dialogArguments;
        
//alert("strParam : " + strParam + " : " + strParam.length);
        var v_display   = strParam[0];
        var v_client_cd = strParam[1];
        c_pay_amt       = strParam[2];
        var v_goods_nm  = strParam[3];
        common_card_term_id = strParam[4];
        common_acct_term_id = strParam[5];
        common_acct_join_no = strParam[6];
        var v_client_sid = strParam[7];
		var v_cust_nm 	= strParam[8];       //��������	2010-01-14 ����..

        /*
         * �ſ�ī�� ��ҽ� �Ķ���� �߰�
         */
        var v_auth_gubn     = "1100";   //���α��� 1100 (�ſ����), 1102 (�ſ����)
        var v_card_no       = "";   //ī���ȣ
        var v_expire_date   = "";   //��ȿ�Ⱓ
        var v_auth_no       = "";   //���ι�ȣ
        var v_org_pay_date  = "";   //���ŷ���������
        var v_halbu_terms   = "00"; //�ҺαⰣ
        
        var v_expire_year   = "";   //��ȿ��
        var v_expire_month  = "";   //��ȿ��
        
        if(strParam.length==15){//��ҽ� �Ķ���� 15��.
            v_auth_gubn     = "1102";	//������ strParam[8]�� ���������� �����鼭 �����ڵ����� ���� 2010-01-14
            v_card_no       = strParam[9];
            v_expire_date   = strParam[10];
            v_halbu_terms   = strParam[11];
            v_auth_no       = strParam[12];
            v_org_pay_date  = strParam[13];
            c_pay_manage_no = strParam[14];

            v_expire_year   = "";
            v_expire_month  = "";
            if(v_expire_date!=undefined && v_expire_date.length==4){
                v_expire_year = v_expire_date.substring(0, 2);
                v_expire_month = v_expire_date.substring(2);
            }
        }
        
        
        function fnOnLoad(){
            cfStyleGrid(getObjectFirst("gr_gift"), "comn");
            cfStyleGrid(getObjectFirst("gr_giftList"), "comn");
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            
            for(var i=0; i<v_display.length; i++){
                if(v_display.charAt(i)=="1"){
                    if(sub_click_img==9)
                        sub_click_img = i;
                    if(getObjectFirst("tr_ac_"+i)!=undefined) 
                        getObjectFirst("tr_ac_"+i).style.display = "inline";
                } else {
                    if(getObjectFirst("tr_ac_"+i)!=undefined)
                        getObjectFirst("tr_ac_"+i).style.display = "none";
                }
            }
            
            changesubclick(sub_click_img);
            fnOnChangTab(sub_click_img);

            window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);
            
            ds_giftType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC003";
            ds_giftType.Reset();
            
            ds_accType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC019&s_item=Y";
            ds_accType.Reset();
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(O:CARD=ds_card,O:ACCOUNT=ds_account,O:NOACCOUNT=ds_noaccount,O:TONGJANG=ds_tongjang,O:ETC=ds_etc,O:GIFT=ds_gift)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
            
            for(var i=0; i<document.all("c_pay_amt").length; i++){
                document.all("c_pay_amt")[i].Text = c_pay_amt;
            }
            
            getObjectFirst("r_card_no").Text        = v_card_no;
            getObjectFirst("r_halbu_terms").value   = v_halbu_terms;
            getObjectFirst("v_expire_year").Text    = v_expire_year;
            getObjectFirst("v_expire_month").Text   = v_expire_month;
            getObjectFirst("r_agree_no").Text       = v_auth_no;
            getObjectFirst("r_org_agree_date").Text = v_org_pay_date;
   			getObjectFirst("v_noaccount_nm").value = v_cust_nm;//�Ա��ڸ� ���õ� ���������� ����ֱ� 2010-01-14
            if(strParam.length==15){
                getObjectFirst("r_card_no").Enable        = "false";
                getObjectFirst("v_expire_year").Enable    = "false";
                getObjectFirst("v_expire_month").Enable   = "false";
                getObjectFirst("r_agree_no").Enable       = "false";
                getObjectFirst("r_org_agree_date").Enable = "false";
            }
        }
        
        /*
         * ī�����
         */
        function fnCardTrans(){
            c_pay_gubn      = "040";
            c_van_cd        = "01";
            c_terminal_id   = common_card_term_id;
            c_pay_amt       = getObjectFirst("c_pay_amt").Text.trim();

            r_card_no       = getObjectFirst("r_card_no").Text.trim();
            r_valid_terms   = getObjectFirst("v_expire_year").Text.trim()+getObjectFirst("v_expire_month").Text.trim();
            //�Һ� : BC Top ����Ʈ( topChk ) üũ�� ���, +60�� ���ݴϴ�.
            //      ������ Form ������ ���� ������ 2�ڸ��� ���߸� ���ڰ� ���ڰ� �����մϴ�.
            if(getObjectFirst("topChk").checked){
	            r_halbu_terms   = parseInt(getObjectFirst("r_halbu_terms").value) + 60;
            }else{
	            r_halbu_terms   = getObjectFirst("r_halbu_terms").value;
            };
            r_card_way_cd   = "10"; //KeyIn
            r_agree_no      = getObjectFirst("r_agree_no").Text.trim();
            r_org_agree_date= getObjectFirst("r_org_agree_date").Text.trim();
            
            //�������� ����
            var v_user_expire = (fnGetYear() + fnGetMonth()).substring(2);

            if(c_pay_amt=="" || eval(c_pay_amt)<1000){
                alert("���� �ݾ� <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("c_pay_amt").Focus();
                return;
            }
            
            if(r_card_no=="" || r_card_no.length<13){
                alert("ī���ȣ <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("r_card_no").Focus();
                return;
            }

            if(getObjectFirst("v_expire_year").Text=="" || getObjectFirst("v_expire_year").Text.trim().length<2){
                alert("��ȿ�Ⱓ �⵵ <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_expire_year").Focus();
                return;
            }
            if(getObjectFirst("v_expire_month").Text=="" || getObjectFirst("v_expire_month").Text.trim().length<2){
                alert("��ȿ�Ⱓ �� <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_expire_month").Focus();
                return;
            }
            if(eval(getObjectFirst("v_expire_month").Text)<1 || eval(getObjectFirst("v_expire_month").Text.trim())>12){
                alert("��ȿ�Ⱓ �� <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_expire_month").Focus();
                return;
            }
            if(r_valid_terms<v_user_expire){
                alert("��ȿ�Ⱓ�� ���� ������� ���� �� �����ϴ�.");
                getObjectFirst("v_expire_year").Focus();
                return;
            }
            
            if(c_pay_manage_no == "")
            	fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 ����������ȣ ä�� �Ķ���� �߰�
            
            if(c_pay_manage_no==""){
                alert("���� ������ȣ�� �������� ���߽��ϴ�.");
                return;
            }
 
            //acc_frm �ʱ�ȭ
            document.acc_frm.reset();
            
            document.acc_frm.c_pay_gubn.value          = c_pay_gubn;
            document.acc_frm.c_pay_manage_no.value     = c_pay_manage_no;
            document.acc_frm.c_van_cd.value            = c_van_cd;
            document.acc_frm.c_pay_amt.value           = c_pay_amt;
            document.acc_frm.c_terminal_id.value       = c_terminal_id;

            //document.acc_frm.r_app_type.value          = "1100";
            document.acc_frm.r_app_type.value          = v_auth_gubn;
            document.acc_frm.r_card_no.value           = r_card_no;
            document.acc_frm.r_valid_terms.value       = r_valid_terms;
            document.acc_frm.r_halbu_terms.value       = r_halbu_terms;
            document.acc_frm.r_card_way_cd.value       = r_card_way_cd;
            document.acc_frm.r_agree_no.value          = r_agree_no;
            document.acc_frm.r_org_agree_date.value    = r_org_agree_date;
            
            document.acc_frm.action ="<%=HDConstant.KCP_CARD_AUTH%>";
            document.acc_frm.submit();
            fnShowLoading(410,180);
            
            
            
            setTimeout("fnAccountFail()", 1000*10);    //10�ʵ��� �� ����� alert Message

//alert(document.acc_frm.action);

        }
        
        function fnAccountFail(){
            fnHideLoading();;
            alert("���� TimeOut");
        }
        
        /*
         * �������
         */
        function fnNonAccountTrans(){
            c_pay_gubn = "020";
            c_pay_manage_no = "";
            c_van_cd        = "01";
            c_terminal_id   = common_acct_term_id;
            c_acct_join_no  = common_acct_join_no;
            c_pay_amt       = getObjectFirst("c_pay_amt").Text;
            
            if(getObjectFirst("v_noaccount_nm").value==""){
                alert("�Ա��ڸ��� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }

            fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 ����������ȣ ä�� �Ķ���� �߰�
            
            if(c_pay_manage_no==""){
                alert("���� ������ȣ�� �������� ���߽��ϴ�.");
                return;
            }

            //acc_frm �ʱ�ȭ
            document.acc_frm.reset();

            document.acc_frm.c_pay_gubn.value          = c_pay_gubn;
            document.acc_frm.c_pay_manage_no.value     = c_pay_manage_no;
            document.acc_frm.c_van_cd.value            = c_van_cd;
            document.acc_frm.c_pay_amt.value           = c_pay_amt;
            document.acc_frm.c_terminal_id.value       = c_terminal_id;
            document.acc_frm.c_acct_join_no.value      = c_acct_join_no;
            document.acc_frm.r_user_key.value          = v_goods_nm;

            document.acc_frm.r_order_nm.value          = getObjectFirst("v_noaccount_nm").value

            document.acc_frm.action ="<%=HDConstant.KCP_ACCOUNT_AUTH%>";
            document.acc_frm.submit();
        }
        /*
         * ������ü
         */
        function fnAccountTrans(){
            c_pay_gubn = "030";
            c_pay_manage_no = "";
            c_van_cd        = "01";
            c_terminal_id   = common_acct_term_id;
            c_acct_join_no  = common_acct_join_no;
            c_pay_amt       = getObjectFirst("c_pay_amt").Text;

            if(getObjectFirst("v_account_nm").value==""){
                alert("�Ա��ڸ��� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }
            
            fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 ����������ȣ ä�� �Ķ���� �߰�
            
            if(c_pay_manage_no==""){
                alert("���� ������ȣ�� �������� ���߽��ϴ�.");
                return;
            }

            //acc_frm �ʱ�ȭ
            document.acc_frm.reset();

            document.acc_frm.c_pay_gubn.value          = c_pay_gubn;
            document.acc_frm.c_pay_manage_no.value     = c_pay_manage_no;
            document.acc_frm.c_van_cd.value            = c_van_cd;
            document.acc_frm.c_pay_amt.value           = c_pay_amt;
            document.acc_frm.c_terminal_id.value       = c_terminal_id;
            document.acc_frm.c_acct_join_no.value      = c_acct_join_no;
            document.acc_frm.r_user_key.value          = v_goods_nm;
            document.acc_frm.r_order_nm.value          = getObjectFirst("v_account_nm").value;

            document.acc_frm.action ="<%=HDConstant.KCP_ACCOUNT_AUTH%>";
            document.acc_frm.submit();
        }
        
        
        /**
         * ������ �Ա� ����
         */
        function fnTongJangTrans(){
        	var v_sel_cnt="0";
        	
        	if(getObjectFirst("ds_tongjang").CountRow==0){
            alert("���� [��ȸ==>����] �� Ŭ���Ͻñ� �ٶ��ϴ�.");
            return;
	        }
        	c_pay_gubn = "080";
        	c_pay_amt  = getObjectFirst("c_pay_amt").Text.trim();
        	
        	fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 ����������ȣ ä�� �Ķ���� �߰�
        	if(c_pay_manage_no==""){
                alert("���� ������ȣ�� �������� ���߽��ϴ�.");
                return;
            }
            
  
			//�����Ա����� ����
			v_plan_pay_date = c_pay_date1.text;
			v_bank_cd=v_bancod.value;
			
        	for(var i=1; i<=getObjectFirst("ds_tongjang").CountRow; i++){
        		if(getObjectFirst("ds_tongjang").NameValue(i, "JOB_SEL")=="T"){
                   	v_sel_cnt++;
        		}
        	}
        	if(v_sel_cnt==1){
       		 	for(var i=1; i<=getObjectFirst("ds_tongjang").CountRow; i++){
	        		if(getObjectFirst("ds_tongjang").NameValue(i, "JOB_SEL")=="T"){
		    			if(getObjectFirst("ds_tongjang").NameValue(i, "c_balance_amt") >= c_pay_amt){ 				    	   	
			    	   		var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
					       		+ ",v_client_sid="+v_client_sid
		    		   	        + ",v_pay_manage_no="+c_pay_manage_no
		       	   		        + ",v_pay_date="+v_plan_pay_date
		       		    	    + ",v_pay_time="+''
		       	    	    	+ ",v_bank_cd="+v_bank_cd
			       	        	+ ",v_pay_amt="+c_pay_amt
			               	    + ",v_pay_cd="+c_pay_gubn;
				        				
			        			ln_TRSetting(tr_save2, 
			               		"<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
					           	"JSP(I:TONGJANG=ds_tongjang)",
			   			        v_param);
		       				    tr_post(tr_save2);
			    	   	}
	        			if(c_pay_amt > getObjectFirst("ds_tongjang").NameValue(i, "c_balance_amt") ){						    
			    	   	alert("�ܾ��� �ʰ��Ͽ����ϴ�.");
				    	return;
				    	}
				    }
				}
			}
       		if(v_sel_cnt==0){
	       	   alert("���õ� ������ �����ϴ�.");
		       return;
		    }
        	if(v_sel_cnt > 1){
       	 	   alert("�Ѱ��� ������ ������ �� �ֽ��ϴ�.");
	    	   return;
        	}
		}
        
        /**
         * ������ �Ա� ��ȸ
         */
        function fnSelect() {
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",c_pay_date1=" + c_pay_date1.text
		            + ",v_order_nm=" + v_order_nm.value 
                    + ",v_bank_acc_no=" + v_bank_acc_no.value
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac080I_02", 
	            "JSP(O:MAIN_DS=ds_tongjang)",
	            v_param);
	        tr_post(tr1);
		}
        
        
        /**
         * ��Ÿ��ü : ȭ�鿡 ����..��ư��..��;;
         */
        function fnEtcTrans(){
        	if(v_pay_empnmk.value==""){
        		alert("�Ա��� <%=HDConstant.A_MSG_MUST_INPUT%>");
        		return;
        	}
        	if(c_pay_date2.Text=="" || c_pay_date2.Text.trim().length!=8){
        		alert("�Ա����� <%=HDConstant.A_MSG_MUST_INPUT%>");
        		return;
        	}

        	c_pay_gubn = "090";
        	
        	fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 ����������ȣ ä�� �Ķ���� �߰�
        	if(c_pay_manage_no==""){
                alert("���� ������ȣ�� �������� ���߽��ϴ�.");
                return;
            }
        	


			ds_etc.AddRow();
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_MANAGE_NO") = c_pay_manage_no;
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_CD") = c_pay_gubn;
        	ds_etc.NameValue(ds_etc.CountRow, "ACC_CD") = v_acc_cd.ValueOfIndex("DETAIL", v_acc_cd.Index);
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_DATE") = c_pay_date2.Text;
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_EMPNMK") = v_pay_empnmk.value;
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_AMT") = c_pay_amt;
        	ds_etc.NameValue(ds_etc.CountRow, "CLIENT_SID") = v_client_sid;

            ln_TRSetting(tr_save2, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(I:ETC=ds_etc)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr_save2);
        }
        
        function fnBankAccountPopup(){
            var arrParam    = new Array();

            var strURL = "<%=dirPath%>/Sales/help/ac003h.jsp";
            var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            var arrResult = showModalDialog(strURL,arrParam,strPos); 

            if(arrResult!=null && arrResult!=undefined){
                arrParam = arrResult.split(";");
                getObjectFirst("v_bank_acc_no").value = arrParam[0];
                getObjectFirst("v_bancod").value = arrParam[1];
                getObjectFirst("v_banknm").value = arrParam[2];
            } else {
                getObjectFirst("v_bank_acc_no").value = "";
                getObjectFirst("v_bancod").value = "";
                getObjectFirst("v_banknm").value = "";
            }
        }

        /*
         * ��ǰ��
         */
        function fnGiftTrans(){
            var v_gift_amt = 0;
            var v_gift_qty = 0;
            c_pay_gubn = "060";
            if(getObjectFirst("ds_gift").CountRow==0){
                alert("��ǰ�� ������ ���� ����Ͻñ� �ٶ��ϴ�.");
                return;
            }
            
            for(var i=1; i<=getObjectFirst("ds_gift").CountRow; i++){
                if(getObjectFirst("ds_gift").NameValue(i, "PAY_AMT")==0){
                    alert(i+ "��° ���� ������ �ݾ׺κ��� ���� �ֽ��ϴ�.");
                    return;
                }
                v_gift_amt += getObjectFirst("ds_gift").NameValue(i, "PAY_AMT")*1000;
                
                /**
                 * ��ǰ�� ���� üũ, ������ 0 �̸� �ȵ�...
                 */
                if(getObjectFirst("ds_gift").NameValue(i, "PAY_QTY")==0){
                    alert(i+ "��° ���� ������ �ݾ׺κ��� ���� �ֽ��ϴ�.");
                    return;
                }
                v_gift_qty += getObjectFirst("ds_gift").NameValue(i, "PAY_QTY");
            }
            
            if(v_gift_amt!=c_pay_amt){
                alert("���� ��û �ݾ�["+c_pay_amt+"]�� �Աݵ� ��ǰ�� �ݾ�["+v_gift_amt+"]�� Ʋ���ϴ�.");
                return;
            }

            fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 ����������ȣ ä�� �Ķ���� �߰�
            
            if(c_pay_manage_no==""){
                alert("���� ������ȣ�� �������� ���߽��ϴ�.");
                return;
            }

            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(I:GIFT=ds_gift)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,v_client_cd="+v_client_cd+",v_pay_manage_no="+c_pay_manage_no+",c_pay_amt="+c_pay_amt+",v_gift_qty="+v_gift_qty);
            tr_post(tr_save);
        }
        
        function fnGiftAdd(){
            getObjectFirst("ds_gift").AddRow();
            getObjectFirst("gr_gift").SetColumn("GIFT_TYPE");
        }
        
        function fnGiftDel(){
            getObjectFirst("ds_gift").DeleteRow(getObjectFirst("ds_gift").RowPosition);
        }
        
        function fnGiftCancel(){
            getObjectFirst("ds_gift").UndoAll();
        }
        
        //���� ���� ��ȣ ���� : ��κ��� �������� ���ϴ�. ���~ 20140121
        // �Ķ���͸� �߰����� v_pay_amt, v_pay_cd
        function fnGetManageNo(p_pay_cd, p_pay_amt){
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(O:PAY_MANAGE_NO=ds_manage_no)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_cd="+p_pay_cd+",v_pay_amt="+p_pay_amt);
            tr_post(tr1);
        }
        
        /*
         * ī�����
         */
        function fnCardCancel(){
        }
        
        /*
         * ���� ����
         */
        function fnPopClose(){
        	//alert(v_plan_pay_date);
            window.returnValue=c_pay_gubn+":"+c_pay_manage_no+":"+v_plan_pay_date;
            window.close();
        }

        /*
         * ���� �������������� ó���Ϸ� (��ǰ���� ó������)
         * pay_gubn     : �������� (020:�������, 030:������ü 040:�ſ�ī�� 060:��ǰ��
         * retn_code    : �����ڵ�
         *                0000:��������
         *                9999:��������
         *                etc :van �����ڵ�
         * arr_param    : �����
         * �� �� : retn_code�� 0000�� �ƴѰ�� result_param �� ���� �޽����� �ѷ��ش�.
         *       result_param�� �����ڴ� ":"���� ���еǸ�, ������ ds_... �� Į�� ������� �Ѿ�´�.
         */
        function fnAccountSuccess(pay_gubn, retn_code, result_param){
            fnHideLoading();;
            var arr_param = new Array();
            if(retn_code=="0000"){  //��������
                arr_param = result_param.split(":");
                //�������
                if(pay_gubn == "020"){
                    getObjectFirst("ds_noaccount").UndoAll();
                    getObjectFirst("ds_noaccount").AddRow();
                    
                    for(var i=1; i<=getObjectFirst("ds_noaccount").CountColumn; i++)
                        getObjectFirst("ds_noaccount").ColumnString(getObjectFirst("ds_noaccount").CountRow, i) = arr_param[i-1];
                    
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:NOACCOUNT_TEMP=ds_noaccount_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    
                    getObjectFirst("ds_noaccount").NameValue(getObjectFirst("ds_noaccount").CountRow, "CLIENT_SID") = v_client_sid;
                    
                    v_plan_pay_date = arr_param[arr_param.length-1];
                    
                    var v_user_msg = "";
                    v_user_msg  = "������� ������"
                                + "[�Ա����� : "+ getObjectFirst("ds_noaccount").NameValue(getObjectFirst("ds_noaccount").CountRow, "BANK_NM")+"��"
                                + "������¹�ȣ : "+ getObjectFirst("ds_noaccount").NameValue(getObjectFirst("ds_noaccount").CountRow, "BANK_ACCT")+"]";
                    //alert(v_user_msg);
					prompt("���� ���¹�ȣ �ȳ� : �Ʒ� ��ȣ�� ����(Ctrl+c)�Ͻ� �� �ֽ��ϴ�.",v_user_msg);
                //������ü
                } else if(pay_gubn == "030"){
                    getObjectFirst("ds_account").UndoAll();
                    getObjectFirst("ds_account").AddRow();
                    
                    for(var i=1; i<=getObjectFirst("ds_account").CountColumn; i++)
                        getObjectFirst("ds_account").ColumnString(getObjectFirst("ds_account").CountRow, i) = arr_param[i-1];
                    
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:ACCOUNT_TEMP=ds_account_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    
                    getObjectFirst("ds_account").NameValue(getObjectFirst("ds_account").CountRow, "CLIENT_SID") = v_client_sid;
                    
                //�ſ�ī��
                } else if(pay_gubn == "040"){
                    getObjectFirst("ds_card").UndoAll();
                    getObjectFirst("ds_card").AddRow();

                    for(var i=1; i<=getObjectFirst("ds_card").CountColumn; i++)
                        getObjectFirst("ds_card").ColumnString(getObjectFirst("ds_card").CountRow, i) = arr_param[i-1];
                    
                    getObjectFirst("ds_card").NameValue(getObjectFirst("ds_card").CountRow, "CLIENT_SID") = v_client_sid;
                    
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:CARD_TEMP=ds_card_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);

                    var v_user_msg = "";
                    v_user_msg  = "--------------------------------------------\n\n"
                                + "     ���ι�ȣ ("+ getObjectFirst("ds_card").NameValue(getObjectFirst("ds_card").RowPosition, "AGREE_NO") +")\n\n"
                                + "     �Ա�Ȯ�� �޴�����\n\n"
                                + "     ��������� Ȯ���Ͻ� �� �ֽ��ϴ�.\n\n"
                                + "--------------------------------------------";
                    alert(v_user_msg);
                } else {
                    alert("�˼� ���� �������м����Դϴ�. ["+ pay_gubn +"]");
                    return;
                }
            } else if(retn_code=="9999"){//��������
                alert("����� ��Ҹ� �����ϼ̽��ϴ�.");
                return;
            } else {    //��������
                if(pay_gubn == "040"){
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:CARD_TEMP=ds_card_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    alert("���� �����ڵ� : "+retn_code + "\n\nó����� : " + ds_card_temp.NameValue(1, "RESP_MSG"));
                } else if(pay_gubn == "020"){
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:NOACCOUNT_TEMP=ds_noaccount_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    alert("���� �����ڵ� : "+retn_code + "\n\nó����� : " + ds_noaccount_temp.NameValue(1, "RESP_MSG"));
                } else if(pay_gubn == "030"){
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:ACCOUNT_TEMP=ds_account_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    alert("���� �����ڵ� : "+retn_code + "\n\nó����� : " + ds_account_temp.NameValue(1, "RESP_MSG"));
                } else {
                    alert("���� �����ڵ� : "+retn_code + "\n\nó����� : " + result_param);
                }
                return;
            }
            
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(I:ACCOUNT=ds_account,I:NOACCOUNT=ds_noaccount,I:CARD=ds_card)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,v_client_cd="+v_client_cd);
            tr_post(tr_save);
        }
    </script>
<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnHideLoading();;

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr1" event="OnFail()">
    fnHideLoading();;
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
    
</script>

<script language="javascript" for="tr_save" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnHideLoading();;

    fnPopClose();
</script>

<script language="javascript" for="tr_save" event="OnFail()">
    fnHideLoading();;
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnHideLoading();;

    fnPopClose();
</script>
<script language="javascript" for="tr_save2" event="OnFail()">
    fnHideLoading();;
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save2.ErrorCode + "\n" + "Error Message : " + tr_save2.ErrorMsg + "\n");
</script>

<script language="javascript" for="gr_gift" event="OnExit(Row, Colid, OldData)">
    if(Row<1) return;
    
    if(Colid=="GIFT_TYPE" || Colid=="FR_GIFT_SEQ" || Colid=="TO_GIFT_SEQ"){
        if(getObjectFirst("ds_gift").NameValue(Row, "GIFT_TYPE")!=""
            && getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ")!=""
            && getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ")!="")
        {
            if(OldData != getObjectFirst("ds_gift").NameValue(Row, Colid)){
                getObjectFirst("ds_giftAmt").NameValue(Row, "PAY_QTY") = 0;
                getObjectFirst("ds_giftAmt").NameValue(Row, "PAY_AMT") = 0;
                
                for(var i=getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ").length; i<6; i++)
                    getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ") = "0"+getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ");
    
                for(var i=getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ").length; i<6; i++)
                    getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ") = "0"+getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ");
    
                var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                            + ",v_gift_type="+getObjectFirst("ds_gift").NameValue(Row, "GIFT_TYPE")
                            + ",v_fr_gift_seq="+getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ")
                            + ",v_to_gift_seq="+getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ");
                ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                    "JSP(O:GIFTAMT=ds_giftAmt,O:GIFTLIST=ds_giftList)",
                    v_param);
                tr_post(tr1);
            }
        }
    }
</script>

<script language="javascript" for="ds_giftAmt" event="OnLoadCompleted(row)">
    getObjectFirst("ds_gift").NameValue(getObjectFirst("ds_gift").RowPosition, "PAY_QTY") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_QTY");
    getObjectFirst("ds_gift").NameValue(getObjectFirst("ds_gift").RowPosition, "PAY_AMT") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_AMT");
</script>

<script language="javascript" for="ds_giftList" event="OnLoadCompleted(row)">
    if(row==0){
        getObjectFirst("div_giftList").style.display = "none";
        alert("��ǰ�� ������������ �����ϴ�.");
        return;
    }
    
    getObjectFirst("div_giftList").style.display = "inline";
</script>

<script language="javascript" for="ds_manage_no" event="OnLoadCompleted(row)">
    if(row==0){
        c_pay_manage_no = "";
        return;
    }
    c_pay_manage_no = ds_manage_no.NameValue(row, "PAY_MANAGE_NO");
</script>

<script language="javascript" for="ds_card_temp" event="OnLoadCompleted(row)">
    if(row==0) return;
    
    ds_card.NameValue(ds_card.CountRow, "ISSUE_COMPANY_NM") = ds_card_temp.NameValue(row, "ISSUE_COMPANY_NM")
    ds_card.NameValue(ds_card.CountRow, "CARD_COMPANY_NM") = ds_card_temp.NameValue(row, "CARD_COMPANY_NM")
</script>

<script language="javascript" for="ds_account_temp" event="OnLoadCompleted(row)">
    if(row==0) return;
    
    ds_account.NameValue(ds_account.CountRow, "ORDER_NM") = ds_account_temp.NameValue(row, "ORDER_NM")
    ds_account.NameValue(ds_account.CountRow, "AGREE_CUST_NM") = ds_account_temp.NameValue(row, "AGREE_CUST_NM")
    ds_account.NameValue(ds_account.CountRow, "BANK_NM") = ds_account_temp.NameValue(row, "BANK_NM")
</script>

<script language="javascript" for="ds_noaccount_temp" event="OnLoadCompleted(row)">
    if(row==0) return;
    
    ds_noaccount.NameValue(ds_noaccount.CountRow, "ORDER_NM") = ds_noaccount_temp.NameValue(row, "ORDER_NM")
    ds_noaccount.NameValue(ds_noaccount.CountRow, "AGREE_CUST_NM") = ds_noaccount_temp.NameValue(row, "AGREE_CUST_NM")
    ds_noaccount.NameValue(ds_noaccount.CountRow, "BANK_NM") = ds_noaccount_temp.NameValue(row, "BANK_NM")
</script>
<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>

<object id=ds_card classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_card_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_account classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_noaccount classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_account_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_noaccount_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_tongjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_etc classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_accType classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gift classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_giftAmt classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_giftList classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_giftType classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_manage_no classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=excelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=MAIN_DS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

    </head>
  
<body bgcolor="#FFFFFF" OnLoad="fnOnLoad()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	

	
        <table width="900" height="325" border="0" cellspacing="0" cellpadding="0" background="<%=dirPath%>/Sales/images/c_bg.gif">
            <tr>
                <td valign="top">
                    
                    <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr height="10">
                            <td colspan=5></td>
                        </tr>
                        
                        <tr>
                            <td width=5></td>
                            <td width="83" valign="top">
                                <table width="83" border="0" cellspacing="0" cellpadding="0" align=center>
                                    <tr id="tr_ac_0" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_01_on.gif" name="ac_0" onMouseOver="changesub(0)" onMouseOut="changesubout(0)" style="cursor:pointer;display:inline" onClick="changesubclick(0),fnOnChangTab(0)"></td>
                                    </tr>
                                    <tr id="tr_ac_1" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_02.gif" name="ac_1" onMouseOver="changesub(1)" onMouseOut="changesubout(1)" style="cursor:pointer;display:inline" onClick="changesubclick(1),fnOnChangTab(1)"></td>
                                    </tr>
                                    <tr id="tr_ac_2" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_03.gif" name="ac_2" onMouseOver="changesub(2)" onMouseOut="changesubout(2)" style="cursor:pointer;display:inline" onClick="changesubclick(2),fnOnChangTab(2)"></td>
                                    </tr>
                                    <tr id="tr_ac_3" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_04.gif" name="ac_3" onMouseOver="changesub(3)" onMouseOut="changesubout(3)" style="cursor:pointer;display:inline" onClick="changesubclick(3),fnOnChangTab(3)"></td>
                                    </tr>
                                    <tr id="tr_ac_4" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_05.gif" name="ac_4" onMouseOver="changesub(4)" onMouseOut="changesubout(4)" style="cursor:pointer;display:inline" onClick="changesubclick(4),fnOnChangTab(4)"></td>
                                    </tr>
                                    <tr id="tr_ac_5" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_06.gif" name="ac_5" onMouseOver="changesub(5)" onMouseOut="changesubout(5)" style="cursor:pointer;display:inline" onClick="changesubclick(5),fnOnChangTab(5)"></td>
                                    </tr>
                                    <tr id="tr_ac_6" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_07.gif" name="ac_6" onMouseOver="changesub(6)" onMouseOut="changesubout(6)" style="cursor:pointer;display:inline" onClick="changesubclick(6),fnOnChangTab(6)"></td>
                                    </tr>
                                </table>
                            </td>
                            <td width=5></td>
                            <td width=800 valign="top">
                                <table height="280" border="0" cellspacing="0" cellpadding="0" align="center">
                                    <tr>
                                        <td width="10" height="15"><img src="<%=dirPath%>/Sales/images/1.gif"></td>
                                        <td background="<%=dirPath%>/Sales/images/2.gif"></td>
                                        <td width="10"><img src="<%=dirPath%>/Sales/images/3.gif"></td>
                                    </tr>
                                    <tr>
                                        <td width="10" background="<%=dirPath%>/Sales/images/8.gif"></td>
                                        <td bgcolor="ffffcc" width=770>
                                        <!--------------------------------------------------------------------------- 
                                                                     �������
                                        ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ڸ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_noaccount_nm" id="v_noaccount_nm" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ݾ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        <!--------------------------------------------------------------------------- 
                                                       ������ü ����
                                        ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ڸ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_account_nm" id="v_account_nm" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ݾ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                            <!--------------------------------------------------------------------------- 
                                                                  EDI ī�� ����
                                            ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td width=30><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ݾ�</td>
                                                    <td width=230 bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
	                                                <td rowspan=7>���ڹ�����ȯ(EDI [Electronic Data Interchange]) ����� <br>
	                                                	�ſ�ī�� �����Դϴ�.<br><br>
	                                                	�ſ�ī�� ��ȣ�� ��ȿ�Ⱓ�� ������<br>
	                                                	������ �� �־�, ���� ������ �����մϴ�.<br>
	                                                	(��ȭ���ΰ� ������ ����Դϴ�.)<br><br>
	                                                	�ſ�ī�� ��ǥ�� ������ �� ����<br>
	                                                	���������� �����մϴ�.<br>
	                                                </td>

                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">ī���ȣ</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=r_card_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='150px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="0000-0000-0000-0000">
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>   
                                                    <td width="70" height="30" align="center">��ȿ�Ⱓ</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=v_expire_year classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='30px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="00">
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        &nbsp;��&nbsp;&nbsp;
                                                        
                                                        <object id=v_expire_month classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='30px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="00">
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        &nbsp;��
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�ҺαⰣ</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<select name="r_halbu_terms">
                                                            <option value="00">�Ͻú�
                                                            <option value="02">2����
                                                            <option value="03">3����
                                                            <option value="04">4����
                                                            <option value="05">5����
                                                            <option value="06">6����
                                                            <option value="07">7����
                                                            <option value="08">8����
                                                            <option value="09">9����
                                                            <option value="10">10����
                                                            <option value="11">11����
                                                            <option value="12">12����
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">���ι�ȣ</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=r_agree_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=IsComma     value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">��������</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=r_org_agree_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=Format      value=YY-MM-DD>
                                                            <param name=InputFormat value=YYYYMMDD>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">BC ī�� </td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input type=checkbox name=topChk id=topChk> BC Top����Ʈ ��뿩��
                                                    </td>
                                                </tr>


                                            </table>
                                            <!--------------------------------------------------------------------------- 
                                                                      ��ǰ�� ����
                                            ---------------------------------------------------------------------------->
                                            <table width="770" height="100%" border="0" cellspacing="0" cellpadding="0" id="ac" style="display:none" valign="abstop">
                                                <tr height="30">
                                                    <td align="right">
                                                        <table width="270" height="30" border="0" cellpadding="0" cellspacing="0" >
                                                            <tr>
                                                                <td align="right"><img src="<%=dirPath%>/Sales/images/add.gif" style="cursor:pointer" onClick="fnGiftAdd()"></td>
                                                                <td width="60" align="right"><img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:pointer" onClick="fnGiftDel()"></td>
                                                                <td width="68" align="center"><img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:pointer" onClick="fnGiftCancel()"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign=top>
                                                        
                                                        <object id=gr_gift classid=<%=HDConstant.CT_GRID_CLSID%> style="width=770; height:160px;border:1 solid #777777;">
                                                            <param name="DataID"        value="ds_gift">
                                                            <param name="BorderStyle"   value="0"> 
                                                            <param name="ColSizing"     value="true">
                                                            <param name="Editable"      value="True">
                                                            <Param Name="UsingOneClick"     value="1">
                                                            <Param Name="AllShowEdit"       value="True">
                                                            <param name="Format"        value="
                                                                <c> Name='����'        ID='GIFT_TYPE'     EditStyle=Lookup Data='ds_giftType:detail:detail_nm' Width=65  align=center </c>
                                                                <c> Name='����'        ID='FR_GIFT_SEQ'   Edit=Numeric EditLimit=6 Width=45</c>
                                                                <c> Name='����'        ID='TO_GIFT_SEQ'   Edit=Numeric EditLimit=6 Width=45</c>
                                                                <c> Name='�ż�'        ID='PAY_QTY'       Edit=None Width=40</c>
                                                                <c> Name='�ݾ�(õ��)'   ID='PAY_AMT'       Edit=None Width=75</c>
                                                            ">
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="10"></td>
                                                </tr>
                                                <tr id="div_giftList" style="display:none">
                                                    <td valign=top>
                                                        
                                                        <object id=gr_giftList classid=<%=HDConstant.CT_GRID_CLSID%> style="width=100%; height:160px;border:1 solid #777777;">
                                                            <param name="DataID"        value="ds_giftList">
                                                            <param name="BorderStyle"   value="0"> 
                                                            <param name="ColSizing"     value="true">
                                                            <param name="Editable"      value="False">
                                                            <Param Name="UsingOneClick"     value="1">
                                                            <Param Name="AllShowEdit"       value="True">
                                                            <param name="Format"        value="
                                                                <c> Name='�Ϸù�ȣ'     ID='GIFT_SEQ'     Edit=None Width=65 align=center</c>
                                                                <c> Name='����'        ID='GIFT_STATE'   Edit=None Width=45 align=center</c>
                                                                <c> Name='��ȿ�Ⱓ'     ID='EFFICACY_DAY' Edit=None Width=65 align=center</c>
                                                                <c> Name='�ݾ�(õ��)'   ID='PAY_AMT'      Edit=None Width=75</c>
                                                            ">
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                            <!--------------------------------------------------------------------------- 
                                                                �������Ա�
	                                        ---------------------------------------------------------------------------->
                                            <table width="770" height="100%" border="0" cellspacing="0" cellpadding="0" id="ac" style="display:none" valign="abstop">
                                                <tr>
                                                	<TD>
                                                		<table width=100%>
                                                		   <tr>
										                        <td align="left" width="70" height="10" class="text">���¹�ȣ</td>
																<td >&nbsp;<input name="v_bank_acc_no" id="v_bank_acc_no" type="text" style="width:130px;" class="textbox" readOnly>
			                                                    	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" align='absmiddle' onClick="fnBankAccountPopup()">
			                                                    </td>
                                                    			<td align="left" width="70" height="10" class="text">����</td>
			                                                    <td >&nbsp;<input name="v_bancod" type="text" style="width:50px;" class="textbox" readOnly>
            			                                        	<input type="text" name="v_banknm" size="10" class="textbox" readonly></td>
            			                                        <td colspan=2 align="right" ><img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:pointer" onClick="fnSelect()"></td>
                        			                        </tr>
															<tr>
	                                                            <td align="left" width="70" height="10" class="text">�����ݾ�</td> 
            			                                        <td >&nbsp;
                        			                                <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height="17" width='100px' align='absmiddle' class='textbox'>            
                                    			                        <param name=Alignment   value=1>
                                                			            <param name=ClipMode    value=true>
			                                                            <param name=Border      value=false>
            			                                                <param name=Enable      value=false>
                        			                                    <param name=SelectAll   value=true>
                                    			                        <param name=SelectAllOnClick      value=true>
                                                			            <param name=SelectAllOnClickAny   value=false>
			                                                        </object>
            			                                            
                                               				    </td>
																<td align=left width="70" height="10" class="text">�Ա�����</td>
																<td align=left>&nbsp;
																     
																     <object id=c_pay_date1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height="17" width="100"  class="textbox">
																		<param name=Alignment 	value=1>
																		<param name=Format      value="YYYY-MM-DD">
			                                        					<PARAM NAME=InputFormat value="YYYYMMDD">
																		<param name=ClipMode    value=true>
			                                                            <param name=Border      value=false>
			                                                            <param name=Enable      value=true>
			                                                            <param name=SelectAll   value=true>
			                                                            <param name=SelectAllOnClick      value=true>
			                                                            <param name=SelectAllOnClickAny   value=false>
			                                                            <param name=text value="">
																	</object>
																	&nbsp;
																</td>											  
																<td align="center" width="70" height="10" class="text">�� ��</td>       
																<td valign="middle">&nbsp;&nbsp;<input type=text name=v_order_nm id=v_order_nm class="textbox"></td>
			                                                </tr>
			                                             </table>
			                                          </td>
			                                        </tr>
			                                        <tr>
			                                        	<td height=180>
															
															<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="770" height="170" border="1">
															        <param name="DataID"            value="ds_tongjang">
															        <param name="BorderStyle"       value="0">
															        <param name="ColSizing"         value="True">
															        <param name="editable"          value="True">
															        <param name=SortView  			value="Left">
															        <param name="indwidth"			value="20">
															        <Param Name="UsingOneClick"     value="1">
															        <Param Name="AllShowEdit"       value="True">
															        <param name="Format"            value="
																	        <FC> name='����'        ID='JOB_SEL'        Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False bgColor={IF(REMAINED_DEPOSIT_AMT>0,'#FF0000','#0000FF')}</FC>
																			<C> name='���¹�ȣ'    	ID='v_bank_acc_no'  Width=100  align=center  show=true 	edit=none</C>
															                <C> name='�Ա�����'    	ID='c_pay_date1'  	Width=100  align=center  show=true 	edit=none</C>  
															                <C> name='�ŷ�����'  	ID='COL02'    		Width=100  align=center  show=true	edit=none</C>
															                <C> name='����'     	ID='v_order_nm'    	Width=130  align=left  	 show=true	edit=none</C>
															                <C> name='�����'   	ID='v_banknm'   	Width=80   align=center  show=true	edit=none</C>
														                    <C> name='�Աݾ�'    	ID='c_pay_amt'   	Width=70   align=RIGHT 	 show=true  edit=none	DEC=0</C>
														                    <C> name='����' 	    ID='c_use_amt' 		Width=70   align=RIGHT   show=true	edit=none   DEC=0</C>
															                <C> name='�ܾ�'    		ID='c_balance_amt'	Width=70   align=RIGHT   show=true	edit=none   DEC=0</C>

															                <C> name='�����ڵ�'   	ID='v_bancod'   	Width=100  align=center  show=false	edit=none</C>
															                <C> name='TR_SID'    	ID='TR_SID'  		Width=100  align=left    show=false	edit=none</C>

															        ">
															</object>
															
														</td>
													</tr>
												</table>
                                              <!--------------------------------------------------------------------------- 
																				��Ÿ��ü
	                                        ---------------------------------------------------------------------------->
                                            <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">��������</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
					                                    <object id=v_acc_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
					                                        <param name=ComboDataID     value=ds_accType>
					                                        <param name=ListExprFormat  value="detail_nm^0^100">
					                                    </object>
					                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�Ա��ڸ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_pay_empnmk" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�Ա�����</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="YYYY-MM-DD">
                                        					<PARAM NAME=InputFormat value="YYYYMMDD">
                                        					<param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=true>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                            <param name=text value="<%=totDay%>">
                                                        </object>
                                                        
                                                      </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ݾ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        <!--------------------------------------------------------------------------- 
															KCP �¶��� �ſ�ī��
                                        ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td width=30><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ڸ�</td>
                                                    <td width=230 bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_noaccount_nm" id="v_noaccount_nm" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
	                                                <td rowspan=2>�Ϲ����� �¶��� �ſ�ī�� ��������Դϴ�.<br><br>
	                                                	
	                                                	ī�� ������ ������ ���� �����ؾ� �ϰ�,<br>
	                                                	����������/�Ƚ�Ŭ�� ��<br>
	                                                	��ȣȭ�� �¶��� ���� ������ �����ϴ�.<br><br>
	                                                	
	                                                	�ſ�ī�� ��ǥ�� ������ �� �ֽ��ϴ�.<br>
	                                                </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">�����ݾ�</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>

                                        </td>
                                        <td background="<%=dirPath%>/Sales/images/4.gif"></td>
                                    </tr>
                                    <tr  height="10">
                                        <td><img src="<%=dirPath%>/Sales/images/7.gif"></td>
                                        <td background="<%=dirPath%>/Sales/images/6.gif"></td>
                                        <td><img src="<%=dirPath%>/Sales/images/5.gif"></td>
                                    </tr>
                                </table>
                            </td>
                            <td width=5></td>
                        </tr>
                        <tr height="10">
                            <td colspan=5></td>
                        </tr>                        
                    </table>
                    
                    <table width="100%" height="35" bgcolor="#66CCFF">
                        <tr>
                            <td width="250"></td>
                            <td align=right>
                            <%
                                if(v_card_no.equals("")){
                            %>
                                <img name=ac_btn_0 id=ac_btn_0 style="display:none; cursor:pointer" onClick="fnNonAccountTrans()"  	src="<%=dirPath%>/Sales/images/create.gif">
                                <img name=ac_btn_1 id=ac_btn_1 style="display:none; cursor:pointer" onClick="fnAccountTrans()" 		src="<%=dirPath%>/Sales/images/acc_transfer.gif">
                                <img name=ac_btn_2 id=ac_btn_2 style="display:none; cursor:pointer" onClick="fnCardTrans()"  		src="<%=dirPath%>/Sales/images/account.gif" alt="ī�����">
                                <img name=ac_btn_3 id=ac_btn_3 style="display:none; cursor:pointer" onClick="fnGiftTrans()"  		src="<%=dirPath%>/Sales/images/account.gif">
                                <img name=ac_btn_4 id=ac_btn_4 style="display:none; cursor:pointer" onClick="fnTongJangTrans()"  	src="<%=dirPath%>/Sales/images/account.gif">
                                <img name=ac_btn_5 id=ac_btn_5 style="display:none; cursor:pointer" onClick="fnEtcTrans()"  		src="<%=dirPath%>/Sales/images/account.gif">
                                <img name=ac_btn_6 id=ac_btn_6 style="display:none; cursor:pointer" onClick="fnEtcTrans()"  		src="<%=dirPath%>/Sales/images/account.gif">
                            <%
                                } else {
                            %>
                                <img name=ac_btn_2 id=ac_btn_2 style="display:none; cursor:pointer" onClick="fnCardCancel()"  		src="<%=dirPath%>/Sales/images/adm_cancel.gif" alt="ī�����">
                            <%
                                }
                            %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td><br><h3>������ �������� ���� ������ ���� �ٸ� ���콺�� Ű���� ������ ��� �����ֽñ� �ٶ��ϴ�.</h3>
                    <form name="acc_frm" method=post target="acc_iframe">
                        <!-- common -->
                        <input type=hidden name="c_pay_gubn">
                        <input type=hidden name="c_pay_manage_no">
                        <input type=hidden name="c_van_cd">
                        <input type=hidden name="c_pay_amt">
                        <input type=hidden name="c_acct_join_no">
                        <input type=hidden name="c_terminal_id">
                        <input type=hidden name="c_return_url" value="<%=HDConstant.KCP_RETURN_URL_ERP%>">
                        
                        <!-- account / noaccount request -->
                        <input type=hidden name="r_order_nm">
                        <input type=hidden name="r_order_email">
                        <input type=hidden name="r_user_key">
						<input type=hidden name="TR_SID">

                        <!-- card request -->
                        <input type=hidden name="r_app_type">
                        <input type=hidden name="r_card_no">
                        <input type=hidden name="r_valid_terms">
                        <input type=hidden name="r_halbu_terms">
                        <input type=hidden name="r_card_way_cd">
                        <input type=hidden name="r_agree_no">
                        <input type=hidden name="r_org_agree_date">
                        <input type=hidden name="r_remark">
                    </form>
                 </td>
            </tr>
        </table>
        
        <iframe name="acc_iframe" frameborder="0" height="0" width="0" marginheight="0" marginwidth="0" scrolling="yes" src=""></iframe>
  </body>
</html>