<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - �������ڽ�û����
+ ���α׷� ID	: TR00604.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ ��   ��  �� : �̹���
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �������� :
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
		
		var gs_ordno = null ; 
		var ls_start = "true" ; 
		
		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_date1 = gcurdate.substring(2,4) + gcurdate.substring(5,7);
		var gs_date2 = gcurdate.substring(0,4);

		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			ln_Start();
			
			window.status="�Ϸ�";

		}


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start() {

	gcem_appl_dt.text='20060301';
	gcem_etd_dt.text=gs_date;

  //������Ʈ����[�˻�]
	gcds_line_part_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?NOH=Y&v_str1=0002"; 
	gcds_line_part_fr.Reset();

	
	//������Ʈ����
	gcds_line_part.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_line_part.Reset();

	gclx_item_div_fr.index = 0 ; 

}
 

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  var str1 = gclx_line_part_fr.BindColVal;           //������Ʈ
	var str2 = gclx_item_div_fr.BindColVal;            //��ǰ�з�
	var str3 = txt_item_nm_fr.value;                   //ǰ��
	

 
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00604_s1?NOH=Y"
									 + "&v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
									
	gcds_data.Reset();
	//prompt('',gcds_data.DataID) ; 
	gclx_item_div_fr.index = 0 ; 

	//ln_Enable(t);
	ln_Format(1);
	ls_start =  false;  
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	gcds_data.AddRow();
	//ln_Enable(t);
	gclx_line_part.index = 0 ;
	gclx_item_div.index = 0 ; 
	gcem_appl_dt.text=gs_date;
	gcem_etd_dt.text=gs_date;

	ln_Format(1);
	ls_start ='true' ; 
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
//alert(ls_start) ; 
	if (gcds_data.IsUpdated){
	//alert(ls_start + "ll" ) ;
	if(ln_Chk()){
		if(ls_start == 'true' ){ 
	//alert(ls_start) ; 	
			SEQ() ;  
			//alert(gs_ordno) ; 
		
		}
			//if(ln_Chk()){
		//prompt('',gcds_data.Text) ;
				if (confirm("�����Ͻðڽ��ϱ�?")){	
					gctr_data.Action = g_servlet+"/Transfer.tr00604_t1?";
					gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid+",gstr3=" + gs_ordno;		
					gctr_data.post();
					ls_start = false ; 
					gcds_data.reset();
					//ln_Query();
	
			}
		}
}
}

function SEQ(){

	var ls_yymm =  gs_date1 ; 
	//	var ls_yymm =  gcem_etd_dt.Text.substring(2,6) ; 
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetSeqNo?NOH=Y&gstr1=0005&gstr2=" + ls_yymm;  // �ֹ���ȣ Load
		gcds_data1.Reset();   
		gs_ordno = ls_yymm + 'O'+  gcds_data1.NameValue(1,"SEQ_NO")  ; 
		//alert("�ֹ���ȣ : " + gs_ordno) ;
		txt_appl_no.value=gs_ordno;

}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (gcds_data.sysStatus(gcds_data.rowposition)=="1") gcds_data.undo(gcds_data.rowposition)
	else gcds_data.deleterow(gcds_data.rowposition);
	ln_Save();
}

/*function ln_Delete(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gcds_data.KeyValue = "tr00604_t2(I:USER=gcds_data)";
		gcds_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00604_t2";
		//gcds_data.post();
	
	}
}
*/
/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}


/******************************************************************************
	Description : ���(����)
******************************************************************************/
function ln_Print(){
	if (gcds_data.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
	} else {
			
		//gs_la=false;

		gcds_print.ClearData();
			
		var ls_temp = "CUDATE:STRING,APPL_NO:STRING,ITEM_SPC:STRING,ITEM_UNIT:STRING,AA:STRING,I_DIV:STRING,L_PART:STRING,"
				        + "ITEM_NM:STRING,ITEM_DIV:STRING,IMAGE:STRING,MANG_NM:STRING,REMARK:STRING,ITEM_QTY:DECIMAL,A_DT:STRING";
		gcds_print.SetDataHeader(ls_temp);
		
		
		for (i=1;i<=gcds_data.countrow;i++) {
			gcds_print.Addrow();
			
			gcds_print.namevalue(i,"CUDATE")=gs_date2;
			gcds_print.namevalue(i,"I_DIV")=gcds_data.namevalue(i,"I_DIV");
			gcds_print.namevalue(i,"ITEM_SPC")=gcds_data.namevalue(i,"ITEM_SPC");
			gcds_print.namevalue(i,"ITEM_UNIT")=gcds_data.namevalue(i,"ITEM_UNIT");
			gcds_print.namevalue(i,"ITEM_QTY")=gcds_data.namevalue(i,"ITEM_QTY");
			gcds_print.namevalue(i,"MANG_NM")=gcds_data.namevalue(i,"MANG_NM");
			gcds_print.namevalue(i,"REMARK")=gcds_data.namevalue(i,"REMARK");
			gcds_print.namevalue(i,"AA")=gcds_data.namevalue(i,"AA");
			gcds_print.namevalue(i,"L_PART")=gcds_data.namevalue(i,"L_PART");
			gcds_print.namevalue(i,"A_DT")=gcds_data.namevalue(i,"A_DT");
		
		}
		gcrp_print.preview();	

		//gs_la=true;
	}
}

