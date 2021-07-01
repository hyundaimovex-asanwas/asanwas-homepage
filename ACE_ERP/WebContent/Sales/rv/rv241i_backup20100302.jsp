<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : Ȩ>��������>����� ���԰���>���� ����>��Ͻ�û(���)
 *				  Ȩ>��������>�������>���� ����>����� �������[�ܱ�]
 * J  S  P      : Rv241I,AC120I
 * �� �� ��     : AC120I
 * �� �� ��     : �ɵ���
 * �� �� ��     : 2006-08-10
 * �������     :  ���밴�� ��� ����
 * [����  ����][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-12-28][�ɵ���] ��ݰ�� ��ư �߰�
 *						�Ϲݻ���ڴ� �������� ���� : �������� ���ڿɼ� ���� ����
 *						��û����ڴ� ��û������    : ������� ���� <- ī��Ʈ�� �������� �Է���
 *						�������(saup_gu) �� ��������(cust_type) ���� ����?
 * [2010-03-02][�ɵ���] GRID �� ��
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
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
		cfStyleGrid(getObjectFirst("gr2"), "comn1");
        getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        getObjectFirst("ds_goods").Reset();
        
        //�������
        // ���(item1) Y	// �����(item3) Y
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CU004&s_item1=Y&s_item3=Y";
        codeDs1.Reset();
        
        //��������(cust_type)	
        // ���(item1) Y	// �����(item4) Y
        codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV003&s_item1=Y&s_item4=Y"; 
        codeDs2.Reset();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
       // if(getObjectFirst("sClientSid").value==""){
       //     alert("�븮���� ���� �����Ͻñ� �ٶ��ϴ�.");
       //     return;
       // }
        
        if(getObjectFirst("sSDate").Text.trim()=="" || getObjectFirst("sSDate").Text.trim().length!=8){
            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("sSDate").Focus();
            return;
        }
        
        if(getObjectFirst("sEDate").Text.trim()=="" || getObjectFirst("sEDate").Text.trim().length!=8){
            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("sEDate").Focus();
            return;
        }
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sClientSid="+getObjectFirst("sClientSid").value
                    + ",sGoodsSid="+sGoodSid.ValueOfIndex ("GOODS_SID", sGoodSid.Index)
                    + ",sSDate="+getObjectFirst("sSDate").Text
                    + ",sEDate="+getObjectFirst("sEDate").Text
                    + ",sAcceptNo="+getObjectFirst("sAcceptNo").Text
                    + ",sCustNm="+getObjectFirst("sCustNm").value;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
            "JSP(O:DS1=ds1)",
            v_param);
            

        tr_post(tr1);
        
		if(getObjectFirst("sAcceptNo").Text == "" ){
            getObjectFirst("save_amt_btn").style.display = "none";
		}
    }


   function fnSelectDs2() {
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sRsvSid="+ds1.namevalue(ds1.rowposition, "RSV_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
            "JSP(O:DS2=ds2)",
            v_param);
        tr_post(tr2);
    }

    //�ǸŰ� ��� ����
    function fnSaveAmt(){
        v_job = "C";

        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
            "JSP(O:DS2=ds_result)",
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,v_accept_sid="+v_accept_sid);
        tr_post(tr2);
    }

    
    
   /**
     * ���� �Լ�
     */
    function fnApply() {    
        if (ds1.IsUpdated) {
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
                "JSP(I:DS2=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr1);
        } else {
            alert("���� ������ �����ϴ�.");
        }
    }
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
        getObjectFirst("gr1").SetExcelTitle(1, "value:���밴�� ��� ����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("���밴�� ��� ����", "���밴�� ��� ����.xls", 8);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�˾�
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            sClientSid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          sClientSid.value = "";
			getObjectFirst("save_amt_btn").style.display = "none";
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
            getObjectFirst("sAcceptNo").Text   = arrParam[1];
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
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        getObjectFirst("save_amt_btn").style.display = "none";
	}

    if(v_accept_sid!=""){
    	getObjectFirst("save_amt_btn").style.display = "inline";
    }	
