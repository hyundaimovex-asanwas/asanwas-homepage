<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: ������� 
 * ���α׷�ID 	: SY020H (�ڵ�� �빮��)
 * J  S  P		: sy020h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Sy020H
 * �� �� ��		: ���ؼ�
 * �� �� ��		: 2006-05-30
 * �������		: ������� ��ȸ 
 * [�� ��  �� ��][������] ����
 * [2009-02-23][�ɵ���] ��ȸ�ϴ� ���̺� ����.. 
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>��ġ������������������������������������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
		

<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">

			// ������ �ε�
			function fnOnLoad(){
            	cfStyleGrid(getObjectFirst("gr1"), "comn");
            
				var strParam = new Array();
				strParam=window.dialogArguments;
				
                if(strParam==undefined) return;
                
				if(strParam[0]!=null) { 
					sEmpno.value=strParam[0];
				}			

				fnInit();
			}

			// ����ȸ
			function fnInit(){ 	
				if ( sEmpno.value != '' ) {			
					ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy030H?proType=S&dsType=1&sEmpno="+sEmpno.value;
					ds1.Reset();
				}
			}			
			// ���� ��ȸ
			function fnSelect() {
				fnSubSelect1();
			}
			
			// ���� �ٸ����� ��ȸ�Ѵ� 
			function fnSubSelect1() {
				//alert(sEmpno.value);
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy030H?proType=S&dsType=1&sEmpno="+sEmpno.value;
				ds1.Reset();
			}
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "UID") + ";" +
								 	 ds1.namevalue(row, "UNAME"); 
			 	fnClose();
			}
			
			function fnClose() {
				window.close();
			}
		
		</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//              :  �����ȣ Opener�� ���õ� �����ȣ ��� 
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "UID") + ";" +
								 ds1.namevalue(row, "UNAME") ;
			window.close();
		</script>

		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>		
<!-----------------------------------------------------------------------------
                                DataSet Components ���� 
# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
		<comment id="__NSID__"><object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

	</head>
	
	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">��ġ��</font>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">��ġ��ID/��</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input id="sEmpno" type="text" name="txt_detailnm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="��ġ�ڸ� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:pointer;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnClose()">                          
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			</tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;border:1 solid #777777;">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit����  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name=SortView  value="Right">
						<param name="Format" 		value="
							<c> Name='ID' 			ID='UID'	 	HeadAlign=Center Width=95  align=center sort=true</c>
							<c> Name='��ġ��' 		ID='UNAME'	 	HeadAlign=Center Width=95  align=center sort=true</c>
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>