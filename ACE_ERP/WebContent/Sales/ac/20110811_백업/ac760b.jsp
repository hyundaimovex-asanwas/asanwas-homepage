<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��ǰ�� �̼��� ��ȸ
 * ���α׷�ID 	: AC770S
 * J  S  P		: ac770s
 * �� �� ��		: Ac770S
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-08-17
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	 
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyy");
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   	String firstday = m_today.format(date.getTime());
   	date.add(date.YEAR,+1);
    String nextyear = m_today.format(date.getTime());		 
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		
		/*
		 * �������ε� 
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		if(sFr_date.text==""){
			sFr_date.text='<%=firstday%>';
			sTo_date.text='<%=nextyear%>';
			}else{
			
			}
		} 
		 
		function fnInit() {
	
		}
		
		 function fnApply() {
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_req_date="+getObjectFirst("sFr_date").Text
                        + ",v_req_date2="+getObjectFirst("sTo_date").Text;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac760B",
                "JSP(O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        }
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sFr_date=" + sFr_date.Text
			          + ",sTo_date=" + sTo_date.Text
			          + ",sVendCd="  + sVendCd.value
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac770S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * �ŷ�ó����
		 */
		
		function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu004h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sVendCd.value = arrParam[0];
		    	sVendCd1.value = arrParam[1];
			}
	} 	
	 function fnExcel() {
        if(ds1.RowCount==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:��ǰ�ǹ̼��� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("��ǰ�ǹ̼��� ��ȸ", "��ǰ�ǹ̼��� ��ȸ.xls", 8);
    }
		</script>

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>	
	
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr>
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr height="30px">
						<td width=545 >
							<table border='0' cellpadding="0" cellspacing="1" width="545" bgcolor="#666666">
								<tr height=30>
				                    <td align=center bgcolor="#ffffff" width=500>&nbsp;�̿��⵵																							
										<%=HDConstant.COMMENT_START%>
										<object id=sFr_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=absmiddle class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											 <param name=Format      value="YYYY">
                                            <PARAM NAME=InputFormat value="YYYY">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                             <param name=SelectAll   value=true>
	                                        <param name=SelectAllOnClick      value=true>
	                                        <param name=SelectAllOnClickAny   value=false>																			
										</object>&nbsp;�⿡��&nbsp;
										<object id=sTo_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=absmiddle class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											 <param name=Format      value="YYYY">
                                            <PARAM NAME=InputFormat value="YYYY">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                             <param name=SelectAll   value=true>
                                             <param name=ReadOnly    value="true">
	                                        <param name=SelectAllOnClick      value=true>
	                                        <param name=SelectAllOnClickAny   value=false>																		
										</object>
										<%=HDConstant.COMMENT_END%>&nbsp;������ �̿� 
								 	</td>
								</tr>
							</table>
						</td>
					 	<td width='300' align=right>
							<table width='300'>
								<tr>
									<td align=right>
										<img src="<%=dirPath%>/Sales/images/settle.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply()"> 		<!-- ��ȸ -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr>
			<td colspan=2>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
					
					</tr>
				</table>
			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

