<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ 시 스 템 명	:	연말정산관리-연말정산내역조회
+ 프로그램 ID	: P030005.HTML
+ 기 능 정 의	: 조회,출력
+ 변 경 이 력	: 
+ 서 블 릿 명	: p030005_s1 (P030002.HTML과 공동사용) 
------------------------------------------------------------------------------
+ 수 정 내 용  :	출력물 추가  
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2007. 1
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>


<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>연말정산내역조회</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substr(5,2);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = parseInt(gcurdate.substring(0,4))+1;
var gs_level;
var gs_treecd;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_curdt.text = gcurdate.substring(0,4);	//귀속년도
	gcem_curdt.text = "2008" ;//gcurdate.substring(0,4);	//귀속년도

	ln_Before();	//선조회

	gcds_manager.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s2?v_str1=2060&v_str2="+gusrid;
	gcds_manager.Reset();	

	if(gcds_manager.countrow>0){ //관리자 존재
    txt_empno1.value="";
		txt_empnmk1.value = "";
	}else{
		txt_empno1.value = gusrid;
		txt_empnmk1.value = gusrnm;
    txt_empnmk1.readOnly = "true";
	}
}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	if (gcem_curdt.text=="") {
		alert("귀속년도는 필수항목입니다.");
		gcem_curdt.setFocus();
	}

  //2009.02.19
	/**
  if(gcds_manager.countrow>0){ //관리자 존재
	}else{
		alert("연말정산 조회기간이 아닙니다.");
		return false;
	}
	**/
	


	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030015_s1?v_str1=" + gcem_curdt.text+"12"
									  + "&v_str2=" + gclx_deptcd.bindcolval
									  + "&v_str3=" + fn_trim(txt_empnmk1.value)
									  + "&v_str4=" + gs_level
									  + "&v_str5=" + gs_treecd
										+ "&v_str6=" + gcem_curdt.text
										+ "&v_str7=" + txt_empno1.value;
	//prompt('',gcds_data.DataID);
	gcds_data.Reset(); 

}

function ln_Query02(p) {

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030015_s4?v_str1=" + gcem_curdt.text+"12"
									  + "&v_str2=" + gclx_deptcd.bindcolval
									  + "&v_str3=" + fn_trim(txt_empnmk1.value)
									  + "&v_str4=" + p;

//	prompt('',gcds_data2.DataID);

	gcds_data2.Reset(); 

}

/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Before(){

	//소속코드
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_dept1.Reset();

	//소속코드2
	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	gcds_dept2.Reset();

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
	Description : 출력 - 영수증  
******************************************************************************/
function ln_Print(){

  if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
		return;
	}else{
	  //연말정산 관리자 체크
		if(gcds_manager.countrow>0){ 	
			alert("출력시 발행자 보고용,발행자 보관용,소득자 보관용 순서로 각각 출력됩니다.");
		}else{
			gcds_empno.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030015_s5?v_str1=" + gcem_curdt.text+"12";
			//prompt('',gcds_empno.DataID);
			gcds_empno.Reset(); 
		}

		gcds_print.ClearAll();
		gcds_print1.ClearAll();

		var ls_temp = "";
		var ls_temp1 = "";
		for( var i=1;i<=gcds_data.countcolumn;i++) {
			ls_temp+=gcds_data.columnid(i)+":";
			if(gcds_data.ColumnType(i)==1)			ls_temp+="STRING";
			else if(gcds_data.ColumnType(i)==2)	ls_temp+="INTEGER";
			else if(gcds_data.ColumnType(i)==3)	ls_temp+="DECIMAL";
			else if(gcds_data.ColumnType(i)==4)	ls_temp+="DATE";
			else if(gcds_data.ColumnType(i)==5)	ls_temp+="URL";
			
			if(gcds_data.countcolumn != i) ls_temp+=",";
		 }
			ls_temp+=",HTITLE:STRING,CURDT:STRING,CURDT2:STRING";
			
			gcds_print.SetDataHeader(ls_temp);

			ls_temp1 ="EMPNO:STRING,APPDT:STRING,RELAT1:STRING,FAMNM1:STRING,RESINO1:STRING,RESINO:STRING,"
				 + "REF1:STRING,REF2:STRING,REF3:STRING,REF4:STRING,REF5:STRING,REF6:STRING,REF7:STRING,REF8:STRING,JUMIN:STRING,"
				 + "REF11:DECIMAL,REF12:DECIMAL,REF13:DECIMAL,REF14:DECIMAL,REF15:DECIMAL,REF16:DECIMAL,"
				 + "REF21:DECIMAL,REF22:DECIMAL,REF23:DECIMAL,REF24:DECIMAL,REF25:DECIMAL,REF26:DECIMAL,"
				 + "PCNT:DECIMAL,TCNT:DECIMAL,"
				 + "TREF11:DECIMAL,TREF12:DECIMAL,TREF13:DECIMAL,TREF14:DECIMAL,TREF15:DECIMAL,TREF16:DECIMAL,"
				 + "TREF21:DECIMAL,TREF22:DECIMAL,TREF23:DECIMAL,TREF24:DECIMAL,TREF25:DECIMAL,TREF26:DECIMAL";
			gcds_print1.SetDataHeader(ls_temp1);

		//20060112 정영식 추가
		gs_date = gcem_curdt.text;
		gs_date4=Number(gcem_curdt.text)+1;

		
		var iccnt = 0;
		for (j=1;j<=gcds_data.countrow;j++) {
			iccnt = 1;
			gcds_print.Addrow();
			gcds_print.namevalue(j,"HTITLE") = "(발행자 보고용)";
			gcds_print.namevalue(j,"CURDT")  = gs_date;  
			gcds_print.namevalue(j,"CURDT2") = gs_date4;

			//gcds_print1.Addrow();
			
			ln_Query02(gcds_data.namevalue(j,"EMPNO"));

			for(var i=1;i<=gcds_data.countcolumn;i++)	{
				gcds_print.namevalue(j,gcds_data.columnid(i))	= gcds_data.namevalue(j,gcds_data.columnid(i));
			}//END I FOR

			gcds_print.namevalue(j,"RCNT")=j;

			for(var aa=1;aa<=gcds_data2.countrow;aa++)	{
				gcds_print1.Addrow();
				var row = gcds_print1.rowposition;
				gcds_print1.namevalue(row,"FAMNM1") = gcds_data2.namevalue(aa,"FAMNM1");
				gcds_print1.namevalue(row,"RESINO1") = gcds_data2.namevalue(aa,"RESINO1");
				gcds_print1.namevalue(row,"RELAT1") = gcds_data2.namevalue(aa,"RELAT1");
				gcds_print1.namevalue(row,"RESINO") = gcds_data2.namevalue(aa,"RESINO");
				gcds_print1.namevalue(row,"JUMIN") = gcds_data2.namevalue(aa,"JUMIN");

				if( gcds_data2.namevalue(aa,"REF1")=="T")gcds_print1.namevalue(row,"REF1")=""
				else gcds_print1.namevalue(row,"REF1")=""

				if( gcds_data2.namevalue(aa,"REF2")=="T")gcds_print1.namevalue(row,"REF2")="O"
				else gcds_print1.namevalue(row,"REF2")=""

				if( gcds_data2.namevalue(aa,"REF3")=="T")gcds_print1.namevalue(row,"REF3")="O"
				else gcds_print1.namevalue(row,"REF3")=""

				if( gcds_data2.namevalue(aa,"REF4")=="T")gcds_print1.namevalue(row,"REF4")="O"
				else gcds_print1.namevalue(row,"REF4")=""

				if( gcds_data2.namevalue(aa,"REF5")=="T")gcds_print1.namevalue(row,"REF5")="O"
				else gcds_print1.namevalue(row,"REF5")=""

				if( gcds_data2.namevalue(aa,"REF6")=="T")gcds_print1.namevalue(row,"REF6")="O"
				else gcds_print1.namevalue(row,"REF6")=""

				if( gcds_data2.namevalue(aa,"REF7")=="T")gcds_print1.namevalue(row,"REF7")="O"
				else gcds_print1.namevalue(row,"REF7")=""

				if( gcds_data2.namevalue(aa,"REF8")=="T")gcds_print1.namevalue(row,"REF8")="O"
				else gcds_print1.namevalue(row,"REF8")=""

				/*
				gcds_print1.namevalue(row,"REF1") = gcds_data2.namevalue(aa,"REF1");
				gcds_print1.namevalue(row,"REF2") = gcds_data2.namevalue(aa,"REF2");
				gcds_print1.namevalue(row,"REF3") = gcds_data2.namevalue(aa,"REF3");
				gcds_print1.namevalue(row,"REF4") = gcds_data2.namevalue(aa,"REF4");
				gcds_print1.namevalue(row,"REF5") = gcds_data2.namevalue(aa,"REF5");
				gcds_print1.namevalue(row,"REF6") = gcds_data2.namevalue(aa,"REF6");
				gcds_print1.namevalue(row,"REF7") = gcds_data2.namevalue(aa,"REF7");
				*/

				for (var d=1; d<7; d++) {
					var nm1 = "REF1"+d;
					var nm2 = "REF2"+d;
					gcds_print1.namevalue(row,nm1) = gcds_data2.namevalue(aa,nm1);
					gcds_print1.namevalue(row,nm2) = gcds_data2.namevalue(aa,nm2);
				}
				gcds_print1.namevalue(row,"PCNT")  = iccnt;

				if (aa==1) {
					var tcnt = gcds_data2.countrow+1;
					gcds_print1.namevalue(row,"TCNT")		 = gcds_data2.countrow;
					gcds_print1.namevalue(row,"TREF11")  = gcds_data2.sum(12,0,tcnt);
					gcds_print1.namevalue(row,"TREF12")  = gcds_data2.sum(13,0,tcnt);
					gcds_print1.namevalue(row,"TREF13")  = gcds_data2.sum(14,0,tcnt);
					gcds_print1.namevalue(row,"TREF14")  = gcds_data2.sum(15,0,tcnt);
					gcds_print1.namevalue(row,"TREF15")  = gcds_data2.sum(16,0,tcnt);
					gcds_print1.namevalue(row,"TREF16")  = gcds_data2.sum(17,0,tcnt);
					gcds_print1.namevalue(row,"TREF21")  = gcds_data2.sum(18,0,tcnt);
					gcds_print1.namevalue(row,"TREF22")  = gcds_data2.sum(19,0,tcnt);
					gcds_print1.namevalue(row,"TREF23")  = gcds_data2.sum(20,0,tcnt);
					gcds_print1.namevalue(row,"TREF24")  = gcds_data2.sum(21,0,tcnt);
					gcds_print1.namevalue(row,"TREF25")  = gcds_data2.sum(22,0,tcnt);
					gcds_print1.namevalue(row,"TREF26")  = gcds_data2.sum(23,0,tcnt);
				}
				iccnt++;
			}//END I FOR

			var icc = 11 - gcds_data2.countrow;
			for (var s=1;s<=icc;s++) {
				gcds_print1.addrow();
				var rr = gcds_print1.rowposition;
				gcds_print1.namevalue(rr,"PCNT")  = iccnt;
        /*
        var tcnt = gcds_data2.countrow+1;
				gcds_print1.namevalue(rr,"TCNT")		= gcds_data2.countrow;
				gcds_print1.namevalue(rr,"TREF11")  = gcds_data2.sum(12,0,tcnt);
				gcds_print1.namevalue(rr,"TREF12")  = gcds_data2.sum(13,0,tcnt);
				gcds_print1.namevalue(rr,"TREF13")  = gcds_data2.sum(14,0,tcnt);
				gcds_print1.namevalue(rr,"TREF14")  = gcds_data2.sum(15,0,tcnt);
				gcds_print1.namevalue(rr,"TREF15")  = gcds_data2.sum(16,0,tcnt);
				gcds_print1.namevalue(rr,"TREF16")  = gcds_data2.sum(17,0,tcnt);
				gcds_print1.namevalue(rr,"TREF21")  = gcds_data2.sum(18,0,tcnt);
				gcds_print1.namevalue(rr,"TREF22")  = gcds_data2.sum(19,0,tcnt);
				gcds_print1.namevalue(rr,"TREF23")  = gcds_data2.sum(20,0,tcnt);
				gcds_print1.namevalue(rr,"TREF24")  = gcds_data2.sum(21,0,tcnt);
				gcds_print1.namevalue(rr,"TREF25")  = gcds_data2.sum(22,0,tcnt);
				gcds_print1.namevalue(rr,"TREF26")  = gcds_data2.sum(23,0,tcnt);
				*/

				iccnt++;
			}
		}//END J FOR

		//prompt('', gcds_print1.text);
    if(gcds_manager.countrow>0){ 	//관리자 

		 // prompt('', gcds_print.text);
		 // prompt('', gcds_print1.text);
		  //임시막음.
			//////gcrp_print.preview();		//(발행자 보고용)

			for (j=1;j<=gcds_data.countrow;j++) {
				gcds_print.namevalue(j,"HTITLE") = "(발행자 보관용)";
			}
			gcrp_print2.preview();	//(발행자 보관용)

			for (j=1;j<=gcds_data.countrow;j++) {
				gcds_print.namevalue(j,"HTITLE") = "(소득자 보관용)";
			}
		//임시막음
		//////gcrp_print3.preview();	//(소득자 보관용)

		}else{  //개인

		  for(var k=1;k<=gcds_empno.countrow;k++){
				if(gcds_empno.namevalue(k,"EMPNO")==gusrid){
					gcds_print.namevalue(1,"RCNT")=k;
				}
			}

			for (j=1;j<=gcds_data.countrow;j++) {
				gcds_print.namevalue(j,"HTITLE") = "(소득자 보관용)";
			}

			gcrp_print3.preview();	//(소득자 보관용)
		}		
	}
}

