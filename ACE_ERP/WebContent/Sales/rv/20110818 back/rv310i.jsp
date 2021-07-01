<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ���� ��� ����
 * ���α׷�ID 		: RV310I
 * J  S  P		: Rv310i
 * �� �� ��		: Rv310i
 * �� �� ��		: �迵��
 * �� �� ��		: 2006-06-28
 * �������		: ���� ��� ����
 * ��������		: 
 * �� �� ��		: �迵��
 * ������������ 	: 2006-06-28 
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-12-24][�ɵ���] �������� �߰�...
 * [2008-05-10][�ɵ���] ��ȸ�Ͽ� �������ܱ� ��ü�� ���������� ���� ��� �������� �Ұ�
 * [2009-03-27][�ɵ���] �̸� �÷� ��Ʈ �߰�.. �ʿ��� ��� ������ ��ȸ ���� ����..
 * [2010-01-14][�ɵ���] ����â �˾��� �Ķ���� �߰� = ���õ� ��������
 * [2010-06-08][�ڰ汹] ��ȸ���ǿ� [��ǰ����][��������] �߰�. ��ȸ�� �÷��� [��������] �߰�.
 * [2010-06-14][���ϳ�] ������ ù��° row �ݾ� �Է� �� Ŭ����, ��ü ,row ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	 
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    
    String startDay = m_today.format(date.getTime());           
    date.add(java.util.Calendar.DATE, +2);
    String endDay = m_today.format(date.getTime());

    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
		<script language="javascript">
		var div='';

	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		div = 'init';
			fnInit(); 
		}

		function fnInit(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
            getObjectFirst("ds_goods").Reset();

			codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs1.Reset(); //�����ڵ�
           
		}

		function fnSelect() {
            /*if(getObjectFirst("v_client_sid").value==""){
                alert("�븮���� ���� �˻��Ͻñ� �ٶ��ϴ�.");
                return;
            }*/
            
            if(getObjectFirst("v_depart_date1").Text.trim()=="" || getObjectFirst("v_depart_date1").Text.trim().length!=8){
                alert("������� (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date1").Focus();
                return;
            }
            
            /*if(getObjectFirst("v_depart_date2").Text.trim()=="" || getObjectFirst("v_depart_date2").Text.trim().length!=8){
                alert("������� (To) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date2").Focus();
                return;
            }*/
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                        + ",v_depart_date1="+getObjectFirst("v_depart_date1").Text
                        + ",v_depart_date2="+getObjectFirst("v_depart_date1").Text
                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                        + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
	      		        + ",v_pay_seq=" + v_payseq.ValueOfIndex("pay_seq", v_payseq.Index)
                        + ",v_cust_nm="+getObjectFirst("v_cust_nm").value
                        + ",v_pay_gubn="+getObjectFirst("v_pay_gubn").value
   	                    + ",v_saup_sid=" + v_saup_sid.ValueOfIndex("saup_sid", v_saup_sid.Index);
            
            if(getObjectFirst("v_cancel_yn").checked)
                v_param = v_param + ",v_cancel_yn=RC";
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv310I",
                "JSP(O:DEFAULT=ds1)",
                v_param);
            tr_post(tr1);
		}

		function fnApply() {
		}

    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            v_client_sid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          v_client_sid.value = "";
        }               
    }
    /**
     * ��û�� ��ȣ ��ȸ
     */
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop("<%=dirPath%>");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
        }
    }
    //��ǰ����
		function fnSelectBound(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                  + ",v_accept_no=" + v_accept_no.Text;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
	            "JSP(O:DS_BOUND=ds_bound)",
	            param);
	           
	        tr_post(tr1);
	    }
	    
		//��������
		function fnSelectPayseq(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                  + ",v_accept_no=" + v_accept_no.Text
				          + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
		                  ;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
	            "JSP(O:DS_PAYSEQ=ds_payseq)",
	            param);
	        tr_post(tr1);
	    }
	    

	//��� ������ư
    function fnAccount() {
        var v_sel_cnt = 0;
        var v_account_amt = 0;
        var v_client_cd = "";
        var v_client_sid = "";
        
        if(getObjectFirst("ds1").CountRow==0){
            alert("���� ��ȸ�� Ŭ���Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        for(var i=1; i<=getObjectFirst("ds1").CountRow; i++){
            if((getObjectFirst("ds1").NameValue(i, "JOB_SEL")=="T")	|| (getObjectFirst("ds1").NameValue(i, "JOB_SEL2")=="T")){
                v_sel_cnt++;
                v_account_amt += getObjectFirst("ds1").NameValue(i, "PAY_AMT");
                v_client_cd = getObjectFirst("ds1").NameValue(i, "CLIENT_CD");
                v_client_sid = getObjectFirst("ds1").NameValue(i, "CLIENT_SID");
                
              
              
              
                if(getObjectFirst("ds1").NameValue(i, "PAY_AMT")==0){
                    alert("������ �ݾ��� �Է��Ͻñ� �ٶ��ϴ�.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                }
                
                if(eval(getObjectFirst("ds1").NameValue(i, "PAY_AMT"))>eval(getObjectFirst("ds1").NameValue(i, "ARREARS_AMT"))){
                    alert("������ �ݾ��� ���� �̳��� ���� �� ���� �ݾ��Դϴ�.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                }
               
                if(getObjectFirst("ds1").NameValue(i, "AFTER_CU")=="1"){
                	// 1. ��ü�ο� �������� ���
                	// 2. ��ü�ο� �������̸鼭 ������+�Աݾ��� ���ݺ��� ���� ��쿡�� ���â�� ����. 
                   	if((eval(getObjectFirst("ds1").NameValue(i, "PAY_AMT"))+eval(getObjectFirst("ds1").NameValue(i, "TOT_PAY_AMT")))<eval(getObjectFirst("ds1").NameValue(i, "DEPOSIT_AMT"))){
                    alert("���ݺ��� ���� �ݾ��Դϴ�.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                	}
                }
            }
        }
        
        if(v_sel_cnt==0){
            alert("���õ� ������ �����ϴ�.");
            return;
        }
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var v_pay_manage_no ="";
        var v_pay_date = "<%=DateUtil.getCurrentDate(8)%>";	//���⼭ �Ա����� ����Ʈ ������ �غθ���..�쾾.. ������ �ε� Ÿ�̹��� ��¥�� ������ ����!! �ѳ��� ���� �� ���� �� ACCEPT_DATE�� PAY_DATE�� �޶����� ��..;
        var v_pay_cd = "";
        var v_plan_pay_date = "";   //�Աݿ�������
        
        /**���� �׸�
         * arrParam[0]
         * 0 : ������� ��ü
         * 1 : ������ü (������)
         * 2 : �ſ�ī��
         * 3 : ��ǰ�ǰ���
         * 4 : �������Ա�
         * 5 : ��Ÿ��ü
         * 6 : �ſ�ī�� Online
         */
		//������
        arrParam[0] = "1011101";
		//�븮����
//        arrParam[0] = "1010000";
        arrParam[1] = v_client_cd;
        arrParam[2] = v_account_amt;
        arrParam[3] = ds1.NameValue(ds1.RowPosition, "GOODS_NM");
        
        arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";     //�ܸ����ȣ
        arrParam[5] = "<%=HDConstant.KCP_TERM_ID%>";    //������ü �� ������� �͹̳� ID
        arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP%>";  //������ü �� ������� ������ ��ȣ
        arrParam[7] = v_client_sid;                     //�븮�� Sid
        arrParam[8] = ds1.NameValue(ds1.RowPosition, "CUST_NM");
//prompt("","<%=dirPath%>");
//prompt("",arrParam);

		//���⼭ ����â ��!
        arrResult = fnCreditPop("<%=dirPath%>", arrParam);
//alert("arrResult : " + arrResult);	���⼭�� ����� �޾ƿ��� �����Ա�����..



		//���� �� ���� ������ ������Ʈ �ϴ� �κ�.. 
        if(arrResult!=null && arrResult!=undefined){
            arrParam = arrResult.split(":");
            v_pay_cd = arrParam[0];
            v_pay_manage_no = arrParam[1];
            if(arrParam.length>2)
                v_plan_pay_date = arrParam[2];
            
//alert("arrParam : " + arrParam + " v_pay_cd : " +  v_pay_cd + " v_pay_manage_no : " + v_pay_manage_no);
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_client_cd="+v_client_cd
                        + ",v_pay_manage_no="+v_pay_manage_no
                        + ",v_account_amt="+v_account_amt
                        + ",v_pay_date="+v_pay_date
                        + ",v_pay_cd="+v_pay_cd
                        + ",v_plan_pay_date="+v_plan_pay_date;
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv310I",
                "JSP(I:DEFAULT=ds1)",
                v_param);
            tr_post(tr_save);
        }
    }

	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds_goods" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("��ǰ���� <%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
	fnSelectBound();
</script>

<script language=JavaScript for=v_bound event=OnSelChange()>
 	if( div !="loadBound"){
		fnSelectPayseq();
	}
</script>

 <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
	 	div = "loadBound";	
 		ds_bound.insertrow(1);
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "0";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_NM") = "��ü";
		v_bound.Index = 0; 
		div="";		
    </script>

<script language=JavaScript  for=ds_payseq event="OnLoadCompleted(row)">
 		ds_payseq.insertrow(1);
		ds_payseq.namevalue(ds_payseq.rowposition, "PAY_SEQ") = "0";
		ds_payseq.namevalue(ds_payseq.rowposition, "PAY_NM") = "��ü";
		v_payseq.Index = 0;
    </script>

<script language=javascript for="gr1" event="OnClick(Row,Colid)">
	//���� Ŭ������ ��
    if(Row==0) {
        if(Colid == "JOB_SEL"){
            for(var i=1; i<=ds1.CountRow; i++){
//            alert(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT"));
            	//������ �ܱ� ���� �ѵ鸸.
				if(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT")==0){
	                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	                
	                if(getObjectFirst("ds1").NameValue(i, Colid)=="T")
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=getObjectFirst("ds1").NameValue(i, "ARREARS_AMT");
	                else
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=0;
				};
            }
        }else if(Colid == "JOB_SEL2"){ //����
            for(var i=1; i<=ds1.CountRow; i++){
//            alert(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT"));
            	//������ �ܱ� ���� �ѵ鸸.
				if(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT")==0){
	                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	                
	                if(getObjectFirst("ds1").NameValue(i, Colid)=="T")
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=getObjectFirst("ds1").NameValue(i, "DEPOSIT_AMT");
	                else
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=0;
				};
            }
        }else if(Colid == "PAY_AMT"){
            for(var j=1; j<=ds1.CountRow; j++){
	            	        // alert(getObjectFirst("ds1").NameValue(j,"PAY_AMT"));
	            	         ds1.NameValue(j, Colid) = ds1.NameValue(1, Colid);
           };
         }   
        return;
    }


    if(Colid=="JOB_SEL"){
		//�����ݴ�ü ����� ���� ���� 2008-05-10 by �ɵ���
		if(getObjectFirst("ds1").NameValue(Row, "REMAINED_DEPOSIT_AMT")>0){
			alert("["+getObjectFirst("ds1").NameValue(Row, "CUST_NM")+"]���� ������ ��ü�� �Ϸ���� �ʾ� ���� ������ �� �����ϴ�.\n��������ڿ��� �����ݴ�ü�� ��û���ּ���.");
			getObjectFirst("ds1").NameValue(Row, "JOB_SEL")="F";
		}else{
			//���� Ŭ���̺�Ʈ 
	        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T"){
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=getObjectFirst("ds1").NameValue(Row, "ARREARS_AMT");
	        }else{
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=0;
	        };

		    if(getObjectFirst("ds1").NameValue(Row, "TOT_PAY_AMT")>getObjectFirst("ds1").NameValue(Row, "TOT_TOUR_AMT")){
		        alert("�ǸŰ����� �Աݾ��� �� �����ϴ�.�����Ͻ� �� �����ϴ�.");
		        ds1.Undo(ds1.RowPosition);
		    };
	
		};
	};	
	
	 if(Colid=="JOB_SEL2"){
		//�����ݴ�ü ����� ���� ���� 2008-05-10 by �ɵ���
		if(getObjectFirst("ds1").NameValue(Row, "REMAINED_DEPOSIT_AMT")>0){
			alert("["+getObjectFirst("ds1").NameValue(Row, "CUST_NM")+"]���� ������ ��ü�� �Ϸ���� �ʾ� ���� ������ �� �����ϴ�.\n��������ڿ��� �����ݴ�ü�� ��û���ּ���.");
			getObjectFirst("ds1").NameValue(Row, "JOB_SEL2")="F";
		}else{
			//���� Ŭ���̺�Ʈ 
	        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T"){
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=getObjectFirst("ds1").NameValue(Row, "DEPOSIT_AMT");
	        }else{
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=0;
	        };

		    if(getObjectFirst("ds1").NameValue(Row, "TOT_PAY_AMT")>getObjectFirst("ds1").NameValue(Row, "TOT_TOUR_AMT")){
		        alert("�ǸŰ����� �Աݾ��� �� �����ϴ�.�����Ͻ� �� �����ϴ�.");
		        ds1.Undo(ds1.RowPosition);
		    };
	
		};
	};	
    
</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr_save.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr_save.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);

    fnSelect();
</script>

<script language="javascript" for="tr_save" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
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

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����������� -->
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ���� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_payseq classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/account.gif" style="cursor:hand" onClick="fnAccount()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td align="center" width="100px" class="text">�븮��</td>
                                <td COLSPAN=3 align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
                                </td>
                                <td   align="center" width="100px" class="text">��ݱ���</td>
                                <td colspan='3' align="left" bgcolor="#ffffff">&nbsp;<select name=v_pay_gubn class="text">
                                        <option value="N">�������
                                        <option value="Y">OPTION���
                                    </select>
                                    &nbsp;��������� <input type=checkbox name=v_cancel_yn>
                                </td>
                            </tr>
                            <tr height="25px">
		                        <td  align="center" class="text" >����</td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=v_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
		                                <param name=ComboDataID     value=codeDs1>
		                                <param name=ListExprFormat  value="saup_nm^1^80,saup_sid^1^40">
										<param name=SearchColumn	value="saup_nm">
										<param name=BindColumn		value="saup_sid">
		                            </object>
		                            <%=HDConstant.COMMENT_END%>
		                        </td>
                                <td  align="center" width="100px" class="text">��ǰ�ڵ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            
                                <td  align="center"  width="100px" class="text">�������</td>
                                <td colspan='3'  align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date1 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=startDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;&nbsp;
                                    <!--  <object id=v_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>-->
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr height="25px">
                                <td  align="center" width="100px" class="text">��û����ȣ</td>
                                <td  clospan='2' align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="000000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
	                                <td  align="center" width="100px" class="text">��ǰ����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_bound classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=50 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_bound>
                                            <param name=SearchColumn	value="BOUND_NM">
                                            <param name=BindColumn  	value="BOUND_SEQ">
                                            <param name=ListExprFormat  value="BOUND_NM^0^50">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td  align="center" width="100px" class="text">��������</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_payseq classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_payseq>
                                            <param name=SearchColumn	value="PAY_NM">
                                            <param name=BindColumn  	value="PAY_SEQ">
                                            <param name=ListExprFormat  value="PAY_NM^0^50">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>  
                                <td width="100px" class="text">����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="13" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>             
                <tr>
                    <td colspan="2">
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:360px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="True">
                        <param name="SuppressOption"    value="1">
                        <Param Name="UsingOneClick"     value="1">
                        <Param Name="AllShowEdit"       value="True">
                        <param name="ViewSummary"       value="1">
                        <Param Name="SortView"     value="Right">
                        <param name="Format"            value=" 
                            <FC> name='��ü��'         ID='JOB_SEL'        Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False bgColor={IF(REMAINED_DEPOSIT_AMT>0,'#FF0000','#0000FF')}</FC>
                            <FC> name='����'         ID='JOB_SEL2'      Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False bgColor={IF(REMAINED_DEPOSIT_AMT>0,'#FF0000','#0000FF')}</FC>
                            <FC> name='NO'            ID='{CURROW}'       Width=35   edit=none align=center</FC>
                            <FC> name='��������'     	ID='PAY_SEQ'       	width=60	align=center editlimit=2 show=true </FC>
                            <FC> name='��ǰ'          ID='GOODS_NM'       Width=100  SumText='�ѰǼ�' Edit=none align=Left suppress=1</FC>
                            <C> name='�������'       ID='DEPART_DATE'    Width=60   SumText=@count Edit=none align=Left suppress=2</C>
                            <C> name='����'           ID='CUST_NM'        Width=60   Edit=none align=Left suppress=3 SUMTEXT=@CNT sort=True</C>
                            <C> name='�ֹ�/���ǹ�ȣ'  ID='MANAGE_NO'      Width=60   SumText='���������ݾ�' Edit=none align=Left suppress=4 show=true</C>
                            <C> name='����\\�ڵ�'     ID='ROOM_TYPE_NM'   Width=50   Edit=none align=Left suppress=5</C>
                            <C> name='����\\�ڵ�'     ID='CUST_TYPE_NM'   Width=50    Edit=none align=Center suppress=6< Dec=0/C>
                            <C> name='�ǸŰ�'         ID='TOT_TOUR_AMT'   Width=60   SumText=@sum Edit=none align=Right Dec=0</C>
                            <G> name='�Աݾ�'
                            <C> name='�Աݾ�'         ID='TOT_PAY_AMT'    Width=60   SumText=@sum Edit=none align=Right Dec=0</C>
                            <C> name='���Աݾ�'       ID='MI_PAY_AMT'     Width=60  SumText=@sum Edit=none align=Right Dec=0</C>
                            </G>
                            <C> name='�̳���'         ID='ARREARS_AMT'    Width=60   SumText=@sum Edit=none align=Right Dec=0</C>
                            <C> name='����'         ID='DEPOSIT_AMT'    Width=60   SumText=@sum Edit=none align=Right Dec=0 show=false</C>
                            <C> name='������'         ID='PAY_AMT'        Width=60   SumText=@sum Edit=Numeric Dec=0 align=Right</C>
                            <C> name='��û��ȣ'       ID='ACCEPT_NO'      Width=90   Edit=none align=Left</C>
                            <C> name='���SID'        ID='BLOCK_SID'      Width=60   Edit=none align=Left show=false</C>
                            <C> name='�����ܱ�'       ID='REMAINED_DEPOSIT_AMT' Width=90 Edit=none align=RIGHT DEC=0 show=TRUE</C>
                            <C> name='����ñ�'       ID='AFTER_CU'      Width=60   Edit=none align=Left show=false</C>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
     <tr>
         <td>
         	<table>
         	  <tr>
         	  	<td valign=top>
		         �� GRID�� [����] �׸� ������ ��Ÿ���ϴ�.<br>
		         ��<font color=blue>�Ķ�</font> : ���� �ٷ� ������ �� �ֽ��ϴ�.<br>
		         ��<font color=red>����</font> : <b>��� �������� ��ü�� ��</b> ������ �� �ֽ��ϴ�.<br>
		         ����������������ڿ��� �������ּ���.<br>
         	  	</td>
         	  	<td valign=top>
		         �� <font color=red><b>������� ���� ���ǻ���</b></font><br>
		         �����¹�ȣ�� �����ϸ� "���¹�ȣ�ȳ�â"�� ��ϴ�.<br>
		         �����¹�ȣ�� �����Ͻ� �� �ݵ�� <b>Ȯ��</b>�� ���� â�� �ݾ��ּ���.<br>
		         �����˾� â�� �����鼭 <b>�߰� ���� �۾�</b>�� ����ǹǷ�,<br> 
		         ����Ȯ���� ������ ���� ���¿��� ������ü�� �Ͻ� ���<br>
		         ����<B>�Ա�Ȯ���� �ڵ� ó������ �ʽ��ϴ�</b>.<BR>
		         �� �������� �� ��ȸ: ��û����ȣ => ��ǰ���� ���� �� ���������� ���� �����մϴ�.
         	  	</td>         	  	
         	  </tr>
         	</table>
         </td>
     </tr>
</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


