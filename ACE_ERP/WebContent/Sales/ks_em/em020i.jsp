<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �޿� ����
+ ���α׷�ID : em016i.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.11
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em020_S.java
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
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(e){//������ȸ

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);

  if(e=='01'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno.value = arrParam[0];
        txt_empnmk.value = arrParam[1];
      } else {
        txt_empno.value = "";
        txt_empnmk.value = "";
      }
  }else if(e=='02'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno_R.value = arrParam[0];
        txt_empnmk_R.value = arrParam[1];
        txt_deptcd_R1.value = arrParam[2];
        txt_teamcd_R1.value = arrParam[3];
        txt_cust_R.value = arrParam[4];
        txt_jobcd_R1.value = arrParam[5];
        txt_deptcd_R2.value = arrParam[6];
        txt_teamcd_R2.value = arrParam[7];
      } else {
        txt_empno_R.value = "";
        txt_empnmk_R.value = "";
        txt_deptcd_R1.value = "";
        txt_teamcd_R1.value = "";
        txt_cust_R.value = "";
        txt_jobcd_R1.value = "";
        txt_deptcd_R2.value = "";
        txt_teamcd_R2.value = "";
      }
  }
}


/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	  gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em020_S"
											 + "?v_str1=" + fn_trim(gclx_team_cd.bindcolval)	//�Ҽ�
											 + "&v_str2=" + fn_trim(gcem_att_dt_fr.Text)			//�����
											 + "&v_str3=" + fn_trim(gcem_att_dt_fr.Text)			//�����
											 + "&v_str4=" + fn_trim(txt_empno.value)			    //���(����)
											 + "&v_str5=" + fn_trim(gclx_dept_cd.bindcolval); //�μ�
    //prompt('',gcds_data00.DataID);
	  gcds_data00.Reset();

		gclx_pb_div.enable = false;
    gclx_pay_cd.enable = false;
 }

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//����  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();
	//�ٹ���ü  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();
	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();
	//�ٹ���  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();
 	//�޿��׸񱸺�  CM016
	gcds_cm016.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM016";
	gcds_cm016.Reset();
	//�޿����ް����׸��  CM021
	gcds_cm021.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM021";
	gcds_cm021.Reset();

	gcds_cm021_all.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM021";
	gcds_cm021_all.Reset();

	gclx_pb_div.enable = false;
  gclx_pay_cd.enable = false;
}


/*----------------------------------------------------------------------------
		Description : 
----------------------------------------------------------------------------*/
	function ln_Add(){
		 gcds_data00.addrow();
		 //alert(""+gcds_data00.SysStatus(gcds_data00.rowposition));
		 gclx_pb_div.enable = true;
     gclx_pay_cd.enable = true;
	}
/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Save(){
	if (gcds_data00.IsUpdated) {
		 if (confirm("�����Ͻðڽ��ϱ�?")) {
				for(i=1;i<=gcds_data00.countrow;i++){
					if(gcds_data00.SysStatus(i)=='3'){
						gcds_data00.namevalue(i,"ORG_PB_DIV") = gcds_data00.OrgNameValue(i,"PB_DIV");
						gcds_data00.namevalue(i,"ORG_PAY_CD") = gcds_data00.OrgNameValue(i,"PAY_CD");
					}
				}	
				gctr_data00.KeyValue = "Em020_T1(I:USER=gcds_data00)";
				gctr_data00.Parameters ="v_str1="+useid;
				gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em020_T1";
				//prompt('',gcds_data00.text);
				gctr_data00.post();
		 }
	}
}
/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Delete(){
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
			gcds_data00.deleterow(gcds_data00.rowposition);
			gctr_data00.KeyValue = "Em020_T1(I:USER=gcds_data00)";
			gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em020_T1";
			gctr_data00.post();
		}
}


