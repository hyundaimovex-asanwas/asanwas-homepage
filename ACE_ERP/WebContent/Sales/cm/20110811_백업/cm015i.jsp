<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 수리 관리
+ 프로그램 ID	: cm015i.jsp
+ 기 능 정 의	: 조회|등록|저장
+ 변 경 이 력	: KBJ
+ 작 성 일 자   : 2008.01.19
+ 수 정 일 자   : 2008.01.21
+ 서 블 릿 명	: cm015i_s02, cm015i_t01, cm015i_s03
------------------------------------------------------------------------------>
<html>
<head>
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
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
//		fnInit();               //초기화 함수
	}

	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function fnInit(){
		//*****  페이지 초기화 함수는 여기에..  ********
		cfStyleGrid(getObjectFirst("gr1"), "comn");	//그리드에 스타일 적용하는 부분. 1줄="comn";2줄="comn1"
		window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //브라우저 상태창 수정.
		//window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		//window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	}
	/******************************************************************************
		Description : 차량조회
	******************************************************************************/
	function ln_SearchCar(){
		gcem_carno_sid.text = "";
		gcem_1.text = "";
		var strURL = "cm015i_r.jsp";
		var strPos = "dialogWidth:670px;dialogHeight:320px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

		gcem_carno_sid.text = firstList[0];
		gcem_1.text = firstList[1];

		ln_Query();
	}

	/******************************************************************************
		Description : 의뢰자	:	남쪽 직원이 직접하는 게 좋지 않나요?
	******************************************************************************/
	function ln_Cust(){
		gcem_cust_sid.text = "";
		gcem_cust_nm.text = "";
		var strURL = "/services/Sales/bm/bm062i_r.html";
		var strPos = "dialogWidth:515px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

	    gcem_cust_sid.text = firstList[0];
	    gcem_cust_nm.text = firstList[4];

		var row = gcds_data02.rowposition;
		if(row > 0){
			gcds_data02.NameValue(row, "CUST_SID") = fn_trim(gcem_cust_sid.text);
		}

	}
	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query() {
		if(fn_trim(gcem_1.text) == ""){
			alert("차량번호 선택 후 조회 가능 합니다.");
			return;
		}

		gcds_data02.DataID = "/services/servlet/sales.cm.cm015i_s02?"
												 + "&v_str1=" + fn_trim(gcem_carno_sid.text);
		gcds_data02.Reset();
		var row = gcds_data02.rowposition;
		gcem_cust_sid.text = gcds_data02.NameValue(row, "CUST_SID");
		gcem_cust_nm.text = gcds_data02.NameValue(row, "CUST_NM");
	}

	/******************************************************************************
		Description : 추가
	******************************************************************************/
	function ln_Add(){
		if(fn_trim(gcem_1.text) == ""){
			alert("차량번호 선택 후 추가가 가능 합니다.");
			return;
		}
		if(fn_trim(gcem_cust_sid.text) == ""){
			alert("의뢰자 선택 후 추가가 가능 합니다.");
			return;
		}

		gcds_data02.addrow();
		var row = gcds_data02.rowposition;
		gcds_data02.NameValue(row, "CARNO_SID") = fn_trim(gcem_carno_sid.text);
		gcds_data02.NameValue(row, "CUST_SID") = fn_trim(gcem_cust_sid.text);
		//alert("::" + fn_trim(gcem_carno_sid.text) + "::");
		gcem_rr_date.focus();
	}
	/******************************************************************************
	//		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
		gcds_data03.DataID = "/services/servlet/sales.cm.cm015i_s03";
		//prompt('',gcds_data03.DataID);
		gcds_data03.Reset();

		 SetTitle("수리내역조회");
		 if (gcds_data03.countrow<1) { //alert("해당날짜에 맞는 내용이 없습니다"); 
		 } else {gcgd_disp.GridToExcel("수리내역조회","C:\\Test\\수리내역조회.xls",2);}
	}
	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
		if (!gcds_data02.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

		var row = gcds_data02.rowposition;
		//gv_date_check		fn_trim
		gctr_data.KeyValue = "cm015_t01(I:DATA=gcds_data02)";
	    gctr_data.Action = "/services/servlet/sales.cm.cm015i_t01";

		gctr_data.Parameters = "v_str1=" +  gcds_data02.namevalue(row,"REPAIR_SID") + ", v_str2=" + gusrid;
		//alert("::" + 	gcds_data02.NameValue(row, "CARNO_SID") + "::");
		gctr_data.post();
//		gcds_data02.Reset();	//상세 그리드 reset
	}


	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){
		if(fn_trim(gcem_rr_date.text) == ""){
			alert("수리 요청일을 입력해야 합니다.");
			return false;
		}
		if(fn_trim(gcem_wh_date.text) == ""){
			alert("수리 요청일을 입력해야 합니다.");
			return false;
		}
		if(fn_trim(gcem_rr_date.text) == ""){
			alert("입고일자를 입력해야 합니다.");
			return false;
		}
		if(gcra_calc_yn.CodeValue != 0 && gcra_calc_yn.CodeValue != 1){
			alert("정산여부를 입력해야 합니다.");
			return false;
		}

		return true;
	}
	
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
	<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
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
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
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
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/new.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Add()">
            <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Save()">
			<img src="/services/Sales/images/excel.gif"	style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onClick="ln_Excel()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0101">차량번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:80px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
								<param name=ReadOnly		value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SearchCar();">
						<comment id="__NSID__"><OBJECT id=gcem_carno_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
		    <tr>
					<td class="tab_a0101">의&nbsp;뢰&nbsp;자:</td>
					<td class="tab_b0101" style="width:200px">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_cust_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:80px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=ReadOnly		value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_Cust();">
						<comment id="__NSID__"><OBJECT id=gcem_cust_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>

					<td class="tab_a0111">수리요청일:</td>
					<td class="tab_b0011" colspan=3>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_rr_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:60px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=0>
								<param="DateModify"   value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td> 					
				</tr>
		    <tr>
				  <td class="tab_a0101">입고일자:</td>
					<td class="tab_b0101" style="width:200px">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_wh_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:60px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=0>
								<param="DateModify"   value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>
					<td class="tab_a0101">출고일자:</td>
					<td class="tab_b0001" colspan=3>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_owh_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:60px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=0>
								<param="DateModify"   value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td> 					
				</tr>
		    <tr>
					<td class="tab_a0101">수리사유:</td>
					<td class="tab_b0001" colspan=5>
						<fieldset class=field_01 style="width:250px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_cause classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:240px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>				
				</tr>
		    <tr>
					<td class="tab_a0101">수리요청1:</td>
					<td class="tab_b0001" colspan=5>
						<fieldset class=field_01 style="width:500px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_content1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:490px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=GeneralEdit   value="true">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td>				
				</tr>
		    <tr>
					<td class="tab_a0101">수리요청2:</td>
					<td class="tab_b0001" colspan=5>
						<fieldset class=field_01 style="width:500px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_content2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:490px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>				
				</tr>
		    <tr>
					<td class="tab_a0101">수리요청3:</td>
					<td class="tab_b0001" colspan=5>
						<fieldset class=field_01 style="width:500px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_content3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:490px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>				
				</tr>
		    <tr>
					<td class="tab_a0101">수리요청4:</td>
					<td class="tab_b0001" colspan=5>
						<fieldset class=field_01 style="width:500px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_content4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:490px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>				
				</tr>
		    <tr>
					<td class="tab_a0101">수리요청5:</td>
					<td class="tab_b0001" colspan=5>
						<fieldset class=field_01 style="width:500px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_content5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:490px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>				
				</tr>
		    <tr>
					<td class="tab_a0100">수리비용:</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_repair_fee classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment		value=2>
								<param name=Border	      value=false>
								<param name=Numeric       value="true">
								<param name=IsComma       value=true>
								<param name=MaxLength     value=4>
								<param name=SelectAll     value=true>
								<param name=MaxDecimalPlace   value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>		
					</td>				
					<td class="tab_a0100">정산여부</td>
					<td class="tab_b0000">
						<comment id="__NSID__"><object id=gcra_calc_yn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:24;width:150;cursor:hand;">
								<param name=Cols     value="2">
								<param name=CodeValue  value="1">
								<param name=Format   value="0^정산,1^미정산">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:200px;" viewastext>
							<param name="DataID"				value="gcds_data02">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="Editable"      value="false">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'					ID={CURROW} 					HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='수리이력'			ID=REPAIR_SID					HeadAlign=Center HeadBgColor=#EEEEEE Width=0	show=false edit=none</C> 
								<C> Name='CARNO_SID'		ID=CARNO_SID					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=false</C> 
								<C> Name='의뢰자'				ID=CUST_SID					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=false</C> 
								<C> Name='수리요청일'		ID=RR_DATE						HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='입고일자'	    	ID=WH_DATE						HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='출고일자'			ID=OWH_DATE					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='수리비용'			ID=REPAIR_FEE					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
								<C> Name='수리사유'		    ID=REPAIR_CAUSE				HeadAlign=Center HeadBgColor=#EEEEEE Width=330	align=center</C> 
								<C> Name='수리요청1'	    ID=REPAIR_CONTENT1		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청2'	    ID=REPAIR_CONTENT2		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청3'	    ID=REPAIR_CONTENT3		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청4'	    ID=REPAIR_CONTENT4		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청5'	    ID=REPAIR_CONTENT5		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='정산여부'			ID=CALC_YN						HeadAlign=Center HeadBgColor=#EEEEEE Width=80 EditStyle=Combo Data='0:정산,1:비정산'</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:878px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:0px;height:0px;" viewastext>
							<param name="DataID"				value="gcds_data03">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="Editable"      value="false">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'					ID={CURROW} 					HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='수리이력'			ID=REPAIR_SID					HeadAlign=Center HeadBgColor=#EEEEEE Width=0	show=false edit=none</C> 
								<C> Name='CARNO_SID'		ID=CARNO_SID					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=false</C> 
								<C> Name='의뢰자'				ID=CUST_SID					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=false</C> 
								<C> Name='수리요청일'		ID=RR_DATE						HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='입고일자'	    	ID=WH_DATE						HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='출고일자'			ID=OWH_DATE					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='수리비용'			ID=REPAIR_FEE					HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
								<C> Name='수리사유'		    ID=REPAIR_CAUSE				HeadAlign=Center HeadBgColor=#EEEEEE Width=305	align=center</C> 
								<C> Name='수리요청1'	    ID=REPAIR_CONTENT1		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청2'	    ID=REPAIR_CONTENT2		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청3'	    ID=REPAIR_CONTENT3		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청4'	    ID=REPAIR_CONTENT4		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='수리요청5'	    ID=REPAIR_CONTENT5		HeadAlign=Center HeadBgColor=#EEEEEE Width=0 show=false</C> 
								<C> Name='정산여부'			ID=CALC_YN						HeadAlign=Center HeadBgColor=#EEEEEE Width=60 EditStyle=Combo Data='0:정산,1:비정산'</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<comment id="__NSID__">
<object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data02>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=RR_DATE					Ctrl=gcem_rr_date				Param=text</C>
		<C>Col=WH_DATE				    Ctrl=gcem_wh_date			Param=text</C>
		<C>Col=OWH_DATE				Ctrl=gcem_owh_date				Param=text</C>
		<C>Col=REPAIR_FEE				Ctrl=gcem_repair_fee			Param=text</C>
		<C>Col=REPAIR_CAUSE			Ctrl=gcem_repair_cause				Param=text</C>
		<C>Col=REPAIR_CONTENT1   Ctrl=gcem_repair_content1			Param=text</C>
		<C>Col=REPAIR_CONTENT2	Ctrl=gcem_repair_content2				Param=text</C>
		<C>Col=REPAIR_CONTENT3   Ctrl=gcem_repair_content3			Param=text</C>
		<C>Col=REPAIR_CONTENT4   Ctrl=gcem_repair_content4			Param=text</C>
		<C>Col=REPAIR_CONTENT5   Ctrl=gcem_repair_content5			Param=text</C>
		<C>Col=CALC_YN					Ctrl=gcra_calc_yn			Param=CodeValue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>