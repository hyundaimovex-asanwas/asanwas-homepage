<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사고과관리 - 피고과자선정
+ 프로그램 ID	:   H060002.HTML
+ 기 능 정 의	:   
+ 변 경 이 력	: 
+ 서 블 릿 명	:   h060002_s1, hclcode_s1, h060002_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>피고과자선정</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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
var strgcem_yyymm
var gs_level;
var gs_treecd;

get_cookdata();
lfn_init();

/******************************************************************************
	Description : 페이지 로딩                      
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yymm.text = gcurdate.substring(0,7); 
  strgcem_yyymm= gcem_yymm.text;

	//공통코드
	ln_Luxecombo_load();  
	gcrd_gubun.codevalue='1';
}


/******************************************************************************
	Description : 생성
******************************************************************************/
function ln_Popup(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]	= "0";
	strURL = "./H060002_popup.html";
	strPos = "dialogWidth:575px;dialogHeight:330px;status:yes;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  if(gcrd_gubun.codevalue=="1"){
		gcds_data.DataID="/servlet/Person.h060002_s1?v_str1="+fn_trim(gcem_yymm.text)
																											 +"&v_str2="+fn_trim(gclx_deptcd.bindcolval)
																											 +"&v_str3="+fn_trim(gclx_paygrd.bindcolval)
																											 +"&v_str4="+fn_trim(txt_name.value)
																											 +"&v_str5="+gs_level
																											 +"&v_str6="+gs_treecd;
		gcds_data.Reset();  
	}else if(gcrd_gubun.codevalue=="2"){
		gcds_data.DataID="/servlet/Person.h060002_s2?v_str1="+fn_trim(gcem_yymm.text);
		gcds_data.Reset();
	}
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

	if (gcds_data.countrow<1){
			alert ("저장할 정보가 없습니다.");
	}else {
		if (confirm("선택한 정보를 저장하시겠습니까?")){
			gctr_data.action = "/servlet/Person.h060002_t1";
			gctr_data.post();
			ln_Query()
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	
	if(gcrd_gubun.codevalue=="1"){ //일반
		if (gcds_data.countrow<1){
			alert ("삭제할 정보가 없습니다.");
		}else {
			if (confirm("선택한 정보를 삭제하시겠습니까?")){
				gcds_data.deleterow(gcds_data.rowposition);
				gctr_data.action = "/servlet/Person.h060002_t1";
				//prompt('',gcds_data.text);
				gctr_data.post();
				//ln_Query()
			}
		}
	}else if(gcrd_gubun.codevalue=="2"){ //부서장
		if (gcds_data.countrow<1){
			alert ("삭제할 정보가 없습니다.");
		}else {
			if (confirm("선택한 정보를 삭제하시겠습니까?")){
				gcds_data.deleterow(gcds_data.rowposition);
				gctr_data.action = "/servlet/Person.h060002_t4";
				//prompt('',gcds_data.text);
				gctr_data.post();
				ln_Query()
			}
		}
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	//gcds_data.UndoAll()
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	alert("개발중입니다.");
	//var THeader="FRDATE:STRING(10),TODATE:STRING(10),CUDATE:STRING(10)";
	//gcds_print_param.SetDataHeader(THeader);
	//gcds_print_param.addrow();

	//gcds_print_param.namevalue(1,"FRDATE") = ADE_EMEdit_monthFr.text;
	//gcds_print_param.namevalue(1,"TODATE") = ADE_EMEdit_monthTo.text;
	//gcds_print_param.namevalue(1,"CUDATE") = "20040729";

	//gcpt_create.PreView();
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_create.RunExcel('피고과자선정');
}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){
	
}

/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//소속
	gcds_deptcd.DataID = "/servlet/Person.hcdept_s2?";  
	gcds_deptcd.Reset();
    
	//직위
	gcds_paygrd.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";  
	gcds_paygrd.Reset();

	//직군
	gcds_jobref.DataID = "/servlet/Person.hclcode_s1?v_str1=2034";  
	gcds_jobref.Reset();

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_deptcd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<!-- <param name="SortExpr" value="+TREECD"> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_paygrd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<!-- <param name="SortExpr" value="+MINORNM"> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_jobref classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<!-- <param name="SortExpr" value="+MINORNM"> -->
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060002_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
	gcds_paygrd.insertrow(1);
	gcds_paygrd.namevalue(1,"MINORCD") = "";
	gcds_paygrd.namevalue(1,"MINORNM") = "전체";
	gclx_paygrd.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);
		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>


<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>



