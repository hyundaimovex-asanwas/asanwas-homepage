<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - �ý��۸� 	     : ������������
 - ���α׷�ID 	 : xat1001.jsp
 - �� �� ��		 : xat1001_s1,  xat1001_s2, 
 - �� �� ��		 : ������
 - �� �� ��		 : 2018.04.13
 - �������		 : 
 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>

<%@ page import="Account.common.*" %>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/Omsm/common/include/head.jsp"/>
<jsp:include page="/Account/common/include/head.jsp"/>

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>	
	<script language="javascript">
	
	var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	var gs_userid = gusrid;
		//get_cookdata();
		//var gs_userid = gusrid;
		//var gs_fdcode = gfdcode;
		
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit();
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr1"), "comn");
		}

		
		function fnInit(){ 
		}

			
		function fnSetHeaderDs1(){
			if (ds_default1.countrow<1){
				var s_temp = "HEAD_CD:STRING,HEAD_NAME:STRING";
				ds_default1.SetDataHeader(s_temp);
			}
		}
		
		
		function fnSetHeaderDs2(){
			if (ds_default2.countrow<1){
				var s_temp = "HEAD_CD:STRING,DETAIL_CD:STRING,DETAIL_NAME:STRING,PRT_SEQ:DECIMAL,USE_GB:STRING,"
						   + "ITEM1:STRING,ITEM2:STRING,ITEM3:STRING,ITEM4:STRING,ITEM5:STRING,REMARK:STRING,"
						   + "CREATE_ID:STRING,UPDATE_ID:STRING";
									
				ds_default2.SetDataHeader(s_temp);
			}
		}			
	
		
		function fnSelect() {
			fnSelectDs1();
			//fnSelectDs2();
		}

			
		function fnSelectDs1(){   
			if (ds_default1.IsUpdated || ds_default2.IsUpdated) {
				alert("�������� ���� �ֽ��ϴ�.");
			} else {
				
				ds_default1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1001_s1?v_str1="+txt_head_cd_s.value+"&v_str2="+txt_head_name_s.value;	
				ds_default1.Reset();
			}
		} 
	
		function fnSelectDs2(){
			if (ds_default1.IsUpdated || ds_default2.IsUpdated) {
				
			} else {
				
				ds_default2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1001_s2?v_str1="+ds_default1.namevalue(ds_default1.rowposition,"HEAD_CD");	
				
				//prompt("",ds_default2.Dataid);
				ds_default2.Reset();
				
			}
		}
		
		function fnAddRowDs1(){
			if(ds_default2.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else {
				fnSetHeaderDs1();
				ds_default1.addrow();
				txt_head_cd.readOnly = false;
				txt_head_name.readOnly = false;
				row.value = ds_default1.RowPosition;
				gr1.setcolumn("HEAD_CD");
				ds_default2.clearall();
				return;
			}
		}
		
		
		function fnAddRowDs2() {
			fnSetHeaderDs2();
			
			if (ds_default2.RowStatus(ds_default2.RowPosition) == 1 && ds_default2.namevalue(ds_default2.rowposition,"DETAIL_CD") == "" && ds_default2.namevalue(ds_default2.rowposition,"DETAIL_NAME") == "" ) {
					alert('�߰��Ҽ� �����ϴ�1');
					gr2.setcolumn("DETAIL_CD");
					return false;
			}
			
			if (ds_default1.namevalue(ds_default1.rowposition,"HEAD_CD") == undefined || ds_default1.namevalue(ds_default1.rowposition,"HEAD_CD") == "" ) {
					alert('�߰��Ҽ� �����ϴ�2');
					gr2.setcolumn("DETAIL_CD");
			} else {
				ds_default2.addrow();
				ds_default2.namevalue(ds_default2.RowPosition, "HEAD_CD") = ds_default1.namevalue(ds_default1.rowposition, "HEAD_CD");
				gr2.setcolumn("DETAIL_CD");
				window.status="Detail ���� ���ԵǾ����ϴ�.";
			}
		}

		/*
		 * ������ ���� 
		 * ���� �׼ǽ� �ٷ� ����
		 */
		function fnDeleteRowDs1() {			
			if(ds_default2.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else{
				if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
					
					ds_default1.deleterow(ds_default1.rowposition);
					ds_default2.deleteall();
					
					fnApplyDs1();
					//fnApplyDs2()
					window.status="Master ���� �����Ǿ����ϴ�.";
				
					return;
				}
			}
		}

		/*
		 * ������ ����� 
		 */
		function fnDeleteRowDs2(){
			ds_default2.deleterow(ds_default2.rowposition);
			window.status="Detail ���� �����Ǿ����ϴ�.";
		}

		/*
		 * ����
		 * ������ ����� �߰�, ������ ���߰�,���� �� ���� 
		 */
		function fnApply(){
			fnApplyDs1();
			fnApplyDs2();
			
			txt_head_cd.readOnly = true;
			txt_head_name.readOnly = false;
		}

		/*
		 * ������ ���� 1
		 */	
		function fnApplyDs1() {
			if (ds_default1.IsUpdated) {
				if (ln_Chk())	{
					 if(confirm("�����Ͻðڽ��ϱ�?")){
						 
						 tr1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1001_t1?";
						 tr1.KeyValue = "Account.xat1001_t1(I:USER=ds_default1)";	
						 tr1.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
						 tr1.post();
						 
						 /*
						 ln_TRSetting(tr1, 
				                	  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1001_s1",
				                      "JSP(I:DS_DEFAULT=ds_default1)",
				                      "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                      +",v_user_id ="+gusrid 
				                     );
						 
						 prompt("",ds_default.TEXT);
						 tr_post(tr1);
						 */
					 }
				}
			}
		}

		/*
		 * ������ ����
		 */		
		function fnApplyDs2() {
			if (ds_default2.IsUpdated) {
				if (ln_Chk()) {
					 if(confirm("�����Ͻðڽ��ϱ�?")){
						 
						 
						 tr1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1001_t2?";
						 tr1.KeyValue = "Account.xat1001_t2(I:USER=ds_default2)";	
						 tr1.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
						 tr1.post();
						 
						 
						 /*
						 ln_TRSetting(tr1, 
				                	  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1001_s2",
				                      "JSP(I:DS_DEFAULT=ds_default2)",
				                      "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                      +",v_user_id ="+gusrid 
				                     );
						 
						 //prompt("",ds_default.TEXT);
						 tr_post(tr1);
						 */
					 }
				}
			}
		}

		/*
		 * ��� 
		 * ������, ������
		 */
		function fnCancel(){
		
			if(ds_default1.IsUpdated || ds_default2.IsUpdated) {
				ds_default1.undoall();
				ds_default2.undoall();
			}
			txt_head_cd.readOnly = true;
			txt_head_name.readOnly = false;
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
			
			var row1=ds_default1.countrow;
			var row2=ds_default2.countrow;
			for(i=1;i<=row1;i++) {
				if(ds_default1.namevalue(i,"HEAD_CD")=="") {
					alert("�з��ڵ带 �Է��� �ֽʽÿ�");
					return false;
				}
			}
			for(i=1;i<=row2;i++) {
				if (ds_default2.namevalue(i,"DETAIL_CD")=="") {			
					alert("�ڵ带 �Է��� �ֽʽÿ�");
					return false;
				}
			}
			for(i=1;i<row1;i++) {
				if(ds_default1.namevalue(i,"HEAD_CD")==ds_default1.namevalue(i+1,"HEAD_CD")) {
					alert("�з��ڵ尪�� �ߺ��˴ϴ�.");
					return false;
				}
			}
			for(i=1;i<row2;i++) { 
				if(ds_default2.namevalue(i,"DETAIL_CD")==ds_default2.namevalue(i+1,"DETAIL_CD")) {
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
<%=HDConstant.COMMENT_START%>
<object  id=ds_default1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object  id=ds_default2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<!-- 
		������ �׸��� OnClick
	-->
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
		if (ds_default1.IsUpdated || ds_default2.IsUpdated) {
			alert("�������� �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			ds_default1.RowPosition = row.value;
			return false;
		} else {
			fnSelectDs2();
			row.value = ds_default1.RowPosition;
		}
	</script>

	<!-- 
		������ ���߰� 
		����Ű �Ʒ��� ������� �߰���
	-->
	<script language=JavaScript for=gr2 event=onKeyPress(keycode)>
      	if (keycode == 40 && (ds_default2.CountRow == ds_default2.RowPosition) && ds_default2.namevalue(ds_default2.rowposition,"DETAIL_CD") != "" && ds_default2.namevalue(ds_default2.rowposition,"DETAIL_NAME") != "") {
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
		<script language=JavaScript  for=ds_default1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		</script>
	<!-- 
		������ �۾�
	-->		
 		<script language=JavaScript  for=ds_default1 event="OnLoadError()">
			window.status="��ȸ�߿� ������ �߻��߽��ϴ�!.";
		</script>
	<!-- 
		������ ��ȸ �Ϸ� 
	--> 		
		<script language=JavaScript  for=ds_default1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			//head.readOnly = true;
			//head_name.readOnly = false;
			
			if( row < 1){
				ds_default2.clearall();
			}			
			
					
			txt_head_cd.readOnly = true;
			txt_head_name.readOnly = false;
					
		</script>
	<!-- 
		������ ��ȸ�� 
	-->		
		<script language=JavaScript  for=ds_default2 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		</script>
	<!-- 
		������ ��ȸ ����
	-->
		<script language=JavaScript  for=ds_default2 event="OnLoadError()">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		</script>
	<!-- 
		������ ��ȸ �Ϸ�
	-->			
		<script language=JavaScript  for=ds_default2 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�.");
			}			
		</script>

</head>
<jsp:include page="/Common/sys/body_s17.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table  width="845px"  cellpadding="0" cellspacing="0" >
	<tr>
		<td align="left">
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr height="50px" > 
					<td align="left"  width="355px">
						<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left">
							<tr  bgcolor="#6f7f8d" align="left">
								<td height="30px" width="60px"  bgcolor="#eeeeee" align="center" class="text">�з��ڵ�</td>
								<td width="90px;" align="center" bgcolor="#FFFFFF">
									<input id="txt_head_cd_s" type="text"  maxlength="36" size="10"  onkeydown="if(event.keyCode==13) fnSelectDs1();" class="textbox"></td>  	
								<td width="60px"   align="center" bgcolor="#eeeeee" class="text" valign="center">�з���</td>
								<td bgcolor="#ffffff" width="143px">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
										<tr>
											<td width="110px" align="center"  bgcolor="#FFFFFF">
												<input height="22px" id="txt_head_name_s" type="text" size="10"  maxlength="50" onkeydown="if(event.keyCode==13) fnSelectDs1();" class="textbox">
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
									<img src="<%=dirPath%>/Omsm/images/refer.gif"   style="cursor:hand" onclick="fnSelect()">
									<img src="<%=dirPath%>/Omsm/images/new.gif"	 style="cursor:hand" onClick="fnAddRowDs1()" >
									<img src="<%=dirPath%>/Omsm/images/save.gif"	 style="cursor:hand" onClick="fnApply();">
									<img src="<%=dirPath%>/Omsm/images/cancel.gif"	 style="cursor:hand" onclick="fnCancel()">
									<img src="<%=dirPath%>/Omsm/images/delete.gif"  style="cursor:hand" onClick="fnDeleteRowDs1()" >
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
			<table  width="845px"  cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="5"  align="left">
						<table width="845px" border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="left" valign="top" width="300px" >
									<%=HDConstant.COMMENT_START%>
									<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=300px; height:383px" border="1">
										<param name="DataID"				value="ds_default1">
										<param name="BorderStyle"   	value="0">
										<param name="Fillarea"			value="true">
										<param name="ColSizing"     	value="true">
										<param name="IndWidth"     		value="0">
										<param name="editable"      		value="false">
										<param name="LineColor" 		value="#dddddd">
										<param name="Format"		value="  
											<C> name='�з��ڵ�' 	ID='HEAD_CD'  	 Width=100  align=left editlimit=5</C>
											<C> name='�з���'  	ID='HEAD_NAME'   Width=200 align=left editlimit=50</C>											
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								<td width="10px"></td>
								<td valign="top">
									<table width="530px" cellpadding="0" cellspacing="0" >
										<tr>
											<td align="center">
												<table width="530px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="boardt02">�з��ڵ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="txt_head_cd" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="5" >
														</td>
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">�� �� ��</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="txt_head_name" type="text" class="textbox"   readonly="true" value="" size="20" maxlength="50" >
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
												<%=HDConstant.COMMENT_START%>
													<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gr2"  style="WIDTH:530px;HEIGHT:290px" border="1">
														<param name="DataID"		value="ds_default2">
														<param name="BorderStyle"   value="0">
														<param name="Fillarea"		value="true">
														<param name="ColSizing"		value="true">
														<param name="IndWidth"		value="0">
														<param name="Editable"      value="true">
														<param name=SortView  		value="RIGHT">
														<param name="Format"		value="  
														    <C> name='�з��ڵ�' 		ID='HEAD_CD'       Width=50 	align=left   editlimit=5  </C>
														    <C> name='�ڵ�'       	ID='DETAIL_CD'     Width=50 	align=left   editlimit=10   sort=true</C>
														    <C> name='�ڵ��'    		ID='DETAIL_NAME'   Width=170 	align=left   editlimit=50  </C>
														    <C> name='����'       	ID='PRT_SEQ'       Width=30 	align=center editlimit=50  </C>
														    <C> name='���'       	ID='USE_GB'        Width=50 	align=left   editlimit=50  sort=true  EditStyle=Combo Data='T:���,F:�̻��'</C>
														    <C> name='�Ӽ�1'       	ID='ITEM1'         Width=70 	align=left   editlimit=50  sort=true</C>
														    <C> name='�Ӽ�2'        	ID='ITEM2'         Width=70 	align=left   editlimit=30 </C>
														    <C> name='�Ӽ�3'        	ID='ITEM3'         Width=70 	align=left   editlimit=30 </C>
														    <C> name='�Ӽ�4'        	ID='ITEM4'         Width=70 	align=left   editlimit=30 </C>
														    <C> name='�Ӽ�5'        	ID='ITEM5'         Width=70 	align=left   editlimit=30 </C>
														    <C> name='���'        	ID='REMARK'        Width=100 	align=left   editlimit=80 </C>
														">
													</object>
												<%=HDConstant.COMMENT_END%>
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

<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>	
<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>> 
	<param name=DataID    value=ds_default1>
	<param name=BindInfo  value='  
	<C>Col=HEAD_CD			Ctrl=txt_head_cd		Param=value</C>
	<C>Col=HEAD_NAME		Ctrl=txt_head_name	    Param=value</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>  

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

