<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	���� �ܰ� ����
+ ���α׷� ID	: cm017i.jsp
+ �� �� �� ��	: ��ȸ|���|����
+ �� �� �� ��	: KBJ
+ �� �� �� ��	: cm017i_s01, cm017i_t01
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
	var gdataset = "";

	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/
	function fnOnLoad(tree_idx){	
			fnInit_tree(tree_idx);	
			ln_Query();
	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query(){

//		gcds_data.DataID = "/services/servlet/sales.cm.cm017i_s01";
		gcds_data.DataID = "/services/servlet/sales.cm.cm017s01";
		//prompt('',gcds_data.DataID);
		gcds_data.Reset();

	}

	/******************************************************************************
		Description : ���
	******************************************************************************/
	function ln_Add(){
		if (gcds_data.RowStatus(gcds_data.RowPosition) == 1 ){
					return false;
		}
			var row = gcds_data.rowposition;
			gcds_data.addrow();

			gcem_date.text = gs_date;
//			gcds_data.NameValue(row,"OP_DATE")   = gs_date; 
			gcds_data.NameValue(row,"OIL_TYPE") = "0";
			gcra_ot.CodeValue = "0"; 
			gcem_unit.focus();
	}


	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){

		if (!gcds_data.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

		gctr_data.KeyValue = "cm017i_t01(I:DATA=gcds_data)";
		gctr_data.Action = "/services/servlet/sales.cm.cm017i_t01";
		gctr_data.Parameters = "v_str1=" + fn_trim(gusrid);
		//prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query();
	}


	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_Valchk(){

		if (gcem_unit.text == null || gcem_unit.text == "") {
			alert("�ܰ��� �ʼ� �Է»����Դϴ�.");
			return false;
		}

		if (gcem_date.text == null || gcem_date.text == "") {
			alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
			return false;
		}

		if (gcra_ot.codevalue == null || gcra_ot.codevalue == "") {
			alert("���� ������ �ʿ��մϴ�.");
			return false;
		}

		return true;
	}

</script>	
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>
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
	//gn_LoadComp('1',gcds_data.countrow);
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
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
			<img src="/services/Sales/images/plus.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Add()">
			<img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>

  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:410px;height:200px;" viewastext>
							<param name="DataID"				value="gcds_data">
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
								<C> Name='OP_SID'		ID=OP_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='����'	ID=OIL_TYPE		HeadAlign=Center HeadBgColor=#EEEEEE Width=120		align=right show=true EditStyle=Combo 					Data='0:����,1:�ֹ���,2:����,3:������(����)'</C> 
								<C> Name='�ܰ�'	ID=OP_UNIT		HeadAlign=Center HeadBgColor=#EEEEEE Width=120		align=right show=true </C> 
								<C> Name='��������'	  	ID=OP_DATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=100		align=center show=true mask='XXXX/XX/XX'</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:411px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
					<td width=3></td>
					<td valign=top>
						<table class="tab_b1011" border="0" cellpadding=0 cellspacing=0 style='width:463px;height:220px;font-size:9pt;'>
							<tr>
   							<td class="tab_a0101">��������</td>
								<td class="tab_b0101" colspan=3>
									<comment id="__NSID__"><object id=gcra_ot classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:375;cursor:hand;">
											<param name=Cols     value="4">
											<param name=CodeValue  value="S">
											<param name=Format   value="0^����,1^�ֹ���,2^����,3^������(����)">
									</object></comment><script>__ws__(__NSID__);</script>		
								</td>
							</tr>
			  			    <tr>
								<td class="tab_a0101"">��������</td>
								<td class="tab_b0101">
									<fieldset class=field_01 style="width:75px;">
									<comment id="__NSID__"><OBJECT id=gcem_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:70px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
											<param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">�ܰ�(����)</td>
								<td class="tab_b0101">
 									<fieldset class=field_01 style="width:55px;">
									<comment id="__NSID__"><OBJECT id=gcem_unit classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:50px;">
											<param name=Alignment			value=2>
											<param name=Border	      value=false>
											<param name=MaxLength value=3>
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
											<param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset> 
								</td>
							</tr>
							<tr><td class="tab_b0100" colspan="4">&nbsp;</td></tr> 
						</table>
  				</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=OP_UNIT   Ctrl=gcem_unit	  Param=Text</C>
		<C>Col=OP_DATE  Ctrl=gcem_date	  Param=Text</C>
		<C>Col=OIL_TYPE      Ctrl=gcra_ot	        Param=CodeValue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--------------------------------- �ڵ� �κ� �� --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
