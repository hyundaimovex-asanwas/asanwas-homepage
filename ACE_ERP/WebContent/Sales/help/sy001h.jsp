<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: �����ڵ� 
 * ���α׷�ID 	: SY001H (�ڵ�� �빮��)
 * J  S  P		: sy001h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Sy001H
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
		<title>���� �ڵ�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
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

		        cfStyleGrid(getObjectFirst("gr1"), "comn");			
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
				if(strParam[3]!=null) { //item1~
					item1=strParam[3];
				}else {
					item1="";
				}
				if(strParam[4]!=null) {
					item2=strParam[4];
				}else {
					item2="";
				}
				if(strParam[5]!=null) {
					item3=strParam[5];
				}else {
					item3="";
				}
				if(strParam[6]!=null) {
					item4=strParam[6];
				}else {
					item4="";
				}
				if(strParam[7]!=null) {
					item5=strParam[7];
				}else {
					item5="";
				}
				if(strParam[8]!=null) {
					item6=strParam[8];
				}else {
					item6="";
				}
				if(strParam[9]!=null) {
					item7=strParam[9];
				}else {
					item7="";
				}
				if(strParam[10]!=null) {
					item8=strParam[10];
				}else {
					item8="";
				}		
				if(strParam[11]!=null) {
					item9=strParam[11];
				}else {
					item9="";
				}
				if(strParam[12]!=null) {
					item10=strParam[12];
				}else {
					item10="";
				}
				if(strParam[13]!=null) {
					item11=strParam[13];
				}else {
					item11="";
				}
				if(strParam[14]!=null) {
					item12=strParam[14];
				}else {
					item12="";
				}
				if(strParam[15]!=null) {
					item13=strParam[15];
				}else {
					item13="";
				}
				if(strParam[16]!=null) {
					item14=strParam[16];
				}else {
					item14="";
				}
				if(strParam[17]!=null) {
					item15=strParam[17];
				}else {
					item15="";
				}
				fnInit();
			}

			// ����ȸ
			function fnInit(){ 		
		
				fnSelect();
			}			
			// ���� ��ȸ
			function fnSelect() {
				fnSubSelect1();
			}
			
			// ���� �ٸ����� ��ȸ�Ѵ� 
			function fnSubSelect1() {
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head="+txt_detail1.value+"&s_Detail="+txt_detailnm.value+
									"&s_Item1="+item1+"&s_Item2="+item2+"&s_Item3="+item3+
									"&s_Item4="+item4+"&s_Item5="+item5+"&s_Item6="+item6+
									"&s_Item7="+item7+"&s_Item8="+item8+"&s_Item9="+item9+
									"&s_Item10="+item10+"&s_Item11="+item11+"&s_Item12="+item12+
									"&s_Item13="+item13+"&s_Item14="+item14+"&s_Item15="+item15;
				ds1.Reset();
			}
		
			// �ű�
			function fnNewRow() {

			}
			// ���
			function fnInsert() {

			}
			// ���� 
			function fnDelete() {

			}
			// ����
			function fnExcel() {

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
					window.returnValue = ds1.namevalue(row, "head") + ";" +
								 ds1.namevalue(row, "detail") + ";" + 
								 ds1.namevalue(row, "detail_nm") + ";" +
								 ds1.namevalue(row, "item1") + ";" + 
								 ds1.namevalue(row, "item2") + ";" + 
								 ds1.namevalue(row, "item3") + ";" + 
								 ds1.namevalue(row, "item4") + ";" + 
								 ds1.namevalue(row, "item5") + ";" + 
								 ds1.namevalue(row, "item6") + ";" + 
								 ds1.namevalue(row, "item7") + ";" + 
								 ds1.namevalue(row, "item8") + ";" + 
								 ds1.namevalue(row, "item9") + ";" + 
								 ds1.namevalue(row, "item10") + ";" + 
								 ds1.namevalue(row, "item11") + ";" + 
								 ds1.namevalue(row, "item12") + ";" + 
								 ds1.namevalue(row, "item13") + ";" + 
								 ds1.namevalue(row, "item14") + ";" + 
								 ds1.namevalue(row, "item15") + ";" + 
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
			fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//              :  �����ȣ Opener�� ���õ� �����ȣ ��� 
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "head") + ";" +
								 ds1.namevalue(row, "detail") + ";" + 
								 ds1.namevalue(row, "detail_nm") + ";" +
								 ds1.namevalue(row, "item1") + ";" + 
								 ds1.namevalue(row, "item2") + ";" + 
								 ds1.namevalue(row, "item3") + ";" + 
								 ds1.namevalue(row, "item4") + ";" + 
								 ds1.namevalue(row, "item5") + ";" + 
								 ds1.namevalue(row, "item6") + ";" + 
								 ds1.namevalue(row, "item7") + ";" + 
								 ds1.namevalue(row, "item8") + ";" + 
								 ds1.namevalue(row, "item9") + ";" + 
								 ds1.namevalue(row, "item10") + ";" + 
								 ds1.namevalue(row, "item11") + ";" + 
								 ds1.namevalue(row, "item12") + ";" + 
								 ds1.namevalue(row, "item13") + ";" + 
								 ds1.namevalue(row, "item14") + ";" + 
								 ds1.namevalue(row, "item15") + ";" + 
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
	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	
		
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center>
								<input id="txt_detail1" type="hidden" name="txt_detail1" class="" style="width:50;position:relative;top:2px;border:0;" readonly>
								<input id="txt_detail2" type="text" name="txt_detail2" class="" style="width:100;position:relative;top:2px;border:0;" readonly>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">�ڵ�/��</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input id="txt_detailnm" type="text" name="txt_detailnm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
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
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:280px;border:1 solid #777777;">
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
						<param name="VIEWSUMMARY"   value="1">
						<param name="Format" 		value="
							<c> Name='��        ��'		ID='detail'		Width=100  align=center  SUMTEXT='��'</c>
							<c> Name='��   ��   ��' 	ID='detail_nm'	Width=379  leftmargin=30 SUMTEXT=@CNT</c>
							
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>

		</table>
	</body>
	<!-- BODY END -->
</html>