/******************************************************************************
	Description : 출력 - 연말정산 대장현황
******************************************************************************/
function ln_Print2(){
	//잠시막아놓음
	//gcds_print2.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030005_s2?v_str1=" + gcem_curdt.text+"12"
	//																												+"&v_str2=" + gcem_curdt.text;
//	gcds_print2.Reset();
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
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="usechangeinfo" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- 소속 검색-->
<comment id="__NSID__"><object id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</object></comment><script>__ws__(__NSID__);</script>

<!-- 소속 BIND-->
<comment id="__NSID__"><object id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 관리자구분 -->
</OBJECT>

<OBJECT id=gcds_empno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 관리번호 순번 개인용 -->
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	ft_cnt1.innerText="데이타 조회중입니다.";
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "조회건수 : " + rowcount + " 건";
	//document.all.LowerFrame.style.visibility="hidden";
	window.status = " 조회가 완료 되었습니다.";
	if (rowcount==0)	alert("검색된 데이타가 없습니다."); 
</script>

<script language=JavaScript  for=gcds_print2 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print2 event=OnLoadCompleted(rowcount)>
	//document.all.LowerFrame.style.visibility="hidden";
	if (rowcount<1) {
		alert("출력하실 정보가 없습니다");
	}else{
		gcrp_print4.preview();	
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.insertrow(1);
	gcds_dept2.namevalue(1,"DEPTCD") = "";
	gcds_dept2.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

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
<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030005_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>	    
			<img src="../../Common/img/btn/com_b_receipt.gif"	style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_btn_ledger.gif"	style="cursor:hand" onclick="ln_Print2()">
			<img src="../../Common/img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()"> 
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;귀속년도&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td  width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;소 속&nbsp;&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:112px;">
							<param name=ComboDataID			value="gcds_dept2">
							<param name=CBDataColumns		value="DEPTCD, DEPTNM">
							<param name=SearchColumn		value=DEPTNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DEPTNM^0^150">
							<param name=BindColumn			value=DEPTCD>
 						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
						<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
							<nobr>&nbsp;&nbsp;&nbsp;성 명&nbsp;&nbsp;&nbsp;</nobr></td>
						<td><nobr>&nbsp;<input id="txt_empnmk1" name="txt_empnmk1" type="text"  class="txtbox" style="width:70px; height:18px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;
						<input id="txt_empno1" type="hidden"  class="txtbox" style="width:70px; height:18px;" ">
					</nobr>
						</td>
						<td width="100%">&nbsp;&nbsp;</td>
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
          <td style="width:310px" valign=top>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  style="WIDTH: 302px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="FALSE">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
              <PARAM name="SortView"    value="Left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='귀속년도' ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	Mask='XXXX'</C> 
								<C> Name='소속'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT		sort=true</C> 
								<C> Name='성명'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		sort=true</C>
								<C> Name='사번'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER  sort=true</C> 
								<C> Name='입사일'		ID=STRTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	MASK='XXXX/XX/XX'	 sort=true</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:304px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>
					</td>
          <td>&nbsp;</td>
					<td STYLE="PADDING-TOP:0px;" valign=top>
		<table width="512" cellpadding="0" cellspacing="0" border="0">
			<tr> 
				<td valign=top>
				
					<table border= "0"  cellpadding=0 cellspacing=0  border=0  style='width:565px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
						<tr>
							<td class ="tab25" style="width:60;height:25px;" bgcolor="#eeeeee">&nbsp;귀속년도</td>
							<td class ="tab26" style="" colspan=2><nobr>
								<comment id="__NSID__"><object id=gcem_APPDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
									<param name=Text          value="">
								  <param name=Border	      value=true>
									<param name=Format	      value="YYYY">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=enable				value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>
							<td class ="tab26"  style="height:25px;" bgcolor="#eeeeee">&nbsp;사번</td>
							<td class ="tab26"  style="" colspan=2><nobr>
								<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt; " > 
								<param name=Text          value="">
								<param name=Border	      value=true>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=7>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>
							<td class ="tab26"  style="" bgcolor="#eeeeee">&nbsp;성명</td>
							<td class ="tab26"  style="" colspan=2>
								<input id="txt_empnmk2" name="txt_empnmk2" type="text"  class="txtbox"  style="width:70px; height:18px;position:relative;left:6px" maxlength=16 disabled>
							</td>
						</tr>
						<tr>
							<td class ="tab30" style="height:25px;" bgcolor="#eeeeee">&nbsp;소속</td>
							<td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_deptnm" name="txt_deptnm" type="text"  class="txtbox" style="width:70px; height:18px;position:relative;left:-6px" maxlength=16 disabled></td>
							</td>
							<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;직위</td>
							<td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_paygrdnm" name="txt_paygrdnm" type="text"  class="txtbox"  style= "width:70px; height:18px; position:relative;left:-6px" value="" maxlength=16 disabled></td>
							</td>
							<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;호봉</td>
						  <td class ="tab21" style="" colspan=2>&nbsp;
								<input id="txt_payseqnm" name="txt_payseq" type="text"  class="txtbox"  style= "width:70px; height:18px; position:relative;left:-6px" value="" maxlength=16 disabled></td>
			
						</tr>
						<tr>
						<td class ="tab30" style="height:25px;" bgcolor="#eeeeee">&nbsp;입사일자</td>
						<td class ="tab21" style="" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Text          value="">
		   					<param name=Border	      value=True>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class ="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;퇴사일자</td>
						<td class ="tab21" style="" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; "  >
								<param name=Text          value="">
								<param name=Border	      value=True>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab28" colspan=2><nobr>&nbsp;</nobr>
					</tr>
					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>
					<tr>
						<td class="tab25" style="font-family:굴림;font-size:9pt;" bgcolor="#B9D4DC">&nbsp;소득명세</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" colspan=2>현근무지</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee">종전근무지</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" colspan=2>종전근무지</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee">납세조합</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#DCDCDC" colspan=2>합계</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;급여</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px;height:20px;font-family:굴림;font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bc11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
							  <param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pbc1000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;상여</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
							  <param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_bc12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pbc2000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;인정상여</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bc13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pbc3000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#DCDCDC">&nbsp;계</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_bc10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bc20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_twksum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
										<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					
					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;비과세소득</td>
						<td class="tab24" colspan=2><nobr>
							&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab26" colspan=2><nobr>&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#DCDCDC">&nbsp;비과세소득계</td>
						<td class="tab26" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;야근근로수당</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;기타비과세</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;국외근로소득</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pc23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;정산명세</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;총급여</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;근로소득공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb20000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;근로소득금액</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb30000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;인적공제</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;본인</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_baamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;배우자</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_baamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;부양가족</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_baamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;경로우대</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;장애인</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;부녀자</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;자녀양육비</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;출산.입양자</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt07 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;다자녀추가공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_adamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;국민연금보험료공제&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pensum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#B9D4DC"><nobr>&nbsp;퇴직연금보험료공제&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;특별공제</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#DCDCDC">&nbsp;특별공제계</td>
						<td class="tab14" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_spcsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;보험료</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_inssum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;의료비</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_medsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;교육비</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_edusum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;주택임차차입금<br>&nbsp;원리금상환액</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt02s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;장기주택저당<br>&nbsp;차입금이자상환액</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt34s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;주택마련<br>&nbsp;저축소득공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_houamt01s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>

						<td class="tab27" bgcolor="#eeeeee">&nbsp;기부금</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_consum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;혼인이사장례</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_marsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>

						<td class="tab28" bgcolor="#eeeeee">&nbsp;표준공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_stdsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;차감소득금액&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_offsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;조특소득공제</nobr></td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#DCDCDC">&nbsp;조특소득공제계</td>
						<td class="tab14" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;개인연금<br>&nbsp;저축소득공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt011s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee">&nbsp;연금저축<br>&nbsp;소득공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt01s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;투자조합<br>&nbsp;출자소득공제</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcsum02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;신용카드 등<br>&nbsp;소득공제</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etcamt03s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;우리사주<br>&nbsp;조합소득공제</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_etdamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#eeeeee"><nobr>&nbsp;장기주식형<br>&nbsp;저축소득공제</nobr></td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_fndsums classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;종합소득과세표준&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_tstdsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;산출세액&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_stdtax classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;세액감면</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab26" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab26" colspan=2><nobr>&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#DCDCDC">&nbsp;감면세액계</td>
						<td class="tab26" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;소득세법</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;조세특례제한법</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_redamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC">&nbsp;세액공제</td>
						<td class="tab24" colspan=2>&nbsp;</td>
						<td class="tab26" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab26" colspan=2><nobr>&nbsp;</nobr>
						</td>
						<td class="tab26" bgcolor="#DCDCDC">&nbsp;세액공제계</td>
						<td class="tab26" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;근로소득</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;납세조합공제</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;주택차입금</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;외국인납부</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;기부정치자금</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_dedamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;</td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" bgcolor="#B9D4DC"><nobr>&nbsp;결정세액&nbsp;</nobr></td>
						<td class="tab24" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb40000_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab24" colspan=2><nobr>&nbsp;</nobr></td>
						<td class="tab24" bgcolor="#eeeeee">&nbsp;</td>
						<td class="tab14" colspan=2><nobr>&nbsp;</nobr></td>
					</tr>

					<tr>
						<td style="height:3px;border:0 solid #708090;" colspan=6></td>
					</tr>

					<tr>
						<td class="tab25" style="font-family:굴림;font-size:9pt;" bgcolor="#B9D4DC">&nbsp;세액명세</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" colspan=2>소득세</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee">주민세</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" colspan=2>농어촌특별세</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#DCDCDC">계</td>
						<td class="tab14" style="font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;결정세액</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px;height:20px;font-family:굴림;font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb40000_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
  							<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;전근무지<br>&nbsp;기납부세액</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb51000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28"><nobr>
							<comment id="__NSID__"><object id=gcem_pb52000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb53000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb50000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;현근무지기<br>&nbsp;납부세액</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb61000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb62000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb63000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb60000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
					</tr>
					<tr>
						<td class="tab27" bgcolor="#eeeeee">&nbsp;차감징수세액</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb71000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb72000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb73000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gcem_pb70000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td class="tab28" colspan=2>&nbsp;</td>
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
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
			<C>Col=APPDT			Ctrl=gcem_APPDT			Param=Text</C>
			<C>Col=EMPNO			Ctrl=gcem_empno     Param=Text</C>
			<C>Col=EMPNMK			Ctrl=txt_empnmk2    Param=Value</C>
			<C>Col=DEPTNM			Ctrl=txt_deptnm     Param=Value</C>
			<C>Col=PAYGRDNM		Ctrl=txt_paygrdnm   Param=Value</C>
			<C>Col=PAYSEQNM		Ctrl=txt_payseqnm   Param=Value</C>
			<C>Col=STRTDT			Ctrl=gcem_strtdt    Param=Text</C>
			<C>Col=ENDDT			Ctrl=gcem_enddt     Param=Text</C>
			<C>Col=PC11000		Ctrl=gcem_pc11000   Param=Text</C>
			<C>Col=PC12000		Ctrl=gcem_pc12000   Param=Text</C>
			<C>Col=PC13000		Ctrl=gcem_pc13000   Param=Text</C>
			<C>Col=PC10000		Ctrl=gcem_pc10000   Param=Text</C>
			<C>Col=BC11000		Ctrl=gcem_bc11000   Param=Text</C>
			<C>Col=BC12000		Ctrl=gcem_bc12000   Param=Text</C>
			<C>Col=BC13000		Ctrl=gcem_bc13000   Param=Text</C>
			<C>Col=BC10000		Ctrl=gcem_bc10000   Param=Text</C>
			<C>Col=BC21000		Ctrl=gcem_bc21000   Param=Text</C>
			<C>Col=BC22000		Ctrl=gcem_bc22000   Param=Text</C>
			<C>Col=BC23000		Ctrl=gcem_bc23000   Param=Text</C>
			<C>Col=BC20000		Ctrl=gcem_bc20000   Param=Text</C>
			<C>Col=PBC1000		Ctrl=gcem_pbc1000   Param=Text</C>
			<C>Col=PBC2000		Ctrl=gcem_pbc2000   Param=Text</C>
			<C>Col=PBC3000		Ctrl=gcem_pbc3000   Param=Text</C>
			<C>Col=TWKSUM			Ctrl=gcem_twksum    Param=Text</C>
			<C>Col=PC21000		Ctrl=gcem_pc21000   Param=Text</C>
			<C>Col=PC22000		Ctrl=gcem_pc22000   Param=Text</C>
			<C>Col=PC23000		Ctrl=gcem_pc23000   Param=Text</C>
			<C>Col=PC20000		Ctrl=gcem_pc20000   Param=Text</C>
			<C>Col=PB10000		Ctrl=gcem_pb10000   Param=Text</C>
			<C>Col=PB20000		Ctrl=gcem_pb20000   Param=Text</C>
			<C>Col=PB30000		Ctrl=gcem_pb30000   Param=Text</C>
			<C>Col=BAAMT01		Ctrl=gcem_baamt01   Param=Text</C>
			<C>Col=BAAMT02		Ctrl=gcem_baamt02   Param=Text</C>
			<C>Col=BAAMT03		Ctrl=gcem_baamt03   Param=Text</C>
			<C>Col=ADAMT01		Ctrl=gcem_adamt01   Param=Text</C>
			<C>Col=ADAMT02		Ctrl=gcem_adamt02   Param=Text</C>
			<C>Col=ADAMT03		Ctrl=gcem_adamt03   Param=Text</C>
			<C>Col=ADAMT04		Ctrl=gcem_adamt04   Param=Text</C>
			<C>Col=ADAMT05S		Ctrl=gcem_adamt05   Param=Text</C>
			<C>Col=PENSUMS		Ctrl=gcem_pensum    Param=Text</C>
			<C>Col=INSSUM			Ctrl=gcem_inssum    Param=Text</C>
			<C>Col=MEDSUM			Ctrl=gcem_medsum    Param=Text</C>
			<C>Col=EDUSUM			Ctrl=gcem_edusum    Param=Text</C>
			<C>Col=CONSUM			Ctrl=gcem_consum    Param=Text</C>
			<C>Col=MARSUM			Ctrl=gcem_marsum    Param=Text</C>
			<C>Col=SPCSUM			Ctrl=gcem_spcsum    Param=Text</C>
			<C>Col=STDSUM			Ctrl=gcem_stdsum    Param=Text</C>
			<C>Col=OFFSUM			Ctrl=gcem_offsum    Param=Text</C>
			<C>Col=ETCAMT011S Ctrl=gcem_etcamt011s Param=Text</C>
			<C>Col=ETCAMT01S   Ctrl=gcem_etcamt01s  Param=Text</C>
			<C>Col=ETCAMT02   Ctrl=gcem_etcsum02  Param=Text</C>
			<C>Col=ETCAMT03S  Ctrl=gcem_etcamt03s  Param=Text</C>
			<C>Col=ETCAMT04   Ctrl=gcem_etdamt04  Param=Text</C>
			<C>Col=ETCSUM     Ctrl=gcem_etcsum    Param=Text</C>
			<C>Col=TSTDSUM    Ctrl=gcem_tstdsum   Param=Text</C>
			<C>Col=STDTAX     Ctrl=gcem_stdtax    Param=Text</C>
			<C>Col=REDAMT01S  Ctrl=gcem_redamt01  Param=Text</C>
			<C>Col=REDAMT02S  Ctrl=gcem_redamt02  Param=Text</C>
			<C>Col=REDSUM     Ctrl=gcem_redsum    Param=Text</C>
			<C>Col=DEDAMT01S	Ctrl=gcem_dedamt01  Param=Text</C>
			<C>Col=DEDAMT02S	Ctrl=gcem_dedamt02  Param=Text</C>
			<C>Col=DEDAMT03S	Ctrl=gcem_dedamt03  Param=Text</C>
			<C>Col=DEDAMT04S	Ctrl=gcem_dedamt04  Param=Text</C>
			<C>Col=DEDAMT05S	Ctrl=gcem_dedamt05  Param=Text</C>
			<C>Col=DEDSUM			Ctrl=gcem_dedsum    Param=Text</C>
			<C>Col=PB40000		Ctrl=gcem_pb40000_1 Param=Text</C>
			<C>Col=PB40000		Ctrl=gcem_pb40000_2 Param=Text</C>
			<C>Col=PB41000		Ctrl=gcem_pb41000   Param=Text</C>
			<C>Col=PB42000		Ctrl=gcem_pb42000   Param=Text</C>
			<C>Col=PB43000		Ctrl=gcem_pb43000   Param=Text</C>
			<C>Col=PB51000		Ctrl=gcem_pb51000   Param=Text</C>
			<C>Col=PB52000		Ctrl=gcem_pb52000   Param=Text</C>
			<C>Col=PB53000		Ctrl=gcem_pb53000   Param=Text</C>
			<C>Col=PB50000		Ctrl=gcem_pb50000   Param=Text</C>
			<C>Col=PB61000		Ctrl=gcem_pb61000   Param=Text</C>
			<C>Col=PB62000		Ctrl=gcem_pb62000   Param=Text</C>
			<C>Col=PB63000		Ctrl=gcem_pb63000   Param=Text</C>
			<C>Col=PB60000		Ctrl=gcem_pb60000   Param=Text</C>
			<C>Col=PB71000		Ctrl=gcem_pb71000   Param=Text</C>
			<C>Col=PB72000		Ctrl=gcem_pb72000   Param=Text</C>
			<C>Col=PB73000		Ctrl=gcem_pb73000   Param=Text</C>
			<C>Col=PB70000		Ctrl=gcem_pb70000   Param=Text</C>
			<C>Col=ADAMT07		Ctrl=gcem_adamt07   Param=Text</C>
			<C>Col=HOUAMT02S		Ctrl=gcem_houamt02s  Param=Text</C>
			<C>Col=HOUAMT34S	Ctrl=gcem_houamt34s Param=Text</C>
			<C>Col=HOUAMT01S		Ctrl=gcem_houamt01s  Param=Text</C>
			<C>Col=FNDSUMS		Ctrl=gcem_fndsums   Param=Text</C>
			<C>Col=ETCAMT05		Ctrl=gcem_etcamt05   Param=Text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 Ⅰ : 근로소득원천징수영수증 REPORT
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print">  -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='1쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'

<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2746 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=66 ,top=185 ,right=394 ,bottom=275 ,border=true</X>
	<L> left=29 ,top=2651 ,right=1852 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=159 ,right=29 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210㎜x297㎜(일반용지 54g/㎡)' ,left=1207 ,top=2662 ,right=1849 ,bottom=2704 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(제1쪽)' ,left=1691 ,top=90 ,right=1847 ,bottom=151 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1720 ,top=318 ,right=1720 ,bottom=360 </L>
	<L> left=1294 ,top=233 ,right=1831 ,bottom=233 </L>
	<T>id='여1 / 부2' ,left=1585 ,top=280 ,right=1826 ,bottom=315 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=1302 ,top=196 ,right=1513 ,bottom=228 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자1 / 비거주자2' ,left=1529 ,top=196 ,right=1826 ,bottom=228 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외국인' ,left=1302 ,top=241 ,right=1513 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=273 ,right=1831 ,bottom=273 </L>
	<T>id='외국인단일세율적용' ,left=1302 ,top=280 ,right=1572 ,bottom=315 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=318 ,right=1831 ,bottom=318 </L>
	<T>id='거주지국' ,left=1302 ,top=323 ,right=1421 ,bottom=357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=360 ,right=1831 ,bottom=360 </L>
	<T>id='내국인1 / 외국인9' ,left=1529 ,top=241 ,right=1826 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국코드' ,left=1529 ,top=323 ,right=1709 ,bottom=357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=98 ,top=1781 ,right=138 ,bottom=1820 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=98 ,top=1860 ,right=138 ,bottom=1900 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=188 ,right=1831 ,bottom=188 </L>
	<L> left=1294 ,top=188 ,right=1294 ,bottom=360 </L>
	<T>id='[별지 제24호 서식(1)]   (2008.12.12 조세특례제한법 일부 개정안 국회 본회의 의결 반영)' ,left=29 ,top=90 ,right=1437 ,bottom=151 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1852 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=614 ,right=1852 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='득' ,left=34 ,top=804 ,right=87 ,bottom=833 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=34 ,top=836 ,right=87 ,bottom=865 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=775 ,right=87 ,bottom=802 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=34 ,top=743 ,right=87 ,bottom=770 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='처' ,left=34 ,top=712 ,right=87 ,bottom=738 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='무' ,left=34 ,top=680 ,right=87 ,bottom=709 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근' ,left=34 ,top=648 ,right=87 ,bottom=677 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=870 ,right=87 ,bottom=897 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합  계' ,left=1609 ,top=622 ,right=1847 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)' ,left=1117 ,top=622 ,right=1334 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자' ,left=37 ,top=503 ,right=209 ,bottom=569 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=381 ,right=1852 ,bottom=381 </L>
	<T>id='의무자' ,left=37 ,top=445 ,right=209 ,bottom=489 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=572 ,right=1852 ,bottom=572 </L>
	<L> left=90 ,top=654 ,right=1852 ,bottom=654 </L>
	<L> left=214 ,top=421 ,right=1852 ,bottom=421 </L>
	<T>id='①법 인 명 (상 호)' ,left=220 ,top=386 ,right=508 ,bottom=418 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑧주소' ,left=220 ,top=540 ,right=508 ,bottom=569 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑥성명' ,left=220 ,top=503 ,right=508 ,bottom=532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑤소 재 지 (주소)' ,left=220 ,top=466 ,right=508 ,bottom=492 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③사업자등록번호' ,left=220 ,top=429 ,right=508 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=214 ,top=460 ,right=1852 ,bottom=460 </L>
	<L> left=214 ,top=534 ,right=1852 ,bottom=534 </L>
	<L> left=29 ,top=497 ,right=1852 ,bottom=497 </L>
	<T>id='까지' ,left=1749 ,top=579 ,right=1826 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부터' ,left=1513 ,top=579 ,right=1588 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징   수' ,left=37 ,top=392 ,right=209 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구   분' ,left=101 ,top=622 ,right=508 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)계' ,left=101 ,top=915 ,right=508 ,bottom=945 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=908 ,right=1852 ,bottom=908 </L>
	<T>id='15)-1주식매수선택권 행사이익' ,left=101 ,top=873 ,right=508 ,bottom=902 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=865 ,right=1852 ,bottom=865 </L>
	<T>id='15)인   정   상   여' ,left=101 ,top=831 ,right=508 ,bottom=860 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=823 ,right=1852 ,bottom=823 </L>
	<T>id='14)상               여' ,left=101 ,top=788 ,right=508 ,bottom=818 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=781 ,right=1852 ,bottom=781 </L>
	<T>id='13)급               여' ,left=101 ,top=746 ,right=508 ,bottom=775 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)사업자등록번호' ,left=101 ,top=704 ,right=508 ,bottom=733 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=696 ,right=1852 ,bottom=696 </L>
	<T>id='11)근   무   처   명' ,left=101 ,top=661 ,right=508 ,bottom=691 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1117, top=915, right=1334, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1614, top=915, right=1844, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=90 ,top=616 ,right=90 ,bottom=950 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1117, top=788, right=1334, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1614, top=788, right=1844, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1117, top=833, right=1334, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1614, top=833, right=1844, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1117, top=749, right=1334, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1614, top=749, right=1844, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1117, top=704, right=1334, bottom=733, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=90 ,top=741 ,right=1852 ,bottom=741 </L>
	<C>id='BCWKNM2', left=1117, top=661, right=1334, bottom=691, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HTITLE', left=630, top=299, right=1048, bottom=339, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='근로소득지급조서' ,left=598 ,top=241 ,right=1217 ,bottom=288 ,align='left' ,face='HY중고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로소득원천징수영수증' ,left=598 ,top=188 ,right=1217 ,bottom=235 ,align='left' ,face='HY중고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=278 ,border=true</X>
	<X>left=550 ,top=193 ,right=579 ,bottom=228 ,border=true</X>
	<T>id='관리' ,left=71 ,top=191 ,right=185 ,bottom=230 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=71 ,top=233 ,right=185 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=302, top=191, right=389, bottom=270, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2008 -' ,left=206 ,top=191 ,right=320 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비과세' ,left=32 ,top=960 ,right=127 ,bottom=990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3외국인근로자' ,left=1093 ,top=960 ,right=1336 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)그 밖의 비과세' ,left=1344 ,top=960 ,right=1590 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)비과세소득 계' ,left=1598 ,top=960 ,right=1842 ,bottom=992 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1045 ,right=1852 ,bottom=1045 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(PC22000,0,,PC22000)}', left=1352, top=1008, right=1585, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='17)연구활동비' ,left=138 ,top=960 ,right=331 ,bottom=987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑨귀  속  연  도' ,left=34 ,top=579 ,right=413 ,bottom=611 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1363 ,top=381 ,right=1363 ,bottom=460 </L>
	<L> left=1005 ,top=497 ,right=1005 ,bottom=534 </L>
	<L> left=1363 ,top=497 ,right=1363 ,bottom=534 </L>
	<T>id='⑦주 민  등 록  번 호' ,left=1013 ,top=503 ,right=1355 ,bottom=532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1384, top=503, right=1818, bottom=532, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='②대 표 자 (성     명)' ,left=1013 ,top=386 ,right=1355 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=569 ,top=386 ,right=860 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='101-85-10695' ,left=569 ,top=429 ,right=860 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서울시 종로구 계동 현대빌딩 140-2' ,left=569 ,top=466 ,right=1704 ,bottom=492 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDNM', left=569, top=540, right=1818, bottom=569, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='조 건 식' ,left=1384 ,top=386 ,right=1704 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1384 ,top=429 ,right=1704 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=569, top=500, right=860, bottom=534, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='까지' ,left=974 ,top=579 ,right=1040 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑩감면기간' ,left=1066 ,top=579 ,right=1312 ,bottom=609 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1323 ,top=574 ,right=1323 ,bottom=614 </L>
	<T>id='16)-1납세조합' ,left=1349 ,top=622 ,right=1580 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCWKNM3', left=1349, top=661, right=1585, bottom=691, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1349, top=704, right=1585, bottom=733, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1349, top=749, right=1585, bottom=775, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1349, top=788, right=1585, bottom=818, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1349, top=833, right=1585, bottom=860, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1349, top=915, right=1585, bottom=945, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=950 ,right=1852 ,bottom=950 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='소 득' ,left=34 ,top=1003 ,right=119 ,bottom=1042 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1087 ,top=614 ,right=1087 ,bottom=1048 </L>
	<L> left=339 ,top=950 ,right=339 ,bottom=1042 </L>
	<L> left=132 ,top=997 ,right=1852 ,bottom=997 </L>
	<C>id='{decode(PC21000+PC22000+PC23000,0,,PC21000+PC22000+PC23000)}', left=1595, top=1008, right=1855, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명' ,left=40 ,top=1572 ,right=85 ,bottom=1609 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정' ,left=40 ,top=1363 ,right=85 ,bottom=1402 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='산' ,left=40 ,top=1468 ,right=85 ,bottom=1505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합' ,left=98 ,top=1439 ,right=138 ,bottom=1479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종' ,left=98 ,top=1360 ,right=138 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=98 ,top=1519 ,right=138 ,bottom=1556 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=98 ,top=1595 ,right=138 ,bottom=1632 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)총 급 여(16)' ,left=98 ,top=1053 ,right=550 ,bottom=1085 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)근로소득공제' ,left=98 ,top=1098 ,right=550 ,bottom=1130 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='23)근로소득금액' ,left=98 ,top=1143 ,right=550 ,bottom=1175 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='31)다자녀추가공제(' ,left=153 ,top=1566 ,right=445 ,bottom=1598 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)국외근로' ,left=362 ,top=958 ,right=556 ,bottom=984 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC23000,0,,PC23000)}', left=360, top=1005, right=564, bottom=1035, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=452, top=1566, right=513, bottom=1598 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=516 ,top=1566 ,right=572 ,bottom=1598 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=40 ,top=1659 ,right=85 ,bottom=1696 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2출산보육수당' ,left=836 ,top=960 ,right=1085 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)' ,left=595 ,top=622 ,right=818 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=749, right=818, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=833, right=818, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=915, right=818, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='18)-1야간근로수당' ,left=590 ,top=960 ,right=828 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=841, top=749, right=1080, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=841, top=788, right=1080, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=841, top=833, right=1080, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=841, top=915, right=1080, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='종(전)' ,left=839 ,top=622 ,right=1080 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=191 ,top=185 ,right=191 ,bottom=273 </L>
	<L> left=214 ,top=381 ,right=214 ,bottom=572 </L>
	<L> left=442 ,top=572 ,right=442 ,bottom=611 </L>
	<T>id='세무서장  귀하' ,left=299 ,top=2582 ,right=564 ,bottom=2617 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(서명 또는 인)' ,left=1482 ,top=2551 ,right=1749 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=1169 ,top=2551 ,right=1426 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수(보고)의무자' ,left=743 ,top=2551 ,right=1095 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT2', left=738, top=2492, right=1146, bottom=2529 ,mask='XXXX년  02월  28일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=246 ,top=2328 ,right=1847 ,bottom=2328 </L>
	<L> left=90 ,top=2373 ,right=1852 ,bottom=2373 </L>
	<L> left=29 ,top=2418 ,right=1852 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=2286 ,right=1852 ,bottom=2286 </L>
	<L> left=130 ,top=953 ,right=130 ,bottom=1045 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=140 ,top=1183 ,right=140 ,bottom=2159 </L>
	<L> left=222 ,top=1606 ,right=222 ,bottom=2156 </L>
	<T>id='보험료' ,left=148 ,top=1656 ,right=220 ,bottom=1685 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=148 ,top=1701 ,right=220 ,bottom=1730 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=148 ,top=1799 ,right=220 ,bottom=1857 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=148 ,top=1863 ,right=220 ,bottom=1921 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=148 ,top=1931 ,right=220 ,bottom=1990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=148 ,top=1995 ,right=220 ,bottom=2056 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)국민연금보험료공제' ,left=225 ,top=1614 ,right=553 ,bottom=1646 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)퇴직연금소득공제' ,left=225 ,top=1709 ,right=548 ,bottom=1741 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)보   험   료' ,left=225 ,top=1754 ,right=545 ,bottom=1786 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='35)의   료   비' ,left=225 ,top=1797 ,right=545 ,bottom=1828 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)교   육   비' ,left=225 ,top=1839 ,right=545 ,bottom=1871 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)주택임차차입금원리금상환액' ,left=225 ,top=1881 ,right=566 ,bottom=1913 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='24)본         인' ,left=235 ,top=1191 ,right=519 ,bottom=1222 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)배   우   자' ,left=235 ,top=1233 ,right=529 ,bottom=1265 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)부양가족(' ,left=235 ,top=1273 ,right=421 ,bottom=1304 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)경로우대(' ,left=235 ,top=1315 ,right=421 ,bottom=1347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)장 애 인 (' ,left=235 ,top=1357 ,right=421 ,bottom=1389 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)부   녀   자' ,left=235 ,top=1400 ,right=529 ,bottom=1431 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)자녀양육비(' ,left=235 ,top=1442 ,right=450 ,bottom=1474 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=455, top=1442, right=497, bottom=1474 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=505 ,top=1442 ,right=553 ,bottom=1474 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=429, top=1360, right=489, bottom=1389 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=511 ,top=1357 ,right=566 ,bottom=1389 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=426, top=1320, right=487, bottom=1347 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=508 ,top=1315 ,right=564 ,bottom=1347 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=429, top=1273, right=492, bottom=1304 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=511 ,top=1273 ,right=566 ,bottom=1304 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1기타연금보험료공제' ,left=225 ,top=1662 ,right=558 ,bottom=1693 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=146 ,top=1617 ,right=222 ,bottom=1646 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)기부금' ,left=225 ,top=1963 ,right=545 ,bottom=1995 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)표 준 공 제' ,left=225 ,top=2127 ,right=545 ,bottom=2156 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)혼인ㆍ이사ㆍ장례비' ,left=225 ,top=2006 ,right=545 ,bottom=2037 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      계' ,left=225 ,top=2085 ,right=545 ,bottom=2117 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 정 세 액[51)-55)-63)]' ,left=995 ,top=2170 ,right=1471 ,bottom=2199 ,align='left' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='42)차 감 소 득 금 액' ,left=101 ,top=2172 ,right=582 ,bottom=2201 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구          분' ,left=101 ,top=2215 ,right=582 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)결     정     세     액' ,left=101 ,top=2254 ,right=582 ,bottom=2283 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)차  감  징  수  세  액' ,left=101 ,top=2381 ,right=582 ,bottom=2410 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기납부' ,left=98 ,top=2299 ,right=225 ,bottom=2331 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세   액' ,left=98 ,top=2331 ,right=225 ,bottom=2363 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='66)주(현)근무지' ,left=257 ,top=2339 ,right=579 ,bottom=2368 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)종(전)근무지' ,left=257 ,top=2294 ,right=579 ,bottom=2323 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC21000,0,,PC21000)}', left=598, top=1008, right=820, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB10000,0,,PB10000)}', left=598, top=1050, right=934, bottom=1087, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=598, top=1101, right=934, bottom=1130, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB30000,0,,PB30000)}', left=598, top=1146, right=934, bottom=1175, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=598, top=1188, right=934, bottom=1217, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=598, top=1233, right=934, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=598, top=1275, right=934, bottom=1304, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=598, top=1320, right=934, bottom=1347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=598, top=1357, right=934, bottom=1389, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=598, top=1402, right=934, bottom=1431, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=598, top=1445, right=934, bottom=1474, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=598, top=1566, right=934, bottom=1598, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=598, top=1614, right=934, bottom=1646, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=598, top=1759, right=934, bottom=1786, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=598, top=1799, right=934, bottom=1828, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=598, top=1842, right=934, bottom=1871, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=598, top=1966, right=934, bottom=1995, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MARSUM,0,,MARSUM)}', left=598, top=2008, right=934, bottom=2037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=598, top=2088, right=934, bottom=2117, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=598, top=2127, right=934, bottom=2156, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='농어촌특별세' ,left=1241 ,top=2215 ,right=1535 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=598 ,top=2215 ,right=934 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=598, top=2254, right=934, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB51000,0,,PB51000)}', left=598, top=2297, right=934, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=598, top=2339, right=934, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주민세' ,left=947 ,top=2215 ,right=1233 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1236 ,top=2209 ,right=1236 ,bottom=2418 </L>
	<C>id='{decode(PB71000,0,,PB71000)}', left=595, top=2384, right=931, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계' ,left=1548 ,top=2215 ,right=1842 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위의 원천징수액(근로소득)을 영수(지급)합니다.' ,left=95 ,top=2437 ,right=1511 ,bottom=2477 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1548, top=2339, right=1842, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB50000,0,,PB50000)}', left=1548, top=2297, right=1842, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1548, top=2254, right=1842, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1548, top=2384, right=1842, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1241, top=2339, right=1535, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB53000,0,,PB53000)}', left=1241, top=2297, right=1535, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1241, top=2254, right=1535, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1241, top=2384, right=1535, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=947, top=2339, right=1233, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB52000,0,,PB52000)}', left=947, top=2297, right=1233, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=947, top=2254, right=1233, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=947, top=2384, right=1233, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=222 ,top=2119 ,right=942 ,bottom=2119 </L>
	<L> left=222 ,top=2080 ,right=942 ,bottom=2080 </L>
	<L> left=222 ,top=2040 ,right=942 ,bottom=2040 </L>
	<L> left=222 ,top=2000 ,right=942 ,bottom=2000 </L>
	<L> left=222 ,top=1958 ,right=942 ,bottom=1958 </L>
	<L> left=222 ,top=1916 ,right=942 ,bottom=1916 </L>
	<L> left=222 ,top=1873 ,right=942 ,bottom=1873 </L>
	<L> left=222 ,top=1791 ,right=942 ,bottom=1791 </L>
	<L> left=222 ,top=1696 ,right=942 ,bottom=1696 </L>
	<L> left=222 ,top=1651 ,right=942 ,bottom=1651 </L>
	<L> left=222 ,top=1394 ,right=942 ,bottom=1394 </L>
	<L> left=222 ,top=1437 ,right=942 ,bottom=1437 </L>
	<L> left=222 ,top=1476 ,right=942 ,bottom=1476 </L>
	<L> left=222 ,top=1352 ,right=942 ,bottom=1352 </L>
	<L> left=222 ,top=1183 ,right=222 ,bottom=1561 </L>
	<L> left=230 ,top=2289 ,right=230 ,bottom=2371 </L>
	<T>id='기' ,left=146 ,top=1193 ,right=222 ,bottom=1220 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본' ,left=146 ,top=1220 ,right=222 ,bottom=1249 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=146 ,top=1249 ,right=222 ,bottom=1278 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=146 ,top=1278 ,right=222 ,bottom=1302 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=140 ,top=1312 ,right=945 ,bottom=1312 </L>
	<L> left=222 ,top=1225 ,right=942 ,bottom=1225 </L>
	<L> left=222 ,top=1267 ,right=942 ,bottom=1267 </L>
	<L> left=90 ,top=1090 ,right=945 ,bottom=1090 </L>
	<L> left=90 ,top=1135 ,right=945 ,bottom=1135 </L>
	<L> left=90 ,top=1180 ,right=945 ,bottom=1180 </L>
	<T>id='43)개인연금저축소득공제' ,left=1064 ,top=1056 ,right=1490 ,bottom=1087 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1553, top=1061, right=1834, bottom=1087, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)연금저축소득공제' ,left=1064 ,top=1098 ,right=1490 ,bottom=1130 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1553, top=1101, right=1834, bottom=1130, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2주택마련저축 소득공제' ,left=1064 ,top=1185 ,right=1490 ,bottom=1217 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='45)투자조합출자등소득공제' ,left=1064 ,top=1230 ,right=1490 ,bottom=1262 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='46)신용카드등소득공제' ,left=1064 ,top=1270 ,right=1490 ,bottom=1302 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='47)우리사주조합소득공제' ,left=1064 ,top=1315 ,right=1490 ,bottom=1347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)장기주식형저축 소득공제' ,left=1064 ,top=1357 ,right=1490 ,bottom=1389 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1553, top=1318, right=1834, bottom=1347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1553, top=1273, right=1834, bottom=1302, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1550, top=1233, right=1831, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1090 ,right=1849 ,bottom=1090 </L>
	<L> left=1058 ,top=1135 ,right=1849 ,bottom=1135 </L>
	<L> left=1058 ,top=1177 ,right=1849 ,bottom=1177 </L>
	<L> left=1058 ,top=1349 ,right=1849 ,bottom=1349 </L>
	<L> left=1058 ,top=1304 ,right=1849 ,bottom=1304 </L>
	<L> left=1058 ,top=1262 ,right=1849 ,bottom=1262 </L>
	<L> left=1058 ,top=1220 ,right=1849 ,bottom=1220 </L>
	<L> left=1058 ,top=1437 ,right=1849 ,bottom=1437 </L>
	<L> left=1056 ,top=1394 ,right=1847 ,bottom=1394 </L>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1550, top=1490, right=1831, bottom=1516, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)그 밖의 소득공제 계' ,left=1064 ,top=1484 ,right=1453 ,bottom=1516 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=2246 ,right=1852 ,bottom=2246 </L>
	<L> left=1852 ,top=156 ,right=1852 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1849 ,top=1519 ,right=222 ,bottom=1519 </L>
	<L> left=1056 ,top=1048 ,right=1056 ,bottom=1521 </L>
	<T>id='소득' ,left=950 ,top=1275 ,right=1048 ,bottom=1312 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그밖의' ,left=953 ,top=1230 ,right=1050 ,bottom=1267 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=953 ,top=1318 ,right=1050 ,bottom=1357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1058 ,top=1476 ,right=1849 ,bottom=1476 </L>
	<T>id='50)종합소득 과세표준' ,left=950 ,top=1524 ,right=1450 ,bottom=1556 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=140 ,top=1561 ,right=1849 ,bottom=1561 </L>
	<L> left=140 ,top=1606 ,right=1849 ,bottom=1606 </L>
	<T>id='51)산     출     세     액' ,left=950 ,top=1569 ,right=1450 ,bottom=1601 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1550, top=1527, right=1831, bottom=1553, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1550, top=1572, right=1831, bottom=1598, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1648 ,right=1849 ,bottom=1648 </L>
	<T>id='제' ,left=950 ,top=2061 ,right=1048 ,bottom=2111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=950 ,top=2003 ,right=1048 ,bottom=2053 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=950 ,top=1945 ,right=1048 ,bottom=1995 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=950 ,top=1886 ,right=1048 ,bottom=1937 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='54)' ,left=1066 ,top=1709 ,right=1455 ,bottom=1741 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1849 ,top=1831 ,right=222 ,bottom=1831 </L>
	<T>id='52)[소   득   세   법]' ,left=1066 ,top=1614 ,right=1455 ,bottom=1646 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='53)[조세특례제한법]' ,left=1066 ,top=1662 ,right=1455 ,bottom=1693 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1550, top=1617, right=1831, bottom=1646, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1550, top=1664, right=1831, bottom=1693, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1699 ,right=1849 ,bottom=1699 </L>
	<L> left=1058 ,top=1744 ,right=1849 ,bottom=1744 </L>
	<L> left=1058 ,top=1791 ,right=1849 ,bottom=1791 </L>
	<T>id='60)외  국   납  부' ,left=1066 ,top=2006 ,right=1455 ,bottom=2037 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)기부 정치자금' ,left=1066 ,top=1963 ,right=1455 ,bottom=1995 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)주 택 차 입 금' ,left=1066 ,top=1921 ,right=1455 ,bottom=1953 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)납세조합공제' ,left=1066 ,top=1881 ,right=1455 ,bottom=1913 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='56)근  로   소  득' ,left=1066 ,top=1839 ,right=1455 ,bottom=1871 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='55)세액감면 계' ,left=1066 ,top=1797 ,right=1455 ,bottom=1828 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1550, top=1802, right=1831, bottom=1828, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1550, top=1842, right=1831, bottom=1871, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1550, top=1884, right=1831, bottom=1913, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1550, top=1924, right=1831, bottom=1953, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1550, top=1966, right=1831, bottom=1995, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1550, top=2008, right=1831, bottom=2037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='세액' ,left=955 ,top=1670 ,right=1053 ,bottom=1699 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면' ,left=955 ,top=1704 ,right=1053 ,bottom=1736 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1066 ,top=2053 ,right=1455 ,bottom=2082 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='63)세 액 공 제 계' ,left=1066 ,top=2125 ,right=1455 ,bottom=2154 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='62)' ,left=1066 ,top=2088 ,right=1455 ,bottom=2117 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1550, top=2125, right=1831, bottom=2154, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1873 ,right=1849 ,bottom=1873 </L>
	<L> left=1058 ,top=1916 ,right=1849 ,bottom=1916 </L>
	<L> left=1058 ,top=1958 ,right=1849 ,bottom=1958 </L>
	<L> left=1058 ,top=2000 ,right=1849 ,bottom=2000 </L>
	<L> left=1058 ,top=2040 ,right=1849 ,bottom=2040 </L>
	<L> left=1058 ,top=2080 ,right=1849 ,bottom=2080 </L>
	<L> left=1058 ,top=2119 ,right=1849 ,bottom=2119 </L>
	<L> left=1058 ,top=1609 ,right=1058 ,bottom=2162 </L>
	<L> left=1056 ,top=572 ,right=1056 ,bottom=611 </L>
	<L> left=1540 ,top=1045 ,right=1540 ,bottom=2418 </L>
	<T>id='44)-1소기업ㆍ소상공인 공제부금 소득공제' ,left=1064 ,top=1143 ,right=1529 ,bottom=1175 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1521 ,top=188 ,right=1521 ,bottom=273 </L>
	<L> left=1831 ,top=191 ,right=1831 ,bottom=362 </L>
	<L> left=1577 ,top=275 ,right=1577 ,bottom=318 </L>
	<L> left=1426 ,top=320 ,right=1426 ,bottom=360 </L>
	<L> left=1527 ,top=318 ,right=1527 ,bottom=360 </L>
	<T>id='④주민(법인)등록번호' ,left=1013 ,top=429 ,right=1355 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1005 ,top=384 ,right=1005 ,bottom=463 </L>
	<C>id='BCWKNM1', left=841, top=664, right=1080, bottom=693, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO1', left=841, top=709, right=1080, bottom=738, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=788, right=818, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=831 ,top=614 ,right=831 ,bottom=1048 </L>
	<L> left=90 ,top=1048 ,right=90 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=537 ,top=381 ,right=537 ,bottom=574 </L>
	<T>id='30)-1출산ㆍ입양자(' ,left=233 ,top=1484 ,right=492 ,bottom=1516 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=495, top=1484, right=540, bottom=1516 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=542 ,top=1484 ,right=579 ,bottom=1516 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=143 ,top=1746 ,right=942 ,bottom=1746 </L>
	<T>id='37)-1장기주택저당차입금이자상환액' ,left=225 ,top=1924 ,right=579 ,bottom=1955 ,align='left' ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=2164 ,right=1852 ,bottom=2164 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1550, top=2170, right=1831, bottom=2199, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=587 ,top=616 ,right=587 ,bottom=2421 </L>
	<T>id='명' ,left=34 ,top=2320 ,right=87 ,bottom=2357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=34 ,top=2275 ,right=87 ,bottom=2315 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=2236 ,right=87 ,bottom=2273 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=2365 ,right=87 ,bottom=2402 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=942 ,top=1045 ,right=942 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2207 ,right=1852 ,bottom=2207 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1341 ,top=614 ,right=1341 ,bottom=1045 </L>
	<L> left=1590 ,top=614 ,right=1590 ,bottom=1045 </L>
	<X>left=1590 ,top=654 ,right=1852 ,bottom=696 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1590 ,top=696 ,right=1852 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=587 ,top=654 ,right=831 ,bottom=696 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=587 ,top=696 ,right=831 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='부터' ,left=669 ,top=579 ,right=746 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=466, top=579, right=661, bottom=606, align='right' ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CURDT', left=757, top=579, right=968, bottom=606, align='right' ,mask='XXXX/12/31', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Column', left=1344, top=579, right=1505, bottom=606, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1590, top=579, right=1744, bottom=606, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='제' ,left=146 ,top=1461 ,right=222 ,bottom=1490 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=146 ,top=1426 ,right=222 ,bottom=1458 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가' ,left=146 ,top=1394 ,right=222 ,bottom=1426 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추' ,left=146 ,top=1363 ,right=222 ,bottom=1394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=598, top=1487, right=934, bottom=1516, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=598, top=1709, right=934, bottom=1741, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=598, top=1926, right=934, bottom=1955, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=598, top=1884, right=934, bottom=1913, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1553, top=1188, right=1834, bottom=1217, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1553, top=1360, right=1834, bottom=1389, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=598, top=2172, right=934, bottom=2201, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
 <R>id='2쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print1', DetailDataID='gcds_print1', 
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=600 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='68)소득공제 명세(인적공제항목은 해당란에 O 표새를 하며, 각종 소득공제 항목은 공제를 위하여 실제 지출한 금액을 기입합니다)' ,left=71 ,top=87 ,right=1889 ,bottom=148 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[제2쪽]' ,left=1722 ,top=8 ,right=1879 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1902 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=161 ,right=1902 ,bottom=161 </L>
	<T>id='각종 소득공제 항목' ,left=1154 ,top=167 ,right=1897 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번' ,left=61 ,top=275 ,right=103 ,bottom=304 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호' ,left=61 ,top=307 ,right=103 ,bottom=333 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=111 ,top=167 ,right=188 ,bottom=209 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자 녀' ,left=717 ,top=262 ,right=826 ,bottom=291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=720 ,top=331 ,right=820 ,bottom=362 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='다자녀' ,left=839 ,top=265 ,right=947 ,bottom=310 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추가공제' ,left=833 ,top=310 ,right=958 ,bottom=352 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출산.' ,left=717 ,top=376 ,right=826 ,bottom=405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입양자' ,left=717 ,top=410 ,right=826 ,bottom=442 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=717 ,top=447 ,right=826 ,bottom=479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=407 ,top=508 ,right=460 ,bottom=564 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=601 ,right=1902 ,bottom=601 </L>
	<T>id='성 명' ,left=198 ,top=167 ,right=466 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=542 ,right=828 ,bottom=542 </L>
	<T>id='양육비' ,left=717 ,top=296 ,right=826 ,bottom=328 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=828 ,top=259 ,right=828 ,bottom=601 </L>
	<L> left=106 ,top=257 ,right=960 ,bottom=257 </L>
	<T>id='공제' ,left=595 ,top=429 ,right=704 ,bottom=471 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경로우대' ,left=590 ,top=384 ,right=709 ,bottom=429 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=595 ,top=318 ,right=704 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인' ,left=595 ,top=273 ,right=704 ,bottom=318 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=484 ,top=273 ,right=577 ,bottom=318 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=484 ,top=318 ,right=577 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀자' ,left=484 ,top=384 ,right=579 ,bottom=429 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=484 ,top=429 ,right=577 ,bottom=471 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=487 ,top=167 ,right=953 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=474 ,top=368 ,right=960 ,bottom=368 </L>
	<T>id='번         호' ,left=198 ,top=370 ,right=468 ,bottom=413 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주 민 등 록' ,left=198 ,top=325 ,right=468 ,bottom=370 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='코드' ,left=111 ,top=209 ,right=188 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내.외' ,left=111 ,top=325 ,right=188 ,bottom=370 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그밖의 자료' ,left=966 ,top=550 ,right=1143 ,bottom=598 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=828 ,top=368 ,right=960 ,bottom=487 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=712 ,top=259 ,right=712 ,bottom=601 </L>
	<X>left=582 ,top=487 ,right=712 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=474 ,top=542 ,right=582 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=582 ,top=542 ,right=712 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=712 ,top=542 ,right=828 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=828 ,top=542 ,right=960 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='보험료' ,left=1156 ,top=262 ,right=1262 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=1278 ,top=262 ,right=1389 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현금' ,left=1662 ,top=318 ,right=1778 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=1791 ,top=262 ,right=1897 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국인' ,left=111 ,top=370 ,right=188 ,bottom=413 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='영수증' ,left=1659 ,top=360 ,right=1783 ,bottom=394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=106 ,top=508 ,right=183 ,bottom=564 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=257 ,right=582 ,bottom=598 </L>
	<L> left=217 ,top=569 ,right=452 ,bottom=569 </L>
	<L> left=1146 ,top=257 ,right=1905 ,bottom=257 </L>
	<C>id='{decode(TCNT,0,,TCNT)}', left=251, top=503, right=386, bottom=564, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구 분' ,left=966 ,top=169 ,right=1143 ,bottom=479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=474 ,top=487 ,right=582 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=712 ,top=487 ,right=828 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='국세청자료' ,left=966 ,top=495 ,right=1143 ,bottom=540 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=542 ,right=966 ,bottom=542 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1394 ,top=259 ,right=1394 ,bottom=601 </L>
	<L> left=1654 ,top=259 ,right=1654 ,bottom=601 </L>
	<L> left=1786 ,top=259 ,right=1786 ,bottom=601 </L>
	<L> left=1270 ,top=259 ,right=1270 ,bottom=601 </L>
	<C>id='{decode(TREF11,0,,TREF11)}', left=1156, top=495, right=1270, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=1156, top=553, right=1270, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1278, top=495, right=1392, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1278, top=553, right=1392, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1659, top=553, right=1778, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1794, top=553, right=1894, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1659, top=495, right=1778, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1794, top=495, right=1894, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=828 ,top=487 ,right=960 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=474 ,top=161 ,right=474 ,bottom=601 </L>
	<L> left=191 ,top=161 ,right=191 ,bottom=601 </L>
	<L> left=106 ,top=161 ,right=106 ,bottom=601 </L>
	<L> left=1146 ,top=161 ,right=1146 ,bottom=601 </L>
	<L> left=61 ,top=487 ,right=1905 ,bottom=487 </L>
	<L> left=58 ,top=69 ,right=58 ,bottom=601 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1902 ,top=69 ,right=1902 ,bottom=601 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(제2쪽)' ,left=1662 ,top=8 ,right=1879 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=960 ,top=161 ,right=960 ,bottom=601 </L>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1400, top=495, right=1516, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1524, top=495, right=1651, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1524, top=553, right=1651, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1400, top=553, right=1516, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='신용카드' ,left=1527 ,top=299 ,right=1651 ,bottom=378 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등' ,left=1535 ,top=381 ,right=1640 ,bottom=415 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=1400 ,top=262 ,right=1511 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1519 ,top=259 ,right=1519 ,bottom=601 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=108 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=106 ,right=1902 ,bottom=106 </L>
	<T>id='그밖의 자료' ,left=966 ,top=61 ,right=1146 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청자료' ,left=966 ,top=8 ,right=1146 ,bottom=53 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1146 ,top=0 ,right=1146 ,bottom=103 </L>
	<C>id='PCNT', left=61, top=24, right=95, bottom=71, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=106 ,top=0 ,right=106 ,bottom=103 </L>
	<C>id='RELAT1', left=111, top=5, right=183, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF1,T,○,T,○,)}', left=111, top=58, right=183, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=191 ,top=0 ,right=191 ,bottom=103 </L>
	<C>id='RESINO1', left=198, top=58, right=466, bottom=103 ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=198, top=5, right=466, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=474 ,top=0 ,right=474 ,bottom=103 </L>
	<C>id='REF2', left=479, top=5, right=579, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=479, top=58, right=579, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=582 ,top=0 ,right=582 ,bottom=103 </L>
	<C>id='REF3', left=587, top=5, right=706, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5', left=587, top=58, right=706, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=712 ,top=0 ,right=712 ,bottom=103 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=103 </L>
	<L> left=960 ,top=3 ,right=960 ,bottom=106 </L>
	<C>id='', left=836, top=58, right=958, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1394 ,top=0 ,right=1394 ,bottom=103 </L>
	<L> left=482 ,top=53 ,right=960 ,bottom=53 </L>
	<L> left=106 ,top=50 ,right=474 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=958 ,top=53 ,right=1905 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1654 ,top=0 ,right=1654 ,bottom=103 </L>
	<L> left=1270 ,top=0 ,right=1270 ,bottom=103 </L>
	<L> left=1786 ,top=0 ,right=1786 ,bottom=103 </L>
	<C>id='{decode(REF11,0,,REF11)}', left=1156, top=8, right=1270, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21,0,,REF21)}', left=1156, top=61, right=1270, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1278, top=8, right=1392, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1278, top=61, right=1392, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1659, top=8, right=1778, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1659, top=61, right=1778, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1794, top=8, right=1894, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1794, top=61, right=1894, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=58 ,top=0 ,right=58 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1902 ,top=0 ,right=1902 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='REF4', left=717, top=5, right=826, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=831, top=5, right=953, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7', left=839, top=5, right=958, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8', left=717, top=58, right=826, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1524, top=8, right=1651, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1524, top=61, right=1651, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1400, top=8, right=1516, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1400, top=61, right=1516, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1519 ,top=5 ,right=1519 ,bottom=108 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=968 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='※ 작성방법' ,left=74 ,top=13 ,right=278 ,bottom=58 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 거주지국과 거주지국코드는 비거주자에 해당하는 경우에 한하여 적으며, 국제표준화기구(ISO)가 정한 ISO코드 중 국명약어 및 국가코드를 적습니다.' ,left=71 ,top=61 ,right=1889 ,bottom=101 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO국가코드 : 국세청홈페이지->국세정보->국세조세정보->국세조세자료실에서 조회 할 수 있습니다. 예) 대한민국: KR, 미국 : US' ,left=71 ,top=98 ,right=1889 ,bottom=138 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 근무처별소득명세란은 비과세소득을 제외하고 적고, 근무처별소득명세에 적힌 근무처의 비과세소득은 그 금액을 합산하여 비과세 소득란에 적습니다.' ,left=71 ,top=209 ,right=1889 ,bottom=249 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     까지 지급조서를 제출하여야 합니다.' ,left=71 ,top=172 ,right=1889 ,bottom=212 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 원천징수의무자는 지급일이 속하는 연도의 다음 연도 2월 말일(휴업 또는 폐업한 경우에는 휴업일 또는 폐업일이 속하는 달의 다음 다음 달 말일을 말합니다)' ,left=71 ,top=135 ,right=1889 ,bottom=175 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 갑종근로소득과 을종근로소득을 합산하여 연말정산하는 때에는 16)-1 납세조합란의 11)란과 13)란에 각각 을종근로소득납세조합과 을종근로소득을' ,left=71 ,top=246 ,right=1889 ,bottom=286 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=0 ,right=1902 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=966 ,right=1905 ,bottom=966 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='      적고, [소득세법 시행령] 제150조에 따른 납세조합공제금액을 57)납세조합공제란에 적습니다. 합병, 기업형태 변경 등으로 당해 법인이 연말정산을' ,left=71 ,top=283 ,right=1889 ,bottom=323 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      하는 경우에 피합병법인, 기업형태변경전의 소득은 근무처별소득명세 종(전)란에 별도로 적습니다.' ,left=71 ,top=320 ,right=1889 ,bottom=360 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3란은 외국인근로자가 [조세특례제한법] 제 18조의2제1항을 적용하는 경우에 한하여 적으며, 16)계란의 금액에 100분의 30을 곱한 금액을 적습니다.' ,left=71 ,top=357 ,right=1889 ,bottom=397 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)총급여란에는 16)계란의 금액을 적되, 18)-3란의 금액이 있는 경우에는 16)계란의 금액에서 18)-3란의 금액을 뺀 금액을 적으며, 외국인근로자가 ' ,left=71 ,top=394 ,right=1889 ,bottom=434 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [조세특례제한법] 제18조의2제2항에 따라 단일세율을 적용하는 경우에는 16)계 + 비과세소득 금액을 적고, 소득세와 관련한 비과세 .공제.감면 및 세액공제에 ' ,left=71 ,top=431 ,right=1889 ,bottom=471 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    관한 규정은 적용하지 아니합니다.' ,left=71 ,top=468 ,right=1889 ,bottom=508 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. 종합소득 특별공제[34) ~ 39)]란과 그 밖의 소득공제[43)~48)]란은 별지 제37호서식의 공제액을 적습니다.' ,left=71 ,top=505 ,right=1889 ,bottom=545 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. 67) 차감징수세액이 소액부징수(1천원 미만을 말합니다)에 해당하는 경우 세액을 0 으로 적습니다.' ,left=71 ,top=542 ,right=1889 ,bottom=582 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) 소득공제 명세란은 2006년 이후 발생하는 근로소득 연말정산분부터 사용합니다.' ,left=71 ,top=579 ,right=1889 ,bottom=619 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    가. 관계코드란 : 소득자 본인=0, 소득자의 직계존속=1, 배우자의 직계존속=2, 배우자=3, 직계비속=4, 형제자매=5, 기타=6을 적습니다(4.5.6의 경우 소득자와' ,left=71 ,top=619 ,right=1889 ,bottom=659 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           배우자의 각각의 관계를 포함합니다). ' ,left=71 ,top=656 ,right=1889 ,bottom=696 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    나. 내.외국인란 : 내국인의 경우 1 로, 외국인의 경우 9 로 적습니다.' ,left=71 ,top=693 ,right=1889 ,bottom=733 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    다. 인적공제항목란 : 인적공제사항이 있는 경우 해당란에 O 표시를 합니다(해당사항이 없을 경우 비워둡니다).' ,left=71 ,top=730 ,right=1889 ,bottom=770 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    라. 국세청 자료란 : [소득세법] 제165조에 따라 국세청 홈페이지에서 제공하는 각 소득공제 항목의 금액 중 소득공제대상이 되는 금액을  적습니다.' ,left=71 ,top=767 ,right=1889 ,bottom=807 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    마. 그 밖의 자료란 : 국세청에서 제공하는 증빙서류 외의 것을 말합니다.(예를 들면, 학원비 지로납부영수증은 신용카드 등 란에, 시력교정용 안경구입비는 ' ,left=71 ,top=804 ,right=1889 ,bottom=844 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    바. 각종 소득공제 항목란 : 소득공제항목에 해당하는 실제 지출금액을 적습니다(소득공제액이 아닌 실제 사용금액이 금액단위별로 구분된 범위 안에 적도록' ,left=71 ,top=878 ,right=1889 ,bottom=918 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         작성합니다).' ,left=71 ,top=915 ,right=1889 ,bottom=955 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        의료비란에 각각 적습니다).' ,left=71 ,top=841 ,right=1889 ,bottom=881 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>




