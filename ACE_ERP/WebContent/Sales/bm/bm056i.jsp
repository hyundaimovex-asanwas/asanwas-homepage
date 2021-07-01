<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	전화통화 단가 관리
+ 프로그램 ID	: bm056i.jsp
+ 기 능 정 의	: 조회|등록|수정
+ 변 경 이 력	: 김병진
+ 서 블 릿 명	: bm051i_s01,bm051i_t01,bm051i_chk_s01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<Script language="javascript" src="../common/include/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
	var gs_date = gn_Replace(gcurdate,"/");
	var gdataset = "";

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
			fnInit_tree(tree_idx);	
			//1:DATE, 2:두개데이터, 3:TOP
			var sdata = "/services/servlet/sales.bm.bm056i_s01";
			gcds_data.DataID = sdata;
			gcds_data.Reset();		
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

		var sdata = "/services/servlet/sales.bm.bm056i_s01";
		gcds_data.DataID = sdata; 
		gcds_data.Reset();			
	}

	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){
			var row = gcds_data.rowposition;

			gcds_data.addrow();
			gcem_date.text = gs_date;
			gcds_data.NameValue(row,"TH_DATE")   = gs_date; 
			gcds_data.NameValue(row,"SN_GU") = "S";
			gcra_sn.CodeValue = "S"; 
			gcem_unit.focus();
	}


	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){

		if (!gcds_data.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

		gctr_data.KeyValue = "bm056i_t01(I:DATA=gcds_data)";
		gctr_data.Action = "/services/servlet/sales.bm.bm056i_t01";
		gctr_data.Parameters = "v_str1=" + fn_trim(gusrid);
		//prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query();
	}


	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

		if (gcem_unit.text == null || gcem_unit.text == "") {
			alert("단가는 필수 입력사항입니다.");
			return false;
		}

		if (gcem_date.text == null || gcem_date.text == "") {
			alert("시작일자는 필수 입력사항입니다.");
			return false;
		}

		if (gcra_sn.codevalue == null || gcra_sn.codevalue == "") {
			alert("남/북 구분이 필요합니다.");
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
//	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
//	gn_LoadComp('1',gcds_data.countrow);
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
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
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:450px;height:200px;" viewastext>
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
								<C> Name='TH_SID'		ID=TH_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='단가'	ID=TH_UNIT		HeadAlign=Center HeadBgColor=#EEEEEE Width=120		align=right show=true mask='000.00'</C> 
								<C> Name='시작일자'	  	ID=TH_DATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=160		align=center show=true mask='XXXX/XX/XX'</C> 
								<C> Name='남북구분'	  ID=SN_GU		HeadAlign=Center HeadBgColor=#EEEEEE Width=100		align=center show=true EditStyle=Combo 					Data='S:남쪽,N:북쪽'</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:451px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
					<td width=3></td>
					<td valign=top>
						<table class="tab_b1011" border="0" cellpadding=0 cellspacing=0 style='width:423px;height:220px;font-size:9pt;'>
	  			    <tr>
								<td class="tab_a0101"">시작일자</td>
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
   							<td class="tab_a0101">단&nbsp;&nbsp;&nbsp;가</td>
								<td class="tab_b0101">
 									<fieldset class=field_01 style="width:55px;">
									<comment id="__NSID__"><OBJECT id=gcem_unit classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:50px;">
											<param name=Alignment			value=2>
											<param name=Border	      value=false>
											<param name=MaxDecimalPlace   value=2>
											<param name=MaxLength value=3>
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
											<param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset> 
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">남북구분</td>
								<td class="tab_b0101" colspan=3>
									<comment id="__NSID__"><object id=gcra_sn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:100;cursor:hand;">
											<param name=Cols     value="2">
											<param name=CodeValue  value="S">
											<param name=Format   value="S^남,N^북">
									</object></comment><script>__ws__(__NSID__);</script>		
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
<!-- CodeValue -->
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=TH_UNIT   Ctrl=gcem_unit	  Param=Text</C>
		<C>Col=TH_DATE  Ctrl=gcem_date	  Param=Text</C>
		<C>Col=SN_GU      Ctrl=gcra_sn	        Param=CodeValue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
