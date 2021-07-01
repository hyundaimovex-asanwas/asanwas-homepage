<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	������
+ ���α׷� ID	: cm013i.jsp
+ �� �� �� ��	: ��ȸ|���|����
+ �� �� �� ��	: KBJ
+ �� �� �� ��   : 2008.01.16
+ �� �� �� ��   : 2008.01.18
+ �� �� �� ��	: cm013i_s01,cm013i_s02, cm013i_t01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
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
//		ln_before();//����ȸ
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
	}

	/*----------------------------------------------------------------------------
		Description : ����ȸ ����
	----------------------------------------------------------------------------*/
	function ln_before(){
	//�ƹ��͵� ���� ������ �ҷ����� ���� �Ķ����(zzzzz) ����
//		gcds_data01.DataID = "/services/servlet/sales.cm.cm012i_s01?"
//										 + "v_str1=zzzzz";
//		gcds_data01.Reset();

//		gcds_data03.DataID = "/services/servlet/sales.cm.cm012i_s03";
//		gcds_data03.Reset();
//		gcem_ounit.text = gcds_data03.NameValue(1, "DETAIL_NM");
	}
	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query() {
		gcds_data01.DataID = "/services/servlet/sales.cm.cm013i_s01?"
												 + "v_str1=" + fn_trim(gcem_c1.text)
												 + "&v_str2=" + fn_trim(gcem_c2.text)
												 + "&v_str3=" + fn_trim(gcem_c3.text);
	//  prompt('',gcds_data01.DataID);
		gcds_data01.Reset();

		gcds_data02.DataID = "/services/servlet/sales.cm.cm013i_s02?"
												 + "&v_str1=0";
	//  prompt('',gcds_data02.DataID);
		gcds_data02.Reset();
	}

	/******************************************************************************
		Description : �߰�
	******************************************************************************/
	function ln_Add(){
		gcds_data02.addrow();

		var row1 = gcds_data01.rowposition;
		var row2 = gcds_data02.rowposition;
		gcds_data02.NameValue(row2, "CARNO_SID") = gcds_data01.NameValue(row1, "CARNO_SID");

	}

	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_Valchk(){

		var rowcount = gcds_data02.CountRow;
		
		if(rowcount < 1) return false;

		for(i = 1 ; i <= rowcount ; i++){
			//alert("i : " + i);
			//alert(":::::" + gcds_data02.NameValue(i, "ACCI_TIME").length+":::::::::::::"); 
			if (fn_trim(gcds_data02.NameValue(i, "ACCI_DATE")) == ""  || gcds_data02.NameValue(i, "ACCI_DATE").length < 8) {
				alert("��¥�� �Է��ϼž� �մϴ�.");
				return false;
			} 
			if (fn_trim(gcds_data02.NameValue(i, "ACCI_TIME")) == ""  || gcds_data02.NameValue(i, "ACCI_TIME").length < 4) {
				alert("�ð��� �Է��ϼž� �մϴ�.");
				return false;
			}
		}
		return true;

	}
	/******************************************************************************
	//		Description : ����
	******************************************************************************/
	function ln_Excel(){
		gcds_data03.DataID = "/services/servlet/sales.cm.cm013i_s03";
		//prompt('',gcds_data03.DataID);
		gcds_data03.Reset();

		 SetTitle("������ȸ");
		 if (gcds_data03.countrow<1) { //alert("�ش糯¥�� �´� ������ �����ϴ�"); 
		 } else {gcgd_disp.GridToExcel("������ȸ","C:\\Test\\������ȸ.xls",2);}
	}
	/******************************************************************************
	//		Description : ����
	******************************************************************************/
	function ln_Save(){
		if (!gcds_data02.isUpdated) {
			alert(gn_Msg(4));
			return;
		}
		if (!ln_Valchk()) return;

		var row = gcds_data02.rowposition;
		//gv_date_check		fn_trim
		gctr_data.KeyValue = "cm013i_t01(I:DATA=gcds_data02)";
	    gctr_data.Action = "/services/servlet/sales.cm.cm013i_t01";
		gctr_data.Parameters = "v_str1=" +  gcds_data02.namevalue(row,"ACCI_SID") + ", v_str2=" + gusrid;
		//alert(	gcds_data02.NameValue(Row, "CARNO_SID"));
		gctr_data.post();
//		gcds_data02.Reset();	//�� �׸��� reset
	}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- master data -->
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="false"></object>
<!--��üũ-->
<object id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></object>
<object id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></object>
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
//	gn_LoadComp('1',gcds_data.countrow);
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>

<script language="javascript"  for=gcgd_disp1 event=OnClick(Row,Colid)>
//	gcds_data02.Undo(gcds_data02.RowPosition);
	gcds_data02.UndoAll();
  </script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_c1 event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>
<script language=javascript for=gcem_c2 event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>
<script language=javascript for=gcem_c3 event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
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
	<!-- �׸��� Ŭ���� ����ȸ -->
<script language="javascript"  for=gcgd_disp1 event=OnClick(Row,Colid)>
	gcds_data02.DataID = "/services/servlet/sales.cm.cm013i_s02?"
										 + "v_str1=" + gcds_data01.NameValue(Row, "CARNO_SID");
	//prompt('',gcds_data02.DataID);
	gcds_data02.Reset();
	//�� ���� �����͸� ������
	//alert(	gcds_data02.NameValue(Row, "OIL_TYPE"));