/******************************************************************************
	Description : ���(Ȯ�μ�)
******************************************************************************/
function ln_Print01(){
		
	var	row = gcds_data.rowposition;
	
	if (gcds_data.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
	} else {
	
		
		//gs_la=false;

		gcds_print01.ClearData();
			
		var ls_temp = "CUDATE:STRING,APPL_NO:STRING,ITEM_SPC:STRING,ITEM_UNIT:STRING,AA:STRING,I_DIV:STRING,L_PART:STRING,"
				        + "ITEM_NM:STRING,ITEM_DIV:STRING,IMAGE:STRING,MANG_NM:STRING,REMARK:STRING,ITEM_QTY:DECIMAL";
		gcds_print01.SetDataHeader(ls_temp);
		
		gcds_print.addrow();

		
		for (i=1;i<=gcds_data.countrow;i++) {
			gcds_print01.Addrow();
			
			gcds_print01.namevalue(i,"CUDATE")=gs_date2;
			gcds_print01.namevalue(i,"I_DIV")=gcds_data.namevalue(row,"I_DIV");
			gcds_print01.namevalue(i,"ITEM_SPC")=gcds_data.namevalue(row,"ITEM_SPC");
			gcds_print01.namevalue(i,"ITEM_UNIT")=gcds_data.namevalue(row,"ITEM_UNIT");
			gcds_print01.namevalue(i,"ITEM_QTY")=gcds_data.namevalue(row,"ITEM_QTY");
			gcds_print01.namevalue(i,"MANG_NM")=gcds_data.namevalue(row,"MANG_NM");
			gcds_print01.namevalue(i,"REMARK")=gcds_data.namevalue(row,"REMARK");
			gcds_print01.namevalue(i,"AA")=gcds_data.namevalue(row,"AA");


			gcds_print01.namevalue(i,"APPL_NO")=gcds_data.namevalue(row,"APPL_NO");
			gcds_print01.namevalue(i,"ITEM_NM")=gcds_data.namevalue(row,"ITEM_NM");
			gcds_print01.namevalue(i,"ITEM_DIV")=gcds_data.namevalue(row,"ITEM_DIV");
			
			gcds_print01.namevalue(i,"IMAGE")=gcds_data.namevalue(i,"IMAGE");
			gcds_print01.namevalue(i,"P_CMPY")=gcds_data.namevalue(i,"P_CMPY");
			gcds_print01.namevalue(i,"L_PART")=gcds_data.namevalue(row,"L_PART");
			
		}

		gcrp_print01.preview();	
		
	}
}
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : �Է�üũ 
******************************************************************************/
function ln_Chk(){

		//�ʼ��׸�üũ
		if (fn_trim(gclx_line_part.BindColVal)=="" ){
			alert("������Ʈ������ �����Ͻʽÿ�.");
			gclx_line_part.focus();
			return false; 
		}
		if (fn_trim(gcem_appl_dt.Text)=="" ){
			alert("��û���ڸ� �Է��Ͻʽÿ�.");
			gcem_appl_dt.focus();
			return false; 
		}

	return true; 
}

/******************************************************************************
	Description : ������ �������
******************************************************************************/
function ln_Format(e){
	if (gcds_data.sysStatus(e)=="1") {	//���

		//txt_chargecode.disabled	= false;
		//gclx_pack_type.index = 1;

	} else {
		
		//txt_chargecode.disabled	= true;
	}
}

</script>

