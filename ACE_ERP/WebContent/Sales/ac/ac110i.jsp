<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ���밴�� ��� ����
 * J  S  P      : AC110I
 * �� �� ��     : AC110I
 * �� �� ��     : �̺���
 * �� �� ��     : 2006-08-10
 * �������     : ���밴�� ��� ����
 * [ �������� ][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-10-31][�ɵ���] ���� �� �߰� 
 * [2010-01-06][�ɵ���] �׸��� �÷� ����(���λ󼼳��� ���)
 * [2010-01-06][�ɵ���] ������ ���� : ���������� ������� 
 *						��, �����ϸ� �ش� ������ڿ� ������ ���������� �˻��Ǵ� ���̴�~!
 *						�� �������� ���� ���� ? 
 * �� ������ ���ν��� ���� �޼��� ������ ǥ������ �ﵵ�� ������ ����. ~ !!!!!!
 * ds_result�� ���� ������ �޼����� ���� �ɷ� ó���Ѵٸ� , ������ tr�̺�Ʈ���� ���� �޼��� ó���� �ʿ��������..
 * ��� �̺�Ʈ�� �켱�ϴ��� Ȯ���ؾ� �� �� : with ���븮��.
 * [2014-01-23][�ɵ���] ���� �׽�Ʈ
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
    //date.set(java.util.Calendar.HOUR_OF_DAY, 240);
    String firstday = m_today.format(date.getTime());
    date.add(java.util.Calendar.DATE, +2);
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
        var v_accept_sid = "";
        var v_job="";        
        
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ �ε�
// Parameter    :
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

        fnInit();

        codeDs1.deleterow(1);
        codeDs3.deleterow(1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : ����ȸ
// Parameter    :
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		v_job="I";
		
		// ��ǰ���� : 
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_ARRIVE_GOODS_DS=codeDs7)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		// ����
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:RV014=codeDs6)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
			//2007-05-10 ���λ� �߰� by �ɵ��� 
			//�������� (����=Y, ����=N)
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM021&s_item1=Y";
            codeDs1.Reset();
            
            //��������(cust_type)	
            // �������� ��ȸ�ǹǷ� ���⼭�� �������� �ش��ϴ� �͸� ������..��������
            codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2"
							+"&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+"&s_Head=RV003"
							+"&s_item1=Y"	// ��� Y
							+"&s_item3=Y";	// ������ Y. 
            codeDs2.Reset();

            //���ֿ��� (����=Y, ު����=N)
            codeDs3.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM020&s_item1=Y";
            codeDs3.Reset();
            
            //�ָ����� (�ָ�=Y, ����=N)
            codeDs4.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM019&s_item1=Y";
            codeDs4.Reset();
			
            //�׸��ڵ�(theme_cd)
            codeDs5.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM018&s_item1=Y";
            codeDs5.Reset();
			
		getObjectFirst("sSDate").focus();	
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    :
%>
    function fnSelect() {
        v_job = "S";
    	if (getObjectFirst("sAcceptNo").Text.trim() =="" && getObjectFirst("sSDate").Text.trim() =="") {
	    	alert ("��û�� ��ȣ �Ǵ� ������� �Է��ϼ���!");
	    	return;
    	}

    	v_accept_sid = getObjectFirst("v_accept_sid").value;

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sSDate="+getObjectFirst("sSDate").Text
                    + ",sAcceptNo="+getObjectFirst("sAcceptNo").Text
                    + ",sRoomType=" + getObjectFirst("sRoomType").Text
                    + ",sPrice=" + getObjectFirst("sPrice").Text
                    + ",sCustNm="+getObjectFirst("sCustNm").value
                    + ",v_out_gubn="+ v_out_gubn.value
                    + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
                    + ",sClientSid="+ sClientSid.value;

        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac110I",
            "JSP(O:DEFAULT=ds1)",
            v_param);


        tr_post(tr1);

        if ( ds1.CountRow > 0) {
				if(ds1.namevalue(ds1.RowPosition,"ACCT_CLOSE_YN") == 'Y' ){
				gr1.Editable = 'false';
				}else{
				gr1.Editable = 'true';
				}
			}

		if(getObjectFirst("sAcceptNo").Text == "" ){
            getObjectFirst("save_amt_btn").style.display = "none";
            }
    }

   /**
     * ���� �Լ�
     */
    function fnApply() {
    	v_job="A";
    	
        if (ds1.IsUpdated) {
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac110I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr1);
        } else {
            alert("���� ������ �����ϴ�.");
        }
    }

    /*
     * �ǸŰ� ��� ����
     */
    function fnSaveAmt(){
        v_job = "C";

        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac110I",
            "JSP(O:DS2=ds_result)",
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,v_accept_sid="+v_accept_sid);
        tr_post(tr2);

    }

	//�湮Ƚ�� ���� 
	function fnNorthCnt(){
        v_job = "N";

        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }

        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac110I",
            "JSP(I:DS3=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        tr_post(tr1);
	};


