<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	��������
+ ���α׷� ID	: cm012i.jsp
+ �� �� �� ��	: ��ȸ|���|����
+ �� �� �� ��	: KBJ
+ �� �� �� ��   : 2007.12.03
+ �� �� �� ��   : 2008.01.15	2008.01.16
+ �� �� �� ��	: cm012i_s01,cm012i_s02, cm012i_s03, cm012i_t01
------------------------------------------------------------------------------>
<html>
<head>
<jsp:include page="/Sales/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<Script language="javascript" src="../common/include/PubFun.js"></script>
<link rel="stylesheet" href="../common/include/common.css">
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
	var gs_date = gn_Replace(gcurdate,"/");

	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		ln_before();//����ȸ
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

	}

	/******************************************************************************
		Description : ����ȸ
	******************************************************************************/
	function fnInit(){
		//*****  ������ �ʱ�ȭ �Լ��� ���⿡..  ********
		cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
		window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.
	}
/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
	function ln_before(){
	//�ƹ��͵� ���� ������ �ҷ����� ���� �Ķ����(zzzzz) ����
		gcds_data01.DataID = "/services/servlet/sales.cm.cm012i_s01?"
										 + "v_str1=zzzzz";
		gcds_data01.Reset();

		gcds_data03.DataID = "/services/servlet/sales.cm.cm012i_s03?v_str1=0";
		gcds_data03.Reset();
		gcem_ounit.text = gcds_data03.NameValue(1, "OP_UNIT");
	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query() {
	gcds_data01.DataID = "/services/servlet/sales.cm.cm012i_s01?"
											 + "v_str1=" + fn_trim(gcem_c1.text)
											 + "&v_str2=" + fn_trim(gcem_c2.text)
											 + "&v_str3=" + fn_trim(gcem_c3.text);
//  prompt('',gcds_data01.DataID);
	gcds_data01.Reset();

	gcds_data02.DataID = "/services/servlet/sales.cm.cm012i_s02?"
											 + "&v_str1=0";
//  prompt('',gcds_data02.DataID);
	gcds_data02.Reset();
	}

	/******************************************************************************
		Description : �߰�
	******************************************************************************/
	function ln_Add(){

		gcds_data02.addrow();
		gcra_otype.codevalue = 0;
		gcem_oqty.text = 0;
		gcem_oprice.text = 0;
		gcra_ocalc_yn.codevalue = 1;
		gcem_oqty.focus();

	}
	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_Valchk(){

		if (gcem_oqty.text < 1) {
			alert("�������� �Է��ϼž� �մϴ�.");
			return false;
		} 
		if (gcem_oprice.text < 1) {
			alert("�����ݾ��� �Է��ϼž� �մϴ�.");
			return false;
		}

		return true;

	}

	function ln_Auth(){
		<%
			String tree_idx = request.getParameter("idx");
		%>
		var v_btn_auth = "S";
		gcds_btn_auth.DataID = "/services/servlet/sales.common.btn_auth?"
										 + "v_str1=" + gusrid
										 + "&v_str2=" + <%=tree_idx%>;

		//prompt('',gcds_btn_auth.DataID);
		gcds_btn_auth.Reset();
		if(gcds_btn_auth.countrow < 1 || gcds_btn_auth.NameValue(1, "BTN_AUTH") =="undefined"){	v_btn_auth = "S";}
		else	{	v_btn_auth = gcds_btn_auth.NameValue(1, "BTN_AUTH");	 }

		
		if(v_btn_auth=="S")
			{	window.status='���� ������ �����ϴ�';	}
		else
			{	ln_Save();	}
	}
	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
		if (!gcds_data02.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

		var row = gcds_data02.rowposition;
		gcds_data02.NameValue(row, "OIL_TYPE") = gcra_otype.codevalue;
		gcds_data02.NameValue(row, "OILING_QTY") = gcem_oqty.text;
		gcds_data02.NameValue(row, "OILING_PRICE") = gcem_oprice.text;
		gcds_data02.NameValue(row, "CALC_YN") = gcra_ocalc_yn.codevalue;

		gcds_data02.NameValue(row, "CARNO_SID") = gcem_carno_sid.text;
		gcds_data02.NameValue(row,"CAR_NO") = gcem_car_no.text; 
		gcds_data02.NameValue(row,"CAR_DNO")   = gcem_car_dno.text; 
		gcds_data02.NameValue(row,"CAR_RNO")   = gcem_car_rno.text;
		//alert("" + gcds_data02.NameValue(row, "OILING_SID") + "");
		gctr_data.KeyValue = "cm012i_t01(I:DATA=gcds_data02)";
	    gctr_data.Action = "/services/servlet/sales.cm.cm012i_t01";
		gctr_data.Parameters = "v_str1=" +  gcds_data02.namevalue(row,"OILING_SID") + ", v_str2=" + gusrid;

		gctr_data.post();
//		gcds_data02.Reset();	//�� �׸��� reset
	}

	//Description : ���ó
	function ln_Udeprt(){
		gcem_use_depart.text = "";
		var strURL = "/services/Sales/cm/cm012i_r.jsp";
		var strPos = "dialogWidth:415px;dialogHeight:420px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

	    gcem_use_depart_sid.text = firstList[0];
	    gcem_use_depart.text = firstList[1];
	}

	/******************************************************************************
		Description : ����

	function ln_Excel(){
		 SetTitle("�������ڰ���");
		 if (gcds_data.countrow<1) {
		 } else {gcgd_disp.GridToExcel("�������ڰ���","C:\\Test\\dsh1033.xls",2);}
	}
	******************************************************************************/	
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
<%=HDConstant.COMMENT_END%>

<comment id="__NSID__">

<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
//	gn_LoadComp('1',gcds_data01.countrow);
	gn_LoadComp_NonAlert('1',gcds_data01.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>
<!-- �׸��� Ŭ���� ����ȸ -->
<script language="javascript"  for=gcgd_disp1 event=OnClick(Row,Colid)>
	gcds_data02.DataID = "/services/servlet/sales.cm.cm012i_s02?"
											 + "v_str1=" + gcds_data01.NameValue(Row, "CARNO_SID");
//  prompt('',gcds_data02.DataID);
	gcds_data02.Reset();
	//�� ���� �����͸� ������
	var row2 = gcds_data02.rowposition;
	gcem_carno_sid.text = gcds_data01.NameValue(Row, "CARNO_SID");
	gcem_car_no.text = gcds_data01.NameValue(Row, "CAR_NO");
	gcem_car_dno.text = gcds_data01.NameValue(Row, "CAR_DNO");
	gcem_car_rno.text = gcds_data01.NameValue(Row, "CAR_RNO");
	gcra_otype.codevalue = gcds_data02.NameValue(row2, "OIL_TYPE");
	gcem_oqty.text = gcds_data02.NameValue(row2, "OILING_QTY");
	gcem_oprice.text = gcds_data02.NameValue(row2, "OILING_PRICE");
	gcra_ocalc_yn.codevalue = gcds_data02.NameValue(row2, "CALC_YN");
//	alert(	gcds_data02.NameValue(Row, "OIL_TYPE"));
  </script>
  <!--		�����ݾ� �ڵ� ���//-->
<script language=JavaScript for=gcem_oqty event=OnKillFocus()>
	if(gcem_oqty.text > 0){
		gcem_oprice.text = gcem_oqty.text * gcem_ounit.text;
	}
</script>
<script language=JavaScript for=gcra_otype event=OnSelChange()>
 	gcds_data03.DataID = "/services/servlet/sales.cm.cm012i_s03?v_str1=" + gcra_otype.CodeValue;
	gcds_data03.Reset();
	gcem_ounit.text = gcds_data03.NameValue(1, "OP_UNIT");
	if(gcem_oqty.text > 0){
		gcem_oprice.text = gcem_oqty.text * gcem_ounit.text;
	}
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert(gn_Msg(1));
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gn_Msg(2));
</script>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/new.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Add()">
            <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Auth()">
<!--            <img src="/services/Sales/images/excel.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Excel()">	 //-->
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">������ȣ:</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_c1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0100">�����ȣ:</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_c2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
					<td class="tab_a0100">������ȣ:</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_c3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <!-- <td colspan=2>  -->
    <td>
      <table width="415" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:405px;height:210px;" viewastext>
							<param name="DataID"				value="gcds_data01">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='CARNOSID'		ID=CARNO_SID	HeadAlign=Center HeadBgColor=#EEEEEE Width=0		align=left show=false</C> 
								<C> Name='����SID'		ID=CAR_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=0		align=left show=false</C> 
								<C> Name='������ȣ'		ID=CAR_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=115	align=center</C> 
								<C> Name='�����ȣ'	  	ID=CAR_DNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=125	align=center</C> 
								<C> Name='������ȣ'		ID=CAR_RNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:406px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:462px;'>
		    <tr>
					<td class="tab_a0101">������ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;">
						<comment id="__NSID__"><OBJECT id=gcem_carno_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<comment id="__NSID__"><OBJECT id=gcem_car_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:115px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
								<param name=ReadOnly value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">�����ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_dno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:115px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
								<param name=ReadOnly value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>					
				</tr>
		    <tr>
				  <td class="tab_a0101">������ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_rno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:115px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
								<param name=ReadOnly value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td>		
			</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;��&nbsp;ó</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;">
						<comment id="__NSID__"><OBJECT id=gcem_use_depart classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:115px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;
						<OBJECT id=gcem_use_depart_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT>

						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_Udeprt();">
					</td>		
			</tr>
		    <tr>
				  <td class="tab_a0101">��������</td>
					<td class="tab_b0001" style="width:450px;">
						<comment id="__NSID__"><object id=gcra_otype classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="left:4px;top:0px;height:24;width:380;cursor:hand;">
								<param name=Cols     value="4">
								<param name=CodeValue  value="0">
								<param name=AutoMargin  value="false">
								<param name=Format   value="0^����,1^�ֹ���,2^����,3^������(����)">
						</object></comment><script>__ws__(__NSID__);</script>				
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:60px;">
						<comment id="__NSID__"><OBJECT id=gcem_oqty classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=2>
								<param name=Border	      value=false>
								<param name=Numeric       value="true">
								<param name=IsComma       value=true>
								<param name=MaxLength     value=6>
								<param name=SelectAll     value=true>
								<param name=MaxDecimalPlace   value=2>
						</OBJECT>						</fieldset>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<fieldset class=field_01 style="width:55px;">
						<OBJECT id=gcem_ounit classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=2>
								<param name=Border	      value=false>
								<param name=Numeric       value="true">
								<param name=IsComma       value=true>
								<param name=MaxLength     value=6>
								<param name=SelectAll     value=true>
								<param name=MaxDecimalPlace   value=2>
								<param name=ReadOnly value="true">
								<param name=Enable value="false">
						</OBJECT>
						</comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
				</tr>
				  <td class="tab_a0101">�����ݾ�($)</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_oprice classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=2>
								<param name=Border	      value=false>
								<param name=Numeric       value="true">
								<param name=IsComma       value=true>
								<param name=MaxLength     value=8>
								<param name=SelectAll     value=true>
								<param name=MaxDecimalPlace   value=2>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>		

		    <tr>
				  <td class="tab_a0100">���꿩��</td>
					<td class="tab_b0000">
						<comment id="__NSID__"><object id=gcra_ocalc_yn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:24;width:390;cursor:hand;">
								<param name=Cols     value="6">
								<param name=CodeValue  value="0">
								<param name=Format   value="0^����,1^�ܻ�,2^����,3^����,4^����,5^����">
						</object></comment><script>__ws__(__NSID__);</script>			
					</td>		
				</tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:300px;" viewastext>
							<param name="DataID"				value="gcds_data02">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'					ID={CURROW}		HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='�����̷�SID'		ID=OILING_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='����SID'			ID=CARNO_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='������ȣ'			ID=CAR_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center</C> 
								<C> Name='�����ȣ'		  	ID=CAR_DNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center</C> 
								<C> Name='������ȣ'			ID=CAR_RNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center</C> 
								<C> Name='����'					ID=OIL_TYPE			HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center EditStyle=Combo 					Data='0:����,1:�ֹ���,2:����,3:������(����)'</C>
								<C> Name='������'				ID=OILING_QTY		HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center </C> 
								<C> Name='�����ݾ�'		    ID=OILING_PRICE	HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center </C> 
								<C> Name='���꿩��'			ID=CALC_YN			HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center EditStyle=Combo Data='0:����,1:�ܻ�,2:����,3:����,4:����,5:����'</C>
								<C> Name='������'				ID=OILING_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center mask='XXXX/XX/XX'</C> 
								<C> Name='���ó�ڵ�'		ID=USEP				HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='���ó'				ID=USEPNM		HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<comment id="__NSID__">
<object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		value=gcds_data02>
	<param name=ActiveBind   value=true>	
	<param name=BindInfo		value='
		<C>Col=OIL_TYPE			Ctrl=gcra_otype			Param=CodeValue</C>
		<C>Col=OILING_QTY		Ctrl=gcem_oqty			Param=text</C>
		<C>Col=OILING_PRICE   Ctrl=gcem_oprice		Param=text</C>
		<C>Col=CALC_YN			Ctrl=gcra_ocalc_yn		Param=CodeValue</C>
		<C>Col=USEP				Ctrl=gcem_use_depart_sid		Param=text</C>
		<C>Col=USEPNM			Ctrl=gcem_use_depart		Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!--------------------------------- �ڵ� �κ� �� --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>