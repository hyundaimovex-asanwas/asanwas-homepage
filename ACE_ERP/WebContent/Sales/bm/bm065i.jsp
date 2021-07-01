<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	협력업체관리
+ 프로그램 ID	: bm065i.jsp
+ 기 능 정 의	: 조회|등록|저장|
+ 변 경 이 력	: KBJ 20080124
+ 서 블 릿 명	: 
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

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);
		var sdata = "/services/servlet/sales.bm.bm065i_s01"
							+ "?v_str1=0";
		gcds_data.DataID = sdata; 
		gcds_data.Reset();
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

//		if(fn_trim(gcem_vend_cd_fr.text) =="" && fn_trim(txt_vend_nm_fr.value) == "" && fn_trim(gcem_vend_id_fr.text) == ""){
//			alert("조회 조건이 하나 이상 존재해야 합니다.");
//			return false;
//		}

		var sdata = "/services/servlet/sales.bm.bm065i_s01"
							+ "?v_str1=" + fn_trim(gcem_vend_cd_fr.text)   //거래처코드
							+ "&v_str2=" + fn_trim(txt_vend_nm_fr.value);   //거래처명
//							+ "&v_str3=" + fn_trim(gcem_vend_id_fr.text);  //등록번호

		gcds_data.DataID = sdata; 
		//prompt("gcds_data::",gcds_data.DataID);
		gcds_data.Reset();
	}

	/******************************************************************************
		Description : 팝업(협력업체관리 팝업)
	******************************************************************************/
	function ln_Pop(){
		//var strURL = "../popup/bm065i_r.html";
		var strURL = "bm065i_r.html";
		var strPos = "dialogWidth:515px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

		gcds_data.addrow();

		txt_h_vend_cd.value      = firstList[0]; 
		txt_h_vend_id.value      = firstList[1]; 
		txt_h_vend_nm.value      = firstList[2]; 
		txt_h_vd_direct.value    = firstList[3]; 
		txt_h_bsns_cnd.value     = firstList[4]; 
		txt_h_bsns_knd.value     = firstList[5]; 
		txt_h_vd_telno.value     = firstList[6]; 
		txt_h_vd_faxno.value     = firstList[7]; 
		txt_h_postno.value       = firstList[8]; 
		txt_h_address1.value     = firstList[9]; 
		txt_h_address2.value     = firstList[10]; 
		txt_h_local_mgr.value    = firstList[11]; 
		txt_h_local_staff.value  = firstList[12]; 
		txt_h_local_gu.value     = firstList[13]; 
		gcra_local_gu.CodeValue = firstList[13];
		txt_h_local_tel.value    = firstList[14]; 
		txt_h_local_fax.value    = firstList[15]; 
		txt_h_vend_sid.value    = firstList[16]; 

		gcds_data.namevalue(gcds_data.rowposition, "VEND_CD")     =  txt_h_vend_cd.value
		gcds_data.namevalue(gcds_data.rowposition, "VEND_ID")     =  txt_h_vend_id.value
		gcds_data.namevalue(gcds_data.rowposition, "CLIENT_NM")     =  txt_h_vend_nm.value
		gcds_data.namevalue(gcds_data.rowposition, "CLIENT_DAM_NM")   =  txt_h_vd_direct.value
		gcds_data.namevalue(gcds_data.rowposition, "BSNS_CND")    =  txt_h_bsns_cnd.value
		gcds_data.namevalue(gcds_data.rowposition, "BSNS_KND")    =  txt_h_bsns_knd.value
		gcds_data.namevalue(gcds_data.rowposition, "VD_TELNO")    =  txt_h_vd_telno.value
		gcds_data.namevalue(gcds_data.rowposition, "VD_FAXNO")    =  txt_h_vd_faxno.value
		gcds_data.namevalue(gcds_data.rowposition, "POSTNO")      =  txt_h_postno.value
		gcds_data.namevalue(gcds_data.rowposition, "ADDRESS1")    =  txt_h_address1.value
		gcds_data.namevalue(gcds_data.rowposition, "ADDRESS2")    =  txt_h_address2.value
		gcds_data.namevalue(gcds_data.rowposition, "LOCAL_MGR")   =  txt_h_local_mgr.value
		gcds_data.namevalue(gcds_data.rowposition, "LOCAL_STAFF") =  txt_h_local_staff.value

		gcds_data.namevalue(gcds_data.rowposition, "LOCAL_GU")    =  txt_h_local_gu.value

		gcds_data.namevalue(gcds_data.rowposition, "LOCAL_TEL")   =  txt_h_local_tel.value
		gcds_data.namevalue(gcds_data.rowposition, "LOCAL_FAX")   =  txt_h_local_fax.value
		gcds_data.namevalue(gcds_data.rowposition, "VEND_SID")     =  txt_h_vend_sid.value;
	}

	/******************************************************************************
		Description : 추가
	******************************************************************************/
	function ln_Add(){
		var row = gcds_data.rowposition;
//		if (row<1){alert("조회후 등록하세요");return;}

    ln_Pop();

	}

