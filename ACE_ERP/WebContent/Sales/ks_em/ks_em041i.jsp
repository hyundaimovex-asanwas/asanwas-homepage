<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �޿� ���� ���
+ ���α׷�ID : ks_em041i.jsp
+ ������� : 
+ �� �� �� : �� �� ��  
+ �ۼ����� : 2008.10.14
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : KS_Em041_S1.java  KS_Em041_t1.java
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan	
	java.util.Calendar date = java.util.Calendar.getInstance();	
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");   	
   	String firstday = m_today.format(date.getTime());	
   			
%>
<!-- HTML ����-->
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">

   
	get_cookdata();
   //���ÿ��� ����ϱ� ���� ���Ƿ� ����.
   /*
	var gs_date = gcurdate;
	var year_date = gcurdate.substring(0,7);
	*/
	
	var gs_date ='<%=firstday%>';
	
	var year_date ='<%=firstday%>';
	
    var useid = gusrid;

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			ln_before();//����ȸ
			
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			
      		gcem_att_dt_fr.Text=year_date;
      
		}

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	  gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em041_S1"
											 + "?v_str1=" + fn_trim(gclx_dept_cd.bindcolval) 	//����
											 + "&v_str2=" + fn_trim(gcem_att_dt_fr.Text)			//�޿����
											 + "&v_str3=" + fn_trim(txt_empno.value);			    //����(����)
   
	  gcds_data00.Reset();

 }

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//����  KS006
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";	
	gcds_ks006.Reset();
	
	//�׸񱸺� KS022
	gcds_ks022.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cm007?v_str1=KS022";	
	gcds_ks022.Reset();

	//�׸񱸺� KS023
	gcds_ks023.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cm007?v_str1=KS023";	
	gcds_ks023.Reset();
	
//	ln_SetDataHeader();//gcds_data00 �ش�����

}

/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

    var arrParam	= new Array();  
	var strURL   = "./ks_com_pop.jsp";	
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";	
	var arrResult = showModalDialog(strURL,window,strPos);
		
	if (arrResult != null) {	
		arrParam = arrResult.split(";");		
		txt_empno.value = arrParam[0];		
		txt_empnmk.value = arrParam[1];		
	} else {	
		txt_empno.value = "";		
		txt_empnmk.value = "";		
	}
}

/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find2(){//������ȸ2

    var arrParam	= new Array();  
	var strURL   = "./ks_com_pop.jsp";	
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";	
	var arrResult = showModalDialog(strURL,window,strPos);
		
	if (arrResult != null) {	
		arrParam = arrResult.split(";");			
		txt_empnmk_R.value = arrParam[1];		
	} else {	
		txt_empnmk_R.value = "";		
	}
}

/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Save(){

	if(!ln_Save_Chk()) return;

	if (gcds_data00.IsUpdated) {
	
		 if (confirm("�����Ͻðڽ��ϱ�?")) {
		 
				for(i=1;i<=gcds_data00.countrow;i++){
				
					if(gcds_data00.SysStatus(i)=='3'){
					
						gcds_data00.namevalue(i,"ORG_PB_DIV") = gcds_data00.OrgNameValue(i,"PB_DIV");
						gcds_data00.namevalue(i,"ORG_PAY_CD") = gcds_data00.OrgNameValue(i,"PAY_CD");
						
					}
				}	
				
				gctr_data00.KeyValue = "KS_Em041_T1(I:USER=gcds_data00)";
				
				gctr_data00.Parameters ="v_str1="+useid;
				
				gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em041_T1";
				
				//prompt('',gcds_data00.text);
				
				gctr_data00.post();
		 }
	}
}

/*----------------------------------------------------------------------------
	Description : ����� üũ
----------------------------------------------------------------------------*/
function ln_Save_Chk(){

	for(i=1;i<=gcds_data00.countrow;i++){

		if(gcds_data00.SysStatus(i)==3){ // �����ҷ��� �Ұ��
		

			 
		}
		
	}
	
	return true;
	
}



/*----------------------------------------------------------------------------
	Description : ��Ͻ�
----------------------------------------------------------------------------*/
function ln_Create(){

	alert("�����ϰ� �־!");
	
	
}





/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Delete(){

		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
		
			gcds_data00.deleterow(gcds_data00.rowposition);
			
			gctr_data00.KeyValue = "KS_Em041_t1(I:USER=gcds_data00)";
			
			gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em041_t1";
			
						prompt('',gcds_data00.text);
						
			gctr_data00.post();
			
		}
		
}

</script>




