<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - ������������
+ ���α׷� ID	: TR00506.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: �̹���
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :  tr00506_s1, tr00506_t1
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

		ln_SrhBef();
		
		txt_car_no.readonly =true ;
}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_SrhBef(){
	
	//����[�˻�]
	gcds_cartypeno_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00512_s1?NOH=Y"; 
	gcds_cartypeno_fr.Reset();

	//����
	gcds_cartypeno.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00512_s1?NOH=Y"; 
	gcds_cartypeno.Reset();

	//�Ҽ� [�˻�]
	gcds_company_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0015"; 
	gcds_company_fr.Reset();

	//�Ҽ�
	gcds_company.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0015"; 
	gcds_company.Reset();

	//�����ڸ�
	gcds_person_no.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00510_s1?v_str1=";  
	gcds_person_no.Reset();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00506_s1?"+"v_str1="+txt_car_no_fr.value + "&v_str2=" 
										+ gclx_cartypeno_fr.BindColVal + "&v_str3=" +gclx_company_fr.BindColVal; 
	gcds_data.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();
	//ln_Enable("t");
	
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (gcds_data.IsUpdated){
				//if(ln_Chk()){
		//prompt('',gcds_data.Text) ;
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					//prompt('',gcds_data.Text) ; 
					gctr_data.Action =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00506_t1?";
					gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
					gctr_data.post();
	
		//	}
		}
}

}
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (gcds_data.sysStatus(gcds_data.rowposition)=="1") gcds_data.undo(gcds_data.rowposition)
	else gcds_data.deleterow(gcds_data.rowposition);
	ln_Save();
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

function CheckLoadClass(){
		var ls_row  = 0 ;
		ls_row = gcds_data.Rowposition ; 
		
		if(lead_class.checked == true){

			gcds_data.NameValue(ls_row,"LEAD_CLASS") ='T' ; 

		}
		else{
			gcds_data.NameValue(ls_row,"LEAD_CLASS") ='F' ; 

		}


}
/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}


