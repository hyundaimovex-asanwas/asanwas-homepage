<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	개인정보관리
+ 프로그램 ID	: bm010i.jsp
+ 기 능 정 의	: 조회|등록|저장|
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm010i_s01,bm010i_t01,bm010i_chk_s01
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
		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
		ln_Before();            //초기화 함수

		var sdata = "/services/servlet/sales.bm.bm010i_s01"
							+ "?v_str1=GG"
							+ "&v_str2="
							+ "&v_str3=GG";
							//+ "&v_str4=" + txt_cust_sid.value;
		gcds_data.DataID = sdata; 
		gcds_data.Reset();

	}

	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
		//국적구분fr
		gcds_cu009_fr.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU009&v_str2=Y";
		gcds_cu009_fr.Reset();

		gcds_cu009.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU009&v_str2=Y";
		gcds_cu009.Reset();
   
		//성별
		gcds_sy009.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=SY009";
		gcds_sy009.Reset();
    
		//고객구분
		gcds_cu001.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=SY001";
		gcds_cu001.Reset();

		//사업구분
		gcds_cu004.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU004";
		gcds_cu004.Reset();

		//고객유형
		gcds_rv003.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=RV003&v_str2=Y";
		gcds_rv003.Reset();

		//직군
		gcds_cu020.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU020&v_str2=Y";
		gcds_cu020.Reset();
	
		//민족
		gcds_sy005.DataID = "/services/servlet/sales.bm.bm_common_s02?v_str1=SY005&v_str2=100";
		gcds_sy005.Reset();
	}


	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
		var sdata = "/services/servlet/sales.bm.bm010i_s01"
							+ "?v_str1=" + gclx_sy005_fr.bindcolval
							+ "&v_str2=" + txt_cust_nm_fr.value
							+ "&v_str3=" + gcem_regi_no_fr.text;
							//+ "&v_str4=" + txt_cust_sid.value;
		gcds_data.DataID = sdata; 
		gcds_data.Reset();
	}


	/******************************************************************************
		Description : 팝업(개인정보관리 팝업)
	******************************************************************************/
	function ln_Pop(){
		var strURL = "bm010i_r.html";
		var strPos = "dialogWidth:515px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		txt_cust_sid.value  = firstList[0]; //CUST_SID
		txt_sy005.value     = firstList[1]; //국적구분
		txt_work_no.value   = firstList[2]; //실무번호
		txt_nm.value        = firstList[3]; //이름
		txt_regi_no.value   = firstList[4]; //주민/여권번호
		txt_birthday.value  = firstList[5]; //생년월일
		txt_sy009.value     = firstList[6]; //성별
		txt_cu001.value     = firstList[7]; //고객구분
		txt_cu004.value     = firstList[8]; //사업구분
		txt_rv003.value     = firstList[9]; //고객유형
		txt_last_nm.value   = firstList[10];//영문성
		txt_first_nm.value  = firstList[11];//영문성명
		txt_czipcd.value    = firstList[12];//우편번호
		txt_cu020.value     = firstList[13];//직군
		txt_address1.value  = firstList[14];//주소1
		txt_address2.value  = firstList[15];//주소2
		txt_tel_no.value    = firstList[16];//자택전화
		txt_mobile_no.value = firstList[17];//핸드폰
		txt_company_nm.value= firstList[18];//직장명
		txt_positions.value = firstList[19];//직위
		txt_gu_neme.value   = firstList[20];//국적
		txt_nation_cd.value = firstList[21];//민족

		ln_AddDetail();
	}


	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){
		//var row = gcds_data.rowposition;
		//if (row<1){alert("조회후 등록하세요");return;}

    //ln_Query();
    ln_Pop();
    //ln_AddDetail();
	}
	/******************************************************************************
		Description : 등록(세부)
	******************************************************************************/
	function ln_AddDetail(){
		//gcds_data.ClearData();
		gcds_data.addrow();
		gcds_data.namevalue(gcds_data.rowposition,"CUST_SID")        =  txt_cust_sid.value;//KEY
		gcds_data.namevalue(gcds_data.rowposition,"COUNTRY_GU")      =  txt_sy005.value;//국적구분
		gcds_data.namevalue(gcds_data.rowposition,"WORK_NO")         =  txt_work_no.value;//실무번호
		gcds_data.namevalue(gcds_data.rowposition,"CUST_NM")         =  txt_nm.value;////이름
		gcds_data.namevalue(gcds_data.rowposition,"MANAGE_NO")       =  txt_regi_no.value;//주민/여권번호
		gcds_data.namevalue(gcds_data.rowposition,"BIRTHDAY")        =  txt_birthday.value;//생년월일
		gcds_data.namevalue(gcds_data.rowposition,"SEX")             =  txt_sy009.value;//성별
		gcds_data.namevalue(gcds_data.rowposition,"CUST_GU")         =  txt_cu001.value;//고객구분
		gcds_data.namevalue(gcds_data.rowposition,"SAUP_GU")         =  txt_cu004.value;//사업구분
		gcds_data.namevalue(gcds_data.rowposition,"CUST_TYPE")       =  txt_rv003.value;//고객유형
		gcds_data.namevalue(gcds_data.rowposition,"LAST_NM")         =  txt_last_nm.value;//영문성
		gcds_data.namevalue(gcds_data.rowposition,"FIRST_NM")        =  txt_first_nm.value;//영문성명
		gcds_data.namevalue(gcds_data.rowposition,"ZIP_CD")          =  txt_czipcd.value;//우편번호
		gcds_data.namevalue(gcds_data.rowposition,"ZIP_NAME")        =  txt_cu020.value;//직군
		gcds_data.namevalue(gcds_data.rowposition,"ADDRESS1")        =  txt_address1.value;//주소1
		gcds_data.namevalue(gcds_data.rowposition,"ADDRESS2")        =  txt_address2.value;//주소2
		gcds_data.namevalue(gcds_data.rowposition,"TEL_NO")          =  txt_tel_no.value;//자택전화
		gcds_data.namevalue(gcds_data.rowposition,"MOBILE_NO")       =  txt_mobile_no.value;//핸드폰
		gcds_data.namevalue(gcds_data.rowposition,"COMPANY_NM")      =  txt_company_nm.value;//직장명
		gcds_data.namevalue(gcds_data.rowposition,"POSITIONS")       =  txt_positions.value;//직위
		gcds_data.namevalue(gcds_data.rowposition,"COUNTRY_GU_NAME") =  txt_gu_neme.value;//국적
		gcds_data.namevalue(gcds_data.rowposition,"NATION_CD")       =  txt_nation_cd.value;//민족
		gcds_data.namevalue(gcds_data.rowposition,"I_EMPNO")         =  gusrid;
		gcds_data.namevalue(gcds_data.rowposition,"U_EMPNO")         =  gusrid;
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

    gctr_data.KeyValue = "bm010i_t01(I:DATA=gcds_data)";
    gctr_data.Action = "/services/servlet/sales.bm.bm010i_t01";
    //prompt("",gcds_data.text);
		gctr_data.post();

		//ln_Query();
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
		var strURL   = "../common/html/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_VEND_SID.text = firstList[0];
		gcem_vend_nm.text = firstList[1];
	} 

	/******************************************************************************
		Description : 비용부담회사
	******************************************************************************/
	function ln_SrhCust2(){
		var strURL   = "../common/html/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_REAL_VEND.text = firstList[0];
		gcem_vend_nm2.text = firstList[1];
	} 

	/******************************************************************************
		Description : 소속팀
	******************************************************************************/
	function ln_SrhTeam(){
		var strURL   = "../common/html/Company_Team_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

		gcem_team_cd.text = firstList[0];
		gcem_team_nm.text = firstList[1];
	} 

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

		if (gcem_VEND_SID.text == "") {
			alert("소속사를 입력하셔야 합니다.");
			//gcem_VEND_SID.focus();
			return false;
		} 