</script>
	<!-- �׸��� Ŭ���� ����ȸ -->
<script language=JavaScript for=gcds_data02 event=OnColumnChanged(row,colid)>
	var chkValue = "";

	if(colid == "ACCI_DATE"){
		chkValue = gcds_data02.NameValue(row, "ACCI_DATE");
		if(chkValue != ""){
//		alert("" + chkValue.substring(0, 2));
			if(!gv_date_check(chkValue)){
				alert("��¥ ������ ������ϴ�.");
				gcds_data02.NameValue(row, "ACCI_DATE") = "";
				return;
			}
		}
	}	

	if(colid == "ACCI_TIME"){
		chkValue = gcds_data02.NameValue(row, "ACCI_TIME");

		if(chkValue.substring(0, 2) < 0 || chkValue.substring(0, 2) > 23){
			alert("�ð��� 00�ú��� 23�ñ��� �Դϴ�");
			gcds_data02.NameValue(row, "ACCI_TIME") = "";
		}
		if(chkValue.substring(2, 4) < 0 || chkValue.substring(2, 4) > 59){
			alert("���� 00�ú��� 59�ñ��� �Դϴ�");
			gcds_data02.NameValue(row, "ACCI_TIME") = "";
		}
	}

</script>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>&nbsp;</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:302px;'>

		    <tr>
					<td class="tab_a0101">������ȣ:</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_c1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:95px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
							<img src="/services/Sales/images/refer.gif" style="position:relative;cursor:hand;"	align=absmiddle onclick="ln_Query()">
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">�����ȣ:</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_c2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:95px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>					
				</tr>
		    <tr>
				  <td class="tab_a0101">������ȣ:</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_c3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:95px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>		
				</tr>
				<tr><td colspan=3 style="height:86px">&nbsp;</td></tr>
			</table>		
		</td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:570px;'>
		    <tr>
					<td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:560px;height:140px;" viewastext>
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
								<F> Name='No.'				ID={CURROW}	 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='CARNO_SID'	ID=CARNO_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=0	align=center show=false</C>
								<C> Name='������ȣ'		ID=CAR_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C>
								<C> Name='�����ȣ'		ID=CAR_DNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C>
								<C> Name='������ȣ'		ID=CAR_RNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C>
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:560px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>					
					</td>
				</tr>
			</table>	
		</td>
	</tr>
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=4>
		<img src="/services/Sales/images/new.gif"	style="position:relative;cursor:hand;" align=absmiddle onClick="ln_Add()">
		<img src="/services/Sales/images/save.gif"	style="position:relative;cursor:hand;" align=absmiddle onClick="ln_Save()">
		<img src="/services/Sales/images/excel.gif"	style="position:relative;cursor:hand;"	align=absmiddle onClick="ln_Excel()">
   </td>
	</tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:200px;" viewastext>
							<param name="DataID"				value="gcds_data02">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="Editable"      value="true">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 			HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center edit=false</F>
								<C> Name='����̷�'		ID=ACCI_SID				HeadAlign=Center HeadBgColor=#EEEEEE Width=0	align=center show=false edit=false</C> 
								<C> Name='CARNO_SID'	ID=CARNO_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=0	align=center show=false edit=false</C> 
								<C> Name='�������'		ID=ACCI_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center mask='XXXX/XX/XX' edit=true EditLimit=8</C>
								<C> Name='�ð�'				ID=ACCI_TIME			HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center mask='XX:XX' edit=true EditLimit=4</C>
								<C> Name='������'		ID=ACCI_PLACE			HeadAlign=Center HeadBgColor=#EEEEEE Width=180	align=center edit=true EditLimit=30</C> 
								<C> Name='������'			ID=WORK_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center edit=true EditLimit=20</C> 
								<C> Name='�����'		ID=ACCI_CONTENT	HeadAlign=Center HeadBgColor=#EEEEEE Width=180	align=center edit=true EditLimit=50</C> 
								<C> Name='��ġ����'		ID=ACCI_FU				HeadAlign=Center HeadBgColor=#EEEEEE Width=250	align=center edit=true EditLimit=100</C> 
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
<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:0px;height:0px;" viewastext>
							<param name="DataID"				value="gcds_data03">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="Editable"      value="true">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 			HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center edit=false</F>
								<C> Name='����̷�'		ID=ACCI_SID				HeadAlign=Center HeadBgColor=#EEEEEE Width=0	align=center show=false edit=false</C> 
								<C> Name='CARNO_SID'	ID=CARNO_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=0	align=center show=false edit=false</C> 
								<C> Name='�������'		ID=ACCI_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center mask='XXXX/XX/XX' edit=true EditLimit=8</C>
								<C> Name='�ð�'				ID=ACCI_TIME			HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center mask='XX:XX' edit=true EditLimit=4</C>
								<C> Name='������'		ID=ACCI_PLACE			HeadAlign=Center HeadBgColor=#EEEEEE Width=180	align=center edit=true EditLimit=30</C> 
								<C> Name='������'			ID=WORK_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center edit=true EditLimit=20</C> 
								<C> Name='�����'		ID=ACCI_CONTENT	HeadAlign=Center HeadBgColor=#EEEEEE Width=180	align=center edit=true EditLimit=50</C> 
								<C> Name='��ġ����'		ID=ACCI_FU				HeadAlign=Center HeadBgColor=#EEEEEE Width=250	align=center edit=true EditLimit=100</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
<!--------------------------------- �ڵ� �κ� �� --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>