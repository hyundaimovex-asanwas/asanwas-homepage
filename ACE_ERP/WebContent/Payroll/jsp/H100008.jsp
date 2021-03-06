<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/급여대장
+ 프로그램 ID	: h100008.HTML
+ 기 능 정 의	: 조회|출력
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 수 정 이 력	: 정영식 - 2005.08.17 - 급여대장 출력물 관련 수정
+ 수 정 이 력	: 정영식 - 2005.09.05 - 정기급여 ( 소급, 퇴직, 휴직포함함)
---------------------------------------------------------------------------------
+ 수 정 내 용 : 급여대장 과거 데이터 조회를 위하여 급여대장 출력물의 상세내용 쿼리문 변경
                ( p020006_s9 ==> p020006_s91로 변경함 )
+ 수 정 일 자 : 2010.10.29 
+ 수   정  자 : 정  영  식 
---------------------------------------------------------------------------------
+ 서 블 릿 명	: h100008_s1, h100008_s2, h100008_s3
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>급여대장</title>

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
var gs_level;
var gs_treecd;

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_app_yyyymm_1.Text = gs_date2;

	//지급구분
	gcds_select_ec01az.DataID = "/servlet/Contract.hclcode_s1?v_str1=1120";
	gcds_select_ec01az.Reset();

	//소속정보
  gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();

	//직군정보
	gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000"; 
	gcds_select_ec03az.Reset();

	//직위정보
	//gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	//gcds_select_ec04az.Reset();

	//직종정보
	gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2037"; 
	gcds_select_ec04az.Reset();

	//급여항목
	gcds_select_ec06az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_select_ec06az.Reset();

	//직급정보
	gcds_select_ec05az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	gcds_select_ec05az.Reset();

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){ //사원별대장 탭 조회
	var str1 = "";// fn_trim(gcem_jigubil_1.Text);			//지급일자
	var str2 = fn_trim(gcem_app_yyyymm_1.Text);					//적용년월
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);	//지급구분
	var str4 = fn_trim(gclx_select_ec02az.BindColVal);	//소속
	var str5 = fn_trim(gclx_select_ec03az.BindColVal);	//직군
	var str6 = fn_trim(gcem_emo_1.Text);								//사번부터
	var str7 =fn_trim( gcem_emo_2.Text);								//사번까지
	var str8 =fn_trim( txt_empnm.value);								//성명
	var str9 =fn_trim( gclx_select_ec04az.BindColVal);	//직위
	var str10 =fn_trim( gclx_select_ec05az.BindColVal);	//직급

	gcds_grid_ec01az.DataID = "/servlet/Contract.h100008_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + str8
									 + "&v_str9=" + str9
									 + "&v_str10=" + str10
									 + "&v_str11=" + gs_level
									 + "&v_str12=" + gs_treecd;
   // prompt("",gcds_grid_ec01az.DataID);
	gcds_grid_ec01az.Reset(); //그리드
	

}

/******************************************************************************
	Description : 보고서 조회 - 정기급여
******************************************************************************/
function ln_Query2(){ //사원별대장 탭 조회
	var str1 = "";//fn_trim(gcem_jigubil_1.Text);        //지급일자
	var str2 = fn_trim(gcem_app_yyyymm_1.Text);        //적용년월
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);  //지급구분
	var str4 = fn_trim(gclx_select_ec02az.BindColVal);  //소속
	var str5 = fn_trim(gclx_select_ec03az.BindColVal);  //직군
	var str6 = fn_trim(gcem_emo_1.Text);                //사번부터
	var str7 =fn_trim( gcem_emo_2.Text);                //사번까지
	var str8 =fn_trim( txt_empnm.value);                //성명
	var str9 =fn_trim( gclx_select_ec04az.BindColVal);  //직위
	var str10 =fn_trim( gclx_select_ec05az.BindColVal);  //직급

  //2008.08.18 재택근무자 반영
  //gcds_grid_ec02az.DataID = "/servlet/Contract.h100008_s2?"
	//gcds_grid_ec02az.DataID = "/servlet/Contract.h100008_s9?"
	gcds_grid_ec02az.DataID = "/servlet/Contract.h100008_s91?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + str8
									 + "&v_str9=" + str9
									 + "&v_str10=" + str10;
  //prompt("h100008_s91?",gcds_grid_ec02az.DataID);
	gcds_grid_ec02az.Reset(); //그리드
	gcds_grid_ec02az.rowposition=1;

}