</R>
</A>

	">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 ⅠⅠ : 근로소득원천징수영수증 REPORT
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='3쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'
	
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2746 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=66 ,top=185 ,right=394 ,bottom=275 ,border=true</X>
	<L> left=29 ,top=2651 ,right=1852 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=159 ,right=29 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210㎜x297㎜(일반용지 54g/㎡)' ,left=1207 ,top=2662 ,right=1849 ,bottom=2704 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(제1쪽)' ,left=1691 ,top=90 ,right=1847 ,bottom=151 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1720 ,top=318 ,right=1720 ,bottom=360 </L>
	<L> left=1294 ,top=233 ,right=1831 ,bottom=233 </L>
	<T>id='여1 / 부2' ,left=1585 ,top=280 ,right=1826 ,bottom=315 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=1302 ,top=196 ,right=1513 ,bottom=228 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자1 / 비거주자2' ,left=1529 ,top=196 ,right=1826 ,bottom=228 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외국인' ,left=1302 ,top=241 ,right=1513 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=273 ,right=1831 ,bottom=273 </L>
	<T>id='외국인단일세율적용' ,left=1302 ,top=280 ,right=1572 ,bottom=315 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=318 ,right=1831 ,bottom=318 </L>
	<T>id='거주지국' ,left=1302 ,top=323 ,right=1421 ,bottom=357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=360 ,right=1831 ,bottom=360 </L>
	<T>id='내국인1 / 외국인9' ,left=1529 ,top=241 ,right=1826 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국코드' ,left=1529 ,top=323 ,right=1709 ,bottom=357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=98 ,top=1781 ,right=138 ,bottom=1820 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=98 ,top=1860 ,right=138 ,bottom=1900 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=188 ,right=1831 ,bottom=188 </L>
	<L> left=1294 ,top=188 ,right=1294 ,bottom=360 </L>
	<T>id='[별지 제24호 서식(1)]   (2008.12.12 조세특례제한법 일부 개정안 국회 본회의 의결 반영)' ,left=29 ,top=90 ,right=1437 ,bottom=151 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1852 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=614 ,right=1852 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='득' ,left=34 ,top=804 ,right=87 ,bottom=833 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=34 ,top=836 ,right=87 ,bottom=865 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=775 ,right=87 ,bottom=802 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=34 ,top=743 ,right=87 ,bottom=770 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='처' ,left=34 ,top=712 ,right=87 ,bottom=738 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='무' ,left=34 ,top=680 ,right=87 ,bottom=709 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근' ,left=34 ,top=648 ,right=87 ,bottom=677 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=870 ,right=87 ,bottom=897 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합  계' ,left=1609 ,top=622 ,right=1847 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)' ,left=1117 ,top=622 ,right=1334 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자' ,left=37 ,top=503 ,right=209 ,bottom=569 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=381 ,right=1852 ,bottom=381 </L>
	<T>id='의무자' ,left=37 ,top=445 ,right=209 ,bottom=489 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=572 ,right=1852 ,bottom=572 </L>
	<L> left=90 ,top=654 ,right=1852 ,bottom=654 </L>
	<L> left=214 ,top=421 ,right=1852 ,bottom=421 </L>
	<T>id='①법 인 명 (상 호)' ,left=220 ,top=386 ,right=508 ,bottom=418 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑧주소' ,left=220 ,top=540 ,right=508 ,bottom=569 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑥성명' ,left=220 ,top=503 ,right=508 ,bottom=532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑤소 재 지 (주소)' ,left=220 ,top=466 ,right=508 ,bottom=492 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③사업자등록번호' ,left=220 ,top=429 ,right=508 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=214 ,top=460 ,right=1852 ,bottom=460 </L>
	<L> left=214 ,top=534 ,right=1852 ,bottom=534 </L>
	<L> left=29 ,top=497 ,right=1852 ,bottom=497 </L>
	<T>id='까지' ,left=1749 ,top=579 ,right=1826 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부터' ,left=1513 ,top=579 ,right=1588 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징   수' ,left=37 ,top=392 ,right=209 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구   분' ,left=101 ,top=622 ,right=508 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)계' ,left=101 ,top=915 ,right=508 ,bottom=945 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=908 ,right=1852 ,bottom=908 </L>
	<T>id='15)-1주식매수선택권 행사이익' ,left=101 ,top=873 ,right=508 ,bottom=902 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=865 ,right=1852 ,bottom=865 </L>
	<T>id='15)인   정   상   여' ,left=101 ,top=831 ,right=508 ,bottom=860 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=823 ,right=1852 ,bottom=823 </L>
	<T>id='14)상               여' ,left=101 ,top=788 ,right=508 ,bottom=818 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=781 ,right=1852 ,bottom=781 </L>
	<T>id='13)급               여' ,left=101 ,top=746 ,right=508 ,bottom=775 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)사업자등록번호' ,left=101 ,top=704 ,right=508 ,bottom=733 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=696 ,right=1852 ,bottom=696 </L>
	<T>id='11)근   무   처   명' ,left=101 ,top=661 ,right=508 ,bottom=691 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1117, top=915, right=1334, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1614, top=915, right=1844, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=90 ,top=616 ,right=90 ,bottom=950 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1117, top=788, right=1334, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1614, top=788, right=1844, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1117, top=833, right=1334, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1614, top=833, right=1844, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1117, top=749, right=1334, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1614, top=749, right=1844, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1117, top=704, right=1334, bottom=733, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=90 ,top=741 ,right=1852 ,bottom=741 </L>
	<C>id='BCWKNM2', left=1117, top=661, right=1334, bottom=691, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HTITLE', left=630, top=299, right=1048, bottom=339, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='근로소득지급조서' ,left=598 ,top=241 ,right=1217 ,bottom=288 ,align='left' ,face='HY중고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로소득원천징수영수증' ,left=598 ,top=188 ,right=1217 ,bottom=235 ,align='left' ,face='HY중고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=278 ,border=true</X>
	<X>left=550 ,top=193 ,right=579 ,bottom=228 ,border=true</X>
	<T>id='관리' ,left=71 ,top=191 ,right=185 ,bottom=230 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=71 ,top=233 ,right=185 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=302, top=191, right=389, bottom=270, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2008 -' ,left=206 ,top=191 ,right=320 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비과세' ,left=32 ,top=960 ,right=127 ,bottom=990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3외국인근로자' ,left=1093 ,top=960 ,right=1336 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)그 밖의 비과세' ,left=1344 ,top=960 ,right=1590 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)비과세소득 계' ,left=1598 ,top=960 ,right=1842 ,bottom=992 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1045 ,right=1852 ,bottom=1045 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(PC22000,0,,PC22000)}', left=1352, top=1008, right=1585, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='17)연구활동비' ,left=138 ,top=960 ,right=331 ,bottom=987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑨귀  속  연  도' ,left=34 ,top=579 ,right=413 ,bottom=611 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1363 ,top=381 ,right=1363 ,bottom=460 </L>
	<L> left=1005 ,top=497 ,right=1005 ,bottom=534 </L>
	<L> left=1363 ,top=497 ,right=1363 ,bottom=534 </L>
	<T>id='⑦주 민  등 록  번 호' ,left=1013 ,top=503 ,right=1355 ,bottom=532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1384, top=503, right=1818, bottom=532, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='②대 표 자 (성     명)' ,left=1013 ,top=386 ,right=1355 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=569 ,top=386 ,right=860 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='101-85-10695' ,left=569 ,top=429 ,right=860 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서울시 종로구 계동 현대빌딩 140-2' ,left=569 ,top=466 ,right=1704 ,bottom=492 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDNM', left=569, top=540, right=1818, bottom=569, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='조 건 식' ,left=1384 ,top=386 ,right=1704 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1384 ,top=429 ,right=1704 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=569, top=500, right=860, bottom=534, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='까지' ,left=974 ,top=579 ,right=1040 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑩감면기간' ,left=1066 ,top=579 ,right=1312 ,bottom=609 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1323 ,top=574 ,right=1323 ,bottom=614 </L>
	<T>id='16)-1납세조합' ,left=1349 ,top=622 ,right=1580 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCWKNM3', left=1349, top=661, right=1585, bottom=691, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1349, top=704, right=1585, bottom=733, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1349, top=749, right=1585, bottom=775, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1349, top=788, right=1585, bottom=818, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1349, top=833, right=1585, bottom=860, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1349, top=915, right=1585, bottom=945, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=950 ,right=1852 ,bottom=950 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='소 득' ,left=34 ,top=1003 ,right=119 ,bottom=1042 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1087 ,top=614 ,right=1087 ,bottom=1048 </L>
	<L> left=339 ,top=950 ,right=339 ,bottom=1042 </L>
	<L> left=132 ,top=997 ,right=1852 ,bottom=997 </L>
	<C>id='{decode(PC21000+PC22000+PC23000,0,,PC21000+PC22000+PC23000)}', left=1595, top=1008, right=1855, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명' ,left=40 ,top=1572 ,right=85 ,bottom=1609 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정' ,left=40 ,top=1363 ,right=85 ,bottom=1402 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='산' ,left=40 ,top=1468 ,right=85 ,bottom=1505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합' ,left=98 ,top=1439 ,right=138 ,bottom=1479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종' ,left=98 ,top=1360 ,right=138 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=98 ,top=1519 ,right=138 ,bottom=1556 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=98 ,top=1595 ,right=138 ,bottom=1632 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)총 급 여(16)' ,left=98 ,top=1053 ,right=550 ,bottom=1085 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)근로소득공제' ,left=98 ,top=1098 ,right=550 ,bottom=1130 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='23)근로소득금액' ,left=98 ,top=1143 ,right=550 ,bottom=1175 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='31)다자녀추가공제(' ,left=153 ,top=1566 ,right=445 ,bottom=1598 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)국외근로' ,left=362 ,top=958 ,right=556 ,bottom=984 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC23000,0,,PC23000)}', left=360, top=1005, right=564, bottom=1035, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=452, top=1566, right=513, bottom=1598 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=516 ,top=1566 ,right=572 ,bottom=1598 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=40 ,top=1659 ,right=85 ,bottom=1696 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2출산보육수당' ,left=836 ,top=960 ,right=1085 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)' ,left=595 ,top=622 ,right=818 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=749, right=818, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=833, right=818, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=915, right=818, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='18)-1야간근로수당' ,left=590 ,top=960 ,right=828 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=841, top=749, right=1080, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=841, top=788, right=1080, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=841, top=833, right=1080, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=841, top=915, right=1080, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='종(전)' ,left=839 ,top=622 ,right=1080 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=191 ,top=185 ,right=191 ,bottom=273 </L>
	<L> left=214 ,top=381 ,right=214 ,bottom=572 </L>
	<L> left=442 ,top=572 ,right=442 ,bottom=611 </L>
	<T>id='세무서장  귀하' ,left=299 ,top=2582 ,right=564 ,bottom=2617 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(서명 또는 인)' ,left=1482 ,top=2551 ,right=1749 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=1169 ,top=2551 ,right=1426 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수(보고)의무자' ,left=743 ,top=2551 ,right=1095 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT2', left=738, top=2492, right=1146, bottom=2529 ,mask='XXXX년  02월  28일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=246 ,top=2328 ,right=1847 ,bottom=2328 </L>
	<L> left=90 ,top=2373 ,right=1852 ,bottom=2373 </L>
	<L> left=29 ,top=2418 ,right=1852 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=2286 ,right=1852 ,bottom=2286 </L>
	<L> left=130 ,top=953 ,right=130 ,bottom=1045 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=140 ,top=1183 ,right=140 ,bottom=2159 </L>
	<L> left=222 ,top=1606 ,right=222 ,bottom=2156 </L>
	<T>id='보험료' ,left=148 ,top=1656 ,right=220 ,bottom=1685 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=148 ,top=1701 ,right=220 ,bottom=1730 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=148 ,top=1799 ,right=220 ,bottom=1857 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=148 ,top=1863 ,right=220 ,bottom=1921 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=148 ,top=1931 ,right=220 ,bottom=1990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=148 ,top=1995 ,right=220 ,bottom=2056 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)국민연금보험료공제' ,left=225 ,top=1614 ,right=553 ,bottom=1646 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)퇴직연금소득공제' ,left=225 ,top=1709 ,right=548 ,bottom=1741 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)보   험   료' ,left=225 ,top=1754 ,right=545 ,bottom=1786 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='35)의   료   비' ,left=225 ,top=1797 ,right=545 ,bottom=1828 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)교   육   비' ,left=225 ,top=1839 ,right=545 ,bottom=1871 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)주택임차차입금원리금상환액' ,left=225 ,top=1881 ,right=566 ,bottom=1913 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='24)본         인' ,left=235 ,top=1191 ,right=519 ,bottom=1222 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)배   우   자' ,left=235 ,top=1233 ,right=529 ,bottom=1265 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)부양가족(' ,left=235 ,top=1273 ,right=421 ,bottom=1304 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)경로우대(' ,left=235 ,top=1315 ,right=421 ,bottom=1347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)장 애 인 (' ,left=235 ,top=1357 ,right=421 ,bottom=1389 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)부   녀   자' ,left=235 ,top=1400 ,right=529 ,bottom=1431 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)자녀양육비(' ,left=235 ,top=1442 ,right=450 ,bottom=1474 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=455, top=1442, right=497, bottom=1474 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=505 ,top=1442 ,right=553 ,bottom=1474 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=429, top=1360, right=489, bottom=1389 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=511 ,top=1357 ,right=566 ,bottom=1389 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=426, top=1320, right=487, bottom=1347 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=508 ,top=1315 ,right=564 ,bottom=1347 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=429, top=1273, right=492, bottom=1304 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=511 ,top=1273 ,right=566 ,bottom=1304 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1기타연금보험료공제' ,left=225 ,top=1662 ,right=558 ,bottom=1693 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=146 ,top=1617 ,right=222 ,bottom=1646 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)기부금' ,left=225 ,top=1963 ,right=545 ,bottom=1995 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)표 준 공 제' ,left=225 ,top=2127 ,right=545 ,bottom=2156 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)혼인ㆍ이사ㆍ장례비' ,left=225 ,top=2006 ,right=545 ,bottom=2037 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      계' ,left=225 ,top=2085 ,right=545 ,bottom=2117 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 정 세 액[51)-55)-63)]' ,left=995 ,top=2170 ,right=1471 ,bottom=2199 ,align='left' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='42)차 감 소 득 금 액' ,left=101 ,top=2172 ,right=582 ,bottom=2201 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구          분' ,left=101 ,top=2215 ,right=582 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)결     정     세     액' ,left=101 ,top=2254 ,right=582 ,bottom=2283 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)차  감  징  수  세  액' ,left=101 ,top=2381 ,right=582 ,bottom=2410 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기납부' ,left=98 ,top=2299 ,right=225 ,bottom=2331 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세   액' ,left=98 ,top=2331 ,right=225 ,bottom=2363 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='66)주(현)근무지' ,left=257 ,top=2339 ,right=579 ,bottom=2368 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)종(전)근무지' ,left=257 ,top=2294 ,right=579 ,bottom=2323 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC21000,0,,PC21000)}', left=598, top=1008, right=820, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB10000,0,,PB10000)}', left=598, top=1050, right=934, bottom=1087, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=598, top=1101, right=934, bottom=1130, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB30000,0,,PB30000)}', left=598, top=1146, right=934, bottom=1175, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=598, top=1188, right=934, bottom=1217, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=598, top=1233, right=934, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=598, top=1275, right=934, bottom=1304, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=598, top=1320, right=934, bottom=1347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=598, top=1357, right=934, bottom=1389, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=598, top=1402, right=934, bottom=1431, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=598, top=1445, right=934, bottom=1474, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=598, top=1566, right=934, bottom=1598, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=598, top=1614, right=934, bottom=1646, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=598, top=1759, right=934, bottom=1786, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=598, top=1799, right=934, bottom=1828, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=598, top=1842, right=934, bottom=1871, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=598, top=1966, right=934, bottom=1995, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MARSUM,0,,MARSUM)}', left=598, top=2008, right=934, bottom=2037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=598, top=2088, right=934, bottom=2117, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=598, top=2127, right=934, bottom=2156, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='농어촌특별세' ,left=1241 ,top=2215 ,right=1535 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=598 ,top=2215 ,right=934 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=598, top=2254, right=934, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB51000,0,,PB51000)}', left=598, top=2297, right=934, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=598, top=2339, right=934, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주민세' ,left=947 ,top=2215 ,right=1233 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1236 ,top=2209 ,right=1236 ,bottom=2418 </L>
	<C>id='{decode(PB71000,0,,PB71000)}', left=595, top=2384, right=931, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계' ,left=1548 ,top=2215 ,right=1842 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위의 원천징수액(근로소득)을 영수(지급)합니다.' ,left=95 ,top=2437 ,right=1511 ,bottom=2477 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1548, top=2339, right=1842, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB50000,0,,PB50000)}', left=1548, top=2297, right=1842, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1548, top=2254, right=1842, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1548, top=2384, right=1842, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1241, top=2339, right=1535, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB53000,0,,PB53000)}', left=1241, top=2297, right=1535, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1241, top=2254, right=1535, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1241, top=2384, right=1535, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=947, top=2339, right=1233, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB52000,0,,PB52000)}', left=947, top=2297, right=1233, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=947, top=2254, right=1233, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=947, top=2384, right=1233, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=222 ,top=2119 ,right=942 ,bottom=2119 </L>
	<L> left=222 ,top=2080 ,right=942 ,bottom=2080 </L>
	<L> left=222 ,top=2040 ,right=942 ,bottom=2040 </L>
	<L> left=222 ,top=2000 ,right=942 ,bottom=2000 </L>
	<L> left=222 ,top=1958 ,right=942 ,bottom=1958 </L>
	<L> left=222 ,top=1916 ,right=942 ,bottom=1916 </L>
	<L> left=222 ,top=1873 ,right=942 ,bottom=1873 </L>
	<L> left=222 ,top=1791 ,right=942 ,bottom=1791 </L>
	<L> left=222 ,top=1696 ,right=942 ,bottom=1696 </L>
	<L> left=222 ,top=1651 ,right=942 ,bottom=1651 </L>
	<L> left=222 ,top=1394 ,right=942 ,bottom=1394 </L>
	<L> left=222 ,top=1437 ,right=942 ,bottom=1437 </L>
	<L> left=222 ,top=1476 ,right=942 ,bottom=1476 </L>
	<L> left=222 ,top=1352 ,right=942 ,bottom=1352 </L>
	<L> left=222 ,top=1183 ,right=222 ,bottom=1561 </L>
	<L> left=230 ,top=2289 ,right=230 ,bottom=2371 </L>
	<T>id='기' ,left=146 ,top=1193 ,right=222 ,bottom=1220 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본' ,left=146 ,top=1220 ,right=222 ,bottom=1249 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=146 ,top=1249 ,right=222 ,bottom=1278 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=146 ,top=1278 ,right=222 ,bottom=1302 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=140 ,top=1312 ,right=945 ,bottom=1312 </L>
	<L> left=222 ,top=1225 ,right=942 ,bottom=1225 </L>
	<L> left=222 ,top=1267 ,right=942 ,bottom=1267 </L>
	<L> left=90 ,top=1090 ,right=945 ,bottom=1090 </L>
	<L> left=90 ,top=1135 ,right=945 ,bottom=1135 </L>
	<L> left=90 ,top=1180 ,right=945 ,bottom=1180 </L>
	<T>id='43)개인연금저축소득공제' ,left=1064 ,top=1056 ,right=1490 ,bottom=1087 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1553, top=1061, right=1834, bottom=1087, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)연금저축소득공제' ,left=1064 ,top=1098 ,right=1490 ,bottom=1130 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1553, top=1101, right=1834, bottom=1130, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2주택마련저축 소득공제' ,left=1064 ,top=1185 ,right=1490 ,bottom=1217 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='45)투자조합출자등소득공제' ,left=1064 ,top=1230 ,right=1490 ,bottom=1262 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='46)신용카드등소득공제' ,left=1064 ,top=1270 ,right=1490 ,bottom=1302 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='47)우리사주조합소득공제' ,left=1064 ,top=1315 ,right=1490 ,bottom=1347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)장기주식형저축 소득공제' ,left=1064 ,top=1357 ,right=1490 ,bottom=1389 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1553, top=1318, right=1834, bottom=1347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1553, top=1273, right=1834, bottom=1302, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1550, top=1233, right=1831, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1090 ,right=1849 ,bottom=1090 </L>
	<L> left=1058 ,top=1135 ,right=1849 ,bottom=1135 </L>
	<L> left=1058 ,top=1177 ,right=1849 ,bottom=1177 </L>
	<L> left=1058 ,top=1349 ,right=1849 ,bottom=1349 </L>
	<L> left=1058 ,top=1304 ,right=1849 ,bottom=1304 </L>
	<L> left=1058 ,top=1262 ,right=1849 ,bottom=1262 </L>
	<L> left=1058 ,top=1220 ,right=1849 ,bottom=1220 </L>
	<L> left=1058 ,top=1437 ,right=1849 ,bottom=1437 </L>
	<L> left=1056 ,top=1394 ,right=1847 ,bottom=1394 </L>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1550, top=1490, right=1831, bottom=1516, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)그 밖의 소득공제 계' ,left=1064 ,top=1484 ,right=1453 ,bottom=1516 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=2246 ,right=1852 ,bottom=2246 </L>
	<L> left=1852 ,top=156 ,right=1852 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1849 ,top=1519 ,right=222 ,bottom=1519 </L>
	<L> left=1056 ,top=1048 ,right=1056 ,bottom=1521 </L>
	<T>id='소득' ,left=950 ,top=1275 ,right=1048 ,bottom=1312 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그밖의' ,left=953 ,top=1230 ,right=1050 ,bottom=1267 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=953 ,top=1318 ,right=1050 ,bottom=1357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1058 ,top=1476 ,right=1849 ,bottom=1476 </L>
	<T>id='50)종합소득 과세표준' ,left=950 ,top=1524 ,right=1450 ,bottom=1556 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=140 ,top=1561 ,right=1849 ,bottom=1561 </L>
	<L> left=140 ,top=1606 ,right=1849 ,bottom=1606 </L>
	<T>id='51)산     출     세     액' ,left=950 ,top=1569 ,right=1450 ,bottom=1601 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1550, top=1527, right=1831, bottom=1553, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1550, top=1572, right=1831, bottom=1598, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1648 ,right=1849 ,bottom=1648 </L>
	<T>id='제' ,left=950 ,top=2061 ,right=1048 ,bottom=2111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=950 ,top=2003 ,right=1048 ,bottom=2053 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=950 ,top=1945 ,right=1048 ,bottom=1995 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=950 ,top=1886 ,right=1048 ,bottom=1937 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='54)' ,left=1066 ,top=1709 ,right=1455 ,bottom=1741 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1849 ,top=1831 ,right=222 ,bottom=1831 </L>
	<T>id='52)[소   득   세   법]' ,left=1066 ,top=1614 ,right=1455 ,bottom=1646 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='53)[조세특례제한법]' ,left=1066 ,top=1662 ,right=1455 ,bottom=1693 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1550, top=1617, right=1831, bottom=1646, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1550, top=1664, right=1831, bottom=1693, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1699 ,right=1849 ,bottom=1699 </L>
	<L> left=1058 ,top=1744 ,right=1849 ,bottom=1744 </L>
	<L> left=1058 ,top=1791 ,right=1849 ,bottom=1791 </L>
	<T>id='60)외  국   납  부' ,left=1066 ,top=2006 ,right=1455 ,bottom=2037 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)기부 정치자금' ,left=1066 ,top=1963 ,right=1455 ,bottom=1995 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)주 택 차 입 금' ,left=1066 ,top=1921 ,right=1455 ,bottom=1953 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)납세조합공제' ,left=1066 ,top=1881 ,right=1455 ,bottom=1913 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='56)근  로   소  득' ,left=1066 ,top=1839 ,right=1455 ,bottom=1871 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='55)세액감면 계' ,left=1066 ,top=1797 ,right=1455 ,bottom=1828 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1550, top=1802, right=1831, bottom=1828, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1550, top=1842, right=1831, bottom=1871, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1550, top=1884, right=1831, bottom=1913, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1550, top=1924, right=1831, bottom=1953, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1550, top=1966, right=1831, bottom=1995, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1550, top=2008, right=1831, bottom=2037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='세액' ,left=955 ,top=1670 ,right=1053 ,bottom=1699 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면' ,left=955 ,top=1704 ,right=1053 ,bottom=1736 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1066 ,top=2053 ,right=1455 ,bottom=2082 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='63)세 액 공 제 계' ,left=1066 ,top=2125 ,right=1455 ,bottom=2154 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='62)' ,left=1066 ,top=2088 ,right=1455 ,bottom=2117 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1550, top=2125, right=1831, bottom=2154, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1873 ,right=1849 ,bottom=1873 </L>
	<L> left=1058 ,top=1916 ,right=1849 ,bottom=1916 </L>
	<L> left=1058 ,top=1958 ,right=1849 ,bottom=1958 </L>
	<L> left=1058 ,top=2000 ,right=1849 ,bottom=2000 </L>
	<L> left=1058 ,top=2040 ,right=1849 ,bottom=2040 </L>
	<L> left=1058 ,top=2080 ,right=1849 ,bottom=2080 </L>
	<L> left=1058 ,top=2119 ,right=1849 ,bottom=2119 </L>
	<L> left=1058 ,top=1609 ,right=1058 ,bottom=2162 </L>
	<L> left=1056 ,top=572 ,right=1056 ,bottom=611 </L>
	<L> left=1540 ,top=1045 ,right=1540 ,bottom=2418 </L>
	<T>id='44)-1소기업ㆍ소상공인 공제부금 소득공제' ,left=1064 ,top=1143 ,right=1529 ,bottom=1175 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1521 ,top=188 ,right=1521 ,bottom=273 </L>
	<L> left=1831 ,top=191 ,right=1831 ,bottom=362 </L>
	<L> left=1577 ,top=275 ,right=1577 ,bottom=318 </L>
	<L> left=1426 ,top=320 ,right=1426 ,bottom=360 </L>
	<L> left=1527 ,top=318 ,right=1527 ,bottom=360 </L>
	<T>id='④주민(법인)등록번호' ,left=1013 ,top=429 ,right=1355 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1005 ,top=384 ,right=1005 ,bottom=463 </L>
	<C>id='BCWKNM1', left=841, top=664, right=1080, bottom=693, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO1', left=841, top=709, right=1080, bottom=738, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=788, right=818, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=831 ,top=614 ,right=831 ,bottom=1048 </L>
	<L> left=90 ,top=1048 ,right=90 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=537 ,top=381 ,right=537 ,bottom=574 </L>
	<T>id='30)-1출산ㆍ입양자(' ,left=233 ,top=1484 ,right=492 ,bottom=1516 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=495, top=1484, right=540, bottom=1516 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=542 ,top=1484 ,right=579 ,bottom=1516 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=143 ,top=1746 ,right=942 ,bottom=1746 </L>
	<T>id='37)-1장기주택저당차입금이자상환액' ,left=225 ,top=1924 ,right=579 ,bottom=1955 ,align='left' ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=2164 ,right=1852 ,bottom=2164 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1550, top=2170, right=1831, bottom=2199, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=587 ,top=616 ,right=587 ,bottom=2421 </L>
	<T>id='명' ,left=34 ,top=2320 ,right=87 ,bottom=2357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=34 ,top=2275 ,right=87 ,bottom=2315 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=2236 ,right=87 ,bottom=2273 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=2365 ,right=87 ,bottom=2402 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=942 ,top=1045 ,right=942 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2207 ,right=1852 ,bottom=2207 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1341 ,top=614 ,right=1341 ,bottom=1045 </L>
	<L> left=1590 ,top=614 ,right=1590 ,bottom=1045 </L>
	<X>left=1590 ,top=654 ,right=1852 ,bottom=696 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1590 ,top=696 ,right=1852 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=587 ,top=654 ,right=831 ,bottom=696 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=587 ,top=696 ,right=831 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='부터' ,left=669 ,top=579 ,right=746 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=466, top=579, right=661, bottom=606, align='right' ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CURDT', left=757, top=579, right=968, bottom=606, align='right' ,mask='XXXX/12/31', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Column', left=1344, top=579, right=1505, bottom=606, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1590, top=579, right=1744, bottom=606, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='제' ,left=146 ,top=1461 ,right=222 ,bottom=1490 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=146 ,top=1426 ,right=222 ,bottom=1458 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가' ,left=146 ,top=1394 ,right=222 ,bottom=1426 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추' ,left=146 ,top=1363 ,right=222 ,bottom=1394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=598, top=1487, right=934, bottom=1516, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=598, top=1709, right=934, bottom=1741, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=598, top=1926, right=934, bottom=1955, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=598, top=1884, right=934, bottom=1913, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1553, top=1188, right=1834, bottom=1217, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1553, top=1360, right=1834, bottom=1389, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=598, top=2172, right=934, bottom=2201, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=600 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='68)소득공제 명세(인적공제항목은 해당란에 O 표새를 하며, 각종 소득공제 항목은 공제를 위하여 실제 지출한 금액을 기입합니다)' ,left=71 ,top=87 ,right=1889 ,bottom=148 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[제2쪽]' ,left=1722 ,top=8 ,right=1879 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1902 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=161 ,right=1902 ,bottom=161 </L>
	<T>id='각종 소득공제 항목' ,left=1154 ,top=167 ,right=1897 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번' ,left=61 ,top=275 ,right=103 ,bottom=304 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호' ,left=61 ,top=307 ,right=103 ,bottom=333 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=111 ,top=167 ,right=188 ,bottom=209 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자 녀' ,left=717 ,top=262 ,right=826 ,bottom=291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=720 ,top=331 ,right=820 ,bottom=362 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='다자녀' ,left=839 ,top=265 ,right=947 ,bottom=310 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추가공제' ,left=833 ,top=310 ,right=958 ,bottom=352 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출산.' ,left=717 ,top=376 ,right=826 ,bottom=405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입양자' ,left=717 ,top=410 ,right=826 ,bottom=442 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=717 ,top=447 ,right=826 ,bottom=479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=407 ,top=508 ,right=460 ,bottom=564 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=601 ,right=1902 ,bottom=601 </L>
	<T>id='성 명' ,left=198 ,top=167 ,right=466 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=542 ,right=828 ,bottom=542 </L>
	<T>id='양육비' ,left=717 ,top=296 ,right=826 ,bottom=328 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=828 ,top=259 ,right=828 ,bottom=601 </L>
	<L> left=106 ,top=257 ,right=960 ,bottom=257 </L>
	<T>id='공제' ,left=595 ,top=429 ,right=704 ,bottom=471 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경로우대' ,left=590 ,top=384 ,right=709 ,bottom=429 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=595 ,top=318 ,right=704 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인' ,left=595 ,top=273 ,right=704 ,bottom=318 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=484 ,top=273 ,right=577 ,bottom=318 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=484 ,top=318 ,right=577 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀자' ,left=484 ,top=384 ,right=579 ,bottom=429 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=484 ,top=429 ,right=577 ,bottom=471 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=487 ,top=167 ,right=953 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=474 ,top=368 ,right=960 ,bottom=368 </L>
	<T>id='번         호' ,left=198 ,top=370 ,right=468 ,bottom=413 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주 민 등 록' ,left=198 ,top=325 ,right=468 ,bottom=370 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='코드' ,left=111 ,top=209 ,right=188 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내.외' ,left=111 ,top=325 ,right=188 ,bottom=370 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그밖의 자료' ,left=966 ,top=550 ,right=1143 ,bottom=598 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=828 ,top=368 ,right=960 ,bottom=487 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=712 ,top=259 ,right=712 ,bottom=601 </L>
	<X>left=582 ,top=487 ,right=712 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=474 ,top=542 ,right=582 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=582 ,top=542 ,right=712 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=712 ,top=542 ,right=828 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=828 ,top=542 ,right=960 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='보험료' ,left=1156 ,top=262 ,right=1262 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=1278 ,top=262 ,right=1389 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현금' ,left=1662 ,top=318 ,right=1778 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=1791 ,top=262 ,right=1897 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국인' ,left=111 ,top=370 ,right=188 ,bottom=413 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='영수증' ,left=1659 ,top=360 ,right=1783 ,bottom=394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=106 ,top=508 ,right=183 ,bottom=564 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=257 ,right=582 ,bottom=598 </L>
	<L> left=217 ,top=569 ,right=452 ,bottom=569 </L>
	<L> left=1146 ,top=257 ,right=1905 ,bottom=257 </L>
	<C>id='{decode(TCNT,0,,TCNT)}', left=251, top=503, right=386, bottom=564, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구 분' ,left=966 ,top=169 ,right=1143 ,bottom=479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=474 ,top=487 ,right=582 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=712 ,top=487 ,right=828 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='국세청자료' ,left=966 ,top=495 ,right=1143 ,bottom=540 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=542 ,right=966 ,bottom=542 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1394 ,top=259 ,right=1394 ,bottom=601 </L>
	<L> left=1654 ,top=259 ,right=1654 ,bottom=601 </L>
	<L> left=1786 ,top=259 ,right=1786 ,bottom=601 </L>
	<L> left=1270 ,top=259 ,right=1270 ,bottom=601 </L>
	<C>id='{decode(TREF11,0,,TREF11)}', left=1156, top=495, right=1270, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=1156, top=553, right=1270, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1278, top=495, right=1392, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1278, top=553, right=1392, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1659, top=553, right=1778, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1794, top=553, right=1894, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1659, top=495, right=1778, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1794, top=495, right=1894, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=828 ,top=487 ,right=960 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=474 ,top=161 ,right=474 ,bottom=601 </L>
	<L> left=191 ,top=161 ,right=191 ,bottom=601 </L>
	<L> left=106 ,top=161 ,right=106 ,bottom=601 </L>
	<L> left=1146 ,top=161 ,right=1146 ,bottom=601 </L>
	<L> left=61 ,top=487 ,right=1905 ,bottom=487 </L>
	<L> left=58 ,top=69 ,right=58 ,bottom=601 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1902 ,top=69 ,right=1902 ,bottom=601 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(제2쪽)' ,left=1662 ,top=8 ,right=1879 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=960 ,top=161 ,right=960 ,bottom=601 </L>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1400, top=495, right=1516, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1524, top=495, right=1651, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1524, top=553, right=1651, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1400, top=553, right=1516, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='신용카드' ,left=1527 ,top=299 ,right=1651 ,bottom=378 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등' ,left=1535 ,top=381 ,right=1640 ,bottom=415 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=1400 ,top=262 ,right=1511 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1519 ,top=259 ,right=1519 ,bottom=601 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=108 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=106 ,right=1902 ,bottom=106 </L>
	<T>id='그밖의 자료' ,left=966 ,top=61 ,right=1146 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청자료' ,left=966 ,top=8 ,right=1146 ,bottom=53 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1146 ,top=0 ,right=1146 ,bottom=103 </L>
	<C>id='PCNT', left=61, top=24, right=95, bottom=71, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=106 ,top=0 ,right=106 ,bottom=103 </L>
	<C>id='RELAT1', left=111, top=5, right=183, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF1,T,○,T,○,)}', left=111, top=58, right=183, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=191 ,top=0 ,right=191 ,bottom=103 </L>
	<C>id='RESINO1', left=198, top=58, right=466, bottom=103 ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=198, top=5, right=466, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=474 ,top=0 ,right=474 ,bottom=103 </L>
	<C>id='REF2', left=479, top=5, right=579, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=479, top=58, right=579, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=582 ,top=0 ,right=582 ,bottom=103 </L>
	<C>id='REF3', left=587, top=5, right=706, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5', left=587, top=58, right=706, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=712 ,top=0 ,right=712 ,bottom=103 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=103 </L>
	<L> left=960 ,top=3 ,right=960 ,bottom=106 </L>
	<C>id='', left=836, top=58, right=958, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1394 ,top=0 ,right=1394 ,bottom=103 </L>
	<L> left=482 ,top=53 ,right=960 ,bottom=53 </L>
	<L> left=106 ,top=50 ,right=474 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=958 ,top=53 ,right=1905 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1654 ,top=0 ,right=1654 ,bottom=103 </L>
	<L> left=1270 ,top=0 ,right=1270 ,bottom=103 </L>
	<L> left=1786 ,top=0 ,right=1786 ,bottom=103 </L>
	<C>id='{decode(REF11,0,,REF11)}', left=1156, top=8, right=1270, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21,0,,REF21)}', left=1156, top=61, right=1270, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1278, top=8, right=1392, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1278, top=61, right=1392, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1659, top=8, right=1778, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1659, top=61, right=1778, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1794, top=8, right=1894, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1794, top=61, right=1894, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=58 ,top=0 ,right=58 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1902 ,top=0 ,right=1902 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='REF4', left=717, top=5, right=826, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=831, top=5, right=953, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7', left=839, top=5, right=958, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8', left=717, top=58, right=826, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1524, top=8, right=1651, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1524, top=61, right=1651, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1400, top=8, right=1516, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1400, top=61, right=1516, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1519 ,top=5 ,right=1519 ,bottom=108 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=968 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='※ 작성방법' ,left=74 ,top=13 ,right=278 ,bottom=58 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 거주지국과 거주지국코드는 비거주자에 해당하는 경우에 한하여 적으며, 국제표준화기구(ISO)가 정한 ISO코드 중 국명약어 및 국가코드를 적습니다.' ,left=71 ,top=61 ,right=1889 ,bottom=101 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO국가코드 : 국세청홈페이지->국세정보->국세조세정보->국세조세자료실에서 조회 할 수 있습니다. 예) 대한민국: KR, 미국 : US' ,left=71 ,top=98 ,right=1889 ,bottom=138 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 근무처별소득명세란은 비과세소득을 제외하고 적고, 근무처별소득명세에 적힌 근무처의 비과세소득은 그 금액을 합산하여 비과세 소득란에 적습니다.' ,left=71 ,top=209 ,right=1889 ,bottom=249 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     까지 지급조서를 제출하여야 합니다.' ,left=71 ,top=172 ,right=1889 ,bottom=212 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 원천징수의무자는 지급일이 속하는 연도의 다음 연도 2월 말일(휴업 또는 폐업한 경우에는 휴업일 또는 폐업일이 속하는 달의 다음 다음 달 말일을 말합니다)' ,left=71 ,top=135 ,right=1889 ,bottom=175 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 갑종근로소득과 을종근로소득을 합산하여 연말정산하는 때에는 16)-1 납세조합란의 11)란과 13)란에 각각 을종근로소득납세조합과 을종근로소득을' ,left=71 ,top=246 ,right=1889 ,bottom=286 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=0 ,right=1902 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=966 ,right=1905 ,bottom=966 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='      적고, [소득세법 시행령] 제150조에 따른 납세조합공제금액을 57)납세조합공제란에 적습니다. 합병, 기업형태 변경 등으로 당해 법인이 연말정산을' ,left=71 ,top=283 ,right=1889 ,bottom=323 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      하는 경우에 피합병법인, 기업형태변경전의 소득은 근무처별소득명세 종(전)란에 별도로 적습니다.' ,left=71 ,top=320 ,right=1889 ,bottom=360 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3란은 외국인근로자가 [조세특례제한법] 제 18조의2제1항을 적용하는 경우에 한하여 적으며, 16)계란의 금액에 100분의 30을 곱한 금액을 적습니다.' ,left=71 ,top=357 ,right=1889 ,bottom=397 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)총급여란에는 16)계란의 금액을 적되, 18)-3란의 금액이 있는 경우에는 16)계란의 금액에서 18)-3란의 금액을 뺀 금액을 적으며, 외국인근로자가 ' ,left=71 ,top=394 ,right=1889 ,bottom=434 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [조세특례제한법] 제18조의2제2항에 따라 단일세율을 적용하는 경우에는 16)계 + 비과세소득 금액을 적고, 소득세와 관련한 비과세 .공제.감면 및 세액공제에 ' ,left=71 ,top=431 ,right=1889 ,bottom=471 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    관한 규정은 적용하지 아니합니다.' ,left=71 ,top=468 ,right=1889 ,bottom=508 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. 종합소득 특별공제[34) ~ 39)]란과 그 밖의 소득공제[43)~48)]란은 별지 제37호서식의 공제액을 적습니다.' ,left=71 ,top=505 ,right=1889 ,bottom=545 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. 67) 차감징수세액이 소액부징수(1천원 미만을 말합니다)에 해당하는 경우 세액을 0 으로 적습니다.' ,left=71 ,top=542 ,right=1889 ,bottom=582 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) 소득공제 명세란은 2006년 이후 발생하는 근로소득 연말정산분부터 사용합니다.' ,left=71 ,top=579 ,right=1889 ,bottom=619 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    가. 관계코드란 : 소득자 본인=0, 소득자의 직계존속=1, 배우자의 직계존속=2, 배우자=3, 직계비속=4, 형제자매=5, 기타=6을 적습니다(4.5.6의 경우 소득자와' ,left=71 ,top=619 ,right=1889 ,bottom=659 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           배우자의 각각의 관계를 포함합니다). ' ,left=71 ,top=656 ,right=1889 ,bottom=696 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    나. 내.외국인란 : 내국인의 경우 1 로, 외국인의 경우 9 로 적습니다.' ,left=71 ,top=693 ,right=1889 ,bottom=733 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    다. 인적공제항목란 : 인적공제사항이 있는 경우 해당란에 O 표시를 합니다(해당사항이 없을 경우 비워둡니다).' ,left=71 ,top=730 ,right=1889 ,bottom=770 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    라. 국세청 자료란 : [소득세법] 제165조에 따라 국세청 홈페이지에서 제공하는 각 소득공제 항목의 금액 중 소득공제대상이 되는 금액을  적습니다.' ,left=71 ,top=767 ,right=1889 ,bottom=807 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    마. 그 밖의 자료란 : 국세청에서 제공하는 증빙서류 외의 것을 말합니다.(예를 들면, 학원비 지로납부영수증은 신용카드 등 란에, 시력교정용 안경구입비는 ' ,left=71 ,top=804 ,right=1889 ,bottom=844 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    바. 각종 소득공제 항목란 : 소득공제항목에 해당하는 실제 지출금액을 적습니다(소득공제액이 아닌 실제 사용금액이 금액단위별로 구분된 범위 안에 적도록' ,left=71 ,top=878 ,right=1889 ,bottom=918 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         작성합니다).' ,left=71 ,top=915 ,right=1889 ,bottom=955 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        의료비란에 각각 적습니다).' ,left=71 ,top=841 ,right=1889 ,bottom=881 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
	">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 ⅠⅠⅠ : 근로소득원천징수영수증 REPORT
