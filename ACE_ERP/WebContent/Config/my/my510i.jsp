<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ��й�ȣ����
 * ���α׷�ID 	: my510i
 * J  S  P		: my510i.jsp
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-10-24
 * �������		: ��й�ȣ����
 * [ �������� ][������] ����
 * [2011-10-24][�ڰ汹] ��й�ȣ����
 * [2014-01-14][�ɵ���] ���� �׽�Ʈ�� �Ϸ�.. �α� �� ���� �������̹Ƿ� �ٷ� ����
 *						���� ��ũ��Ʈ, ���� ���� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="config.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Config/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		
		var jobFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
		} 
		
		function fnInit() {
			
			
			var THeader="pwd_new1:STRING(20):,pwd_new2:STRING(20)";
			ds1.SetDataHeader(THeader);
			
		    //alert("1"); 
	        ds1.addRow();	
	        //alert("2");
		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
		
		}
			
		/*
		 * �Է� üũ
		 */
		function fnCheck() {
			 return true;
		}

		/*
		 * ����
		 */		
		function fnApply() {
		
				   /*if(pwd_past.value==null ||pwd_past.value=='') {
						alert("���� ��й�ȣ�� �Է��ϼ���!");
						return false;
					} else*/
					if (pwd_new1.value==null ||pwd_new1.value=='') {
							alert("���� �� ��й�ȣ�� �Է��ϼ���!");
							return false;
					}  else if (pwd_new2.value==null ||pwd_new2.value=='') {
							alert("��й�ȣ Ȯ���� �Է��ϼ���!");
							return false;
					}	else if (pwd_new1.value != pwd_new2.value){
							alert("��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
							return false;
					}	else if(pwd_new1.value.length < 8){
							alert("��й�ȣ�� ����,����,Ư�������� �������� 8~20�ڸ��� �Է��� �ּ���");
							return false;
					}	else if(pwd_new1.value.length > 20){
							alert("��й�ȣ�� ����,����,Ư�������� �������� 8~20�ڸ��� �Է��� �ּ���");
							return false;
					}	else if(!pwd_new1.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
							alert("��й�ȣ�� ����,����,Ư�������� �������� 8~20�ڸ��� �Է��� �ּ���");
							return false; 
					}
					
					var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
									 + "sPwd_new1=" + ds1.namevalue(ds1.rowposition,"pwd_new1");	
			      
			      	//alert(param);
					ln_TRSetting(tr1, 
					    "<%=dirPath%><%=HDConstant.PATH_MY%>My510I",
					    "JSP(I:DS1=ds1)",
					    param);
					   
					tr_post(tr1);
		}
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		alert("��й�ȣ�� ���� �Ǿ����ϴ�");
		ds1.ClearData();
	</script>	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        alert("row::"+row);               	 			 	
	</script>		
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
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
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border="0" cellpadding="0" cellspacing="0" width="700">	
		<tr>
			<td align="right">
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table>
					<tr>
						<%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=450px; height:1" border="0" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name="Format" 			value="
				                <C> name='���ο��й�ȣ'		ID='pwd_new1' width=160  align=center editlimit=8  edit=none  show=false</C>
				                <C> name='���ο��й�ȣȮ��'  	ID='pwd_new2' width=160    align=center editlimit=8 edit=none show=false</C>
				    			">
						</object>
						<%=HDConstant.COMMENT_END%>
					</tr>					
				</table>
				<table  border="0" cellpadding="0" cellspacing='3'>
					<tr>
						<td  width='120px' height='30px' class='boardt02'>���ο��й�ȣ</td>
						<td   bgcolor='#FFFFFF'>
							&nbsp;&nbsp;<input type="password" id='pwd_new1' 	value='' maxlength='20' minlength="7" size='30' 	class='textbox'>
						</td>
						<td>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;- [���/���̵�] ������
						</td>
					</tr>
					<tr>
						<td width='120px' height='30px' class='boardt02'>���ο��й�ȣȮ��</td>
						<td bgcolor='#FFFFFF'>
							&nbsp;&nbsp;<input type="password" id='pwd_new2' value='' maxlength='20' minlength="7" size='30' 	class='textbox'> 
						</td>
						<td>
						</td>
						<td>&nbsp;&nbsp;&nbsp;- ȸ����� ����ó�� 22. �������ȱ����� �ǰ�<br>
						&nbsp;&nbsp;&nbsp;- [����+����+Ư������] 8��~20�� ���						
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
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
	    <C>Col=pwd_new1           Ctrl=pwd_new1            Param=value </C>
	    <C>Col=pwd_new2         	Ctrl=pwd_new2	       Param=value </C>

	">
</object>
<%=HDConstant.COMMENT_END%>  
<input type="hidden" name="row" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		