<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>
	ls_start = 'false' ;
	gs_ordno = gcds_data.NameValue(gcds_data.Rowposition,"APPL_NO") ; 
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- ������Ʈ����[�˻�] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_line_part_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- ������Ʈ����  -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_line_part classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_print01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00604_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00604_t1(I:USER=gcds_data)">
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
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	ft_cnt.innerText = "��ȸ�Ǽ� : �� ( " + row + " ) ��";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="onRowPoschanged(row)">
	if (gcds_data.sysStatus(row)=="1") txt_appl_no.readOnly = true;
	//else txt_chargecode.readOnly = true;
</script>

 <script language=JavaScript for=gcem_unit_price event=onKeyUp(kcode,scode)>
		//alert("Key : " + kcode);
		var ls_amt = gcem_item_qty.Text ;        //����
		var ls_ama = gcem_unit_price.Text ;      //�ܰ�

		gcem_item_price.Text = ls_amt*1 * ls_ama*1 ;
		
</script> 
	
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- ������Ʈ����[�˻�] -->
<script language="javascript" for="gcds_line_part_fr" event="onloadCompleted(row,colid)">
	gcds_line_part_fr.InsertRow(1);
	gcds_line_part_fr.NameValue(1,"MINORCD")="";
	gcds_line_part_fr.NameValue(1,"MINORNM")="��ü";
	gclx_line_part_fr.index=0;
</script>

