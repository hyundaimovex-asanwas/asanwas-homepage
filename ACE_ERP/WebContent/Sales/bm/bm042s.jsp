<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	식수내역조회
+ 프로그램 ID	: bm042s.jsp
+ 기 능 정 의	: 조회|등록|저장|
+ 변 경 이 력	: KBJ
+ 서 블 릿 명	: bm042s01
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
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	
		ln_Before();
	}
	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
		gcem_acdate_fr.text = fn_trim(gs_date);
		gcem_acdate_fr2.text = fn_trim(gs_date);

		gcds_cm001.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CM001";
		gcds_cm001.Reset();
	}
	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

		var sdata = "/services/servlet/sales.bm.bm042s01"
							+ "?v_str1=" + gcem_acdate_fr.text
							+ "&v_str2=" + gcem_acdate_fr2.text;
		gcds_data.DataID = sdata;
		//prompt("",gcds_data.DataID);
		gcds_data.Reset();
	}
	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
		 SetTitle("식수내역조회");
		 if (gcds_data.countrow<1) {
		 } else {gcgd_disp.GridToExcel("식수내역조회","C:\\Temp\\식수내역조회.xls",2);}
	}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cm001 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
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

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_acdate_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>
<script language=javascript for=gcem_acdate_fr2 event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
<!--			<img src="/services/Sales/images/print.gif"	style="position:relative;top:-5px;" align=absmiddle onclick="ln_Print()">		//-->
			<img src="/services/Sales/images/excel.gif"	style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onClick="ln_Excel()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">날&nbsp;&nbsp;&nbsp;&nbsp;짜</td>
					<td class="tab_b0000" colspan=3>
						<fieldset class=field_01 style="width:67px;">
						<comment id="__NSID__"><OBJECT id=gcem_acdate_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr','Text', '250', '260');">
						&nbsp;~
						<fieldset class=field_01 style="width:67px;">
						<comment id="__NSID__"><OBJECT id=gcem_acdate_fr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr2','Text', '250', '260');">
					</td>
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:600px;" viewastext>
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
							<Param Name="UsingOneClick" value="1">
							<param name="Editable"      value="true">
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
									<C> Name='소속회사'		ID=CLIENT_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=left   edit=none</C> 
									<C> Name='팀'	      	ID=TEAM_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=left   edit=none</C> 
									<C> Name='실무번호'		ID=WORK_NO			 HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center edit=none</C>
									<C> Name='성명'		    ID=CUST_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=90	align=center edit=none</C> 
									<C> Name='조식'		    ID=EATING_BRE	 HeadAlign=Center HeadBgColor=#EEEEEE Width=110 	align=center editstyle='lookup' 	
														data='gcds_cm001:DETAIL:DETAIL_NM' bgcolor=#C4DDFF</C> 
									<C> Name='중식'		    ID=EATING_LUN	 HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center align=center editstyle='lookup' 
														data='gcds_cm001:DETAIL:DETAIL_NM' bgcolor=#C4DDFF</C> 
									<C> Name='석식'		    ID=EATING_DIN	 HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center align=center editstyle='lookup' 
														data='gcds_cm001:DETAIL:DETAIL_NM' bgcolor=#C4DDFF</C> 
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
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>