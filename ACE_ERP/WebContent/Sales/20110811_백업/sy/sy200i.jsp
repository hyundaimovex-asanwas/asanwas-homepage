<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �ý��۰���
 * ���α׷�ID 	: SY200I
 * J  S  P		: sy200i
 * �� �� ��		: Sy200i
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������	: ���� ����(��ȸ ��� ���� ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-08-05][�ڰ汹] ȭ�鿡 ǥ�õǴ� �÷� �� [��뿩��],[����] �׸� ��
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

<!-- HTML ����-->��
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	
	<script language="JavaScript">
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>
		function fnSetHeaderDs1(){
				var s_temp = "saup_cd:STRING,saup_nm:STRING";
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
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200i?proType=S&dsType=1";
				ds1.Reset();
			}			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>
			function fnAddRowDs1() {
					ds1.addrow();
					gr1.setcolumn("saup_cd");
			
					window.status=" ���� ���ԵǾ����ϴ�.";
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
		function fnApply() {
				
			if (ds1.IsUpdated) {
				tr1.KeyValue = "Sy200i(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200i?proType=A&dsNum=1";
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
			gr1.RunExcelSheet("���� ����");
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �����ȣ �˾�
%>
			function fnZipCodePopup(){ 
			
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				
				strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);	
			
				if (arrResult != null) {
					arrParam = arrResult.split(";");
			   		zip_cd.Text = arrParam[0];
			   		address1.value = arrParam[1];
			   		
				} else {
				  zip_cd.value = "";
				  address1.value = "";
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
		function fnCheck() {
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
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
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
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
<comment id="__NSID__"><object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table  cellpadding="0" cellspacing="0" border="0" BORDERCOLOR=ORANGE>
	<tr>
	  <TD ALIGN=RIGHT HEIGHT=30>
	   	<table  cellpadding="0" cellspacing="0" border="0">
		  <tr>        					
			<td align="right" width=100%>
			<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:hand;position:relative;top:3px" onclick="fnExcelDs1()">   
			<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;top:3px" onclick="fnSelect()">     
			<img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand;position:relative;top:3px"  onClick="fnAddRowDs1()" >
			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;top:3px" onClick="fnDeleteRowDs1()" >     
			<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;top:3px" onClick="fnApply()">      
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;top:3px"  onclick="fnCancelDs1()"> 
			</td>
		  </tr>
		</table>	
	  </td>
	</tr>
	<tr>
	  <td height=3  border="0"></td>
	</tr>
	<tr> 
	  <td> 
		<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:310px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
		  <tr> 
			<td>
				<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=250px; height:400px;border:1 solid #777777;">   
					<param name="DataID"			value="ds1">                                                                                                                              
					<param name="BorderStyle"   	value="0">                                                                                                                                        
					<param name="Fillarea"			value="true">                                                                                                                             
					<param name="ColSizing"     	value="true">                                                                                                                                     
					<param name="IndWidth"      	value="0">                                                                                                                                        
					<param name="Editable"      	value="true">                                                                                                                                     
					<param name="LineColor" 		value="#dddddd">                                                             
					<param name="Format"			value="  
						<c> Name='���� �ڵ�'	 	ID='saup_cd'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center </c>
						<c> Name='���� ��' 			ID='saup_nm'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center </c>
					">
				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
			</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td valign="top">
			  <table width="495px" cellpadding="0" cellspacing="0">
			  	<tr>
			  		<td align="right">
			  			<table width="530px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" algin=right>
			  				<tr>
			  					<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="boardt02">���� �ڵ�</td>
			  					<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="saup_cd" type="text" class="textbox"   size="10" value="" maxlength="2" onBlur="bytelength(this,this.value,5);" onkeydown="if (event.keyCode == 13) saup_nm.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">���� ��</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="saup_nm" type="text" class="textbox"    value="" size="30" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) saup_no.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">��뿩��</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="use_yn" type="text" class="textbox"    value="" size="10" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) display_seq.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">����</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="display_seq" type="text" class="textbox"    value="" size="10" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) display_seq.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">����� ��ȣ</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="saup_no" type="text" class="textbox"    value="" size="20" maxlength="12" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) ceo_nm.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">��ǥ�̻�</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="ceo_nm" type="text" class="textbox"    value="" size="30" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) zip_cd.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">�����ȣ</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<comment id="__NSID__"><object id=zip_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align=center>			
			  						<param name=Text 		value="">
			  						<param name=Alignment 	value=1>
			  						<param name=Format 		value="###-###">
			  						<param name=Cursor	 	value="iBeam">
			  						<param name=ReadOnly  	value="true">
			  					
			  				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;&nbsp;&nbsp;
			  				<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ȣ�� �˻��մϴ�" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnZipCodePopup();"></td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">�� ��</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="address1" type="text" class="textbox"    value="" size="40" maxlength="60" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) address2.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">���ּ�</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="address2" type="text" class="textbox"    value="" size="40" maxlength="60" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) tel_no1.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">��ǥ��ȭ</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="tel_no1" type="text" class="textbox"    value="" size="20" maxlength="15" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) fax_no1.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">��ǥ�ѽ�</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="fax_no1" type="text" class="textbox"    value="" size="20" maxlength="15" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) uptae.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">�� ��</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="uptae" type="text" class="textbox"    value="" size="30" maxlength="50" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) jongmok.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">�� ��</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="jongmok" type="text" class="textbox"    value="" size="30" maxlength="50" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) homepage.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">Ȩ������</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="homepage" type="text" class="textbox"    value="" size="25" maxlength="25" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) e_mail.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">E-Mail</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="e_mail" type="text" class="textbox"    value="" size="25" maxlength="30" onBlur="bytelength(this,this.value,50);">
			  					</td>
			  				</tr>	
			  			</table>
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
		<C>Col=saup_cd 			Ctrl=saup_cd 		    Param=value </C>
		<C>Col=saup_nm 			Ctrl=saup_nm 		    Param=value </C>
		<C>Col=display_seq 		Ctrl=display_seq 	    Param=value </C>
		<C>Col=use_yn 			Ctrl=use_yn 		    Param=value </C>
		<C>Col=saup_no 			Ctrl=saup_no 			Param=value </C>
		<C>Col=saup_eng_nm 		Ctrl=saup_eng_nm 		Param=value </C>
		<C>Col=ceo_nm 			Ctrl=ceo_nm 			Param=value </C>
		<C>Col=ceo_eng_nm 		Ctrl=ceo_eng_nm 		Param=value </C>
		<C>Col=zip_cd 			Ctrl=zip_cd 			Param=Text </C>
		<C>Col=address1 		Ctrl=address1 			Param=value </C>
		<C>Col=address2 		Ctrl=address2 			Param=value </C>
		<C>Col=address_eng 		Ctrl=address_eng 		Param=value </C>
		<C>Col=tel_no1 			Ctrl=tel_no1 			Param=value </C>
		<C>Col=tel_no2 			Ctrl=tel_no2 			Param=value </C>
		<C>Col=tel_no3 			Ctrl=tel_no3 			Param=value </C>
		<C>Col=fax_no1 			Ctrl=fax_no1 			Param=value </C>
		<C>Col=fax_no2 			Ctrl=fax_no2 			Param=value </C>
		<C>Col=fax_no3 			Ctrl=fax_no3 			Param=value </C>
		<C>Col=uptae 			Ctrl=uptae 				Param=value </C>
		<C>Col=jongmok 			Ctrl=jongmok 			Param=value </C>
		<C>Col=homepage 		Ctrl=homepage 			Param=value </C>
		<C>Col=e_mail 			Ctrl=e_mail 			Param=value </C>
		"     
	>	
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<input type="hidden" name="row" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

