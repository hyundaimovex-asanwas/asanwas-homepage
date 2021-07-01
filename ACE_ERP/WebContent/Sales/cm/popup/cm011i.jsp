<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	차량번호 관리
+ 프로그램 ID	: cm011i.jsp
+ 기 능 정 의	: 조회|등록|저장
+ 변 경 이 력	: 김병진
+ 작 성 일 자   : 2007.12.03
+ 수 정 일 자   : 2007.12.06
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<html>
<head> 
<jsp:include page="/Sales/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../Common/js/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
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
		ln_before();//선조회
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

/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){
	//아무것도 없는 데이터 불러오기 위해 파라미터(zzzzz) 설정
	gcds_data01.DataID = "/services/servlet/sales.cm.cm011i_s01?"
											 + "v_str1=zzzzz";
	gcds_data01.Reset();
//

}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query() {
	gcds_data01.DataID = "/services/servlet/sales.cm.cm011i_s01?"
											 + "v_str1="+fn_trim(gcem_carnum.value);
//											 + "&v_str2="+fn_trim(gcem_cardnum.value);

	gcds_data01.Reset();
	}

	/******************************************************************************
		Description : 추가
	******************************************************************************/
	function ln_Add(){
	  gcds_data02.addrow();

	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
//		ln_Query();
	}

	/******************************************************************************
		Description : 삭제
	******************************************************************************/
	function ln_Delete(){

	}

	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
	}

	/******************************************************************************
		Description : 부서정보
	******************************************************************************/
	function ln_SrhBuse(){

	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

	}
	
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
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--
<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="false"></object>
<!--값체크--
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
//-->
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
	gn_LoadComp('1',gcds_data.countrow);
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
<!-- 			<img src="../../Sales/images/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
      <img src="../../Sales/images/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel()"> -->
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">차량번호</td>
					<td class="tab_b0100" style='width:180px'>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_carnum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0100">차대번호</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_cardnum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
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
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:405px;height:190px;" viewastext>
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
								<C> Name='차량SID'		ID=CAR_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='차량번호'		ID=CAR_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C> 
								<C> Name='차대번호'	  	ID=CAR_DNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C> 
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
					<td class="tab_a0101">차량번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="####################">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">차대번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_dno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="####################">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">현지번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_rno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
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
				  <td class="tab_a0101">시작일자</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_use_sdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;					
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">종료일자</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_use_edate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
					</td>		
				</tr>

		    <tr>

				  <td class="tab_a0101">채류구분</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><object id=gcra_stay_ls classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
								<param name=Cols     value="3">
								<param name=CodeValue  value="0">
								<param name=Enable  value="False">
								<param name=Format   value="0^장기,1^단기">
						</object></comment><script>__ws__(__NSID__);</script>					
					</td>		

				</tr>
				<tr>
				<td class="tab_b0000" style='height:50px' colspan=2>&nbsp;&nbsp;1:아산, 2:대화, 3:푸드, 7:관광공사, 8:공사현장용(운행제한차량), <br>&nbsp;&nbsp; 9, 10, 11: 온천장, 금강산 호텔 운행</td></tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__">
							<OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:200px;" viewastext>
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
								<F> Name='No.'							ID={CURROW} 		HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='차량현지번호SID'		ID=CARNO_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='차량SID'					ID=CAR_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='차량번호'					ID=CAR_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='차대번호'				  	ID=CAR_DNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='현지번호'					ID=CAR_RNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='사용시작일'				ID=USE_SDATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='사용종료일'				ID=USE_EDATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='소속'							ID=VEND_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								">
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
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
	<param name=DataID				value=gcds_data_1>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=CUST_SID   Ctrl=gcem_cust_sid	Param=text</C>
		<C>Col=VEND_NM    Ctrl=txt_vend_nm	  Param=value</C>
		<C>Col=OP         Ctrl=gcra_op	      Param=CodeValue</C>
		<C>Col=REC_PLAC   Ctrl=txt_rec_plac	  Param=value</C>
		<C>Col=TEL_NUM    Ctrl=txt_tel_num	  Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__">
<object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data_2>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=CT        Ctrl=gcra_ct	       Param=CodeValue</C>
		<C>Col=WORK_NO   Ctrl=txt_work_no	   Param=value</C>
		<C>Col=TEL_SID   Ctrl=txt_tel_sid	   Param=value</C>
		<C>Col=TEL_DATE  Ctrl=gcem_tel_date	 Param=text</C>
		<C>Col=TEL_STIME Ctrl=gcem_tel_stime Param=text</C>
		<C>Col=TEL_ETIME Ctrl=gcem_tel_etime Param=text</C>
		<C>Col=TEL_DURA  Ctrl=gcem_tel_dura	 Param=text</C>
		<C>Col=UP_SID    Ctrl=txt_up_sid	   Param=value</C>
		<C>Col=CAL_YN    Ctrl=gcra_cal_yn	   Param=CodeValue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

</body>
</html>