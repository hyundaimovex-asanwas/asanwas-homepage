<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�        	: �ֹ���ȸ
 * ���α׷�ID       : ML150S
 * J  S  P      	: ml150s
 * �� �� ��        	: Ml150S
 * �� �� ��        	: �ɵ���
 * �� �� ��        	: 2011-01-27
 * [ �������� ][������] ����
 * [2011-01-25][�ɵ���] �ֹ���ȸ(���θ�...������Ʈ)
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
    String endDay = m_today.format(date.getTime());
    date.add(java.util.Calendar.DATE, -2);        
    String startDay = m_today.format(date.getTime());           

	   

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
        var v_default_row = 1;
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
   		sBgnDate.text='<%=startDay%>';
   		sEndDate.text='<%=endDay%>';
	
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
        cfStyleGrid(getObjectFirst("gr2"), "comn1");

        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML001&s_item1=Y";
        codeDs1.Reset();
        
        //getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        //getObjectFirst("ds_goods").Reset();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
        getObjectFirst("ds_detail").DeleteAll();
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
		                + ",sTrGu=" + sTrGu.ValueOfIndex("detail", sTrGu.Index)
			            + ",sBgnDate=" + sBgnDate.text
			            + ",sEndDate=" + sEndDate.text
			            + ",sOrderNo=" + getObjectFirst("sOrderNo").value
			            + ",sEmpno="   + getObjectFirst("sEmpno").value
			            + ",sTr_OrderNm="+ getObjectFirst("sTr_OrderNm").value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150S",
            "JSP(O:DEFAULT=ds_main)",
            v_param);
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  Detail ��ȸ
// Parameter    : 
%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_order_sid="+getObjectFirst("ds_main").NameValue(row, "ORDER_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150S",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� ���� ��� 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_main.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�ֹ���ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�ֹ���ȸ", "�ֹ���ȸ.xls", 32);

        getObjectFirst("gr2").SetExcelTitle(0, "");
        getObjectFirst("gr2").SetExcelTitle(1, "value:��ٱ�����ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr2").GridToExcel("��ٱ�����ȸ", "��ٱ�����ȸ.xls", 32);

    }

  
   	// ��ġ���˾�
	function fnPopup1() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			empno.value = arrParam[1];
		} else {
			empno.value = "";		
		}				
	}
	
	<%// �ֹ����˾�(�˻�����)%>
	function fnPopup2() {   
		var arrParam	= new Array(); 
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/ml010h.jsp"
		strPos = "dialogWidth:507px;dialogHeight:330px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
		
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			user_nm.value = arrParam[1];
		} else {
			user_nm.value = "";		
		}				
	} 

    
	<%//����  �˾�%>
	function popConfirm(order_sid){
		var receiptURL ="http://com.hdasan.com/shop_statement.asp?order_sid=" + order_sid;
	   	window.open(receiptURL,"shopStatement","width=730,height=670,scrollbars=yes,toolbar=no,menubar=yes,location=no,directories=no,top=100,left=100,noresize");
	}
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=JavaScript for=sBgnDate event=OnKillFocus()>
   if( sBgnDate.Modified == true )
		sEndDate.text = sBgnDate.text;
</script>	


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

<script language=javascript for="gr1" event="OnClick(Row, Colid)">
//���ʹ�ư Ŭ���ϸ� ������ ���̱�
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDetail(Row);
</script>
<script language=JavaScript for="gr1" event="OnRButtonUp(Row, Colid, xpos, ypos)">
//������ư Ŭ���ϸ� Ȯ���� ���
	if(ds_main.namevalue(Row, "GOODS_SID")==57||ds_main.namevalue(Row, "GOODS_SID")==58||ds_main.namevalue(Row, "GOODS_SID")==59){
	 	if(ds_main.namevalue(Row, "TOT_TOUR_AMT") - ds_main.namevalue(Row, "TOT_PAY_AMT") == 0) {
		 	popConfirm(ds_main.namevalue(Row, "RSV_SID"));	//�Ա���
	 	}else{
		 	popConfirm2(ds_main.namevalue(Row, "RSV_SID"));	//���Ա�
	 	};
	}else{
		alert("�����Ǹ� ��ǰ�� Ȯ������ ���� �� �ֽ��ϴ�.");
	};
</script>

<script language=javascript for="ds_main" event="OnLoadCompleted(row)">
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
		return;
	}
    fnSelectDetail(v_default_row);
</script>


<script language=javascript for="gr2" event="OnClick(Row, Colid)">
    if(Row<1) return;
    fnConfirmView('<%=dirPath%>');
</script>
<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
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

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
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
</script>
<script language=JavaScript for="gr1" event="OnRButtonUp(Row, Colid, xpos, ypos)">
	//������ư Ŭ���ϸ� ��â ��
 	popConfirm(ds_main.namevalue(Row, "ORDER_SID"));	//�ֹ�sid
</script>

