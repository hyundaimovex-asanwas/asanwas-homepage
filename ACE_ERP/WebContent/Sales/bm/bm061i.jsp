<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	진료일자관리
+ 프로그램 ID	: bm061i.jsp
+ 기 능 정 의	: 조회|등록|저장|
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm061_s01,bm061_t01
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
		ln_Before();
	}
	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
		gcem_acdate_fr.text = fn_trim(gs_date);
		var sdata = "/services/servlet/sales.bm.bm061i_s01"
							+ "?v_str1=19000000";
		gcds_data.DataID = sdata; 
		gcds_data.Reset();
	}
	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
		var sdata = "/services/servlet/sales.bm.bm061i_s01"
							+ "?v_str1=" + gcem_acdate_fr.text;
		gcds_data.DataID = sdata; 
		gcds_data.Reset();
	}
	/******************************************************************************
		Description : 팝업(개인정보관리 팝업)
	******************************************************************************/
	function ln_Pop(){
		var strURL = "bm061i_r.html";
		var strPos = "dialogWidth:515px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

		gcds_data.NameValue(gcds_data.rowposition,"CUST_SID")= firstList[0];
		gcds_data.NameValue(gcds_data.rowposition,"VEND_NM")= firstList[1];
		gcds_data.NameValue(gcds_data.rowposition,"TEAM_NM")= firstList[2];
		gcds_data.NameValue(gcds_data.rowposition,"WORK_NO")= firstList[3];
		gcds_data.NameValue(gcds_data.rowposition,"CUST_NM")= firstList[4];
	}
	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){
		if (gcds_data.RowStatus(gcds_data.RowPosition) == 1 ){
					return false;
		}

		gcds_data.addrow();
		gcds_data.NameValue(gcds_data.rowposition,"I_EMPNO") = gusrid;
	    gcds_data.NameValue(gcds_data.rowposition,"MEDI_DATE") = gs_date.substring(0,4)+gs_date.substring(5,7)+gs_date.substring(8,10);
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

		gctr_data.KeyValue = "bm061i_t01(I:DATA=gcds_data)";
		gctr_data.Action = "/services/servlet/sales.bm.bm061i_t01";
		//prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query();
	}

	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
		 SetTitle("진료일자관리");
		 if (gcds_data.countrow<1) {
		 } else {gcgd_disp.GridToExcel("진료일지관리","C:\\Temp\\진료일지관리.xls",2);}
	}

	/******************************************************************************
		Description : 출력
	******************************************************************************/
	function ln_Print(){
		alert("준비중입니다.");
	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){
		if (gcds_data.NameValue(gcds_data.rowposition,"CUST_SID") =="") {
			alert("성명은 필수사항입니다.");
			//gcem_vend_id.focus();
			return false;
		} 

		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="3"){
       gcds_data.NameValue(gcds_data.rowposition,"U_EMPNO") = gusrid;			
		}

		return true;
	}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
//	gn_LoadComp('1',gcds_data.countrow);
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language="javascript"  for=gcgd_disp event=OnDblClick(Row,Colid)>
	if(Colid=="VEND_NM" || Colid=="TEAM_NM" || Colid=="WORK_NO" || Colid=="CUST_NM") ln_Pop();
</script>

</script>
<!---	T R A N S A C T I O N   C O M P O N E N T' S		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N	 ---->
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
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr','Text', '255', '260');">
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
							<param name="ViewSummary"		value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
									<C> Name='소속회사'		ID=VEND_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=left   edit=none</C> 
									<C> Name='팀'	      	ID=TEAM_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=left   edit=none</C> 
									<C> Name='관리번호'		ID=WORK_NO			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center edit=none</C>
									<C> Name='성명'		    ID=CUST_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=65	align=center edit=none</C> 
									<C> Name='치료비용'		ID=MEDI_FEE			 HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=right sumText=@sum color =#0000FF  sumcolor =#0000FF dec=0</C>
									<C> Name='정산여부'		ID=CALC_YN			 HeadAlign=Center HeadBgColor=#EEEEEE Width=70 	align=center EditStyle=CheckBox</C> 
									<C> Name='병 명'		  ID=DISEASE_NAME	 HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=left</C> 
									<C> Name='치료내용'		ID=TREAT_CONTENT HeadAlign=Center HeadBgColor=#EEEEEE Width=200	align=left</C> 
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