<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� ���� ���
// Parameter    :
%>
    function fnExcel() {
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�Ǹ� ���Ƿ� ����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�Ǹ� ���Ƿ� ����", "�Ǹ� ���Ƿ� ����.xls", 8);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�˾�
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnClientPop("<%=dirPath%>", "");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            sClientSid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          sClientSid.value = "";
        }
    }

    /**
     * ��û�� ��ȣ ��ȸ
     */
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop1("<%=dirPath%>",getObjectFirst("sSDate").Text);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("sAcceptNo").Text   = arrParam[1];
        } else {
            getObjectFirst("v_accept_sid").value = 0;
            getObjectFirst("sAcceptNo").Text   = "";
            getObjectFirst("save_amt_btn").style.display = "none";
            }
    }


  /**
     * ����Ÿ��
     */
    function fnRoomTypePopup(){
        var arrResult   = new Array();

        var arrParam = "";
   		var strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
    	var strPos = "dialogWidth:495px;dialogHeight:389px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,arrParam,strPos);

        if (arrResult != null) {

            arrParam = arrResult.split(";");
            getObjectFirst("sRoomType").Text = arrParam[1];

        }
    }
<%
////////////////////////////////////////////////////////////////////////////////
// Description �Աݹ�� ���� �˾�

%>

 function fnConfirmView(dir) {
	var arrParam    = new Array();
    var arrResult   = new Array();

	var pay_sid = ds_detail.namevalue(ds_detail.rowposition, "PAY_SID1");
	var pay_manage_no = ds_detail.namevalue(ds_detail.rowposition, "PAY_MANAGE_NO");



		if (pay_sid == "020") { // �������
			var strURL = dir+"/Sales/help/rv007h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "030") { // ������ü
			var strURL = dir+"/Sales/help/rv008h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "040") { // �ſ�ī��
			var strURL = dir+"/Sales/help/rv009h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "060") { // ��ǰ��
			var strURL = dir+"/Sales/help/rv010h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else {
			return;
		}

    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

    arrResult =  showModalDialog(strURL,arrParam,strPos);

    }
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds_goods" event="OnLoadCompleted(row)">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_result" event="OnLoadCompleted(row)">

	if(row==0)
		return;

	var alert_msg = "";
	for(var i=1; i<=row; i++){
		if(ds_result.NameValue(i, "MSG_CD")!="0000")
			alert_msg += ds_result.NameValue(i, "MSG") +"\n";
	}

	if(alert_msg!="")
		alert(alert_msg);
/*	else {
		alert("�ǸŰ� ����� �Ϸ�Ǿ����ϴ�.");
		fnSelect();
	}*/

</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>

<script language=javascript for="gr1" event="OnClick(Row, Colid)">
// ���� ������ ��.. ��ü ���� ������ �̺�Ʈ
        if(Row==0){
            if(ds1.CountRow==0) return;

            if(Colid=="CAROWNER_YN"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="CUST_TYPE"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="WEEKEND_YN"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="THEME_CD"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }                                    
            
/*            if(Colid=="AGE_CD"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }*/
            if(Colid=="USE_AMT"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "USE_AMT") = ds1.NameValue(1, "USE_AMT");
                }
            }
            if(Colid=="STD_AMT"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "STD_AMT") = ds1.NameValue(1, "STD_AMT");
                }
            }
            return;
        }
</script>

<script language="javascript"  for="gr1" event=OnCloseUp(row,colid)>
// ��� �÷��� ���� (��������) �ϰ� ���� �� �߻��ϴ� �̺�Ʈ : 20071031
	if(colid=="CUST_TYPE"){
//		alert("Occur OnCloseUp Event :" + "<ROW :" + row +">"+ "<Colid :" + colid+ ">" );
//		alert(ds1.NameValue(row,"CUST_TYPE"));
		gr1.ColumnProp("USE_AMT","Edit")=1;
		
//		alert("��");
		
	};