<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px"  >
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h060002_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_create.gif"	style="cursor:hand" onclick="ln_Popup()">
			<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand"	onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
	</tr>
  <tr>
    <td COLSPAN=2 valign="top">
			<table  cellpadding="0" cellspacing="0" border="0"      
	   style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
						<td width="50"  style="border:0 solid #708090;border-right-width:1px;text-align:center" bgcolor="#eeeeee" > <nobr>고과년월</nobr></td>
						<td width="70"  style="border:0 solid #708090;border-right-width:1px;"><nobr>
							<comment id="__NSID__">
							<object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
							style="position:relative; left:1px;top:3px; width:50px; height:20px; font-family:굴림; font-size:9pt; "> 
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
						</td>
						<td width="50"  style="border:0 solid #708090;border-right-width:1px;text-align:center"		bgcolor="#eeeeee"><nobr>소속</nobr></td>
						<td width="150" style="border:0 solid #708090;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=400 width=150   style="position:relative;left:2px;top:2px;">
									<param name=ComboDataID           value=gcds_deptcd>
									<param name=CBDataColumns		      value="DEPTCD, DEPTNM">
									<param name=SearchColumn          value="DEPTNM">
									<param name=Sort                  value= false>
									<param name=ListExprFormat        value="DEPTNM^0^140">       
									<param name=BindColumn            value="DEPTCD"> 
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>  
						<td width="50"   style="border:0 solid #708090;border-right-width:1px;;text-align:center" bgcolor="#eeeeee"><nobr>직위</nobr></td>
						<td width="150"  style="border:0 solid #708090;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=140  style="position:relative;left:2px;top:2px;">
									<param name=ComboDataID           value=gcds_paygrd>
									<param name=CBDataColumns					value="MINORCD, MINORNM">
									<param name=SearchColumn          value=" MINORNM">
									<param name=Sort                  value=false>
									<param name=ListExprFormat        value="MINORNM">       
									<param name=BindColumn            value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>			
							&nbsp;&nbsp;</nobr></td>  
						<td width="50"  style="border:0 solid #708090;border-right-width:1px;;text-align:center" bgcolor="#eeeeee"><nobr>성명</nobr></td> 
						<td width="60" Style="border:0 solid #708090;border-right-width:1px;"><nobr>   
							<input id="txt_name" name="txt_name" type="text" class="txt11" style="width:60px;position:relative;left:2px"   onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td>	
						
            <td width="50"  style="border:0 solid #708090;border-right-width:1px;;text-align:center" bgcolor="#eeeeee"><nobr>구분</nobr></td> 
						<td width="120" Style="border:0 solid #708090;border-bottom-width:0px"><nobr>  
					   <comment id="__NSID__">
							 <object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:120">
								<param name=Cols	  value="2">
								<param name=Format	value="1^일반,2^부서장">
							</object>
						 </comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
			    	</td>
				</tr>
			</table>
	</td>
  </tr>
  
  <tr> 
  <td height=3></td>
  </tr>  

  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td  >
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  
					style="WIDTH: 875px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
					  <param name="dataid"		  value="gcds_data">
					  <param name="editable"    value="true">
					  <param name="borderstyle" value="0">
					  <param name="fillarea"		value="true">
            <param name=SortView			value="Left">
					  <param name="format"		  value="  
						<C> Name='사번'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  sort=true	edit=none</C>
						<C> Name='소속'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=LEFT		sort=true	edit=none</C>
						<C> Name='직위'			ID=GRDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		sort=true	edit=none</C>
						<C> Name='성명'			ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		sort=true edit=none</C>
						<C> Name='입사구분' ID=RECNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=left		sort=true	edit=none</C>
						<C> Name='직종'			ID=JOBREF		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  sort=true	 Editstyle='lookup' Data='gcds_jobref:MINORCD:MINORNM' show=true</C>
						<C> Name='그룹입사일'		ID=GRSTRTDT HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center  mask='XXXX/XX/XX' edit=none	sort=true</C>
						<C> Name='입사일' ID=STRTDT HeadAlign=Center HeadBgColor=#B9D4DC	 Width=90		align=center  mask='XXXX/XX/XX' edit=none	sort=true</C>
						<C> Name='최종승진일' ID=LAMDT HeadAlign=Center HeadBgColor=#B9D4DC	 Width=90		align=center  mask='XXXX/XX/XX'	edit=none	sort=true</C>
						<C> Name='생성고과년월' ID=WRDT HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX'		edit=none	sort=true</C>	
							">
					</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
		
        </tr>
      </table>
    </td>
  </tr>
  <tr>
		<td height="24" border= 1>조회건수 : <label id="lbl_search"></label></td>
  </tr>	

</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>