/*		
		if (gcem_team_cd.text.text = null || gcem_team_cd.text == "") {
			alert("소속팀을 입력하셔야 합니다.");
			//gcem_team_cd.focus();
			return false;
		}

		if (txt_work_place.value == "") {
			alert("근무장소를 입력하셔야 합니다.");
			//txt_work_place.focus();
			return false;
		}

		if (gcem_order_date.text == "" ) {
			alert("부임일을 입력하셔야 합니다.");
			//gcem_order_date.focus();
			return false;
		}

		if (gcem_order_date.text.length < 8) {
			alert("부임일은 8자리 이상이어합니다");
			//gcem_order_date.focus();
			return false;
		}
*/		
		//키값중복체크
		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="1"){
				gcds_chk.DataID = "/services/servlet/sales.bm.bm010i_chk_s01?v_str1="+txt_cust_sid.value;
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"CUST_SID") != 0){
					alert("동일한 아이디가 있습니다.확인후 입력하세요");
					gcds_data.namevalue(row,"CUST_SID") = "";
					//gcem_lineno.focus();
					return;
				}				
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

<comment id="__NSID__"><OBJECT id=gcds_cu009_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu009 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_sy009 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu001 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rv003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_sy005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
/*
	if (gcds_data.countrow>0){
		if (gcds_data.namevalue(1,"file_nm")=="") {
			file_nm.src="/services/Sales/images/00000.gif";
		} else {
			var str1 = gcds_data.namevalue(1,"CUST_SID");
			file_nm.src="/services/servlet/groupware.g050050_s3?v_str1="+str1; //확인후 수정할것
			
		}
	} else {
		if (row <1) {
			file_nm.src="/services/Sales/images/00000.gif";
			alert("검색된 데이터가 없습니다.");
		}		
	}
*/
</script>

