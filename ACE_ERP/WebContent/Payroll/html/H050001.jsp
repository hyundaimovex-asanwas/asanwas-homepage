<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: h050001.html
+ 기 능 정 의	: 일별근태신청
+ 최 초 이 력	: 문희식
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: h050001_s1, h050001_s2, h050001_s3, h050001_t1, h050001_s1_time
------------------------------------------------------------------------------>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	var THeader = "APPDT:String(8),EMPNO:String(7),LAZCD:String(4),DEPTCD:String(4),PAYSEQ:String(4),"
							+ "FRDT:String(8),TODT:String(8),FRTIME:String(6),TOTIME:String(6),DTYREM:String(40),"
							+ "CLOSYN:String(1),SGDT:String(8),SGNID:String(7),AGRDT:String(8),AGRID:String(7),"
							+ "PAYDT:String(8),AMT:Decimal(7),DEPTNM:String(50),MINORNM:String(30),EMPNMK:String(20),"
							+ "LAZFEENM:String(20),CURYEAR:String(3),USEYEAR:String(3),PAYYEAR:String(3),"
							+ "SGNM:String(20),MINORCD:String(4),AGNM:String(20)";

	gcds_data.SetDataHeader(THeader);								//Header Set
	gcem_fr.text = gcurdate.substring(0,7) + "01";	//검색일자 FROM
	gcem_to.text = gcurdate;												//검색일자	TO
	txt_EMPNO.value = gusrid;												//사용자ID
	txt_NAME.value	= gusrnm;												//사용자명

	// 근태구분
	gcds_holfee.DataID = "/services/servlet/Person.h050001_s2";
	gcds_holfee.Reset();
	
	gclx_LAZCD.BindColVal = gcds_holfee.namevalue(gcds_holfee.rowposition,"LAZCD");	//근태구분
	//gclx_LAZCD.index = -1;
	txt_AMT.value="";

	DEPTNM.disabled	= true;
	MINORNM.disabled = true;
	EMPNMK.disabled	= true;	

	ln_Query2();
	ln_Query33();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
  
	var v_str1=gcem_fr.text;
	var v_str2=gcem_to.text;
	var v_str4=v_str1.substring(0,4)+v_str1.substring(4,6);
	var v_str5=v_str2.substring(0,4)+v_str2.substring(4,6);

	gcds_data.DataID = "/services/servlet/Person.h050001_s1?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text+ "&v_str3=" + txt_EMPNO.value+ "&v_str4=" +v_str4+ "&v_str5=" +v_str5;
	gcds_data.Reset();

	gclx_LAZCD.enable = false;
	txt_MEMO.disabled = true;
	txt_AMT.disabled  = true;
	CURYEAR.disabled  = true;
	USEYEAR.disabled  = true;
	PAYYEAR.disabled  = true;
}

/*-----------------------------------------------------------------------------
		Description : 조회
-----------------------------------------------------------------------------*/
function ln_Query33(){

	var row = gcds_data3.rowposition;

	var v_str1=gcem_fr.text;
	var v_str2=gcem_to.text;
	var v_str4=v_str1.substring(0,4)+v_str1.substring(4,6);
	var v_str5=v_str2.substring(0,4)+v_str2.substring(4,6);

	gcds_data3.DataID = "/services/servlet/Person.h050001_s1?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text+ "&v_str3=" + txt_EMPNO.value+ "&v_str4=" +v_str4+ "&v_str5=" +v_str5;
	gcds_data3.Reset();

		if (CURYEAR.value != "" && USEYEAR.value != "" || gcds_data.namevalue(row,"CURYEAR") != null) {
			var v_CURYEAR = gcds_data3.namevalue(row,"CURYEAR");	//연차
			var v_USEYEAR = gcds_data3.namevalue(row,"USEYEAR");	//사용
			var v_PAYYEAR = gcds_data3.namevalue(row,"PAYYEAR");	//잔액

			CURYEAR.value = v_CURYEAR;
			USEYEAR.value = v_USEYEAR;
			PAYYEAR.value = v_PAYYEAR;
	} else {
		CURYEAR.value = "";
		USEYEAR.value = "";
		PAYYEAR.value = "";
		//ln_Query2();
	}

	txt_MEMO.disabled = true;
	txt_AMT.disabled  = true;
	CURYEAR.disabled  = true;
	USEYEAR.disabled  = true;
	PAYYEAR.disabled  = true;
}

