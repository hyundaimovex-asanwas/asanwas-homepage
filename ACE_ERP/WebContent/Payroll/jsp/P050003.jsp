<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/소득집계관리
+ 프로그램 ID	: p050003.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제|실행|엑셀|파일
+ 변 경 이 력	: 권영법
+ 수 정 이 력	: 이순미 - 2005.08.05 - 소스 정리
+ 서 블 릿 명	: p050003_s1, p050003_s2, p050003_t1, p050003_t2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>소득집계관리</title>


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
var curtid = "88001";  
var key_sabun="";
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
gs_date3 = gcurdate.substring(0,4);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yymm_search.Text=gs_date2;          //기준년월
	gcem_yymm_search2.Text=gs_date3;         //기준년월
 
	//소속정보 1
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();

	//소속정보 2
	gcds_dept2.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept2.Reset();

	//보험구분 1
	gcds_select_bgubun_1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1169"; 
	gcds_select_bgubun_1.Reset();

	//보험구분2
	gcds_select_bgubun_2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1169"; 
	gcds_select_bgubun_2.Reset();

	var Obj="div_zipcode";
	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");

  for(var i=0;i<=3;i++) {
		if(div_cm[i]==Obj) {
			eval("document.all."+Obj+".style.display='block';");
		} else {
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
  }
}

/******************************************************************************
	Description : 조회 1
******************************************************************************/
function ln_Query_1(){
	var str1 = fn_trim(gclx_select_bgubun_1.BindColVal);        //보험구분
	var str2 = fn_trim(gcem_yymm_search.Text);									//기준년월
	var str3 = fn_trim(gclx_select_ec02az.BindColVal);		      //소속
	var str4 = fn_trim(txt_empnmk_1.value);											//성명
	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4;
	gcds_grid_ec01az.Reset(); //그리드
	gcds_grid_ec01az.rowposition=1;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query_2(){
	var str1 = ""; // fn_trim(gclx_select_bgubun_2.BindColVal);	//보험구분
	var str2 = fn_trim(gcem_yymm_search2.Text);									//기준년월
	var str3 = fn_trim(gclx_select_ec03az.BindColVal);					//소속
	var str4 = fn_trim(txt_empnmk_2.value);											//성명

	gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_s2?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4;
	gcds_grid_ec02az.Reset(); //그리드
	gcds_grid_ec02az.rowposition=1;
}

/******************************************************************************
	Description : 저장 1
******************************************************************************/
function ln_Save_1(){
	if (gcds_grid_ec01az.IsUpdated) {
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			gctr_grade1.KeyValue = "p050003_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t1";
			gctr_grade1.post();
		}
	}
}

