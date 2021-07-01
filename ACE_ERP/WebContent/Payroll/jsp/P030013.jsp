<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	연말정산제출관리
+ 프로그램 ID	: P030013.HTML
+ 기 능 정 의	: 조회,권한
+ 변 경 이 력	: 
+ 서 블 릿 명	: P030013_s1, P030013_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>연말정산제출관리</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>


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
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_Before();

	gcem_year.text = "2010";

	gcem_year.enabled=false;

	gcra_caldiv.CodeValue = 2;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
if(gcra_caldiv.CodeValue == 1){
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P030013_s1?v_str1="+gcem_year.text;
								//	 prompt('',gcds_data.DataID);

		gcds_data.Reset();
	}else if (gcra_caldiv.CodeValue == 2){
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P030013_s2?v_str1="+gcem_year.text;
								//	 prompt('',gcds_data.DataID);

		gcds_data.Reset();
	}
}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	
}

/******************************************************************************
	Description : 권한반영
******************************************************************************/
function ln_Apply(){
	if (gcds_data.IsUpdated ){
			if (confirm("해당 직원에 대한 연말전산제출을 취소하시겠습니까 ?")) {
				ln_Chk();
				gctr_data.KeyValue = "Payroll.P030013_t1(I:USER=gcds_data)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P030013_t1";
				//prompt('',gcds_data.text);
				gctr_data.post();
			}
	}
}



	
/******************************************************************************
	Description : 체크값 변경
******************************************************************************/
function ln_Chk(){
	for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"BCHK")=="T"){
				gcds_data.namevalue(i,"SENDFLAG")='' ;
			}
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
	if (gcds_data.countrow<1) alert("다운로드 하실 자료가 없습니다");
	else gcgd_disp.RunExcel("연말정산제출관리");
}

/******************************************************************************
	Description : 선조회조건
******************************************************************************/
function ln_Before(){
	//소속코드2
	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_dept2.Reset();

	//직위코드
	gcds_deptlvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_deptlvl.Reset();

	//직위코드
	gcds_deptlv2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_deptlv2.Reset();


}

/******************************************************************************
	Description : 헤더생성
******************************************************************************/
function ln_SetHeader(){
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>



<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><OBJECT id=gcds_deptlv2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+seq">
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
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
		 
</script>





<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_disp event=OnClick(row,colid)>

	if(row==0&&colid=="BCHK"){
		if(gcds_data.namevalue(1,"BCHK")=="T"){
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,"BCHK")="F";
			}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,"BCHK")="T";
			}
		}
	}

 </script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
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
    <td><img src="../img/P030013_head.jpg"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			<img src="../../Common/img/btn/com_b_reflect.gif" style="cursor:hand" onclick="ln_Apply()">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
		</td>
  </tr>
	<tr> 
    <td colspan=2>
			<table width="876" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan=8 align=center>
						<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;border:0 solid #708090;border-top-width:1px;border-left-width:1px'>
							<tr>
								<td class="tab11" width="80px" bgcolor="#eeeeee">귀속년도</td>
								<!--<td class="tab21"><input type=text class="txt11" id=txt_year name=txt_year></td>-->
						<td width="0" width="100px" class="tab21" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcem_year classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="1"
                style="position:relative; left:5px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
                validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true> 
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY">
										<param name=MaxLength     value=4>
										<param name=PromptChar    value="_">
										<param name=IsComma   3    value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;</td>
							<td class="tab11" width="80px" bgcolor="#eeeeee">제출상태</td>
							<td width="0" class="tab21" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcra_caldiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:200;cursor:hand;" class="txtbox">
										<param name=Cols     value="3">
										<param name=Format   value="1^제출,2^미제출">
									</object></comment><script>__ws__(__NSID__);</script>
								</td> 
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
								<td style="width:876" align=center>
									<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp  
										style="width:876px;height:437px;border:1 solid #777777;z-index:2;">
										<PARAM NAME="DataID"				VALUE="gcds_data">
			              <PARAM NAME="Editable"			VALUE="True">
						        <PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="Indwidth"			VALUE="0">
										<param name="Fillarea"			VALUE="true">
										<PARAM NAME="SortView"			VALUE="left">
										<PARAM NAME="ColSizing"			VALUE="true">
									  <PARAM NAME="Format"				VALUE="  
	<F> Name='선택'				ID=BCHK			HeadAlign=Center HeadBgColor=#B9D4DC width=120 align=center, bgcolor=#f5f5f5, EditStyle=CheckBox, cursor=hand</F>
	<F> Name='사번'				ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=center,	bgcolor=#f5f5f5, Edit=none,sort=true  </F> 
	<F> Name='성명'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=left,		bgcolor=#f5f5f5, Edit=none,sort=true </F>
  <C> Name='소속'				ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=210 align=left, EditStyle=lookup, Data='gcds_dept2:deptcd:deptnm', edit=none </C>
  	<C> Name='직위'				ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left,		Edit=none  EditStyle=lookup, Data='gcds_deptlv2:minorcd:minornm', sort=true</C>
	<C> Name='제출상태'				ID=SENDFLAG		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=center,	Edit=none,  EditStyle=Combo Data='Y:제출,N:미제출', sort=true</C>
	<F> Name='제출 flag'			ID=SENDFLAG AS FLAG		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left,		bgcolor=#f5f5f5, Edit=none, sort=true show=false</F> 
										">
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<fieldset style="width:876px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
									</fieldset>
                </td>
       					<td style="padding-left:3px;">

								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
		</td>
	</tr>
</table>



<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>