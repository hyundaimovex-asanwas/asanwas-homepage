<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �ý��۰���
 * ���α׷�ID 	: SY110I
 * J  S  P		: sy110i
 * �� �� ��		: Sy110i
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������		: �Ϲ� �����ȣ ���� (��ȸ ��� ���� ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	 
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			fnInit(); 
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
		function fnSetHeaderDs1(){
				var s_temp = "zip_cd:STRING,address1:STRING,address2:STRING,address3:STRING,post_box:STRING";
				ds1.SetDataHeader(s_temp);
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ 
// Parameter 	: 
%>
		function fnInit(){
		    fnSetHeaderDs1();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
		function fnSelect() {
			fnSelectDs1();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  
// Parameter 	: 
%>
		function fnSelectDs1() {
			if(ds1.Isupdated){
				alert("�������� ���� �ֽ��ϴ�.");
			}else{
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy110i?proType=S&dsType=1&sKeyWord="+sKeyWord.value;
				ds1.Reset();
			}			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>
			function fnAddRowDs1() {
					fnSetHeaderDs1();
					ds1.addrow();
					gr1.setcolumn("zip_cd");
			
					window.status=" ���� ���ԵǾ����ϴ�.";
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
		function fnApply() {
				
			if (ds1.IsUpdated) {
				tr1.KeyValue = "Sy110i(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy110i?proType=A&dsNum=1";
				tr1.post();
				ds1.ResetStatus();
			}		
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
		function fnCancelDs1() {
			ds1.undoall();
			window. status="������ ������ ��ҵǾ����ϴ�.";
			return;		
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �����
// Parameter 	: 
%>
			function fnDeleteRowDs1() {			
				if(ds1.IsUpdated) {
					alert("�������� ���� ������ ������ �� �����ϴ�.");
					return;
				}else{
						ds1.deleterow(ds1.rowposition);
						fnApply();
						window.status="���������� �����Ǿ����ϴ�.";
					
						return;
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �μ� (������)
%>
		function fnPrintDs1() {
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : ���� (������)
%>
		function fnExcelDs1() {
			gr1.RunExcelSheet("�����ȣ");
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �з��� �˾� (������)
%>
		function fnPopup() {
			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
		function fnCheck() {
		}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
			function fnSetHeaderDs1(){
				if (ds1.countrow<1){
					var s_temp = "zip_cd:STRING,address1:STRING,address2:STRING,address3:STRING,post_box:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}
			
		
		</script>	
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
////////////////////////////////////////////////////////////////////////////////
//// �Ʒ�Ű�� ������ ��� AddRow
%>
<script language=JavaScript for=gr1 event=onKeyPress(keycode)>

          if (keycode == 40) {
				fnAddRowDs1();
          }

 </script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
//			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
			}
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : " + ds1.ErrorMsg );
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			//document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<comment id="__NSID__"><object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
  <tr height="30px" >                     
	<td align="left"  width="355px">
		<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left">
		  <tr  bgcolor="#6f7f8d" align="left">
			<td height="30px" width="60px"  bgcolor="#eeeeee" align="center" class="text">�� ��</td>
			<td bgcolor="#ffffff" width="143px">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
				  <tr>
					<td width="110px" align="center"  bgcolor="#FFFFFF">
						<input height="22px" id="addr" name="sKeyWord" type="text" size="10"  maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelect();" class="textbox">
					</td>	
				  </tr>
				</table>
			</td>   
		  </tr>           
		</table>
	</TD>
	<TD width="645" align="right" >
		<table  cellpadding="0" cellspacing="0" border="0">
		  <tr>        					
			<td align="right" width=100%><NOBR>
			  <img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:hand;position:relative;top:3px" onclick="fnExcelDs1()">   
			  <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;top:3px" onclick="fnSelect()">     
			  <img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand;position:relative;top:3px"  onClick="fnAddRowDs1()" >
			  <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;top:3px" onClick="fnDeleteRowDs1()" >     
			  <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;top:3px" onClick="fnApply()">      
			  <img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;top:3px"  onclick="fnCancelDs1()"> </NOBR>
			</td>
		  </tr>
		</table>	
	</td>
  </tr>
  <tr>
	<td height=3 COLSPAN=2 border="0"></td>
  </tr>
  <tr> 
	<td COLSPAN=2> 
		<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:310px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
		  <tr> 
			<td>
				<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400px;border:1 solid #777777;">   
					<param name="DataID"			value="ds1">                                                                                                                              
					<param name="BorderStyle"   	value="0">                                                                                                                                        
					<param name="Fillarea"			value="true">                                                                                                                             
					<param name="ColSizing"     	value="true">                                                                                                                                     
					<param name="IndWidth"      	value="0">                                                                                                                                        
					<param name="Editable"      	value="true">                                                                                                                                     
					<param name="LineColor" 		value="#dddddd">                                                             
					<param name="Format"		value="  
						<c> Name='�����ȣ'	 	ID='zip_cd'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center mask='XXX-XXX'</c>
						<c> Name='��/��' 		ID='address1'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center </c>
						<c> Name='��/��' 		ID='address2'	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center </c>
						<c> Name='��/��/��'	 	ID='address3'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=250  align=left </c>
						<c> Name='����'	 		ID='post_box'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=195  align=left </c>
					">
				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
		<C>Col=zip_cd 			Ctrl=zip_cd 		    Param=Text </C>
		<C>Col=address1 		Ctrl=address1 		    Param=value </C>
		<C>Col=address2 		Ctrl=address2			Param=value </C>
		<C>Col=address3 		Ctrl=address3			Param=value </C>
		<C>Col=post_box 		Ctrl=post_box			Param=value </C>"     
	>
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<input type="hidden" name="row" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