<%/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/%>     
		<script language=JavaScript for= gclx_pb_div event=OnSelChange()>
			//gcds_cm021.Filter();
		</script>

		<script language=JavaScript for= gclx_pay_cd event=OnSelChange()>
       //gcds_cm021.Filter();
		</script>

    <!-- filter -->
    <script language=JavaScript for=gcds_ks022 event=onFilter(row)>
      if(gcds_data00.SysStatus(gcds_data00.rowposition)==1){
				if(gclx_pb_div.bindcolval=="1"){//����(1 �ϰ��)
					if(gcds_ks022.namevalue(row,"ITEM2")=="1"){
						return true;
					}else{
						return false;
					}
				}		

				if(gclx_pb_div.bindcolval=="2"){//���� (2�ϰ��)
					if(gcds_ks022.namevalue(row,"ITEM2")=="2"){
						return true;
					}else{
						return false;
					}
				}		
		  }else{
				return true;
			}
	  </script> 
  
	    <!-- �Ҽ��� -->
	    <script language="javascript" for="gcds_ks006" event="onloadCompleted(row,colid)">
	      gcds_ks006.insertrow(1);
	      gcds_ks006.namevalue(1,"COM_CODE") = "";
	      gcds_ks006.namevalue(1,"COM_SNAME") = "��ü";
	      gclx_dept_cd.index = 0;
	    </script>

		<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
		window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		document.all.LowerFrame.style.visibility="visible";
		</script>
		<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
		</script>

    <script language=JavaScript for=gcds_data00 event=OnRowPosChanged(row)>
		  if(gcds_data00.SysStatus(row)!=1){
				gclx_pb_div.enable=false;
			  gclx_pay_cd.enable=false;
			}
    </script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/%>

    <script language="javascript" for="gctr_data00" event="OnSuccess()">
      alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
    </script>
    <script language="javascript" for="gctr_data00" event="OnFail()">
      alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
    </script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_ks022 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_ks023 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">
								<img src="<%=dirPath%>/Sales/images/delete.gif"			style="cursor:hand" onClick="ln_Delete()">
								<img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:hand" onClick="ln_Create()">
								<img src="<%=dirPath%>/Sales/images/save.gif"			style="cursor:hand" onClick="ln_Save()">
								<img src="<%=dirPath%>/Sales/images/refer.gif"   		style="cursor:hand" onclick="ln_Query()">	
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
					 	<td bgcolor="#eeeeee" align="center">����</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_ks006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
			           	<td bgcolor="#eeeeee" align="center">�޿����</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
				              <OBJECT id=gcem_att_dt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;" >
				              <param name=Alignment			value=0>
				              <param name=Border	      value=true>
				              <param name=Format	      value="YYYY/MM">
				              <param name=PromptChar	  value="_">
				              </OBJECT><%=HDConstant.COMMENT_END%>
				              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_att_dt_fr', 'Text');">
				              </td>
				                <td bgcolor="#eeeeee" align="center" width="50">����</td>
				                <td bgcolor="#FFFFFF">
								<input type="text" id="txt_empnmk" style="position:relative;left:8px;top:-2px;width:100px;" >
			                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:8px;top:2px;cursor:hand" onclick="ln_Find()">
			                <input type="text" id="txt_empno" style="position:relative;left:8px;top:-2px;width:60px;" >
						</td>
            		</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:600px;height:390px;">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:600;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
				                <F> Name=NO				  ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=center </F> 
				                <FC>ID=DEPT_NM  ,		Name=����,			width=100,	align=left,		HeadBgColor=#B9D4DC,show=false</FC>
								<FC>ID=EMPNO    ,		Name=����,			width=70,	  align=center,	HeadBgColor=#B9D4DC,</FC>
				                <FC>ID=EMPNMK   ,		Name=����,			width=75,	  align=left,		HeadBgColor=#B9D4DC,</FC>
				                <FC>ID=PB_DIV   ,		Name=�׸񱸺�,	width=90,	  align=left,		HeadBgColor=#B9D4DC, EditStyle=Lookup, Data='gcds_ks022:COM_CODE:COM_SNAME'</FC>
				                <FC>ID=PAY_CD   ,		Name=�׸��,		width=90,	  align=left,		HeadBgColor=#B9D4DC, EditStyle=Lookup, Data='gcds_ks023:COM_CODE:COM_SNAME'</FC>
				                <FC>ID=EX_PAY   ,		Name=�����ݾ�,	width=70,	  align=right,	HeadBgColor=#B9D4DC, dec=2</C>
				                <FC>ID=EX_FRDT  ,		Name=���ۿ�,		width=75,		align=center,	HeadBgColor=#B9D4DC,Mask='XXXX/XX'</FC>
				                <FC>ID=EX_TODT  ,		Name=�����,		width=75,		align=center,	HeadBgColor=#B9D4DC,Mask='XXXX/XX'</FC>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:600;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
						<td bgcolor="#FFFFFF">&nbsp;</td>
						<td>
							<table cellpadding=0 cellspacing=0 style="width:218px;height:390px;">
								<tr height="18">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010">����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
				                    <input type="text" id="txt_empnmk_R" style="position:relative;left:8px;width:80px;" readonly>
				                    <input type="hidden" id="txt_empno_R" style="position:relative;left:8px;width:80px;">
				                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand"  onclick="ln_Find2()">
									</td>
								</tr>
								<tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�μ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >

				                    <input type="text" id="txt_deptcd_R1" style="position:relative;left:8px;width:80px;" readonly>
				                    <input type="hidden" id="txt_jobcd_R1" style="position:relative;left:8px;width:40px;" readonly>
									</td>
								</tr>
                				<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�׸񱸺�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
				                    <%=HDConstant.COMMENT_START%>
				                    <OBJECT id=gclx_pb_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
				                    style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
				                    <param name=ComboDataID			value="gcds_ks022">
				                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
				                    <param name=SearchColumn		value=COM_SNAME>
				                    <param name=Sort						value=false>
				                    <param name=Index						value=0>
				                    <param name=ListExprFormat	value="COM_SNAME^0^100">
				                    <param name=BindColumn			value=COM_CODE>
				                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                				<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�׸��</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
				                    <%=HDConstant.COMMENT_START%>
				                    <OBJECT id=gclx_pay_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
				                    style="position:relative;left:8px;top:1px;font-size:12px;width:100px;height:300px">
				                    <param name=ComboDataID			value="gcds_ks023">
				                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
				                    <param name=SearchColumn		value=COM_SNAME>
				                    <param name=Sort						value=false>
				                    <param name=Index						value=0>
				                    <param name=ListExprFormat	value="COM_SNAME^0^100">
				                    <param name=BindColumn			value=COM_CODE>
				                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
  				              <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�����ݾ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
				                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_ex_pay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
				                    style="position:relative; left:8px;top:1px; width:80px;  font-family:����; font-size:9pt;z-index:2; ">
				                    <param name=Alignment			value=2>
				                    <param name=Border	      value=true>
				                    <param name=Numeric	      value=true>
									<param name=MaxDecimalPlace   value=2>
				                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�������۳��</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
				                    <%=HDConstant.COMMENT_START%>
				                    <OBJECT id=gcem_ex_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				                    style="position:relative; left:8px;top:2px; width:50px; font-family:����; font-size:9pt;z-index:2; " >
				                    <param name=Alignment			value=0>
				                    <param name=Border	      value=true>
				                    <param name=Format	      value="YYYY/MM">
				                    <param name=PromptChar	  value="_">
				                    </OBJECT><%=HDConstant.COMMENT_END%>
				                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_ex_frdt', 'Text');">
									</td>
								</tr>
                				<tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1011" >����������</td>
									<td bgcolor="#FFFFFF" class="tab_z1111" >
				                    <%=HDConstant.COMMENT_START%>
				                    <OBJECT id=gcem_ex_todt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				                    style="position:relative; left:8px;top:2px; width:50px; font-family:����; font-size:9pt;z-index:2; " >
				                    <param name=Alignment			value=0>
				                    <param name=Border	      value=true>
				                    <param name=Format	      value="YYYY/MM">
				                    <param name=PromptChar	  value="_">
				                    </OBJECT><%=HDConstant.COMMENT_END%>
				                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_ex_todt', 'Text');">
									</td>
								</tr>
				                <tr height="100">
				                  <td bgcolor="#FFFFFF" class="tab_z0000">&nbsp;</td>
				                </tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- �⺻�� -->
						<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
							<PARAM NAME="DataID"				VALUE="gcds_data00">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
				                <C>Col=EMPNO      			Ctrl=txt_empno_R     						Param=Value</C>
				                <C>Col=EMPNMK     			Ctrl=txt_empnmk_R    					Param=Value</C>
				                <C>Col=DEPT_CD    			Ctrl=txt_deptcd_R2    					Param=Value</C>
				                <C>Col=DEPT_NM    			Ctrl=txt_deptcd_R1    					Param=Value</C>
				                <C>Col=JOB_CD     				Ctrl=txt_jobcd_R1    						Param=Value</C>
				                <C>Col=PB_DIV     				Ctrl=gclx_pb_div     						Param=bindcolval</C>
				                <C>Col=PAY_CD     				Ctrl=gclx_pay_cd     					Param=bindcolval</C>
				                <C>Col=CUST_SID   			Ctrl=txt_cust_R      						Param=Value</C>
				                <C>Col=EX_PAY     				Ctrl=gcem_ex_pay     					Param=Text</C>
				                <C>Col=EX_FRDT    				Ctrl=gcem_ex_frdt    					Param=Text</C>
				                <C>Col=EX_TODT    				Ctrl=gcem_ex_todt    					Param=Text</C>
								<C>Col=REMARK    	  			Ctrl=txt_remark     						Param=value</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>


