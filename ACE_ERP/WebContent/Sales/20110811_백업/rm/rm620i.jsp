<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�       : ������ ��ü
 * ���α׷�ID : RM620I
 * J  S  P   : Rm620i
 * �� �� ��        : Rm620i
 * �� �� ��        : �ɵ���
 * �� �� ��        : 2007-10-09
 * �������     : ������ �Աݳ����� ���������� ��ü
 * [��  ��   ��  ��][������] ����
 * [2008-01-11][�ɵ���] ���� �븮���� �ٸ� ��û����ȣ�� ��ü �����ϵ��� �ϴ� �׸��� �κ��� ����.
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
	
	String toDay     = m_today.format(date.getTime());
	
	date.set(java.util.Calendar.HOUR_OF_DAY, -24*15);
	String startDay = m_today.format(date.getTime());           
	date.add(java.util.Calendar.DATE, +30);
	String endDay = m_today.format(date.getTime());
	
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
            var v_default_row = 1;
            var v_job="";
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ �ε� 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit(); 
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : ����ȸ 
// Parameter    : 
%>
        function fnInit(){
            var refund_amt = 0;
            cfStyleGrid(getObjectFirst("gr_master"), "comn1");
            cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
            getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
            getObjectFirst("ds_goods").Reset();
        }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
        function fnSelect() {
            if(getObjectFirst("v_client_sid").value==""){
                alert("�븮���� ���� �˻��Ͻñ� �ٶ��ϴ�.");
                return;
            }
            
            if(getObjectFirst("v_fr_date").Text.trim()=="" || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("���� (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            
            if(getObjectFirst("v_to_date").Text.trim()=="" || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("���� (To) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            
            gr_master.ReDraw = "False";

            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                        + ",v_block_no="+getObjectFirst("v_block_no").Text
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text
                        + ",v_job_sel="+getObjectFirst("v_job_sel").value
                        + ",v_mi_ipkum_gu="+getObjectFirst("v_mi_ipkum_gu").value;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm620I",
                "JSP(O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
        }

    function fnSelectDetail(row) {
        v_default_row = row;
	    ds_detail.ClearAll();
	    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
    	            + ",v_block_sid="+ds_master.NameValue(v_default_row, "BLOCK_SID");
	                    
	    ln_TRSetting(tr2, 
	        "<%=dirPath%><%=HDConstant.PATH_RM%>Rm620I",
	        "JSP(O:DETAIL=ds_detail)",
	        v_param);
	    tr_post(tr2);
    }

	function fnSettle()
	{
		if (ds_detail.ConutRow <1) return;
	    refund_amt = ds_master.NameValue(v_default_row,"REFUND_AMT")-ds_master.NameValue(v_default_row,"PAY_AMT");	//���⿡ ������ �Ѿ��� �Ҵ�.	
	    
	    if (refund_amt > 0) {
			for( i=1; i<=ds_detail.CountRow; i++ ) {
				var pay_amt = 0;
				
				// �ǸŰ�-�Աݾ� >0 �� �� ���׸�ŭ ��ü����
				if(getObjectFirst("ds_detail").NameValue(i, "TOT_TOUR_AMT")-getObjectFirst("ds_detail").NameValue(i, "TOT_PAY_AMT")>0)
					pay_amt = getObjectFirst("ds_detail").NameValue(i, "TOT_TOUR_AMT")-getObjectFirst("ds_detail").NameValue(i, "TOT_PAY_AMT");
				
	        	if (refund_amt >= pay_amt) {
		            getObjectFirst("ds_detail").NameValue(i, "PAY_AMT")= pay_amt;
		            refund_amt = refund_amt - getObjectFirst("ds_detail").NameValue(i, "PAY_AMT");
		        } else {
		        	getObjectFirst("ds_detail").NameValue(i, "PAY_AMT")= refund_amt;
		        	refund_amt = 0;
		        }
		        
			}	
		} else {
			alert("��ü���ɾ��� ���  ��ü�Ϸ��Ͽ����ϴ�.");
		}
	}
	
	/* ���� */
	function fnApply() {
		if ( ds_detail.isUpdated ) {

            v_job = "I";
            window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm620I",
                "JSP(I:DETAIL=ds_detail,O:msgDS=msgDS)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
         } else {
         	alert("������Ʈ�� ���� �����ϴ�.");
		 }
	}	
	
    /**
     * ��û�� ��ȣ ��ȸ
     */
    function fnAcceptNoPopup(){
        if(ds_master.CountRow==0){
            alert("�� �����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }    

        v_cust_row = 0;
        var arrResult   = new Array();

        arrResult = fnAcceptNoPop2("<%=dirPath%>",getObjectFirst("v_client_cd").value);

        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("sAcceptNo").Text   = arrParam[1];
        } else {
            getObjectFirst("v_accept_sid").value = 0;
            getObjectFirst("sAcceptNo").Text   = "";
            }
    }

	

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�˾�
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "1");    
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

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� ���� ��� 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_master.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_detail").SetExcelTitle(0, "");
        getObjectFirst("gr_detail").SetExcelTitle(1, "value:������ ��ȸ ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_detail").GridToExcel("������ ��ȸ ��", "������ ��ȸ.xls", 32);

        getObjectFirst("gr_master").SetExcelTitle(0, "");
        getObjectFirst("gr_master").SetExcelTitle(1, "value:������ ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("������ ��ȸ", "������ ��ȸ.xls", 32);
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

<script language=javascript for="ds_master" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    gr_master.ReDraw = "True";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
    fnSelectDetail(v_default_row);        
</script>

<script language=javascript for="gr_master" event="OnClick(Row, Colid)">
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDetail(Row);
</script>

<script language=JavaScript for=v_fr_date event=OnKillFocus()>
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
</script>

<script language=javascript for="gr_detail" event="OnClick(Row,Colid)">
//	alert(tot_amt);	//������� ����...
//    if(tot_amt=0);
    
/*    if(Colid=="JOB_SEL"){
        if(getObjectFirst("ds_detail").NameValue(Row, Colid)=="T") {
        	if (tot_amt >= (getObjectFirst("ds_detail").NameValue(Row, "TOT_TOUR_AMT")-getObjectFirst("ds_detail").NameValue(Row, "TOT_PAY_AMT"))) {
	            getObjectFirst("ds_detail").NameValue(Row, "PAY_AMT")=getObjectFirst("ds_detail").NameValue(Row, "TOT_TOUR_AMT")-getObjectFirst("ds_detail").NameValue(Row, "TOT_PAY_AMT");
	            tot_amt = tot_amt - getObjectFirst("ds_detail").NameValue(Row, "PAY_AMT");
	        } else {
	        	getObjectFirst("ds_detail").NameValue(Row, "PAY_AMT")= tot_amt;
	        	tot_amt = 0;
	        }
        } else {
            tot_amt = tot_amt + getObjectFirst("ds_detail").NameValue(Row, "PAY_AMT");            
            getObjectFirst("ds_detail").NameValue(Row, "PAY_AMT")=0;
        }
    }*/
/*    if(Colid=="JOB_SEL"){
	    if(getObjectFirst("ds_detail").NameValue(Row, "TOT_PAY_AMT")>getObjectFirst("ds_detail").NameValue(Row, "TOT_TOUR_AMT")){
	        alert("�ǸŰ����� �Աݾ��� �� �����ϴ�.�����Ͻ� �� �����ϴ�.");
	        ds_detail.Undo(ds_detail.RowPosition);
    	}
    	
    }*/
</script>
<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);

	if(v_job=="I"){
		fnSelect();
	}
</script>

<script language="javascript" for="tr1" event="OnFail()">
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
        
  //�޽��� ó��
/*   var msg='';
   for(j=1; j<=msgDS.CountRow; j++ )
      msg+=msgDS.namevalue(j,"pMsg")+"\n";

   if (msgDS.CountRow > 0 ) {
      alert(msg);
      msgDS.ClearData();
   }  */      
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr2.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);

</script>

<script language="javascript" for="tr2" event="OnFail()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");

  //�޽��� ó��
/*   var msg='';
   for(j=1; j<=msgDS.CountRow; j++ )
      msg+=msgDS.namevalue(j,"pMsg")+"\n";

   if (msgDS.CountRow > 0 ) {
      alert(msg);
      msgDS.ClearData();
   }        */
        
</script>

<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<!-- �޽���  -->
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align=right>
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                        <img src="<%=dirPath%>/Sales/images/settle.gif" style="cursor:hand" onClick="fnSettle();">
                        <img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply();">
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">�븮��</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="" name="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">

                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">

                                    <input type="text" value="" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="" name="v_client_sid" readOnly>
                                </td>
                                <td width="100px" class="text">��ǰ�ڵ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=200 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^180">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text">�۾�����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<select name=v_mi_ipkum_gu class=textbox>
                                    <option value="T">��ü
                                    <option value="F">�� ��ü
                                    </select>
                                </td>
                            </tr>
                            <tr height="25px">
                                <td width="100px" class="text">��Ϲ�ȣ</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_block_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="0000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text"><select name="v_job_sel" class=textbox>
                                        <option value="1">��û����
                                        <option value="2">�������
                                    </select>
                                </td>
                                <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=startDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td>
                        <table border=0 cellspacing=0 cellpadding=0 width="100%">
                            <tr>
                                <td>
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=843; height:200px" border="1">
                                        <param name="DataID"            value="ds_master">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="FALSE">
                                        <param name="SuppressOption"    value="1">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="ViewSummary"       value="1">
                                        <param name="Format"            value=" 
                                            <FC>name='�������'	ID='DEPART_DATE'        Width=70    Edit=none align=CENTER mask='XXXX-XX-XX' suppress=1</FC>
                                            <C> name='��Ϲ�ȣ'	ID='BLOCK_NO'           Width=70   Edit=none align=Left suppress=2</C>
                                            <C> name='��ǰ'   	ID='GOODS_NM'           Width=80 SumText='���������ݾ�' Edit=none align=Left suppress=3</C>
                                            <C> name='����Ÿ��'	ID='C_ROOM_TYPE_SID'    Width=60   Edit=none align=Left suppress=4</C>
                                            <C> name='��Ͽ��\\��'	ID='BLOCK_AMT'      Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='������\\��=��*0.2'		ID='DEPOSIT_AMT'        Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='�Աݾ�\\��'		ID='TOT_AMT'       	Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='��Ÿ��'	ID='CUST_RATE_TYPE'    	Width=50   Edit=none align=Center</C>
                                            <C> name='����'		ID='CUST_RATE'	     	Width=50   Edit=none align=Center align=Right dec=0 MASK=XXXXX</C>
                                            <C> name='ȯ����\\��'		ID='REFUND_RATE'	   	Width=50   Edit=none align=Center align=Right dec=0</C>
                                            <C> name='��ü���ɾ�\\��=��*��'	ID='REFUND_AMT'        	Width=70   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='ȯ�Ծ�'		ID='EARNING_AMT'       	Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='��ü�Ϸ��'		ID='PAY_AMT'        Width=70   SumText=@sum Edit=none align=Right dec=0</C>

                                            <C> name='���Ǽ�'		ID='C_ROOM_CNT'     	Width=50   Edit=none align=Center</C>
                                            <C> name='�ο�'   	ID='CONFIRM_PERSONS' 	Width=50   Edit=none align=Center</C>
                                            <C> name='T/L'    	ID='TL_DATE'     	 	Width=60   Edit=none align=Right</C>
                                        ">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr>                            
                                <td HEIGHT="10"></td>
                            </tr>
						</table>
					</td>
				</tr>

                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">��û����ȣ</td>
                                <td width="450px" align="left" bgcolor="#ffffff">&nbsp;
									<%=HDConstant.COMMENT_START%>
                                    <object id=sAcceptNo classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="00000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Enable      value=false>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()"></td>
                            </tr>      
						</table>
					</td>
				</tr>
				
                <tr>
                    <td>
                        <table border=0 cellspacing=0 cellpadding=0 width="100%">
                            <tr>                            
                                <td HEIGHT="10"></td>
                            </tr>
                            <tr>                            
                                <td>
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_detail  style="width=843; height:300px" border="1">
                                        <param name="DataID"            value="ds_detail">
				                        <param name="BorderStyle"       value="0">
				                        <param name="ColSizing"         value="true">
				                        <param name="editable"          value="True">
				                        <param name="SuppressOption"    value="1">
				                        <Param Name="UsingOneClick"     value="1">
				                        <Param Name="AllShowEdit"       value="True">
				                        <param name="ViewSummary"       value="1">
				                        <param name="Format"            value=" 
				                            <FC> name='NO'           ID='{CURROW}'        Width=35   edit=none align=center SUMTEXT=@COUNT</FC>
				                            <C> name='����'           ID='CUST_NM'        Width=70   Edit=none align=Left suppress=3</C>
				                            <C> name='�������'       ID='STATUS_CD'     Width=60  Edit=none align=center </C>
				                            <C> name='����\\�ڵ�'     ID='ROOM_TYPE_NM'   Width=50   Edit=none align=Left suppress=5  show=false</C>
				                            <C> name='����\\�ڵ�'     ID='CUST_TYPE_NM'   Width=50    Edit=none align=Center suppress=6 Dec=0  show=false</C>
				                            <C> name='�ǸŰ�'         ID='TOT_TOUR_AMT'   Width=70   SumText=@sum Edit=none align=Right Dec=0</C>
				                            <C> name='�Աݾ�'         ID='TOT_PAY_AMT'    Width=70   SumText=@sum Edit=none align=Right Dec=0</C>
				                            <C> name='��ü��'         ID='PAY_AMT'        Width=70   SumText=@sum Edit=Numeric Dec=0 align=Right edit=none</C>
				                            <C> name='�ֹ�/���ǹ�ȣ'  ID='MANAGE_NO'      Width=100   Edit=none align=Left </C>
				                            <C> name='��û����ȣ'       ID='ACCEPT_NO'      Width=120   Edit=none align=center</C>

				                            <C> name='������\\������ȣ' ID='PAY_MANAGE_NO'  Width=100  Edit=none align=center mask='XXXXXX-XXXX' </C>
				                            <C> name='������\\�Ա�����'      ID='PAY_DATE'     Width=60  Edit=none align=CENTER </C>
				                            <C> name='������\\���SID'     ID='BLOCK_SID'     Width=60  Edit=none align=center </C>
				                            <C> name='�������'       ID='DEPART_DATE' Width=70   SumText=@count Edit=none align=Left show=false</C>
				                            <C> name='����SID'       ID='RSV_SID'     Width=70  Edit=none align=center SHOW=FALSE</C>
				                            <C> name='CLIENT_SID'    ID='CLIENT_SID'     Width=60  Edit=none align=Right  show=false</C>

				                        ">
				                    </object>                                    
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


