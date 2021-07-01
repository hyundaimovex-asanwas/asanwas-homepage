<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - ȭ�ְ���
+ ���α׷� ID	: TR00601.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: �̹���
+ �� �� �� ��	: tr00601_s1, tr00601_t1
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
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
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

		get_cookdata();
		
		var gs_userid = gusrid;

		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			ln_Start();
			
			window.status="�Ϸ�";

		}
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start() {

	//������Ʈ[�˻�]
	gcds_project_cd_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_project_cd_fr.Reset();

	//������Ʈ[�Է�]
	gcds_project_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_project_cd.Reset();

}
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00601_s1?v_str1=" + gclx_project_cd_fr.bindColVal + "&v_str2=" + gcem_vend_cd_fr.text
	+"&v_str3=" + txt_vend_nm_fr.value;
	gcds_data.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_data.AddRow();
	//gcem_vend_cd.focus();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (gcds_data.IsUpdated){
	
				if(ln_Chk()){

				if (confirm("�����Ͻðڽ��ϱ�?")){	

					gctr_data.Action = g_servlet+"/Transfer.tr00601_t1?";
					gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
					gctr_data.post();
			}
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
	
		gcds_data.deleterow(gcds_data.rowposition);
		gcds_data.KeyValue = "tr00601_t1(I:USER=gcds_data)";
		gctr_data.Action = g_servlet+"/Transfer.tr00601_t1?";
		ln_Save();


	}
}

/******************************************************************************
	Description : �Է�üũ 
******************************************************************************/
function ln_Chk(){

	  //�ŷ�ó�ڵ�üũ
		if (fn_trim(gcem_vend_cd.text)=="" ){
			alert("�ŷ�ó��ȣ�� �Է��Ͻʽÿ�.");
			//gcem_vend_cd.focus();
			return false; 
	}
		if (fn_trim(gclx_project_cd.BindColVal)=="" ){
			alert("������Ʈ�� �����Ͻʽÿ�.");
			gclx_project_cd.focus();
			return false; 
		}

	return true;
}

/******************************************************************************
	Description : �ŷ�ó�ڵ� ã��
******************************************************************************/
function ln_Popup(){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Transfer/jsp/tr00601_popup.jsp";
	strPos = "dialogWidth:395px;dialogHeight:419px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_vend_cd.text = arrParam[0];
		txt_vend_nm.value = arrParam[1];
		txt_vend_tel.value = arrParam[2];
		txt_vend_fax.value = arrParam[3];
		txt_vend_tel.focus();

	}
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- ������Ʈ [�˻�] -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_project_cd_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- ������Ʈ -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_project_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00601_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00601_t1(I:USER=gcds_data)">
</OBJECT><%=HDConstant.COMMENT_END%>  

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";

	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>


<!-- ������Ʈ [�˻�] -->
<script language="javascript" for="gcds_project_cd_fr" event="onloadCompleted(row,colid)">
	gcds_project_cd_fr.InsertRow(1);
	gcds_project_cd_fr.NameValue(1,"MINORCD")="";
	gcds_project_cd_fr.NameValue(1,"MINORNM")="��ü";
	gclx_project_cd_fr.index=0;
</script>

<!-- ������Ʈ -->
<script language="javascript" for="gcds_project_cd" event="onloadCompleted(row,colid)">
	gcds_project_cd.InsertRow(1);
	gcds_project_cd.NameValue(1,"MINORCD")="";
	gcds_project_cd.NameValue(1,"MINORNM")="��ü";
	gclx_project_cd.index=0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
	//gcds_data.reset();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>