/******************************************************************************
	Description : 지급항목명
******************************************************************************/
function ln_Query_title(){
  var str1 = '3070048' //임의의 사람 지정
	var str2 = gcem_app_yyyymm_1.Text;//gs_date2;
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);
	
	gcds_rpt_title.DataID = "/servlet/Contract.h100008_s4?v_str1="+str1 +"&v_str2="+str2+"&v_str3="+str3;
	//prompt('',gcds_rpt_title.DataID);
	gcds_rpt_title.Reset();
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	if (gcds_grid_ec01az.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
	  
		if (gclx_select_ec01az.BindColVal=='1') {	//지급구분-급여대장[1]
			ln_Query_title();
			ln_Query2();
			
			var ls_temp = "CUDATE:STRING,CTITLE:STRING,PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
			
			gcds_report0.SetDataHeader(ls_temp);
			gcds_report0.Addrow();
			gcds_report0.namevalue(1,"CUDATE")=gs_date;
      
			//REPORT TITLE START--------------------------------------------------------------------------------------
			var str_yyyymm = gcem_app_yyyymm_1.Text;
			var str_paydiv1 = fn_trim(gclx_select_ec01az.text);
			var str_paydiv2 = fn_trim(gclx_select_ec01az.BindcolVal);

//			if (str_paydiv2 == '1') { 
			if (str_paydiv2 == '1') { 
			   
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1.substring(2,4) + " 대장 ["
																					+ str_yyyymm.substring(0,4) + "년"
																					+ str_yyyymm.substring(4,6) + "월]";
			}else { 
			     
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1.substring(0,2) + " 대장 ["
																					+ str_yyyymm.substring(0,4) + "년"
																					+ str_yyyymm.substring(4,6) + "월]";
			}
			//REPORT TITLE END----------------------------------------------------------------------------------------
      
			if (gcds_rpt_title.namevalue(1,"PR0020") != '' || gcds_rpt_title.namevalue(1,"PR0020") != '0') {
				gcds_report0.namevalue(1,"PR0020") = gcds_rpt_title.namevalue(1,"PR0020"); 
			} else { gcds_report0.namevalue(1,"PR0020") = ''; }

			if (gcds_rpt_title.namevalue(1,"PR0030") != '' || gcds_rpt_title.namevalue(1,"PR0030") != '0') {
				gcds_report0.namevalue(1,"PR0030") = gcds_rpt_title.namevalue(1,"PR0030"); 
			} else { gcds_report0.namevalue(1,"PR0030") = ''; }

			if (gcds_rpt_title.namevalue(1,"PR0040") != '' || gcds_rpt_title.namevalue(1,"PR0040") != '0') {
				gcds_report0.namevalue(1,"PR0040") = gcds_rpt_title.namevalue(1,"PR0040"); 
			} else { gcds_report0.namevalue(1,"PR0040") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0020") != '' || gcds_rpt_title.namevalue(1,"BR0020") != '0') {
				gcds_report0.namevalue(1,"BR0020") = gcds_rpt_title.namevalue(1,"BR0020"); 
			} else { gcds_report0.namevalue(1,"BR0020") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0030") != '' || gcds_rpt_title.namevalue(1,"BR0030") != '0') {
				gcds_report0.namevalue(1,"BR0030") = gcds_rpt_title.namevalue(1,"BR0030"); 
			} else { gcds_report0.namevalue(1,"BR0030") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0040") != '' || gcds_rpt_title.namevalue(1,"BR0040") != '0') {
				gcds_report0.namevalue(1,"BR0040") = gcds_rpt_title.namevalue(1,"BR0040"); 
			} else { gcds_report0.namevalue(1,"BR0040") = ''; }

			gcrp_print.preview();		//급여대장
	
	} else {	//지급구분-상여대장[5]
			   
			ln_Query_title();
			ln_Query2();
			var ls_temp = "CUDATE:STRING,CTITLE:STRING,PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
			gcds_report0.SetDataHeader(ls_temp);
			gcds_report0.Addrow();
			gcds_report0.namevalue(1,"CUDATE")=gs_date;

			//REPORT TITLE START--------------------------------------------------------------------------------------
			var str_yyyymm = gcem_app_yyyymm_1.Text;
			var str_paydiv1 = fn_trim(gclx_select_ec01az.text);
			var str_paydiv2 = fn_trim(gclx_select_ec01az.BindcolVal);

        str_paydiv1 = "한국인계약직급여";

			if (str_paydiv2 == '1') { 
       // 	if (str_paydiv2 == '1') { 
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1 + "대장["
				                                 //str_paydiv1.substring(2,4) + " 대장 ["
																					+ str_yyyymm.substring(0,4) + "년"
																					+ str_yyyymm.substring(4,6) + "월]";
			}else { 
				gcds_report0.namevalue(1,"CTITLE")= str_paydiv1 + "대장["
				                                  //str_paydiv1.substring(0,2) + " 대장 ["
																					+ str_yyyymm.substring(0,4) + "년"
																					+ str_yyyymm.substring(4,6) + "월]";
			}
			//REPORT TITLE END----------------------------------------------------------------------------------------
    
			if (gcds_rpt_title.namevalue(1,"PR0020") != '' || gcds_rpt_title.namevalue(1,"PR0020") != '0') {
				gcds_report0.namevalue(1,"PR0020") = gcds_rpt_title.namevalue(1,"PR0020"); 
				                                     
			} else { gcds_report0.namevalue(1,"PR0020") = ''; }

			if (gcds_rpt_title.namevalue(1,"PR0030") != '' || gcds_rpt_title.namevalue(1,"PR0030") != '0') {
				gcds_report0.namevalue(1,"PR0030") = gcds_rpt_title.namevalue(1,"PR0030"); 
			} else { gcds_report0.namevalue(1,"PR0030") = ''; }

			if (gcds_rpt_title.namevalue(1,"PR0040") != '' || gcds_rpt_title.namevalue(1,"PR0040") != '0') {
				gcds_report0.namevalue(1,"PR0040") = gcds_rpt_title.namevalue(1,"PR0040"); 
			} else { gcds_report0.namevalue(1,"PR0040") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0020") != '' || gcds_rpt_title.namevalue(1,"BR0020") != '0') {
				gcds_report0.namevalue(1,"BR0020") = gcds_rpt_title.namevalue(1,"BR0020"); 
			} else { gcds_report0.namevalue(1,"BR0020") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0030") != '' || gcds_rpt_title.namevalue(1,"BR0030") != '0') {
				gcds_report0.namevalue(1,"BR0030") = gcds_rpt_title.namevalue(1,"BR0030"); 
			} else { gcds_report0.namevalue(1,"BR0030") = ''; }

			if (gcds_rpt_title.namevalue(1,"BR0040") != '' || gcds_rpt_title.namevalue(1,"BR0040") != '0') {
				gcds_report0.namevalue(1,"BR0040") = gcds_rpt_title.namevalue(1,"BR0040"); 
			} else { gcds_report0.namevalue(1,"BR0040") = ''; }

			gcrp_print2.preview();		//계약급여
		}
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

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete() {
	
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk(){

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gcds_pyo" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_pyo2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지급구분 DataSet-->
  <PARAM NAME="SortExpr" VALUE="+MINORCD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 소속구분 DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직군 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직위 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직급 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec06az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 급여항목 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SubsumExpr   value="1:SEQ">
	<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rpt_title classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	// document.all.LowerFrame.style.visibility="hidden";
	//gcds_select_ec01az.InsertRow(1);
	//gcds_select_ec01az.NameValue(1,"MINORCD")="";
	//gcds_select_ec01az.NameValue(1,"MINORNM")="전체";
	gcds_select_ec01az.DeleteRow(2);
	gcds_select_ec01az.DeleteRow(2);
	gcds_select_ec01az.DeleteRow(2);
	gclx_select_ec01az.index=0; //지급구분
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0; //소속구분
</script>

<script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1);
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="전체";
	gclx_select_ec03az.index=0; //직군구분
</script>

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	gcds_select_ec04az.InsertRow(1);
	gcds_select_ec04az.NameValue(1,"MINORCD")="";
	gcds_select_ec04az.NameValue(1,"MINORNM")="전체";
	gclx_select_ec04az.index=0;  //직위구분
</script>

<script language="javascript" for="gcds_select_ec06az" event="onloadCompleted(row,colid)">
	gcds_select_ec06az.InsertRow(1);
	gcds_select_ec06az.NameValue(1,"MINORCD")="";
	gcds_select_ec06az.NameValue(1,"MINORNM")="전체";
	//gclx_select_ec06az.index=0;
</script>

<script language="javascript" for="gcds_select_ec05az" event="onloadCompleted(row,colid)">
	gcds_select_ec05az.InsertRow(1);
	gcds_select_ec05az.NameValue(1,"MINORCD")="";
	gcds_select_ec05az.NameValue(1,"MINORNM")="전체";
	gclx_select_ec05az.index=0;

	// document.all.LowerFrame.style.visibility="hidden";
	window.status="조회가 완료 되었습니다.";
</script>

<script language="javascript" for="gcds_select_ec07az" event="onloadCompleted(row,colid)">
	gcds_select_ec07az.InsertRow(1);
	gcds_select_ec07az.NameValue(1,"MINORCD")="";
	gcds_select_ec07az.NameValue(1,"MINORNM")="전체";
	gclx_select_iche.index=0;
</script>

<script language="javascript" for="gcds_select_ec08az" event="onloadCompleted(row,colid)">
	gcds_select_ec08az.InsertRow(1);
	gcds_select_ec08az.NameValue(1,"MINORCD")="";
	gcds_select_ec08az.NameValue(1,"MINORNM")="전체";
	gclx_select_bank.index=0;
	window.status="조회가 완료 되었습니다.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	for (i=1; i<= row ; i++) {
		gcds_grid_ec02az.namevalue(i,"SENUM")  =  gcds_grid_ec02az.namevalue(i,"P23002") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23003") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23004") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23005") +"-"
					 +  gcds_grid_ec02az.namevalue(i,"P23006") ;
    

	}