<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
							<tr height="30px">	
		                        <td align="center" width="100" class="text">�ŷ�����</td>
								<td align="left" bgcolor="#ffffff" >&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>

								<td align=CENTER width=100 class="text">�ֹ�����</td>
								<td align=left bgcolor="#ffffff" >&nbsp;
								     <%=HDConstant.COMMENT_START%>
								     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">
										<param name=InheritColor      value="true">
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">
										<param name=SelectAllOnClick   value="true">
										<param name=SelectAllOnClickAny  	value="false">
									</object>
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">
										<param name=InheritColor      value="true">
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">
										<param name=SelectAllOnClick   value="true">
										<param name=SelectAllOnClickAny  	value="false">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align=CENTER width=100 class="text"><B>�ֹ���ȣ</B></td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sOrderNo" type="text" class="textbox"  style="width:100px;">
								</td>			
		                    </tr>
                            <tr height="30px">
                                <td align=CENTER class="text">&nbsp;��ġ��</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sEmpno" type="text" class="textbox"  style= "position:relative;center:-20px;top:2px;width:100px; height:20px; text-align:center;" >									
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��ġ�ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
								</td>	
								<td align=CENTER  class="text">�ֹ��ڸ�</td>
								<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_OrderNm id=sTr_OrderNm  class="textbox"></td>
								<td bgcolor=#ffffff align="center" COLSPAN=2></td>
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
                    <td width=450>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=450; height:380px" border="1">
                            <param name="DataID"            value="ds_main">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
<C> name='�ŷ�\\����'	ID='ORDER_GUBN'	Width=55  align=center  show=true	suppress=1  editstyle=lookup  data='codeDs1:detail:detail_nm'  sumtext=�� SumTextAlign=right</C>
<C> name='�ֹ���ȣ'    	ID='ORDER_NO'  	Width=80  align=center  show=true	 sumtext=@cnt  SumTextAlign=right</C>
<C> name='�ֹ��ڸ�'   	ID='USER_NM'  	Width=70  align=left show=true	 sumtext=��  SumTextAlign=left</C>
<C> name='����ó1'      ID='MOBILE_NO'  Width=85  align=left show=true	</C>
<C> name='�ֹ��Ѿ�'		ID='AMT_EXCH'  	Width=70  align=right   show=true	Edit=none decao=0	sumtext=@sum</C>
<C> name='�ϳ�\\����' 	ID='PAY_YN_TOT'	Width=30  align=center  show=true 	</C>
<C> name='�ŷ�\\����2'	ID='ORDER_GUBN2'	Width=40  align=center  show=true	suppress=1  editstyle=lookup  data='codeDs2:detail:detail_nm' </C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                    <td width="3">&nbsp;</td>
                    <td width=392>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=392; height:380px" border="1">
                            <param name="DataID"            value="ds_detail">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
<C> name='No' 	    	ID='ORDER_SEQ'		width=30	align=right show=true</C>
<C> name='��ǰ��' 		ID='ITEM_NM'		width=85 	align=left  Edit=None sumtext=�� SumTextAlign=right</C>
<C> name='�ֹ�\\�ܰ�'	ID='AMT_ORDERED'	width=60	align=right Edit=None SumText=@sum   decao=0  show=false</C>
<C> name='�̿�\\�ܰ�'	ID='AMT_USED'		width=50 	align=right sumtext=@cnt decao=0  show=true</C>
<C> name='��ȭ'    		ID='AMT_CURR_CD'	width=35 	align=center Edit=None sumtext=��  SumTextAlign=left</C>
<C> name='ȯ��'	    	ID='EXCH_RATE'      width=30 	align=center  Edit=Numeric  DECao=0  Edit=None</C>
<C> name='����'        	ID='ORDER_CNT'      width=30 	align=right decao=0  sumtext=�հ� show=true</C>
<C> name='ȯ��\\�Ұ�' 	ID='AMT_EXCH'		width=70 	align=right decao=0  show=true SumText=@sum  </C>
<C> name='�ڵ�' 		ID='SELLER_CD'    	width=40 	align=left Edit=None show=true</C>
			 									 
<C> name='�ֹ�SID'     	ID='ORDER_SID'     	align=left  editlimit=12 show=false</C>
<C> name='��ǰSID' 		ID='ITEM_SID'       		width=40 align=right Edit=None DEC=0 show=false</C>




                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
	  <tr>
		<td>���� ���� GRID�� ���� <b>��</b> Ŭ���ϸ� ���� GRID�� <b><font color="blue">��������</font>�� ǥ��</b>�˴ϴ�.<br>
				���� ���� GRID�� ���� <b>����</b> Ŭ���ϸ� <b><font color="blue">����Ȯ����</font>�� ���</b>�մϴ�.<br>
				���� �ֹ���ȣ �������� ��ȸ�� ���, �ٸ� ������ ��� ���õ˴ϴ�.<br>
		</td>
	  </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

