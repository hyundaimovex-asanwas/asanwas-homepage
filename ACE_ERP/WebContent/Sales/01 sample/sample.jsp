
<%
/******************************************************************************
 * �ý��۸� 	: �����ڵ� ���� 
 * ���α׷�ID 	: SAMPLE (�ڵ�� �빮��)
 * J  S  P		: sample (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Sample
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-05-02
 * �������		: �����ڵ� ��ȸ, ���, ���� ����, �˾���ȸ , �˻� 
 * ��������		: 2006-05-02 : XXXXX ���� XXXXX ������û (�Ϸ�/�̿Ϸ�)
 * �� �� ��		: �̺���
 * ������������ : 2006-05-02 
 * T O D O		: 1. xxxxxx ��ó��
 * T O D O		: 2. yyyyyy ��ó�� 
 *
 *****************************************************************************/
%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>	�����ڵ���� (ȭ���) </title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%
/*=============================================================================
				Style Sheet, Common Java Script Link
=============================================================================*/
%>		
		<link rel="stylesheet" href="<%=dirPath%>/Sales/common/include/common.css">

		<Script language="javascript" src="<%=dirPath%>/Sales/common/include/PubFun.js"></script>

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
		<script language="javascript">
			get_cookdata();
			var gs_userid = gusrid;
			var gs_fdcode = gfdcode;
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
			function fnOnLoad(){
				fnInit();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����ȸ
// Parameter 	: 
%>
			function fnInit(){ 
				ln_SetDataHeader1();
				ln_SetDataHeader2();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ��ȸ 
// Parameter 	: dsType = 1
%>
			function fnSelectDs1(){   
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Sample?proType=S&dsType=1&s_Head=" + txt_head.value + "&s_HeadName=" + txt_head_name.value;
				ds1.Reset();
			} 
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ȸ2 
// Parameter 	: 
%>
	
			function fnSelectDs2(){
				ds2.DataID = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Sample?proType=S&dsType=2&s_Head=" + ds1.namevalue(ds1.rowposition,"head");
				ds2.Reset();
			}
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� ù��° 
// Parameter 	:
%>
	
			function fnAddRowDs1(){
				if(ds1.IsUpdated||ds2.IsUpdated) {
					alert("�������� ���� ������ �߰��� �� �����ϴ�.");
				}else {
					ds1.addrow();
					gr1.setcolumn("head");
					window.status="Master ���� ���ԵǾ����ϴ�.";
					fnSelectDs2();
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���߰�
%>
	
			function fnAddRowDs2() {
				if(ds2.IsUpdated) {
					alert("�������� ���� ������ �߰��� �� �����ϴ�.");
				}else{
					ds2.addrow();
					gr2.setcolumn("detail");
					window.status="Detail ���� ���ԵǾ����ϴ�.";
				}
			}
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �����
// Parameter 	: 
%>
			function fnDeleteRowDs1() {			
				if(ds1.IsUpdated || ds2.IsUpdated) {
					alert("�������� ���� ������ ������ �� �����ϴ�.");
					return;
				}else{
					if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
						ds2.deleteall();
						ds1.deleterow(ds1.rowposition);
						window.status="Master ���� �����Ǿ����ϴ�.";
						fnApply();
						return;
					}
				}
			}
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �����2
// Parameter 	: 
%>
			function fnDeleteRowDs2(){
				if(ds1.IsUpdated || ds2.IsUpdated) {
					alert("�������� ���� ������ ������ �� �����ϴ�.");
					return;
				}else{
					ds2.deleterow(ds2.rowposition);
					window.status="Detail ���� �����Ǿ����ϴ�.";
				}
			}
<%
	///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
			function fnApply(){
			
				var row1=ds1.countrow;
				var row2=ds2.countrow;			
				if (ds1.IsUpdated) {
					if (ln_Chk())	{
						txt_save1.value="1"; //������ �÷���
						for(i=1;i<=row1;i++) {
							if(ds1.rowstatus(i)==1||ds1.rowstatus(i)==3) {
								ds1.namevalue(i,"head")=txt_head1.value;
								ds1.namevalue(i,"u_empno")=gs_userid;
							}
						}
						tr1.KeyValue = "Sample(I:INPUT_DATA=ds1)";
						tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Sample?proType=A&dsNum=1";
						tr1.post();
						txt_save1.value="0"; //������ �÷��� ����
					}
				}
				if (ds2.IsUpdated) {
					if (ln_Chk()) {
						txt_save2.value="1"; //������ �÷���
						for(i=1;i<=row2;i++) {
							if(ds2.rowstatus(i)==1||ds2.rowstatus(i)==3) {
								ds2.namevalue(i,"head")=txt_head1.value;
								ds2.namevalue(i,"u_empno")=gs_userid;
							}
						}
						tr2.KeyValue = "Sample(I:INPUT_DATA=ds2)";
						tr2.Action = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Sample?proType=A&dsNum=2";
						tr2.post();
						txt_save2.value="0"; //������ �÷��� ����
					}
				}
				fnSelectDs1();
		
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
			function fnCancel(){
				ds1.undoall();
				ds2.undoall();
				window.status="������ ������ ��ҵǾ����ϴ�.";
				fnSelectDs1();
				return;
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ��� (�μ�)
%>
			function fnPrint(){
				gr_print1.preview();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : ���� 
%>
			function fnExcelGr1(){
				gr2.runexcel("�����ڵ����");
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �з��� �˾�
%>
			function fnPopup(){ 
			
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				
				strURL = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>sample_popup.jsp?head="+head.value+"&headName="+headName.value;
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);	
			
				if (arrResult != null) {
					arrParam = arrResult.split(";");
			    txt_head.value = arrParam[0];
					txt_head_name.value = arrParam[1];
				} else {
				  txt_head.value="";
					txt_head_name.value="";
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
			function ln_Chk() {
				
				var row1=ds1.countrow;
				var row2=ds2.countrow;
				for(i=1;i<=row1;i++) {
					if(ds1.namevalue(i,"head")=="") {
						alert("�з��ڵ带 �Է��� �ֽʽÿ�");
						return false;
					}
				}
				for(i=1;i<=row2;i++) {
					if (ds2.namevalue(i,"detail")=="") {			
						alert("�ڵ带 �Է��� �ֽʽÿ�");
						return false;
					}
				}
				for(i=1;i<row1;i++) {
					if(ds1.namevalue(i,"head")==ds1.namevalue(i+1,"head")) {
						alert("�з��ڵ尪�� �ߺ��˴ϴ�.");
						return false;
					}
				}
				for(i=1;i<row2;i++) { <%// DS2�� ���� �ڵ尪 �ߺ� üũ�� (������ ������ ������.. )%>
					if(ds2.namevalue(i,"detail")==ds2.namevalue(i+1,"detail")) {
						alert("�ڵ尪�� �ߺ��˴ϴ�.");
						return false;
					}
				}
				return true;
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
			function ln_SetDataHeader1(){
				if (ds1.countrow<1){
					var s_temp = "head:STRING,head_name:STRING,u_empno:STRING,u_date:STRING,u_ip:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
			function ln_SetDataHeader2(){
				if (ds2.countrow<1){
					var s_temp = "head:STRING,detail:STRING,detail_name:STRING,"
										 + "item1:STRING,item2:STRING,item3:STRING,item4:STRING,item5:STRING,"
										 + "item6:STRING,item7:STRING,item8:STRING,item9:STRING,item10:STRING,"
										 + "item11:STRING,item12:STRING,item13:STRING,item14:STRING,item15:STRING,"
										 + "u_empno:STRING,u_date:STRING,u_ip:STRING";
					ds2.SetDataHeader(s_temp);
				}
			}
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">

</object>
<object  id=ds2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">

</object>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM name="KeyName"  value="toinb_dataid4">
</object>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=ds1 event=CanRowPosChange(row)>
			if(ds1.IsUpdated||ds2.IsUpdated) {
				if(txt_save1.value=="0") {
					alert("�������� ���� ������ �ű� �� �����ϴ�.");
					return false; //������Ʈ�� �ϴµ� ��������� �ƴϸ� �ο��̵��Ұ�
				}else {
					return true; //������Ʈ���̸� �������(�ο��̵������ϰ�)
				}					
			}
			else {
				return true; //������Ʈ���� �ƴϸ� ������ �̵�����
			}
		</script>
		<script language=JavaScript for=ds2 event=CanRowPosChange(row)>
			if(ds2.IsUpdated) { //�ι�° �׸���� �������̶� �̵����� 
				if(txt_save2.value=="0") {
					alert("�������� ���� ������ �ű� �� �����ϴ�.");
					return false; //������Ʈ�� �ϴµ� ��������� �ƴϸ� �ο��̵��Ұ�
				}else {
					return true; //������Ʈ���̸� �������(�ο��̵������ϰ�)
				}					
			}
			else {
				return true; //������Ʈ���� �ƴϸ� ������ �̵�����
			}
		</script>
		<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
			if(ds1.sysstatus(row)==1) {
				txt_head1.disabled=false;
			} else {
				txt_head1.disabled=true;
			}
		</script>
		<script language=JavaScript for=ds2 event=OnRowPosChanged(row)>
			if(ds2.sysstatus(row)==1) {
				gr2.ColumnProp('detail','edit')="any";
			} else {
				gr2.ColumnProp('detail','edit')="none";
			}
		</script>
		<script language=JavaScript for=gr1 event=OnClick(row,colid)>
			//fnSelectDs2(); //�ο� Ŭ���ϸ� ������ȸ
		</script>		

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 ó�� �Ϸ�  
%>	
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 ���� 
%>	
		<script language="javascript" for="tr1" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR2ó�� �Ϸ�  
%>	
		
		<script language="javascript" for="tr2" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 ó�� ���� 
%>	
		<script language="javascript" for="tr2" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>	

		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("DS1 ������ �߻��߽��ϴ� : "+ds1.ErrorCode+" "+ds1.ErrorMsg );
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
 		
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			fnSelectDs2();	
		</script>
		
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			alert("DS2 ������ �߻��߽��ϴ� : "+ds2.ErrorCode+" "+ds2.ErrorMsg );
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
		
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�.");
			}			
		</script>
	</head>
<!--------------------------------- BODY START ------------------------------->
	<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" onload="fnOnLoad()" style="overflow:hidden">
		<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;" >
			<tr> 
				<td background="<%=dirPath%>/Sales/common/img/com_t_bg.gif">
					<img src="<%=dirPath%>/Sales/common/img/tsy160.gif">
				</td>
				<td align="right" style="padding-top:10px;" 
					background="<%=dirPath%>/Sales/common/img/com_t_bg.gif">&nbsp;&nbsp;
				</td>
			</tr>
			<tr> 
	   			<td>
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� �κ� 
				: �з��ڵ�, �з���
-----------------------------------------------------------------------------*/
%>		   		
					<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
						<tr> 
					        <td width="70px" class="tab12" bgcolor="#eeeeee" align="center"><nobr>&nbsp;�з��ڵ�&nbsp;</nobr></td>
							<td width="100px;" class="tab23" align="center"><nobr>&nbsp;
								<input id="txt_head" type="text" class="txtbox" name="head"  style= "position:relative;left:-5px;top:0px;width:130px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelectDs1();">
								</nobr>&nbsp;
							</td>  	
							<td width="60px" class="tab12" bgcolor="#eeeeee" align="center"><nobr>&nbsp;�з���&nbsp;</nobr></td>
							<td width="100px" align="center"><nobr>&nbsp;
								<input id="txt_head_name" name="headName" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:130px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelectDs1();">&nbsp;
								<img SRC="<%=dirPath%>/Sales/common/img/btn/com_b_find.gif" BORDER="0" ALT="�з��ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnPopup();">
								</nobr>
								<input id="txt_save1" type="hidden" size="1" value="0">
								<input id="txt_save2" type="hidden" size="1" value="0">
							</td>
							<td align="right" width=100%>					
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_excel.gif"  style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fnExcelGr1()">
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_print.gif"  style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fnPrint()">
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;left:-5px;top:3px" onClick="fnDeleteRowDs1()" >
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_insert.gif"	 style="cursor:hand;position:relative;left:-5px;top:3px"  onClick="fnAddRowDs1()" >
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;left:-5px;top:3px" onClick="fnApply()">
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_cancle.gif"	style="cursor:hand;position:relative;left:-5px;top:3px"  onclick="fnCancel()">
									<img src="<%=dirPath%>/Sales/common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fnSelectDs1()">
						 	</td>
						</tr>
					</table>	
		
					<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:1px;width:310px;height:300px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
						<tr>
							<td height=3  border="0"></td>
						</tr>
						<tr> 
							<td> 
								<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:310px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
									<tr> 
										<td>
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: xxxxxxxx 
				: �˻� ���� - �з��ڵ�, �з���
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>												
											<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:310px;HEIGHT:400px;border:1 solid #777777;">
												<param name="DataID"		VALUE="ds1">
												<param name="BorderStyle"   VALUE="0">
												<param name="Fillarea"		VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"       value="0">
												<param name="editable"      value="false">
												<param name="Format"		      VALUE="  
													<C> name='' 		ID='{CURROW}' HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center </C>						
													<C> name='�з��ڵ�' 	ID='head'  HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left editlimit=5</C>
													<C> name='�з���'  	ID='head_name'   HeadAlign=Center HeadBgColor=#B9D4DC Width=600 align=left editlimit=50</C>											
												">
											</object> 
										</td>
		           					</tr>
								</table>
							</td>
							<td valign=top>
								<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:5px;top:0px;width:560px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">�з��ڵ�</td>
										<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
											<input id="txt_head1" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:50px; height:20px;" maxlength="5" onBlur="bytelength(this,this.value,5);">
										</td>
									</tr>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�з���</td>
										<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
										<input id="txt_head_name1" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:150px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);">
										</td>
									</tr>				
								</table>
								<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:5px;top:0px;width:560px;height:25px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
									<tr>
										<td height=3  border="0" align=right>
											<img src="<%=dirPath%>/Sales/common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;left:-5px;top:5px" onClick="fnDeleteRowDs2()" >
											<img src="<%=dirPath%>/Sales/common/img/btn/com_b_insert.gif"	 style="cursor:hand;position:relative;left:-5px;top:5px"  onClick="fnAddRowDs2()" >
										</td>
									</tr>
								</table>
								<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:5px;top:5px;width:560px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
									<tr>
										<td>
											<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr2  style="WIDTH:558px;HEIGHT:116px;border:1 solid #777777;">
											
												<param name="DataID"		VALUE="ds2">
												<param name="BorderStyle"   VALUE="0">
												<param name="Fillarea"		     VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"       value="0">
												<param name="Editable"      value="true">
												
												<param name="Format"		VALUE="  
													<C> name='' 		ID='{CURROW}' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=20	align=center  </C>
													<C> name='�з��ڵ�'	ID='head' 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left show=true </C>
													<C> name='�ڵ�'   	ID='detail'	 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�ڵ��' 	ID='detail_name' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 	align=left </C>
													<C> name='�Ӽ�1'  	ID='item1'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�2'  	ID='item2' 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�3'  	ID='item3'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�4'  	ID='item4' 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�5'  	ID='item5'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�6'  	ID='item6'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�7'  	ID='item7'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�8'  	ID='item8'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�9'  	ID='item9'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>									
													<C> name='�Ӽ�10'  	ID='item10' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�11'  	ID='item11'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>									
													<C> name='�Ӽ�12'  	ID='item12' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�13'  	ID='item13'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>									
													<C> name='�Ӽ�14'  	ID='item14' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>
													<C> name='�Ӽ�15'  	ID='item15'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>	
													<C> name='�Ӽ�16'  	ID='u_empno'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>	
													<C> name='�Ӽ�15'  	ID='u_date'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>									
													<C> name='�Ӽ�15'  	ID='u_ip'  			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left </C>	
													">
											</object>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>	
<object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='  
	<C>Col=head                    Ctrl=txt_head1              Param=value</C>
	<C>Col=head_name               Ctrl=txt_head_name1         Param=value</C>
	'>
</object>
<%
/*=============================================================================
			Print ����
=============================================================================*/
%>		
<object  id="gr_print1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"		VALUE="ds2">
	<param name="DetailDataID"		VALUE="ds2">
	<param name="PaperSize"			VALUE="A4">	
	<param name="LandScape"			VALUE="true">
	<param name="PrintSetupDlgFlag"	VALUE="true">
	<param name="PreviewZoom"		VALUE="100">
	<param name="FixPaperSize"		VALUE="true">
	<param name="PrintMargine"		VALUE="false">
	<param name="NullRecordFlag"	VALUE="false">	
	<param name="Format"			VALUE="
		<B>id=Header ,left=0,top=0 ,right=2869 ,bottom=238 ,face='Arial' ,size=12 ,penwidth=2
			<L>					left=25,   top=237, right=2778,	bottom=237 </L>
			<T>id='�����ڵ����',	left=0,	   top=25,	right=2791,	bottom=122, 			   face='HY������M', size=18 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='#p/#t',		left=2641, top=178, right=2756, bottom=234, 			   face='����', size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='Page:',		left=2328, top=178, right=2591, bottom=234, align='center' face='����', size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=116 ,face='Arial' ,size=12 ,penwidth=2
			<T>id='�Ӽ�8' ,left=1588 ,top=0 ,right=1734 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�7' ,left=1447 ,top=0 ,right=1584 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�6' ,left=1300 ,top=0 ,right=1444 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�5' ,left=1153 ,top=0 ,right=1297 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�4' ,left=1003 ,top=0 ,right=1150 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�1' ,left=553 ,top=0 ,right=700 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�2' ,left=703 ,top=0 ,right=850 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�3' ,left=853 ,top=0 ,right=1000 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�9' ,left=1738 ,top=0 ,right=1884 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�10' ,left=1888 ,top=0 ,right=2034 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�11' ,left=2038 ,top=0 ,right=2184 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�12' ,left=2188 ,top=0 ,right=2334 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�13' ,left=2338 ,top=0 ,right=2484 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�14' ,left=2488 ,top=0 ,right=2634 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�Ӽ�15' ,left=2638 ,top=0 ,right=2784 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ڵ��' ,left=331 ,top=0 ,right=550 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ڵ�' ,left=181 ,top=0 ,right=328 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�з��ڵ�' ,left=31 ,top=0 ,right=178 ,bottom=116 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2869 ,bottom=72 ,face='Arial' ,size=12 ,penwidth=2
			<L> left=25 ,top=3 ,right=2778 ,bottom=3 </L>
			<C>id='head', left=31, top=9, right=178, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='detail', left=181, top=9, right=328, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item15', left=2638, top=9, right=2784, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item14', left=2488, top=9, right=2634, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item13', left=2338, top=9, right=2484, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item12', left=2188, top=9, right=2334, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item11', left=2038, top=9, right=2184, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item10', left=1888, top=9, right=2034, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item9', left=1738, top=9, right=1884, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item8', left=1588, top=9, right=1734, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item7', left=1447, top=9, right=1584, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item6', left=1300, top=9, right=1444, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item5', left=1153, top=9, right=1297, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item4', left=1003, top=9, right=1150, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item3', left=853, top=9, right=1000, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item2', left=703, top=9, right=850, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='item1', left=553, top=9, right=700, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='detail_name', left=331, top=9, right=550, bottom=72, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
		<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=12 ,penwidth=2
			<L> left=25 ,top=0 ,right=2778 ,bottom=0 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
		</B>
		<B>id=Footer ,left=0 ,top=1903 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='<%=dirPath%>/Sales/common/img/icon.jpg' ,left=2391 ,top=0 ,right=2772 ,bottom=94</I>
		</B>
	">
</object> 
<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:350px; top:220px;" 
			FrameBorder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>
	</body>
<!--------------------------------- BODY E N D ------------------------------->	
</html>