</script>

<script language="javascript" for="gcds_rpt_title" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_rpt_title" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
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

</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif" ><img src="../img/h100008_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>	    
			 <img id=com_b_print src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()"> 
			 <img id=com_b_query src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;</nobr>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0">
    <tr><td width=140 valign=top><nobr><DIV ID="gcgd_create1_1" STYLE="display:block;">
			<table  cellpadding="0" cellspacing="0" border="0" style='width:877px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;적용년월&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:0px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gcem_app_yyyymm_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;지급구분&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:0px;"><nobr><comment id="__NSID__"><OBJECT id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
         	<param name=CBData					value="T^계약급여,K^특별상여">					
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="FALSE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-top-width:0px;"><nobr><comment id="__NSID__"><OBJECT id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
						<param name=ComboDataID			value=gcds_dept>
						<param name=SearchColumn		value="DEPTCD^DEPTNM">
						<param name=Sort            value="false">
						<param name=SortColumn			value="DEPTCD">
						<param name=ListExprFormat	value="DEPTNM^0^130">
						<param name=BindColumn			value="DEPTCD">
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
					<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee"><nobr >&nbsp;직군&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;"><nobr><comment id="__NSID__"><OBJECT id=gclx_select_ec03az  name="gclx_select_ec03az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
						style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec03az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
							<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#ffffff" ><nobr>&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3>&nbsp;</td>
					<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:0px;" align=RIGHT >&nbsp;&nbsp;</td>
				</tr>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;사원번호&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:1px;"><nobr><table cellpadding=0 cellspacing=0 width=150><tr><td>
						<comment id="__NSID__"><OBJECT id=gcem_emo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td><td>~</td>
					<td>
						<comment id="__NSID__"><OBJECT id=gcem_emo_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table></nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-top-width:1px;"><nobr><input type="text" id=txt_empnm style="width:70px;" class="txt11" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;&nbsp;</nobr></td>
				<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;직종&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;"><nobr>
					<comment id="__NSID__"><OBJECT id=gclx_select_ec04az  name="gclx_select_ec04az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec04az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
				<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee" ><nobr>&nbsp;직급&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-top-width:1px;" colspan=3>
					<comment id="__NSID__"><OBJECT id=gclx_select_ec05az  name="gclx_select_ec05az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec05az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="TRUE">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</OBJECT></comment><script>__ws__(__NSID__);</script></td>
				
				<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:1px;" COLSPAN=3 align=RIGHT >&nbsp;&nbsp;</td>
					</tr>
			</table>
