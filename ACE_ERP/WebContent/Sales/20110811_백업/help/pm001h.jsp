<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: �����ڵ� 
 * ���α׷�ID 	: PM001H (�ڵ�� �빮��)
 * J  S  P		: pm001h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Pm001H
 * �� �� ��		: ������
 * �� �� ��		: 2006-05-09
 * �������		: �����ڵ� ��ȸ 
 * ��������		: 2006-05-09 : XXXXX ���� XXXXX ������û (�Ϸ�/�̿Ϸ�)
 * �� �� ��		: ������
 * ������������ :  
 * TODO			: �ڸ�Ʈ�κ� ���� ����
 * TODO         :
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
		<title>�ŷ�ó �˻�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			var item1,item2,item3,item4,item5;
			var item6,item7,item8,item9,item10;
			var item11,item12,item13,item14,item15;
			// ������ �ε�
			function fnOnLoad(){

			
				var strParam = new Array();
				strParam=window.dialogArguments;
				
		//		alert(strParam[0]);
				if(strParam[0]!=null) { //head������ �ָ� �ֺз����ǰ˻�
					txt_detail1.value=strParam[0];
				}else {
				}
				if(strParam[1]!=null) { //detail������ �ָ� �ڵ����ǰ˻�
					txt_detail2.value=strParam[1];
				}else {
				}
				if(strParam[2]!=null) { //detailnm������ �ָ� �̸����ǰ˻�
					txt_detailnm.value=strParam[2];
				}else {
				}

				fnInit();
			}

			// ����ȸ
			function fnInit(){ 		
				//fnSelect();
				txt_detailnm.focus();
		        cfStyleGrid(getObjectFirst("gr1"), "comn");
			}			
			// ���� ��ȸ
			function fnSelect() {
				if(!txt_detailnm.value) {
					alert("�˻��� ���¾�ü�� �ڵ� �Ǵ� ��ü�� �Ǵ� ����ڵ�Ϲ�ȣ�� �Է����ּ���.");
					txt_detailnm.focus();
					return false;
				}
				fnSubSelect1();
			}
			
			// ���� �ٸ����� ��ȸ�Ѵ� 
			function fnSubSelect1() {
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Pm001H?proType=S&dsType=2&s_Head="+txt_detail1.value+"&s_Detail="+txt_detailnm.value;
				ds1.Reset();
			}
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �˾�â �ݱ�
// Parameter 	:
%>
		<script language="javascript">
			function fnAdd(){
					var row = ds1.rowposition;
					window.returnValue = ds1.namevalue(row, "client_sid") + ";" +
								 ds1.namevalue(row, "client_nm") + ";" + 
								 ds1.namevalue(row, "client_cd") + ";" +
								 ds1.namevalue(row, "u_empno") + ";" + 
								 ds1.namevalue(row, "u_date") + ";" + 
								 ds1.namevalue(row, "u_ip"); 
				window.close();
				
			}
		</script>
		
		<script type="text/javascript">
 			function fnClose() {
				window.close();
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
//			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//              :  Opener�� ���õ� �� ��� 
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "client_sid") + ";" +
								 ds1.namevalue(row, "client_nm") + ";" + 
								 ds1.namevalue(row, "client_cd") + ";" +
								 ds1.namevalue(row, "u_empno") + ";" + 
								 ds1.namevalue(row, "u_date") + ";" + 
								 ds1.namevalue(row, "u_ip"); 
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
		<%=HDConstant.COMMENT_START%>
		<object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object>
		<%=HDConstant.COMMENT_END%>

	</head>
	
	<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table width=479>
			<tr>
				<td>
					<table border=0 cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> ���¾�ü ��ȸ
								<input id="txt_detail1" type="hidden" name="txt_detail1" class="" style="width:50;position:relative;top:2px;border:0;" readonly>
								<input id="txt_detail2" type="text" name="txt_detail2" class="" style="width:100;position:relative;top:2px;border:0;" readonly>
							</td>
						</tr>
						<tr>
							<td class="text" width="160px" height="30" style="border:1 solid #708090">�ڵ� / �� / ����ڹ�ȣ </td>
							<td width="130px" style="border:1 solid #708090;border-left-width:0px">
								<input id="txt_detailnm" type="text" name="txt_detailnm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td valign=bottom>
					<table border=0 cellpadding="0" cellspacing="0">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�ڵ�/���� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

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
                        <param name="ViewSummary"       value="1">						
						<param name="Format" 		value="
							<c> Name='�ڵ�'			ID='CLIENT_CD'	Width=60  align=center sumtext=@cnt </c>
							<c> Name='��ü��' 		ID='CLIENT_NM'	Width=300  leftmargin=20 sumtext='��'  </c>
							<c> Name='��üSID' 		ID='CLIENT_SID'	Width=110  leftmargin=30 sumtext='��' SHOW=TRUE </c>
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