<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	개인정보관리
+ 프로그램 ID	: bm010i.jsp
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: 
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


	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
			var sdata = "/services/servlet/sales.bm.bm011s_s01"
								+ "?v_str1=" + gcem_vend_id.text  //회사명
								+ "&v_str2=" + gcem_regi_no_fr.text  //주민/여권번호
								+ "&v_str3=" + txt_cust_nm_fr.value; //성명
			gcds_data.DataID = sdata; 
			gcds_data.Reset();
	}


	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
			if (gcds_data.countrow<1) alert(gn_Msg(4));
			else gn_Excel(gcgd_disp,"개인정보조회","","");
	}

	/******************************************************************************
		Description : 출력물
	******************************************************************************/
	function ln_Print(){
       alert("준비중입니다.");
	}

	/******************************************************************************
		Description : 소속사
	******************************************************************************/
	function ln_SrhCust(){
			var strURL   = "../common/html/Company_pop.html";
			var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
			var arrResult = showModalDialog(strURL,window,strPos);

			if (arrResult == -1 || arrResult == null || arrResult == "") return;
			var firstList = arrResult.split(";");
			gcem_vend_id.text = firstList[0];
			gcem_vend_nm_fr.text = firstList[1];
	}
	</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="ln_Excel()">
			<img src="/services/Sales/images/print.gif"	style="cursor:hand" align=absmiddle onclick="ln_Print()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">회&nbsp;사&nbsp;명</td>
					<td class="tab_b0100" style='width:150px'>
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=Enable        value=false>
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<comment id="__NSID__"><OBJECT id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=Visible        value=false>
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					  <img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhCust();">
					</td>	
					<td class="tab_a0100">주민/여권번호</td>
					<td class="tab_b0100"  style='width:160px'>
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_regi_no_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:97px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="">
								<param name=MaxLength   value="13">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
					<td class="tab_a0100">성&nbsp;&nbsp;&nbsp;명</td>
					<td class="tab_b0000">
				    <input id="txt_cust_nm_fr" type="text" class="txt_a01"  style="width:80px;" maxlength="29">	
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td colspan=2>
      <table width="395" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:875px;height:430px;" viewastext>
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
								<F> Name='No.'				  ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30	 align=center</F>
								<C> Name='소속회사코드'	ID=VEND_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center </C> 
								<C> Name='소속회사'	  	ID=VEND_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center</C> 
								<C> Name='팀코드'	  	  ID=TEAM_CD		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center show=false</C> 
								<C> Name='팀'	  	      ID=DETAIL_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center</C> 
								<C> Name='사업자번호'	  ID=WORK_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=100	 align=center</C> 
								<C> Name='성명'	        ID=CUST_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=65	 align=center</C> 
								<C> Name='주민/여권번호' ID=REGI_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=100 align=center</C> 
								<C> Name='자택전화'	    ID=TEL_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	 align=center</C> 
								<C> Name='비상전화'	  	ID=MOBILE_NO	HeadAlign=Center HeadBgColor=#EEEEEE Width=75	 align=center</C> 
								<C> Name='직위'	        ID=POSITIONS	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center</C> 
								<C> Name='주소1'	      ID=ADDRESS1		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=right show=false</C> 
								<C> Name='주소2'	      ID=ADDRESS2		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=right show=false</C> 
								<C> Name='주소'	        ID=ADDRESS		HeadAlign=Center HeadBgColor=#EEEEEE Width=150 align=right</C> 
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
  <tr><td height=3></td></tr>  
</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