--------------------------------------------------------------------------------------->


<comment id="__NSID__"><object id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='5쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print'

<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2746 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=66 ,top=185 ,right=394 ,bottom=275 ,border=true</X>
	<L> left=29 ,top=2651 ,right=1852 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=159 ,right=29 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210㎜x297㎜(일반용지 54g/㎡)' ,left=1207 ,top=2662 ,right=1849 ,bottom=2704 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(제1쪽)' ,left=1691 ,top=90 ,right=1847 ,bottom=151 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1720 ,top=318 ,right=1720 ,bottom=360 </L>
	<L> left=1294 ,top=233 ,right=1831 ,bottom=233 </L>
	<T>id='여1 / 부2' ,left=1585 ,top=280 ,right=1826 ,bottom=315 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=1302 ,top=196 ,right=1513 ,bottom=228 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자1 / 비거주자2' ,left=1529 ,top=196 ,right=1826 ,bottom=228 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외국인' ,left=1302 ,top=241 ,right=1513 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=273 ,right=1831 ,bottom=273 </L>
	<T>id='외국인단일세율적용' ,left=1302 ,top=280 ,right=1572 ,bottom=315 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=318 ,right=1831 ,bottom=318 </L>
	<T>id='거주지국' ,left=1302 ,top=323 ,right=1421 ,bottom=357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=360 ,right=1831 ,bottom=360 </L>
	<T>id='내국인1 / 외국인9' ,left=1529 ,top=241 ,right=1826 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국코드' ,left=1529 ,top=323 ,right=1709 ,bottom=357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=98 ,top=1781 ,right=138 ,bottom=1820 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=98 ,top=1860 ,right=138 ,bottom=1900 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1294 ,top=188 ,right=1831 ,bottom=188 </L>
	<L> left=1294 ,top=188 ,right=1294 ,bottom=360 </L>
	<T>id='[별지 제24호 서식(1)]   (2008.12.12 조세특례제한법 일부 개정안 국회 본회의 의결 반영)' ,left=29 ,top=90 ,right=1437 ,bottom=151 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=1852 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=614 ,right=1852 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='득' ,left=34 ,top=804 ,right=87 ,bottom=833 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=34 ,top=836 ,right=87 ,bottom=865 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=775 ,right=87 ,bottom=802 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=34 ,top=743 ,right=87 ,bottom=770 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='처' ,left=34 ,top=712 ,right=87 ,bottom=738 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='무' ,left=34 ,top=680 ,right=87 ,bottom=709 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근' ,left=34 ,top=648 ,right=87 ,bottom=677 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=870 ,right=87 ,bottom=897 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합  계' ,left=1609 ,top=622 ,right=1847 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)' ,left=1117 ,top=622 ,right=1334 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자' ,left=37 ,top=503 ,right=209 ,bottom=569 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=381 ,right=1852 ,bottom=381 </L>
	<T>id='의무자' ,left=37 ,top=445 ,right=209 ,bottom=489 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=572 ,right=1852 ,bottom=572 </L>
	<L> left=90 ,top=654 ,right=1852 ,bottom=654 </L>
	<L> left=214 ,top=421 ,right=1852 ,bottom=421 </L>
	<T>id='①법 인 명 (상 호)' ,left=220 ,top=386 ,right=508 ,bottom=418 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑧주소' ,left=220 ,top=540 ,right=508 ,bottom=569 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑥성명' ,left=220 ,top=503 ,right=508 ,bottom=532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑤소 재 지 (주소)' ,left=220 ,top=466 ,right=508 ,bottom=492 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③사업자등록번호' ,left=220 ,top=429 ,right=508 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=214 ,top=460 ,right=1852 ,bottom=460 </L>
	<L> left=214 ,top=534 ,right=1852 ,bottom=534 </L>
	<L> left=29 ,top=497 ,right=1852 ,bottom=497 </L>
	<T>id='까지' ,left=1749 ,top=579 ,right=1826 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부터' ,left=1513 ,top=579 ,right=1588 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징   수' ,left=37 ,top=392 ,right=209 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구   분' ,left=101 ,top=622 ,right=508 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)계' ,left=101 ,top=915 ,right=508 ,bottom=945 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=908 ,right=1852 ,bottom=908 </L>
	<T>id='15)-1주식매수선택권 행사이익' ,left=101 ,top=873 ,right=508 ,bottom=902 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=865 ,right=1852 ,bottom=865 </L>
	<T>id='15)인   정   상   여' ,left=101 ,top=831 ,right=508 ,bottom=860 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=823 ,right=1852 ,bottom=823 </L>
	<T>id='14)상               여' ,left=101 ,top=788 ,right=508 ,bottom=818 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=781 ,right=1852 ,bottom=781 </L>
	<T>id='13)급               여' ,left=101 ,top=746 ,right=508 ,bottom=775 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)사업자등록번호' ,left=101 ,top=704 ,right=508 ,bottom=733 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=696 ,right=1852 ,bottom=696 </L>
	<T>id='11)근   무   처   명' ,left=101 ,top=661 ,right=508 ,bottom=691 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC20000,0,,BC20000)}', left=1117, top=915, right=1334, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TWKSUM,0,,TWKSUM)}', left=1614, top=915, right=1844, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=90 ,top=616 ,right=90 ,bottom=950 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(BC22000,0,,BC22000)}', left=1117, top=788, right=1334, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC2000,0,,PBC2000)}', left=1614, top=788, right=1844, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC23000,0,,BC23000)}', left=1117, top=833, right=1334, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC3000,0,,PBC3000)}', left=1614, top=833, right=1844, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC21000,0,,BC21000)}', left=1117, top=749, right=1334, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PBC1000,0,,PBC1000)}', left=1614, top=749, right=1844, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1117, top=704, right=1334, bottom=733, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=90 ,top=741 ,right=1852 ,bottom=741 </L>
	<C>id='BCWKNM2', left=1117, top=661, right=1334, bottom=691, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HTITLE', left=630, top=299, right=1048, bottom=339, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='근로소득지급조서' ,left=598 ,top=241 ,right=1217 ,bottom=288 ,align='left' ,face='HY중고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로소득원천징수영수증' ,left=598 ,top=188 ,right=1217 ,bottom=235 ,align='left' ,face='HY중고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=550 ,top=243 ,right=579 ,bottom=278 ,border=true</X>
	<X>left=550 ,top=193 ,right=579 ,bottom=228 ,border=true</X>
	<T>id='관리' ,left=71 ,top=191 ,right=185 ,bottom=230 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=71 ,top=233 ,right=185 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCNT', left=302, top=191, right=389, bottom=270, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2008 -' ,left=206 ,top=191 ,right=320 ,bottom=270 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비과세' ,left=32 ,top=960 ,right=127 ,bottom=990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-3외국인근로자' ,left=1093 ,top=960 ,right=1336 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)그 밖의 비과세' ,left=1344 ,top=960 ,right=1590 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20)비과세소득 계' ,left=1598 ,top=960 ,right=1842 ,bottom=992 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1045 ,right=1852 ,bottom=1045 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(PC22000,0,,PC22000)}', left=1352, top=1008, right=1585, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='17)연구활동비' ,left=138 ,top=960 ,right=331 ,bottom=987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑨귀  속  연  도' ,left=34 ,top=579 ,right=413 ,bottom=611 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1363 ,top=381 ,right=1363 ,bottom=460 </L>
	<L> left=1005 ,top=497 ,right=1005 ,bottom=534 </L>
	<L> left=1363 ,top=497 ,right=1363 ,bottom=534 </L>
	<T>id='⑦주 민  등 록  번 호' ,left=1013 ,top=503 ,right=1355 ,bottom=532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1384, top=503, right=1818, bottom=532, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='②대 표 자 (성     명)' ,left=1013 ,top=386 ,right=1355 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=569 ,top=386 ,right=860 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='101-85-10695' ,left=569 ,top=429 ,right=860 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서울시 종로구 계동 현대빌딩 140-2' ,left=569 ,top=466 ,right=1704 ,bottom=492 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDNM', left=569, top=540, right=1818, bottom=569, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='조 건 식' ,left=1384 ,top=386 ,right=1704 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1384 ,top=429 ,right=1704 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=569, top=500, right=860, bottom=534, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='까지' ,left=974 ,top=579 ,right=1040 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑩감면기간' ,left=1066 ,top=579 ,right=1312 ,bottom=609 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1323 ,top=574 ,right=1323 ,bottom=614 </L>
	<T>id='16)-1납세조합' ,left=1349 ,top=622 ,right=1580 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BCWKNM3', left=1349, top=661, right=1585, bottom=691, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO3', left=1349, top=704, right=1585, bottom=733, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC31000,0,,BC31000)}', left=1349, top=749, right=1585, bottom=775, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC32000,0,,BC32000)}', left=1349, top=788, right=1585, bottom=818, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC33000,0,,BC33000)}', left=1349, top=833, right=1585, bottom=860, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC3000,0,,BC3000)}', left=1349, top=915, right=1585, bottom=945, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=950 ,right=1852 ,bottom=950 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='소 득' ,left=34 ,top=1003 ,right=119 ,bottom=1042 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1087 ,top=614 ,right=1087 ,bottom=1048 </L>
	<L> left=339 ,top=950 ,right=339 ,bottom=1042 </L>
	<L> left=132 ,top=997 ,right=1852 ,bottom=997 </L>
	<C>id='{decode(PC21000+PC22000+PC23000,0,,PC21000+PC22000+PC23000)}', left=1595, top=1008, right=1855, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명' ,left=40 ,top=1572 ,right=85 ,bottom=1609 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정' ,left=40 ,top=1363 ,right=85 ,bottom=1402 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='산' ,left=40 ,top=1468 ,right=85 ,bottom=1505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합' ,left=98 ,top=1439 ,right=138 ,bottom=1479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종' ,left=98 ,top=1360 ,right=138 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=98 ,top=1519 ,right=138 ,bottom=1556 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=98 ,top=1595 ,right=138 ,bottom=1632 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)총 급 여(16)' ,left=98 ,top=1053 ,right=550 ,bottom=1085 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22)근로소득공제' ,left=98 ,top=1098 ,right=550 ,bottom=1130 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='23)근로소득금액' ,left=98 ,top=1143 ,right=550 ,bottom=1175 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='31)다자녀추가공제(' ,left=153 ,top=1566 ,right=445 ,bottom=1598 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)국외근로' ,left=362 ,top=958 ,right=556 ,bottom=984 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC23000,0,,PC23000)}', left=360, top=1005, right=564, bottom=1035, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AD0106CNT,0,,AD0106CNT)}', left=452, top=1566, right=513, bottom=1598 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=516 ,top=1566 ,right=572 ,bottom=1598 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=40 ,top=1659 ,right=85 ,bottom=1696 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)-2출산보육수당' ,left=836 ,top=960 ,right=1085 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)' ,left=595 ,top=622 ,right=818 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC11000,0,,PC11000)}', left=595, top=749, right=818, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC13000,0,,PC13000)}', left=595, top=833, right=818, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC10000,0,,PC10000)}', left=595, top=915, right=818, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='18)-1야간근로수당' ,left=590 ,top=960 ,right=828 ,bottom=990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BC11000,0,,BC11000)}', left=841, top=749, right=1080, bottom=775, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC12000,0,,BC12000)}', left=841, top=788, right=1080, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC13000,0,,BC13000)}', left=841, top=833, right=1080, bottom=860, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BC10000,0,,BC10000)}', left=841, top=915, right=1080, bottom=945, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='종(전)' ,left=839 ,top=622 ,right=1080 ,bottom=651 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=191 ,top=185 ,right=191 ,bottom=273 </L>
	<L> left=214 ,top=381 ,right=214 ,bottom=572 </L>
	<L> left=442 ,top=572 ,right=442 ,bottom=611 </L>
	<T>id='세무서장  귀하' ,left=299 ,top=2582 ,right=564 ,bottom=2617 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(서명 또는 인)' ,left=1482 ,top=2551 ,right=1749 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=1169 ,top=2551 ,right=1426 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수(보고)의무자' ,left=743 ,top=2551 ,right=1095 ,bottom=2585 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT2', left=738, top=2492, right=1146, bottom=2529 ,mask='XXXX년  02월  28일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=246 ,top=2328 ,right=1847 ,bottom=2328 </L>
	<L> left=90 ,top=2373 ,right=1852 ,bottom=2373 </L>
	<L> left=29 ,top=2418 ,right=1852 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=90 ,top=2286 ,right=1852 ,bottom=2286 </L>
	<L> left=130 ,top=953 ,right=130 ,bottom=1045 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=140 ,top=1183 ,right=140 ,bottom=2159 </L>
	<L> left=222 ,top=1606 ,right=222 ,bottom=2156 </L>
	<T>id='보험료' ,left=148 ,top=1656 ,right=220 ,bottom=1685 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=148 ,top=1701 ,right=220 ,bottom=1730 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=148 ,top=1799 ,right=220 ,bottom=1857 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=148 ,top=1863 ,right=220 ,bottom=1921 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=148 ,top=1931 ,right=220 ,bottom=1990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=148 ,top=1995 ,right=220 ,bottom=2056 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)국민연금보험료공제' ,left=225 ,top=1614 ,right=553 ,bottom=1646 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)퇴직연금소득공제' ,left=225 ,top=1709 ,right=548 ,bottom=1741 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)보   험   료' ,left=225 ,top=1754 ,right=545 ,bottom=1786 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='35)의   료   비' ,left=225 ,top=1797 ,right=545 ,bottom=1828 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)교   육   비' ,left=225 ,top=1839 ,right=545 ,bottom=1871 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)주택임차차입금원리금상환액' ,left=225 ,top=1881 ,right=566 ,bottom=1913 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='24)본         인' ,left=235 ,top=1191 ,right=519 ,bottom=1222 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)배   우   자' ,left=235 ,top=1233 ,right=529 ,bottom=1265 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)부양가족(' ,left=235 ,top=1273 ,right=421 ,bottom=1304 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)경로우대(' ,left=235 ,top=1315 ,right=421 ,bottom=1347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)장 애 인 (' ,left=235 ,top=1357 ,right=421 ,bottom=1389 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)부   녀   자' ,left=235 ,top=1400 ,right=529 ,bottom=1431 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30)자녀양육비(' ,left=235 ,top=1442 ,right=450 ,bottom=1474 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0105CNT,0,,AD0105CNT)}', left=455, top=1442, right=497, bottom=1474 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=505 ,top=1442 ,right=553 ,bottom=1474 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0103CNT,0,,AD0103CNT)}', left=429, top=1360, right=489, bottom=1389 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=511 ,top=1357 ,right=566 ,bottom=1389 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TOTCNT02,0,,TOTCNT02)}', left=426, top=1320, right=487, bottom=1347 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=508 ,top=1315 ,right=564 ,bottom=1347 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BA0101CNT,0,,BA0101CNT)}', left=429, top=1273, right=492, bottom=1304 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=511 ,top=1273 ,right=566 ,bottom=1304 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)-1기타연금보험료공제' ,left=225 ,top=1662 ,right=558 ,bottom=1693 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=146 ,top=1617 ,right=222 ,bottom=1646 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)기부금' ,left=225 ,top=1963 ,right=545 ,bottom=1995 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)표 준 공 제' ,left=225 ,top=2127 ,right=545 ,bottom=2156 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)혼인ㆍ이사ㆍ장례비' ,left=225 ,top=2006 ,right=545 ,bottom=2037 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)      계' ,left=225 ,top=2085 ,right=545 ,bottom=2117 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 정 세 액[51)-55)-63)]' ,left=995 ,top=2170 ,right=1471 ,bottom=2199 ,align='left' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='42)차 감 소 득 금 액' ,left=101 ,top=2172 ,right=582 ,bottom=2201 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구          분' ,left=101 ,top=2215 ,right=582 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)결     정     세     액' ,left=101 ,top=2254 ,right=582 ,bottom=2283 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='67)차  감  징  수  세  액' ,left=101 ,top=2381 ,right=582 ,bottom=2410 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기납부' ,left=98 ,top=2299 ,right=225 ,bottom=2331 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세   액' ,left=98 ,top=2331 ,right=225 ,bottom=2363 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='66)주(현)근무지' ,left=257 ,top=2339 ,right=579 ,bottom=2368 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)종(전)근무지' ,left=257 ,top=2294 ,right=579 ,bottom=2323 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PC21000,0,,PC21000)}', left=598, top=1008, right=820, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB10000,0,,PB10000)}', left=598, top=1050, right=934, bottom=1087, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB20000,0,,PB20000)}', left=598, top=1101, right=934, bottom=1130, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB30000,0,,PB30000)}', left=598, top=1146, right=934, bottom=1175, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT01,0,,BAAMT01)}', left=598, top=1188, right=934, bottom=1217, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT02,0,,BAAMT02)}', left=598, top=1233, right=934, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BAAMT03,0,,BAAMT03)}', left=598, top=1275, right=934, bottom=1304, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT01,0,,ADAMT01)}', left=598, top=1320, right=934, bottom=1347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT02,0,,ADAMT02)}', left=598, top=1357, right=934, bottom=1389, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT03,0,,ADAMT03)}', left=598, top=1402, right=934, bottom=1431, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT04,0,,ADAMT04)}', left=598, top=1445, right=934, bottom=1474, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ADAMT05S,0,,ADAMT05S)}', left=598, top=1566, right=934, bottom=1598, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUMS,0,,PENSUMS)}', left=598, top=1614, right=934, bottom=1646, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=598, top=1759, right=934, bottom=1786, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=598, top=1799, right=934, bottom=1828, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=598, top=1842, right=934, bottom=1871, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONSUM,0,,CONSUM)}', left=598, top=1966, right=934, bottom=1995, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MARSUM,0,,MARSUM)}', left=598, top=2008, right=934, bottom=2037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPCSUM,0,,SPCSUM)}', left=598, top=2088, right=934, bottom=2117, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDSUM,0,,STDSUM)}', left=598, top=2127, right=934, bottom=2156, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='농어촌특별세' ,left=1241 ,top=2215 ,right=1535 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=598 ,top=2215 ,right=934 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB41000,0,,PB41000)}', left=598, top=2254, right=934, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB51000,0,,PB51000)}', left=598, top=2297, right=934, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB61000,0,,PB61000)}', left=598, top=2339, right=934, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주민세' ,left=947 ,top=2215 ,right=1233 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1236 ,top=2209 ,right=1236 ,bottom=2418 </L>
	<C>id='{decode(PB71000,0,,PB71000)}', left=595, top=2384, right=931, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계' ,left=1548 ,top=2215 ,right=1842 ,bottom=2244 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위의 원천징수액(근로소득)을 영수(지급)합니다.' ,left=95 ,top=2437 ,right=1511 ,bottom=2477 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PB60000,0,,PB60000)}', left=1548, top=2339, right=1842, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB50000,0,,PB50000)}', left=1548, top=2297, right=1842, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB40000,0,,PB40000)}', left=1548, top=2254, right=1842, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB70000,0,,PB70000)}', left=1548, top=2384, right=1842, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB63000,0,,PB63000)}', left=1241, top=2339, right=1535, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB53000,0,,PB53000)}', left=1241, top=2297, right=1535, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB43000,0,,PB43000)}', left=1241, top=2254, right=1535, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB73000,0,,PB73000)}', left=1241, top=2384, right=1535, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB62000,0,,PB62000)}', left=947, top=2339, right=1233, bottom=2368, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB52000,0,,PB52000)}', left=947, top=2297, right=1233, bottom=2326, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB42000,0,,PB42000)}', left=947, top=2254, right=1233, bottom=2283, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PB72000,0,,PB72000)}', left=947, top=2384, right=1233, bottom=2413, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=222 ,top=2119 ,right=942 ,bottom=2119 </L>
	<L> left=222 ,top=2080 ,right=942 ,bottom=2080 </L>
	<L> left=222 ,top=2040 ,right=942 ,bottom=2040 </L>
	<L> left=222 ,top=2000 ,right=942 ,bottom=2000 </L>
	<L> left=222 ,top=1958 ,right=942 ,bottom=1958 </L>
	<L> left=222 ,top=1916 ,right=942 ,bottom=1916 </L>
	<L> left=222 ,top=1873 ,right=942 ,bottom=1873 </L>
	<L> left=222 ,top=1791 ,right=942 ,bottom=1791 </L>
	<L> left=222 ,top=1696 ,right=942 ,bottom=1696 </L>
	<L> left=222 ,top=1651 ,right=942 ,bottom=1651 </L>
	<L> left=222 ,top=1394 ,right=942 ,bottom=1394 </L>
	<L> left=222 ,top=1437 ,right=942 ,bottom=1437 </L>
	<L> left=222 ,top=1476 ,right=942 ,bottom=1476 </L>
	<L> left=222 ,top=1352 ,right=942 ,bottom=1352 </L>
	<L> left=222 ,top=1183 ,right=222 ,bottom=1561 </L>
	<L> left=230 ,top=2289 ,right=230 ,bottom=2371 </L>
	<T>id='기' ,left=146 ,top=1193 ,right=222 ,bottom=1220 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본' ,left=146 ,top=1220 ,right=222 ,bottom=1249 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=146 ,top=1249 ,right=222 ,bottom=1278 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=146 ,top=1278 ,right=222 ,bottom=1302 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=140 ,top=1312 ,right=945 ,bottom=1312 </L>
	<L> left=222 ,top=1225 ,right=942 ,bottom=1225 </L>
	<L> left=222 ,top=1267 ,right=942 ,bottom=1267 </L>
	<L> left=90 ,top=1090 ,right=945 ,bottom=1090 </L>
	<L> left=90 ,top=1135 ,right=945 ,bottom=1135 </L>
	<L> left=90 ,top=1180 ,right=945 ,bottom=1180 </L>
	<T>id='43)개인연금저축소득공제' ,left=1064 ,top=1056 ,right=1490 ,bottom=1087 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT011S,0,,ETCAMT011S)}', left=1553, top=1061, right=1834, bottom=1087, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)연금저축소득공제' ,left=1064 ,top=1098 ,right=1490 ,bottom=1130 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT01S,0,,ETCAMT01S)}', left=1553, top=1101, right=1834, bottom=1130, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='44)-2주택마련저축 소득공제' ,left=1064 ,top=1185 ,right=1490 ,bottom=1217 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='45)투자조합출자등소득공제' ,left=1064 ,top=1230 ,right=1490 ,bottom=1262 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='46)신용카드등소득공제' ,left=1064 ,top=1270 ,right=1490 ,bottom=1302 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='47)우리사주조합소득공제' ,left=1064 ,top=1315 ,right=1490 ,bottom=1347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)장기주식형저축 소득공제' ,left=1064 ,top=1357 ,right=1490 ,bottom=1389 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ETCAMT04S,0,,ETCAMT04S)}', left=1553, top=1318, right=1834, bottom=1347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT03S,0,,ETCAMT03S)}', left=1553, top=1273, right=1834, bottom=1302, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT02S,0,,ETCAMT02S)}', left=1550, top=1233, right=1831, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1090 ,right=1849 ,bottom=1090 </L>
	<L> left=1058 ,top=1135 ,right=1849 ,bottom=1135 </L>
	<L> left=1058 ,top=1177 ,right=1849 ,bottom=1177 </L>
	<L> left=1058 ,top=1349 ,right=1849 ,bottom=1349 </L>
	<L> left=1058 ,top=1304 ,right=1849 ,bottom=1304 </L>
	<L> left=1058 ,top=1262 ,right=1849 ,bottom=1262 </L>
	<L> left=1058 ,top=1220 ,right=1849 ,bottom=1220 </L>
	<L> left=1058 ,top=1437 ,right=1849 ,bottom=1437 </L>
	<L> left=1056 ,top=1394 ,right=1847 ,bottom=1394 </L>
	<C>id='{decode(ETCSUM,0,,ETCSUM)}', left=1550, top=1490, right=1831, bottom=1516, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='49)그 밖의 소득공제 계' ,left=1064 ,top=1484 ,right=1453 ,bottom=1516 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=2246 ,right=1852 ,bottom=2246 </L>
	<L> left=1852 ,top=156 ,right=1852 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1849 ,top=1519 ,right=222 ,bottom=1519 </L>
	<L> left=1056 ,top=1048 ,right=1056 ,bottom=1521 </L>
	<T>id='소득' ,left=950 ,top=1275 ,right=1048 ,bottom=1312 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그밖의' ,left=953 ,top=1230 ,right=1050 ,bottom=1267 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=953 ,top=1318 ,right=1050 ,bottom=1357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1058 ,top=1476 ,right=1849 ,bottom=1476 </L>
	<T>id='50)종합소득 과세표준' ,left=950 ,top=1524 ,right=1450 ,bottom=1556 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=140 ,top=1561 ,right=1849 ,bottom=1561 </L>
	<L> left=140 ,top=1606 ,right=1849 ,bottom=1606 </L>
	<T>id='51)산     출     세     액' ,left=950 ,top=1569 ,right=1450 ,bottom=1601 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TSTDSUM,0,,TSTDSUM)}', left=1550, top=1527, right=1831, bottom=1553, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STDTAX,0,,STDTAX)}', left=1550, top=1572, right=1831, bottom=1598, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1648 ,right=1849 ,bottom=1648 </L>
	<T>id='제' ,left=950 ,top=2061 ,right=1048 ,bottom=2111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=950 ,top=2003 ,right=1048 ,bottom=2053 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=950 ,top=1945 ,right=1048 ,bottom=1995 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=950 ,top=1886 ,right=1048 ,bottom=1937 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='54)' ,left=1066 ,top=1709 ,right=1455 ,bottom=1741 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1849 ,top=1831 ,right=222 ,bottom=1831 </L>
	<T>id='52)[소   득   세   법]' ,left=1066 ,top=1614 ,right=1455 ,bottom=1646 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='53)[조세특례제한법]' ,left=1066 ,top=1662 ,right=1455 ,bottom=1693 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDAMT01S,0,,REDAMT01S)}', left=1550, top=1617, right=1831, bottom=1646, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REDAMT02S,0,,REDAMT02S)}', left=1550, top=1664, right=1831, bottom=1693, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1699 ,right=1849 ,bottom=1699 </L>
	<L> left=1058 ,top=1744 ,right=1849 ,bottom=1744 </L>
	<L> left=1058 ,top=1791 ,right=1849 ,bottom=1791 </L>
	<T>id='60)외  국   납  부' ,left=1066 ,top=2006 ,right=1455 ,bottom=2037 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)기부 정치자금' ,left=1066 ,top=1963 ,right=1455 ,bottom=1995 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)주 택 차 입 금' ,left=1066 ,top=1921 ,right=1455 ,bottom=1953 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)납세조합공제' ,left=1066 ,top=1881 ,right=1455 ,bottom=1913 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='56)근  로   소  득' ,left=1066 ,top=1839 ,right=1455 ,bottom=1871 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='55)세액감면 계' ,left=1066 ,top=1797 ,right=1455 ,bottom=1828 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REDSUM,0,,REDSUM)}', left=1550, top=1802, right=1831, bottom=1828, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT01S,0,,DEDAMT01S)}', left=1550, top=1842, right=1831, bottom=1871, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT02S,0,,DEDAMT02S)}', left=1550, top=1884, right=1831, bottom=1913, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT03S,0,,DEDAMT03S)}', left=1550, top=1924, right=1831, bottom=1953, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT04S,0,,DEDAMT04S)}', left=1550, top=1966, right=1831, bottom=1995, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DEDAMT05S,0,,DEDAMT05S)}', left=1550, top=2008, right=1831, bottom=2037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='세액' ,left=955 ,top=1670 ,right=1053 ,bottom=1699 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면' ,left=955 ,top=1704 ,right=1053 ,bottom=1736 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1066 ,top=2053 ,right=1455 ,bottom=2082 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='63)세 액 공 제 계' ,left=1066 ,top=2125 ,right=1455 ,bottom=2154 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='62)' ,left=1066 ,top=2088 ,right=1455 ,bottom=2117 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDSUM,0,,DEDSUM)}', left=1550, top=2125, right=1831, bottom=2154, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=1873 ,right=1849 ,bottom=1873 </L>
	<L> left=1058 ,top=1916 ,right=1849 ,bottom=1916 </L>
	<L> left=1058 ,top=1958 ,right=1849 ,bottom=1958 </L>
	<L> left=1058 ,top=2000 ,right=1849 ,bottom=2000 </L>
	<L> left=1058 ,top=2040 ,right=1849 ,bottom=2040 </L>
	<L> left=1058 ,top=2080 ,right=1849 ,bottom=2080 </L>
	<L> left=1058 ,top=2119 ,right=1849 ,bottom=2119 </L>
	<L> left=1058 ,top=1609 ,right=1058 ,bottom=2162 </L>
	<L> left=1056 ,top=572 ,right=1056 ,bottom=611 </L>
	<L> left=1540 ,top=1045 ,right=1540 ,bottom=2418 </L>
	<T>id='44)-1소기업ㆍ소상공인 공제부금 소득공제' ,left=1064 ,top=1143 ,right=1529 ,bottom=1175 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1521 ,top=188 ,right=1521 ,bottom=273 </L>
	<L> left=1831 ,top=191 ,right=1831 ,bottom=362 </L>
	<L> left=1577 ,top=275 ,right=1577 ,bottom=318 </L>
	<L> left=1426 ,top=320 ,right=1426 ,bottom=360 </L>
	<L> left=1527 ,top=318 ,right=1527 ,bottom=360 </L>
	<T>id='④주민(법인)등록번호' ,left=1013 ,top=429 ,right=1355 ,bottom=455 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1005 ,top=384 ,right=1005 ,bottom=463 </L>
	<C>id='BCWKNM1', left=841, top=664, right=1080, bottom=693, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO1', left=841, top=709, right=1080, bottom=738, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PC12000,0,,PC12000)}', left=595, top=788, right=818, bottom=818, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=831 ,top=614 ,right=831 ,bottom=1048 </L>
	<L> left=90 ,top=1048 ,right=90 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=537 ,top=381 ,right=537 ,bottom=574 </L>
	<T>id='30)-1출산ㆍ입양자(' ,left=233 ,top=1484 ,right=492 ,bottom=1516 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(AD0107CNT,0,,AD0107CNT)}', left=495, top=1484, right=540, bottom=1516 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='명)' ,left=542 ,top=1484 ,right=579 ,bottom=1516 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=143 ,top=1746 ,right=942 ,bottom=1746 </L>
	<T>id='37)-1장기주택저당차입금이자상환액' ,left=225 ,top=1924 ,right=579 ,bottom=1955 ,align='left' ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=90 ,top=2164 ,right=1852 ,bottom=2164 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(RESSUM,0,,RESSUM)}', left=1550, top=2170, right=1831, bottom=2199, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=587 ,top=616 ,right=587 ,bottom=2421 </L>
	<T>id='명' ,left=34 ,top=2320 ,right=87 ,bottom=2357 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=34 ,top=2275 ,right=87 ,bottom=2315 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=2236 ,right=87 ,bottom=2273 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=2365 ,right=87 ,bottom=2402 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=942 ,top=1045 ,right=942 ,bottom=2418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2207 ,right=1852 ,bottom=2207 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1341 ,top=614 ,right=1341 ,bottom=1045 </L>
	<L> left=1590 ,top=614 ,right=1590 ,bottom=1045 </L>
	<X>left=1590 ,top=654 ,right=1852 ,bottom=696 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1590 ,top=696 ,right=1852 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=587 ,top=654 ,right=831 ,bottom=696 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=587 ,top=696 ,right=831 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='부터' ,left=669 ,top=579 ,right=746 ,bottom=606 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT3', left=466, top=579, right=661, bottom=606, align='right' ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CURDT', left=757, top=579, right=968, bottom=606, align='right' ,mask='XXXX/12/31', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Column', left=1344, top=579, right=1505, bottom=606, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1590, top=579, right=1744, bottom=606, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='제' ,left=146 ,top=1461 ,right=222 ,bottom=1490 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=146 ,top=1426 ,right=222 ,bottom=1458 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가' ,left=146 ,top=1394 ,right=222 ,bottom=1426 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추' ,left=146 ,top=1363 ,right=222 ,bottom=1394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(ADAMT07,0,,ADAMT07)}', left=598, top=1487, right=934, bottom=1516, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETCAMT05,0,,ETCAMT05)}', left=598, top=1709, right=934, bottom=1741, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT34S,0,,HOUAMT34S)}', left=598, top=1926, right=934, bottom=1955, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02S,0,,HOUAMT02S)}', left=598, top=1884, right=934, bottom=1913, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT01S,0,,HOUAMT01S)}', left=1553, top=1188, right=1834, bottom=1217, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDSUMS,0,,FNDSUMS)}', left=1553, top=1360, right=1834, bottom=1389, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OFFSUM,0,,OFFSUM)}', left=598, top=2172, right=934, bottom=2201, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='6쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print1'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=600 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='68)소득공제 명세(인적공제항목은 해당란에 O 표새를 하며, 각종 소득공제 항목은 공제를 위하여 실제 지출한 금액을 기입합니다)' ,left=71 ,top=87 ,right=1889 ,bottom=148 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[제2쪽]' ,left=1722 ,top=8 ,right=1879 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=69 ,right=1902 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=161 ,right=1902 ,bottom=161 </L>
	<T>id='각종 소득공제 항목' ,left=1154 ,top=167 ,right=1897 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번' ,left=61 ,top=275 ,right=103 ,bottom=304 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호' ,left=61 ,top=307 ,right=103 ,bottom=333 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=111 ,top=167 ,right=188 ,bottom=209 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자 녀' ,left=717 ,top=262 ,right=826 ,bottom=291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=720 ,top=331 ,right=820 ,bottom=362 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='다자녀' ,left=839 ,top=265 ,right=947 ,bottom=310 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추가공제' ,left=833 ,top=310 ,right=958 ,bottom=352 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출산.' ,left=717 ,top=376 ,right=826 ,bottom=405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입양자' ,left=717 ,top=410 ,right=826 ,bottom=442 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=717 ,top=447 ,right=826 ,bottom=479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=407 ,top=508 ,right=460 ,bottom=564 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=58 ,top=601 ,right=1902 ,bottom=601 </L>
	<T>id='성 명' ,left=198 ,top=167 ,right=466 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=542 ,right=828 ,bottom=542 </L>
	<T>id='양육비' ,left=717 ,top=296 ,right=826 ,bottom=328 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=828 ,top=259 ,right=828 ,bottom=601 </L>
	<L> left=106 ,top=257 ,right=960 ,bottom=257 </L>
	<T>id='공제' ,left=595 ,top=429 ,right=704 ,bottom=471 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경로우대' ,left=590 ,top=384 ,right=709 ,bottom=429 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=595 ,top=318 ,right=704 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인' ,left=595 ,top=273 ,right=704 ,bottom=318 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=484 ,top=273 ,right=577 ,bottom=318 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=484 ,top=318 ,right=577 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀자' ,left=484 ,top=384 ,right=579 ,bottom=429 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=484 ,top=429 ,right=577 ,bottom=471 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=487 ,top=167 ,right=953 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=474 ,top=368 ,right=960 ,bottom=368 </L>
	<T>id='번         호' ,left=198 ,top=370 ,right=468 ,bottom=413 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주 민 등 록' ,left=198 ,top=325 ,right=468 ,bottom=370 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='코드' ,left=111 ,top=209 ,right=188 ,bottom=254 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내.외' ,left=111 ,top=325 ,right=188 ,bottom=370 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그밖의 자료' ,left=966 ,top=550 ,right=1143 ,bottom=598 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=828 ,top=368 ,right=960 ,bottom=487 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=712 ,top=259 ,right=712 ,bottom=601 </L>
	<X>left=582 ,top=487 ,right=712 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=474 ,top=542 ,right=582 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=582 ,top=542 ,right=712 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=712 ,top=542 ,right=828 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=828 ,top=542 ,right=960 ,bottom=601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='보험료' ,left=1156 ,top=262 ,right=1262 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=1278 ,top=262 ,right=1389 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현금' ,left=1662 ,top=318 ,right=1778 ,bottom=360 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=1791 ,top=262 ,right=1897 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국인' ,left=111 ,top=370 ,right=188 ,bottom=413 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='영수증' ,left=1659 ,top=360 ,right=1783 ,bottom=394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=106 ,top=508 ,right=183 ,bottom=564 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=257 ,right=582 ,bottom=598 </L>
	<L> left=217 ,top=569 ,right=452 ,bottom=569 </L>
	<L> left=1146 ,top=257 ,right=1905 ,bottom=257 </L>
	<C>id='{decode(TCNT,0,,TCNT)}', left=251, top=503, right=386, bottom=564, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구 분' ,left=966 ,top=169 ,right=1143 ,bottom=479 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=474 ,top=487 ,right=582 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=712 ,top=487 ,right=828 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='국세청자료' ,left=966 ,top=495 ,right=1143 ,bottom=540 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=542 ,right=966 ,bottom=542 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1394 ,top=259 ,right=1394 ,bottom=601 </L>
	<L> left=1654 ,top=259 ,right=1654 ,bottom=601 </L>
	<L> left=1786 ,top=259 ,right=1786 ,bottom=601 </L>
	<L> left=1270 ,top=259 ,right=1270 ,bottom=601 </L>
	<C>id='{decode(TREF11,0,,TREF11)}', left=1156, top=495, right=1270, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF21,0,,TREF21)}', left=1156, top=553, right=1270, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF12,0,,TREF12)}', left=1278, top=495, right=1392, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF22,0,,TREF22)}', left=1278, top=553, right=1392, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF25,0,,TREF25)}', left=1659, top=553, right=1778, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF26,0,,TREF26)}', left=1794, top=553, right=1894, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF15,0,,TREF15)}', left=1659, top=495, right=1778, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF16,0,,TREF16)}', left=1794, top=495, right=1894, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=828 ,top=487 ,right=960 ,bottom=542 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=474 ,top=161 ,right=474 ,bottom=601 </L>
	<L> left=191 ,top=161 ,right=191 ,bottom=601 </L>
	<L> left=106 ,top=161 ,right=106 ,bottom=601 </L>
	<L> left=1146 ,top=161 ,right=1146 ,bottom=601 </L>
	<L> left=61 ,top=487 ,right=1905 ,bottom=487 </L>
	<L> left=58 ,top=69 ,right=58 ,bottom=601 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1902 ,top=69 ,right=1902 ,bottom=601 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(제2쪽)' ,left=1662 ,top=8 ,right=1879 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=960 ,top=161 ,right=960 ,bottom=601 </L>
	<C>id='{decode(TREF13,0,,TREF13)}', left=1400, top=495, right=1516, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF14,0,,TREF14)}', left=1524, top=495, right=1651, bottom=540, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF24,0,,TREF24)}', left=1524, top=553, right=1651, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TREF23,0,,TREF23)}', left=1400, top=553, right=1516, bottom=598, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='신용카드' ,left=1527 ,top=299 ,right=1651 ,bottom=378 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등' ,left=1535 ,top=381 ,right=1640 ,bottom=415 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=1400 ,top=262 ,right=1511 ,bottom=476 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1519 ,top=259 ,right=1519 ,bottom=601 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=108 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=106 ,right=1902 ,bottom=106 </L>
	<T>id='그밖의 자료' ,left=966 ,top=61 ,right=1146 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청자료' ,left=966 ,top=8 ,right=1146 ,bottom=53 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1146 ,top=0 ,right=1146 ,bottom=103 </L>
	<C>id='PCNT', left=61, top=24, right=95, bottom=71, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=106 ,top=0 ,right=106 ,bottom=103 </L>
	<C>id='RELAT1', left=111, top=5, right=183, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF1,T,○,T,○,)}', left=111, top=58, right=183, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=191 ,top=0 ,right=191 ,bottom=103 </L>
	<C>id='RESINO1', left=198, top=58, right=466, bottom=103 ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=198, top=5, right=466, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=474 ,top=0 ,right=474 ,bottom=103 </L>
	<C>id='REF2', left=479, top=5, right=579, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6', left=479, top=58, right=579, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=582 ,top=0 ,right=582 ,bottom=103 </L>
	<C>id='REF3', left=587, top=5, right=706, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5', left=587, top=58, right=706, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=712 ,top=0 ,right=712 ,bottom=103 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=103 </L>
	<L> left=960 ,top=3 ,right=960 ,bottom=106 </L>
	<C>id='', left=836, top=58, right=958, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1394 ,top=0 ,right=1394 ,bottom=103 </L>
	<L> left=482 ,top=53 ,right=960 ,bottom=53 </L>
	<L> left=106 ,top=50 ,right=474 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=958 ,top=53 ,right=1905 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1654 ,top=0 ,right=1654 ,bottom=103 </L>
	<L> left=1270 ,top=0 ,right=1270 ,bottom=103 </L>
	<L> left=1786 ,top=0 ,right=1786 ,bottom=103 </L>
	<C>id='{decode(REF11,0,,REF11)}', left=1156, top=8, right=1270, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21,0,,REF21)}', left=1156, top=61, right=1270, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12,0,,REF12)}', left=1278, top=8, right=1392, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22,0,,REF22)}', left=1278, top=61, right=1392, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15,0,,REF15)}', left=1659, top=8, right=1778, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25,0,,REF25)}', left=1659, top=61, right=1778, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16,0,,REF16)}', left=1794, top=8, right=1894, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26,0,,REF26)}', left=1794, top=61, right=1894, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=58 ,top=0 ,right=58 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1902 ,top=0 ,right=1902 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='REF4', left=717, top=5, right=826, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=831, top=5, right=953, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF7', left=839, top=5, right=958, bottom=50, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8', left=717, top=58, right=826, bottom=103, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14,0,,REF14)}', left=1524, top=8, right=1651, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24,0,,REF24)}', left=1524, top=61, right=1651, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13,0,,REF13)}', left=1400, top=8, right=1516, bottom=53, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23,0,,REF23)}', left=1400, top=61, right=1516, bottom=106, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1519 ,top=5 ,right=1519 ,bottom=108 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=968 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='※ 작성방법' ,left=74 ,top=13 ,right=278 ,bottom=58 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 거주지국과 거주지국코드는 비거주자에 해당하는 경우에 한하여 적으며, 국제표준화기구(ISO)가 정한 ISO코드 중 국명약어 및 국가코드를 적습니다.' ,left=71 ,top=61 ,right=1889 ,bottom=101 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     (* ISO국가코드 : 국세청홈페이지->국세정보->국세조세정보->국세조세자료실에서 조회 할 수 있습니다. 예) 대한민국: KR, 미국 : US' ,left=71 ,top=98 ,right=1889 ,bottom=138 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 근무처별소득명세란은 비과세소득을 제외하고 적고, 근무처별소득명세에 적힌 근무처의 비과세소득은 그 금액을 합산하여 비과세 소득란에 적습니다.' ,left=71 ,top=209 ,right=1889 ,bottom=249 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     까지 지급조서를 제출하여야 합니다.' ,left=71 ,top=172 ,right=1889 ,bottom=212 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 원천징수의무자는 지급일이 속하는 연도의 다음 연도 2월 말일(휴업 또는 폐업한 경우에는 휴업일 또는 폐업일이 속하는 달의 다음 다음 달 말일을 말합니다)' ,left=71 ,top=135 ,right=1889 ,bottom=175 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 갑종근로소득과 을종근로소득을 합산하여 연말정산하는 때에는 16)-1 납세조합란의 11)란과 13)란에 각각 을종근로소득납세조합과 을종근로소득을' ,left=71 ,top=246 ,right=1889 ,bottom=286 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=0 ,right=1902 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=968 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=61 ,top=966 ,right=1905 ,bottom=966 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='      적고, [소득세법 시행령] 제150조에 따른 납세조합공제금액을 57)납세조합공제란에 적습니다. 합병, 기업형태 변경 등으로 당해 법인이 연말정산을' ,left=71 ,top=283 ,right=1889 ,bottom=323 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      하는 경우에 피합병법인, 기업형태변경전의 소득은 근무처별소득명세 종(전)란에 별도로 적습니다.' ,left=71 ,top=320 ,right=1889 ,bottom=360 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 18-3란은 외국인근로자가 [조세특례제한법] 제 18조의2제1항을 적용하는 경우에 한하여 적으며, 16)계란의 금액에 100분의 30을 곱한 금액을 적습니다.' ,left=71 ,top=357 ,right=1889 ,bottom=397 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 21)총급여란에는 16)계란의 금액을 적되, 18)-3란의 금액이 있는 경우에는 16)계란의 금액에서 18)-3란의 금액을 뺀 금액을 적으며, 외국인근로자가 ' ,left=71 ,top=394 ,right=1889 ,bottom=434 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    [조세특례제한법] 제18조의2제2항에 따라 단일세율을 적용하는 경우에는 16)계 + 비과세소득 금액을 적고, 소득세와 관련한 비과세 .공제.감면 및 세액공제에 ' ,left=71 ,top=431 ,right=1889 ,bottom=471 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    관한 규정은 적용하지 아니합니다.' ,left=71 ,top=468 ,right=1889 ,bottom=508 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  7. 종합소득 특별공제[34) ~ 39)]란과 그 밖의 소득공제[43)~48)]란은 별지 제37호서식의 공제액을 적습니다.' ,left=71 ,top=505 ,right=1889 ,bottom=545 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  8. 67) 차감징수세액이 소액부징수(1천원 미만을 말합니다)에 해당하는 경우 세액을 0 으로 적습니다.' ,left=71 ,top=542 ,right=1889 ,bottom=582 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  9. 68) 소득공제 명세란은 2006년 이후 발생하는 근로소득 연말정산분부터 사용합니다.' ,left=71 ,top=579 ,right=1889 ,bottom=619 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    가. 관계코드란 : 소득자 본인=0, 소득자의 직계존속=1, 배우자의 직계존속=2, 배우자=3, 직계비속=4, 형제자매=5, 기타=6을 적습니다(4.5.6의 경우 소득자와' ,left=71 ,top=619 ,right=1889 ,bottom=659 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='           배우자의 각각의 관계를 포함합니다). ' ,left=71 ,top=656 ,right=1889 ,bottom=696 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    나. 내.외국인란 : 내국인의 경우 1 로, 외국인의 경우 9 로 적습니다.' ,left=71 ,top=693 ,right=1889 ,bottom=733 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    다. 인적공제항목란 : 인적공제사항이 있는 경우 해당란에 O 표시를 합니다(해당사항이 없을 경우 비워둡니다).' ,left=71 ,top=730 ,right=1889 ,bottom=770 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    라. 국세청 자료란 : [소득세법] 제165조에 따라 국세청 홈페이지에서 제공하는 각 소득공제 항목의 금액 중 소득공제대상이 되는 금액을  적습니다.' ,left=71 ,top=767 ,right=1889 ,bottom=807 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    마. 그 밖의 자료란 : 국세청에서 제공하는 증빙서류 외의 것을 말합니다.(예를 들면, 학원비 지로납부영수증은 신용카드 등 란에, 시력교정용 안경구입비는 ' ,left=71 ,top=804 ,right=1889 ,bottom=844 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    바. 각종 소득공제 항목란 : 소득공제항목에 해당하는 실제 지출금액을 적습니다(소득공제액이 아닌 실제 사용금액이 금액단위별로 구분된 범위 안에 적도록' ,left=71 ,top=878 ,right=1889 ,bottom=918 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         작성합니다).' ,left=71 ,top=915 ,right=1889 ,bottom=955 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='        의료비란에 각각 적습니다).' ,left=71 ,top=841 ,right=1889 ,bottom=881 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   연말정산 대장 현황
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print4  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print2">
	<param NAME="DetailDataID"				VALUE="gcds_print2">
	<PARAM NAME="PaperSize"						VALUE="A3">	
	<PARAM NAME="LandScape"						VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="FixPaperSize"				VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="PreviewZoom"					VALUE="70">
	<PARAM NAME="Format"							VALUE="
<B>id=Header ,left=0,top=0 ,right=4100 ,bottom=144 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1631 ,top=34 ,right=2506 ,bottom=112 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1619 ,top=25 ,right=2500 ,bottom=103 ,border=true</X>
	<C>id='CURDT', left=1625, top=31, right=2494, bottom=97 ,mask='연말정산 XXXX 년 대장 현황', face='HY견고딕', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(단위:원)' ,left=3872 ,top=100 ,right=4084 ,bottom=144 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4100 ,bottom=166 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='주민세' ,left=3816 ,top=119 ,right=3947 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=3956 ,top=119 ,right=4088 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차감징수 세액' ,left=3675 ,top=19 ,right=4088 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타비과세' ,left=1988 ,top=19 ,right=2400 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=3253 ,top=119 ,right=3384 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=3113 ,top=119 ,right=3244 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2825 ,top=9 ,right=2825 ,bottom=166 </L>
	<T>id='총급여' ,left=2409 ,top=19 ,right=2822 ,bottom=59 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(비과세 제외)' ,left=2409 ,top=66 ,right=2822 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국외근로소득' ,left=1566 ,top=19 ,right=1978 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결정세액' ,left=2831 ,top=19 ,right=3103 ,bottom=106 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2403 ,top=9 ,right=2403 ,bottom=166 </L>
	<L> left=1981 ,top=9 ,right=1981 ,bottom=166 </L>
	<T>id='70~' ,left=941 ,top=119 ,right=1000 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=72 ,top=9 ,right=72 ,bottom=166 </L>
	<L> left=3 ,top=9 ,right=3 ,bottom=166 </L>
	<L> left=353 ,top=9 ,right=353 ,bottom=166 </L>
	<L> left=725 ,top=9 ,right=725 ,bottom=166 </L>
	<L> left=616 ,top=9 ,right=616 ,bottom=166 </L>
	<L> left=463 ,top=9 ,right=463 ,bottom=166 </L>
	<T>id='(비과세 포함)' ,left=1144 ,top=66 ,right=1556 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연간급여액' ,left=1144 ,top=19 ,right=1556 ,bottom=59 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1138 ,top=9 ,right=1138 ,bottom=166 </L>
	<L> left=1559 ,top=9 ,right=1559 ,bottom=166 </L>
	<L> left=1138 ,top=112 ,right=4091 ,bottom=112 </L>
	<T>id='전근무지' ,left=1144 ,top=119 ,right=1275 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65~' ,left=872 ,top=119 ,right=931 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=866 ,top=112 ,right=1003 ,bottom=112 </L>
	<T>id='순번' ,left=9 ,top=16 ,right=69 ,bottom=162 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=466 ,top=16 ,right=613 ,bottom=162 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자녀' ,left=1009 ,top=72 ,right=1066 ,bottom=112 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배' ,left=731 ,top=69 ,right=769 ,bottom=162 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=772 ,top=62 ,right=772 ,bottom=166 </L>
	<L> left=819 ,top=62 ,right=819 ,bottom=166 </L>
	<L> left=1003 ,top=62 ,right=1003 ,bottom=166 </L>
	<L> left=866 ,top=62 ,right=866 ,bottom=166 </L>
	<L> left=3 ,top=166 ,right=4091 ,bottom=166 </L>
	<T>id='경' ,left=872 ,top=69 ,right=1000 ,bottom=109 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제' ,left=731 ,top=16 ,right=1131 ,bottom=56 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=9 ,right=4091 ,bottom=9 </L>
	<L> left=725 ,top=62 ,right=1138 ,bottom=62 </L>
	<T>id='양육' ,left=1009 ,top=119 ,right=1066 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장' ,left=825 ,top=69 ,right=863 ,bottom=162 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부' ,left=778 ,top=69 ,right=816 ,bottom=162 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀' ,left=1075 ,top=72 ,right=1131 ,bottom=112 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=1075 ,top=119 ,right=1131 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현근무지' ,left=1284 ,top=119 ,right=1416 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1425 ,top=119 ,right=1556 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2269 ,top=119 ,right=2400 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전근무지' ,left=1988 ,top=119 ,right=2119 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현근무지' ,left=2128 ,top=119 ,right=2259 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1847 ,top=119 ,right=1978 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현근무지' ,left=1706 ,top=119 ,right=1838 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전근무지' ,left=1566 ,top=119 ,right=1697 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2691 ,top=119 ,right=2822 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현근무지' ,left=2550 ,top=119 ,right=2681 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전근무지' ,left=2409 ,top=119 ,right=2541 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=934 ,top=112 ,right=934 ,bottom=166 </L>
	<L> left=1841 ,top=112 ,right=1841 ,bottom=166 </L>
	<L> left=1700 ,top=112 ,right=1700 ,bottom=166 </L>
	<L> left=2263 ,top=112 ,right=2263 ,bottom=166 </L>
	<L> left=2122 ,top=112 ,right=2122 ,bottom=166 </L>
	<L> left=2684 ,top=112 ,right=2684 ,bottom=166 </L>
	<L> left=2544 ,top=112 ,right=2544 ,bottom=166 </L>
	<L> left=1419 ,top=112 ,right=1419 ,bottom=166 </L>
	<L> left=1278 ,top=112 ,right=1278 ,bottom=166 </L>
	<T>id='소득세' ,left=2831 ,top=119 ,right=2963 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3106 ,top=9 ,right=3106 ,bottom=166 </L>
	<T>id='주민세' ,left=2972 ,top=119 ,right=3103 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전근무지 납부' ,left=3113 ,top=19 ,right=3384 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3247 ,top=112 ,right=3247 ,bottom=166 </L>
	<L> left=2966 ,top=112 ,right=2966 ,bottom=166 </L>
	<L> left=1069 ,top=62 ,right=1069 ,bottom=166 </L>
	<T>id='부서' ,left=78 ,top=16 ,right=350 ,bottom=162 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=3394 ,top=119 ,right=3525 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3669 ,top=9 ,right=3669 ,bottom=166 </L>
	<T>id='주민세' ,left=3534 ,top=119 ,right=3666 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현근무지 납부' ,left=3394 ,top=19 ,right=3666 ,bottom=106 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3528 ,top=112 ,right=3528 ,bottom=166 </L>
	<T>id='소득세' ,left=3675 ,top=119 ,right=3806 ,bottom=159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=4091 ,top=9 ,right=4091 ,bottom=166 </L>
	<L> left=3950 ,top=112 ,right=3950 ,bottom=166 </L>
	<L> left=3809 ,top=112 ,right=3809 ,bottom=166 </L>
	<L> left=3388 ,top=9 ,right=3388 ,bottom=166 </L>
	<T>id='사번' ,left=359 ,top=16 ,right=459 ,bottom=162 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=622 ,top=16 ,right=722 ,bottom=162 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=4100 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3 ,top=0 ,right=3 ,bottom=50 </L>
	<L> left=3 ,top=50 ,right=4091 ,bottom=50 </L>
	<L> left=72 ,top=0 ,right=72 ,bottom=50 </L>
	<L> left=353 ,top=0 ,right=353 ,bottom=50 </L>
	<L> left=616 ,top=0 ,right=616 ,bottom=50 </L>
	<L> left=725 ,top=0 ,right=725 ,bottom=50 </L>
	<L> left=2966 ,top=0 ,right=2966 ,bottom=50 </L>
	<L> left=3247 ,top=0 ,right=3247 ,bottom=50 </L>
	<L> left=3388 ,top=0 ,right=3388 ,bottom=50 </L>
	<L> left=3528 ,top=0 ,right=3528 ,bottom=50 </L>
	<L> left=3669 ,top=0 ,right=3669 ,bottom=50 </L>
	<L> left=3950 ,top=0 ,right=3950 ,bottom=50 </L>
	<L> left=3809 ,top=0 ,right=3809 ,bottom=50 </L>
	<L> left=4091 ,top=0 ,right=4091 ,bottom=50 </L>
	<L> left=463 ,top=0 ,right=463 ,bottom=50 </L>
	<C>id='BA0101YN', left=731, top=3, right=769, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=772 ,top=0 ,right=772 ,bottom=50 </L>
	<C>id='BA0102CNT', left=778, top=3, right=816, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=819 ,top=0 ,right=819 ,bottom=50 </L>
	<C>id='AD0103CNT', left=825, top=3, right=863, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=866 ,top=0 ,right=866 ,bottom=50 </L>
	<C>id='AD0101CNT', left=872, top=3, right=931, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=934 ,top=0 ,right=934 ,bottom=50 </L>
	<C>id='AD0102CNT', left=941, top=3, right=1000, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1003 ,top=0 ,right=1003 ,bottom=50 </L>
	<C>id='AD0105CNT', left=1009, top=3, right=1066, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1069 ,top=0 ,right=1069 ,bottom=50 </L>
	<L> left=1278 ,top=0 ,right=1278 ,bottom=50 </L>
	<L> left=1419 ,top=0 ,right=1419 ,bottom=50 </L>
	<C>id='AD0104YN', left=1075, top=3, right=1131, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1138 ,top=0 ,right=1138 ,bottom=50 </L>
	<L> left=1700 ,top=0 ,right=1700 ,bottom=50 </L>
	<L> left=1841 ,top=0 ,right=1841 ,bottom=50 </L>
	<C>id={CURROW}, left=9, top=3, right=69, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=78, top=3, right=350, bottom=44, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000}, left=1141, top=3, right=1275, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1559 ,top=0 ,right=1559 ,bottom=50 </L>
	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 </L>
	<L> left=2122 ,top=0 ,right=2122 ,bottom=50 </L>
	<L> left=2263 ,top=0 ,right=2263 ,bottom=50 </L>
	<L> left=2403 ,top=0 ,right=2403 ,bottom=50 </L>
	<L> left=2544 ,top=0 ,right=2544 ,bottom=50 </L>
	<L> left=2684 ,top=0 ,right=2684 ,bottom=50 </L>
	<L> left=2825 ,top=0 ,right=2825 ,bottom=50 </L>
	<C>id={PC10000+PC20000}, left=1281, top=3, right=1416, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000+PC10000+PC20000}, left=1422, top=3, right=1556, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={FRE13001+PC23000}, left=1844, top=3, right=1978, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC23000', left=1703, top=3, right=1838, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE13001', left=1563, top=3, right=1697, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={FRE13005+PC20000}, left=2266, top=3, right=2400, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC20000', left=2125, top=3, right=2259, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE13005', left=1984, top=3, right=2119, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000+PB10000}, left=2688, top=3, right=2822, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB10000', left=2547, top=3, right=2681, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={BC10000+BC20000}, left=2406, top=3, right=2541, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB41000', left=2828, top=3, right=2963, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB42000', left=2969, top=3, right=3103, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3106 ,top=0 ,right=3106 ,bottom=50 </L>
	<C>id='PB51000', left=3109, top=3, right=3244, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB52000', left=3250, top=3, right=3384, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB62000', left=3531, top=3, right=3666, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB61000', left=3391, top=3, right=3525, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB71000', left=3672, top=3, right=3806, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB72000', left=3813, top=3, right=3947, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={PB71000+PB72000}, left=3953, top=3, right=4088, bottom=44, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=359, top=3, right=459, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=466, top=3, right=613, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=622, top=3, right=722, bottom=44, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2726 ,right=4100 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=3713 ,top=3 ,right=4091 ,bottom=84</I>
	<T>id='#p/#t' ,left=1706 ,top=3 ,right=2413 ,bottom=44 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=0 ,right=4091 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>