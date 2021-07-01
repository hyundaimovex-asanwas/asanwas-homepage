<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	사고관리
+ 프로그램 ID	: cm013i.jsp
+ 기 능 정 의	: 조회|등록|저장
+ 변 경 이 력	: KBJ
+ 작 성 일 자   : 2008.01.16
+ 수 정 일 자   : 2008.01.16
+ 서 블 릿 명	: cm012i_s01,cm012i_s02, cm012i_s03, cm012i_t01
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
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
//		ln_before();//선조회
		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
	}

	/*----------------------------------------------------------------------------
		Description : 선조회 조건
	----------------------------------------------------------------------------*/
	function ln_before(){
	//아무것도 없는 데이터 불러오기 위해 파라미터(zzzzz) 설정
//		gcds_data01.DataID = "/services/servlet/sales.cm.cm012i_s01?"
//										 + "v_str1=zzzzz";
//		gcds_data01.Reset();

//		gcds_data03.DataID = "/services/servlet/sales.cm.cm012i_s03";
//		gcds_data03.Reset();
//		gcem_ounit.text = gcds_data03.NameValue(1, "DETAIL_NM");
	}
	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query() {

	}

	/******************************************************************************
		Description : 추가
	******************************************************************************/
	function ln_Add(){
	  gcds_data.addrow();

	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
		ln_Query();
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
<comment id="__NSID__">
<!-- master data -->
<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="false"></object>
<!--값체크-->
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
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
    <td  align="right" style="padding-top:4px;" colspan=2>&nbsp;</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:402px;'>

		    <tr>
					<td class="tab_a0101">차량번호:</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
									<img src="../../Sales/images/com_b_query.gif"		style="position:relative;left:190px;top:2px;cursor:hand" onclick="ln_Query()">
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">차대번호:</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
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
				  <td class="tab_a0101">현지번호:</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
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
				<tr><td colspan=3 style="height:86px">&nbsp;</td></tr>
			</table>		
		</td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:470px;'>
		    <tr>
					<td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:468px;height:140px;" viewastext>
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
								<C> Name='차량번호'		ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=130	align=center</C> 
								<C> Name='차대번호'		ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=130	align=center</C> 
								<C> Name='현지번호'		ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=130	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:469px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>					
					</td>
				</tr>
			</table>	
		</td>
	</tr>
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=4>
			<img src="../../Sales/images/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()">
			<img src="../../Sales/images/com_b_save.gif"		style="cursor:hand"	onclick="ln_Save()">
 			<img src="../../Sales/images/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
      <!-- <img src="../../Sales/images/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel()"> -->
   </td>
	</tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:200px;" viewastext>
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
								<F> Name='No.'				ID={CURROW} 			HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center edit=false</F>
								<C> Name='사고이력'		ID=ACCI_SID				HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false edit=false</C> 
								<C> Name='사고일자'		ID=ACCI_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center mask='XXXX/XX/XXXX' edit=true</C> 
								<C> Name='시간'				ID=ACCI_TIME			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center mask='XX:XX' edit=true</C> 
								<C> Name='사고장소'		ID=ACCI_PLACE			HeadAlign=Center HeadBgColor=#EEEEEE Width=180	align=center edit=true</C> 
								<C> Name='운전자'			ID=WORK_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center edit=true</C> 
								<C> Name='사고내용'		ID=ACCI_CONTENT	HeadAlign=Center HeadBgColor=#EEEEEE Width=200	align=center edit=true</C> 
								<C> Name='조치사항'		ID=ACCI_FU				HeadAlign=Center HeadBgColor=#EEEEEE Width=200	align=center edit=true</C>  
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

</body>
</html>