</div></nobr>
		</td>
	 </tr>
 </table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:340px" valign=top>
						<comment id="__NSID__"><OBJECT id=gcgd_create1_2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 875px; HEIGHT: 380px;border:1 solid #777777" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="viewSummary" VALUE="1">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="SortView"		VALUE="left">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="
			          <C> Name='소속'       ID=DEPTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=LEFT SumText='합계' SumBgColor=#C3D0DB sort=true  </C>
								<C> Name='사번'				ID=EMPNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center SumText='' SumBgColor=#C3D0DB sort=true </C>
								<C> Name='성명'				ID=EMPNMK			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center SumText='' SumBgColor=#C3D0DB sort=true </C>
								<C> Name='직위'				ID=JOBKINDNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=LEFT SumText='' SumBgColor=#C3D0DB sort=true </C> 
								<C> Name='지급합계'		ID=S91000  		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	 align=right SumText=@sum SumBgColor=#C3D0DB  </C> 
								<C> Name='공제합계'		ID=S93000			HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right SumText=@sum  SumBgColor=#C3D0DB </C>
								<C> Name='차인지급'		ID=S94000			HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right SumText=@sum  SumBgColor=#C3D0DB </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
            </td>
          </tr>
				</table>
			</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 정 기 급 여 ####
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_grid_ec02az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=2869 ,bottom=181 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='단위 : 원' ,left=3784 ,top=122 ,right=4000 ,bottom=181 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3784, top=62, right=4000, bottom=119, align='right' ,mask='XXXX.XX.XX', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='Print Date:' ,left=3484 ,top=62 ,right=3781 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CTITLE', left=922, top=56, right=2581, bottom=144, face='HY중고딕', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4100 ,bottom=250 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3997 ,top=3 ,right=25 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=613 ,top=3 ,right=613 ,bottom=250 </L>
	<L> left=253 ,top=3 ,right=253 ,bottom=250 </L>
	<T>id='입사일' ,left=3738 ,top=12 ,right=3969 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배부자장경' ,left=2581 ,top=12 ,right=2831 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=638 ,top=12 ,right=850 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그룹입사일' ,left=3738 ,top=75 ,right=3969 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수습적용' ,left=3734 ,top=131 ,right=3966 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=3734 ,top=191 ,right=3966 ,bottom=247 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=25 ,top=3 ,right=25 ,bottom=244 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2556 ,top=6 ,right=2556 ,bottom=250 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=244 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='직급' ,left=272 ,top=191 ,right=572 ,bottom=247 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=638 ,top=75 ,right=850 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호봉계' ,left=634 ,top=191 ,right=850 ,bottom=247 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=638 ,top=131 ,right=850 ,bottom=187 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역근무수당' ,left=1391 ,top=191 ,right=1647 ,bottom=247 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=903 ,top=12 ,right=1113 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=1659 ,top=191 ,right=1922 ,bottom=247 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근무수당' ,left=1947 ,top=75 ,right=2200 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(PR0030,'','기타지급2',PR0030)}, left=2253, top=75, right=2531, bottom=131, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(PR0040,'','기타지급3',PR0040)}, left=2253, top=131, right=2531, bottom=187, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급계' ,left=2253 ,top=191 ,right=2531 ,bottom=247 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(PR0020,'','기타지급1',PR0020)}, left=2253, top=16, right=2531, bottom=72, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전월소급' ,left=1972 ,top=12 ,right=2200 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임원직책수당' ,left=1659 ,top=131 ,right=1922 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학자금' ,left=1697 ,top=75 ,right=1922 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=1697 ,top=12 ,right=1922 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1391 ,top=131 ,right=1647 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장단수당' ,left=1391 ,top=75 ,right=1647 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남북경협수당' ,left=1391 ,top=12 ,right=1647 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=1159 ,top=194 ,right=1372 ,bottom=250 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연장수당' ,left=1159 ,top=131 ,right=1372 ,bottom=191 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=1159 ,top=78 ,right=1372 ,bottom=134 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납' ,left=1159 ,top=16 ,right=1372 ,bottom=75 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=903 ,top=75 ,right=1113 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=903 ,top=131 ,right=1113 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유지비' ,left=903 ,top=191 ,right=1113 ,bottom=247 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(BR0020,'','기타공제1',BR0020)}, left=3147, top=191, right=3425, bottom=247, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='실수령액' ,left=3500 ,top=191 ,right=3709 ,bottom=247 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(BR0030,'','기타공제2',BR0030)}, left=3434, top=12, right=3709, bottom=69, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공제계' ,left=3500 ,top=131 ,right=3709 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(BR0040,'','기타공제3',BR0040)}, left=3434, top=75, right=3709, bottom=128, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소속' ,left=272 ,top=12 ,right=553 ,bottom=72 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=25 ,top=250 ,right=4006 ,bottom=250 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사번' ,left=38 ,top=12 ,right=250 ,bottom=72 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=38 ,top=131 ,right=250 ,bottom=184 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급호' ,left=38 ,top=191 ,right=250 ,bottom=247 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=38 ,top=75 ,right=250 ,bottom=128 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='최종변동일' ,left=272 ,top=75 ,right=556 ,bottom=128 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연차수당' ,left=1947 ,top=131 ,right=2200 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=2581 ,top=75 ,right=2831 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=2581 ,top=131 ,right=2831 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=2584 ,top=187 ,right=2834 ,bottom=244 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=2834 ,top=75 ,right=3134 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=2834 ,top=19 ,right=3134 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=2834 ,top=131 ,right=3134 ,bottom=187 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여직원회비' ,left=2834 ,top=191 ,right=3134 ,bottom=250 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출원금이자' ,left=3175 ,top=131 ,right=3425 ,bottom=184 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보증보험' ,left=3200 ,top=75 ,right=3425 ,bottom=128 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=3200 ,top=19 ,right=3425 ,bottom=72 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