/*-----------------------------------------------------------------------------
		Description : 조회[부서]
-----------------------------------------------------------------------------*/
function ln_Query2(){

	txt_EMPNO.value = gusrid;
	txt_NAME.value	= gusrnm;
  var v_str1 = gcem_fr.text;
	var v_str2 = gcem_to.text;
	var v_str3 = txt_EMPNO.value;
	var v_str4 = v_str1.substring(0,4)+v_str1.substring(4,6);

	gcds_data2.DataID = "/services/servlet/Person.h050001_s3?v_str1="+v_str3;
	gcds_data2.Reset();

	var row = gcds_data2.rowposition;

	if (DEPTNM.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		DEPTNM.value	= gcds_data2.namevalue(row,"DEPTNM");		//부서명
		MINORNM.value = gcds_data2.namevalue(row,"MINORNM");	//직위
		EMPNMK.value	= gusrnm;																//성명	
	} else {
		DEPTNM.value	= "";
		MINORNM.value = "";
		EMPNMK.value	= gusrnm;	
	}

}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	if (DEPTNM.value == "") { 
		alert("소속된 부서가 없으므로 등록할 수 없습니다.");
		return false;
	} 

	var v_payseq  = gcds_data.namevalue(row,"MINORCD");	//직위
	////var v_CURYEAR = gcds_data.namevalue(row,"CURYEAR");	//연차
	////var v_USEYEAR = gcds_data.namevalue(row,"USEYEAR");	//사용
	////var v_PAYYEAR = gcds_data.namevalue(row,"PAYYEAR");	//잔액

	gcds_data.addrow();

	ln_Query2();
	ln_Query33();

	gcds_holfee.DataID = "/services/servlet/Person.h050001_s2?v_str3=" + txt_EMPNO.value;
	gcds_holfee.Reset();

	gcem_to.text = gcurdate;				//현재일

	txt_APPDT.value = gcem_to.text;	//신청일
	FRDT.text = gcurdate;						//시작일
	TODT.text = gcurdate;						//종료일

	ln_CurTime1();
	//FRTIME.text = '000000';					//시작시간
	
	TOTIME.text = '';				//종료시간
	TOTIME.enabled = false;

	var row = gcds_data.rowposition;
	var row2 = gcds_data2.rowposition;

	if (DEPTNM.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		txt_EMPNO.value	= gusrid;
		txt_MINORCD.value = v_payseq;		//직위
		DEPTNM.value  = gcds_data2.namevalue(row2,"DEPTNM");		//부서명
		txt_deptcd.value = gcds_data2.namevalue(row2,"DEPTCD");	//부서코드
		EMPNMK.value = gcds_data2.namevalue(row2,"EMPNMK");			//성명
		////CURYEAR.value = v_CURYEAR;
		////USEYEAR.value = v_USEYEAR;
		////PAYYEAR.value = v_PAYYEAR;
		gclx_LAZCD.enable = true;
	} else {
		txt_EMPNO.value	= gusrid;
		DEPTNM.value	= "";
		MINORNM.value = "";
		EMPNMK.value	= gusrnm;	
		txt_deptcd.value = "";
		////CURYEAR.value = v_CURYEAR;
		////USEYEAR.value = v_USEYEAR;
		////PAYYEAR.value = v_PAYYEAR;
		gclx_LAZCD.enable = true;
	}
}

