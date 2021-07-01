<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여기본사항
+ 프로그램 ID	: P020001.HTML
+ 기 능 정 의	: 조회
+ 변 경 이 력 : 권영법
+ 수 정 이 력	: 정영식 - 2005.07.07 - 본부 - 소속 -팀별 조회조건 추가
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 서 블 릿 명	: p020001_s1, p020001_s2, p020001_s3, p020001_s4, p020001_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>급여기본사항</title>
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
var curtid = "88001";  
var key_sabun="";
var gs_level;
var gs_treecd;
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
	//재직정보
	gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1121";
	gcds_select_ec01az.Reset();

  //소속정보
	gcds_select_ec02az.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1="; 
	gcds_select_ec02az.Reset();

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	var str1 = gclx_select_ec01az.BindColVal;
	var str2 = gclx_select_ec02az.BindColVal;
	var str3 = txt_empnm.value;

	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020001_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + gs_date
									 + "&v_str5=" + gs_level
									 + "&v_str6=" + gs_treecd;
	
	gcds_grid_ec01az.Reset(); //그리드
	
}

/******************************************************************************
	Description : 급여기본사항조회- 기본급,학비보조금내역,건강보험내역
******************************************************************************/
function ln_Basis() {

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020001_s2?"
									 + "v_str1=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empno")
									 + "&v_str2=" + gs_date2;
	gcds_data01.Reset();
}

/******************************************************************************
	Description : 가족사항조회
******************************************************************************/
function ln_FamQuery() {
	
	ft_cnt2.innerText = "데이타 조회중입니다..잠시만 기다려 주십시오.";
	
	//학력코드
	gcds_edccd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1115";
	gcds_edccd.Reset();

	//호주관계코드
	gcds_hdfamret.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	gcds_hdfamret.Reset();
	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030001_s2?"
									 + "v_str1=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empno");
	gcds_data02.Reset();
}

/******************************************************************************
	Description : 자격증사항조회
******************************************************************************/
function ln_LicQuery() {
	
	ft_cnt4.innerText = "데이타 조회중입니다..잠시만 기다려 주십시오.";

	if (gcds_lcstype.countrow<1) {
		
		//자격증종류
		gcds_lcstype.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1127";
		gcds_lcstype.Reset();

		//자격증등급
		gcds_lcscd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1128";
		gcds_lcscd.Reset();
	}

	gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030001_s4?"
									 + "v_str1=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empno");
	gcds_data04.Reset();
}


/******************************************************************************
	Description : 발령사항조회
******************************************************************************/
function ln_OrdQuery() {
	
	ft_cnt7.innerText = "데이타 조회중입니다..잠시만 기다려 주십시오.";

	if (gcds_ordcd.countrow<1) {
		//직위코드
		gcds_deptlvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
		gcds_deptlvl.Reset();

		//소속코드
		gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
		gcds_dept.Reset();

		//발령구분
		gcds_ordcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>ordcode_s1?v_str1=1149";
		gcds_ordcd.Reset();

		//호봉
		gcds_payseq.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1184";
		gcds_payseq.Reset();
	}

	gcds_data07.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030001_s7?"
									 + "v_str1=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empno");
	gcds_data07.Reset();
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_HakbiQuery(){
	if(gcds_grid_ec01az.countrow > 0)	{
		var str1 = fn_trim(gs_date2);        //기준년월
		if(str1.length != 6)		{
			alert("기준년월 6자리를 입력하세요");
		}else{

		gcds_data08.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050004_s3?"
										 + "v_str1=" + str1
										 + "&v_str2=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empno");

		gcds_data08.Reset(); //그리드
		gcds_data08.rowposition=1;
		}
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_HakbiQuery() {
	if(gcds_grid_ec01az.countrow > 0)	{
		var str1 = fn_trim(gs_date2);        //기준년월
		if(str1.length != 6) {
			alert("기준년월 6자리를 입력하세요");
		}else{

		gcds_data08.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050004_s3?"
										 + "v_str1=" + str1
										 + "&v_str2=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empno");

		gcds_data08.Reset(); //그리드
		gcds_data08.rowposition=1;
		}
	}
}