<B>id=default ,left=0,top=0 ,right=4100 ,bottom=225 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=620 ,top=160 ,right=855 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3470 ,top=162 ,right=3713 ,bottom=220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3470 ,top=100 ,right=3713 ,bottom=155 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2205 ,top=160 ,right=2528 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=613 ,top=0 ,right=613 ,bottom=222 </L>
	<L> left=2555 ,top=0 ,right=2555 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=253 ,top=0 ,right=253 ,bottom=222 </L>
	<C>id='{decode(P21000,0,'',P21000)}', left=878, top=0, right=1113, bottom=50, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P25000,0,'',P25000)}', left=1135, top=0, right=1373, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P29000,0,'',P29000)}', left=1395, top=0, right=1648, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P37000,0,'',P37000)}', left=1673, top=0, right=1923, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P39000,0,'',P39000)}', left=1953, top=0, right=2200, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0020,0,'',PX0020)}', left=2278, top=0, right=2528, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SENUM', left=2580, top=0, right=2830, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STRTDT', left=3738, top=0, right=3970, bottom=50, align='right' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P22000,0,'',P22000)}', left=878, top=55, right=1113, bottom=105, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P26000,0,'',P26000)}', left=1138, top=55, right=1373, bottom=102, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P30000,0,'',P30000)}', left=1395, top=55, right=1648, bottom=102, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P36000,0,'',P36000)}', left=1673, top=55, right=1923, bottom=102, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0010,0,'',PX0010)}', left=1953, top=55, right=2200, bottom=102, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P23000,0,'',P23000)}', left=875, top=105, right=1113, bottom=155, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P27000,0,'',P27000)}', left=1135, top=105, right=1373, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P31000,0,'',P31000)}', left=1388, top=105, right=1645, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P38000,0,'',P38000)}', left=1665, top=105, right=1915, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P24000,0,'',P24000)}', left=878, top=160, right=1113, bottom=212, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P28000,0,'',P28000)}', left=1138, top=160, right=1373, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P32000,0,'',P32000)}', left=1395, top=160, right=1648, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P35000,0,'',P35000)}', left=1673, top=160, right=1923, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0030,0,'',PX0030)}', left=2278, top=55, right=2528, bottom=105, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='GRSTRTDT', left=3738, top=55, right=3970, bottom=110, align='right' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PX0040,0,'',PX0040)}', left=2278, top=105, right=2528, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(TRAINYN,1,'수습',2,'')}', left=3735, top=105, right=3965, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S91000,0,'',S91000)}', left=2215, top=160, right=2525, bottom=210, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='', left=3738, top=160, right=3970, bottom=210, align='left' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(S94000,0,'',S94000)}', left=3475, top=162, right=3710, bottom=215, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(S93000,0,'',S93000)}', left=3473, top=100, right=3705, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<L> left=25 ,top=225 ,right=4003 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=25 ,top=0 ,right=25 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,'',EMPNO)}', left=38, top=0, right=250, bottom=50, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'',EMPNMK)}', left=38, top=55, right=250, bottom=102, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'소계',PAYGRDNM)}', left=38, top=105, right=250, bottom=155, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'',PAYSEQNM)}', left=38, top=162, right=250, bottom=215, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P10000,0,'',P10000)}', left=628, top=0, right=853, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P12000,0,'',P12000)}', left=628, top=105, right=853, bottom=155, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{P10000+P11000+P12000}', left=628, top=160, right=853, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{decode(P11000,0,'',P11000)}', left=628, top=55, right=853, bottom=102, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(empno)-1,'')}', left=265, top=112, right=475, bottom=162, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='{decode(curlevel,1,,DEPTNM)}', left=265, top=12, right=613, bottom=60, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
	<C>id='{decode(curlevel,1,'명')}', left=495, top=112, right=540, bottom=162, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P34000,0,'',P34000)}', left=1953, top=105, right=2200, bottom=152, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T12000,0,'',T12000)}', left=2580, top=110, right=2830, bottom=162, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T11000,0,'',T11000)}', left=2580, top=55, right=2830, bottom=105, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B11000,0,'',B11000)}', left=2580, top=165, right=2830, bottom=220, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B13000,0,'',B13000)}', left=2838, top=55, right=3135, bottom=105, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B15000,0,'',B15000)}', left=2838, top=110, right=3135, bottom=162, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B12000,0,'',B12000)}', left=2838, top=0, right=3135, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B14000,0,'',B14000)}', left=2838, top=170, right=3135, bottom=220, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(APLAMT+APLRAT,0,'',APLAMT+APLRAT)}', left=3175, top=110, right=3425, bottom=162, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(BX0020,0,'',BX0020)}', left=3188, top=170, right=3425, bottom=220, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(B16000,0,'',B16000)}', left=3188, top=0, right=3425, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(BX0010,0,'',BX0010)}', left=3190, top=55, right=3425, bottom=105, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T22000,0,'',T22000)}', left=3470, top=52, right=3705, bottom=97, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T21000,0,'',T21000)}', left=3470, top=0, right=3705, bottom=47, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>

