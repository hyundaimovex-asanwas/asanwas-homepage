<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	사업자 출국신청
+ 프로그램 ID	: bm026i.jsp
+ 기 능 정 의	: 조회|저장|엑셀
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm026i_s01,bm026i_s02,bm026i_s03,bm026i_t01
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
		ln_Before();            
	}
	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
		gcem_acdate_fr.text = gs_date;
	}
	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

		var sdata = "/services/servlet/sales.bm.bm026i_s01"
							+ "?v_str1=" + txt_cdname_fr.value;
		gcds_data_1.DataID = sdata; 
		gcds_data_1.Reset();

	}
	
	/******************************************************************************
		Description : 엑셀 (조회)
	******************************************************************************/
	function ln_ExcelQuery(){

		var sdata = "/services/servlet/sales.bm.bm026i_s03"
							+ "?v_str1=" + gcem_acdate_fr.text;
		gcds_back.DataID = sdata; 
		gcds_back.Reset();

	}

	//Description : 저장
	function ln_Save(){
//		gcds_data_2.addrow();
/*		if (!gcds_data_2.isUpdated) {
			alert(gn_Msg(4));
			return;
		}
*/
		if (!ln_Valchk()) return;

		gcds_data_2.namevalue(gcds_data_2.rowposition,"T1_RSV_SID")	= fn_trim(gcem_rsv_sid.text);
		gcds_data_2.namevalue(gcds_data_2.rowposition,"I_EMPNO")     = gusrid;
		gcds_data_2.namevalue(gcds_data_2.rowposition,"U_EMPNO")     = gusrid;
		gcds_data_2.namevalue(gcds_data_2.rowposition,"T1_U_EMPNO")  = gusrid;
		gcds_data_2.namevalue(gcds_data_2.rowposition,"ARRIVE_DATE") = gcem_ns_plan.text;
		gcds_data_2.namevalue(gcds_data_2.rowposition,"NS_PLAN")	=	fn_trim(gcem_ns_plan.text);
		gcds_data_2.namevalue(gcds_data_2.rowposition,"SN_PLAN")	=	fn_trim(gcem_sn_plan.text);
		gcds_data_2.namevalue(gcds_data_2.rowposition,"CAR_YN")	 =	 gcra_caryn.codevalue;
		gcds_data_2.namevalue(gcds_data_2.rowposition,"BIGO")	=	fn_trim(txt_bigo.value);

		gctr_data.KeyValue = "bm026i_t01(I:DATA=gcds_data_2)";
		gctr_data.Action = "/services/servlet/sales.bm.bm026i_t01";
		gctr_data.Parameters = "v_str1=" +  gcds_data_2.namevalue(gcds_data_2.rowposition,"T1_RSV_SID");
		gctr_data.post();
	}

	//Description : 입력값 체크
	function ln_Valchk(){

		if (fn_trim(gcem_rsv_sid.text) == "") {
			alert("해당 출입일이 존재하지 않습니다.");
			return false;
		}

		if (fn_trim(gcem_depart.text) == "") {
			alert("최근방북일은 필수조건 입니다.");
			return false;
		}

		if (fn_trim(gcem_ns_plan.text) == "") {
			alert("출국예정일은 필수조건 입니다.");
			return false;
		}

		if (gcra_caryn.CodeValue == null || gcra_caryn.CodeValue == "") {
			alert("차량여부를 입력하셔야 합니다.");
			return false;
		}

		return true;
	}
	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
     ln_ExcelQuery();

		 SetTitle("사업자 출국신청");
		 if (gcds_back.countrow<1) { alert("해당날짜에 맞는 내용이 없습니다"); gcem_acdate_fr.focus();
		 } else {gcgd_back.GridToExcel("사업자 출국신청 ","C:\\Temp\\사업자출국신청.xls",2);}
	}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"   VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="UseChangeInfo"    value="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_back classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<script language="javascript" for="gcds_data_1" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_1" event="onloadCompleted(row,colid)">
	gn_LoadComp('1',gcds_data_1.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_acdate_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language="javascript"  for=gcgd_disp event=OnClick(Row,Colid)>
	var str1 = gcds_data_1.namevalue(gcds_data_1.rowposition,"CUST_SID");

	gcds_data_2.DataID = "/services/servlet/sales.bm.bm026i_s02?v_str1="+str1;
	gcds_data_2.Reset();

	gcem_rsv_sid.text	 =	 gcds_data_2.namevalue(gcds_data_2.rowposition,"T1_RSV_SID");
	gcem_depart.text	=	gcds_data_2.namevalue(gcds_data_2.rowposition,"ARRIVE_DATE");
	gcem_ns_plan.text	=	gcds_data_2.namevalue(gcds_data_2.rowposition,"NS_PLAN");
	gcem_sn_plan.text	=	gcds_data_2.namevalue(gcds_data_2.rowposition,"SN_PLAN");
	gcra_caryn.codevalue	=	gcds_data_2.namevalue(gcds_data_2.rowposition,"CAR_YN");
	txt_bigo.value	 =	 gcds_data_2.namevalue(gcds_data_2.rowposition,"BIGO");

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
			<img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="ln_Save()">
			<img src="/services/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="ln_Excel()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">성&nbsp;&nbsp;&nbsp;명</td>
					<td class="tab_b0100" style="width:100px;">
            <input id="txt_cdname_fr" type="text" class="txt_a01" style="width:72px" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);">
					</td>
					<td class="tab_a0100">날&nbsp;&nbsp;&nbsp;&nbsp;짜</td>
					<td class="tab_b0000">
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
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr','Text', '400', '260');">
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td>
      <table width="425" cellpadding="0" cellspacing="0" border="0">	 <!--		3//-->
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:420px;height:410px;" viewastext>
							<param name="DataID"				value="gcds_data_1">
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
								<F> Name='No.'				ID={CURROW} 	 HeadAlign=Center HeadBgColor=#EEEEEE Width=30	align=center show=false</F>
								<C> Name='소속회사'   	ID=VEND_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=left   suppress=1</C> 
								<C> Name='CUST_SID'   	ID=CUST_SID	 HeadAlign=Center HeadBgColor=#EEEEEE Width=85	align=center show=false</C> 
								<C> Name='팀명'	        ID=TEAM_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=left </C> 
								<C> Name='사업자번호'	  ID=WORK_NO	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center </C> 
								<C> Name='성명'	        ID=CUST_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center </C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:420px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>

						<!-- 엑셀 -->
						<comment id="__NSID__"><OBJECT class="tab_b0110" id=gcgd_back classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:500px;height:352px;display:none" viewastext>
						<param name="DataID"				value="gcds_back">
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
						    <F> Name='No.'				ID={CURROW} 	 HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
                <C> Name='소속회사'   	ID=VEND_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	  align=left suppress=1</C> 
                <C> Name='팀명'       	ID=TEAM_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	  align=left </C> 
                <C> Name='사업자번호'  	ID=WORK_NO	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	  align=center </C> 
                <C> Name='성명'   	    ID=CUST_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=65	  align=center </C> 
                <C> Name='입국날짜'   	ID=DEPART_DATE	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center Mask='XXXX/XX/XX'</C> 
                <C> Name='입국시간'   	ID=DEPART_TIME	 HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center mask='XX:XX'</C> 
                <C> Name='방문기간'   	ID=ARRIVE_DATE	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center Mask='XXXX/XX/XX'</C> 
                <C> Name='방문시간'   	ID=ARRIVE_TIME	 HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center mask='XX:XX'</C> 
                <C> Name='출국예정일'   ID=NS_PLAN	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	  align=center Mask='XXXX/XX/XX'</C> 
                <C> Name='입국예정일'   ID=SN_PLAN	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	  align=center Mask='XXXX/XX/XX'</C> 
                <C> Name='차량유무'   	ID=CAR_YN	   HeadAlign=Center HeadBgColor=#EEEEEE Width=55	  align=center </C> 
                <C> Name='비고'   	    ID=BIGO	     HeadAlign=Center HeadBgColor=#EEEEEE Width=120	  align=left </C> 
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
        </tr>
      </table>
    </td>
		<td>	
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:450px;'>
		    <tr>
					<td class="tab_a0101">최근방북일</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:67px;">
						<comment id="__NSID__"><OBJECT id=gcem_depart classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
						<comment id="__NSID__"><OBJECT id=gcem_rsv_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_00" style="width:62px;">	<!--TRV020.RSV_SID//-->
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>							
				</tr> 
		    <tr>
					<td class="tab_a0101">출국예정일</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:67px;">
						<comment id="__NSID__"><OBJECT id=gcem_ns_plan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
 						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_ns_plan','Text', '600', '310');">					
					</td>							
				</tr> 
		    <tr>
					<td class="tab_a0101">입국예정일</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:67px;">
						<comment id="__NSID__"><OBJECT id=gcem_sn_plan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
 						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_sn_plan','Text', '600', '335');">
					</td>							
				</tr> 
		    <tr>
					<td class="tab_a0101">차량&nbsp;&nbsp;여부</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><object id=gcra_caryn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:30; width:150">
							<param name=Cols	      value="2">
							<param name= CodeValue  value="N">
							<param name=AutoMargin	value="true">
							<param name=Format	value="Y^예,N^아니오">			
						</object></comment><script>__ws__(__NSID__);</script>	
					</td>							
				</tr> 
		    <tr>
					<td class="tab_a0101">비&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;고</td>
					<td class="tab_b0001">
						<textarea id="txt_bigo" class="txt_a01"  style= "width:200px; height:71px; overflow:auto;position:relative;left:4px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
					</td>							
				</tr> 
   		  <tr>
					<td class="tab_b0000" colspan=4 style="height:244px;">&nbsp;
					</td>		
				</tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data_002>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=DEPART_DATE   Ctrl=gcem_depart	    Param=Text</C>
		<C>Col=NS_PLAN       Ctrl=gcem_ns_plan	  Param=Text</C>
		<C>Col=SN_PLAN       Ctrl=gcem_sn_plan	  Param=Text</C>
		<C>Col=CAR_YN        Ctrl=gcra_caryn	    Param=CodeValue</C>
		<C>Col=BIGO          Ctrl=txt_bigo	      Param=Value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