<!-- 움직일때 마다 사진나오게 -->
<script language=javascript for=gcds_data event=OnRowPosChanged(row)>
/*
	if (gcds_data.namevalue(row,"file_nm")=="") {
		file_nm.src="services/Sales/images/00000.gif;
	} else {
		var str1 = gcds_data.namevalue(row,"empno");
		file_nm.src="/services/servlet/groupware.g050050_s3?v_str1="+str1;//확인후 수정할것.
	}
*/
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language="javascript" for="gcds_sy009" event="onloadCompleted(row,colid)">
	gcds_sy009.deleterow(2);
</script>

<script language="javascript" for="gcds_cu001" event="onloadCompleted(row,colid)">
	gcds_cu001.deleterow(2);
	gcds_cu001.deleterow(2);
</script>

<script language="javascript" for="gcds_cu004" event="onloadCompleted(row,colid)">
	gcds_cu004.deleterow(3);
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
<input id="txt_cust_sid" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_sy005" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_work_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_regi_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_birthday" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_sy009" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_cu001" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_cu004" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_rv003" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_last_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_first_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_czipcd" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_cu020" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_address1" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_address2" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_tel_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_mobile_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_company_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_positions" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_gu_neme" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_nation_cd" type="hidden" class="txt_a01"  style="width:70px;">



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
			<table class="tab_b1111" border="0" cellpadding="0" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">국적구분</td>
					<td class="tab_b0100" style='width:180px'>
						<comment id="__NSID__"><OBJECT id=gclx_sy005_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu009_fr">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>	
					<td class="tab_a0100">고객명</td>
					<td class="tab_b0100">
            <input id="txt_cust_nm_fr" type="text" class="txt_a01"  style="width:120px;"  onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 				
					</td>	
					<td class="tab_a0100">주민/여권번호</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:130px;">
						<comment id="__NSID__"><OBJECT id=gcem_regi_no_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:120px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000000-0000000">
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
								<F> Name='No.'			  	ID={CURROW} 	     HeadAlign=Center HeadBgColor=#EEEEEE Width=30	align=center show=false</F>
								<C> Name='소속팀'		    ID=TEAM_CD			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='소속명'		    ID=DETAIL_NM		   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='고객SID'		  ID=CUST_SID			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='성명'		      ID=CUST_NM		 	   HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center sort=true</C> 
								<C> Name='(주민/여권)'	ID=MANAGE_NO		   HeadAlign=Center HeadBgColor=#EEEEEE Width=90	align=center mask='XXXXXX-XXXXXXX'</C> 
								<C> Name='성별'		      ID=SEX			       HeadAlign=Center HeadBgColor=#EEEEEE Width=35	align=center editstyle='lookup' data='gcds_sy009:DETAIL:DETAIL_NM'</C> 
								<C> Name='성별'		      ID=SEX_NAME			   HeadAlign=Center HeadBgColor=#EEEEEE Width=35	align=center show=false</C> 
								<C> Name='영문성'		    ID=LAST_NM			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='영문이름'		  ID=FIRST_NM			   HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=left </C> 
								<C> Name='실무번호'		  ID=WORK_NO			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='생년월일'		  ID=BIRTHDAY			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='고객구분'		  ID=CUST_GU			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='고객구분(명)'	ID=SAUP_GU_NAME	   HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center show=false</C> 
								<C> Name='주민번호'		  ID=REGI_NO			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='국적'		      ID=COUNTRY_GU		   HeadAlign=Center HeadBgColor=#EEEEEE Width=45	align=center show=true editstyle='lookup' data='gcds_cu009:DETAIL:DETAIL_NM'</C> 
								<C> Name='사업구분'		  ID=SAUP_GU			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='사업구분(명)'	ID=SAUP_GU_NAME2	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='고객유형'		  ID=CUST_TYPE	  	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='고객유형(명)'	ID=CUST_TYPE_NAME	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='우편번호'		  ID=ZIP_CD		    	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='직군'		      ID=ZIP_NAME			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='주소1'		    ID=ADDRESS1		  	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='주소2'		    ID=ADDRESS2		     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='자택전화'		  ID=TEL_NO			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=true</C> 
								<C> Name='핸드폰'		    ID=MOBILE_NO			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center </C> 
								<C> Name='직장명'		    ID=COMPANY_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='직위'		      ID=POSITIONS			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='국적(명)'		  ID=COUNTRY_GU_NAME HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C>								
								<C> Name='민족'		    ID=NATION_CD			   HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center editstyle='lookup' data='gcds_sy005:DETAIL:DETAIL_NM'</C> 
								<C> Name='민족(명)'		ID=NATION_NAME		   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='소속사'		  ID=VEND_SID			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='소속사(명)' ID=VEND_NM			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='비부사'		  ID=REAL_VEND			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='비부사명' ID=VEND_NM2			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='부임일'		  ID=ORDER_DATE			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='근무장소'		ID=WORK_PLACE			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='입력자'		  ID=I_EMPNO			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='입력일자'	  ID=I_DATE			       HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
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
				  <!-- <td class="tab_b0100" style='width:100px;' rowspan=4 align=center>사진</td> -->
				  <td class="tab_b0100" style='width:100px;' rowspan=4 align=center>
					<!-- -------------------------------------- -->
									<!-- <input type="text" class="txt_a01" id=txt_file name="txt_file" readonly style="width:100px;top:-3px;">  -->