/******************************************************************************
	Description : 저장 2
******************************************************************************/
function ln_Save_2(){
	if (gcds_grid_ec02az.IsUpdated) {
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			gctr_grade2.KeyValue = "p050003_t2(I:USER=gcds_grid_ec02az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t2";
			gctr_grade2.post();
		}
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Exec_1(){

}

/******************************************************************************
	Description : 삭제 1
******************************************************************************/
function ln_Del_1(){
	if (gcds_grid_ec01az.countrow >0) {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_grid_ec01az.deleterow(gcds_grid_ec01az.rowposition);
			gctr_grade1.KeyValue = "p050002_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t1";
			gctr_grade1.post();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del_2(){
	if (gcds_grid_ec02az.countrow >0) {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_grid_ec02az.deleterow(gcds_grid_ec02az.rowposition);
			gctr_grade2.KeyValue = "p050003_t2(I:USER=gcds_grid_ec02az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050003_t2";
			gctr_grade2.post();
		}
	}
}

/******************************************************************************
	Description : 파일열기
******************************************************************************/
function ln_FileOpen_2(){
	var str1=gcem_yymm_search2.Text;
	inp_File_2.Open();

	var str2=fn_trim(inp_File_2.Value);
	var str3=str2.substr(str2.length-3,3).toLowerCase();
	if(str2=="")
		alert("파일을 선택하세요");
	else if(str3 !="csv")
	{
	  inp_File_2.Value="";
		alert("CSV확장자 파일을 선택하세요");
	}
	else if(str1.length != 4)
		alert("기준년월을 4자리를 정확히 입력하세요");
	else
		ln_File_2();
}

/******************************************************************************
	Description : 데이터 임포트
******************************************************************************/
function ln_File_2(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";

	var THeader = "STDYM:String(6),"	
						+"GRDCD:Decimal(3),"   
						+"LOWAMT:Decimal(9),"   
						+"HIGAMT:Decimal(9),"	
						+"STDAMT:Decimal(9),"	
						+"INSSUM:Decimal(9),"	
						+"INSAMT1:Decimal(9),"	
						+"INSAMT2:Decimal(9)";	
	gcds_dump.DataID = inp_File_2.Value;
	gcds_dump.Reset();
	gcds_grid_ec02az.SyncLoad=true;
	gcds_grid_ec02az.ClearAll();
	gcds_grid_ec02az.DataID = "";
	gcds_grid_ec02az.SetDataHeader(THeader);
	var ls_pd = gcem_yymm_search2.Text;
	//ls_pd = ls_pd.substring(0,4) + "-" + ls_pd.substring(4,6) + "-" + ls_pd.substring(6,8);
	//if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd) alert("ok");
	for (var j=1; j<=gcds_dump.countrow;j++){
		if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd){
			gcds_grid_ec02az.addrow();
			var ls_pos = gcds_grid_ec02az.rowposition;
			for (var i=1; i<9; i++) {
			 gcds_txt=fn_trim(gcds_dump.ColumnValue(j,i));
			 gcds_txt=ln_Ltrim(gcds_txt,",");
			 gcds_grid_ec02az.ColumnValue(ls_pos,i) = gcds_txt;
			}
		}
	}
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + gcds_grid_ec01az.countrow + " 건";
	if (gcds_grid_ec02az.countrow <1) alert("검색된 데이터가 없습니다.");

	gcds_grid_ec02az.DataID = "gcds_grid_ec02az";
	gcds_grid_ec02az.SyncLoad=false;
	inp_File_2.Value="";

}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(index){
	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");
  for(var i=0;i<=3;i++) {
		if(i==index)	{
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
  }
}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel_1(){
	if (gcds_grid_ec01az.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_grid_ec01az.RunExcel('건강보험등급내역');
}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel_2(){
	if (gcds_grid_ec02az.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_grid_ec02az.RunExcel('건강보험등급내역');
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_select_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
  <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_bgubun_1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_bgubun_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 보험료 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec02az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 연금 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec03az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 요율 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dump"   classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49   VIEWASTEXT> 
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_grade1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_grade2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_grade3" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
    <PARAM NAME="KeyValue" VALUE="hdasan_h060001_tr(I:USER=gcds_pyo)">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="inp_File_1" event="OnClick()">
	txt_file_1.value=inp_File_1.Value
	ln_File_1();
</script>

<script language="javascript" for="gcds_select_bgubun_1" event="OnLoadStarted()">
  window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_bgubun_1" event="onloadCompleted(row,colid)">
	gcds_select_bgubun_1.InsertRow(1);
  gcds_select_bgubun_1.NameValue(1,"MINORCD")="";
  gcds_select_bgubun_1.NameValue(1,"MINORNM")="전체";
	gclx_select_bgubun_1.index=0; //보험구분

	//document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_select_bgubun_2" event="OnLoadStarted()">
  window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_bgubun_2" event="onloadCompleted(row,colid)">
	gcds_select_bgubun_2.InsertRow(1);
  gcds_select_bgubun_2.NameValue(1,"MINORCD")="";
  gcds_select_bgubun_2.NameValue(1,"MINORNM")="전체";
	//gclx_select_bgubun_2.index=0; //보험구분
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0;
	
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_dept2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.InsertRow(1);
	gcds_dept2.NameValue(1,"DEPTCD")="";
	gcds_dept2.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec03az.index=0;

	//document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	gcds_row_ec01az =0;

	if(gcds_grid_ec01az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	ft_cnt2.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_grid_ec02az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcgd_pyo" event="onclick(row)">
    /*if (row == 0) return;
    if (gcds_pyo.sysStatus(row)==0) ln_format('A');
    else ln_format('B');*/
</script>

<script language=JavaScript for=ADE_Tab_1 event=OnSelChanged(index)>
	ln_visible_hidden((index-1));
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_grade1" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade1" event="OnFail()">
	alert("중복된 데이타 입력으로 에러가 발생했습니다.");
</script>

<script language="javascript" for="gctr_grade2" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade2" event="OnFail()">
	alert("중복된 데이타 입력으로 에러가 발생했습니다.");
</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p050003_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2 ALING=LEFT>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td width="0" align=RIGHT><NOBR>
						<comment id="__NSID__"><OBJECT id=ADE_Tab_1 classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px">
							<PARAM NAME="BackColor" VALUE="#cccccc">
							<PARAM NAME="titleHeight" VALUE="20px">
							<PARAM NAME="DisableBackColor" VALUE="#eeeeee">
							<PARAM NAME="Format" VALUE="
                <T>divid=div_zipcode  title=소득집계</T>                          						  
								<T>divid=div_sendal		title=보수총액조회</T>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
			</table>
    </td>
  </tr>
  <tr><td height=10></td></tr>
  <tr> 
    <td COLSPAN=2>
<div id="div_zipcode" style="display:block">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="847" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
          <tr> 
			      <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;구분&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_bgubun_1  name="gclx_select_bgubun_1" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
							style="position:relative;left:6px;top:2px;font-size:12px;width:75px;height:200px;">
								<param name=ComboDataID			value=gcds_select_bgubun_1>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="TRUE">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;기준년월&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
				        validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment	  value=1>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode	  value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY/MM">
        				<param name=MaxLength     value=6>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
						<td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;</nobr></td>
						<td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
     			    </td>
							<td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
							<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr><input id="txt_empnmk_1" name="txt_empnmk_1" type="text" style="width:70px;" class="txt21" maxlength=10 onkeydown="if(event.keyCode==13) ln_Query_1();"></nobr></td>
   				    <td width="100%">&nbsp;</td>
              <td style="padding-top:4px;"><nobr>      
								<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Exec_1();" > 
								<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand"  onclick="ln_Del_1();">
								<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand"  onclick="ln_Save_1();">
								<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_1();"></nobr>
							</td>
            </tr>
          </table>
        </td>
      </tr>
			<tr>
				<td ALIGN=CENTER>
          <table width="847" cellpadding="1" cellspacing="0" border="0">
            <tr> 
              <td style="width:847" ALIGN=LEFT VALIGN=TOP>
                <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_reresult  style="WIDTH: 845px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
									<PARAM NAME="DataID"          VALUE="gcds_grid_ec01az">
									<PARAM NAME="Editable"				VALUE="True">
									<PARAM NAME="ColSizing"				VALUE="True">
									<PARAM NAME="BorderStyle"			VALUE="0">
       						<PARAM NAME="Fillarea"				VALUE="true">
									<PARAM NAME="Format"          VALUE="  
										<C> Name='순번'   HeadAlign=Center HeadBgColor=#B9D4DC Width=40 Value={currow} align=RIGHT EDIT=NONE </C> 
										<C> Name='사번' ID=EMPNO HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=RIGHT EDIT=NONE </C>
										<C> Name='성명' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=CENTER EDIT=NONE </C>
										<C> Name='소속' ID=DEPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=LEFT EDIT=NONE </C>
										<C> Name='보험증번호' ID=MEDSNO HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT  EDIT=NONE  </C> 
										<G> Name='보험료산정' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC
											<C> Name='납부보험료' ID=M12300 HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=RIGHT Edit=Numeric </C>
											<C> Name='년간보수' ID=Y12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT Edit=Numeric </C>
											<C> Name='개월' ID=DUTMON HeadAlign=Center HeadBgColor=#B9D4DC Width=40 align=RIGHT Edit=Numeric </C>
											<C> Name='월보수' ID=M12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT Edit=Numeric </C>
											<C> Name='월표준' ID=S12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT Edit=Numeric </C>
											<C> Name='현등급' ID=OGRDCD HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=RIGHT Edit=Numeric </C>
											<C> Name='신등급' ID=NGRDCD HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=RIGHT Edit=Numeric </C>
										</G>
                    ">
                   </OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset id=ft_div1 style="width:847px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
											<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
										</fieldset>
									</td>
                </table>
              </TD>
						</tr>
					</table>
        </td>
      </tr>
    </table>
	</div>

<div id="div_sendal" style="display:block">
	<table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="847" cellpadding="1" cellspacing="0" border="0"	 style='border:1 solid #708090' >
          <tr> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;기준년도&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
				        validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment			value=1>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode			value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY">
        				<param name=MaxLength     value=4>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>	
							<comment id="__NSID__"><object id=gclx_select_ec03az  name="gclx_select_ec03az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept2>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr><input id="txt_empnmk_2" name="txt_empnmk_2" type="text" class="txt21" style="width:70px;" maxlength=10 ></nobr></td>
						<td width="100%">&nbsp;
							<comment id="__NSID__"><object id=inp_File_2 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='찾아보기'>
								<param name="Enable"	value="True">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="padding-top:4px;"><nobr>      
							<img src="../../Common/img/btn/com_b_download.gif" style="cursor:hand" onclick="ln_FileOpen_2();">   
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel_2();">  
							<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del_2();">
							<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand"  onclick="ln_Save_2();">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_2();"></nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
			<td ALIGN=CENTER>
        <table width="847" cellpadding="1" cellspacing="0" border="0">
          <tr> 
            <td style="width:847" ALIGN=RIGHT VALIGN=TOP>
              <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec01az  style="WIDTH: 845px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
							  <PARAM NAME="DataID"          VALUE="gcds_grid_ec02az">
							  <PARAM NAME="Editable"				VALUE="True">
							  <PARAM NAME="BorderStyle"			VALUE="0">
       					<param name="Fillarea"				VALUE="true">
							  <PARAM NAME="Format"          VALUE="  
									<C> Name='순번'   Value={currow}				HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=RIGHT Edit=Numeric EDIT=NONE </C> 									
									<C> Name='성명'							ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=LEFT	EDIT=NONE </C>
									<C> Name='주민번호'					ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=104	align=RIGHT EDIT=NONE </C>
									<C> Name='보험증번호'				ID=MEDSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT EDIT=NONE  </C> 
									<C> Name='자격취득일'				ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT Mask='XXXX/XX/XX' </C>
									<C> Name='전년도보험료납부' ID=MEDAMT1	HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=RIGHT </C>
									<C> Name='실납부보험료'			ID=MEDAMT2	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT </C>
									<C> Name='전년도보수총액'		ID=M12100		HeadAlign=Center HeadBgColor=#B9D4DC Width=105	align=RIGHT </C>
									<C> Name='개월'							ID=DUTMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=RIGHT </C>
									<C> Name='결정등급'					ID=NGRDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT </C>
                  ">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div1 style="width:847px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
							</td>
						</TR>
					</table>
					</TD>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="div_holiday" style="display:block"></div>
<div id="div_special" style="display:block"></div>
			<td>
		</tr>
  </table>

<div class=page id="out_line" style="position:absolute; left:174; top:158; width:875; height:460;z-index:-1;">&nbsp;</div>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	