<B>id=Tail ,left=0,top=0 ,right=4100 ,bottom=255 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=620 ,top=177 ,right=855 ,bottom=227 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3463 ,top=180 ,right=3713 ,bottom=227 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3463 ,top=127 ,right=3713 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2215 ,top=180 ,right=2535 ,bottom=230 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=25 ,top=0 ,right=25 ,bottom=227 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2555 ,top=0 ,right=2555 ,bottom=227 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=253 ,top=0 ,right=253 ,bottom=227 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=227 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='총원' ,left=280 ,top=130 ,right=423 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합 계' ,left=50 ,top=130 ,right=220 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=395 ,top=130 ,right=515 ,bottom=180 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<L> left=4005 ,top=0 ,right=30 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{SUM(S91000)}' ,left=2220 ,top=177 ,right=2528 ,bottom=227 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(S94000)}' ,left=3465 ,top=177 ,right=3705 ,bottom=227 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<L> left=4000 ,top=240 ,right=25 ,bottom=240 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='명' ,left=520 ,top=130 ,right=573 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=613 ,top=0 ,right=613 ,bottom=227 </L>
	<S>id='{Sum(P25000)}' ,left=1130 ,top=12 ,right=1373 ,bottom=62 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P29000)}' ,left=1398 ,top=15 ,right=1648 ,bottom=62 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P37000)}' ,left=1670 ,top=15 ,right=1920 ,bottom=62 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P39000)}' ,left=1945 ,top=15 ,right=2195 ,bottom=62 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P36000)}' ,left=1670 ,top=62 ,right=1920 ,bottom=115 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P38000)}' ,left=1670 ,top=120 ,right=1920 ,bottom=170 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P35000)}' ,left=1670 ,top=172 ,right=1920 ,bottom=222 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P30000)}' ,left=1398 ,top=70 ,right=1648 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P31000)}' ,left=1398 ,top=125 ,right=1648 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P32000)}' ,left=1398 ,top=177 ,right=1648 ,bottom=227 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P26000)}' ,left=1130 ,top=65 ,right=1373 ,bottom=120 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P27000)}' ,left=1130 ,top=122 ,right=1373 ,bottom=172 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P28000)}' ,left=1130 ,top=175 ,right=1373 ,bottom=225 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P24000)}' ,left=870 ,top=185 ,right=1110 ,bottom=230 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P23000)}' ,left=870 ,top=127 ,right=1110 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P22000)}' ,left=870 ,top=72 ,right=1110 ,bottom=120 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P21000)}' ,left=870 ,top=20 ,right=1110 ,bottom=65 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(PX0020)}', left=2215, top=15, right=2528, bottom=65, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(S93000)}' ,left=3465 ,top=127 ,right=3705 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<C>id='{Sum(BX0020)}', left=3163, top=177, right=3410, bottom=227, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(T21000)}', left=3473, top=12, right=3705, bottom=62, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(T22000)}', left=3473, top=72, right=3705, bottom=122, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(P10000)}' ,left=630 ,top=15 ,right=850 ,bottom=62 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P11000)}' ,left=630 ,top=70 ,right=850 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P12000)}' ,left=630 ,top=125 ,right=850 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(P10000)+SUM(P11000)+SUM(P12000)}', left=630, top=180, right=850, bottom=215, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{Sum(PX0010)}', left=1945, top=65, right=2195, bottom=120, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{Sum(P34000)}', left=1945, top=122, right=2195, bottom=175, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<S>id='{Sum(T12000)}' ,left=2578 ,top=120 ,right=2828 ,bottom=170 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(T11000)}' ,left=2578 ,top=65 ,right=2828 ,bottom=115 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B11000)}' ,left=2578 ,top=172 ,right=2828 ,bottom=220 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(PX0040)}', left=2215, top=122, right=2528, bottom=172, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(PX0030)}', left=2215, top=70, right=2528, bottom=120, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(B15000)}' ,left=2830 ,top=120 ,right=3135 ,bottom=170 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B13000)}' ,left=2830 ,top=65 ,right=3135 ,bottom=115 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(B12000)}' ,left=2830 ,top=15 ,right=3135 ,bottom=70 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(B14000)}' ,left=2830 ,top=172 ,right=3135 ,bottom=220 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(B16000)}' ,left=3173 ,top=15 ,right=3410 ,bottom=70 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(BX0010)}' ,left=3173 ,top=72 ,right=3410 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(APLAMT)+SUM(APLRAT)}', left=3160, top=125, right=3410, bottom=175, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>

