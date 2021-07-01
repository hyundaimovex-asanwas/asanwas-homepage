<%@ page language="java" contentType="text/html;charset=euc-kr" %>


<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사/인사발령등록

+ 프로그램 ID	: H080010.HTML
+ 기 능 정 의	: 조회,저장,삭제
+ 변 경 이 력	: 
+ 서 블 릿 명	: h080010_s1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>인사발령등록</title>
<meta http-equiv="Pragma" content="no-cache">

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_orddt.text = gs_date;
	ln_SetHeader();
	ln_Before();
	txt_useyn.disabled = true;
	txt_useyn.checked = false;
	chk_p01.checked = false;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	if (chk_p01.checked == false) {
	gcds_data.DataID = "/servlet/Contract.h080010_s1?"
									 + "v_str1=" + gclx_dept.bindcolval
								 	 + "&v_str2=&v_str3=" + fn_trim(txt_empnmk.value)
									 + "&v_str4="+gs_level 
									 + "&v_str5="+gs_treecd;								
//prompt('',gcds_data.DataID);
	gcds_data.Reset(); }
  else if (chk_p01.checked == true) {
 	gcds_data.DataID = "/servlet/Contract.h080010_s2?"
									 + "v_str1=" + gclx_dept.bindcolval
								 	 + "&v_str2=&v_str3=" + fn_trim(txt_empnmk.value)
									 + "&v_str4="+gs_level 
									 + "&v_str5="+gs_treecd;								
//prompt('',gcds_data.DataID);
	gcds_data.Reset(); }
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	for (var i=1; i<=gcds_data.countrow;i++){

		var v_ordcd = fn_trim(gclx_ordcd.BindColVal);
     //alert(v_ordcd);
     //alert(gcds_data.namevalue(i,"BCHK"));
		if (gcds_data.namevalue(i,"BCHK") == "T" && 
				(v_ordcd=="B5" ||  v_ordcd=="A1" || v_ordcd=="A2" || v_ordcd=="A3" || v_ordcd=="A4"  ||v_ordcd=="C8"||v_ordcd=="D6"||v_ordcd=="F1"|| v_ordcd=="B8")) {
			gcds_data2.addrow();
			var row = gcds_data2.rowposition;
			gcds_data2.namevalue(row,"EMPNO")		= fn_trim(gcds_data.namevalue(i,"EMPNO"));
			gcds_data2.namevalue(row,"ORDDT")		= gcem_orddt.text;
			gcds_data2.namevalue(row,"SEQ")			= 0;
			gcds_data2.namevalue(row,"ORDCD")		= gclx_ordcd.bindcolval;
      gcds_data2.namevalue(row,"GRDDIV")	= gclx_grddiv.bindcolval;
			gcds_data2.namevalue(row,"DEPTCD")	= gclx_dept2.bindcolval;
			gcds_data2.namevalue(row,"PAYGRD")	= gclx_deptlvl.bindcolval;
			gcds_data2.namevalue(row,"PAYSEQ")	= gclx_payseq.bindcolval;
			gcds_data2.namevalue(row,"EMPNMK")	= gcds_data.namevalue(i,"EMPNMK");
		}else if (gcds_data.namevalue(i,"BCHK") == "T" && (v_ordcd == "F2" ) ) {
		gcds_data2.addrow();
			var row = gcds_data2.rowposition;
			gcds_data2.namevalue(row,"EMPNO")		= fn_trim(gcds_data.namevalue(i,"EMPNO"));
			gcds_data2.namevalue(row,"ORDDT")		= gcem_orddt.text;
			gcds_data2.namevalue(row,"SEQ")			= 0;
			gcds_data2.namevalue(row,"ORDCD")		= gclx_ordcd.bindcolval;
			gcds_data2.namevalue(row,"GRDDIV")	= gclx_grddiv.bindcolval;
			gcds_data2.namevalue(row,"DEPTCD")	= gclx_dept2.bindcolval;
			gcds_data2.namevalue(row,"PAYGRD")	= gclx_deptlvl.bindcolval;
			//alert("::"+i+"::"+gcds_data.namevalue(i,"EMPNMK"));

			gcds_data2.namevalue(row,"EMPNMK")	= gcds_data.namevalue(i,"EMPNMK");
		}else if (gcds_data.namevalue(i,"BCHK") == "T" && v_ordcd == "A7") {
			gcds_data2.addrow();
			var row = gcds_data2.rowposition;
			gcds_data2.namevalue(row,"EMPNO")		= fn_trim(gcds_data.namevalue(i,"EMPNO"));
			gcds_data2.namevalue(row,"ORDDT")		= gcem_orddt.text;
			gcds_data2.namevalue(row,"SEQ")			= 0;
			gcds_data2.namevalue(row,"ORDCD")		= gclx_ordcd.bindcolval;
			gcds_data2.namevalue(row,"GRDDIV")	= gclx_grddiv.bindcolval;
			gcds_data2.namevalue(row,"DEPTCD")	= gcds_data.namevalue(i,"DEPTCD");
			gcds_data2.namevalue(row,"PAYGRD")	= gcds_data.namevalue(i,"PAYGRD");
			gcds_data2.namevalue(row,"PAYSEQ")	= gclx_payseq.bindcolval;
			gcds_data2.namevalue(row,"EMPNMK")	= gcds_data.namevalue(i,"EMPNMK");
		}else if (gcds_data.namevalue(i,"BCHK") == "T" && 
			(v_ordcd != "B5" || v_ordcd != "B8" || v_ordcd != "A1" || v_ordcd != "A2" || v_ordcd != "A3" || v_ordcd != "A4" || v_ordcd != "A7"|| v_ordcd != "D6"||v_ordcd=="F1"||v_ordcd=="F2")) {
			gcds_data2.addrow();
			var row = gcds_data2.rowposition;
			gcds_data2.namevalue(row,"EMPNO")		= fn_trim(gcds_data.namevalue(i,"EMPNO"));
			gcds_data2.namevalue(row,"ORDDT")		= gcem_orddt.text;
			gcds_data2.namevalue(row,"GRDDIV")	= gclx_grddiv.bindcolval;
			gcds_data2.namevalue(row,"ORDCD")		= gclx_ordcd.bindcolval;
			gcds_data2.namevalue(row,"DEPTCD")	= gclx_dept2.bindcolval;
			gcds_data2.namevalue(row,"EMPNMK")	= gcds_data.namevalue(i,"EMPNMK");

			//보직변경 체크시만 적용함
			if(v_ordcd=="E1" && txt_useyn.checked ==true ){
				 gcds_data2.namevalue(row,"PAYSEQ")	= gclx_payseq.bindcolval;
			}
		}
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if (gcds_data2.countrow <1) {
		alert("저장하실 정보가 없습니다.");
	} else {
		if (gcds_data2.IsUpdated ){
			if (confirm("해당 직원에 대한 발령요청 정보를 저장하겠습니까 ?")) {
				gctr_data.KeyValue = "Contract.h080010_t1(I:USER=gcds_data2)";
				gctr_data.Action = "/servlet/Contract.h080010_t1";

				//prompt('',gcds_data2.text);
				gctr_data.post();
			}
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	gcds_data2.undo(gcds_data2.rowposition);
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
	Description : 선조회조건
******************************************************************************/
function ln_Before(){

	//소속코드1
	gcds_dept.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_dept.Reset();

	//발령구분
	gcds_ordcd.DataID = "/servlet/Person.ordcode_s1?v_str1=1149";
	gcds_ordcd.Reset();

	//소속코드2
	gcds_dept2.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_dept2.Reset();

	//직위코드
	gcds_deptlvl.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_deptlvl.Reset();

	//직위코드
	gcds_deptlv2.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_deptlv2.Reset();

	//호봉
	gcds_payseq.DataID = "/servlet/Person.hclcode_s1?v_str1=1184";
	gcds_payseq.Reset();

	//직급코드
	gcds_grddiv.DataID = "/servlet/Person.hclcode_s1?v_str1=2001";
	gcds_grddiv.Reset();

	//직책코드
	gcds_deptgb.DataID = "/servlet/Person.hclcode_s1?v_str1=2038";
	gcds_deptgb.Reset();

}

/******************************************************************************
	Description : 헤더생성
******************************************************************************/
function ln_SetHeader(){
	var ls_html = "";
	ls_html += "EMPNO:STRING(7),ORDDT:STRING(8),SEQ:DECIMAL(2.0),ORDCD:STRING(2),DEPTCD:STRING(4),";
	ls_html += "PAYGRD:STRING(4),PAYSEQ:STRING(4),ENDDT:STRING(8),APPDT:STRING(8),EMPNMK:STRING(20),GRDDIV:STRING(4)";
	//ls_html += "DEPTGB:STRING(4)";

	gcds_data2.SetDataHeader(ls_html);
}

/******************************************************************************************
	Descrition : CheckBox
******************************************************************************************/
function ln_Chkbox(e,a){
	
	if (e.checked) gclx_payseq.enable = true;
	else gclx_payseq.enable = false;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grddiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_ordcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+ordnm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlv2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_payseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptgb classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="TRUE">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.insertrow(1);
	gcds_dept.namevalue(1,"DEPTCD") = "";
	gcds_dept.namevalue(1,"DEPTNM") = "전체";
	gclx_dept.index = 0;
</script>

<script language="javascript" for="gcds_deptgb" event="onloadCompleted(row,colid)">
	gcds_deptgb.insertrow(1);
	gcds_deptgb.namevalue(1,"MINORCD") = "";
	gcds_deptgb.namevalue(1,"MINORNM") = "";
	//gclx_deptgb.index = 0;
</script>

<!-- <script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.insertrow(1);
	gcds_dept2.namevalue(1,"DEPTCD") = "";
	gcds_dept2.namevalue(1,"DEPTNM") = "전체";
	gclx_dept2.index = 0;
</script> -->

<script language="javascript" for="gcds_grddiv" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

	gcds_grddiv.insertrow(1);
	gcds_grddiv.namevalue(1,"MINORCD") = "";
	gcds_grddiv.namevalue(1,"MINORNM") = "";
	gclx_grddiv.index = 0; 
</script>

<!-- <script language="javascript" for=gclx_dept2	event="OnSelChange()">
	//gcds_temp.DataID = "/servlet/Person.hcdept_s1?v_str1="+gclx_dept2.BindColVal;
	//gcds_temp.Reset();
	//gclx_deptgb.BindColVal = gcds_temp.namevalue(gcds_temp.rowposition,"DEPTGB");
</script> -->


<script language=JavaScript for=gclx_dept event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_dept.ValueOfIndex ("level", gclx_dept.Index);
	gs_treecd = gclx_dept.ValueOfIndex ("treecd", gclx_dept.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for=gclx_ordcd event=onSelChange()>
	var chkOrd = gclx_ordcd.BindColVal;

	txt_useyn.disabled = true;
	txt_useyn.checked = false;

	if (chkOrd == "B5" || chkOrd == "B8" || chkOrd == "A1" || chkOrd == "A2" || chkOrd == "A3" || chkOrd == "A4" || chkOrd == "C8"|| chkOrd == "D6" || chkOrd == "F1" ) {
		gclx_deptlvl.enable = true;
		gclx_payseq.enable = true;
	}else if (chkOrd == "A7") {
		gclx_payseq.enable = true;
		gclx_dept2.enable = false;
	}else if (chkOrd == "F2") {
		gclx_deptlvl.enable = true;
		gclx_payseq.enable = false;
	}else{
		gclx_dept2.enable = true;
		gclx_deptlvl.enable = false;
		gclx_payseq.enable = false;

		if(chkOrd == "E1" ){ // 보직변경 일 경우
			txt_useyn.disabled = false;
		}
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcds_data2.ClearData();
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("요청하신 작업이 성공적으로 수행되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h080010_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
	<tr> 
    <td colspan=2>
			<table width="876" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan=8 align=center>
						<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;border:0 solid #708090;border-top-width:1px;border-left-width:1px'>
							<tr>
								<td class="tab11" width="80px" bgcolor="#eeeeee">소속</td>
								<td class="tab21" width="200px">
									<comment id="__NSID__"><object id=gclx_dept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:140px;">
											<param name=ComboDataID			value="gcds_dept">
											<param name=CBDataColumns		value="DEPTCD, DEPTNM">
											<param name=SearchColumn		value=DEPTNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="DEPTNM^0^150">
											<param name=BindColumn			value=DEPTCD>
			 						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" width="80px" bgcolor="#eeeeee">성명</td>
								<td class="tab21"><input type=text class="txt11" id=txt_empnmk onkeydown="if(event.keyCode==13) ln_Query();"></td>
								<td class="tab11" width="80px" bgcolor="#eeeeee">퇴사자포함</td>
								<td class="tab21" width="200px">
								<nobr> 
						    <input type="checkbox" id=chk_p01   value="T" style="position:relative;left:2px;">
						 	 	<input type="text"     id=chk_p01nm value="사용" style="position:relative;border-width:0;width:42px;">
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> 
    <td colspan="2" align=center valign=center> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=center>
						<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;top:2px;">
							<tr> 
								<td style="width:435" align=center>
									<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp  
										style="width:505px;height:437px;border:1 solid #777777;z-index:2;">
										<PARAM NAME="DataID"				VALUE="gcds_data">
			              <PARAM NAME="Editable"			VALUE="True">
						        <PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="Indwidth"			VALUE="0">
										<param name="Fillarea"			VALUE="true">
										<PARAM NAME="SortView"			VALUE="left">
										<PARAM NAME="ColSizing"			VALUE="true">
									  <PARAM NAME="Format"				VALUE="  
	<F> Name='선택'				ID=BCHK			HeadAlign=Center HeadBgColor=#B9D4DC width=50 align=center, bgcolor=#f5f5f5, EditStyle=CheckBox, cursor=hand, sort=true</F>
	<F> Name='사번'				ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=center,	bgcolor=#f5f5f5, Edit=none,sort=true  </F> 
	<F> Name='성명'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=left,		bgcolor=#f5f5f5, Edit=none,sort=true </F> 
	<C> Name='소속'				ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=128 align=left,	Edit=none, EditStyle=LookUp, Data='gcds_dept:deptcd:deptnm',sort=true</C>
	<C> Name='그룹입사일'	ID=GRSTRTDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 align=center	Edit=none, Mask='XXXX/XX/XX',sort=true </C>
	<C> Name='입사일'			ID=STRTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center	Edit=none, Mask='XXXX/XX/XX',sort=true </C>
	<C> Name='직위'				ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=78 align=left,		Edit=none  EditStyle=lookup, Data='gcds_deptlv2:minorcd:minornm', sort=true</C>
	<C> Name='직급'				ID=GRDDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center, Edit=none, EditStyle=LookUp, Data='gcds_grddiv:minorcd:minornm' SHOW=ture, sort=true</C>
	<C> Name='호봉'				ID=PAYSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center, Edit=none, EditStyle=LookUp, Data='gcds_payseq:minorcd:minornm',sort=true </C>
	<C> Name='최종승급일' ID=LRMDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=85 align=center, Edit=none, Mask='XXXX/XX/XX', sort=true </C>
										">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
<!--
											<C> Name='최종승호일' ID=		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center Edit=none, Mask='XXXX/XX/XX' </C>
-->
									<fieldset style="width:507px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
									</fieldset>
                </td>
       					<td style="padding-left:3px;">
									<table border="0" cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
										<tr>
											<td class="tab11" width="80px;" bgcolor="#B9D4DC">발령사항</td>
											<td class="tab21" colspan=3 align=right>
											  <input name="txt_useyn" type="checkbox"       style="position:relative;left:0px;" onclick="ln_Chkbox(this,'USEYN')" >보직변경 호봉적용&nbsp;
												<img src="../../Common/img/btn/com_b_bal.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
												<img src="../../Common/img/btn/com_b_cancle.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Cancel()">
												<img src="../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
												&nbsp;
											</td>
										</tr>
										<tr>
											<td class="tab11" width="80px;" bgcolor="#eeeeee">발령구분</td>
											<td class="tab21" width="110px">
												<comment id="__NSID__"><object id=gclx_ordcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:90px;">
														<param name=ComboDataID			value="gcds_ordcd">
														<param name=CBDataColumns		value="ORDCD, ORDNM">
														<param name=SearchColumn		value=ORDNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="ORDNM^0^90">
														<param name=BindColumn			value=ORDCD>
						 						</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab11" width="80px;" bgcolor="#eeeeee">발령일자</td>
											<td class="tab21" width="100px">
												<comment id="__NSID__"><object id=gcem_orddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:2px; width:70px; font-family:굴림; font-size:9pt; " >
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
											  </object></comment><script>__ws__(__NSID__);</script>
												<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_orddt', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
											</td>
										</tr>
										<tr>
											<td class="tab11" width="80px;" bgcolor="#eeeeee">소속</td>
											<td class="tab21" width="110px">
												<comment id="__NSID__"><object id=gclx_dept2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:90px;">
														<param name=ComboDataID			value="gcds_dept2">
														<param name=CBDataColumns		value="DEPTCD, DEPTNM">
														<param name=SearchColumn		value=DEPTNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="DEPTNM^0^150">
														<param name=BindColumn			value=DEPTCD>
			 									</object></comment><script>__ws__(__NSID__);</script>
											</td>


					  					<td class="tab11" width="80px;" bgcolor="#eeeeee">직급</td>
											<td class="tab21" width="100px">
												<comment id="__NSID__"><object id=gclx_grddiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:85px;">
														<param name=ComboDataID			value="gcds_grddiv">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value="MINORNM">
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^100">
														<param name=BindColumn			value="MINORCD">
														<param name=Enable					value=true>
	 											</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>  
										
										
										
										<tr>
											<td class="tab11" width="80px;" bgcolor="#eeeeee">직위</td>
											<td class="tab21" width="110px"> 
												<comment id="__NSID__"><object id=gclx_deptlvl classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:85px;">
														<param name=ComboDataID			value="gcds_deptlvl">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^100">
														<param name=BindColumn			value=MINORCD>
	 											</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<!-- <td class="tab11" colspan="2">&nbsp;</td> -->
											<td class="tab11" width="80px;" bgcolor="#eeeeee">호봉</td>
											<td class="tab21" width="100px">
												<comment id="__NSID__"><object id=gclx_payseq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:90px;">
														<param name=ComboDataID			value="gcds_payseq">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="MINORNM^0^80">
														<param name=BindColumn			value=MINORCD>
			 									</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr><td height="2px;"></td></tr>
									</table>
									<table border="0" cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
										<tr>
											<td class="tab21" colspan=4>
												<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2  
													style="width: 364px;; height: 357px;">
							              <PARAM NAME="DataID"			VALUE="gcds_data2">
							              <PARAM NAME="Editable"		VALUE="true">
							              <PARAM NAME="AllShowEdit"	VALUE="true">
							              <PARAM NAME="BorderStyle" VALUE="0">
														<PARAM NAME="Indwidth"		VALUE="0">
														<PARAM NAME="Fillarea"		VALUE="true">
														<PARAM NAME="ColSizing"			VALUE="true">
													  <PARAM NAME="Format"			VALUE="  
						                  <F> Name='발령구분'				ID=ORDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=left Bgcolor=#f5f5f5, EditStyle=lookup, Data='gcds_ordcd:ordcd:ordnm', edit=none </F> 
															<F> Name='성명'						ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=left Bgcolor=#f5f5f5, edit=none </F> 
						                  <C> Name='사번'						ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=left, edit=none </C> 
															<C> Name='소속'						ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left, EditStyle=lookup, Data='gcds_dept2:deptcd:deptnm', edit=none </C>
															<C> Name='발령일자'				ID=ORDDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center, Mask='XXXX/XX/XX', edit=none </C>
															<C> Name='직위'						ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left, EditStyle=lookup, Data='gcds_deptlvl:minorcd:minornm', edit=none</C>
															<C> Name='직급'				ID=GRDDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center, Edit=none, EditStyle=LookUp, Data='gcds_grddiv:minorcd:minornm' SHOW=ture, sort=true</C>
															<C> Name='호봉'						ID=PAYSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center, EditStyle=lookup, Data='gcds_payseq:minorcd:minornm', edit=none </C>
															<C> Name='소급급여년월'		ID=PAYDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=center, Mask='XXXX/XX' </C>
															<C> Name='직책'						ID=DEPTGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=center, EditStyle=lookup, Data='gcds_deptgb:minorcd:minornm', edit=none</C>
															<C> Name='비고'						ID=ETC			HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left</C>
														">
						            </OBJECT></comment><script>__ws__(__NSID__);</script>
<!--
															<C> Name='최종승호일' ID=CHOLHO		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center, Mask='XXXX/XX/XX' </C>
-->
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
</table>



<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pyo>
	<param name=BindInfo  value='
		<C>Col=EVACD			Ctrl=ddlb_evacd       Param=BindColVal</C>
		<C>Col=DIVCD			Ctrl=ddlb_divcd       Param=BindColVal</C>
		<C>Col=GRPCD			Ctrl=ddlb_grpcd       Param=BindColVal</C>
		<C>Col=JOBGRPH		Ctrl=ddlb_jobgrph			Param=BindColVal</C>
		<C>Col=DETCD			Ctrl=ddlb_detcd				Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>