<!-- ������Ʈ���� -->
<script language="javascript" for="gcds_line_part" event="onloadCompleted(row,colid)">
	/*gcds_pack_type.InsertRow(1);
	gcds_pack_type.NameValue(1,"MINORCD")="";
	gcds_pack_type.NameValue(1,"MINORNM")="";
	gclx_pack_type.index=0;*/
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	//ln_Query();
	// prompt('',gcds_data.DataID) ; 
	// gcds_data.reset();

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
    <td ><img src="../img/TR00604_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif">
			<img src="../img/btn/btn_print1.gif"		 style="position:relative;top:2px;cursor:hand" onClick="ln_Print01()">
			<img src="../img/btn/btn_print2.gif"		 style="position:relative;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
			<img src="../../common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
	    <img src="../../common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      <table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">������Ʈ����</td>
					<td class="tab21" style="width:200px;">&nbsp;
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:160px;">
								<param name=ComboDataID			value="gcds_line_part_fr">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value=MINORCD>
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 

	
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">��ǰ�з�</td>
					 <td class="tab21"> 
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_item_div_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
											<param name=CBData			   value="''^��ü,C^��ǻ��,E^�Ϲݹ���">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^80">
											<param name=BindColumn			value="Code">
									</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">ǰ��</td>
					 <td class="tab21"> 
						 <input type="text" class="txt11" id="txt_item_nm_fr" style="width:100px;height:18px;IME-MODE: active;"
					onkeydown="if(event.keyCode==13) ln_Query();">
					</td>
				</tr>
			</table>
		</td>
	</tr>
  <tr> 
    <td colspan="2"> 

      <table width="867" style="position:relative;left:0px;width:866px;top:3px;border:0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:420px; border:1 solid #708090" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
						  <PARAM NAME="Format"			VALUE=" 
								<C> Name='��û��ȣ'			  ID='APPL_NO' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center</C>
								<C> Name='��û��ǰ����'	  ID='ITEM_SEQ'  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right,
								</C> 
								<C> Name='PROJECT'		    ID='LINE_PART'	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left, 
								Editstyle='lookup', Data='gcds_line_part:minorcd:minornm'</C>
								<C> Name='��ǰ�з�'	      ID='ITEM_DIV' 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left, 
								Value = {Decode(ITEM_DIV,'C','��ǻ��','E','�Ϲݹ���')}</C>
								<C> Name='ǰ��'			      ID='ITEM_NM'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C> 
								<C> Name='�𵨸�'	        ID='MODEL_NM'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C> 
								<C> Name='�԰�'	          ID='ITEM_SPC'		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C>
								<C> Name='�Ϸù�ȣ'	      ID='SERIAL_NO'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left
								</C>
							">
            </OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:90px;height:25px;" bgcolor="#eeeeee">&nbsp;��û��ȣ</td>
								<td class="tab21" colspan="3"><input type="text" class="txt11" id="txt_appl_no" style="width:100px;height:20px;" readOnly></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;��û��ǰ����</td>
								<td class="tab21" colspan="3" > 
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_item_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=0>
                     <param name=Enable							value=true>
										 <param name=MaxLength          value=4>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;PROJECT ����</td>
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
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;��ǰ�з�</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_item_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
											<param name=CBData			   value="C^��ǻ��,E^�Ϲݹ���">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^80">
											<param name=BindColumn			value="Code">
									</OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;ǰ��</td>
								<td class="tab21" colspan="3">
								<input type="text" class="txt11" id="txt_item_nm" style="width:260px;height:20px;IME-MODE: active;" maxlength="50">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
										
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
								</tr>
						 	<!-- </tr>
							<tr>  -->
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;HS CODE</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_hs_code" style="width:100px;height:20px;IME-MODE: active;" maxlength="10"
									onBlur="bytelength(this,this.value,10);">
								<!-- 	<%=HDConstant.COMMENT_START%><OBJECT id=gcem_itemrqst_price2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�𵨸�</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_model_nm" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�԰�</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_item_spc" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�Ϸù�ȣ</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_serial_no" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;CPU</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_cpu_spc" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
									onBlur="bytelength(this,this.value,50);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�ϵ�</td>
								<td class="tab21" >
									<input type="text" class="txt11" id="txt_hard_spc" style="width:90px;height:20px;IME-MODE: active;" maxlength="20"
									onBlur="bytelength(this,this.value,20);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							<!-- </tr>
							<tr> -->
								<td class="tab21" style="width:70px;height:25px;" bgcolor="#eeeeee">&nbsp;��</td>
								<td class="tab21" >
									<input type="text" class="txt11" id="txt_ram_spc" style="width:90px;height:20px;IME-MODE: active;" maxlength="20"
									onBlur="bytelength(this,this.value,20);">
								<!-- 	<%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab21" >
									<input type="text" class="txt11" id="txt_item_unit" style="width:90px;height:20px;IME-MODE: active;" maxlength="20"
									onBlur="bytelength(this,this.value,20);">
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
						<!-- 	</tr>
							<tr> -->
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_item_qty classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
										 <param name=MaxLength          value=13>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�ܰ�</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_unit_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
 									   <param name=MaxLength          value=13>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							<!-- </tr>
							<tr> -->
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;�ݾ�</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_item_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=2>
                     <param name=Enable							value=true>
										 <param name=MaxLength          value=13>
										
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;������</td>
								<td class="tab21" colspan="3">
									
								<input type="text" class="txt11" id="txt_mang_nm" style="width:260px;height:20px;IME-MODE: active;" maxlength="50"
								onBlur="bytelength(this,this.value,50);">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;������</td>
								<td class="tab21" colspan="3">
									<input type="text" class="txt11" id="txt_use_pps" style="width:260px;height:20px;IME-MODE: active;" maxlength="100"
									onBlur="bytelength(this,this.value,100);">
								
								</td>
							</tr>

							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;��û����</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_appl_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:3px;height:20;width:70" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../img/btn_calendar.gif" style="position:relative; left:4px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_appl_dt', 'Text');"> 
									
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;��������</td>
								<td class="tab21">
									
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_etd_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:6px;top:3px;height:20;width:70">
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../img/btn_calendar.gif" style="position:relative; left:6px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_etd_dt', 'Text');">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;���</td>
								<td class="tab21" colspan="3">
								<textarea id="txt_remark" class="txtbox"  style= "width:260px; height:23px; overflow:auto;position:relative;left:8px;IME-MODE: active" maxlength="100" onBlur="bytelength(this,this.value,100);"></textarea>
									
								</td>
							</tr>
							<tr>
					<td height="10px" style="border:1 solid 
					#708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;" >&nbsp;</td><!--�ؿ� ���ĭ-->
					 <td height="10px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan="3">&nbsp;</td>
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
		<C>Col=APPL_NO      Ctrl=txt_appl_no       Param=value</C>
		<C>Col=ITEM_SEQ     Ctrl=gcem_item_seq     Param=Text</C>
		<C>Col=LINE_PART    Ctrl=gclx_line_part    Param=BindColVal</C>
		<C>Col=ITEM_DIV     Ctrl=gclx_item_div     Param=BindColVal</C>
		<C>Col=ITEM_NM      Ctrl=txt_item_nm       Param=Value</C>

		<C>Col=HS_CODE      Ctrl=txt_hs_code       Param=Value</C>
		<C>Col=MODEL_NM     Ctrl=txt_model_nm      Param=Value</C>
		<C>Col=ITEM_SPC     Ctrl=txt_item_spc      Param=Value</C>
		<C>Col=SERIAL_NO    Ctrl=txt_serial_no     Param=Value</C>
		<C>Col=CPU_SPC      Ctrl=txt_cpu_spc       Param=Value</C>

		<C>Col=HARD_SPC     Ctrl=txt_hard_spc      Param=Value</C>
		<C>Col=RAM_SPC      Ctrl=txt_ram_spc       Param=Value</C>
		<C>Col=ITEM_UNIT    Ctrl=txt_item_unit     Param=Value</C>
		<C>Col=ITEM_QTY     Ctrl=gcem_item_qty     Param=Text</C>
		<C>Col=UNIT_PRICE   Ctrl=gcem_unit_price   Param=Text</C>

		<C>Col=ITEM_PRICE   Ctrl=gcem_item_price   Param=Text</C>
		<C>Col=MANG_NM      Ctrl=txt_mang_nm       Param=Value</C>
		<C>Col=USE_PPS      Ctrl=txt_use_pps       Param=Value</C>
		<C>Col=APPL_DT      Ctrl=gcem_appl_dt      Param=Text</C>
		<C>Col=ETD_DT       Ctrl=gcem_etd_dt       Param=Text</C>

		<C>Col=REMARK       Ctrl=txt_remark        Param=Value</C>
	
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   ���
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print">
	<param NAME="DetailDataID"				VALUE="gcds_print">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=2727 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=741 ,top=2612 ,right=1218 ,bottom=2712</I>
	<I>id='../../common/img/new_attamp.jpg' ,left=1134 ,top=2207 ,right=1864 ,bottom=2503</I>
	<T>id='110-793 / ����Ư���� ���α� �赿 140-2 ������� Tel (02)3669-3881, Fax (02)3669-3880' ,left=24 ,top=473 ,right=1959 ,bottom=539 ,face='HY�߸���' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ��ֽ�ȸ��' ,left=24 ,top=299 ,right=1959 ,bottom=418 ,face='HY�߸���' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=560 ,right=1959 ,bottom=560 </L>
	<L> left=29 ,top=547 ,right=1959 ,bottom=547 </L>
	<T>id='��    �� :' ,left=45 ,top=574 ,right=319 ,bottom=640 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CERTINO', left=680, top=574, right=875, bottom=640, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='ȣ' ,left=883 ,top=574 ,right=973 ,bottom=640 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ϻ�' ,left=335 ,top=653 ,right=609 ,bottom=719 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=45 ,top=653 ,right=319 ,bottom=719 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ܻ�������� ����������' ,left=335 ,top=732 ,right=1110 ,bottom=798 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=45 ,top=732 ,right=319 ,bottom=798 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=45 ,top=814 ,right=319 ,bottom=880 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����� ��ǰ ���� ���� ��û�� ��' ,left=335 ,top=817 ,right=1110 ,bottom=883 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=917 ,right=1959 ,bottom=917 </L>
	<T>id='1. �ͺ��� ������ ������ ����մϴ�.' ,left=269 ,top=962 ,right=1255 ,bottom=1028 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� :' ,left=113 ,top=1544 ,right=282 ,bottom=1610 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ�μ� 1��.' ,left=295 ,top=1544 ,right=570 ,bottom=1610 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� Ȯ�μ� 1��. ��.' ,left=295 ,top=1628 ,right=1071 ,bottom=1694 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ȭ����.���ô븦.�����ϴ±��' ,left=24 ,top=227 ,right=1959 ,bottom=293 ,face='HY�߸���' ,size=15 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=335, top=574, right=556, bottom=640, align='left' ,mask='�� XXXX - XXXX ȣ', face='HY�߸���', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2. ��簡 ���� ��û�� ' ,left=269 ,top=1057 ,right=833 ,bottom=1123 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǻ�� 1���� ������ν�û�� �����Ͽ� ���Ӱ� ���� Ȯ�μ��� ÷���Ͽ��� ����' ,left=111 ,top=1145 ,right=1914 ,bottom=1211 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��ǰ�� ���޵� �� �ֵ��� �����Ͽ� �ֽñ� �ٶ��ϴ�.' ,left=111 ,top=1232 ,right=1914 ,bottom=1298 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='-' ,left=585 ,top=574 ,right=675 ,bottom=640 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='A_DT', left=1545, top=574, right=1846, bottom=640, face='HY�߸���', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='L_PART', left=838, top=1057, right=1097, bottom=1123, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1�ܰ� ��������� �����Ͽ� ����' ,left=1107 ,top=1057 ,right=1935 ,bottom=1123 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print01  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print">
	<param NAME="DetailDataID"				VALUE="gcds_print01">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=2218 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=132 ,top=1213 ,right=1804 ,bottom=1417 ,border=true</X>
	<T>id='�����ϰ��� �մϴ�. ' ,left=1176 ,top=777 ,right=1767 ,bottom=843 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1�ܰ� ��������� �����Ͽ� ���� ' ,left=749 ,top=698 ,right=1577 ,bottom=764 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='L_PART', left=446, top=698, right=730, bottom=764, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AA', left=965, top=777, right=1173, bottom=843, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�븦 �Ʒ� ��ϰ� ���� ' ,left=425 ,top=777 ,right=962 ,bottom=843 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �뵵 ���� Ȯ��' ,left=335 ,top=605 ,right=1110 ,bottom=671 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     �� :' ,left=45 ,top=603 ,right=319 ,bottom=669 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ITEM_QTY', left=272, top=777, right=414, bottom=843, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='I_DIV', left=1582, top=698, right=1777, bottom=764, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���� ' ,left=269 ,top=698 ,right=438 ,bottom=764 ,align='left' ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ �� ��' ,left=24 ,top=140 ,right=1959 ,bottom=259 ,face='HY�߸���' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=809 ,top=267 ,right=1163 ,bottom=267 </L>
	<C>id='I_DIV', left=140, top=1332, right=335, bottom=1406</C>
	<C>id='ITEM_SPC', left=348, top=1332, right=918, bottom=1406</C>
	<C>id='ITEM_UNIT', left=931, top=1332, right=1073, bottom=1406</C>
	<C>id='ITEM_QTY', left=1092, top=1332, right=1234, bottom=1406</C>
	<C>id='MANG_NM', left=1247, top=1332, right=1429, bottom=1406</C>
	<C>id='REMARK', left=1448, top=1332, right=1790, bottom=1406</C>
	<L> left=1081 ,top=1213 ,right=1081 ,bottom=1417 </L>
	<L> left=923 ,top=1213 ,right=923 ,bottom=1417 </L>
	<L> left=1437 ,top=1213 ,right=1437 ,bottom=1417 </L>
	<L> left=1239 ,top=1213 ,right=1239 ,bottom=1417 </L>
	<L> left=340 ,top=1213 ,right=340 ,bottom=1417 </L>
	<L> left=132 ,top=1322 ,right=1804 ,bottom=1322 </L>
	<T>id='�� ��' ,left=348 ,top=1221 ,right=918 ,bottom=1314 ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=931 ,top=1221 ,right=1073 ,bottom=1314 ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1092 ,top=1221 ,right=1234 ,bottom=1314 ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1247 ,top=1221 ,right=1429 ,bottom=1314 ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=1448 ,top=1221 ,right=1790 ,bottom=1314 ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ǰ ��' ,left=140 ,top=1221 ,right=335 ,bottom=1314 ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='- ��                ��  -' ,left=24 ,top=1078 ,right=1959 ,bottom=1145 ,face='HY�߸���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='L_PART', left=599, top=1618, right=1015, bottom=1684, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1�ܰ� ���ܺ��� ������ ��������' ,left=1023 ,top=1618 ,right=1785 ,bottom=1684 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' ���������� �˷��帳�ϴ�.' ,left=396 ,top=2070 ,right=1782 ,bottom=2136 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MANG_NM', left=113, top=2070, right=388, bottom=2136, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ƿ﷯ ����Ǵ� ����鿡 ���� ������ �������� �ٹ����� ����ƻ�' ,left=113 ,top=1990 ,right=1785 ,bottom=2056 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ÿ �뵵�� ������� ���� ���� Ȯ���մϴ�.' ,left=113 ,top=1779 ,right=1785 ,bottom=1845 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ȿ���� ���ϱ� ���Ͽ� ���ԵǴ� ������ ������ �뵵 ����' ,left=113 ,top=1700 ,right=1785 ,bottom=1766 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='I_DIV', left=182, top=1618, right=377, bottom=1684, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITEM_QTY', left=382, top=1618, right=472, bottom=1684, face='HY�߸���', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��� ' ,left=477 ,top=1618 ,right=593 ,bottom=1684 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=113 ,top=1618 ,right=177 ,bottom=1684 ,align='left' ,face='HY�߸���' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>



">
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>