<B>id=Footer ,left=0 ,top=2761 ,right=4100 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=34 ,top=19 ,right=4006 ,bottom=97 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=3597 ,top=9 ,right=3978 ,bottom=109</I>
	<L> left=25 ,top=6 ,right=4006 ,bottom=6 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 계약급여 ####
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param NAME="DetailDataID"			VALUE="gcds_grid_ec02az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format"						VALUE="
<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=180 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1376, top=56, right=2725, bottom=143, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000</C>
	<T>id='단위 : 원' ,left=3784 ,top=122 ,right=4001 ,bottom=180 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3784, top=61, right=4001, bottom=119, align='right' ,mask='XXXX.XX.XX', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=3485 ,top=61 ,right=3781 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=259 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3998 ,top=3 ,right=24 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=614 ,top=3 ,right=614 ,bottom=249 </L>
	<L> left=254 ,top=3 ,right=254 ,bottom=249 </L>
	<T>id='배부자장경' ,left=2580 ,top=13 ,right=2831 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=638 ,top=13 ,right=878 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=3 ,right=24 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2553 ,top=5 ,right=2553 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='계' ,left=635 ,top=191 ,right=878 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장수당' ,left=902 ,top=13 ,right=1207 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급계' ,left=2254 ,top=191 ,right=2529 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='북측근무수당' ,left=902 ,top=74 ,right=1207 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=275 ,top=13 ,right=556 ,bottom=71 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=249 ,right=4006 ,bottom=249 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사번' ,left=37 ,top=13 ,right=249 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=37 ,top=130 ,right=249 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급호' ,left=37 ,top=191 ,right=249 ,bottom=249 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=37 ,top=74 ,right=249 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=1913 ,top=13 ,right=2196 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=638 ,top=74 ,right=878 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=2836 ,top=130 ,right=3135 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성과금' ,left=902 ,top=124 ,right=1207 ,bottom=180 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=638 ,top=127 ,right=876 ,bottom=191 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=905 ,top=185 ,right=1209 ,bottom=238 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유지비' ,left=1344 ,top=13 ,right=1646 ,bottom=66 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PR0030,,기타지급2,PR0030)}', left=1265, top=74, right=1648, bottom=127, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='조장수당' ,left=1341 ,top=124 ,right=1646 ,bottom=177 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 연차수당' ,left=1341 ,top=185 ,right=1646 ,bottom=238 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급1' ,left=1913 ,top=74 ,right=2196 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급2' ,left=1913 ,top=124 ,right=2196 ,bottom=177 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='최종변동일' ,left=275 ,top=74 ,right=556 ,bottom=130 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=2580 ,top=130 ,right=2831 ,bottom=188 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실수령액' ,left=3776 ,top=191 ,right=3987 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제계' ,left=3776 ,top=130 ,right=3987 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정산주민세' ,left=3715 ,top=74 ,right=3987 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정산소득세' ,left=3715 ,top=13 ,right=3987 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=2836 ,top=13 ,right=3135 ,bottom=66 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=2580 ,top=74 ,right=2831 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=2836 ,top=74 ,right=3135 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BR0020,,기타공제1,BR0020)}', left=3424, top=13, right=3691, bottom=66, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='보증보험' ,left=3141 ,top=13 ,right=3408 ,bottom=69 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BR0030,,기타공제2,BR0030)}', left=3141, top=130, right=3408, bottom=183, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='공조회비' ,left=3141 ,top=74 ,right=3408 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BR0040,,기타공제3,BR0040)}', left=3141, top=188, right=3408, bottom=241, align='right', face='HY중고딕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='공조회대출' ,left=3424 ,top=74 ,right=3691 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=227 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=3749 ,top=101 ,right=3993 ,bottom=156 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=619 ,top=159 ,right=886 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3749 ,top=161 ,right=3993 ,bottom=220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2207 ,top=159 ,right=2527 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=614 ,top=0 ,right=614 ,bottom=222 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=222 </L>
	<C>id='SENUM', left=2580, top=0, right=2831, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(B13000,0,,B13000)}', left=2839, top=106, right=3133, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S91000,0,,S91000)}', left=2217, top=159, right=2524, bottom=209, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=24 ,top=225 ,right=4003 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,,EMPNO)}', left=37, top=0, right=249, bottom=50, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,EMPNMK)}', left=37, top=56, right=249, bottom=103, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'소계\',JOBKINDNM)}', left=37, top=106, right=249, bottom=156, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,PAYSEQNM)}', left=143, top=161, right=249, bottom=217, align='left', supplevel=2, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P10000,0,,P10000)}', left=630, top=0, right=884, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P10000+P12000+P28000,0,,P10000+P12000+P28000)}', left=630, top=159, right=884, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{decode(P39000,0,,P39000)}', left=1913, top=0, right=2196, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P12000,0,,P12000)}', left=630, top=56, right=884, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GRDDIVNM', left=37, top=161, right=119, bottom=217, align='right', supplevel=2, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'/\')}', left=119, top=161, right=143, bottom=217, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,DEPTNM)}', left=267, top=8, right=614, bottom=58, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='{decode(P38000,0,,P38000)}', left=902, top=111, right=1207, bottom=161, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P31000,0,,P31000)}', left=902, top=56, right=1207, bottom=106, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P30000,0,,P30000)}', left=902, top=0, right=1207, bottom=50, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PX0030,0,,PX0030)}', left=1265, top=56, right=1648, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P28000,0,,P28000)}', left=627, top=103, right=884, bottom=153, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P24000,0,,P24000)}', left=1265, top=0, right=1646, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P27000,0,,P27000)}', left=1267, top=111, right=1648, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P34000,0,,P34000)}', left=1267, top=167, right=1648, bottom=214, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PX0020,0,,PX0020)}', left=1913, top=56, right=2196, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PX0040,0,,PX0040)}', left=1913, top=111, right=2196, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P35000,0,,P35000)}', left=902, top=167, right=1207, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'명\',\' \')}', left=495, top=56, right=540, bottom=106, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(empno)-1,)}', left=267, top=56, right=474, bottom=106, align='right', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CHAGDT', left=267, top=106, right=497, bottom=156, align='right' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S93000,0,,S93000)}', left=3754, top=101, right=3987, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{decode(T22000,0,,T22000)}', left=3752, top=53, right=3987, bottom=98, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(T21000,0,,T21000)}', left=3752, top=0, right=3987, bottom=48, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S94000,0,,S94000)}', left=3752, top=161, right=3987, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{decode(B11000,0,,B11000)}', left=2839, top=53, right=3133, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(B12000,0,,B12000)}', left=2839, top=0, right=3133, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T11000,0,,T11000)}', left=2580, top=53, right=2831, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T12000,0,,T12000)}', left=2580, top=106, right=2831, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0040,0,,BX0040)}', left=3141, top=159, right=3408, bottom=209, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0030,0,,BX0030)}', left=3141, top=106, right=3408, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0010,0,,BX0010)}', left=3141, top=0, right=3408, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(B16000,0,,B16000)}', left=3141, top=53, right=3408, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BX0020,0,,BX0020)}', left=3424, top=0, right=3691, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(COAAMT+COLAMT,0,,COAAMT+COLAMT)}', left=3424, top=53, right=3691, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=4101 ,bottom=252 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=180 ,right=886 ,bottom=228 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3741 ,top=183 ,right=3993 ,bottom=228 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3741 ,top=130 ,right=3993 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2217 ,top=183 ,right=2532 ,bottom=233 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=24 ,top=0 ,right=24 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=228 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=228 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='총원' ,left=283 ,top=132 ,right=421 ,bottom=183 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합 계' ,left=50 ,top=132 ,right=220 ,bottom=183 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=394 ,top=132 ,right=516 ,bottom=183 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=4006 ,top=0 ,right=32 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{Sum(S91000)}' ,left=2220 ,top=180 ,right=2527 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<L> left=3998 ,top=241 ,right=24 ,bottom=241 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='명' ,left=519 ,top=132 ,right=572 ,bottom=183 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=614 ,top=0 ,right=614 ,bottom=228 </L>
	<S>id='{Sum(P10000)}' ,left=632 ,top=16 ,right=881 ,bottom=64 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</S>
	<S>id='{Sum(P12000)}' ,left=632 ,top=69 ,right=881 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<C>id='{SUM(P10000)+SUM(P12000)+SUM(P28000)}', left=632, top=185, right=881, bottom=220, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<S>id='{Sum(P39000)}' ,left=1913 ,top=16 ,right=2193 ,bottom=64 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</S>
	<S>id='{Sum(SENUM)}' ,left=2577 ,top=16 ,right=2828 ,bottom=66 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P38000)}' ,left=902 ,top=124 ,right=1207 ,bottom=172 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P31000)}' ,left=902 ,top=71 ,right=1207 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P30000)}' ,left=902 ,top=19 ,right=1207 ,bottom=66 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(PX0030)}' ,left=1265 ,top=69 ,right=1648 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P28000)}' ,left=632 ,top=122 ,right=881 ,bottom=169 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P35000)}' ,left=900 ,top=172 ,right=1204 ,bottom=220 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(PX0020)}' ,left=1913 ,top=69 ,right=2193 ,bottom=116 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(PX0040)}' ,left=1913 ,top=124 ,right=2193 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P24000)}' ,left=1265 ,top=19 ,right=1648 ,bottom=66 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(P27000)}' ,left=1265 ,top=124 ,right=1648 ,bottom=172 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<C>id='{Sum(P34000)}', left=1265, top=172, right=1648, bottom=225, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{Sum(T21000)}', left=3757, top=13, right=3987, bottom=64, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(T22000)}', left=3757, top=71, right=3987, bottom=122, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<S>id='{Sum(S93000)}' ,left=3747 ,top=130 ,right=3987 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<S>id='{Sum(S94000)}' ,left=3747 ,top=180 ,right=3987 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<S>id='{Sum(T11000)}' ,left=2577 ,top=69 ,right=2828 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(T12000)}' ,left=2577 ,top=124 ,right=2828 ,bottom=172 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(B11000)}' ,left=2831 ,top=69 ,right=3133 ,bottom=116 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(B12000)}' ,left=2831 ,top=16 ,right=3133 ,bottom=69 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BX0010)}' ,left=3172 ,top=16 ,right=3408 ,bottom=66 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BX0030)}' ,left=3172 ,top=124 ,right=3408 ,bottom=177 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(B16000)}' ,left=3172 ,top=69 ,right=3408 ,bottom=116 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BX0040)}' ,left=3172 ,top=180 ,right=3408 ,bottom=233 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(B13000)}' ,left=2831 ,top=124 ,right=3133 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(B17000)}' ,left=2831 ,top=180 ,right=3133 ,bottom=230 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BX0020)}' ,left=3434 ,top=16 ,right=3702 ,bottom=64 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<C>id='{SUM(COAAMT)+SUM(COLAMT)}', left=3434, top=69, right=3702, bottom=119, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=Footer ,left=0 ,top=2761 ,right=4101 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=34 ,top=19 ,right=4006 ,bottom=98 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=3625 ,top=8 ,right=4006 ,bottom=108</I>
	<L> left=24 ,top=5 ,right=4006 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>


">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>

</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	

	<!--  <T>id='특별상여' ,left=274 ,top=74 ,right=556 ,bottom=127 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>  

	
	<T>id='지급율' ,left=274 ,top=129 ,right=556 ,bottom=185 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	 	<C>id='{decode(curlevel,1,,TIMAMT)}', left=266, top=63, right=550, bottom=111, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			
			
			<C>id='{decode(curlevel,1,subcount(empno)-1,SANGRAT)}', left=266, top=116, right=474, bottom=166, align='right', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
		<C>id='{decode(curlevel,1,'',CHAGDT)}', left=265, top=62, right=525, bottom=110, align='left', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	-->