/******************************************************************************
	Description : 주소 조회
******************************************************************************/
function ln_Popup(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/common/html/com_zipcd.html";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_czipcd.text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		txt_address1.value = val;
	}
}

	/******************************************************************************
		Description : 소속사
	******************************************************************************/
	function ln_SrhCust(){
		var strURL = "/common/html/cust_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_cscode.text = firstList[0];
		txt_cscdnm.value = firstList[1];
	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

		if (txt_h_vend_sid.value == "") {
			alert("회사코드 참조 오류");
			//gcem_vend_id.focus();
			return false;
		} 
		
		if (gcra_local_gu.CodeValue == null || gcra_local_gu.CodeValue == "") {
			alert("지역구분을 입력하셔야 합니다.");
			return false;
		}

		if (txt_h_vend_sid.value == 0) {
			alert("VEND_SID = 0");
			return false;
		}
/*
		//키값중복체크
		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="1"){
				gcds_chk.DataID = "/services/servlet/sales.bm.bm065i_chk_s01?v_str1="+txt_h_vend_id.value;
				gcds_chk.Reset();

				if(txt_h_vend_id.value != "" && gcds_chk.namevalue(1,"VEND_ID") != 0){
					alert("동일한 사업자번호가 있습니다.확인후 입력하세요");
					//gcds_data.namevalue(row,"VEND_ID") = "";
					gcds_data.deleterow(row);
					return;
				}				
		}
*/
		return true;
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

    gctr_data.KeyValue = "bm065i_t01(I:DATA=gcds_data)";
    gctr_data.Action = "/services/servlet/sales.bm.bm065i_t01";
							+ "?v_str1=" + gusrid;
		gctr_data.post();

		ln_Query();
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
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_vend_cd_fr event=OnKeyUp(kcode,scode)>
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<input id="txt_h_vend_cd"     type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_vend_id"     type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_vend_nm"     type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_vd_direct"   type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_bsns_cnd"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_bsns_knd"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_vd_telno"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_vd_faxno"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_postno"      type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_address1"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_address2"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_local_mgr"   type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_local_staff" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_local_gu"    type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_local_tel"   type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_h_local_fax"   type="hidden" class="txt_a01"  style="width:70px;">  
<input id="txt_h_vend_sid"   type="hidden" class="txt_a01"  style="width:70px;">  

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/plus.gif"	style="cursor:hand" align=absmiddle onClick="ln_Add()">
			<img src="/services/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">거래처코드</td>
					<td class="tab_b0100" style='width:180px'>
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_cd_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:87px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#############">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=0>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>		
					</td>	
					<td class="tab_a0100">거래처명</td>
					<td class="tab_b0100">
            <input id="txt_vend_nm_fr" type="text" class="txt_a01"  style="width:120px;"  onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 				
					</td>	
	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td>
      <table width="395" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:385px;height:430px;" viewastext>
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
								<F> Name='No.'				ID={CURROW} 	 HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
								<C> Name='아이디'   	ID=COOP_SID		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='거래처코드'	ID=VEND_CD		 HeadAlign=Center HeadBgColor=#EEEEEE Width=85	align=center sort=true</C> 
								<C> Name='사업자번호'	ID=VEND_ID		 HeadAlign=Center HeadBgColor=#EEEEEE Width=90	align=center mask='XXX-XX-XXXXX'</C> 
								<C> Name='거래처명'	  ID=CLIENT_NM	   HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=left </C> 
								<C> Name='대표자명'		ID=CLIENT_DAM_NM	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='업태'		    ID=BSNS_CND		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='업종'		    ID=BSNS_KND		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='전화번호'		ID=VD_TELNO		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='팩스번호'		ID=VD_FAXNO		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='우편번호'  	ID=POSTNO		   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='주소1'	    ID=ADDRESS1		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='주소2'		  ID=ADDRESS2		 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='현지책임자'	ID=LOCAL_MGR	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='현지담당자'	ID=LOCAL_STAFF HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='지역'   		ID=LOCAL_GU		 HeadAlign=Center HeadBgColor=#EEEEEE Width=65	align=center editstyle=combo data='K:금강산,G:개성'</C> 
								<C> Name='현지전화번호'	ID=LOCAL_TEL HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='현지팩스'	  ID=LOCAL_FAX	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='VEND_SID'	  ID=VEND_SID	     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C>
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:386px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
		<td>	
			<table class="tab_b1111" border="0" cellpadding="0" cellspacing="0" style='width:482px;'>
		    <tr>
					<td class="tab_a0101">거래처코드</td>
					<td class="tab_b0101">
						<fieldset class=field_01 style="width:80px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:72px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#############">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=0>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td>	
					<td class="tab_a0101">사업자번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_a_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="###-##-#####">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">거래처명</td>
					<td class="tab_b0001" colspan=3>
            <input id="txt_vend_nm" type="text" class="txt_a01"  style="width:80px;" disabled>		
					</td>							
				</tr>
 		    <tr>
					<td class="tab_a0101">대표자명</td>
					<td class="tab_b0001" colspan=3>
            <input id="txt_vd_direct" type="text" class="txt_a01"  style="width:80px;" disabled>			
					</td>							
				</tr>
 		    <tr>
				  <td class="tab_a0101">업&nbsp;&nbsp;&nbsp;&nbsp;태</td>
					<td class="tab_b0101">
            <input id="txt_bsns_cnd" type="text" class="txt_a01"  style="width:80px;" disabled>
					</td>		
					<td class="tab_a0101">업&nbsp;&nbsp;&nbsp;&nbsp;종</td>
					<td class="tab_b0001">
            <input id="txt_bsns_knd" type="text" class="txt_a01"  style="width:150px;" disabled>
					</td>	
				</tr>
 		    <tr>
				  <td class="tab_a0101">전화번호</td>
					<td class="tab_b0101">
            <input id="txt_vd_telno" type="text" class="txt_a01"  style="width:80px;" disabled>
					</td>		
					<td class="tab_a0101">팩스번호</td>
					<td class="tab_b0001">
            <input id="txt_vd_faxno" type="text" class="txt_a01"  style="width:80px;" disabled>
					</td>	
				</tr>
 		    <tr>
				  <td class="tab_a0101">우편번호</td>
					<td class="tab_b0001" colspan=3>
						<fieldset class=field_01 style="width:50px;">
						<comment id="__NSID__"><OBJECT id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  class="gcem_01"
							style="width:47px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000-000">
								<param name=Enable	      value="false">
								<param name=PromptChar	  value="_">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
<!-- 						<img alt=우편번호조회  id='img_search1' name='img_search1' style="position:relative;left:4px;top:3px;cursor:hand" src='../common/img/btn/com_b_search.gif'  onclick=""> -->
          </td>
				</tr>
 		    <tr>
				  <td class="tab_a0101">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
					<td class="tab_b0001" colspan=3>
					  <input id="txt_address1" type="text" class="txt_a01"  style="position:relative;left:8px;top:-2px;cursor:hand;width:300px;" disabled>
            <input id="txt_address2" type="hidden" class="txt_a01"  style="width:235px;" disabled>		
					</td>		
				</tr>
 		    <tr>
				  <td class="tab_a0101">현지책임자</td>
					<td class="tab_b0101">
            <input id="txt_local_mgr" type="text" class="txt_a01"  style="width:80px;" maxlength=15>
					</td>		
					<td class="tab_a0101">현지담당자</td>
					<td class="tab_b0001">
            <input id="txt_local_staff" type="text" class="txt_a01"  style="width:80px;" maxlength=15>
					</td>	
				</tr>
 		    <tr>
				  <td class="tab_a0101">지역구분</td>
					<td class="tab_b0001" colspan=3>
						<comment id="__NSID__"><object id=gcra_local_gu classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:30; width:150">
							<param name=Cols	value="2">
							<param name=AutoMargin	value="true">
							<param name=Format	value="K^금강산,G^개성">			
						</object></comment><script>__ws__(__NSID__);</script>						
					</td>		
				</tr> 
 		    <tr>
				  <td class="tab_a0101">현지전화번호</td>
					<td class="tab_b0101">
            <input id="txt_local_tel" type="text" class="txt_a01"  style="width:80px;" maxlength=15>
					</td>		
					<td class="tab_a0101">현지팩스</td>
					<td class="tab_b0001">
            <input id="txt_local_fax" type="text" class="txt_a01"  style="width:80px;" maxlength=15>			
					</td>	
				</tr>
   		  <tr>
					<td class="tab_b0000" colspan=4 style="height:168px;">&nbsp;
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
	<param name=DataID				value=gcds_data>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=VEND_CD     Ctrl=gcem_vend_cd	   Param=Text</C>
		<C>Col=VEND_ID     Ctrl=gcem_a_vend_id	 Param=Text</C>
		<C>Col=CLIENT_NM     Ctrl=txt_vend_nm	     Param=Value</C>
		<C>Col=CLIENT_DAM_NM   Ctrl=txt_vd_direct	   Param=Value</C>
		<C>Col=BSNS_CND    Ctrl=txt_bsns_cnd	   Param=Value</C>
		<C>Col=BSNS_KND    Ctrl=txt_bsns_knd	   Param=Value</C>
		<C>Col=VD_TELNO    Ctrl=txt_vd_telno	   Param=Value</C>
		<C>Col=VD_FAXNO    Ctrl=txt_vd_faxno	   Param=Value</C>
		<C>Col=POSTNO      Ctrl=gcem_czipcd	     Param=Text</C>
		<C>Col=ADDRESS1    Ctrl=txt_address1	   Param=Value</C>
		<C>Col=ADDRESS2    Ctrl=txt_address2	   Param=Value</C>
		<C>Col=LOCAL_MGR   Ctrl=txt_local_mgr   Param=Value</C>
		<C>Col=LOCAL_STAFF Ctrl=txt_local_staff	 Param=Value</C>
		<C>Col=LOCAL_GU    Ctrl=gcra_local_gu	   Param=CodeValue</C>
		<C>Col=LOCAL_TEL   Ctrl=txt_local_tel	   Param=Value</C>
		<C>Col=LOCAL_FAX   Ctrl=txt_local_fax	   Param=Value</C>
		<C>Col=VEND_SID   Ctrl=txt_h_vend_sid	   Param=Value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
