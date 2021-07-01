<%@ page language="java" contentType="text/html;charset=euc-kr" %>


<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: H040002.HTML
+ 기 능 정 의	: 조회,저장,삭제,출력,엑셀
+ 변 경 이 력	: 
+ 서 블 릿 명	: h040002_s1, h040002_s2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>인사발령작업</title>
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


var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gcurdate;
	ln_Before();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "/servlet/Contract.h080011_s1?"
									 + "v_str1=" + gclx_dept.bindcolval
									 + "&v_str2=" + gclx_ordcd.bindcolval
									 + "&v_str3=" + gcem_fr.text
									 + "&v_str4=" + gcem_to.text
									 + "&v_str5=" + fn_trim(txt_hdid.value)
									 + "&v_str6=" + gs_level
									 + "&v_str7=" + gs_treecd;
					
	gcds_data.Reset();

}

/******************************************************************************
	Description : 레포트 조회
******************************************************************************/
function ln_PrintQuery(){

	var str1 = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");

	gcds_data_p.DataID = "/servlet/Contract.h080011_s3?"
								 + "v_str1=" + gclx_dept.bindcolval
								 + "&v_str2=" + gclx_ordcd.bindcolval
								 + "&v_str3=" + gcem_fr.text
								 + "&v_str4=" + gcem_to.text
								 + "&v_str5=" + fn_trim(str1);
	gcds_data_p.Reset();
}
/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
 	if (gcds_data.countrow <1) {
 		alert("발령작업 하실 정보가 없습니다.");
 	} else {
		if (confirm("해당 인사 발령요청 사항을 저장하겠습니까 ?")) {
			
			gcds_tr.DataID = "/servlet/Contract.h080011_s2?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"DEPTCD")
										 + "&v_str2=" + gcds_data.namevalue(gcds_data.rowposition,"ORDCD")
										 + "&v_str3=" + gcds_data.namevalue(gcds_data.rowposition,"ORDDT")
										 + "&v_str4=" + gcds_data.namevalue(gcds_data.rowposition,"ORDDT")
										 + "&v_str5=" + gcds_data.namevalue(gcds_data.rowposition,"EMPNO");

			// prompt("",gcds_tr.DataID);
  	  gcds_tr.Reset();
		}
 	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	var row = gcds_data.rowposition;
	if(gcds_data.namevalue(row,"APPDT") == "") {			
		if (confirm("선택하신 사항을 삭제하시겠습니까?")) {
			gcds_data.deleterow(row);
			//prompt('',gcds_data.text);
			gctr_data.KeyValue = "h080011_t1(I:USER=gcds_data)";
			gctr_data.Action = "/servlet/Contract.h080011_t1";
			 //prompt("",gcds_data.text);
			gctr_data.post();
			ln_Query();
		}
	} else {
		alert("인사적용된 사항이므로 삭제할 수 없습니다");
	}
}

/******************************************************************************
	Description : 비고 내용만 update 함
******************************************************************************/
function ln_Update(){
	
	if (gcds_data.IsUpdated ) {
		if (confirm("입력하신 비고란을 저장하시겠습니까?")) {
				gctr_data.KeyValue = "h080011_t2(I:USER=gcds_data)";
				gctr_data.Action = "/servlet/Contract.h080011_t2";
				//prompt('',gcds_data.text);
				gctr_data.post();			
				//return ln_Query();
		}
	} else{
		alert( "비고란이 수정 되지 않았습니다.");
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

	ln_PrintQuery();

	var	row = gcds_data_p.rowposition;
	if (gcds_data.countrow<1) alert("출력하실 자료가 없습니다");
	else if (gcds_data.sysStatus(row)=="1") alert("증명서 등록후 사용할수 있습니다.");
	else {
		var ls_ehtml = "";

		ls_ehtml += "EMPNO:STRING(7),ORDDT:STRING(8),SEQ:DECIMAL(2.0),ORDCD:STRING(2),DEPTCD:STRING(4),";
		ls_ehtml += "PAYGRD:STRING(4),PAYSEQ:STRING(4),ENDDT:STRING(8),APPDT:STRING(8),EMPNMK:STRING(20),";
		ls_ehtml += "REGDAT:STRING(8),DEPTNM:STRING(50),PAYGRDNM:STRING(30),BIRDT:STRING(8),DEPTPRT:STRING(30),";
		ls_ehtml += "JOBDTY:STRING(4),PREDEPT:STRING(50)";
	
		gcds_print.SetDataHeader(ls_ehtml);

		gcds_print.addrow();

		for (var i=1;i<=gcds_data_p.countcolumn;i++){
			gcds_print.namevalue(1,gcds_data_p.columnid(i)) = gcds_data_p.namevalue(row,gcds_data_p.columnid(i));
		}

		gcds_print.namevalue(1,"CURDT") = gs_date;
		if (fn_trim(gcds_print.namevalue(1,"ENDDT"))=="") gcds_print.namevalue(1,"ENDDT") = " ";
		
		gcrp_print1.preview();
	}		
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data.countrow<1) alert("다운로드 하실 자료가 없습니다");
	else gcgd_disp.runexcel("인사발령작업");	
}