</script>



<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    if(row==0){
    	v_accept_sid = "";
    	getObjectFirst("save_amt_btn").style.display = "none";
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }

    if(v_accept_sid!=""){
    	getObjectFirst("save_amt_btn").style.display = "inline";
    }
</script>


<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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

<script language="javascript" for="tr2" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

	var alert_msg = "";
	
	for(var i=1; i<=ds_result.CountRow; i++){
		if(ds_result.NameValue(i, "MSG_CD")!="0000")
			alert_msg += ds_result.NameValue(i, "MSG") +"\n";
	}

	if(alert_msg!="")
		alert(alert_msg);
	else {
		alert("�ǸŰ� ����� �Ϸ�Ǿ����ϴ�.");
		fnSelect();
	}
    	
    ds_result.ClearAll();
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="")
        alert(error_msg);							//20070619 : ���긶���� ��� ���⼭ �޼��� ����ݴϴ�.
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>



<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/prize_cal.gif" style="cursor:pointer;display:none" id="save_amt_btn" onClick="fnSaveAmt()">
                        <img src="<%=dirPath%>/Sales/images/btn_northcount.gif" style="cursor:pointer;display:none;" onClick="fnNorthCnt()">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:pointer" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:pointer" onClick="fnApply()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:pointer" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="80px" height="25px" class="text">�������</td>
                                <td align="center" bgcolor="#ffffff" width="73px">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sSDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>  height='16px' width=67 align=center class='textbox'>
                                        <param name=Format      value="YYYY-MM-dd">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td align=left class="text" width="70" height="25px">��ǰ����</td>
			                      <td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
			                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=150 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs7>
										<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
										<param name=ListExprFormat  value="goods_nm^0^140">
                              </object>
									<%=HDConstant.COMMENT_END%>&nbsp;
								</td>
                                <td width="80px" height="25px" class="text">��û����ȣ</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
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
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
                                <td width="80px" height="25px" class="text">����Ÿ��</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;
                                <%=HDConstant.COMMENT_START%>
                                    <object id=sRoomType classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='80px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="AAAAA">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;
                                     <%=HDConstant.COMMENT_END%>
                                     <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="javascript:fnRoomTypePopup()" id="v_accept_btn">
                                </td>

                            </tr>
                            <tr>
								 <td width="80px" height="25px" class="text">�ǸŰ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sPrice classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width=67 align=center class='textbox'>
                                        <param name=Format      value="##########">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                     <%=HDConstant.COMMENT_END%>

                                </td>
                                <td width="80px" height="25px" class="text">����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                                <td align=left class="text" width='80'>��汸��</td>
	                            <td align=left bgcolor="#ffffff" valign="middle" >&nbsp;
	                                <select name="v_out_gubn" id="v_out_gubn" class="textbox">
	                                    <option value="">��ü
	                                    <option value="Y">���
	                                    <option value="N">�����
	                                </select>
	                            </td>
	                            <td width="80px" height="25px" class="text">�븮��</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="�븮���� ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                                    <input type="hidden" value="" id="sClientSid" readOnly>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=845>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:400px" border="1">
                            <param name="DataID"            value="ds1">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
								    <param name=SortView  		      value="Right">
                            <param name="Format"            value="
								<C> name='����'     			   ID='KEY_SEQ'   		Width=50   	align=Left 	   Edit=none  BgColor=#fefec0 show=false </C>
								<C> name='�����'       	   ID='DEPART_DATE'     Width=50   	align=Center 	Edit=none  BgColor=#fefec0 SumText=�հ� suppress=1</C>
                        		<C> name='�븮�� '            ID='CLIENT_NM'       Width=90    align=Left     Sort=True  Edit=none  BgColor=#fefec0 SumText=@count suppress=2</C>
								<C> name='��û����ȣ'       	ID='ACCEPT_NO'       Width=91    align=Left 	   Edit=none  BgColor=#fefec0 </C>
								<C> name='������'           	ID='M_CUST_NM'       Width=60   	align=Left 	   Sort=True  Edit=none  BgColor=#fefec0 </C>
								<C> name='����'           	   ID='JOIN_NM'         Width=50   	align=Left 	   Edit=none  BgColor=#fefec0 </C>
								<C> name='����'           	   ID='CUST_NM'         Width=50   	align=Left 	   Sort=True  Edit=none  BgColor=#fefec0 </C>
								<C> name='�ֹ�/\\���ǹ�ȣ'		ID='MANAGE_NO'       Width=90	   align=Left 	   Edit=none  BgColor=#fefec0  Sort=True</C>
								<C> name='��û\\����'			   ID='A_ROOM_TYPE_CD' 	Width=51 	align=left 	   edit=none  BgColor=#fefec0 suppress=3</C>
								<C> name='Ȯ��\\����'     		ID='ROOM_TYPE'   	   Width=51   	align=Left 	   Sort=True  Edit=none  BgColor=#fefec0  suppress=4</C>
								<C> name='���ȣ'				   ID='ROOM_NO'		   Width=60	   align=Left     Sort=True  Edit=none  BgColor=#fefec0</C>
								
								<G> name='���λ󼼳���'
									<C> name='��������'      ID='CAROWNER_YN'  	   Width=50   	align=center    BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} editstyle=lookup data='codeDs1:detail:detail_nm' </C>
									<C> name='������������'  ID='CUST_TYPE'   	   Width=90   	align=center 	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} editstyle=lookup data='codeDs2:detail:detail_nm'</C>
									<C> name='���ָ���'      ID='WEEKEND_YN'  	   Width=50   	align=center    BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} editstyle=lookup data='codeDs4:detail:detail_nm' </C>
									<C> name='���׸���'      ID='THEME_CD'  		   Width=60   	align=center    BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} editstyle=lookup data='codeDs5:detail:detail_nm' </C>
									<C> name='����!'		ID='JEJU_YN'  		   Width=50   	align=center    BgColor=#fefec0 editstyle=lookup data='codeDs3:detail:detail_nm' Edit=none</C>
								</G>								
								
                        		<C> name='����\\��'              ID='AGE_CD'          Width=50     	align=center   editstyle=lookup data='codeDs6:detail:detail_nm' BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} Sort=True</C>
								<C> name='ǥ�ؿ�ݡ�'     		ID='STD_AMT'  	 	   Width=80   	align=Right    BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} SumText=@sum  Decao=0</C>
								<C> name='�ǸŰ���'         	ID='USE_AMT'  		   Width=70   	align=Right    SumText=@sum  Decao=0 BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}</C>
								<C> name='�Աݾ�'         	   ID='TOT_TOUR_AMT'    Width=70   	align=Right    Edit=none  BgColor=#fefec0 SumText=@sum   Decao=0</C>
								<C> name='��ǰ'          	   ID='GOODS_NM'        Width=80  	align=Left 	   Edit=none  BgColor=#fefec0  suppress=5</C>

								<C> name='����SID'         	ID='RSV_SID'    	   Width=70   	align=Right    Edit=none  BgColor=#fefec0   show=false </C>
								<C> name='�������'         	ID='USE_DATE'    	   Width=70   	align=Right    Edit=none  BgColor=#fefec0  show=false </C>
								<C> name='�޴�SID'         	ID='MENU_SID'    	   Width=70   	align=Right    Edit=none  BgColor=#fefec0  show=false</C>
								<C> name='����\\����'         ID='STATUS_CD'    	Width=45   	align=LEFT     Edit=none  BgColor=#fefec0  </C>
								<C> name='�湮\\Ƚ��'			ID='NORTH_CNT'		width=45	align=left 	show=true edit=none BgColor=#fefec0  </C>
								<C> name='����\\����'			ID='ACCT_CLOSE_YN'	width=45 	align=center   edit=none  BgColor=#fefec0</C>
								<C> name='�Է���'				ID='i_empnm'		width=60	align=left show=true edit=none BgColor=#fefec0  </C>
								<C> name='�����'				ID='SAL_DAM_NM'		width=60	align=left show=true edit=none BgColor=#fefec0  </C>
								
								
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
                <tr>
                    <td><BR>
                    	���� ��û����ȣ�� �ִ� ��쿡�� �ǸŰ� ��� ��ư�� ��Ÿ���ϴ�.<BR>
                    	���� ���λ󼼳����� 5���� ���ǿ� ���� �ǸŰ��� ����˴ϴ�. <BR>
                    	���� ǥ�ؿ�ݰ� �ǸŰ��� ���� ������ ���, ��� ��ư�� ������ ���� �ѹ� �� ������ �ּ���.<BR>
                    	���� ��Ȯ�� �湮Ƚ�� Ȯ���� ���� [������ȸ(��)] �޴��� Ȱ���� �ּ���.<BR>

                    </td>
                </tr>
                
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