<!-- 									<comment id="__NSID__">
										<object id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:8px;width:80;height:20;top:2px">
											<param name="Text"		value="찾아보기">
											<param name="Enable"  value="true">
										</object>
									</comment><script>__ws__(__NSID__);</script>	 -->
									<!-- <input type=image id="file_nm" NAME="file_nm" src="../../person/html/photo/00000.gif" style="width:60px;height:40px;"> -->
									<input type=image id="file_nm" NAME="file_nm" src="/services/Sales/images/00000.gif" style="width:98px;height:104px;">
          <!-- -------------------------------------- -->
					</td>
					<td class="tab_a0101">국적구분</td>
					<td class="tab_b0001" colspan=3>
						<comment id="__NSID__"><OBJECT id=gclx_sy005 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:0px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu009">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>		
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">실무번호</td>
					<td class="tab_b0001" colspan=3>
						<fieldset class=field_01 style="width:150px;">
						<comment id="__NSID__"><OBJECT id=gcem_work_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:145px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">한글성명</td>
					<td class="tab_b0101">
            <input id="txt_cust_nm" type="text" class="txt_a01"  style="width:70px;top:0px" disabled> 
					</td>	
					<td class="tab_a0101">주민/여권번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_regi_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:87px;top:0px">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#############">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>				
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0100">생년월일</td>
					<td class="tab_b0000" colspan=3>
						<fieldset class=field_01 style="width:70px;top:0px">
						<comment id="__NSID__"><OBJECT id=gcem_birthday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:67px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="0000/00/00">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
			</table><BR>		
			<table class="tab_b1111" border="0" cellpadding="0" cellspacing="0" style='width:482px;'>
		    <tr>
					<td class="tab_a0101">성&nbsp;&nbsp;&nbsp;&nbsp;별</td>
					<td class="tab_b0101">
						<comment id="__NSID__"><OBJECT id=gclx_sy009 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_sy009">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>	
					<td class="tab_a0101">고객구분</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_cu001 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu001">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>		
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">사업구분</td>
					<td class="tab_b0101">
						<comment id="__NSID__"><OBJECT id=gclx_cu004 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu004">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>				
					</td>		
					<td class="tab_a0101">고객유형</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_rv003 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_rv003">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>			
					</td>						
				</tr>
		    <tr>
				  <td class="tab_a0101">영&nbsp;문&nbsp;성</td>
					<td class="tab_b0101">
            <input id="txt_last_nm" type="text" class="txt_a01"  style="width:100px;top:-1px" disabled>
					</td>		
					<td class="tab_a0101">영문이름</td>
					<td class="tab_b0001">
            <input id="txt_first_nm" type="text" class="txt_a01"  style="width:100px;top:-1px" disabled>
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">우편번호</td>
					<td class="tab_b0101">
					    <fieldset class=field_01 style="width:55px;top:-1px">
							<comment id="__NSID__"><OBJECT id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  class="gcem_01"
								style="width:47px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Format	      value="000-000">
									<param name=Enable	      value="false">
									<param name=PromptChar	  value="_">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							</fieldset>
					</td>		
					<td class="tab_a0101">직&nbsp;&nbsp;&nbsp;&nbsp;군</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_cu020 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value="gcds_cu020">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>				
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">주&nbsp;&nbsp;&nbsp;소1</td>
					<td class="tab_b0001" colspan=3>
            <input id="txt_address1" type="text" class="txt_a01"  style="width:337px;top:-1px;" disabled>				
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">주&nbsp;&nbsp;&nbsp;소2</td>
					<td class="tab_b0001" colspan=3>
            <input id="txt_address2" type="text" class="txt_a01"  style="width:337px;top:-1px;" disabled>					
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">자택전화</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;">
						<comment id="__NSID__"><OBJECT id=gcem_tel_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:110px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td>		
					<td class="tab_a0101">핸&nbsp;드&nbsp;폰</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;top:0px;">
						<comment id="__NSID__"><OBJECT id=gcem_mobile_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:110px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">직&nbsp;장&nbsp;명</td>
					<td class="tab_b0101">
            <input id="txt_company_nm" type="text" class="txt_a01"  style="width:120px;top:0px;" disabled>						
					</td>		
					<td class="tab_a0101">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
					<td class="tab_b0001">
            <input id="txt_positions" type="text" class="txt_a01"  style="width:120px;top:0px;" disabled>	
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">국&nbsp;&nbsp;&nbsp;&nbsp;적</td>
					<td class="tab_b0101">
            <input id="txt_country_gu_neme" type="text" class="txt_a01"  style="width:120px;top:0px;" disabled>						
					</td>		
					<td class="tab_a0101">민&nbsp;&nbsp;&nbsp;&nbsp;족</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_nation_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value="gcds_sy005">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">소&nbsp;속&nbsp;사</td>
					<td class="tab_b0101">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<comment id="__NSID__"><OBJECT id=gcem_VEND_SID classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:1px;" onclick="ln_SrhCust();">
					</td>		
					<td class="tab_a0101">소&nbsp;속&nbsp;팀</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;top:-1px;">
						<comment id="__NSID__"><OBJECT id=gcem_team_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<comment id="__NSID__"><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:1px" onclick="ln_SrhTeam();">
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">근무장소</td>
					<td class="tab_b0101">
            <input id="txt_work_place" type="text" class="txt_a01"  style="width:120px;top:0px;">	
					</td>		
					<td class="tab_a0101">부&nbsp;임&nbsp;일</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_order_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:80px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
 		    <tr>
				  <td class="tab_a0100">비용부담회사</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:150px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:140px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<comment id="__NSID__"><OBJECT id=gcem_REAL_VEND classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:1px;" onclick="ln_SrhCust2();">
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
		<C>Col=COUNTRY_GU   Ctrl=gclx_sy005	    Param=Bindcolval</C>
		<C>Col=WORK_NO      Ctrl=gcem_work_no	  Param=Text</C>
		<C>Col=CUST_NM      Ctrl=txt_cust_nm	  Param=Value</C>
		<C>Col=MANAGE_NO      Ctrl=gcem_regi_no	  Param=Text</C>
		<C>Col=BIRTHDAY     Ctrl=gcem_birthday	Param=Text</C>
		<C>Col=SEX          Ctrl=gclx_sy009	    Param=Bindcolval</C>
		<C>Col=CUST_GU      Ctrl=gclx_cu001	    Param=Bindcolval</C>
		<C>Col=SAUP_GU      Ctrl=gclx_cu004	    Param=Bindcolval</C>
		<C>Col=CUST_TYPE    Ctrl=gclx_rv003	    Param=Bindcolval</C>
		<C>Col=LAST_NM      Ctrl=txt_last_nm	  Param=Value</C>
		<C>Col=FIRST_NM     Ctrl=txt_first_nm	  Param=Value</C>
		<C>Col=ZIP_CD       Ctrl=gcem_czipcd	  Param=Text</C>
		<C>Col=ZIP_NAME     Ctrl=gclx_cu020     Param=Bindcolval</C>
		<C>Col=ADDRESS1     Ctrl=txt_address1	  Param=Value</C>
		<C>Col=ADDRESS2     Ctrl=txt_address2	  Param=Value</C>
		<C>Col=TEL_NO       Ctrl=gcem_tel_no	  Param=Text</C>
		<C>Col=MOBILE_NO    Ctrl=gcem_mobile_no	Param=Text</C>
		<C>Col=COMPANY_NM   Ctrl=txt_company_nm	Param=Value</C>
		<C>Col=POSITIONS    Ctrl=txt_positions	Param=Value</C>
		<C>Col=COUNTRY_GU_NAME   Ctrl=txt_country_gu_neme	 Param=Value</C>
		<C>Col=NATION_CD    Ctrl=gclx_nation_cd	Param=Bindcolval</C>
		<C>Col=VEND_SID      Ctrl=gcem_VEND_SID	  Param=Text</C>
		<C>Col=VEND_NM      Ctrl=gcem_vend_nm	  Param=Text</C>
		<C>Col=REAL_VEND      Ctrl=gcem_REAL_VEND	  Param=Text</C>
		<C>Col=VEND_NM2      Ctrl=gcem_vend_nm2	  Param=Text</C>
		<C>Col=TEAM_CD      Ctrl=gcem_team_cd	  Param=Text</C>
		<C>Col=WORK_PLACE   Ctrl=txt_work_place	Param=Value</C>
		<C>Col=ORDER_DATE   Ctrl=gcem_order_date  Param=Text</C>
		<C>Col=DETAIL_NM   Ctrl=gcem_team_nm  Param=Text</C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
