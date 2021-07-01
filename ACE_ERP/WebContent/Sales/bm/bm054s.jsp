<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	통화내역조회
+ 프로그램 ID	: bm054s.jsp
+ 기 능 정 의	: 조회|엑셀|출력
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm054s_s01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
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
	}
	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
		var sdata = "/services/servlet/sales.bm.bm054s_s01"
							+ "?v_str1=" + gcem_vend_nm_fr.text  //회사코드
							+ "&v_str2=" + gcem_acdate_fr.text   //날짜
							+ "&v_str3=" + gcem_work_no.text     //실무번호
							+ "&v_str4=" + txt_cdname_fr.value;  //성명
		gcds_data.DataID = sdata; 
		gcds_data.Reset();			
	}
	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
		 SetTitle("통화내역조회");
		 if (gcds_data.countrow<1) { //alert("해당날짜에 맞는 내용이 없습니다"); 
		 } else {gcgd_disp.GridToExcel("통화내역조회","C:\\Test\\dsh1033.xls",2);}
	}

	/******************************************************************************
		Description : 출력
	******************************************************************************/
	function ln_Print(){
	    alert("준비중입니다.");
	}
	/******************************************************************************
		Description : 회사명
	******************************************************************************/
	function ln_SrhCust(){
		var strURL   = "../../Common/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_vend_nm_fr.text = firstList[0];
		//txt_cscdnm.value = firstList[1];
	}
</script>
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"   VALUE="true">
	<PARAM NAME="SubSumExpr" VALUE="3:VEND_NM,2:TEAM_NM,1:CUST_NM">
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
	gn_LoadComp('1',gcds_data.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_acdate_fr event=OnKeyUp(kcode,scode)>
	  if (kcode=="13") ln_Query();
</script>

<script language=javascript for=gcem_work_no event=OnKeyUp(kcode,scode)>
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


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/excel.gif"	style="position:relative;top:-5px;"	align=absmiddle onClick="ln_Excel()">
			<img src="/services/Sales/images/print.gif"	style="position:relative;top:-5px;" align=absmiddle onclick="ln_Print()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">회&nbsp;사&nbsp;명</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:65px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="##########">
								<param name=PromptChar	  value="">
								<param name=Enable        value=false>
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					  <img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhCust();">		
					</td>		
					<td class="tab_a0100">날&nbsp;&nbsp;&nbsp;&nbsp;짜</td>
					<td class="tab_b0100">
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
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="__GetCallCalendar7('gcem_acdate_fr','Text');">	
					</td>
					<td class="tab_a0100">실무번호</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_work_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="00000000000000000000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>		
					</td>
					<td class="tab_a0100">성&nbsp;&nbsp;&nbsp;&nbsp;명</td>
					<td class="tab_b0000">
            <input id="txt_cdname_fr" type="text" class="txt_a01" style="width:72px" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);">
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
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:402px;" viewastext>
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
							<param name="ViewSummary"		value=1>
							<param name="Format"				value="  
								<F> Name='No.' ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
									<C> Name='소속회사'		ID={decode(curlevel,3,'',2,'',1,'',VEND_NM)}			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=left</C> 
									<C> Name='팀'		      ID=decode(curlevel,3,'',2,'',1,'',TEAM_NM)}			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=left</C> 
									<C> Name='실무번호'		ID=WORK_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center</C> 
									<C> Name='성명'		    ID={decode(curlevel,3,'회사계',2,'팀 계',1,'개인계',CUST_NM)} HeadAlign=Center HeadBgColor=#EEEEEE Width=55	align=center sumText='총 계'</C> 
									<C> Name='요금'	     	ID=UP_SID			  HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right, sumText=@sum color =#0000FF  sumcolor =#0000FF dec=0</C> 
									<C> Name='날짜'		    ID=TEL_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center mask='XXXX/XX/XXXX'</C> 
									<C> Name='통화시작시간'	ID=TEL_STIME	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
									<C> Name='통화종료시간'	ID=TEL_ETIME	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
									<C> Name='사용번호'		ID=UP_NUM			  HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
									<C> Name='전화번호'		ID=TEL_NUM			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
									<C> Name='사용시간'		ID=TEL_DURA			HeadAlign=Center HeadBgColor=#EEEEEE Width=55	align=center</C> 
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