/******************************************************************************
	Description : 선조회조건
******************************************************************************/
function ln_Before(){
	//소속코드
	gcds_dept.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_dept.Reset();

	//발령구분
	gcds_ordcd.DataID = "/servlet/Person.ordcode_s1?v_str1=1149";
	gcds_ordcd.Reset();

	//직위코드
	gcds_deptlvl.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_deptlvl.Reset();

	//호봉
	gcds_payseq.DataID = "/servlet/Person.hclcode_s1?v_str1=1184";
	gcds_payseq.Reset();

	//직책
	gcds_deptgb.DataID = "/servlet/Person.hclcode_s1?v_str1=2038";
	gcds_deptgb.Reset();

	//직급코드
	gcds_grddiv.DataID = "/servlet/Person.hclcode_s1?v_str1=2001";
	gcds_grddiv.Reset();

}

/******************************************************************************
	Description : 사원조회 2
******************************************************************************/
function ln_Find(e){
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H080011_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		txt_hdid.value = arrParam[1];
	} else {
		eval(e).value = "";
		txt_hdid.value = "";
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
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_ordcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+ordnm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_payseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptgb classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_tr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 레포트 -->
<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_p classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><OBJECT id=gcds_grddiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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

<script language="javascript" for="gcds_tr" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_tr" event="onloadCompleted()">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	alert("Completed");
</script>

<script language="javascript" for="gcds_tr" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	alert("error");
</script>

<script language="javascript" for="gcds_tr" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	  if (row <1) alert("인사발령작업이 실패하였습니다.1");
	 else {
	 
		if (gcds_tr.namevalue(1,"FLAG")=="Y") alert("인사발령작업에 성공하였습니다");
			else alert("인사발령작업이 실패하였습니다.2");
 	}
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

	ft_cnt.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.insertrow(1);
	gcds_dept.namevalue(1,"DEPTCD") = "";
	gcds_dept.namevalue(1,"DEPTNM") = "전체";
	gclx_dept.index = 0;
</script>

<script language="javascript" for="gcds_ordcd" event="onloadCompleted(row,colid)">
	gcds_ordcd.insertrow(1);
	gcds_ordcd.namevalue(1,"ordcd") = "";
	gcds_ordcd.namevalue(1,"ordnm") = "전체";
	gclx_ordcd.index = 0;
</script>

<script language="javascript" for="gcds_payseq" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

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
<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">

</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h080011_head.gif"></td>
		<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_save.gif"     style="cursor:hand" onclick="ln_Update()">
			<img src="../../Common/img/btn/com_b_banyoung.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()"> -->
			 <img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()"> 
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2>
			<table width="875" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan=8 align=center>
						<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:20px;font-size:9pt;border:0 solid #708090;border-top-width:1px;border-left-width:1px">
							<tr>
								<td class="tab11" width="70;" bgcolor="#eeeeee">소속</td>
								<td class="tab21" width="150px;">
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
								<td class="tab11" width="65" bgcolor="#eeeeee">구분</td>
								<td class="tab21" width="105px;">
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
								<td class="tab11" width="65" bgcolor="#eeeeee">일자</td>
								<td class="tab22" width="90px;">
									<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative; left:8px;top:3px; width:70px; font-family:굴림; font-size:9pt; " >
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
								  </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;top:2px;left:10px;cursor:hand;">
								</td>
								<td class="tab22" width="20px;" align="right">~</td>
								<td class="tab21" width="100px;">
									<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative; left:8px;top:3px; width:70px; font-family:굴림; font-size:9pt; " >
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
								  </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;top:2px;left:10px;cursor:hand;">
								</td>
								<td class="tab11" width="65" bgcolor="#eeeeee">성명</td>
								<td class="tab22" width="70px;"><input type=text id="txt_empnmk" class="txt11" style="width:60px;" readonly></td>
								<td class="tab21" width="50px"><input type="hidden" width="0" id="txt_hdid" name="txt_hdid"><img src="../../Common/img/btn/com_b_find.gif" alt="성명을 검색합니다" style="position:relative;left:3px;cursor:hand;" onclick="ln_Find('txt_empnmk')"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2" align=center valign=center> 
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp  
				style="width:874px;height:439px;border:1 solid #777777;">
					<PARAM NAME="DataID"			VALUE="gcds_data">
		      <PARAM NAME="Editable"		VALUE="true">
			    <PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Indwidth"		VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Format"			VALUE="  
						<C> Name='발령일자'			ID=ORDDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, edit=none Mask='XXXX/XX/XX' </C> 
						<C> Name='발령구분'			ID=ORDCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=85  	align=left,   edit=none EditStyle=lookup, Data='gcds_ordcd:ordcd:ordnm'  </C>
						<C> Name='사번'					ID=EMPNO	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  edit=none </C>
						<C> Name='성명'					ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    edit=none </C>
						<C> Name='직위'					ID=PAYGRD HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left,   edit=none  EditStyle=lookup, Data='gcds_deptlvl:minorcd:minornm'  </C>
						<C> Name='직급'				  ID=GRDDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=center, Edit=none, EditStyle=LookUp, Data='gcds_grddiv:minorcd:minornm' SHOW=ture, sort=true</C>
						<C> Name='호봉'					ID=PAYSEQ HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center, edit=none  EditStyle=lookup, Data='gcds_payseq:minorcd:minornm'  </C>
						<C> Name='소속명'				ID=DEPTCD HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left,   edit=none  EditStyle=lookup, Data='gcds_dept:deptcd:deptnm' </C>
						<C> Name='인사적용일'		ID=APPDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center, edit=none  Mask='XXXX/XX/XX' </C>
						<C> Name='비고'		      ID=ETC	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left,   BgColor=#ffffcc </C>
					">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="width:876px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
  </tr>
	<tr><td colspan="2" > * 저장버튼은 비고란에 입력된 데이터만 저장함.</td></tr>
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=   Ctrl=   Param=BindColVal</C>
		<C>Col=		Ctrl=   Param=BindColVal</C>
		<C>Col=		Ctrl=   Param=BindColVal</C>
		<C>Col=		Ctrl=		Param=BindColVal</C>
		<C>Col=		Ctrl=		Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------------------
출력물 정의부분
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2731 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1038 ,top=919 ,right=1388 ,bottom=1216 ,border=true</X>
	<X>left=1041 ,top=922 ,right=1384 ,bottom=1066 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=38 ,top=78 ,right=1944 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=38 ,top=919 ,right=388 ,bottom=1819 ,border=true</X>
	<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2612 ,right=1219 ,bottom=2716</I>
	<L> left=38 ,top=919 ,right=1941 ,bottom=919 </L>
	<L> left=38 ,top=1066 ,right=1941 ,bottom=1066 </L>
	<L> left=38 ,top=1369 ,right=1941 ,bottom=1369 </L>
	<L> left=38 ,top=1516 ,right=1941 ,bottom=1516 </L>
	<L> left=38 ,top=1666 ,right=1941 ,bottom=1666 </L>
	<L> left=1038 ,top=919 ,right=1038 ,bottom=1216 </L>
	<L> left=1384 ,top=919 ,right=1384 ,bottom=1216 </L>
	<T>id='부 임 명 령 서' ,left=44 ,top=200 ,right=1938 ,bottom=337 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상기와  같이  부임을  명함' ,left=44 ,top=1850 ,right=1938 ,bottom=1950 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CERTINO', left=138, top=503, right=600, bottom=603, align='left' ,mask='제 XXXX - XXXX 호', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=428, top=959, right=997, bottom=1025, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=428, top=1106, right=813, bottom=1172, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREDEPT', left=428, top=1253, right=809, bottom=1319, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTPRT', left=428, top=1416, right=1878, bottom=1481, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOBDTY', left=428, top=1569, right=1059, bottom=1634, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORDDT', left=428, top=1709, right=1053, bottom=1775, align='left' ,mask='XXXX년XX월XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BIRDT', left=1428, top=1106, right=1853, bottom=1172, align='left' ,mask='XXXX년XX월XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=1428, top=950, right=1856, bottom=1016, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='수     신 : ' ,left=138 ,top=612 ,right=403 ,bottom=709 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='참     조 : ' ,left=138 ,top=716 ,right=403 ,bottom=819 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTPRT', left=381, top=119, right=756, bottom=184, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=416, top=612, right=681, bottom=709, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=416, top=716, right=681, bottom=819, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(부임지) - ' ,left=138 ,top=100 ,right=369 ,bottom=197 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소     속' ,left=44 ,top=925 ,right=381 ,bottom=1062 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=38 ,top=1816 ,right=1941 ,bottom=1816 </L>
	<T>id='부 임 지' ,left=44 ,top=1375 ,right=381 ,bottom=1512 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='CURDT', left=44, top=2050, right=1806, bottom=2150, align='right' ,mask='XXXX년 XX월 XX일', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='관 리 지 원 본 부' ,left=44 ,top=2200 ,right=1806 ,bottom=2269 ,align='right' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 대   장  석  훈' ,left=44 ,top=2281 ,right=1806 ,bottom=2350 ,align='right' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=38 ,top=1212 ,right=1941 ,bottom=1212 </L>
	<T>id='성     명' ,left=44 ,top=1072 ,right=381 ,bottom=1209 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='직     책' ,left=44 ,top=1522 ,right=381 ,bottom=1662 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='전 소 속' ,left=44 ,top=1219 ,right=381 ,bottom=1366 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='직     위' ,left=1044 ,top=925 ,right=1381 ,bottom=1062 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='생년월일' ,left=1044 ,top=1072 ,right=1381 ,bottom=1209 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='발령일자' ,left=44 ,top=1672 ,right=381 ,bottom=1812 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>