/******************************************************************************
	Description : �������ڵ� ã��
******************************************************************************/
function ln_Popup(){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Transfer/html/TR00302_popup03.html";
	strPos = "dialogWidth:537px;dialogHeight:379px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		//gcds_data.NameValue(gcds_data.Rowposition,"MINORCD")  = arrParam[0];

		gcem_person_no.text = arrParam[7];
//alert(arrParam[7]);
		txt_person_no.value = arrParam[0];
//alert(arrParam[0]);
		
		gclx_company.BindColVal = arrParam[1];
//alert(arrParam[2]);

		//txt_vend_tel.focus();
//} else {
//		gcem_artc_cd.text = "";
//		txt_artc_cd.value ="";
	
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- ���� [�˻�] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cartypeno_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- ���� -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cartypeno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- �Ҽ� [�˻�] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_company_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- �Ҽ� -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_company classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- �����ڸ� -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_person_no classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>



<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00506_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00506_t1(I:USER=gcds_data)">
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
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt.innerText = "��ȸ�Ǽ� : �� ( " + row + " ) ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-- ���� [�˻�] -->
<script language="javascript" for="gcds_cartypeno_fr" event="onloadCompleted(row,colid)">
	gcds_cartypeno_fr.InsertRow(1);
	gcds_cartypeno_fr.NameValue(1,"CAR_TYPE")="";
	gcds_cartypeno_fr.NameValue(1,"CAR_NAME")="��ü";
	gclx_cartypeno_fr.index=0;
</script> 

<!-- ���� -->
<script language="javascript" for="gcds_cartypeno" event="onloadCompleted(row,colid)">
	gcds_cartypeno.InsertRow(1);
	gcds_cartypeno.NameValue(1,"CAR_TYPE")="";
	gcds_cartypeno.NameValue(1,"CAR_NAME")="��ü";
	gclx_cartypeno.index=0;
</script> 

<!-- �Ҽ� [�˻�] -->
<script language="javascript" for="gcds_company_fr" event="onloadCompleted(row,colid)">
	gcds_company_fr.InsertRow(1);
	gcds_company_fr.NameValue(1,"MINORCD")="";
	gcds_company_fr.NameValue(1,"MINORNM")="��ü";
	gclx_company_fr.index=0;
</script> 

<!-- �Ҽ� -->
<script language="javascript" for="gcds_company" event="onloadCompleted(row,colid)">
	gcds_company.InsertRow(1);
	gcds_company.NameValue(1,"MINORCD")="";
	gcds_company.NameValue(1,"MINORNM")="��ü";
	gclx_company.index=0;
</script> 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnRowPosChanged(row)">
	if (gcds_data.sysStatus(row)=="0") txt_car_no.readOnly = true;
	else txt_car_no.readOnly = false;
</script> 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
	gcds_data.reset();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>
<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>

	
	var ls_check = null ; 
	ls_check = gcds_data.NameValue(row,"LEAD_CLASS") ; 
	if( ls_check == 'T'){ 
			lead_class.checked =true ; 
	}
	else{
			lead_class.checked =false ;  
	}
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
    <td ><img src="../img/TR00506_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif">
			<img src="../../common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
			<img src="../../common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
	    <img src="../../common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  </tr>
	<tr>  
    <td align="center" colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td class="tab12" style="height:30px;width:100px;" bgcolor="#eeeeee">������ȣ</td>
					<td class="tab23" style="width:150px">
						<input id="txt_car_no_fr" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px;IME-MODE: active" maxlength="16" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 
						
					</td>
					<td width="100" class="tab12" bgcolor="#eeeeee" align="center">����</td>
					<td class="tab23">
					  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_cartypeno_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cartypeno_fr">
								<param name=CBDataColumns		value="car_type, car_name">
								<param name=SearchColumn		value=car_name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="car_name^0^114">
								<param name=BindColumn			value=car_type>
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					<td width="100" class="tab12" bgcolor="#eeeeee" align="center">�Ҽ�</td>
					<td>
					  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_company_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:110px;">
								<param name=ComboDataID			value="gcds_company_fr">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn      value="MINORCD"> 
								<param name=Sort			      value=True>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
		
  <tr> 
   <td colspan="2"> 
		  <table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:0px;width:867px;border:0 solid #708090;">
     <!--  <table width="867" cellpadding="1" cellspacing="0" border="0"> -->
        <tr> 
          <td style="width:503">
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:420px; border:1 solid #708090" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
              <PARAM NAME="TitleHeight"	VALUE="30">
              <PARAM NAME="RowHeight"		VALUE="20">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
						  <PARAM NAME="Format"			VALUE=" 
								<C> Name='No.'					ID={currow} 	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center, Value={currow}</C>
								<C> Name='������ȣ'			ID=CAR_NO 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left</C>
								<C> Name='������'				ID=PERSON_NO  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								EditStyle=Lookup    sort=true    Data='gcds_person_no:person_no:psn_kname'</C> 
								<C> Name='����'					ID=CARTYPENO	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left
								EditStyle=Lookup 				Data='gcds_cartypeno:car_type:car_name'  </C>
								<C> Name='����'					ID=CAR_YEAR	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center</C>
								<C> Name='�Ҽ�'					ID=COMPANY   	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left
								Editstyle='lookup', Data='gcds_company:minorcd:minornm'</C> 

								<C> Name='������;��������'	ID=LEAD_CLASS  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left
								CheckBoxText='LEAD_CLASS'	Pointer=Hand EditStyle=CheckBox
								HeadCheck=false		HeadCheckShow=true align=center HeadVAlign=TOP show=false</C>   

								<C> Name='�μֺ�'				ID=LEADCHARGE HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left
								Value = {Decode(LEADCHARGE,'Y','��','N','��')} show=false</C>
								<C> Name='���'					ID=REMARK   	HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=left show=false</C>
								
							">
            </OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:3px;width:370px;border:0 solid #708090;">
							<tr>
								<td class="tab21" style="height:30px;width:119px;border:1 solid #708090" bgcolor="#eeeeee" align="center"><b>���� ����</b></td>
								<td class="tab22">&nbsp;</td>
							</tr>
						</table>
						<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:3px;width:370px;border:0 solid #708090;">
							<tr>
								<td style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;font-family:����;font-size:9pt;width:119px;height:30px;" bgcolor="#eeeeee">&nbsp;������ȣ</td>
								<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;font-family:����;font-size:9pt;width:119px;height:30px;"><input type="text" class="txt11" id="txt_car_no" style="width:100px;height:20px;IME-MODE: active" maxlength="10"></td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;������</td>
								<td class="tab19">
									 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_person_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:72px;height:20px;position:relative;left:8px;top:2px">		
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
								<img src="../img/btn_find.gif" style="position:relative;left:12px;top:-1px;cursor:hand" onclick="ln_Popup();" > 
								<input type="text" class="txt11" id="txt_person_no" style="left:10px;width:100px;height:20px;" disabled></td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab19">
								  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_cartypeno classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:114px;">
											<param name=ComboDataID			value="gcds_cartypeno">
											<param name=CBDataColumns		value="car_type, car_name">
											<param name=SearchColumn		value=car_name>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="car_name^0^114">
											<param name=BindColumn			value=car_type>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab19">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_car_year classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:40" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;�Ҽ�</td>
								<td class="tab19">
                   <%=HDConstant.COMMENT_START%><OBJECT id=gclx_company classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:110px;">
												<param name=ComboDataID			value="gcds_company">
												<param name=CBDataColumns		value="MINORCD, MINORNM">
												<param name=SearchColumn		value=MINORNM>
												<param name=SortColumn      value="MINORCD"> 
												<param name=Sort			      value=True>
												<param name=ListExprFormat	value="MINORNM^0^100">
												<param name=BindColumn			value=MINORCD>
										</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;������ ��������</td>
								<td class="tab19">
								 <input type="checkbox" class=chk1 id=lead_class name=lead_class  value="C" style="left:4px;position:relative;top:1px;" onclick="CheckLoadClass();">
								 <!-- </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp; FIXED&nbsp;<input type="checkbox" id=fixed name=fixed class="chk1" value="C" style='position:relative;left:-1px;top:2px' tabindex="44" >  -->

									<!-- <%=HDConstant.COMMENT_START%><OBJECT classid=CLSID:60109D65-70C0-425C-B3A4-4CB001513C69 id=gclx_lead_class style="position:relative;left:8px;width:100px;">
										<param name=ComboDataID			value="gcds_lead_class">
										<param name=SearchColumn		value="">
										<param name=BindColumn      value="">
										<param name=Index			      value="0">
										<param name=ListExprFormat	value="^0^120">
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;�μֺ� ��������</td>
								<td class="tab19">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_leadcharge classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
										style="position:relative;left:8px;top:1px;font-size:12px;width:60px;height:200px;" >
											<param name=CBData			   value="Y^��,N^��">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^40">
											<param name=BindColumn			value="Code">
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <%=HDConstant.COMMENT_START%><OBJECT classid=CLSID:60109D65-70C0-425C-B3A4-4CB001513C69 id=gclx_leadcharge style="position:relative;left:8px;width:60px;">
											<param name=CBData			   value="Y^��,N^��">
											<param name=CBDataColumns	 value="code,name">
											<param name=SearchColumn	 value="name">
											<param name=ListExprFormat value="name">								
											<param name=BindColumn		 value="code">
											<param name=Index			     value="0">
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab17" style="height:30px;" bgcolor="#eeeeee">&nbsp;���</td>
								<td class="tab21"><textarea class="txt11" id="txt_remark" style="font-family:����;font-size:9pt;width:230px;height:199px;"></textarea>
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
		<C>Col=CAR_NO			Ctrl=txt_car_no       Param=Value</C>
		<C>Col=PSN_KNAME  Ctrl=txt_person_no    Param=Value</C>
		<C>Col=PERSON_NO  Ctrl=gcem_person_no   Param=Text</C>
		<C>Col=CARTYPENO  Ctrl=gclx_cartypeno   Param=BindColVal</C>
		<C>Col=CAR_YEAR   Ctrl=gcem_car_year    Param=Text</C>
		<C>Col=COMPANY		Ctrl=gclx_company			Param=BindColVal</C>
		<C>Col=LEAD_CLASS	Ctrl=chk1             Param=Value</C>
		<C>Col=LEADCHARGE	Ctrl=gclx_leadcharge  Param=BindColVal</C>
		<C>Col=REMARK			Ctrl=txt_remark				Param=Value</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