</script>

<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
	if (row <= 0) {
		return;
	}
	fnSelectDs2();
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                        <img src="<%=dirPath%>/Sales/images/prize_cal.gif" style="cursor:hand;display:none" id="save_amt_btn" onClick="fnSaveAmt()">                    
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">���¾�ü�ڵ�</td>
                                <td align="left" bgcolor="#ffffff" colspan='4'>&nbsp;<input type="text" value="" name="v_client_cd" id="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                  
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                                  
                                    <input type="text" value="" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="" name="sClientSid" readOnly>
                                </td>
                                
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">��ǰ�ڵ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sGoodSid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=180 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^150">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            
                                <td width="100px" height="25px" class="text">�������</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sSDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=sEDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
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
                            <tr>
                                <td width="100px" height="25px" class="text">��û����ȣ</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sAcceptNo classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000000000000">
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
                                <td width="100px" height="25px" class="text">����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
                
                <tr>
                	<td>
                		 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=520>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=520; height:430px" border="1">
                            <param name="DataID"            value="ds1">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
								<C> name='����'     		ID='KEY_SEQ'   		Width=50   	align=Left 	Edit=none  show=false  SumText=�հ� </C>
								<C> name='�������'       	ID='DEPART_DATE'    Width=60   	align=Left 	Edit=none suppress=1 mask='XXXXXXXX'</C>
								<C> name='��������'       	ID='ARRIVE_DATE'    Width=60   	align=Left 	Edit=none suppress=2 mask='XXXXXXXX'</C>
								<C> name='�ڼ�'       		ID='NIGHTS' 	    Width=35   	align=center	Edit=none suppress=3</C>
								<C> name='��û��ȣ'       	ID='ACCEPT_NO'      Width=90    align=center 	Edit=none suppress=4</C>
								<C> name='����'           	ID='CUST_NM'        Width=60   	align=Left 	Edit=none   </C>
								<C> name='�������'        	ID='SAUP_GU'        Width=60   	align=Left 	editstyle=lookup data='codeDs1:detail:detail_nm'</C>
								<C> name='��������'        	ID='CUST_TYPE'      Width=110   	align=Left 	editstyle=lookup data='codeDs2:detail:detail_nm'  </C>
								
								<C> name='�����ڵ�'     	ID='ROOM_TYPE'   	Width=60   	align=Left 	Edit=none   suppress=4</C>
								<C> name='�ǸŰ�'         	ID='TOT_TOUR_AMT'  		Width=70   	align=Right Edit=none SumText=@sum  Dec=0</C>
								<C> name='�Աݾ�'         	ID='TOT_PAY_AMT'   Width=70   	align=Right Edit=none SumText=@sum  Dec=0</C>
								<C> name='�ֹ�/���ǹ�ȣ'	ID='MANAGE_NO'      Width=100	align=Left 	Edit=none   show=false</C>
								<C> name='����SID'         	ID='RSV_SID'    	Width=70   	align=Right Edit=none   show=false</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                                        
                     <td width=290>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=290; height:430px" border="1">
                            <param name="DataID"            value="ds2">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
								<C> name='����'     	ID='KEY_SEQ'   		Width=40   	align=center	Edit=none </C>
								<C> name='ǰ��'       	ID='MENU_NM' 		Width=90  	align=Left 	Edit=none   suppress=1 SumText=�հ� </C>
								<C> name='�ǸŰ�'       ID='USE_AMT'  		Width=65   	align=Right 		  	SumText=@sum  Dec=0</C>
								<C> name='�������'     ID='USE_DATE'    	Width=70   	align=Right Edit=none  mask='XXXX-XX-XX'</C>
								<C> name='����SID'      ID='RSV_SID'    	Width=70   	align=Right Edit=none  show=false </C>
								<C> name='�޴�SID'      ID='MENU_SID'    	Width=70   	align=Right Edit=none  show=false </C>
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