<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="877" align="right" background="../../common/img/com_t_bg.gif">
			<img src="../../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
			<img src="../../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
	    	<img src="../../../Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      <table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">������Ʈ</td>
					<td class="tab21" style="width:200px;">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gclx_project_cd_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:150px;">
								<param name=ComboDataID			value="gcds_project_cd_fr">
								<param name=SearchColumn			value="MINORNM">
								<param name=ListExprFormat			value="MINORNM^0^100">
								<param name=BindColumn				value="MINORCD">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">�ŷ�ó�ڵ�</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:25px;font-family:����;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();"> 
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_vend_cd_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">�ŷ�ó��</td>
					<td class="tab21">
					<input type="text" class="txt11" id="txt_vend_nm_fr" style="width:100px;height:18px;IME-MODE: active;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height=3></td></tr>
	<tr>
		<td colspan=2>
      		<table width="867" cellpadding="1" cellspacing="0" border="0">
				<tr> 
          			<td style="width:503" valign=top>
						<%=HDConstant.COMMENT_START%>
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:430px; border:1 solid #708090" viewastext>
			              <PARAM NAME="DataID"			VALUE="gcds_data">
			              <PARAM NAME="BorderStyle" VALUE="0">
			              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
						  <PARAM NAME="Format"			VALUE=" 
							  <F> Name='����'		        	ID='SEQ' 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center									Value={ToString(CurRow)}</F>
								<C> Name='�ŷ�ó�ڵ�'		  ID='VEND_CD' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left</C>
								<C> Name='�ŷ�ó��'				ID='VEND_NM' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left</C>
								<C> Name='������Ʈ'				ID='PROJECT_CD' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left
								EditStyle=Lookup 	Data='gcds_project_cd:minorcd:minornm' </C>
								<C> Name='����ڸ�'	      	ID='VEND_PRS' 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left</C>
								<C> Name='����'	          		ID='VEND_PST'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left</C>
								<C> Name='��ȭ��ȣ'	      	ID='VEND_TEL' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left </C>
								<C> Name='�޴�����ȣ'			ID='VEND_CPHN' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=left </C>
								<C> Name='�ѽ���ȣ'				ID='VEND_FAX' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left</C>
								">
            			</OBJECT>
            			<%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:120px;height:30px;" bgcolor="#eeeeee">&nbsp;�ŷ�ó�ڵ�</td>
									 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:25px;font-family:����;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();"> 
												<%=HDConstant.COMMENT_START%>
												<OBJECT id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:8px;top:2px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Numeric       value=false>
														<param name=Format        value="#############">
														<param name=PromptChar    value="">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable	      value="false">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
								<img src="../../../Common/img/btn_find.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="ln_Popup();" > 
	
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�ŷ�ó��</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_vend_nm" style="width:160px;height:20px;" disabled></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;������Ʈ����</td>
								<td class="tab21">
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_project_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
								<param name=ComboDataID			value="gcds_project_cd">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn			value=MINORNM>
								<param name=Sort							value=false>
								<param name=ListExprFormat			value="MINORNM^0^160">
								<param name=BindColumn				value=MINORCD>
								</OBJECT>
								<%=HDConstant.COMMENT_END%>
						</td> 

							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;����ڸ�</td>
								<td class="tab21">
								<input type="text" class="txt11" id="txt_vend_prs" style="width:100px;height:20px;IME-MODE: active;">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab21">
								<input type="text" class="txt11" id="txt_vend_pst" style="width:100px;height:20px;IME-MODE: active;">
									
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;��ȭ��ȣ</td>
								<td class="tab21">
									<input type="text" class="txt11" id="txt_vend_tel" style="width:230px;height:20px;IME-MODE: active;"></td> 
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�޴�����ȣ</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_vend_cphn" style="width:230px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�ѽ���ȣ</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_vend_fax" style="width:140px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�̸����ּ�</td>
								<td class="tab21">
									<input type="text" class="txt11" id="txt_vend_email" style="width:140px;height:20px;IME-MODE: active;">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�ּ�1</td>
								<td class="tab21">
									<input type="text" class="txt11" id="txt_vend_add1" style="width:230px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�ּ�2</td>
								<td class="tab21">
									<input type="text" class="txt11" id="txt_vend_add2" style="width:230px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;�ּ�3</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_vend_add3" style="width:230px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:91px;" bgcolor="#eeeeee">&nbsp;���</td>
								<td class="tab21">
								<textarea class="txt11" id="txt_remark" style="font-family:����;font-size:9pt;width:230px;height:84px;IME-MODE: active;"></textarea>
								</td>
							</tr>
						</table>
					</td>
        		</tr>
      		</table>
    	</td>
  	</tr>
</table>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=VEND_CD      	Ctrl=gcem_vend_cd		Param=text</C>
		<C>Col=VEND_NM      	Ctrl=txt_vend_nm	  		Param=Value</C>
		<C>Col=PROJECT_CD   Ctrl=gclx_project_cd	Param=BindColVal</C>
		<C>Col=VEND_PRS     	Ctrl=txt_vend_prs  		Param=Value</C>
		<C>Col=VEND_PST     	Ctrl=txt_vend_pst  		Param=Value</C>
		<C>Col=VEND_TEL     	Ctrl=txt_vend_tel    		Param=Value</C>
		<C>Col=VEND_CPHN    Ctrl=txt_vend_cphn		Param=Value</C>
		<C>Col=VEND_FAX     	Ctrl=txt_vend_fax     		Param=Value</C>
		<C>Col=VEND_EMAIL	Ctrl=txt_vend_email		Param=Value</C>
		<C>Col=VEND_ADD1		Ctrl=txt_vend_add1   	Param=Value</C>
		<C>Col=VEND_ADD2		Ctrl=txt_vend_add2		Param=Value</C>
		<C>Col=VEND_ADD3		Ctrl=txt_vend_add3		Param=Value</C>
		<C>Col=REMARK			 Ctrl=txt_remark			Param=Value</C>
		
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