/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
function ln_Excel(){

 var szName = "�޿�����";
 var szPath = "C:\\Test\\em020i.xls";
 
 if (gcds_data00.countrow<1){
	 alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
 }else{
	 gcgd_disp.GridToExcel(szName,szPath,2);
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
    <script language=JavaScript for=gcds_cm021 event=onFilter(row)>
      if(gcds_data00.SysStatus(gcds_data00.rowposition)==1){
				if(gclx_pb_div.bindcolval=="1"){//����(1 �ϰ��)
					if(gcds_cm021.namevalue(row,"ITEM2")=="1"){
						return true;
					}else{
						return false;
					}
				}		

				if(gclx_pb_div.bindcolval=="2"){//���� (2�ϰ��)
					if(gcds_cm021.namevalue(row,"ITEM2")=="2"){
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
    <script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
      gcds_cm003.insertrow(1);
      gcds_cm003.namevalue(1,"COM_CODE") = "";
      gcds_cm003.namevalue(1,"COM_SNAME") = "��ü";
      gclx_team_cd.index = 0;
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
		 // gcds_cm021.undoAll();
     // gcds_cm021.ImportData(gcds_cm021_all.ExportData(0,gcds_cm021_all.countrow,false));
		  

			//gcds_cm021.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM021";
	    //gcds_cm021.Reset();

			//gclx_pb_div.bindcolval = "";
			//gclx_pay_cd.bindcolval = "";	    
			
				//alert("OnRowPosChanged");
		    //gcds_cm021.Filter();

        /*
				if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='1'){ //�ű�
						gclx_pb_div.Enable=true;
						gclx_pay_cd.Enable=true;
				}else{
						gclx_pb_div.Enable=false;
						gclx_pay_cd.Enable=false;
				}
				*/
    </script>

  <script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm006","gclx_dept_cd");
  </script>
  <script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm003","gclx_team_cd");
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
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm016 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cm021 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="UseFilter"	value="true">
</OBJECT>

<OBJECT id=gcds_cm021_all classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- �޿����� -->
<OBJECT id=gcds_aa classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<!-- �޿����� -->
<OBJECT id=gcds_bb classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cu003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
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
								<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand" onclick="ln_Query()">
                <img src="<%=dirPath%>/Sales/images/plus.gif"	  style="cursor:hand" onClick="ln_Add()" >
								<img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:hand" onClick="ln_Delete()" >		
								<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
								<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onClick="ln_Excel()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
					 	<td bgcolor="#eeeeee" align="center">�μ�</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
            <td bgcolor="#eeeeee" align="center">�Ҽ�</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_team_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm003">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
           	<td bgcolor="#eeeeee" align="center">�����</td>
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
                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:8px;top:2px;cursor:hand" onclick="ln_Find('01')">
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
                <FC>ID=TEAM_NM  ,		Name=�Ҽ�,			width=100,	align=left,		HeadBgColor=#B9D4DC,</FC>
								<FC>ID=EMPNO    ,		Name=���,			width=50,	  align=center,	HeadBgColor=#B9D4DC,</FC>
                <FC>ID=EMPNMK   ,		Name=����,			width=55,	  align=left,		HeadBgColor=#B9D4DC,</FC>
                <FC>ID=PB_DIV   ,		Name=�׸񱸺�,	width=90,	  align=left,		HeadBgColor=#B9D4DC, EditStyle=Lookup, Data='gcds_cm016:COM_CODE:COM_SNAME'</FC>
                <FC>ID=PAY_CD   ,		Name=�׸��,		width=90,	  align=left,		HeadBgColor=#B9D4DC, EditStyle=Lookup, Data='gcds_cm021:COM_CODE:COM_SNAME'</FC>
                <FC>ID=EX_PAY   ,		Name=�����ݾ�,	width=60,	  align=right,	HeadBgColor=#B9D4DC, dec=2</C>
                <C>ID=EX_FRDT  ,		Name=���ۿ�,		width=50,		align=center,	HeadBgColor=#B9D4DC,Mask='XXXX/XX'</C>
                <C>ID=EX_TODT  ,		Name=�����,		width=50,		align=center,	HeadBgColor=#B9D4DC,Mask='XXXX/XX'</C>
                <C>ID=CUST_SID ,		Name=CUST_SID,	width=60,		align=center,	HeadBgColor=#B9D4DC, show=false</C>
								<C>ID=REMARK   ,		Name=���,			width=100,	  align=left,		HeadBgColor=#B9D4DC,</C>
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
                    <input type="text" id="txt_empnmk_R" style="position:relative;left:8px;width:80px;" readonly><input type="hidden" id="txt_empno_R" style="position:relative;left:8px;width:80px;">
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand"  onclick="ln_Find('02')">
									</td>
								</tr>
								<tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�μ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <input type="text" id="txt_deptcd_R2" style="position:relative;left:8px;width:40px;" readonly>
                    <input type="text" id="txt_deptcd_R1" style="position:relative;left:8px;width:80px;" readonly>
                    <input type="hidden" id="txt_cust_R" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_jobcd_R1" style="position:relative;left:8px;width:40px;" readonly>
									</td>
								</tr>
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�Ҽ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <input type="text" id="txt_teamcd_R2" style="position:relative;left:8px;width:40px;" readonly>
                    <input type="text" id="txt_teamcd_R1" style="position:relative;left:8px;width:80px;" readonly>
									</td>
								</tr>
                <tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�׸񱸺�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_pb_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm016">
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
                    <param name=ComboDataID			value="gcds_cm021">
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
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >����������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
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
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >���</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<textarea id="txt_remark" class="txtbox"  style= "width:110px;height:40px;overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;</nobr>
                  </td>
								</tr>
                <tr height="80">
                  <td bgcolor="#eeeeee" class="tab_z1011">&nbsp;</td>
                  <td class="tab_z1111">&nbsp;</td>
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
                <C>Col=EMPNO      			Ctrl=txt_empno_R     					Param=Value</C>
                <C>Col=TEAM_CD    			Ctrl=txt_teamcd_R2    			  Param=Value</C>
                <C>Col=TEAM_NM    			Ctrl=txt_teamcd_R1    				Param=Value</C>
                <C>Col=DEPT_CD    			Ctrl=txt_deptcd_R2    				Param=Value</C>
                <C>Col=DEPT_NM    			Ctrl=txt_deptcd_R1    				Param=Value</C>
                <C>Col=JOB_CD     			Ctrl=txt_jobcd_R1    					Param=Value</C>
                <C>Col=EMPNMK     			Ctrl=txt_empnmk_R    					Param=Value</C>
                <C>Col=PB_DIV     			Ctrl=gclx_pb_div     					Param=bindcolval</C>
                <C>Col=PAY_CD     			Ctrl=gclx_pay_cd     					Param=bindcolval</C>
                <C>Col=CUST_SID   			Ctrl=txt_cust_R      					Param=Value</C>
                <C>Col=EX_PAY     			Ctrl=gcem_ex_pay     					Param=Text</C>
                <C>Col=EX_FRDT    			Ctrl=gcem_ex_frdt    					Param=Text</C>
                <C>Col=EX_TODT    			Ctrl=gcem_ex_todt    					Param=Text</C>
								<C>Col=REMARK    	  		Ctrl=txt_remark     					Param=value</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>