/******************************************************************************
	Description : 개인연금
******************************************************************************/
function ln_yungumQuery(){
	if(gcds_grid_ec01az.countrow > 0)	{
	gcds_data09.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050005_s1?"
									 + "v_str1=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"deptcd")
									 + "&v_str2=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empnmk");
	gcds_data09.Reset(); //그리드
	gcds_data09.rowposition=1;
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_allowQuery(){
	if(gcds_grid_ec01az.countrow > 0)	{
		gcds_data10.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050006_s1?"
										 + "v_str1=" + gs_date2
										 + "&v_str2=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"empnmk");
		gcds_data10.Reset(); //그리드
		gcds_data10.rowposition=1;
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {

	if (gcds_grid_ec01az.countrow <1)	{
		alert("저장하실 정보가 없습니다.");
	} else {
		if (gcds_grid_ec01az.IsUpdated ) {
			//if (ln_ValChk())
			//{
			if (confirm("급여기본정보를 저장하겠습니까 ?"))			{
				gctr_data.KeyValue = "Payroll.p020001_t1(I:USER=gcds_grid_ec01az)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020001_t1";
				//gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4)+gcurdate.substring(5,7);
				gctr_data.post();
			}
			//}
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

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--재직구분 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속구분 DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속그리드 기본사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--급여기본사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--가족사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--자격증사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--발령사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data08 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--학비보조 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--개인연금 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--기타수당 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcstype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--자격증종류 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcscd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 자격증등급 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_ordcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm"> <!--발령구분-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+deptnm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_edccd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hdfamret classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_payseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 호봉 DataSet-->
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
<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	if(gcds_grid_ec01az.countrow <=0)	{
		//document.all.LowerFrame.style.visibility="hidden";
		alert("조회된 데이타가 없습니다.");
	}	else	{
		gcds_grid_ec01az.rowposition=1;
		ln_Basis();
	}
</script>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ft_cnt2.innerText="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data04" event="OnLoadStarted()">
	ft_cnt4.innerText="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
	ft_cnt4.innerText = "조회건수 : " + row + " 건";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data07" event="OnLoadStarted()">
	ft_cnt7.innerText="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data07" event="onloadCompleted(row,colid)">
	ft_cnt7.innerText = "조회건수 : " + row + " 건";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data08" event="OnLoadStarted()">
	ft_cnt8.innerText="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data08" event="onloadCompleted(row,colid)">
	ft_cnt8.innerText = "조회건수 : " + row + " 건";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data09" event="OnLoadStarted()">
	ft_cnt9.innerText="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data09" event="onloadCompleted(row,colid)">
	ft_cnt9.innerText = "조회건수 : " + row + " 건";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data10" event="OnLoadStarted()">
	ft_cnt10.innerText="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data10" event="onloadCompleted(row,colid)">
	ft_cnt10.innerText = "조회건수 : " + row + " 건";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	/*gcds_select_ec01az.InsertRow(1);
    gcds_select_ec01az.NameValue(1,"MINORCD")="";
    gcds_select_ec01az.NameValue(1,"MINORNM")="전체";*/
    gclx_select_ec01az.index=0;
</script>

<script language="javascript" for="gcds_select_ec02az" event="onloadCompleted(row,colid)">
	gcds_select_ec02az.InsertRow(1);
	gcds_select_ec02az.NameValue(1,"DEPTCD")="";
	gcds_select_ec02az.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="조회가 완료 되었습니다.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="onselChanged(index)">
	if (gcds_grid_ec01az.countrow>0) {
		if (index=="1") ln_Basis();
		else if (index=="2") ln_FamQuery();
		else if (index=="3") ln_LicQuery();
		else if (index=="4") ln_OrdQuery();
		else if (index=="5") ln_HakbiQuery();
		else if (index=="6") ln_yungumQuery();
		else if (index=="7") ln_allowQuery();
	}
</script>
<script language="javascript" for=gcgd_grid_ec01az event=OnClick(row,colid)>
  var index=gcte_disp.ActiveIndex;
	if (gcds_grid_ec01az.countrow>0) {
		if (index=="1") ln_Basis();
		else if (index=="2") ln_FamQuery();
		else if (index=="3") ln_LicQuery();
		else if (index=="4") ln_OrdQuery();
		else if (index=="5") ln_HakbiQuery();
		else if (index=="6") ln_yungumQuery();
		else if (index=="7") ln_allowQuery();
	}
</script>

<script language=JavaScript for=gcgd_grid_ec01az event=onKeyPress(keycode)>

	 if (keycode =="40" || keycode=="38"){
			  var index=gcte_disp.ActiveIndex;
				if (gcds_grid_ec01az.countrow>0) {
					if (index=="1") ln_Basis();
					else if (index=="2") ln_FamQuery();
					else if (index=="3") ln_LicQuery();
					else if (index=="4") ln_OrdQuery();
					else if (index=="5") ln_HakbiQuery();
					else if (index=="6") ln_yungumQuery();
					else if (index=="7") ln_allowQuery();
				}
	 }
</script>


<script language=JavaScript for=gclx_select_ec02az event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_select_ec02az.ValueOfIndex ("level", gclx_select_ec02az.Index);
	gs_treecd = gclx_select_ec02az.ValueOfIndex ("treecd", gclx_select_ec02az.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
</script>

<script language="javascript" for="gctr_data" event="onerror()">
	alert("요청하신 작업을 성공적으로 수행하지 못했습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876", height="0" border="0"   cellpadding="0" cellspacing="0">

<tr height="30px">
	<td width=100% colspan="2">
	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
	  <tr> 
			<td width="215" background="../../Common/img/com_t_bg.gif">
				<img height=47 src="../img/p020001_head.gif" width=197>
			</td>
			<td width="661" align="right"  valign=middle background="../../Common/img/com_t_bg.gif" style="padding-top:2px;">
				<img name="btn_query" src="../../Common/img/btn/com_b_query.gif" style="cursor:hand;" onclick="ln_Query()">
			</td>				    	  
	  </tr>
  </table>
 </td>
</tr>
<tr height="0">
 <td width=10% height="0" cellpadding="0" cellspacing="0" valign="top" style="padding-left:3px;">
		<table height="0" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;border-top-width:1px">
			<tr height="40px">
				<td width="120px;" class="tab11" bgcolor="#eeeeee">재직<br>구분</td>
				<td width="100px;" class="tab21">
					<comment id="__NSID__"><object id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 	style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec01az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</object></comment><script>__ws__(__NSID__);</script>
		  	</td>
			</tr>
			<tr height="40px">
				<td width="120px;" class="tab11" bgcolor="#eeeeee">소속<br>구분</td>
				<td width="100px;" class="tab21"> 
					<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec02az>
						<param name=SearchColumn		value="DEPTCD^DEPTNM">
						<param name=Sort            value="false">
						<param name=SortColumn			value="DEPTCD">
						<param name=ListExprFormat	value="DEPTNM">
						<param name=BindColumn			value="DEPTCD">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr height="35px">
				<td class="tab11" bgcolor="#eeeeee">사원명</td>
				<td class="tab21"><input type="text" id=txt_empnm class="txt11" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
			</tr>
			<tr>
				<td colspan="2" class="tab21">
					<comment id="__NSID__"><object id="gcgd_grid_ec01az" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height:317;width:170" >
						<param name=dataid					value=gcds_grid_ec01az>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=ColSizing       value=True>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=SortView				value="left">
						<param name=format          value='
							<C>ID=DEPTNM,		Name="소속",			width=105,	HeadBgColor=#B9D4DC sort=true  </C>
							<C>ID=EMPNMK,		Name="성명",			width=50,		HeadAlign=CENTER		HeadBgColor=#B9D4DC Align=CENTER sort=true </C>
							<C>ID=EMPNO,		Name="사번",			width=50,		HeadBgColor=#B9D4DC sort=true  </C>
							<C>ID=PAYGNM,		Name="직위",			width=50,		HeadBgColor=#B9D4DC sort=true  </C>
							<C>ID=GRDDIV,		Name="직급",			width=50,		HeadBgColor=#B9D4DC sort=true  </C>
							<C>ID=PAYSEQ,		Name="급호",			width=50,		HeadBgColor=#B9D4DC sort=true  </C>
							<C>ID=DPOFFDT,	Name="소속발령",	width=80,		HeadAlign=center		HeadBgColor=#B9D4DC Align=Left Mask="XXXX/XX/XX" </C>
							<C>ID=LAMDT,		Name="승진일",		width=80,		HeadBgColor=#B9D4DC Mask="XXXX/XX/XX" </C>
							<C>ID=LRMDT,		Name="승급일",		width=80,		HeadBgColor=#B9D4DC Mask="XXXX/XX/XX" </C>'>
					</object></comment><script>__ws__(__NSID__);</script>
					<fieldset style="width:170;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
						<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
					</fieldset>
					</td>
        </tr>
      </table>
	  </td>
   <td width=80%  height="0" valign="top">
	 <table width=100% height="0" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top" >
		 <tr>
			 <td height="120px" valign="top">
				<table width=100% height="120px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding="0" cellspacing="0"  valign="top">
					<tr>
						<td  valign="top">&nbsp;</td>
						<td  valign="top">
				  <table width=100% border="0"  topmargin=0 leftmargin=0  cellpadding=0 cellspacing=0 style="border:1 solid #708090;">
						<tr  height="25px"> 
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">사번</td>
							<td width=20% align="left"  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:1px;"><input type="text" id=txt_empno class="txt11" style="width:80px;" readonly></td>
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">성명</td>
							<td colspan="3" width=54% align="left" valign=middle style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;">
							<table cellpadding=0 cellspacing=0 border=0><tr><td>
							<input type="text" id=txt_empnmk class="txt11" style="width:80px;" readonly></td><td>&nbsp;
							<input type="text" id=txt_empnmc class="txt11" style="width:80px;" readonly></td><td >&nbsp;
							<input type="text" id=txt_usests class="txt11" style="width:80px;text-align:center;" readonly>
						</td></tr></table></td>
						</tr> 
						<tr height="25px"> 
							<td width=12%    style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">초기승급</td>
							<td width=22% align="left"  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
								<comment id="__NSID__"><object id=gcem_FSAMDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
								validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	  value=1>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Readonly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></td>
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">최종승급</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
								<comment id="__NSID__"><object id=gcem_LRMDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
								validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	  value=1>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Readonly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></td>
							<td width=12%  align="center" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee">최종승진</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;">
								<comment id="__NSID__"><object id=gcem_LAMDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
									<param name=Text          value="">
									<param name=Alignment	  value=1>
									<param name=Border	      value=True>
									<param name=ClipMode	  value=true>
									<param name=Numeric	      value=false>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=MaxLength     value=8>
									<param name=PromptChar	  value="_">
									<param name=IsComma	      value=false>
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Readonly      value=true>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>                    
						<tr height="25px"> 
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">소속</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
								<input type="text" id=txt_deptnm class="txt11" style="width:130px;" readonly>
							</td>
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">직위</td>
							<td  width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
								<input type="text" id=txt_paygrd class="txt11" style="width:80px;" readonly>
							</td>
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">호봉</td>
							<td idth=20% align="left"  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;"><input type="text" id=txt_payseq class="txt11" style="width:80px;text-align:center" readonly>
						 </td>
						</tr>
						<tr height="25px"> 
							<td width=12%    style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">소속발령</td>
							<td width=22% align="left"  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
								<comment id="__NSID__"><object id=gcem_dpoffdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
								validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=1>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Readonly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></td>
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align="center">그룹입사일</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
								<comment id="__NSID__"><object id=gcem_grsdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
								validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=1>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Readonly      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td width=12%  align="center" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee">입사일</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;">
								<comment id="__NSID__"><object id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
								validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=1>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Readonly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></td>
						</tr>
						<tr height="24px"> 
							<td width=12% style="height:25px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" align="center">근무일자</td>
							<td width=22% align="left"  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;">
							<table cellspacing=0 cellpadding=0><tr>
								<td><nobr>
									<input type="text" id=txt_DUYEAR  name=txt_DUYEAR  align="right" class="txt11" style="width:20px; text-align:right" readonly>&nbsp;&nbsp;</nobr></td><td style="padding-top:2px">년</td>
								<td><nobr>
								<input type="text" id=txt_DUYMM name=txt_DUYMM class="txt11" style="width:20px; text-align:right" readonly>&nbsp;&nbsp;</nobr></td>
								<td style="padding-top:2px"><nobr>개월</nobr></td>
								<td align="right"><nobr>
								<input type="text" id=txt_DUDAY name=txt_DUDAY  class="txt11" style="width:20px; text-align:right" readonly>&nbsp;&nbsp;</nobr></td>
								<td style="padding-top:2px">일</td></tr></table></td>
							<td width=12%  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" align="center">계약기간</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;"><table cellspacing=0 cellpadding=0><tr>
						<td>
						<comment id="__NSID__"><object id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=1>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Readonly      value=true>
					</object></comment><script>__ws__(__NSID__);</script></td><td>&nbsp;&nbsp;&nbsp;~&nbsp;</td>
					<td><nobr>
						<comment id="__NSID__"><object id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative;left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=1>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Readonly      value=true>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td></tr></table>
						</td>
							<td width=12%  align="center" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee">퇴사일</td>
							<td width=20% align="left" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;border-bottom-width:0px;">
						<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=1>
						<param name=Border	      value=True>
						<param name=ClipMode	     value=true>
						<param name=Numeric	      value=false>
						<param name=Format	         value="YYYY/MM/DD">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Readonly      value=true>
						</object></comment><script>__ws__(__NSID__);</script></td>
						</tr>
					</table></td>
				 </tr>
			 </table></td>
        </tr>
		<tr><td height=5></td></tr>
        <tr><td height="20px" valign="top" >
			<table width=100% height="20px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top">
        <tr>
			  	<td width=100% height="20px" style="padding-left:8px;padding-top:3px;">
						<comment id="__NSID__"><OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px">
							<PARAM NAME="BackColor" VALUE="#cccccc">
							<PARAM NAME="titleHeight" VALUE="20px">
							<PARAM NAME="DisableBackColor" VALUE="#eeeeee">
							<PARAM NAME="Format" VALUE="<T>divid=layer1  title=기본</T>									
								<T>divid=layer2  title=가족</T>
								<T>divid=layer4  title=자격면허</T>
								<T>divid=layer7  title=발령사항</T>
								<T>divid=layer8  title=학비보조</T>
								<T>divid=layer9  title=개인연금</T>
								<T>divid=layer10  title=기타수당</T>
               ">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
         </tr>
       </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<!---------[TAB 1] left:200px;기본사항 ----------->
<div id="layer1" style="position:absolute; top:307px; left:360px; width:677px;  VISIBILITY: inherite;">
	<table width=100% height="30px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top">
    <tr height="30px">
      <td width="120px" style="border:1 solid #708090;" bgcolor="#eeeeee" align="center">기본급</td>
      <td  align="left" style="border:1 solid #708090;border-left-width:0px;">
				<comment id="__NSID__"><object id=gcem_gibon classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:8px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=9>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Readonly  value=true>
				</object></comment><script>__ws__(__NSID__);</script></td>
			<td style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align="center">
				<nobr>급여지급은행</nobr></td>
      <td align="left" style="border:1 solid #708090;border-left-width:0px;"><input type=text id=txt_PAYBNKCDNM  class="txt11" name=txt_PAYBNKCDNM readonly></td>
			<td style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align="center">
				<nobr>급여지급계좌</nobr></td>
      <td align="left" style="border:1 solid #708090;border-left-width:0px;"><nobr><input type=text id=txt_account  class="txt11" name=txt_account Readonly></nobr></td>
    </tr>
	</table>

<table cellpadding=0 cellspacing=0 width=100%><tr><td height=10></td></tr></table>
<table cellpadding=0 cellspacing=0 width=100%><tr><td height=10></td></tr></table>

<table cellpadding=0 cellspacing=0 width=100%><tr><td>건강보험내역</td></tr></table>
	<table width=100% height="30px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top">
    <tr height="30px">
			<td width="120px"  style="border:1 solid #708090;border-bottom-width:1px;" bgcolor="#eeeeee" align="center"><nobr>건강보험등급</nobr></td>
			<td  align="left"  style="border:1 solid #708090;border-left-width:0px;border-bottom-width:1px;"><nobr>
				<input type=text id=txt_gun_grade name=txt_gun_grade class="txt11" STYLE="WIDTH:30PX; text-align:right"  readonly>&nbsp; 등급</nobr></td>
			<td width="120px" style="border:1 solid #708090;border-left-width:0px;border-bottom-width:1px;" bgcolor="#eeeeee" align="center"><nobr>월보험료</nobr></td>
      <td  width="218px" align="left" style="border:1 solid #708090;border-left-width:0px;border-bottom-width:1px;" >
				<comment id="__NSID__"><object id=gcem_gun_pre classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=Readonly	      value=true>
					<param name=MaxLength     value=9>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Readonly  value=true>
				</object></comment><script>__ws__(__NSID__);</script></td>
      </tr>
		</table>

<table cellpadding=0 cellspacing=0 width=100%><tr><td height=20></td></tr></table>
<table cellpadding=0 cellspacing=0 width=100%><tr><td>국민연금내역</td></tr></table>

<table width=100% height="30px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top">
  <tr height="30px">
    <td width="120px"  style="border:1 solid #708090;border-bottom-width:1px;" bgcolor="#eeeeee" align="center"><nobr>표준소득등급</nobr></td>
    <td  align="left"  style="border:1 solid #708090;border-left-width:0px;border-bottom-width:1px;"><nobr><input type=text id=txt_gug_grade name=txt_gug_grade class="txt11" STYLE="WIDTH:30PX; text-align:right" readonly>&nbsp; 등급</nobr></td>
		<td width="120px" style="border:1 solid #708090;border-left-width:0px;border-bottom-width:1px;" bgcolor="#eeeeee" align="center"><nobr>월보험료</nobr></td>
    <td   width="218px" align="left" style="border:1 solid #708090;border-left-width:0px;border-bottom-width:1px;" ><nobr>
			<comment id="__NSID__"><object id=gcem_gug_pre classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Readonly	    value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=9>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
  </tr>
		 </table>
			</td>
		</tr>
	</table>
  </div>

<!---------[TAB 1] 가족사항 그리드----------->
<div id="layer2" style="position:absolute; top:277px; left:360px; width:600px; height:330px; VISIBILITY: hidden;">
  <table style="border:solid; border-width:0px;" width=100% cellpadding=0 cellspacing=0 border=0 >
		<tr>
  		<td width=100%>
			<table width=100% height="20px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top">
        <tr><td height="20px" align="right"></td></tr>
      </table>
		<table  cellpadding="1" cellspacing="0" border="0" bgcolor="#708090" width="100%">
		<tr> 
			<td>
				<comment id="__NSID__"><OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:677;height:261">
					<param name=dataid					value=gcds_data02>
					<param Name=BorderStyle			value=0> 
					<param name=indwidth        value=0>
					<param name=fillarea        value=true>
					<param name=Editable        value=false>
					<param name=AllShowEdit     value=true>
					<param name=headlinecolor   value=#999999>
					<param name=format          value='
						<F> Name=NO ID={CurRow}				HeadAlign=Center HeadBgColor=#B9D4DC Width=30, align=right </F> 
						<F> Name=주민번호 ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=100, align=center MASK="XXXXXX-XXXXXXX"</F> 
						<C> Name=성명			ID=FAMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=74,	align=left</C> 
						<C> Name=관계			ID=REFCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=47,	align=left,		EditStyle=Lookup, Data="gcds_hdfamret:minorcd:minornm"</C> 
						<C> Name=동거			ID=LIVEYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=47,	align=center,	EditStyle=combo, Data="1:동거,2:비동거"</C> 
						<C> Name=부양			ID=SPTYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=47,	align=center,	EditStyle=combo, Data="1:부양,2:피부양"</C> 
						<C> Name=장애			ID=DISYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=47,	align=center,	EditStyle=combo, Data="1:유,2:무"</C> 
						<C> Name=직업			ID=CMPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=87,	align=left</C> 
						<C> Name=학력			ID=LSTEDC		HeadAlign=Center HeadBgColor=#B9D4DC Width=60,	align=left, EditStyle=Lookup, Data="gcds_edccd:minorcd:minornm" </C> 
						<C> Name=의보			ID=MEDINYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=42,	align=center,	EditStyle=combo, Data="1:유,2:무"</C> 
						<C> Name=학자금		ID=EDUEXYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=42		align=center,	EditStyle=combo, Data="1:유,2:무"</C> 
						<C> Name=수당			ID=PAYYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=42		align=center,	EditStyle=combo, Data="Y:유,N:무"</C> 
					'>
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="width:677;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
				<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
			</fieldset> 
			</td>
		</tr>
	</table>
			</td>
		</tr>
	</table>
</div><!---------[TAB 1] 경력사항 그리드----------->

<!---------[TAB 1] 자격면허사항 그리드----------->
<div id="layer4" style="position:absolute; top:267px; left:360px; width:677px;  VISIBILITY: hidden;">
  <table style="border:solid; border-width:0px;" width=100% cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td width=100% height="25px" valign="top" style="padding-top:5px;">
		<table width=100% height="25px" border="0" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 cellpadding=0 cellspacing=0 valign="top">
			<tr><td height="20px" align="right"></td></tr></table> 
			</td>
		</tr>
	<tr>
  	<td width=100%>
		<table  cellpadding="1" cellspacing="0" border="0" bgcolor="#708090" width=100%>
			<tr> 
				<td>
				<comment id="__NSID__"><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:677;height:262">
					<param name=dataid					value=gcds_data04>
					<param Name=BorderStyle			value=0> 
					<param name=indwidth        value=0>
					<param name=fillarea        value=true>
					<param name=Editable        value=false>
					<param name=AllShowEdit     value=true>
					<param name=headlinecolor   value=#999999>
					<param name=format          value='
						<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	align=right </F> 
						<C> Name=취득일자 ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center, Mask="XXXX/XX/XX"</C> 
						<C> Name=자격구분 ID=LCSCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left,		EditStyle=Lookup, Data="gcds_lcscd:minorcd:minornm"</C> 
						<C> Name=자격증명 ID=LCSTYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left,		EditStyle=Lookup, Data="gcds_lcstype:minorcd:minornm"</C> 
						<C> Name=증번호   ID=LCSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=center </C> 
						<C> Name=발행처   ID=ISSPART	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left </C> 
					'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:677;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
					<font id=ft_cnt4 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
			</td>
		</tr>
	</table>
		</td>
	</tr>
</table>
</div>

<!---------[TAB 11] 인사발령+상벌 그리드----------->
<div id="layer7" style="position:absolute; top:290px; left:360px; width:677px;  VISIBILITY: hidden;">
  <table width=100% cellpadding=0 cellspacing=0 border=0 >
   <tr height="7px"><td></td></tr>
		<tr>
  		<td width=100%>
		<table  cellpadding="1" cellspacing="0" border="0" bgcolor="#708090" width=100%>
			<tr> 
				<td>
					<comment id="__NSID__"><OBJECT id=gcgd_disp07 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:677;height:262">
            <param name=dataid					value=gcds_data07>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
							<F> Name=발령일자 ID=ORDDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=90,	align=center, MASK="XXXX/XX/XX"</F> 
						 	<C> Name=발령구분 ID=ORDCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=120, EditStyle=Lookup, Data="gcds_ordcd:ordcd:ordnm" </C> 
							<C> Name=소속			ID=DEPTCD HeadAlign=Center HeadBgColor=#B9D4DC Width=175, EditStyle=Lookup, Data="gcds_dept:deptcd:deptnm"</C> 
							<C> Name=직위			ID=PAYGRD HeadAlign=Center HeadBgColor=#B9D4DC Width=123, EditStyle=Lookup, Data="gcds_deptlvl:minorcd:minornm"</C>
							<C> Name=호봉			ID=PAYSEQ HeadAlign=Center HeadBgColor=#B9D4DC Width=120, EditStyle=Lookup, Data="gcds_payseq:minorcd:minornm" </C>
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:677;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
					<font id=ft_cnt7 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
			</td>
    </tr>
	</table>		
		</td>
      </tr>		 
			<tr height="4px"><td></td></tr>
			</td>
    </tr>
	</table>
  </div>

<!---------[TAB 8] 학비보조 그리드----------->
<div id="layer8" style="position:absolute; top:290px; left:360px; width:677px;  VISIBILITY: hidden;">
  <table width=100% cellpadding=0 cellspacing=0 border=0 >
   <tr height="7px"><td></td></tr>
		<tr>
  		<td width=100%>
		<table  cellpadding="1" cellspacing="0" border="0" bgcolor="#708090" width=100%>
			<tr> 
				<td>
					<comment id="__NSID__"><OBJECT id=gcgd_disp08 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:677;height:262">
            <param name=dataid					value=gcds_data08>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value="
							<C> Name='성명' ID=FAMNM  			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  EDIT=NONE</C> 
							<C> Name='주민번호' ID=RESINO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=CENTER	EDIT=NONE </C> 
							<C> Name='신청일' ID=APPDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=CENTER  MASK='XXXX/XX/XX' EDIT=NONE </C> 
							<C> Name='신청금액' ID=APPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=RIGHT</C> 
							<C> Name='지급금액' ID=PAYAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=RIGHT</C> 
							<C> Name='지급년월' ID=APPYM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=CENTER MASK='XXXX/XX' EDIT=NONE</C> 
							<C> Name='신청내역' ID=REQREM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=CENTER </C> 
							<C> Name='학년' ID=SCHYEAR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center </C> 
							<C> Name='학교명' ID=SCHNM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=126  align=LEFT </C> 
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:677;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
					<font id=ft_cnt8 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
      </td>
     </tr>
		</table>	
			</td>
        </tr><tr height="4px"><td></td></tr>
</table>
</div>

<!---------[TAB 9] 개인연금 그리드----------->
<div id="layer9" style="position:absolute; top:290px; left:360px; width:677px;  VISIBILITY: hidden;">
  <table width=100% cellpadding=0 cellspacing=0 border=0 >
		<tr height="7px"><td></td></tr>
		<tr>
  		<td width=100%>
		<table  cellpadding="1" cellspacing="0" border="0" bgcolor="#708090" width=100%>
			<tr> 
				<td>
					<comment id="__NSID__"><OBJECT id=gcgd_disp09 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:677;height:262">
            <param name=dataid					value=gcds_data09>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value="
							<C> Name='연금명'   ID=DIVNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=220   align=center   </C> 
							<C> Name='불입월'   ID=LASTMON 	HeadAlign=Center HeadBgColor=#B9D4DC Width=140   Mask='XXXX/XX'  align=center  </C> 
							<C> Name='회사부담' ID=PERAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=RIGHT  </C> 
							<C> Name='공제'     ID=SUPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=RIGHT  </C> 
							<C> Name='누계액'   ID=TOTAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=RIGHT  </C> 
						">
					</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:677;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
					<font id=ft_cnt9 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
      </td>
    </tr>
	</table>		
		</td>
			</tr><tr height="4px"><td></td></tr>
</table>
</div>
 
<!---------[TAB 10] 기타수당 그리드----------->
<div id="layer10" style="position:absolute; top:290px; left:360px; width:677px;  VISIBILITY: hidden;">
  <table width=100% cellpadding=0 cellspacing=0 border=0 >
		<tr height="7px"><td></td></tr>
		<tr>
  		<td width=100%>
		<table  cellpadding="1" cellspacing="0" border="0" bgcolor="#708090" width=100%>
			<tr> 
				<td>
					<comment id="__NSID__"><OBJECT id=gcgd_disp10 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:677;height:262">
            <param name=dataid					value=gcds_data10>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value="
							<C> Name='수당구분' ID=ALLOWGBNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=182  align=LEFT   </C> 
							<C> Name='시작년월' ID=FRDT  			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Mask='XXXX/XX' align=center  </C> 
							<C> Name='종료년월' ID=TODT  			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Mask='XXXX/XX' align=center  </C> 
							<C> Name='수당액' ID=ALLOWAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=280 align=RIGHT  </C> 
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:677;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:1px;text-align:LEFT;">
					<font id=ft_cnt10 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
             </td>
        </tr></table>
			</td>
        </tr><tr height="4px"><td></td></tr>
</table>
</div>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>   
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_grid_ec01az">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=EMPNMK		Ctrl=txt_empnmk		Param=Value</C>
		<C>Col=NMC			Ctrl=txt_empnmc		Param=Value</C>
		<C>Col=NME			Ctrl=txt_empnme		Param=Value</C>
		<C>Col=EMPNO		Ctrl=txt_empno		Param=Value</C>
		<C>Col=RESINO		Ctrl=gcem_resino	Param=Text</C>
		<C>Col=BIRDT		Ctrl=gcem_birdt		Param=Text</C>
		<C>Col=GLDIV		Ctrl=gcra_gldiv		Param=CodeValue</C>
		<C>Col=DEPTNM		Ctrl=txt_deptnm	  Param=Value</C>
		<C>Col=PAYGNM		Ctrl=txt_paygrd		Param=Value</C>
		<C>Col=GRDDIV		Ctrl=txt_grddiv		Param=Value</C>
		<C>Col=JOBGRPH	Ctrl=txt_jobgrph	Param=Value</C>
		<C>Col=OZIPCD		Ctrl=gcem_ozipcd	Param=Text</C>
		<C>Col=CZIPCD		Ctrl=gcem_czipcd	Param=Text</C>
		<C>Col=OADDR01	Ctrl=txt_oaddr01	Param=Value</C>
		<C>Col=OADDR02	Ctrl=txt_oaddr02	Param=Value</C>
		<C>Col=CADDR01	Ctrl=txt_caddr01	Param=Value</C>
		<C>Col=CADDR02	Ctrl=txt_caddr02	Param=Value</C>
		<C>Col=TELNO		Ctrl=txt_telno		Param=Value</C>
		<C>Col=HPNO			Ctrl=txt_hpno			Param=Value</C>
		<C>Col=OFFTELNO	Ctrl=txt_offtelno	Param=Value</C>
		<C>Col=EMAIL		Ctrl=txt_email		Param=Value</C>

		<C>Col=DPOFFDT		Ctrl=gcem_dpoffdt 	Param=Text</C>
		<C>Col=GRSTRTDT		Ctrl=gcem_grstrtdt	Param=Text</C>
		<C>Col=STRTDT			Ctrl=gcem_strtdt		Param=Text</C>
    <C>Col=ENDDT			 Ctrl=gcem_enddt		Param=Text</C>

		<C>Col=HITCHYN		Ctrl=gcra_hitchyn		Param=CodeValue</C>

		<C>Col=HDFAMNM 		Ctrl=txt_hdfamnm  		Param=Value</C>
		<C>Col=HDFAMRET		Ctrl=gclx_hdfamret 		Param=BindColVal</C>
		<C>Col=HDFAMJOB		Ctrl=txt_hdfamjob 		Param=Value</C>
		<C>Col=EDCCD   		Ctrl=gclx_edccd   		Param=BindColVal</C>
		<C>Col=EMPDIV  		Ctrl=gclx_empdiv  		Param=BindColVal</C>
		<C>Col=HOUSDIV 		Ctrl=gclx_housdiv 		Param=Value</C>
		<C>Col=HOBBY   		Ctrl=txt_hobby    		Param=Value</C>
		<C>Col=SPECIAL 		Ctrl=txt_special  		Param=Value</C>
		<C>Col=RILIGN  		Ctrl=gclx_rilign  		Param=BindColVal</C>
		<C>Col=MRYDT   		Ctrl=gcem_mrydt   		Param=Text</C>
		<C>Col=RELESAMT		Ctrl=gcem_relesamt 		Param=Text</C>
		<C>Col=MOVESAMT		Ctrl=gcem_movesamt 		Param=Text</C>
		<C>Col=LABUNIYN		Ctrl=gcra_labuniyn		Param=codevalue</C>
		<C>Col=MRTDIV  		Ctrl=gclx_mrtdiv  		Param=BindColVal</C>
		<C>Col=USESTS 		Ctrl=txt_usests  		Param=value</C>
		<C>Col=ENGLVL		Ctrl=gclx_englvl			Param=BindColVal</C>
		<C>Col=TOESCR 		Ctrl=gcem_toescr  		Param=Text</C>
		<C>Col=JPTSCR 		Ctrl=gcem_jptscr  		Param=Text</C>
		<C>Col=DELFSCR 		Ctrl=gcem_delfscr  		Param=Text</C>
		<C>Col=TOFSCR 		Ctrl=gcem_tofscr  		Param=Text</C>
		<C>Col=DALFSCR 		Ctrl=gcem_dalfscr  		Param=Text</C>
		<C>Col=TEPSSCR 		Ctrl=gcem_tepsscr  		Param=Text</C>
		<C>Col=ETCLNG 		Ctrl=txt_etclng  			Param=Value</C>

		<C>Col=HWGRDCD 		Ctrl=gclx_hwgrdcd			Param=BindColVal</C>
		<C>Col=EXGRDCD 		Ctrl=gclx_exgrdcd			Param=BindColVal</C>
		<C>Col=PWGRDCD 		Ctrl=gclx_pwgrdcd			Param=BindColVal</C>
		<C>Col=ACGRDCD 		Ctrl=gclx_acgrdcd			Param=BindColVal</C>
		<C>Col=PICFILE 		Ctrl=txt_file		  		Param=Value</C>

		<C>Col=GRSTRTDT 			Ctrl=gcem_grsdt  			Param=Text</C>

		<C>Col=RELATNM 		Ctrl=txt_relatnm  		Param=Value</C>
		<C>Col=RELATGRD		Ctrl=gclx_relatgrd  	Param=BindColVal</C>
		<C>Col=RELATRE 		Ctrl=gclx_relatre  		Param=BindColVal</C>
		<C>Col=NOMINNM 		Ctrl=txt_nominnm	 		Param=Value</C>
		<C>Col=NOMINGRD		Ctrl=gclx_nomingrd  	Param=BindColVal</C>
		<C>Col=NOMINRE		Ctrl=gclx_nominre  		Param=BindColVal</C>
		<C>Col=FRDT		Ctrl=gcem_frdt  	Param=Text</C>
		<C>Col=TODT		Ctrl=gcem_todt  		Param=Text</C>
		<C>Col=PAYBNKCDNM		Ctrl=txt_PAYBNKCDNM  	Param=value</C>
		<C>Col=PAYACNT		Ctrl=txt_account  		Param=value</C>
		<C>Col=FSAMDT		Ctrl=gcem_FSAMDT  	Param=Text</C>
		<C>Col=LRMDT		Ctrl=gcem_LRMDT  		Param=Text</C>
		<C>Col=LAMDT		Ctrl=gcem_LAMDT  		Param=Text</C>

		<C>Col=DUYEAR		Ctrl=txt_DUYEAR  	Param=value</C>
		<C>Col=DUYMM		Ctrl=txt_DUYMM  		Param=value</C>
		<C>Col=DUDAY		Ctrl=txt_DUDAY  		Param=value</C>
		<C>Col=PAYSEQ		Ctrl=txt_payseq  		Param=value</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcbn_data01 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data01">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=AMT		    Ctrl=gcem_gibon				Param=Text</C>
		<C>Col=PAYDT			Ctrl=gcem_jigbdt			Param=Text</C>
		<C>Col=GRDCD1			Ctrl=txt_gun_grade		Param=value</C>
		<C>Col=GRDCD2			Ctrl=txt_gug_grade		Param=value</C>
		<C>Col=INSAMT1		Ctrl=gcem_gun_pre			Param=Text</C>
		<C>Col=INSAMT2		Ctrl=gcem_gug_pre			Param=Text</C>
		<C>Col=STDAMT			Ctrl=gcem_sodug_price	Param=Text</C>
		<C>Col=MEDNUM			Ctrl=txt_gun_number		Param=value</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<div class=page id="out_line" style="position:absolute; left:353; top:292; width:693; height:299;z-index:-1;">&nbsp;</div>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</BODY>
</HTML>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