/******************************************************************************
	Description : 현재 시작시간정보
******************************************************************************/
function ln_CurTime1() {

	if (DEPTNM.value == "") { 
		alert("소속된 부서가 없으므로 등록할 수 없습니다.");
		return false;
	} 

	FRTIME.enabled = false;
	gcds_curtime.DataID = "/services/servlet/Person.h050001_s1_time";
	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(6,8);

	FRTIME.text = h_time+m_time+s_time;

}

/******************************************************************************
	Description : 현재 퇴근시간정보
******************************************************************************/
function ln_CurTime() {

	if (DEPTNM.value == "") { 
		//alert("소속된 부서가 없으므로 등록할 수 없습니다.");
		return false;
	} 

	TOTIME.enabled = false;
	gcds_curtime.DataID = "/services/servlet/Person.h050001_s1_time";
	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(6,8);

	//alert(h_time+":"+m_time+":"+s_time+">>"+gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME"));
	TOTIME.text = h_time+m_time+s_time;

	ln_Save();

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (DEPTNM.value == "") { 
		alert("소속된 부서가 없으므로 등록할 수 없습니다.");
		return false;
	} 
	
	if (!ln_Valchk()) return;

	var row = gcds_data.rowposition;

	gcds_data.namevalue(row,"DEPTCD")		=		fn_trim(txt_deptcd.value);		//부서코드
	gcds_data.namevalue(row,"EMPNO")		=		txt_EMPNO.value;							//사번
	gcds_data.namevalue(row,"DEPTNM")		=		fn_trim(DEPTNM.value);				//부서명
	gcds_data.namevalue(row,"PAYSEQ")		=		txt_MINORCD.value;						//직위
	gcds_data.namevalue(row,"EMPNMK")		=		EMPNMK.value;									//성명
	gcds_data.namevalue(row,"SGNID")		=		fn_trim(txt_SGNID.value);			//결재자ID
	//gcds_data.namevalue(row,"AGRID")		=		txt_AGRID.value;							//승인자ID
	gcds_data.namevalue(row,"DTYREM")		=		txt_DTYREM.value;							//근태사유

	gcds_data.namevalue(row,"CURYEAR") = CURYEAR.value;
	gcds_data.namevalue(row,"USEYEAR") = USEYEAR.value;
	gcds_data.namevalue(row,"PAYYEAR") = PAYYEAR.value;

	var v_str1 = txt_APPDT.value;
	var v_str2 = txt_EMPNO.value ;					//사번
	var v_str3 = fn_trim(txt_SGNID.value);	//결재자
	//var v_str4 = txt_AGRID.value;						//승인자

	if (gcds_data.IsUpdated) {
//prompt('',gcds_data.text);
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_pyo.Action = "/services/servlet/Person.h050001_t1?v_str1="+ v_str1+"&v_str2="+v_str2 + "&v_str3=" + v_str3;
		gctr_pyo.post();
		ln_Query();
		}else {
			TOTIME.text ='';
		}
			
	}
}

/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Valchk() {

	var row = gcds_data.rowposition;

	txt_SGDT.value = gcds_data.namevalue(row, "SGDT");
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("결재일 / 승인일이  처리 된 항목은  저장 할 수 없습니다."); 
		return false;
	}
	
	if (FRDT.text == "") { 
		alert("정확한 신청 시작일을 입력해 주십시오."); 
		FRDT.focus()
		return false;
	}

	if (TODT.text == "") { 
		alert("정확한 신청 종료일을 입력해 주십시오."); 
		TODT.focus()
		return false;
	}
	
	if (fn_trim(SGNM.value) == "") { 
		alert("정확한 결재자를 입력해 주십시오."); 
		SGNM.value ="";
		SGNM.focus()
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("결재일 / 승인일이  처리 된 항목은  저장 할 수 없습니다."); 
		return false;
	}
	
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.action = "/services/servlet/Person.h050001_t1?v_str1=" + gcem_to.text+ "&v_str2=" + txt_EMPNO.value;
		gctr_pyo.post();
		ln_Query();
	}
 }

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}


