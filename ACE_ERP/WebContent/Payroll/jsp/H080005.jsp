<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/인사조직검색
+ 프로그램 ID	: H080005
+ 기 능 정 의	: 조회,저장,삭제,출력
+ 변 경 이 력	: 
+ 서 블 릿 명	: h080005_s1, h080001_s0
------------------------------------------------------------------------------>

<html>
<head> 
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>인원조직검색</title>

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>


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
var gs_empno = "";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_date.text = gcurdate;
	ln_Before();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){

	gcds_data.DataID = "/servlet/Contract.h080005_s1?v_str1=" + e;
	gcds_data.Reset();
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

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

	if (gcds_data.countrow<1) {
		alert("출력하실 자료가 없습니다");
	} else {

	var THeader = "EMPNMK:STRING(20),DEPTNM:STRING(30),PAYGNM:STRING(30),STRTDT:STRING(8),"
							+ "PICFILE:STRING(100),CURDT:STRING(8)";

	gcds_print.SetDataHeader(THeader);

	var level0 = gcds_before.namevalue(gcds_before.rowposition,"DEPTCD").substring(0,1);
	var treecd = gcds_before.namevalue(gcds_before.rowposition,"TREECD").substring(0,4);

	var level3 = gcds_before.namevalue(gcds_before.rowposition,"DEPTCD").substring(0,2);

	for (j=1;j<=gcds_before.countrow;j++) {
		//조직도에서 2레벨의 소속코드 길이가 1자, 조직코드가 4자인것을 2레벨로 강제 바꿔서 소속코드와 소속명을 변수에 넣어둔다.
		if (gcds_data.namevalue(gcds_data.rowposition,"LEVEL") =='3') {				//3레벨 인경우
			if(gcds_before.namevalue(j,"DEPTCD").substring(0,1) == level0 && gcds_before.namevalue(j,"LEVEL") == '2' 
				&& gcds_before.namevalue(j,"TREECD").substring(0,4) == treecd) {
				gcds_before.namevalue(j,"LEVEL") ='2';
				var level2nm = gcds_before.namevalue(j,"DEPTNM");
			}
		}else if(gcds_data.namevalue(gcds_data.rowposition,"LEVEL") =='4') {	//4레벨 인경우		
			if (gcds_before.namevalue(j,"DEPTCD").substring(0,2) == level3 && gcds_before.namevalue(j,"LEVEL") == '3' 
				&& gcds_before.namevalue(j,"TREECD").substring(0,4) == treecd) {
				gcds_before.namevalue(j,"LEVEL") ='3';
				var level2nm = gcds_before.namevalue(j,"DEPTNM");
			}
		}
	}

	for(i=1;i<=gcds_data.countrow;i++) {
		
		gcds_print.addrow();

		if (gcds_data.namevalue(i,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data.namevalue(i,"empno");
			photo.src="/servlet/Contract.h080001_s0?v_str1="+str1;
		}

		gcds_print.namevalue(i,"PICFILE") =  photo.src;

		//소속 - 팀별 조회 Default[LEVEL - 2]
		if (gcds_data.namevalue(i,"DEPTCD") == 'A000') {
			gcds_print.namevalue(i,"DEPTNM")  =  "현대아산" + " / " + gcds_data.namevalue(i,"DEPTNM");
		}else if (gcds_data.namevalue(i,"LEVEL") =='2') {
			gcds_print.namevalue(i,"DEPTNM")  =  "현대아산" + " / " + gcds_data.namevalue(i,"DEPTNM");
		}else if (gcds_data.namevalue(i,"LEVEL") =='3') {
			gcds_print.namevalue(i,"DEPTNM")  =  level2nm + " / " + gcds_data.namevalue(i,"DEPTNM");
		}else if (gcds_data.namevalue(i,"LEVEL") =='4') {
			gcds_print.namevalue(i,"DEPTNM")  =  level2nm + " / " + gcds_data.namevalue(i,"DEPTNM");
		}else{			
			gcds_print.namevalue(i,"DEPTNM")  =  level2nm + " / " + gcds_data.namevalue(i,"DEPTNM");
		}

		gcds_print.namevalue(i,"PAYGNM")  =  gcds_data.namevalue(i,"PAYGNM");
		gcds_print.namevalue(i,"EMPNMK")  =  gcds_data.namevalue(i,"EMPNMK");
		gcds_print.namevalue(i,"STRTDT")  =  gcds_data.namevalue(i,"STRTDT");
		gcds_print.namevalue(1,"CURDT")   =  gs_date;
	}

	gcrp_print.preview();

	}//end if
}


/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data.countrow<1) alert("다운로드 하실 자료가 없습니다");
	else gcgd_disp.runexcel("인원조직검색");
}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Before(){
	//소속
	//gcds_before.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_before.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	gcds_before.Reset();

	//직원구분
	gcds_empdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1119";
	gcds_empdiv.Reset();

	//직군
	gcds_jobgrph.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000";
	gcds_jobgrph.Reset();

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_before classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_empdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobgrph classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_before" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

	ft_cnt.innerText = "조회건수 : " + row + " 건";
	if (row>0){
		if (gcds_data.namevalue(1,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data.namevalue(1,"empno");
			photo.src="/servlet/Contract.h080001_s0?v_str1="+str1;
		}
	} else {
		photo.src="photo/00000.gif";
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_jobgrph" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
	if (gcds_data.namevalue(row,"picture")=="") {
		photo.src="photo/00000.gif";
	} else {
		var str1 = gcds_data.namevalue(row,"empno");
		photo.src="/servlet/Contract.h080001_s0?v_str1="+str1;
	}
</script>

<script language="javascript" for="gcte_data" event="onClick()">
	var e = gcds_before.namevalue(gcds_before.rowposition,"DEPTCD");
	ln_Query(e);
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width=100% height="25px" colspan="3">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
			  <tr> 
			    <td width="215" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/h080005_head.gif" width=197></td>
			    <td width="799" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:2px;">
						
			      <table cellpadding=0 cellspacing=0 border=0>
							<tr>
								<td width="150px;">
									<comment id="__NSID__"><OBJECT id=gcem_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative; left:1px;top:5px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Enable	      value=false>
											<param name=Format	      value="YYYY년 MM월 DD일">
											<param name=PromptChar	  value="_">
							    </OBJECT></comment><script>__ws__(__NSID__);</script>
								</td>
								<td><img name="btn_print" border="0" src="../../Common/img/btn/com_b_print.gif" style="position:relative; left:-6px;cursor:hand" onclick="ln_Print()"><img name="btn_excel" border="0" src="../../Common/img/btn/com_b_excel.gif" style="position:relative; left:-3px;cursor:hand" onclick="ln_Excel()"></td>
							</tr>
						</table>
					</td>
			  </tr>
		  </table>
	  </td>
	</tr>
	<tr>
   <td width="230">
			<comment id="__NSID__"><OBJECT id="gcte_data" classid="clsid:4401B994-DD33-11D2-B539-006097ADB678" 
				style="position:relative;left:3px;border:1 solid #708090; width:220px; height:470px; font-size:9pt"> 
				<Param Name="DataID"		value="gcds_before">
				<Param Name="TextColumn"	value="DEPTNM">
				<Param Name="LevelColumn"	value="LEVEL">
				<Param Name="BorderStyle"	value="0">
				<param name="useimage"		value="false">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
		<td>
			<table cellpadding=0 cellspacing=0 border=0 >
			  <tr>
				  <td>
						<comment id="__NSID__"><OBJECT id="gcgd_disp" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:319px;width:645;border:1 solid #708090">
		            <param name=dataid				value=gcds_data>
								<param Name=BorderStyle   value=0> 
								<param name=fillarea      value=true>
								<param name=Indwidth      value='0'>
				   			<param name=format        value='
									<F>ID=EMPNO,		Name=사번,			width=65,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center</F>
									<F>ID=EMPNMK,		Name=성명,			width=65,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
									<F>ID=DEPTNM,		Name=소속명,		width=158,	HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
									<C>ID=PAYGNM,		Name=직위명,		width=85,		HeadBgColor=#B9D4DC, align=left</C>
									<C>ID=STRTDT,		Name=입사일,		width=75,		HeadBgColor=#B9D4DC, align=center, MASK="XXXX/XX/XX"</C>

									<C>ID=TODT,			Name=계약만료일,width=75,		HeadBgColor=#B9D4DC, align=center, MASK="XXXX/XX/XX"</C>
									<C>ID=JOBNM,		Name=직종,			width=80,		HeadBgColor=#B9D4DC, align=left</C>
									<C>ID=PAYSEQ,		Name=급호,			width=40,		HeadBgColor=#B9D4DC, align=CENTER, MASK="XX호"</C>
					        
									<C>ID=JOBGRPH,	Name=직군,			width=85,		HeadBgColor=#B9D4DC, align=left, Editstyle=lookup, Data="gcds_jobgrph:minorcd:minornm"</C>
				      '>
						</OBJECT></comment><script>__ws__(__NSID__);</script><br>
						<fieldset style="width:647;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
			<table cellpadding=0 cellspacing=0 border=0>
				<tr><td height="2px;"></td></tr>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="border:1 solid #708090" width="125px" align=center><img id="photo" src="./photo/00000.gif" border=0 width="85px" height="100px"></td>
								<td>
									<table width=100% border="0" cellpadding=0 cellspacing=0 style="border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;">
										<tr>
											<td class="tab12" width="80px;" bgcolor="#eeeeee">성명</td>
			                <td class="tab23" width="140px;"><input type="text" id=txt_empnmk class="txt11" style="width:100px;border:0" disabled></td>
						          <td class="tab12" width="80px;" bgcolor="#eeeeee">사번</td>
									    <td class="tab23" width="215px"><input type="text" id=txt_empno class="txt11" style="width:60px;border:0" disabled></td>
			              </tr> 
									</table>
									<table width=100% border="0"  cellpadding=0 cellspacing=0>
			              <tr>
											<td class="tab11" width="80px;" bgcolor="#eeeeee">주민번호</td>
											<td class="tab21" width="140px;" >
												<comment id="__NSID__"><OBJECT id=gcem_resno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:3px; width:120px; height:17px; font-family:굴림; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="000000-0000000">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
			                <td class="tab11" width="80px;" bgcolor="#eeeeee">생년월일</td>
						          <td class="tab21">
												<comment id="__NSID__"><OBJECT id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:1px; width:70px; height:17px; font-family:굴림; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
												<comment id="__NSID__"><OBJECT id=gcra_gldiv classid=clsid:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
													style="position:relative; left:4px;top:1px; width:100px; height:20px; font-size:9pt;">
														<param name=Cols		value="2">
														<param name=Format	value="1^음력,2^양력">
														<param name=Enable	value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
									<table width=100% border="0"  cellpadding=0 cellspacing=0>
						        <tr> 
											<td class="tab11" width="80px" bgcolor="#eeeeee">소속직위</td>
			                <td class="tab21" width="260px;" colspan="3">
												<input type="text" id=txt_deptnm class="txt11" style="position:relative;top:3px;width:80px;border:0" disabled>
												<input type="text" id=txt_paygnm class="txt11" style="position:relative;top:3px;width:80px;border:0" disabled>
												<input type="text" id=txt_grddnm class="txt11" style="position:relative;top:3px;width:80px;border:0" disabled>
											</td>
								      <td class="tab11" width="80px;" bgcolor="#eeeeee">직군구분</td>
									    <td class="tab21" width="89px;">
			 									<comment id="__NSID__"><OBJECT id=gclx_jobgrph classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 													style="position:relative;left:8px;top:1px;font-size:12px;width:75px;">
														<param name=ComboDataID			value="gcds_jobgrph">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
  													<param name=ListExprFormat	value="MINORNM^0^100">
	 													<param name=BindColumn			value=MINORCD>
														<param name=Enable					value=false>
			 									</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
			              </tr>
									</table>
									<table width=100% border="0"  cellpadding=0 cellspacing=0>
										<tr> 
											<td class="tab11" width="80px;" bgcolor="#eeeeee">소속발령</td>
											<td class="tab21" width="90px;">
												<comment id="__NSID__"><OBJECT id=gcem_dpoffdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:dotum; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">직위발령</td>
                      <td class="tab21" width="92px;">
												<comment id="__NSID__"><OBJECT id=gcem_lamdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:dotum; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">그룹입사일</td>
                      <td class="tab21" width="88px;">
												<comment id="__NSID__"><OBJECT id=gcem_grstrtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:dotum; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                    </tr>
										<tr>
                      <td class="tab11" bgcolor="#eeeeee">직원구분</td>
                      <td class="tab21" >
			 									<comment id="__NSID__"><OBJECT id=gclx_empdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 													style="position:relative;left:8px;top:1px;font-size:12px;width:75px;">
														<param name=ComboDataID			value="gcds_empdiv">
														<param name=CBDataColumns		value="MINORCD, MINORNM">
														<param name=SearchColumn		value=MINORNM>
														<param name=Sort						value=false>
  													<param name=ListExprFormat	value="MINORNM^0^100">
	 													<param name=BindColumn			value=MINORCD>
														<param name=Enable					value=false>
			 									</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" bgcolor="#eeeeee">퇴사일</td>
                      <td class="tab21">
												<comment id="__NSID__"><OBJECT id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:dotum; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" bgcolor="#eeeeee">입사일</td>
                      <td class="tab21">
												<comment id="__NSID__"><OBJECT id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:dotum; font-size:9pt;">
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=Enable	      value=false>
														<param name=PromptChar	  value="_">
										    </OBJECT></comment><script>__ws__(__NSID__);</script>
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

<comment id="__NSID__"><OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=EMPNMK       Ctrl=txt_empnmk       Param=value</C>
		<C>Col=EMPNO        Ctrl=txt_empno        Param=value</C>
		<C>Col=RESINO				Ctrl=gcem_resno				Param=text</C>
		<C>Col=BIRDT				Ctrl=gcem_birdt				Param=text</C>
		<C>Col=GRSTRTDT     Ctrl=gcem_grstrtdt    Param=text</C>
		<C>Col=STRTDT				Ctrl=gcem_strtdt			Param=text</C>
		<C>Col=GLDIV				Ctrl=gcra_gldiv				Param=codevalue</C>
		<C>Col=DPOFFDT	    Ctrl=gcem_dpoffdt			Param=text</C>
		<C>Col=ENDDT		    Ctrl=gcem_enddt				Param=text</C>
		<C>Col=EMPDIV		    Ctrl=gclx_empdiv			Param=BindColVal</C>
		<C>Col=JOBGRPH	    Ctrl=gclx_jobgrph			Param=BindColVal</C>
		<C>Col=DEPTNM       Ctrl=txt_deptnm       Param=value</C>
		<C>Col=LAMDT 		    Ctrl=gcem_lamdt				Param=text</C>
		<C>Col=PAYGNM	      Ctrl=txt_paygnm       Param=value</C>
		<C>Col=GRDDNM	      Ctrl=txt_grddnm       Param=value</C>
	'>
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 Ⅱ : 개인기본정보 출력
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="False">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=450 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=609 ,top=241 ,right=1203 ,bottom=241 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='인 사 기 본 정 보' ,left=503 ,top=125 ,right=1313 ,bottom=231 ,face='HY헤드라인M' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=6 ,top=450 ,right=1844 ,bottom=450 </L>
	<C>id='CURDT', left=1297, top=384, right=1834, bottom=441, align='right' ,mask='발행일자 : XXXX-XX-XX', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=412 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=13 ,top=6 ,right=328 ,bottom=409 ,border=true</X>
	<L> left=13 ,top=6 ,right=328 ,bottom=6 </L>
	<L> left=509 ,top=306 ,right=1838 ,bottom=306 </L>
	<L> left=509 ,top=206 ,right=1838 ,bottom=206 </L>
	<L> left=509 ,top=106 ,right=1838 ,bottom=106 </L>
	<C>id='DEPTNM', left=719, top=12, right=1834, bottom=103, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=325 ,top=6 ,right=700 ,bottom=109 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소속' ,left=331 ,top=12 ,right=694 ,bottom=103 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=325 ,top=106 ,right=700 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=325 ,top=206 ,right=700 ,bottom=309 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=325 ,top=306 ,right=700 ,bottom=409 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=16 ,top=6 ,right=1839 ,bottom=6 </L>
	<T>id='직위' ,left=331 ,top=112 ,right=694 ,bottom=203 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='성명' ,left=331 ,top=212 ,right=694 ,bottom=303 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='입사일' ,left=331 ,top=312 ,right=694 ,bottom=403 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='PAYGNM', left=719, top=112, right=1834, bottom=203, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=719, top=212, right=1834, bottom=303, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STRTDT', left=719, top=312, right=1834, bottom=403, align='left' ,mask='XXXX/XX/XX', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='PICFILE' ,left=14 ,top=7 ,right=325 ,bottom=409</I>
	<L> left=13 ,top=409 ,right=1839 ,bottom=409 </L>
	<L> left=1838 ,top=8 ,right=1838 ,bottom=409 </L>
	<L> left=1844 ,top=0 ,right=1844 ,bottom=416 </L>
	<L> left=6 ,top=0 ,right=6 ,bottom=416 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=134 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=6 ,top=3 ,right=1844 ,bottom=3 </L>
	<I>id='../../Common/img/icon.jpg' ,left=722 ,top=34 ,right=1200 ,bottom=134</I>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>