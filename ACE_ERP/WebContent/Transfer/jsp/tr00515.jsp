<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - �����ڵ����
+ ���α׷� ID	: TR00515.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ ��   ��  �� : �̹���
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �� �� �� ��	: tr00515_s1, tr00515_t1
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

			ln_Start();//����ȸ

			window.status="�Ϸ�";

		}
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	ln_Before();
	ln_SetDataHeader();

}

/******************************************************************************
	Description : �� ��ȸ
******************************************************************************/
function ln_Before() {

	//������Ʈ[�˻�]
	gcds_line_part_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_line_part_fr.Reset();

	//������Ʈ[�Է�]
	gcds_line_part.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_line_part.Reset();
	
	//�����ڵ�[�Է�]
	gcds_project.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e1?NOH=Y&gstr1="; 
	gcds_project.Reset();

	//���� �����ڵ�[�Է�]
	gcds_tr_project.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e1?NOH=Y&gstr1="; 
	gcds_tr_project.Reset();


}
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	var data = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00515_s1";
	gcds_data.DataID = data + "?v_str1=" + gclx_line_part_fr.bindColVal 
													+ "&v_str2=" + gcem_project_fr.text
													+ "&v_str3=" + txt_project_nm_fr.value;
	gcds_data.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_data.AddRow();
	gclx_line_part.index = 0 ; 
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (gcds_data.IsUpdated){
	
				if(ln_Chk()){

				if (confirm("�����Ͻðڽ��ϱ�?")){	

					gctr_data.Action =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00515_t1?";
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
		gcds_data.KeyValue = "tr00515_t1(I:USER=gcds_data)";
		gctr_data.Action =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00515_t1?";
		ln_Save();

	}
}

/******************************************************************************
	Description : �Է�üũ 
******************************************************************************/
function ln_Chk(){

	  //�ŷ�ó�ڵ�üũ
		if (fn_trim(gcem_project.text)=="" ){
			alert("�����ڵ带 �Է��Ͻʽÿ�.");
			//gcem_project.focus();
			return false; 
	}
		if (fn_trim(gcem_tr_project.text)=="" ){
			alert("���������ڵ带 �Է��Ͻʽÿ�.");
			gcem_tr_project.focus();
			return false; 
	}
		if (fn_trim(txt_project_nm.value)=="" ){
			alert("�����ڵ���� �Է��Ͻʽÿ�.");
			return false; 
	}
		if (fn_trim(gclx_line_part.BindColVal)=="" ){
			alert("������Ʈ�� �����Ͻʽÿ�.");
			gclx_line_part.focus();
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

	strURL = "/Transfer/jsp/tr00515_popup.jsp";
	strPos = "dialogWidth:395px;dialogHeight:419px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");

		gcem_project.text = arrParam[0];
		gcem_tr_project.text = arrParam[0];
		txt_project_nm.value = arrParam[1];

	
	}
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
******************************************************************************/
function ln_SetDataHeader(){

		if (gcds_data.countrow<1){
			var s_temp = "LINE_PART:STRING,PROJECT:STRING,TR_PROJECT:STRING,PROJECT_NM:STRING,DETAIL_NM:STRING,"
								 + "CONT_NM:STRING,CONT_DT:STRING,CONT_OWN:STRING,CONT_AMT:DECIMAL,CONT_PED:STRING,"
								 + "CONT_DESC:STRING,STAY_DIV:STRING,FOOD_DIV:STRING,TRANS_DIV:STRING,USE_STS:STRING,REMARK:STRING";
								gcds_data.SetDataHeader(s_temp);
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
<OBJECT id=gcds_line_part_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- ������Ʈ -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_line_part classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- �����ڵ� -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_project classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- ���� �����ڵ� -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_tr_project classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00515_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00515_t1(I:USER=gcds_data)">
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
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-- 
<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>
	if (gcds_data.sysStatus(row)=="1") txt_vend_nm_fr.disabled = false;
	else txt_vend_nm_fr.disabled = true;
</script> -->

<!-- ������Ʈ [�˻�] -->
<script language="javascript" for="gcds_line_part_fr" event="onloadCompleted(row,colid)">
	gcds_line_part_fr.InsertRow(1);
	gcds_line_part_fr.NameValue(1,"MINORCD")="";
	gcds_line_part_fr.NameValue(1,"MINORNM")="��ü";
	gclx_line_part_fr.index=0;
</script>

<!-- ������Ʈ -->
<script language="javascript" for="gcds_line_part" event="onloadCompleted(row,colid)">
	//gcds_line_part.InsertRow(1);
	//gcds_line_part.NameValue(1,"MINORCD")="";
	//gcds_line_part.NameValue(1,"MINORNM")="��ü";
	//gclx_line_part.index=0;
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
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  	<tr> 
    	<td width="876" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif">
			<img src="<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
	    	<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  	</tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      <table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">������Ʈ</td>
					<td class="tab21" style="width:200px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
								<param name=ComboDataID			value="gcds_line_part_fr">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value=MINORCD>
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 
						<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">�����ڵ�</td>
								 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();"> 
								<%=HDConstant.COMMENT_START%><OBJECT id=gcem_project_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">�����ڵ��</td>
					<td class="tab21"><input type="text" class="txt11" id="txt_project_nm_fr" style="width:100px;height:18px;IME-MODE: active"
					onkeydown="if(event.keyCode==13) ln_Query();"></td>
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
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:420px; border:1 solid #708090" viewastext>
			              <PARAM NAME="DataID"			VALUE="gcds_data">
			              <PARAM NAME="BorderStyle" VALUE="0">
			              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
							<Param Name=SortView			VALUE="Left">
						  	<PARAM NAME="Format"			VALUE=" 
							  <F> Name='����'		        ID='SEQ' 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center Value={ToString(CurRow)}</F>
								<C> Name='������Ʈ'				ID='LINE_PART' 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left EditStyle=Lookup 	Data='gcds_line_part:minorcd:minornm' </C>
								<C> Name='�����ڵ�'		    ID='PROJECT' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center sort=true</C>
								<C> Name='���������ڵ�'		ID='TR_PROJECT' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center </C>
								<C> Name='�����ڵ��'	    ID='PROJECT_NM' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left sort=true</C>
								<C> Name='���ο����ڵ��' ID='DETAIL_NM'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=240	align=left</C>
								">
            			</OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:120px;height:25px;" bgcolor="#eeeeee">&nbsp;�����ڵ�</td>
									 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:25px;font-family:����;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();" colspan="3"> 
												<%=HDConstant.COMMENT_START%><OBJECT id=gcem_project classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:8px;top:2px">	
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Numeric       value=false>
														<param name=Format        value="##########">
														<param name=PromptChar    value="">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable	      value="false">
											</OBJECT><%=HDConstant.COMMENT_END%>
								<img src="<%=dirPath%>/Common/img/btn_find.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="ln_Popup();" > 

								</td>
							</tr>
							<tr>
							<td class="tab21" style="width:120px;height:25px;" bgcolor="#eeeeee">&nbsp;�����ڵ�</td>
									 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:25px;font-family:����;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();" colspan="3"> 
												<%=HDConstant.COMMENT_START%><OBJECT id=gcem_tr_project classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:8px;top:2px">			<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Numeric       value=false>
														<param name=Format        value="##########">
														<param name=PromptChar    value="">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
											</OBJECT><%=HDConstant.COMMENT_END%>
										</td>
									</tr>
								<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�����ڵ��</td>
								<td class="tab21" colspan="3"><input type="text" class="txt11" id="txt_project_nm" style="width:230px;height:20px;" disabled></td>
								</tr>
								<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;���ο����ڵ��</td>
								<td class="tab21" colspan="3"><input type="text" class="txt11" id="txt_detail_nm" style="width:230px;height:20px;IME-MODE: active" ></td>
								</tr>
								<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;������Ʈ����</td>
								<td class="tab21" colspan="3">
								<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
									<param name=ComboDataID			value="gcds_line_part">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^160">
									<param name=BindColumn			value=MINORCD>
								</OBJECT><%=HDConstant.COMMENT_END%>
							</td> 
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab21" colspan="3">
								<input type="text" class="txt11" id="txt_cont_nm" style="width:230px;height:20px;IME-MODE: active">
									
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�����</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_cont_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:3px;height:20;width:70" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  			</OBJECT>
                  			<%=HDConstant.COMMENT_END%>&nbsp;<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="position:relative; left:4px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_cont_dt', 'Text');"> 
							</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�������</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_cont_own" style="width:230px;height:20px;IME-MODE: active"></td> 
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����Ѿ�</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_cont_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
				                     <param name=Alignment					value=2>
				                     <param name=MaxDecimalPlace		value=2>
				                     <param name=Enable							value=true>
										 <param name=MaxLength          value=13>
		             				</OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;���Ⱓ</td>
								<td class="tab21" colspan="3"><input type="text" class="txt11" id="txt_cont_ped" style="width:150px;height:20px;IME-MODE: active"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�ֿ䳻��</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_cont_desc" style="width:230px;height:20px;IME-MODE: active">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;���ں�δ���</td>
								<td class="tab21" colspan="3"  >
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_stay_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
										style="position:relative;left:8px;top:1px;font-size:12px;width:80px;height:200px;" >
											<param name=CBData					value="1^��,2^��,0^�ش����">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^60">
											<param name=BindColumn			value="Code">
									</OBJECT><%=HDConstant.COMMENT_END%>
								
								<!-- <input type="text" class="txt11" id="txt_stay_div" style="width:80px;height:20px;"> --></td>
							 </tr>
							<tr> 
								<td class="tab21" style="height:25px;"  bgcolor="#eeeeee">&nbsp;�ĺ�δ���</td>
								<td class="tab21" colspan="3"><!-- <input type="text" class="txt11" id="txt_mobile1" style="width:30px;height:20px;" maxlength=3>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_txt_mobile2" style="width:30px;height:20px;" maxlength=4>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_txt_mobile3" style="width:30px;height:20px;" maxlength=4></td> -->
								<%=HDConstant.COMMENT_START%><OBJECT id=gclx_food_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
									style="position:relative;left:8px;top:1px;font-size:12px;width:80px;height:200px;" >
										<param name=CBData					value="1^��,2^��,0^�ش����">
										<param name=CBDataColumns		value="Code,Parm">
										<param name=SearchColumn		value="Parm">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="Parm^0^60">
										<param name=BindColumn			value="Code">
								</OBJECT><%=HDConstant.COMMENT_END%>
							</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;��ݺ�δ���</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_trans_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
											style="position:relative;left:8px;top:1px;font-size:12px;width:80px;height:200px;" >
												<param name=CBData					value="1^��,2^��,0^�ش����">
												<param name=CBDataColumns		value="Code,Parm">
												<param name=SearchColumn		value="Parm">
												<param name=Sort						value="false">
												<param name=ListExprFormat	value="Parm^0^60">
												<param name=BindColumn			value="Code">
								</OBJECT><%=HDConstant.COMMENT_END%>
								<!-- <input type="text" class="txt11" id="txt_vend_add3" style="width:100px;height:20px;"> -->
								</td>
							</tr>
							<tr> 
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�������</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_use_sts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
											style="position:relative;left:8px;top:1px;font-size:12px;width:60px;height:200px;" >
												<param name=CBData					value="Y^��,N^�ƴϿ�">
												<param name=CBDataColumns		value="Code,Parm">
												<param name=SearchColumn		value="Parm">
												<param name=Sort						value="false">
												<param name=ListExprFormat	value="Parm^0^60">
												<param name=BindColumn			value="Code">
								</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_sort classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:60">
											<param name=Enable				value=true>
											<param name=MaxLength     value=4>
											<param name=Numeric       value=false>
											<param name=Format        value="####">
											<param name=PromptChar    value="">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:41px;" bgcolor="#eeeeee">&nbsp;���</td>
								<td class="tab21"><textarea class="txt11" id="txt_remark" style="font-family:����;font-size:9pt;width:230px;height:30px;IME-MODE: active;overflow:auto"></textarea>
								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=LINE_PART    Ctrl=gclx_line_part	  Param=BindColVal</C>
		<C>Col=PROJECT      Ctrl=gcem_project	  	Param=Text</C>
		<C>Col=TR_PROJECT   Ctrl=gcem_tr_project  Param=Text</C>
		<C>Col=PROJECT_NM   Ctrl=txt_project_nm		Param=Value</C>
		<C>Col=DETAIL_NM    Ctrl=txt_detail_nm 		Param=Value</C>

		<C>Col=CONT_NM      Ctrl=txt_cont_nm      Param=Value</C>
		<C>Col=CONT_DT      Ctrl=gcem_cont_dt  		Param=Text</C>
		<C>Col=CONT_OWN     Ctrl=txt_cont_own     Param=Value</C>
		<C>Col=CONT_AMT 		Ctrl=gcem_cont_amt		Param=Text</C>
		<C>Col=CONT_PED 		Ctrl=txt_cont_ped   	Param=Value</C>

		<C>Col=CONT_DESC		Ctrl=txt_cont_desc		Param=Value</C>
		<C>Col=STAY_DIV 		Ctrl=gclx_stay_div 		Param=BindColVal</C>
		<C>Col=FOOD_DIV 		Ctrl=gclx_food_div 		Param=BindColVal</C>
		<C>Col=TRANS_DIV 		Ctrl=gclx_trans_div		Param=BindColVal</C>
		<C>Col=USE_STS  		Ctrl=gclx_use_sts  		Param=BindColVal</C>
		<C>Col=REMARK			  Ctrl=txt_remark			  Param=Value</C>
		<C>Col=DSP_SORT		  Ctrl=gcem_sort			  Param=Text</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="<%=dirPath%>/Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>

<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