/******************************************************************************
	Description : 결재자 찾기
******************************************************************************/
function ln_Popup(e){

	var row = gcds_data.rowposition;

	txt_SGDT.value  = gcds_data.namevalue(row, "SGDT");		//결재날짜
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");	//승인날짜

	if (gcds_data.IsUpdated) {

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("결재 및 승인이  처리 된 항목입니다."); 
		return false;
	}

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="SGNM") txt_SGNID.value = arrParam[1];	
	} else {
		eval(e).value = "";
		if (e=="SGNM") txt_SGNID.value = "";	
	}
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_holfee classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 근태구분 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_curtime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 현재 시간정보 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050001_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//근태총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
		ln_Query2();
	}else{
		ln_Query33();
		ln_Query2();
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";

//	ln_Query2();

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_LAZCD" event="OnSelChange()">

	var str1 = gcds_holfee.namevalue(row,"LAZCD");
	var row = gcds_holfee.rowposition;

	txt_MEMO.value = gcds_holfee.namevalue(row,"MEMO");
	txt_AMT.value = gcds_holfee.namevalue(row,"AMT");

</script>

<script language="javascript" for="gcgd_pyo" event=onClick()">
//	alert(gcds_data.namevalue(gcds_data.rowposition,"APPDT"));
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h050001_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>

	<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;검색일자&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;" >
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
					
			</td>
			<td align=center> ~ </td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;"><nobr> 
				<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
			</td>
			<td width="150" align=RIGHT ></td>   
			<td width="100" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>신청자사번&nbsp;&nbsp;&nbsp;</nobr></td>
			<td>
				<input id="txt_EMPNO" name="txt_EMPNO" type=text value=""  class="txt21" style="border:0px;position:relative;left:5px;top:2px"   maxlength="7" onBlur="bytelength(this,this.value,7);" readonly >
			</td>
			<td width="150" align=RIGHT style="border:0 solid #708090;border-right-width:1px;">&nbsp;&nbsp;</td>
			<td width="100" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>성&nbsp;&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td >
				<input id="txt_NAME" name="txt_NAME" type=text value="" class="txt21" style="border:0px;position:relative;left:5px;top:1px"       maxlength="20" onBlur="bytelength(this,this.value,20);" readonly>
			</td>
			<td width="150" align=RIGHT >&nbsp;&nbsp;</td>
			<td style="padding-top:4px;"></td>
		</tr>
	</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH: 488px; HEIGHT: 419px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='신청일'			ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER	Mask='XXXX/XX/XX' BgColor='#f5f5f5' Edit=None  </F> 
								<F> Name='근태구분'		ID=LAZCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=LEFT		Edit=None    BgColor='#f5f5f5' Editstyle=lookup data='gcds_holfee:LAZCD:LAZFEENM'  </F> 
								<G> Name='시작'				ID=MIDSCR		HeadAlign=Center HeadBgColor=#B9D4DC 
								<C> Name='날짜'				ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Mask='XXXX/XX/XX' Edit=None  </C>
								<C> Name='시간'				ID=FRTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XX:XX' Edit=None </C>
								</G>
								<G> Name='종료'				ID=MIDSCR		HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='날짜'				ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Mask='XXXX/XX/XX' Edit=None  </C>
								<C> Name='시간'				ID=TOTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XX:XX' Edit=None </C>
								</G>
								<C> Name='결재자명'		ID=SGNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=88		align=LEFT		Edit=None </C>
								<C> Name='결재일'			ID=SGDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER	Mask='XXXX/XX/XX' Edit=None </C>
								<C> Name='결재자ID'		ID=SGNID		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=CENTER	Edit=None SHOW=false</C>
								<C> Name='승인자명'		ID=AGNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=88		align=LEFT		Edit=None </C>
								<C> Name='승인일'			ID=AGRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER	Mask='XXXX/XX/XX' Edit=None </C>
								<C> Name='승인자ID'		ID=AGNID		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		Edit=None SHOW=false</C>
								<C> Name='부서명'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=83		align=CENTER	Edit=None show=false</C>
								<C> Name='직위'				ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
								<C> Name='이름'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
			<td STYLE="PADDING-TOP:0px;" valign=top><table width="350" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:384px;height:421px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="width:70px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >부 서 명</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="DEPTNM" name="DEPTNM" type="text"   class="txtbox"  style= "position:relative;left:-6px;width:126px;height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" readonly>
							<input id="DEPTCD" name="txt_deptcd" type="hidden" style= "position:relative;left:-6px;width:10px;height:20px;" value="" maxlength="4" onBlur="bytelength(this,this.value,4);" readonly>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
						<td style="border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="MINORNM" name="MINORNM"  class="txtbox" type="text" style= "position:relative;left:-5px;width:90px; height:20px;" value="" maxlength="30" onBlur="bytelength(this,this.value,30);" readonly>
							<input id="txt_MINORCD" name="txt_MINORCD"	type="hidden" style= "width:1px; height:1px;" maxlength="4" onBlur="bytelength(this,this.value,4);" readonly>
							<input id="txt_APPDT"		name="txt_APPDT"		type="hidden" style="height:20px" maxlength="8" onBlur="bytelength(this,this.value,8);" readonly>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >근태구분</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gclx_LAZCD name=gclx_LAZCD classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=186 width=128 class="txtbox" >
								<param name=ComboDataID			value=gcds_holfee>
								<param name=SearchColumn		value="LAZCD^LAZFEENM^ALWCON^AMT">
								<param name=Sort						value="LAZFEENM">
								<param name=ListExprFormat	value="LAZFEENM">
								<param name=BindColumn			value="LAZCD">
								<param name=Enable          value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >
							<nobr>성&nbsp;&nbsp;&nbsp;&nbsp;명</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="EMPNMK" name="EMPNMK" type="text"  class="txt21" style= "position:relative;left:-5px;width:90px; height:20px;" value="" maxlength="20" onBlur="bytelength(this,this.value,20);" readonly></td>
					</tr>					
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr>시 작 일</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=FRDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " 		validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('FRDT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></td>
						
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >시작시간</td>
						<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=FRTIME classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " 
				validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="00:00">
								<param name=MaxLength     value=4>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" ><nobr>종 료 일</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2><nobr>&nbsp;
							<comment id="__NSID__"><object id=TODT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; "  
				validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>
					
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('TODT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
				</td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >종료시간</td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2><nobr>&nbsp;
					<comment id="__NSID__"><object id=TOTIME classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " 
				validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="00:00">
						<param name=MaxLength     value=4>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>
					<img src="../../common/img/btn/com_btn_clotime.gif" style="position:relative;left:5px;top:2px;cursor:hand;" BORDER="0" onclick="ln_CurTime()">
					<nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >결 재 자</td>
				<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<input id="SGNM"			name="SGNM"				type="text"		 class="txt21" style= "position:relative;left:-6px;width:76px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);">
					<input id="txt_SGNID" name="txt_SGNID"	type="hidden" style= "width:20px; height:1px;" maxlength="7" onBlur="bytelength(this,this.value,7);">
					<!-- <input id="txt_AGRID" name="txt_AGRID"	type="hidden" style= "width:20px; height:1px;" maxlength=7> -->
					<input id="txt_SGDT"	name="txt_SGDT"		type="hidden" style= "width:20px; height:1px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
					<input id="txt_AGRDT"	name="txt_AGRDT"	type="hidden" style= "width:20px; height:1px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
				</td>
				<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px">
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="성명을 검색합니다" style="cursor:hand;position:relative;left:-2px;" align=center onclick="ln_Popup('SGNM');">
				</td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >지급금액</td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >근태사유</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="txt_DTYREM" name="txt_DTYREM" type="text"  class="txt21" style="position:relative;left:-6px;width:257px;" maxlength="40" onBlur="bytelength(this,this.value,40);" >&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >지급조건</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="txt_MEMO" name="txt_MEMO" type="text" class="txt21"  style="position:relative;left:-6px;width:257px;border=0;background-color:#f1f1f1;" maxlength="30" onBlur="bytelength(this,this.value,30);" readonly>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >수당금액</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="txt_AMT" name="txt_AMT" type="text" class="txt21"  style="position:relative;left:-6px;width:257px;border=0;background-color:#f1f1f1;" maxlength="7" onBlur="bytelength(this,this.value,7);" readonly>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td colspan=6 style="height:100%;border:0 solid #708090;border-bottom-width:1px;" >&nbsp;</td>
			</tr>
					<tr>
						<td style="height:20px;width:50px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;년차</nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-right-width:1px;">&nbsp;
							<input id="CURYEAR" name="CURYEAR" type="text"  class="txtbox" style= "width:50px; height:20px; border=0;background-color:#f1f1f1;position:relative;left:-6px" maxlength="3" onBlur="bytelength(this,this.value,3);"  readonly>
						</td>
						<td style="height:20px;width:50px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;사용</nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-right-width:1px;">&nbsp;
							<input id="USEYEAR" name="USEYEAR" type="text"  class="txtbox" style= "width:50px; height:20px;border=0;background-color:#f1f1f1;position:relative;left:-6px" maxlength="3" onBlur="bytelength(this,this.value,3);" readonly>
            </td>
						<td style="height:20px;width:50px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;잔여</nobr></td>
						<td Style="height:20px;border:0 solid #708090;">&nbsp;
							<input id="PAYYEAR" name="PAYYEAR" type="text"  class="txtbox" style= "width:50px; height:20px;border=0;background-color:#f1f1f1;position:relative;left:-6px" maxlength="3" onBlur="bytelength(this,this.value,3);" readonly>
            </td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
			</td>
		</tr>
  </table>
    </td>
  </tr>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT        Ctrl=txt_APPDT		Param=value			</C>
		<C>Col=EMPNO        Ctrl=EMPNO			  Param=value			</C>
		<C>Col=LAZCD        Ctrl=gclx_LAZCD	  Param=BindColVal</C>
		<C>Col=LAZFEENM     Ctrl=LAZFEENM			Param=BindColVal</C>
		<C>Col=DEPTCD       Ctrl=DEPTCD			  Param=value			</C>
		<C>Col=PAYSEQ       Ctrl=PAYSEQ			  Param=value			</C>
		<C>Col=FRDT					Ctrl=FRDT					Param=Text			</C>
		<C>Col=FRTIME				Ctrl=FRTIME				Param=Text			</C>
		<C>Col=TODT					Ctrl=TODT					Param=Text			</C>
		<C>Col=TOTIME				Ctrl=TOTIME			  Param=Text			</C>
		<C>Col=DTYREM				Ctrl=txt_DTYREM		Param=value			</C>
		<C>Col=CLOSYN				Ctrl=CLOSYN			  Param=value			</C>
		<C>Col=SGNID				Ctrl=txt_SGNID		Param=value			</C>
		<C>Col=SGDT					Ctrl=txt_SGDT			Param=value			</C>
		<C>Col=AGRID				Ctrl=AGRID				Param=value			</C>
		<C>Col=AGRDT				Ctrl=txt_AGRDT		Param=value			</C>
		<C>Col=PAYDT				Ctrl=PAYDT				Param=Text			</C>
		<C>Col=AMT					Ctrl=AMT					Param=value			</C>
		<C>Col=MINORNM			Ctrl=MINORNM		  Param=value			</C>
		<C>Col=DEPTNM				Ctrl=DEPTNM				Param=value			</C>
		<C>Col=EMPNMK				Ctrl=EMPNMK				Param=value			</C>
		<C>Col=SGNM					Ctrl=SGNM					Param=value			</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>




