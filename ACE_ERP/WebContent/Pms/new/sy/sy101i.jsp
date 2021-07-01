<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: �����ڵ� ���� 
 * ���α׷�ID 	: SY010 (�ڵ�� �빮��)
 * J  S  P		: sy010 (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Sy010
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-05-19
 * �������		: �����ڵ� ��ȸ, ���, ���� ����, �˾���ȸ , �˻� 
 * T O D O		: 1. xxxxxx ��ó��
 * T O D O		: 2. yyyyyy ��ó�� 
 * [��  ��   ��  ��][������] ����
 * [2011-06-23][�ڰ汹] ��������ý��� �����ڵ�ȭ�� �ű�.
 * [2013-11-07][�ɵ���] �籸�� ���� 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	
	<script language="javascript">
	   	/*
	 	 * ������ �ε�
	 	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			fnInit();
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr1"), "comn");
		}

		<% //�ʱ�ȭ �۾� %>
		function fnInit(){
			//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy101I",
	            "JSP(O:DS1=ds1,O:DS2=ds2)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);			
		}

		/*
		 * �����ͼ� ��� ���� (������)
		 */	
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = "head:STRING,head_nm:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
		
		/*
		 * �����ͼ� ��� ���� (������)
		 */
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp = "head:STRING,detail:STRING,detail_nm:STRING,"
									 + "item1:STRING,item2:STRING,item3:STRING,item4:STRING,item5:STRING,"
									 + "item6:STRING,item7:STRING,item8:STRING,item9:STRING,item10:STRING,"
									 + "item11:STRING,item12:STRING,item13:STRING,item14:STRING,item15:STRING";
									
				ds2.SetDataHeader(s_temp);
			}
		}			
	
		/*
		 * ������ȸ (������ ��ȸ, ��������ȸ)
		 */
		function fnSelect() {
			fnSelectDs1();
			fnSelectDs2();
		}

			
		/*
		 * ������ ��ȸ
		 */
		function fnSelectDs1(){   
			if (ds1.IsUpdated || ds2.IsUpdated) {
				alert("�������� ���� �ֽ��ϴ�.");
			} else {
		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",s_Head="+ txt_head.value
	                  + ",s_HeadName=" + txt_head_name.value;
		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy101I",
		            "JSP(O:DS1=ds1)",
		            param);
		        tr_post(tr1);					
			}
		} 
		
		/*
		 * ������ ��ȸ
		 */
		function fnSelectDs2(){
			if (ds1.IsUpdated || ds2.IsUpdated) {
				alert("�������� ���� �ֽ��ϴ�.");
			} else {
		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
	                  + ",s_Head="+ ds1.namevalue(ds1.rowposition,"head");

		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy101I",
		            "JSP(O:DS2=ds2)",
		            param);
		        tr_post(tr1);					
				
			}
		}


		/*
		 * ������ �ű� 
		 */
		function fnAddRowDs1(){
			if(ds2.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else {
				fnSetHeaderDs1();
				ds1.addrow();
				head.readOnly = false;
				head_name.readOnly = false;
				row.value = ds1.RowPosition;
				gr1.setcolumn("head");
				ds2.clearall();
				
				return;
				
			}
		}
		
		/*
		 * ������ ���߰� 
		 */
		function fnAddRowDs2() {
			fnSetHeaderDs2();
			
			if (ds2.RowStatus(ds2.RowPosition) == 1 && ds2.namevalue(ds2.rowposition,"detail") == "" && ds2.namevalue(ds2.rowposition,"detail_nm") == "" ) {
					alert('����ڵ� �߰� ������ �������� �߰��� �� �����ϴ�');
					gr2.setcolumn("detail");
					return false;
			}
			
			if (ds1.namevalue(ds1.rowposition,"head") == undefined || ds1.namevalue(ds1.rowposition,"head") == "" ) {
					alert('�߰��Ҽ� �����ϴ�');
					gr2.setcolumn("detail");
			} else {
				ds2.addrow();

				ds2.namevalue(ds2.RowPosition, "head") = ds1.namevalue(ds1.rowposition, "head");
				gr2.setcolumn("detail");
			
				window.status="Detail ���� ���ԵǾ����ϴ�.";
			}
		}

		/*
		 * ������ ���� 
		 * ���� �׼ǽ� �ٷ� ����
		 */
		function fnDeleteRowDs1() {			
			if(ds2.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else{
				if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
					
					ds1.deleterow(ds1.rowposition);
					ds2.deleteall();
					
					fnApplyDs1();
					fnApplyDs2();
					
					
					window.status="Master ���� �����Ǿ����ϴ�.";
				
					return;
				}
			}
		}

		/*
		 * ������ ����� 
		 */
		function fnDeleteRowDs2(){
			ds2.deleterow(ds2.rowposition);
			window.status="Detail ���� �����Ǿ����ϴ�.";
		}

		/*
		 * ����
		 * ������ ����� �߰�, ������ ���߰�,���� �� ���� 
		 */
		function fnApply(){
			fnApplyDs1();
			fnApplyDs2();
			
			head.readOnly = true;
			head_name.readOnly = false;
		}

		/*
		 * ������ ���� 1
		 */	
		function fnApplyDs1() {
			if (ds1.IsUpdated) {
				if (ln_Chk())	{
					ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy101I",
		                "JSP(I:DS1=ds1)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
	        		tr_post(tr1);			        
				}
			}
		}

		/*
		 * ������ ����
		 */		
		function fnApplyDs2() {
			if (ds2.IsUpdated) {
				if (ln_Chk()) {
					ln_TRSetting(tr2, 
			                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy101I",
			                "JSP(I:DS2=ds2)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
		        	tr_post(tr2);
				}
			}
		}

		/*
		 * ��� 
		 * ������, ������
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated || ds2.IsUpdated) {
				ds1.undoall();
				ds2.undoall();
			}
			head.readOnly = true;
			head_name.readOnly = false;
			window.status="������ ������ ��ҵǾ����ϴ�.";
			return;
		}

		/*
		 * ���� 
		 */
		function fnExcelGr1(){
			gr2.runexcel("�����ڵ����");
		}

		/*
		 * �Է°� üũ 
		 */
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
			for(i=1;i<row2;i++) { 
				if(ds2.namevalue(i,"detail")==ds2.namevalue(i+1,"detail")) {
					alert("�ڵ尪�� �ߺ��˴ϴ�.");
					return false;
				}
			}
			return true;
		}

	</script>
		
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object  id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<PARAM name="KeyName"  value="toinb_dataid4">
</object>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<!-- 
		������ �׸��� OnClick
	-->
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
		if (ds1.IsUpdated || ds2.IsUpdated) {
			alert("�������� �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			ds1.RowPosition = row.value;
			return false;
		} else {
			fnSelectDs2();
			row.value = ds1.RowPosition;
		}
	</script>

	<!-- 
		������ ���߰� 
		����Ű �Ʒ��� ������� �߰���
	-->
	<script language=JavaScript for=gr2 event=onKeyPress(keycode)>
      	if (keycode == 40 && (ds2.CountRow == ds2.RowPosition) && ds2.namevalue(ds2.rowposition,"detail") != "" && ds2.namevalue(ds2.rowposition,"detail_nm") != "") {
				fnAddRowDs2();
    	}
 	</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	<!-- 
		������ �۾� �Ϸ�
	-->
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
	<!-- 
		������ �۾� ����
	-->
		<script language="javascript" for="tr1" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
	<!-- 
		������ �۾� �Ϸ�
	-->		
		<script language="javascript" for="tr2" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
	<!-- 
		������ �۾� ����
	-->
		<script language="javascript" for="tr2" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>

	<!-- 
		������ �۾� ����
	-->
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		</script>
	<!-- 
		������ �۾�
	-->		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="��ȸ�߿� ������ �߻��߽��ϴ�!.";
		</script>
	<!-- 
		������ ��ȸ �Ϸ� 
	--> 		
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			head.readOnly = true;
					head_name.readOnly = false;
		</script>
	<!-- 
		������ ��ȸ�� 
	-->		
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		</script>
	<!-- 
		������ ��ȸ ����
	-->
		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		</script>
	<!-- 
		������ ��ȸ �Ϸ�
	-->			
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�.");
			}			
		</script>

</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table  width="1010px"  cellpadding="0" cellspacing="0" >
	<tr>
		<td align="left">
			<table width="1010px" border="0"  cellspacing="0" cellpadding="0" >
				<tr height="50px" > 
					<td align="left"  width="355px">
						<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left">
							<tr  bgcolor="#6f7f8d" align="left">
								<td height="30px" width="60px"  bgcolor="#eeeeee" align="center" class="text">�з��ڵ�</td>
								<td width="90px;" align="center" bgcolor="#FFFFFF">
									<input id="txt_head" type="text"  maxlength="36" size="10" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelectDs1();" class="textbox"></td>  	
								<td width="60px"   align="center" bgcolor="#eeeeee" class="text" valign="center">�з���</td>
								<td bgcolor="#ffffff" width="143px">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
										<tr>
											<td width="110px" align="center"  bgcolor="#FFFFFF">
												<input height="22px" id="txt_head_name" type="text" size="10"  maxlength="50" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelectDs1();" class="textbox">
											</td>	
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand"  onClick="fnAddRowDs1()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
									<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" onClick="fnDeleteRowDs1()" >
					 			</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>											
	</tr>
	<tr height="10">
		<td></td>
	</tr>			
	<tr>
		<td align="left">
			
					
			<table WIDTH=1010 border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td align="left" valign="top" width="300px" >
						<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width:300px; height:583px" border="1">
							<param name="DataID"				value="ds1">
							<param name="BorderStyle"   	value="0">
							<param name="Fillarea"			value="true">
							<param name="ColSizing"     	value="true">
							<param name="IndWidth"     		value="0">
							<param name="editable"      		value="false">
							<param name="LineColor" 		value="#dddddd">
							<param name="Format"		value="  
								<C> name='�з��ڵ�' 	ID='head' 				 	 Width=100  align=left editlimit=5</C>
								<C> name='�з���'  		ID='head_nm'   Width=200 align=left editlimit=50</C>											
							">
						</object>
					</td>
					<td width="10px"></td>
					<td valign="top" WIDTH="700">
						<table cellpadding="0" cellspacing="0" >
							<tr>
								<td align="center">
									<table width="690px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
										<tr>
											<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="boardt02">�з��ڵ�</td>
											<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
												<input id="head" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="5" onBlur="bytelength(this,this.value,5);">
											</td>
										</tr>
										<tr>
											<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">�� �� ��</td>
											<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
												<input id="head_name" type="text" class="textbox"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,50);">
											</td>
										</tr>				
									</table>
								</td>
							</tr>
							<tr>
								<td height="7"></td>
							</tr>
							<tr>
								<td height="10">
									<table border= "0" cellpadding=0 cellspacing=0 width="100%" >
										<tr>
											<td height=3  border="0" align=right>
												<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs2()" >
												<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs2()" >
											</td>
										</tr>
									</table>
								</td>
							<tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr>
								<td align="left" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gr2"  style="WIDTH:690px;HEIGHT:490px" border="1">
										<param name="DataID"		value="ds2">
										<param name="BorderStyle"   value="0">
										<param name="Fillarea"		value="true">
										<param name="ColSizing"		value="true">
										<param name="IndWidth"		value="0">
										<param name="Editable"      value="true">
										<param name=SortView  		value="RIGHT">
										<param name="Format"		value="  
										    <C> name='�з��ڵ�' 		ID='head'        Width=60 	align=left editlimit=5 show=true</C>
										    <C> name='�ڵ�'       	ID='detail'      Width=70 	align=left editlimit=10 show=true  sort=true</C>
										    <C> name='�ڵ��'    		ID='detail_nm'   Width=170 	align=left editlimit=50 show=true</C>
										    <C> name='�Ӽ�15'       	ID='item15'      Width=60 	align=left editlimit=50 show=true sort=true</C>
										    <C> name='�Ӽ�1'        	ID='item1'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�2'        	ID='item2'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�3'        	ID='item3'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�4'        	ID='item4'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�5'        	ID='item5'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�6'        	ID='item6'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�7'        	ID='item7'       Width=50 	align=left editlimit=30 show=true sort=true</C>
										    <C> name='�Ӽ�8'        	ID='item8'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�9'        	ID='item9'       Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�10'       	ID='item10'      Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�11'       	ID='item11'      Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�12'       	ID='item12'      Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�13'       	ID='item13'      Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='�Ӽ�14'       	ID='item14'      Width=50 	align=left editlimit=30 show=true</C>
										    <C> name='U_EMPNO'      ID='u_empno'     Width=50 	align=left editlimit=7 show=false</C>
										    <C> name='U_DATE'       ID='u_date'      Width=50 	align=left editlimit=26 show=false</C>
										    <C> name='U_IP' 		ID='u_ip'        Width=50 	align=left editlimit=30 show=false</C>
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

<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>	
<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='  
	<C>Col=head			Ctrl=head		Param=value</C>
	<C>Col=head_nm		Ctrl=head_name	Param=value</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>  

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

