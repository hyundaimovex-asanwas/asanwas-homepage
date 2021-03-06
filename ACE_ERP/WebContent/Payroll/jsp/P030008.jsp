<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 연말정산관리 - 원천징수부수정
+ 프로그램 ID	: P030008.HTML
+ 기 능 정 의	: 조회,저장,삭제
+ 변 경 이 력	: 
+ 서 블 릿 명	: p030008_s1, (연말정산내역조회와 동일한 서블릿을 사용함.)
                p030008_t1 : 
-----------------------------------------------------------------------------
+ 변 경 내 용	: 금강산/개성 급여를 소득외 급여로 추가한다.
+ 변 경 일 자	: 2010.01.05
+ 변  경   자 : JYS             
------------------------------------------------------------------------------>
<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>원천징수부수정</title>
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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);
var gs_date3 = gcurdate.substr(0,4);
var gs_level;
var gs_treecd;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	
	//gcem_curdt.text = gcurdate.substr(0,4);	//귀속년도
	gcem_curdt.text ="2009";	//귀속년도
	ln_Before();	//선조회


	ln_Disp(gcgd_assess,'gcds_assess');
	ln_Disp(gcgd_specialst,'gcds_specialst');
	ln_Disp(gcgd_humanst,'gcds_humanst');
	ln_Disp(gcgd_exc,'gcds_exc');

}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	if (gcem_curdt.text=="") {
		alert("귀속년도는 필수항목입니다.");
		gcem_curdt.setFocus();
	}

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030008_s1?v_str1=" + gcem_curdt.text
														                           + "&v_str2=" + gclx_deptcd.bindcolval
													                           	 + "&v_str3=" + fn_trim(txt_empnmk1.value)
													                          	 + "&v_str4=" + gs_level
														                           + "&v_str5=" + gs_treecd;
	gcds_data.Reset();   
 }

/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Before(){

	//소속코드[검색]
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_dept1.Reset();

	//소속코드
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
	if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {

		ln_Sum01();	//근로소득지급명세 계산식
		ln_Sum02(); //비과세소득 계산식
		ln_Sum03();	//근로소득원청징수 계산식

		if(ln_Chk()){
			if (confirm("저장하시겠습니까?")) {
					gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030008_t1";
					gctr_data.post();
			}
		}//if ln_Chk
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
       gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030008_t1";
		gctr_data.post();
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력 - 소득자별근로소득원천징수
******************************************************************************/
function ln_PrintLevy() {
	var str1 = fn_trim(txt_empnmk1.value);	//사번
	var str2 = gcem_curdt.text;							//귀속년도
	if (gcds_data.countrow<1) {	alert("출력하실 자료가 없습니다");
	}else{
		gcds_print.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030008_s3?v_str1="+str1
																													+"&v_str2="+str2
																													+"&v_str3="+gs_date
																													+"&v_str4="+gclx_deptcd.bindcolval;
		gcds_print.Reset();
	}
}
	
/******************************************************************************											
Description : 엑셀																								
******************************************************************************/										
function ln_Excel(){	

}

/******************************************************************************	
 Description : Check																																													
******************************************************************************/												
function ln_Chk(){													
	if (gcds_data.IsUpdated) {													
		return true; 																								
	}else{																								
		alert("변경된 사항이 없습니다");														
		return false;															
	}							
}																		
/*****************************************************************************													
	Description : 입력항목 표시유무
******************************************************************************/
function ln_Disp(Obj,e){
/*
	if (e=="gcds_humanst" && gcds_humanst.countrow<1) ln_SerHuman();					//인적공제
	else if (e=="gcds_specialst" && gcds_specialst.countrow<1) ln_SerSpe();	    //특별공제
	else if (e=="gcds_aninsur" && gcds_aninsur.countrow<1) ln_SerAnnu();		    //연금보험공제
	else if (e=="gcds_income" && gcds_income.countrow<1) ln_Income();			  		//기타소득공제
	else if (e=="gcds_assess" && gcds_assess.countrow<1) ln_Assess();				    //세액감면 및 세액공제
*/

	if(Obj.style.display=="none") Obj.style.display="block";
	else Obj.style.display="none";
	
}

/******************************************************************************	
 Description : 근로소득지급명세 계산식
******************************************************************************/												
function ln_Sum01(){		
	//근로소득지급명세(급여계+상여계=합계)
	gcds_data.namevalue(gcds_data.rowposition,"INC01004") = Number(gcem_inc01001.text)+Number(gcem_inc01002.text)+Number(gcem_inc01003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC02004") = Number(gcem_inc02001.text)+Number(gcem_inc02002.text)+Number(gcem_inc02003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC03004") = Number(gcem_inc03001.text)+Number(gcem_inc03002.text)+Number(gcem_inc03003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC04004") = Number(gcem_inc04001.text)+Number(gcem_inc04002.text)+Number(gcem_inc04003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC05004") = Number(gcem_inc05001.text)+Number(gcem_inc05002.text)+Number(gcem_inc05003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC06004") = Number(gcem_inc06001.text)+Number(gcem_inc06002.text)+Number(gcem_inc06003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC07004") = Number(gcem_inc07001.text)+Number(gcem_inc07002.text)+Number(gcem_inc07003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC08004") = Number(gcem_inc08001.text)+Number(gcem_inc08002.text)+Number(gcem_inc08003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC09004") = Number(gcem_inc09001.text)+Number(gcem_inc09002.text)+Number(gcem_inc09003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC10004") = Number(gcem_inc10001.text)+Number(gcem_inc10002.text)+Number(gcem_inc10003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC11004") = Number(gcem_inc11001.text)+Number(gcem_inc11002.text)+Number(gcem_inc11003.text);
	gcds_data.namevalue(gcds_data.rowposition,"INC12004") = Number(gcem_inc12001.text)+Number(gcem_inc12002.text)+Number(gcem_inc12003.text);

	//급여총계
	gcds_data.namevalue(gcds_data.rowposition,"SINC001")  = Number(gcem_inc01001.text)+Number(gcem_inc02001.text)+
																													Number(gcem_inc03001.text)+Number(gcem_inc04001.text)+
																													Number(gcem_inc05001.text)+Number(gcem_inc06001.text)+
																													Number(gcem_inc07001.text)+Number(gcem_inc08001.text)+
																													Number(gcem_inc09001.text)+Number(gcem_inc10001.text)+
																													Number(gcem_inc11001.text)+Number(gcem_inc12001.text);
	//상여총계
	gcds_data.namevalue(gcds_data.rowposition,"SINC002")  = Number(gcem_inc01002.text)+Number(gcem_inc02002.text)+
																													Number(gcem_inc03002.text)+Number(gcem_inc04002.text)+
																													Number(gcem_inc05002.text)+Number(gcem_inc06002.text)+
																													Number(gcem_inc07002.text)+Number(gcem_inc08002.text)+
																													Number(gcem_inc09002.text)+Number(gcem_inc10002.text)+
																													Number(gcem_inc11002.text)+Number(gcem_inc12002.text);
	//인정상여계
	gcds_data.namevalue(gcds_data.rowposition,"SINC003")  = Number(gcem_inc01003.text)+Number(gcem_inc02003.text)+
																													Number(gcem_inc03003.text)+Number(gcem_inc04003.text)+
																													Number(gcem_inc05003.text)+Number(gcem_inc06003.text)+
																													Number(gcem_inc07003.text)+Number(gcem_inc08003.text)+
																													Number(gcem_inc09003.text)+Number(gcem_inc10003.text)+
																													Number(gcem_inc11003.text)+Number(gcem_inc12003.text);
	//급여+상여+인정상여=총계
	gcds_data.namevalue(gcds_data.rowposition,"SINC004")  = Number(gcem_inc01004.text)+Number(gcem_inc02004.text)+
																													Number(gcem_inc03004.text)+Number(gcem_inc04004.text)+
																													Number(gcem_inc05004.text)+Number(gcem_inc06004.text)+
																													Number(gcem_inc07004.text)+Number(gcem_inc08004.text)+
																													Number(gcem_inc09004.text)+Number(gcem_inc10004.text)+
																													Number(gcem_inc11004.text)+Number(gcem_inc12004.text);
	//간이세액표에 의한 소득세 총계
	gcds_data.namevalue(gcds_data.rowposition,"SINC005")  = Number(gcem_inc01005.text)+Number(gcem_inc02005.text)+
																													Number(gcem_inc03005.text)+Number(gcem_inc04005.text)+
																													Number(gcem_inc05005.text)+Number(gcem_inc06005.text)+
																													Number(gcem_inc07005.text)+Number(gcem_inc08005.text)+
																													Number(gcem_inc09005.text)+Number(gcem_inc10005.text)+
																													Number(gcem_inc11005.text)+Number(gcem_inc12005.text);
}

/******************************************************************************	
 Description : 비과세소득 계산식
******************************************************************************/		
function ln_Sum02(){	

	//외화계
	gcds_data.namevalue(gcds_data.rowposition,"SFRE001")  = Number(gcem_fre01001.text)+Number(gcem_fre02001.text)+
																													Number(gcem_fre03001.text)+Number(gcem_fre04001.text)+
																													Number(gcem_fre05001.text)+Number(gcem_fre06001.text)+
																													Number(gcem_fre07001.text)+Number(gcem_fre08001.text)+
																													Number(gcem_fre09001.text)+Number(gcem_fre10001.text)+
																													Number(gcem_fre11001.text)+Number(gcem_fre12001.text);
	//원화계
	gcds_data.namevalue(gcds_data.rowposition,"SFRE002")  = Number(gcem_fre01002.text)+Number(gcem_fre02002.text)+
																													Number(gcem_fre03002.text)+Number(gcem_fre04002.text)+
																													Number(gcem_fre05002.text)+Number(gcem_fre06002.text)+
																													Number(gcem_fre07002.text)+Number(gcem_fre08002.text)+
																													Number(gcem_fre09002.text)+Number(gcem_fre10002.text)+
																													Number(gcem_fre11002.text)+Number(gcem_fre12002.text);
	//생산직근로자야간근로수당등 계
	gcds_data.namevalue(gcds_data.rowposition,"SFRE003")  = Number(gcem_fre01003.text)+Number(gcem_fre02003.text)+
																													Number(gcem_fre03003.text)+Number(gcem_fre04003.text)+
																													Number(gcem_fre05003.text)+Number(gcem_fre06003.text)+
																													Number(gcem_fre07003.text)+Number(gcem_fre08003.text)+
																													Number(gcem_fre09003.text)+Number(gcem_fre10003.text)+
																													Number(gcem_fre11003.text)+Number(gcem_fre12003.text);
	//금액계
	gcds_data.namevalue(gcds_data.rowposition,"SFRE005")  = Number(gcem_fre01005.text)+Number(gcem_fre02005.text)+
																													Number(gcem_fre03005.text)+Number(gcem_fre04005.text)+
																													Number(gcem_fre05005.text)+Number(gcem_fre06005.text)+
																													Number(gcem_fre07005.text)+Number(gcem_fre08005.text)+
																													Number(gcem_fre09005.text)+Number(gcem_fre10005.text)+
																													Number(gcem_fre11005.text)+Number(gcem_fre12005.text);
}

/******************************************************************************	
 Description : 근로소득원천징수 계산식
******************************************************************************/		
function ln_Sum03(){	
	
	//소득세계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL002")	= Number(gcem_col01002.text)+Number(gcem_col02002.text)+
																													Number(gcem_col03002.text)+Number(gcem_col04002.text)+
																													Number(gcem_col05002.text)+Number(gcem_col06002.text)+
																													Number(gcem_col07002.text)+Number(gcem_col08002.text)+
																													Number(gcem_col09002.text)+Number(gcem_col10002.text)+
																													Number(gcem_col11002.text)+Number(gcem_col12002.text);
	//주민세계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL003")	= Number(gcem_col01003.text)+Number(gcem_col02003.text)+
																													Number(gcem_col03003.text)+Number(gcem_col04003.text)+
																													Number(gcem_col05003.text)+Number(gcem_col06003.text)+
																													Number(gcem_col07003.text)+Number(gcem_col08003.text)+
																													Number(gcem_col09003.text)+Number(gcem_col10003.text)+
																													Number(gcem_col11003.text)+Number(gcem_col12003.text);
	//농촌특별세계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL004")	= Number(gcem_col01004.text)+Number(gcem_col02004.text)+
																													Number(gcem_col03004.text)+Number(gcem_col04004.text)+
																													Number(gcem_col05004.text)+Number(gcem_col06004.text)+
																													Number(gcem_col07004.text)+Number(gcem_col08004.text)+
																													Number(gcem_col09004.text)+Number(gcem_col10004.text)+
																													Number(gcem_col11004.text)+Number(gcem_col12004.text);
	//연금보험계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL005")	= Number(gcem_col01005.text)+Number(gcem_col02005.text)+
																													Number(gcem_col03005.text)+Number(gcem_col04005.text)+
																													Number(gcem_col05005.text)+Number(gcem_col06005.text)+
																													Number(gcem_col07005.text)+Number(gcem_col08005.text)+
																													Number(gcem_col09005.text)+Number(gcem_col10005.text)+
																													Number(gcem_col11005.text)+Number(gcem_col12005.text);
	//건강보험계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL006")	= Number(gcem_col01006.text)+Number(gcem_col02006.text)+
																													Number(gcem_col03006.text)+Number(gcem_col04006.text)+
																													Number(gcem_col05006.text)+Number(gcem_col06006.text)+
																													Number(gcem_col07006.text)+Number(gcem_col08006.text)+
																													Number(gcem_col09006.text)+Number(gcem_col10006.text)+
																													Number(gcem_col11006.text)+Number(gcem_col12006.text);
	//고용보험계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL007")	= Number(gcem_col01007.text)+Number(gcem_col02007.text)+
																													Number(gcem_col03007.text)+Number(gcem_col04007.text)+
																													Number(gcem_col05007.text)+Number(gcem_col06007.text)+
																													Number(gcem_col07007.text)+Number(gcem_col08007.text)+
																													Number(gcem_col09007.text)+Number(gcem_col10007.text)+
																													Number(gcem_col11007.text)+Number(gcem_col12007.text);
	//기부금계
	gcds_data.namevalue(gcds_data.rowposition,"SCOL008")	= Number(gcem_col01008.text)+Number(gcem_col02008.text)+
																													Number(gcem_col03008.text)+Number(gcem_col04008.text)+
																													Number(gcem_col05008.text)+Number(gcem_col06008.text)+
																													Number(gcem_col07008.text)+Number(gcem_col08008.text)+
																													Number(gcem_col09008.text)+Number(gcem_col10008.text)+
																													Number(gcem_col11008.text)+Number(gcem_col12008.text);
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- 소속 [검색]-->
<comment id="__NSID__"><OBJECT id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 소속 -->
<comment id="__NSID__"><OBJECT id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 직위 -->
<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print2h classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p030008_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

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
	window.status = " 조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	
	if (rowcount <1 ) { alert("검색된 데이타가 없습니다.");  
	}else{	
		ln_Sum01();	//근로소득지급명세 계산식
		ln_Sum02(); //비과세소득 계산식
		ln_Sum03();	//근로소득원청징수 계산식
	}
</script>

<script language="javascript" for="gcds_print" event="OnLoadStarted()">
	window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_print" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if (gcds_print.countrow<1) {	
		alert("출력하실 자료가 없습니다");
	}else{ 
		gcrp_print.preview(); 
	}//'소득자별근로소득원천징수부' REPORT 미리보기
</script>

<script language="javascript" for="gcgd_create" event="OnClick()">
	ln_Sum01();	//근로소득지급명세 계산식
	ln_Sum02(); //비과세소득 계산식
	ln_Sum03();	//근로소득원청징수 계산식
</script>

<script language="javascript" for="gcgd_create" event="onKeyPress(keycode)">
	ln_Sum01();	//근로소득지급명세 계산식
	ln_Sum02(); //비과세소득 계산식
	ln_Sum03();	//근로소득원청징수 계산식
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
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gctr_data.ErrorMsg);
</script>

</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030008_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
		<!-- <img src="../../Common/img/btn/com_b_levy.gif"				style="cursor:hand" onclick="ln_PrintLevy()"> -->
		<!--<img src="../../Common/img/btn/com_b_mediexp.gif"			style="cursor:hand" onclick="ln_Print2()">-->
		<!--<img src="../../Common/img/btn/com_b_contribute.gif"	style="cursor:hand" onclick="ln_Print3()">-->
			<img src="../../Common/img/btn/com_b_delete.gif"			style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_save.gif"				style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"				style="cursor:hand" onclick="ln_Query()"></nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;귀속년도&nbsp;&nbsp;</nobr>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; "   >
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY">
							<param name=MaxLength     value=4>
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td>	

					<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;소 속&nbsp;&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
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
					<td><nobr>&nbsp;
						<input id="txt_empnmk1" name="txt_empnmk1" type="text"  style="width:70px; height:18px;position:relative;top:0px;left:-5px" onKeydown="if(event.keyCode==13) ln_Query()">
					</nobr></td>
						<td width="100%" align=RIGHT >&nbsp;&nbsp;</td>
					<td style="padding-top:4px;"></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3>  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:376px" valign=top>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  style="WIDTH: 230px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"    VALUE="Left">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='귀속년도' ID=YYYY  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=60	align=center  mask='XXXX' </C> 
							<C> Name='소속'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=100 align=left		sort=true</C> 
							<C> Name='성명'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC	Width=65	align=left		sort=true</C>
							<C> Name='사번'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=50	align=center	sort=true</C>								
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:232px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>
					</td>
          <td>&nbsp;</td>
					<td STYLE="PADDING-TOP:0px;" valign=top>
					
			<table width="500" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
						<table border= "0"  cellpadding=0 cellspacing=0  border=0  style='width:638px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
							<tr>
								<td style="height:25px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;귀속년도</td>
								<td style="border:1 solid #708090;border-left-width:0px;padding-top:0px;padding-left:6px" colspan=2>
									<comment id="__NSID__"><object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
										<param name=Text          value="">
										<param name=Border	      value=True>
										<param name=Format	      value="YYYY">
										<param name=MaxLength     value=4>
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=enable		    value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="height:20px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;사번</td>
								<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
									<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px; width:50px; height:20px; font-family:굴림; font-size:9pt; "   > 
		            		<param name=Text          value="">
		            		<param name=Alignment	  value=1>
	            			<param name=Border	      value=true>
				            <param name=Numeric	      value=false>
				            <param name=Format	      value="0000000">
				            <param name=MaxLength     value=7>
				            <param name=PromptChar	  value="_">
				            <param name=IsComma	      value=false>
				            <param name=BackColor     value="#CCCCCC">
				      	    <param name=enable				value=false>
			             </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td style="border:1 solid #708090;border-left-width:0px; " bgcolor="#eeeeee">&nbsp;성명</td>
								<td style="border:1 solid #708090;border-left-width:0px; "  colspan=2>&nbsp;
											<input id="txt_empnmk2" name="txt_empnmk2" type="text"  style="position:relative; left:-6px; width:70px; height:18px;" value="" maxlength=16 readonly>
								</td>
							</tr>
							<tr><td style="height:3px;border:0 solid #708090;" colspan=6></td>
							</tr>
						</table>
					</td>
			</tr>
			<tr><td colspan="2" height=3></td></tr>
			
			<tr> 
				<td colspan="2"> 

<!--------------------------------------------------------------------------------------------
	+ 근로소득지급명세 TAB[1] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_assess,'gcds_assess')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>근로소득지급명세 (*)</b>
					</td>
				</tr>
				<tr>
					<td>
					<div id=gcgd_assess style="position:relative;display:none">
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:512x;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
							<TR>
								<TD width=40 style="height:20;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER >월별</TD>
								<TD width=80 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER>지급연월</TD>
								<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" COLSPAN=4 align=center>총 급 여</TD>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-right-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER >간이세액표에 의한 소득세</TD>
							</TR>
							<TR>	
								<TD  width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>급여액</TD>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>상여액</TD>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>인정상여</TD>
								<TD width=110 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>계</TD>
							</TR>
					
						<!---------------------------------근로소득지금명세--1------------------------------------>
						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align="center">&nbsp;&nbsp;&nbsp;1</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
								<comment id="__NSID__"><object id=gcem_incyy01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Border	      value=True>
									<param name=Numeric	      value=false>
									<param name=Format	      value="YYYY/MM">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=IsComma	      value=false>
									<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_inc01001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_inc01002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_inc01003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>
	
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_inc01004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_inc01005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>

					<!---------------------------------근로소득지금명세--2------------------------------------>
					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	2</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc02001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc02002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc02003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc02004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc02005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--3------------------------------------>
					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	3</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=center height=23>
						<comment id="__NSID__"><object id=gcem_inc03001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;">
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc03002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc03003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc03004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_inc03005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--4------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	4</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc04001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc04002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc04003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc04004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc04005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>

					<!---------------------------------근로소득지금명세--5------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	5</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc05001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc05002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc05003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc05004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc05005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--6------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	6</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy06 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc06001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc06002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc06003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc06004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc06005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--7------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	7</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy07 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc07001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc07002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc07003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc07004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc07005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--8------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee"align=center> 8</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy08 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc08001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc08002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc08003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc08004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc08005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--9------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	9</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_incyy09 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
			      </object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc09001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc09002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc09003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc09004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc09005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--10------------------------------------->

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center> 10</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;"height=23>
						<comment id="__NSID__"><object id=gcem_incyy10 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc10001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc10002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc10003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc10004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc10005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--11------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>11</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;"height=23>
						<comment id="__NSID__"><object id=gcem_incyy11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc11001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc11002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc11003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc11004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc11005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--12------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	12</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;"height=23>
						<comment id="__NSID__"><object id=gcem_incyy12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc12001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc12002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc12003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc12004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc12005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
					<!---------------------------------근로소득지금명세--계------------------------------------>
					 <TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" colspan=2 align=center>&nbsp;계</TD>
						<TD ALIGN=CENTER height=25  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
						<comment id="__NSID__"><object id=gcem_sinc001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="0,000,000,000">
							<param name=Readonly	    value=true>
							<param name=MaxLength     value=10>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=true>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sinc002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sinc003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sinc004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="0,000,000,000">
							<param name=MaxLength     value=10>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sinc005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					</TR>
<!---------------------------------근로소득지금명세--13------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" align=center>13</TD>
						<TD style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px" ALIGN=CENTER">종전근무</TD>

						<TD style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc13001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=true>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc13002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"   >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc13003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>

						<TD style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc13004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" > 
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						
						<TD style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_inc13005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
					 </TR>
				</table>
			</div>
		</td>
	</tr>

	<tr>
		<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ 비과세소득 사항 TAB[2] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_specialst,'gcds_specialst')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>비과세소득(*)</b>
					</td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_specialst style="position:relative;display:none">
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  style='width:512x;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
							 <TR>
								<TD width=40 style="height:20;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER >월별</TD>
								<TD  width=330 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" COLSPAN=3 align=center>국외근로소득</TD>
								<TD  width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER width=85px>생산직근로자야간근로수당등</TD>
								<TD width=120 style="height:20px;border:1 solid #708090;border-top-width:0px;border-right-width:0px;border-left-width:0px" bgcolor="#eeeeee" colspan=2 ALIGN=CENTER>기타비과세</TD>		
               </TR>
							 <TR>		
								<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>지급연월</TD>
								<TD width=110 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>외화</TD>
								<TD  style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>원화</TD>	
								<TD  style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>내용</TD>	
								<TD  style="height:20px;border:1 solid #708090;border-top-width:0px;border-right-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>금액</TD>
							 </TR>
               
							 <TR>            
								<!---------------------------------비과세소득--1---------------------------------------->
								<TD  width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;1</TD>
								<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
								<comment id="__NSID__"><object id=gcem_freyy01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
									<param name=Text          value="">
									<param name=Alignment	  value=0>
									<param name=Border	      value=True>
									<param name=ClipMode	  value=true>
									<param name=Numeric	      value=false>
									<param name=Format	      value="YYYY/MM">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=IsComma	      value=false>
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script>	
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre01001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"   >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre01002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"   >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre01003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
									<input id="txt_fre01004" name="txt_fre01004" type="text" 
											style="width:80px;height:19;position:relative;top:1px;" maxlength=20>
								</TD>

								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre01005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
							</TR>

              <TR>   
<!-------------------------------비과세소득----2---------------------------------------->
								<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;2</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
								<comment id="__NSID__"><object id=gcem_freyy02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"   >
									<param name=Text          value="">
									<param name=Alignment	  value=0>
									<param name=Border	      value=True>
									<param name=Numeric	      value=false>
									<param name=Format	      value="YYYY/MM">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=IsComma	      value=false>
									<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre02001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"   >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre02002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre02003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
									<input id="txt_fre02004" name="txt_fre02004" type="text" 
											style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
								
								</TD>
								<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_fre02005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</TD>
							</TR>

<!-------------------------------비과세소득----3---------------------------------------->
						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;3</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:60px;height:19;position:relative;left:15px;top:1px;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre03001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre03002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre03003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<input id="txt_fre03004" name="txt_fre03004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre03005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----4---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;4</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;">
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23> 
							<comment id="__NSID__"><object id=gcem_fre04001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre04002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre04003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<input id="txt_fre04004" name="txt_fre04004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre04005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----5---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;5</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"" >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre05001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre05002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre05003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								 <input id="txt_fre05004" name="txt_fre05004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER></TD>
							
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre05005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----6---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;6</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy06 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre06001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre06002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre06003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>	
								<input id="txt_fre06004" name="txt_fre06004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER></TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre06005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득---7--------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;7</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy07 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23> 
							<comment id="__NSID__"><object id=gcem_fre07001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre07002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre07003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<input id="txt_fre07004" name="txt_fre07004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER></TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre07005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----8---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;8</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy08 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;">
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre08001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre08002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre08003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<input id="txt_fre08004" name="txt_fre08004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre08005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----9---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;9</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy09 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre09001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre09002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre09003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<input id="txt_fre09004" name="txt_fre09004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre09005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----10---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px; border-left-width:0px" bgcolor="#eeeeee" align=center>10</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy10 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre10001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre10002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre10003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<input id="txt_fre10004" name="txt_fre10004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre10005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----10--------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>11</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre11001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre11002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre11003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<input id="txt_fre11004" name="txt_fre11004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre11005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----11---------------------------------------->

						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px; border-left-width:0px" bgcolor="#eeeeee" align=center>12</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
							<comment id="__NSID__"><object id=gcem_freyy12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"   >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23> 
							<comment id="__NSID__"><object id=gcem_fre12001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre12002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre12003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<input id="txt_fre12004" name="txt_fre12004" type="text" 
										style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre12005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!-------------------------------비과세소득----계--------------------------------------->

						<TR>	
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;	border-left-width:0px" bgcolor="#eeeeee" align=center colspan=2 align=center>계</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_sfre001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>							
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_sfre002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_sfre003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<input id="" name="" type="text" 
									style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_sfre005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>

						<!-------------------------------비과세소득----13---&&&&&&&&&&&&&&&&&&&&&------------------------------------>
						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>13</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER >종전근무</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=23>
							<comment id="__NSID__"><object id=gcem_fre13001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre13002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre13003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER height=23>
								<input id="txt_fre13004" name="txt_fre13004" type="text" style="width:80px;height:19;position:relative;top:1px;" maxlength=20 ALIGN=CENTER>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_fre13005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"    >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
					</TABLE>
			  </div>		
			</td>
		</tr>

		<tr>
			<td colspan="2">
<!--------------------------------------------------------------------------------------------
	+ 근로소득원천징수액 사항 TAB[3] START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_humanst,'gcds_humanst');" background="../../Common/img/com_cont_subtxt_bg.gif" height=31><b>근로소득원천징수(*)</b></td>
				</tr>
				<tr>
					<td>
					<div id=gcgd_humanst style="position:relative;display:none"> 
					<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 width=600	style='width:640px;height:25px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
						<TR>
							<TD  style="height:18;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER ROWSPAN=2>&nbsp;월&nbsp;별&nbsp;</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ROWSPAN=2 ALIGN=CENTER>감면세액</TD>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" COLSPAN=3 align=center>차감원천징수액</TD>
							<TD  style="height:18px;border:1 solid #708090;border-top-width:0px;border-right-width:0px;border-left-width:0px" bgcolor="#eeeeee" COLSPAN=5 align=center>징수의무자 자체 증빙 지출액(소득공제)</TD>
						</TR>
						<TR>		
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>소득세</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>주민세</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>농촌특별세</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>연금보험</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>건강보험</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>고용보험</TD>
							<TD width=200 style="height:18px;border:1 solid #708090;border-top-width:0px;border-right-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>기부금</TD>
							<!--
							<TD  style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER>비고</TD>-->
						</TR>	
						<!--------------------근로소득원천징수----1------------------------->
						<TR>
							<TD  style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>1</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col01001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;">
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;">
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;" ALIGN=CENTER height=20>
							<comment id="__NSID__"><object id=gcem_col01008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
  					<!---------------------근로소득원천징수---2------------------------->

						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>2</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20> 
							<comment id="__NSID__"><object id=gcem_col02001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script></TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col02008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
						  </TD>
						</TR>
						<!---------------------근로소득원천징수---3------------------------->

						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>3</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col03008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!---------------------근로소득원천징수---4------------------------->
						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>4</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col04008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!---------------------근로소득원천징수---5------------------------->

						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>5</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col05008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!--------------------근로소득원천징수---6------------------------->
						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>6</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col06008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!---------------------근로소득원천징수--7------------------------->

						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>7</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col07008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<!--
							<TD>
							</TD>-->			
							</TR>
						<!-----------------------근로소득원천징수-8------------------------->

						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>8</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;	" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col08008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!----------------------근로소득원천징수--9------------------------->
						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>9</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col09001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>												
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;" bgcolor="#eeeeee" align=center>
							<comment id="__NSID__"><object id=gcem_col09008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>									
						</TR>
						<!----------------------근로소득원천징수--10------------------------->
						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>10</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col10008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!----------------------근로소득원천징수--11------------------------->
						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>11</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD   style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD   style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;	" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col11008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!---------------------근로소득원천징수---12------------------------->

						<TR>
							<TD  style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>12</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD   style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;	" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col12008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
						<!----------------------근로소득원천징수--계------------------------->
						<TR>
							
							<TD  style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align=center colspan=2 >계</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="width:60px;height:18;position:relative;top:1px;left:0;"   >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD   style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD   style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;	" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_scol008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>

						<!--------------------근로소득원천징수----13------------------------->

						<TR>
							<TD style="height:18px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" align=center>13</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER>종전근무</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;" >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13006 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13007 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
							<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;border-bottom-width:0px;" ALIGN=CENTER  height=20>
							<comment id="__NSID__"><object id=gcem_col13008 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
							</TD>
						</TR>
				</table>

			</div>
		</table>
		</td>
	</tr>


		<tr> 
			<td colspan="2"> 

<!--------------------------------------------------------------------------------------------
	+ 소득급여외 START
--------------------------------------------------------------------------------------------->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_exc,'gcds_exc')" background="../../Common/img/com_cont_subtxt_bg.gif" height="31"><b>소득외 급여 (*)</b>
					</td>
				</tr>
				<tr>
					<td>
					<div id=gcgd_exc style="position:relative;display:none">
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:512x;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
							<TR>
								<TD width=40  style="height:20;border:1   solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" rowspan=2  ALIGN=CENTER >월별</TD>
								<TD width=80  style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" rowspan=2  ALIGN=CENTER>지급연월</TD>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" rowspan=2  ALIGN=CENTER width=90x>소득외급여액</TD>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" rowspan=2  ALIGN=CENTER width=90x>소득외상여액</TD>
								<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" COLSPAN=3 align=center>소득공제</TD>
							</TR>
							<TR>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>국민연금</TD>
								<TD width=100 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>건강보험</TD>
								<TD width=110 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" ALIGN=CENTER width=90x>고용보험</TD>
							</TR>
	
						<!---------------------------------소득외 급여--1------------------------------------>
						<TR>
							<TD width=25 style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align="center">&nbsp;&nbsp;&nbsp;1</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
								<comment id="__NSID__"><object id=gcem_excyy01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Numeric	      value=false>
									<param name=Format	      value="YYYY/MM">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=IsComma	      value=false>
									<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_exc01001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_exc01005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_exc01002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>

							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
								<comment id="__NSID__"><object id=gcem_exc01003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
									<param name=Text          value="">
									<param name=Alignment			value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=9>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</TD>
	
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
							<comment id="__NSID__"><object id=gcem_exc01004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px" ALIGN=CENTER height=23>
							<!-- <comment id="__NSID__"><object id=gcem_exc01005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=IsComma	      value=true>
							</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>

					<!---------------------------------소득외 급여--2------------------------------------>
					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	2</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>			
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc02001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc02005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc02002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc02003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc02004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER height=23>
						<!-- <comment id="__NSID__"><object id=gcem_exc02005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>

					<!---------------------------------소득외 급여--3------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	3</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>						
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=center height=23>
						<comment id="__NSID__"><object id=gcem_exc03001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;">
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc03005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc03002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc03003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER height=23>
						<comment id="__NSID__"><object id=gcem_exc03004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script></TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER height=23>
						<!-- <comment id="__NSID__"><object id=gcem_exc03005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--4------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>4</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc04001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc04005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc04002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc04003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc04004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc04005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--5------------------------------------>
					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	5</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy05 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc05001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
							<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc05005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc05002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc05003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc05004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc05005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
						</TR>
					<!---------------------------------소득외 급여--6------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	6</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy06 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc06001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc06005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc06002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc06003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc06004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc06005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--7------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>7</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy07 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc07001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc07005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
					  </object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc07002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
					  </object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc07003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc07004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc07005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--8------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee"align=center>8</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy08 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	    value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc08001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc08005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc08002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc08003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc08004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc08005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--9------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>9</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" height=23>
						<comment id="__NSID__"><object id=gcem_excyy09 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>		
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc09001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc09005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc09002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc09003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc09004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
					<!-- 	<comment id="__NSID__"><object id=gcem_exc09005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--10------------------------------------->

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>	10</TD>
						<TD  style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;"height=23>
						<comment id="__NSID__"><object id=gcem_excyy10 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>			
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc10001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc10005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc10002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc10003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc10004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc10005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--11------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>11</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;"height=23>
						<comment id="__NSID__"><object id=gcem_excyy11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	    value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc11001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc11005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc11002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc11003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc11004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc11005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--12------------------------------------>

					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>12</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;"height=23>
						<comment id="__NSID__"><object id=gcem_excyy12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:19;position:relative;left:15px;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc12001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc12005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc12002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc12003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_exc12004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>													
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_exc12005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>
					<!---------------------------------소득외 급여--계------------------------------------>
					<TR>
						<TD style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" colspan=2 align=center>&nbsp;계</TD>
						<TD ALIGN=CENTER height=25  style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
						<comment id="__NSID__"><object id=gcem_sexc001 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=Readonly	    value=true>
							<param name=MaxLength     value=9>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=true>
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sexc005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sexc002 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sexc003 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" ALIGN=CENTER>
						<comment id="__NSID__"><object id=gcem_sexc004 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script>
						</TD>
						<TD style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;border-right-width:0px;" ALIGN=CENTER>
						<!-- <comment id="__NSID__"><object id=gcem_sexc005 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:19;position:relative;top:1px;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=9>
							<param name=IsComma	      value=true>
						</object></comment><script>__ws__(__NSID__);</script> -->
						</TD>
					</TR>					
				</table>
			</div>
		</td>
	</tr>


	</table>
</td>
</tr>
</table>
</td>
</tr>
</table>

<!----------------------------BindING------------------------------------>

<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=YYYY				        Ctrl=gcem_yyyy					  Param=Text</C>
		<C>Col=EMPNO				      Ctrl=gcem_empno					  Param=Text</C>
		<C>Col=EMPNMK				      Ctrl=txt_empnmk2				  Param=Value</C>
		<C>Col=INCYY01		        Ctrl=gcem_incyy01				  Param=Text</C>
		<C>Col=INC01001		        Ctrl=gcem_inc01001				Param=Text</C>
		<C>Col=INC01002		        Ctrl=gcem_inc01002				Param=Text</C>
		<C>Col=INC01003		        Ctrl=gcem_inc01003				Param=Text</C>
		<C>Col=INC01004		        Ctrl=gcem_inc01004				Param=Text</C>
		<C>Col=INC01005		        Ctrl=gcem_inc01005				Param=Text</C>
		<C>Col=INCYY02		        Ctrl=gcem_incyy02				  Param=Text</C>
		<C>Col=INC02001		        Ctrl=gcem_inc02001				Param=Text</C>
		<C>Col=INC02002		        Ctrl=gcem_inc02002				Param=Text</C>
		<C>Col=INC02003		        Ctrl=gcem_inc02003				Param=Text</C>
		<C>Col=INC02004		        Ctrl=gcem_inc02004				Param=Text</C>
		<C>Col=INC02005		        Ctrl=gcem_inc02005				Param=Text</C>
		<C>Col=INCYY03		        Ctrl=gcem_incyy03				  Param=Text</C>
		<C>Col=INC03001		        Ctrl=gcem_inc03001				Param=Text</C>
		<C>Col=INC03002		        Ctrl=gcem_inc03002				Param=Text</C>
		<C>Col=INC03003		        Ctrl=gcem_inc03003				Param=Text</C>
		<C>Col=INC03004		        Ctrl=gcem_inc03004				Param=Text</C>
		<C>Col=INC03005		        Ctrl=gcem_inc03005				Param=Text</C>
		<C>Col=INCYY04		        Ctrl=gcem_incyy04				  Param=Text</C>
		<C>Col=INC04001		        Ctrl=gcem_inc04001				Param=Text</C>
		<C>Col=INC04002		        Ctrl=gcem_inc04002				Param=Text</C>
		<C>Col=INC04003		        Ctrl=gcem_inc04003				Param=Text</C>
		<C>Col=INC04004		        Ctrl=gcem_inc04004				Param=Text</C>
		<C>Col=INC04005		        Ctrl=gcem_inc04005				Param=Text</C>
		<C>Col=INCYY05		        Ctrl=gcem_incyy05				  Param=Text</C>
		<C>Col=INC05001		        Ctrl=gcem_inc05001				Param=Text</C>
		<C>Col=INC05002		        Ctrl=gcem_inc05002				Param=Text</C>
		<C>Col=INC05003		        Ctrl=gcem_inc05003				Param=Text</C>
		<C>Col=INC05004		        Ctrl=gcem_inc05004				Param=Text</C>
		<C>Col=INC05005		        Ctrl=gcem_inc05005				Param=Text</C>
		<C>Col=INCYY06		        Ctrl=gcem_incyy06				  Param=Text</C>
		<C>Col=INC06001		        Ctrl=gcem_inc06001				Param=Text</C>
		<C>Col=INC06002		        Ctrl=gcem_inc06002				Param=Text</C>
		<C>Col=INC06003		        Ctrl=gcem_inc06003				Param=Text</C>
		<C>Col=INC06004		        Ctrl=gcem_inc06004				Param=Text</C>
		<C>Col=INC06005		        Ctrl=gcem_inc06005				Param=Text</C>
		<C>Col=INCYY07		        Ctrl=gcem_incyy07				  Param=Text</C>
		<C>Col=INC07001		        Ctrl=gcem_inc07001				Param=Text</C>
		<C>Col=INC07002		        Ctrl=gcem_inc07002				Param=Text</C>
		<C>Col=INC07003		        Ctrl=gcem_inc07003				Param=Text</C>
		<C>Col=INC07004		        Ctrl=gcem_inc07004				Param=Text</C>
		<C>Col=INC07005		        Ctrl=gcem_inc07005				Param=Text</C>
		<C>Col=INCYY08		        Ctrl=gcem_incyy08				  Param=Text</C>
		<C>Col=INC08001		        Ctrl=gcem_inc08001				Param=Text</C>
		<C>Col=INC08002		        Ctrl=gcem_inc08002				Param=Text</C>
		<C>Col=INC08003		        Ctrl=gcem_inc08003				Param=Text</C>
		<C>Col=INC08004		        Ctrl=gcem_inc08004				Param=Text</C>
		<C>Col=INC08005		        Ctrl=gcem_inc08005				Param=Text</C>
		<C>Col=INCYY09		        Ctrl=gcem_incyy09				  Param=Text</C>
		<C>Col=INC09001		        Ctrl=gcem_inc09001				Param=Text</C>
		<C>Col=INC09002		        Ctrl=gcem_inc09002				Param=Text</C>
		<C>Col=INC09003		        Ctrl=gcem_inc09003				Param=Text</C>
		<C>Col=INC09004		        Ctrl=gcem_inc09004				Param=Text</C>
		<C>Col=INC09005		        Ctrl=gcem_inc09005				Param=Text</C>
		<C>Col=INCYY10	          Ctrl=gcem_incyy10	  			Param=Text</C>
		<C>Col=INC10001		        Ctrl=gcem_inc10001				Param=Text</C>
		<C>Col=INC10002		        Ctrl=gcem_inc10002				Param=Text</C>
		<C>Col=INC10003		        Ctrl=gcem_inc10003				Param=Text</C>
		<C>Col=INC10004		        Ctrl=gcem_inc10004				Param=Text</C>
		<C>Col=INC10005		        Ctrl=gcem_inc10005				Param=Text</C>
		<C>Col=INCYY11	          Ctrl=gcem_incyy11 				Param=Text</C>
		<C>Col=INC11001		        Ctrl=gcem_inc11001				Param=Text</C>
		<C>Col=INC11002		        Ctrl=gcem_inc11002				Param=Text</C>
		<C>Col=INC11003		        Ctrl=gcem_inc11003				Param=Text</C>
		<C>Col=INC11004		        Ctrl=gcem_inc11004				Param=Text</C>
		<C>Col=INC11005		        Ctrl=gcem_inc11005				Param=Text</C>
		<C>Col=INCYY12	          Ctrl=gcem_incyy12  				Param=Text</C>
		<C>Col=INC12001		        Ctrl=gcem_inc12001				Param=Text</C>
		<C>Col=INC12002		        Ctrl=gcem_inc12002				Param=Text</C>
		<C>Col=INC12003		        Ctrl=gcem_inc12003				Param=Text</C>
		<C>Col=INC12004		        Ctrl=gcem_inc12004				Param=Text</C>
		<C>Col=INC12005		        Ctrl=gcem_inc12005				Param=Text</C>		
		<C>Col=INCYY13	          Ctrl=gcem_incyy13		  		Param=Text</C>
		<C>Col=INC13001		        Ctrl=gcem_inc13001				Param=Text</C>
		<C>Col=INC13002		        Ctrl=gcem_inc13002				Param=Text</C>
		<C>Col=INC13003		        Ctrl=gcem_inc13003				Param=Text</C>
		<C>Col=INC13004		        Ctrl=gcem_inc13004				Param=Text</C>
		<C>Col=INC13005		        Ctrl=gcem_inc13005				Param=Text</C>
		<C>Col=SINC001	          Ctrl=gcem_sinc001				  Param=Text</C>
		<C>Col=SINC002	          Ctrl=gcem_sinc002				  Param=Text</C>
		<C>Col=SINC003		        Ctrl=gcem_sinc003				  Param=Text</C>
		<C>Col=SINC004		        Ctrl=gcem_sinc004				  Param=Text</C>
		<C>Col=SINC005		        Ctrl=gcem_sinc005				  Param=Text</C>
		<C>Col=FREYY01		        Ctrl=gcem_freyy01				  Param=Text</C>
		<C>Col=FRE01001		        Ctrl=gcem_fre01001				Param=Text</C>
		<C>Col=FRE01002		        Ctrl=gcem_fre01002				Param=Text</C>
		<C>Col=FRE01003		        Ctrl=gcem_fre01003				Param=Text</C>
		<C>Col=FRE01004		        Ctrl=txt_fre01004				  Param=Value</C>
		<C>Col=FRE01005		        Ctrl=gcem_fre01005				Param=Text</C>
		<C>Col=FREYY02		        Ctrl=gcem_freyy02				  Param=Text</C>
		<C>Col=FRE02001		        Ctrl=gcem_fre02001				Param=Text</C>
		<C>Col=FRE02002		        Ctrl=gcem_fre02002				Param=Text</C>
		<C>Col=FRE02003		        Ctrl=gcem_fre02003				Param=Text</C>
		<C>Col=FRE02004		        Ctrl=txt_fre02004				  Param=Value</C>
		<C>Col=FRE02005		        Ctrl=gcem_fre02005				Param=Text</C>
		<C>Col=FREYY03		        Ctrl=gcem_freyy03				  Param=Text</C>
		<C>Col=FRE03001		        Ctrl=gcem_fre03001				Param=Text</C>
		<C>Col=FRE03002		        Ctrl=gcem_fre03002				Param=Text</C>
		<C>Col=FRE03003		        Ctrl=gcem_fre03003				Param=Text</C>
		<C>Col=FRE03004		        Ctrl=txt_fre03004				  Param=Value</C>
		<C>Col=FRE03005		        Ctrl=gcem_fre03005				Param=Text</C>
		<C>Col=FREYY04		        Ctrl=gcem_freyy04				  Param=Text</C>
		<C>Col=FRE04001		        Ctrl=gcem_fre04001				Param=Text</C>
		<C>Col=FRE04002		        Ctrl=gcem_fre04002				Param=Text</C>
		<C>Col=FRE04003		        Ctrl=gcem_fre04003				Param=Text</C>
		<C>Col=FRE04004		        Ctrl=txt_fre04004				  Param=Value</C>
		<C>Col=FRE04005		        Ctrl=gcem_fre04005				Param=Text</C>
		<C>Col=FREYY05		        Ctrl=gcem_freyy05				  Param=Text</C>
		<C>Col=FRE05001		        Ctrl=gcem_fre05001				Param=Text</C>
		<C>Col=FRE05002		        Ctrl=gcem_fre05002				Param=Text</C>
		<C>Col=FRE05003		        Ctrl=gcem_fre05003				Param=Text</C>
		<C>Col=FRE05004		        Ctrl=txt_fre05004				  Param=Value</C>
		<C>Col=FRE05005		        Ctrl=gcem_fre05005				Param=Text</C>
		<C>Col=FREYY06		        Ctrl=gcem_freyy06				  Param=Text</C>
		<C>Col=FRE06001		        Ctrl=gcem_fre06001				Param=Text</C>
		<C>Col=FRE06002		        Ctrl=gcem_fre06002				Param=Text</C>
		<C>Col=FRE06003		        Ctrl=gcem_fre06003				Param=Text</C>
		<C>Col=FRE06004		        Ctrl=txt_fre06004				  Param=Value</C>
		<C>Col=FRE06005		        Ctrl=gcem_fre06005				Param=Text</C>
		<C>Col=FREYY07		        Ctrl=gcem_freyy07				  Param=Text</C>
		<C>Col=FRE07001		        Ctrl=gcem_fre07001				Param=Text</C>
		<C>Col=FRE07002		        Ctrl=gcem_fre07002				Param=Text</C>
		<C>Col=FRE07003		        Ctrl=gcem_fre07003				Param=Text</C>
		<C>Col=FRE07004		        Ctrl=txt_fre07004				  Param=Value</C>
		<C>Col=FRE07005		        Ctrl=gcem_fre07005				Param=Text</C>
		<C>Col=FREYY08		        Ctrl=gcem_freyy08				  Param=Text</C>
		<C>Col=FRE08001		        Ctrl=gcem_fre08001				Param=Text</C>
		<C>Col=FRE08002		        Ctrl=gcem_fre08002				Param=Text</C>
		<C>Col=FRE08003		        Ctrl=gcem_fre08003				Param=Text</C>
		<C>Col=FRE08004		        Ctrl=txt_fre08004				  Param=Value</C>
		<C>Col=FRE08005		        Ctrl=gcem_fre08005				Param=Text</C>
		<C>Col=FREYY09		        Ctrl=gcem_freyy09				  Param=Text</C>
		<C>Col=FRE09001		        Ctrl=gcem_fre09001				Param=Text</C>
		<C>Col=FRE09002		        Ctrl=gcem_fre09002				Param=Text</C>
		<C>Col=FRE09003		        Ctrl=gcem_fre09003				Param=Text</C>
		<C>Col=FRE09004		        Ctrl=txt_fre09004				  Param=Value</C>
		<C>Col=FRE09005		        Ctrl=gcem_fre09005				Param=Text</C>
		<C>Col=FREYY10	          Ctrl=gcem_freyy10				  Param=Text</C>
		<C>Col=FRE10001		        Ctrl=gcem_fre10001				Param=Text</C>
		<C>Col=FRE10002		        Ctrl=gcem_fre10002				Param=Text</C>
		<C>Col=FRE10003		        Ctrl=gcem_fre10003				Param=Text</C>
		<C>Col=FRE10004		        Ctrl=txt_fre10004				  Param=Value</C>
		<C>Col=FRE10005		        Ctrl=gcem_fre10005				Param=Text</C>
		<C>Col=FREYY11	          Ctrl=gcem_freyy11				  Param=Text</C>
		<C>Col=FRE11001		        Ctrl=gcem_fre11001				Param=Text</C>
		<C>Col=FRE11002		        Ctrl=gcem_fre11002				Param=Text</C>
		<C>Col=FRE11003		        Ctrl=gcem_fre11003				Param=Text</C>
		<C>Col=FRE11004		        Ctrl=txt_fre11004				  Param=Value</C>
		<C>Col=FRE11005		        Ctrl=gcem_fre11005				Param=Text</C>
		<C>Col=FREYY12	          Ctrl=gcem_freyy12				  Param=Text</C>
		<C>Col=FRE12001		        Ctrl=gcem_fre12001				Param=Text</C>
		<C>Col=FRE12002		        Ctrl=gcem_fre12002				Param=Text</C>
		<C>Col=FRE12003		        Ctrl=gcem_fre12003				Param=Text</C>
		<C>Col=FRE12004		        Ctrl=txt_fre12004				  Param=Value</C>
		<C>Col=FRE12005		        Ctrl=gcem_fre12005				Param=Text</C>		
		<C>Col=FREYY13	          Ctrl=gcem_freyy13	  			Param=Text</C>
		<C>Col=FRE13001		        Ctrl=gcem_fre13001				Param=Text</C>
		<C>Col=FRE13002		        Ctrl=gcem_fre13002				Param=Text</C>
		<C>Col=FRE13003		        Ctrl=gcem_fre13003				Param=Text</C>
		<C>Col=FRE13004		        Ctrl=txt_fre13004		  		Param=Value</C>
		<C>Col=FRE13005		        Ctrl=gcem_fre13005				Param=Text</C>
		<C>Col=SFRE001	          Ctrl=gcem_sfre001				  Param=Text</C>
		<C>Col=SFRE002	          Ctrl=gcem_sfre002				  Param=Text</C>
		<C>Col=SFRE003		        Ctrl=gcem_sfre003				  Param=Text</C>
		<C>Col=SFRE005		        Ctrl=gcem_sfre005				  Param=Text</C>
		<C>Col=COL01001		        Ctrl=gcem_col01001				Param=Text</C>
		<C>Col=COL01002		        Ctrl=gcem_col01002				Param=Text</C>
		<C>Col=COL01003		        Ctrl=gcem_col01003				Param=Text</C>
		<C>Col=COL01004		        Ctrl=gcem_col01004				Param=Text</C>
		<C>Col=COL01005		        Ctrl=gcem_col01005				Param=Text</C>
		<C>Col=COL01006		        Ctrl=gcem_col01006				Param=Text</C>
		<C>Col=COL01007		        Ctrl=gcem_col01007				Param=Text</C>
		<C>Col=COL01008		        Ctrl=gcem_col01008				Param=Text</C>
		<C>Col=COL02001		        Ctrl=gcem_col02001				Param=Text</C>
		<C>Col=COL02002		        Ctrl=gcem_col02002				Param=Text</C>
		<C>Col=COL02003		        Ctrl=gcem_col02003				Param=Text</C>
		<C>Col=COL02004		        Ctrl=gcem_col02004				Param=Text</C>
		<C>Col=COL02005		        Ctrl=gcem_col02005				Param=Text</C>
		<C>Col=COL02006		        Ctrl=gcem_col02006				Param=Text</C>
		<C>Col=COL02007		        Ctrl=gcem_col02007				Param=Text</C>
		<C>Col=COL02008		        Ctrl=gcem_col02008				Param=Text</C>
		<C>Col=COL03001		        Ctrl=gcem_col03001				Param=Text</C>
		<C>Col=COL03002		        Ctrl=gcem_col03002				Param=Text</C>
		<C>Col=COL03003		        Ctrl=gcem_col03003				Param=Text</C>
		<C>Col=COL03004		        Ctrl=gcem_col03004				Param=Text</C>
		<C>Col=COL03005		        Ctrl=gcem_col03005				Param=Text</C>
		<C>Col=COL03006		        Ctrl=gcem_col03006				Param=Text</C>
		<C>Col=COL03007		        Ctrl=gcem_col03007				Param=Text</C>
		<C>Col=COL03008		        Ctrl=gcem_col03008				Param=Text</C>
		<C>Col=COL04001		        Ctrl=gcem_col04001				Param=Text</C>
		<C>Col=COL04002		        Ctrl=gcem_col04002				Param=Text</C>
		<C>Col=COL04003		        Ctrl=gcem_col04003				Param=Text</C>
		<C>Col=COL04004		        Ctrl=gcem_col04004				Param=Text</C>
		<C>Col=COL04005		        Ctrl=gcem_col04005				Param=Text</C>
		<C>Col=COL04006		        Ctrl=gcem_col04006				Param=Text</C>
		<C>Col=COL04007		        Ctrl=gcem_col04007				Param=Text</C>
		<C>Col=COL04008		        Ctrl=gcem_col04008				Param=Text</C>
		<C>Col=COL05001		        Ctrl=gcem_col05001				Param=Text</C>
		<C>Col=COL05002		        Ctrl=gcem_col05002				Param=Text</C>
		<C>Col=COL05003		        Ctrl=gcem_col05003				Param=Text</C>
		<C>Col=COL05004		        Ctrl=gcem_col05004				Param=Text</C>
		<C>Col=COL05005		        Ctrl=gcem_col05005				Param=Text</C>
		<C>Col=COL05006		        Ctrl=gcem_col05006				Param=Text</C>
		<C>Col=COL05007		        Ctrl=gcem_col05007				Param=Text</C>
		<C>Col=COL05008		        Ctrl=gcem_col05008				Param=Text</C>
		<C>Col=COL06001		        Ctrl=gcem_col06001				Param=Text</C>
		<C>Col=COL06002		        Ctrl=gcem_col06002				Param=Text</C>
		<C>Col=COL06003		        Ctrl=gcem_col06003				Param=Text</C>
		<C>Col=COL06004		        Ctrl=gcem_col06004				Param=Text</C>
		<C>Col=COL06005		        Ctrl=gcem_col06005				Param=Text</C>
		<C>Col=COL06006		        Ctrl=gcem_col06006				Param=Text</C>
		<C>Col=COL06007		        Ctrl=gcem_col06007				Param=Text</C>
		<C>Col=COL06008		        Ctrl=gcem_col06008				Param=Text</C>
		<C>Col=COL07001		        Ctrl=gcem_col07001				Param=Text</C>
		<C>Col=COL07002		        Ctrl=gcem_col07002				Param=Text</C>
		<C>Col=COL07003		        Ctrl=gcem_col07003				Param=Text</C>
		<C>Col=COL07004		        Ctrl=gcem_col07004				Param=Text</C>
		<C>Col=COL07005		        Ctrl=gcem_col07005				Param=Text</C>
		<C>Col=COL07006		        Ctrl=gcem_col07006				Param=Text</C>
		<C>Col=COL07007		        Ctrl=gcem_col07007				Param=Text</C>
		<C>Col=COL07008		        Ctrl=gcem_col07008				Param=Text</C>
		<C>Col=COL08001		        Ctrl=gcem_col08001				Param=Text</C>
		<C>Col=COL08002		        Ctrl=gcem_col08002				Param=Text</C>
		<C>Col=COL08003		        Ctrl=gcem_col08003				Param=Text</C>
		<C>Col=COL08004		        Ctrl=gcem_col08004				Param=Text</C>
		<C>Col=COL08005		        Ctrl=gcem_col08005				Param=Text</C>
		<C>Col=COL08006		        Ctrl=gcem_col08006				Param=Text</C>
		<C>Col=COL08007		        Ctrl=gcem_col08007				Param=Text</C>
		<C>Col=COL08008		        Ctrl=gcem_col08008				Param=Text</C>
		<C>Col=COL09001		        Ctrl=gcem_col09001				Param=Text</C>
		<C>Col=COL09002		        Ctrl=gcem_col09002				Param=Text</C>
		<C>Col=COL09003		        Ctrl=gcem_col09003				Param=Text</C>
		<C>Col=COL09004		        Ctrl=gcem_col09004				Param=Text</C>
		<C>Col=COL09005		        Ctrl=gcem_col09005				Param=Text</C>
		<C>Col=COL09006		        Ctrl=gcem_col09006				Param=Text</C>
		<C>Col=COL09007		        Ctrl=gcem_col09007				Param=Text</C>
		<C>Col=COL09008		        Ctrl=gcem_col09008				Param=Text</C>
		<C>Col=COL10001		        Ctrl=gcem_col10001				Param=Text</C>
		<C>Col=COL10002		        Ctrl=gcem_col10002				Param=Text</C>
		<C>Col=COL10003		        Ctrl=gcem_col10003				Param=Text</C>
		<C>Col=COL10004		        Ctrl=gcem_col10004				Param=Text</C>
		<C>Col=COL10005		        Ctrl=gcem_col10005				Param=Text</C>
		<C>Col=COL10006		        Ctrl=gcem_col10006				Param=Text</C>
		<C>Col=COL10007		        Ctrl=gcem_col10007				Param=Text</C>
		<C>Col=COL10008		        Ctrl=gcem_col10008				Param=Text</C>
		<C>Col=COL11001		        Ctrl=gcem_col11001				Param=Text</C>
		<C>Col=COL11002		        Ctrl=gcem_col11002				Param=Text</C>
		<C>Col=COL11003		        Ctrl=gcem_col11003				Param=Text</C>
		<C>Col=COL11004		        Ctrl=gcem_col11004				Param=Text</C>
		<C>Col=COL11005		        Ctrl=gcem_col11005				Param=Text</C>
		<C>Col=COL11006		        Ctrl=gcem_col11006				Param=Text</C>
		<C>Col=COL11007		        Ctrl=gcem_col11007				Param=Text</C>
		<C>Col=COL11008		        Ctrl=gcem_col11008				Param=Text</C>	
		<C>Col=COL12001		        Ctrl=gcem_col12001				Param=Text</C>
		<C>Col=COL12002		        Ctrl=gcem_col12002				Param=Text</C>
		<C>Col=COL12003		        Ctrl=gcem_col12003				Param=Text</C>
		<C>Col=COL12004		        Ctrl=gcem_col12004				Param=Text</C>
		<C>Col=COL12005		        Ctrl=gcem_col12005				Param=Text</C>
		<C>Col=COL12006		        Ctrl=gcem_col12006				Param=Text</C>
		<C>Col=COL12007		        Ctrl=gcem_col12007				Param=Text</C>
		<C>Col=COL12008		        Ctrl=gcem_col12008				Param=Text</C>
		<C>Col=COL13001		        Ctrl=gcem_col13001				Param=Text</C>
		<C>Col=COL13002		        Ctrl=gcem_col13002				Param=Text</C>
		<C>Col=COL13003		        Ctrl=gcem_col13003				Param=Text</C>
		<C>Col=COL13004		        Ctrl=gcem_col13004				Param=Text</C>
		<C>Col=COL13005		        Ctrl=gcem_col13005				Param=Text</C>
		<C>Col=COL13006		        Ctrl=gcem_col13006				Param=Text</C>
		<C>Col=COL13007		        Ctrl=gcem_col13007				Param=Text</C>
		<C>Col=COL13008		        Ctrl=gcem_col13008				Param=Text</C>
		<C>Col=scol002	          Ctrl=gcem_scol002			  	Param=Text</C>
		<C>Col=scol003		        Ctrl=gcem_scol003			  	Param=Text</C>
		<C>Col=scol004		        Ctrl=gcem_scol004				  Param=Text</C>
		<C>Col=scol005		        Ctrl=gcem_scol005				  Param=Text</C>
		<C>Col=scol006		        Ctrl=gcem_scol006				  Param=Text</C>
		<C>Col=scol007		        Ctrl=gcem_scol007				  Param=Text</C>
		<C>Col=scol008		        Ctrl=gcem_scol008				  Param=Text</C>
		<C>Col=EXCYY01		        Ctrl=gcem_excyy01				Param=Text</C>
		<C>Col=EXC01001		        Ctrl=gcem_exc01001				Param=Text</C>
		<C>Col=EXC01002		        Ctrl=gcem_exc01002				Param=Text</C>
		<C>Col=EXC01003		        Ctrl=gcem_exc01003				Param=Text</C>
		<C>Col=EXC01004		        Ctrl=gcem_exc01004				Param=Text</C>
		<C>Col=EXC01005		        Ctrl=gcem_exc01005				Param=Text</C>
		<C>Col=EXCYY02		        Ctrl=gcem_excyy02				Param=Text</C>
		<C>Col=EXC02001		        Ctrl=gcem_exc02001				Param=Text</C>
		<C>Col=EXC02002		        Ctrl=gcem_exc02002				Param=Text</C>
		<C>Col=EXC02003		        Ctrl=gcem_exc02003				Param=Text</C>
		<C>Col=EXC02004		        Ctrl=gcem_exc02004				Param=Text</C>
		<C>Col=EXC02005		        Ctrl=gcem_exc02005				Param=Text</C>
		<C>Col=EXCYY03		        Ctrl=gcem_excyy03				Param=Text</C>
		<C>Col=EXC03001		        Ctrl=gcem_exc03001				Param=Text</C>
		<C>Col=EXC03002		        Ctrl=gcem_exc03002				Param=Text</C>
		<C>Col=EXC03003		        Ctrl=gcem_exc03003				Param=Text</C>
		<C>Col=EXC03004		        Ctrl=gcem_exc03004				Param=Text</C>
		<C>Col=EXC03005		        Ctrl=gcem_exc03005				Param=Text</C>
		<C>Col=EXCYY04		        Ctrl=gcem_excyy04				Param=Text</C>
		<C>Col=EXC04001		        Ctrl=gcem_exc04001				Param=Text</C>
		<C>Col=EXC04002		        Ctrl=gcem_exc04002				Param=Text</C>
		<C>Col=EXC04003		        Ctrl=gcem_exc04003				Param=Text</C>
		<C>Col=EXC04004		        Ctrl=gcem_exc04004				Param=Text</C>
		<C>Col=EXC04005		        Ctrl=gcem_exc04005				Param=Text</C>
		<C>Col=EXCYY05		        Ctrl=gcem_excyy05				Param=Text</C>
		<C>Col=EXC05001		        Ctrl=gcem_exc05001				Param=Text</C>
		<C>Col=EXC05002		        Ctrl=gcem_exc05002				Param=Text</C>
		<C>Col=EXC05003		        Ctrl=gcem_exc05003				Param=Text</C>
		<C>Col=EXC05004		        Ctrl=gcem_exc05004				Param=Text</C>
		<C>Col=EXC05005		        Ctrl=gcem_exc05005				Param=Text</C>
		<C>Col=EXCYY06		        Ctrl=gcem_excyy06				Param=Text</C>
		<C>Col=EXC06001		        Ctrl=gcem_exc06001				Param=Text</C>
		<C>Col=EXC06002		        Ctrl=gcem_exc06002				Param=Text</C>
		<C>Col=EXC06003		        Ctrl=gcem_exc06003				Param=Text</C>
		<C>Col=EXC06004		        Ctrl=gcem_exc06004				Param=Text</C>
		<C>Col=EXC06005		        Ctrl=gcem_exc06005				Param=Text</C>
		<C>Col=EXCYY07		        Ctrl=gcem_excyy07				Param=Text</C>
		<C>Col=EXC07001		        Ctrl=gcem_exc07001				Param=Text</C>
		<C>Col=EXC07002		        Ctrl=gcem_exc07002				Param=Text</C>
		<C>Col=EXC07003		        Ctrl=gcem_exc07003				Param=Text</C>
		<C>Col=EXC07004		        Ctrl=gcem_exc07004				Param=Text</C>
		<C>Col=EXC07005		        Ctrl=gcem_exc07005				Param=Text</C>
		<C>Col=EXCYY08		        Ctrl=gcem_excyy08				Param=Text</C>
		<C>Col=EXC08001		        Ctrl=gcem_exc08001				Param=Text</C>
		<C>Col=EXC08002		        Ctrl=gcem_exc08002				Param=Text</C>
		<C>Col=EXC08003		        Ctrl=gcem_exc08003				Param=Text</C>
		<C>Col=EXC08004		        Ctrl=gcem_exc08004				Param=Text</C>
		<C>Col=EXC08005		        Ctrl=gcem_exc08005				Param=Text</C>
		<C>Col=EXCYY09		        Ctrl=gcem_excyy09				Param=Text</C>
		<C>Col=EXC09001		        Ctrl=gcem_exc09001				Param=Text</C>
		<C>Col=EXC09002		        Ctrl=gcem_exc09002				Param=Text</C>
		<C>Col=EXC09003		        Ctrl=gcem_exc09003				Param=Text</C>
		<C>Col=EXC09004		        Ctrl=gcem_exc09004				Param=Text</C>
		<C>Col=EXC09005		        Ctrl=gcem_exc09005				Param=Text</C>
		<C>Col=EXCYY10		        Ctrl=gcem_excyy10				Param=Text</C>
		<C>Col=EXC10001		        Ctrl=gcem_exc10001				Param=Text</C>
		<C>Col=EXC10002		        Ctrl=gcem_exc10002				Param=Text</C>
		<C>Col=EXC10003		        Ctrl=gcem_exc10003				Param=Text</C>
		<C>Col=EXC10004		        Ctrl=gcem_exc10004				Param=Text</C>
		<C>Col=EXC10005		        Ctrl=gcem_exc10005				Param=Text</C>
		<C>Col=EXCYY11		        Ctrl=gcem_excyy11				Param=Text</C>
		<C>Col=EXC11001		        Ctrl=gcem_exc11001				Param=Text</C>
		<C>Col=EXC11002		        Ctrl=gcem_exc11002				Param=Text</C>
		<C>Col=EXC11003		        Ctrl=gcem_exc11003				Param=Text</C>
		<C>Col=EXC11004		        Ctrl=gcem_exc11004				Param=Text</C>
		<C>Col=EXC11005		        Ctrl=gcem_exc11005				Param=Text</C>
		<C>Col=EXCYY12		        Ctrl=gcem_excyy12				Param=Text</C>
		<C>Col=EXC12001		        Ctrl=gcem_exc12001				Param=Text</C>
		<C>Col=EXC12002		        Ctrl=gcem_exc12002				Param=Text</C>
		<C>Col=EXC12003		        Ctrl=gcem_exc12003				Param=Text</C>
		<C>Col=EXC12004		        Ctrl=gcem_exc12004				Param=Text</C>
		<C>Col=EXC12005		        Ctrl=gcem_exc12005				Param=Text</C>
    <C>Col=SEXC001		        Ctrl=gcem_sexc001 				Param=Text</C>
		<C>Col=SEXC002		        Ctrl=gcem_sexc002 				Param=Text</C>
		<C>Col=SEXC003		        Ctrl=gcem_sexc003 				Param=Text</C>
		<C>Col=SEXC004		        Ctrl=gcem_sexc004 				Param=Text</C>
		<C>Col=SEXC005		        Ctrl=gcem_sexc005 				Param=Text</C>
	'>
	
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 : 소득자별근로소득원천징수부  -  R E P O R T
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2779 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='[별지 제 25호서식(1)] (2005.3.19 개정)' ,left=16 ,top=0 ,right=766 ,bottom=44 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=25 ,top=69 ,right=431 ,bottom=122 ,border=true</X>
	<T>id='소 득 자 별 근 로 소 득 원 천 징 수 부' ,left=472 ,top=62 ,right=1634 ,bottom=137 ,face='HY중고딕' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=253 ,top=69 ,right=253 ,bottom=119 </L>
	<T>id='(1)귀속연도' ,left=31 ,top=75 ,right=247 ,bottom=116 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소   득   자' ,left=9 ,top=250 ,right=288 ,bottom=347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(5)주민등록번호' ,left=947 ,top=250 ,right=1231 ,bottom=294 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근  로  소  득   지  급  명  세' ,left=13 ,top=356 ,right=1872 ,bottom=403 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=406 ,right=1878 ,bottom=406 </L>
	<L> left=3 ,top=350 ,right=1878 ,bottom=350 </L>
	<L> left=3 ,top=244 ,right=1878 ,bottom=244 </L>
	<L> left=3 ,top=47 ,right=1878 ,bottom=47 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='총                              급                              여' ,left=297 ,top=412 ,right=1544 ,bottom=453 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=291 ,top=456 ,right=1550 ,bottom=456 </L>
	<T>id='(11)계' ,left=1269 ,top=462 ,right=1544 ,bottom=503 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(10)인정상여' ,left=947 ,top=462 ,right=1253 ,bottom=503 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(9)상여액' ,left=625 ,top=462 ,right=931 ,bottom=503 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(8)급여액' ,left=300 ,top=462 ,right=609 ,bottom=503 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=506 ,right=1878 ,bottom=506 </L>
	<L> left=3 ,top=1075 ,right=1881 ,bottom=1075 </L>
	<L> left=3 ,top=1031 ,right=1878 ,bottom=1031 </L>
	<L> left=3 ,top=987 ,right=1878 ,bottom=987 </L>
	<L> left=3 ,top=944 ,right=1878 ,bottom=944 </L>
	<L> left=3 ,top=900 ,right=1878 ,bottom=900 </L>
	<L> left=3 ,top=856 ,right=1878 ,bottom=856 </L>
	<L> left=3 ,top=812 ,right=1878 ,bottom=812 </L>
	<L> left=3 ,top=769 ,right=1878 ,bottom=769 </L>
	<L> left=3 ,top=725 ,right=1878 ,bottom=725 </L>
	<L> left=3 ,top=681 ,right=1878 ,bottom=681 </L>
	<L> left=3 ,top=637 ,right=1878 ,bottom=637 </L>
	<L> left=3 ,top=594 ,right=1878 ,bottom=594 </L>
	<L> left=3 ,top=550 ,right=1878 ,bottom=550 </L>
	<C>id='FAMCNT', left=1431, top=303, right=1478, bottom=347, align='right' ,mask='XX명', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO', left=1275, top=250, right=1713, bottom=294, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=656, top=250, right=844, bottom=294, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='YYYY', left=259, top=75, right=425, bottom=116, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01001', left=300, top=512, right=606, bottom=547, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12001', left=300, top=994, right=606, bottom=1028, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11001', left=300, top=950, right=606, bottom=984, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10001', left=300, top=906, right=606, bottom=941, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09001', left=300, top=862, right=606, bottom=897, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08001', left=300, top=819, right=606, bottom=853, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07001', left=300, top=775, right=606, bottom=809, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06001', left=300, top=731, right=606, bottom=766, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05001', left=300, top=687, right=606, bottom=722, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04001', left=300, top=644, right=606, bottom=678, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03001', left=300, top=600, right=606, bottom=634, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02001', left=300, top=556, right=606, bottom=591, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02003', left=947, top=556, right=1253, bottom=591, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03003', left=947, top=600, right=1253, bottom=634, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04003', left=947, top=644, right=1253, bottom=678, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05003', left=947, top=687, right=1253, bottom=722, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06003', left=947, top=731, right=1253, bottom=766, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07003', left=947, top=775, right=1253, bottom=809, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08003', left=947, top=819, right=1253, bottom=853, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09003', left=947, top=862, right=1253, bottom=897, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10003', left=947, top=906, right=1253, bottom=941, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11003', left=947, top=950, right=1253, bottom=984, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12003', left=947, top=994, right=1253, bottom=1028, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01003', left=947, top=512, right=1253, bottom=547, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC001', left=300, top=1037, right=606, bottom=1072, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC003', left=947, top=1037, right=1253, bottom=1072, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1238 ,top=244 ,right=1238 ,bottom=350 </L>
	<T>id='명' ,left=1481 ,top=303 ,right=1547 ,bottom=347 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(6)공제대상 가족의 수 (본인,배우자를 각각 1인으로 봄)' ,left=297 ,top=303 ,right=1231 ,bottom=347 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=291 ,top=297 ,right=1878 ,bottom=297 </L>
	<T>id='(4)성               명' ,left=297 ,top=250 ,right=613 ,bottom=294 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월별' ,left=13 ,top=412 ,right=88 ,bottom=503 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=13 ,top=512 ,right=88 ,bottom=547 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12' ,left=13 ,top=994 ,right=88 ,bottom=1028 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11' ,left=13 ,top=950 ,right=88 ,bottom=984 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10' ,left=13 ,top=906 ,right=88 ,bottom=941 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9' ,left=13 ,top=862 ,right=88 ,bottom=897 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=13 ,top=819 ,right=88 ,bottom=853 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=13 ,top=775 ,right=88 ,bottom=809 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=13 ,top=731 ,right=88 ,bottom=766 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=13 ,top=687 ,right=88 ,bottom=722 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=13 ,top=644 ,right=88 ,bottom=678 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=13 ,top=600 ,right=88 ,bottom=634 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=13 ,top=556 ,right=88 ,bottom=591 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(7)지급연월' ,left=97 ,top=412 ,right=288 ,bottom=503 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='YYYY', left=97, top=994, right=288, bottom=1028 ,mask='XXXX년 12월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=950, right=288, bottom=984 ,mask='XXXX년 11월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=906, right=288, bottom=941 ,mask='XXXX년 10월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=862, right=288, bottom=897 ,mask='XXXX년 09월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=819, right=288, bottom=853 ,mask='XXXX년 08월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=775, right=288, bottom=809 ,mask='XXXX년 07월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=731, right=288, bottom=766 ,mask='XXXX년 06월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=687, right=288, bottom=722 ,mask='XXXX년 05월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=644, right=288, bottom=678 ,mask='XXXX년 04월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=600, right=288, bottom=634 ,mask='XXXX년 03월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=556, right=288, bottom=591 ,mask='XXXX년 02월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SINC002', left=625, top=1037, right=931, bottom=1072, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12002', left=625, top=994, right=931, bottom=1028, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11002', left=625, top=950, right=931, bottom=984, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10002', left=625, top=906, right=931, bottom=941, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09002', left=625, top=862, right=931, bottom=897, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08002', left=625, top=819, right=931, bottom=853, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07002', left=625, top=775, right=931, bottom=809, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06002', left=625, top=731, right=931, bottom=766, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05002', left=625, top=687, right=931, bottom=722, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04002', left=625, top=644, right=931, bottom=678, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03002', left=625, top=600, right=931, bottom=634, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02002', left=625, top=556, right=931, bottom=591, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01002', left=625, top=512, right=931, bottom=547, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SINC004', left=1269, top=1037, right=1544, bottom=1072, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02004', left=1269, top=556, right=1544, bottom=591, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03004', left=1269, top=600, right=1544, bottom=634, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04004', left=1269, top=644, right=1544, bottom=678, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05004', left=1269, top=687, right=1544, bottom=722, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06004', left=1269, top=731, right=1544, bottom=766, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07004', left=1269, top=775, right=1544, bottom=809, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08004', left=1269, top=819, right=1544, bottom=853, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09004', left=1269, top=862, right=1544, bottom=897, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10004', left=1269, top=906, right=1544, bottom=941, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11004', left=1269, top=950, right=1544, bottom=984, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12004', left=1269, top=994, right=1544, bottom=1028, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01004', left=1269, top=512, right=1544, bottom=547, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='의한 소득세' ,left=1556 ,top=459 ,right=1869 ,bottom=500 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(12)간이세액표에' ,left=1556 ,top=412 ,right=1869 ,bottom=453 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=291 ,top=197 ,right=1878 ,bottom=197 </L>
	<T>id='(3)사업자등록번호' ,left=297 ,top=203 ,right=613 ,bottom=244 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(2)법 인 명 (상 호)' ,left=297 ,top=153 ,right=613 ,bottom=197 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수의무자' ,left=9 ,top=150 ,right=288 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=147 ,right=1878 ,bottom=147 </L>
	<L> left=291 ,top=147 ,right=291 ,bottom=350 </L>
	<L> left=616 ,top=147 ,right=616 ,bottom=297 </L>
	<L> left=944 ,top=244 ,right=944 ,bottom=297 </L>
	<C>id='SINC005', left=1556, top=1037, right=1869, bottom=1072, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC12005', left=1556, top=994, right=1869, bottom=1028, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC11005', left=1556, top=950, right=1869, bottom=984, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC10005', left=1556, top=906, right=1869, bottom=941, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC09005', left=1556, top=862, right=1869, bottom=897, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC08005', left=1556, top=819, right=1869, bottom=853, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC07005', left=1556, top=775, right=1869, bottom=809, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC06005', left=1556, top=731, right=1869, bottom=766, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC05005', left=1556, top=687, right=1869, bottom=722, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC04005', left=1556, top=644, right=1869, bottom=678, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC03005', left=1556, top=600, right=1869, bottom=634, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC02005', left=1556, top=556, right=1869, bottom=591, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC01005', left=1556, top=512, right=1869, bottom=547, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP11000', left=300, top=1081, right=606, bottom=1116, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP12000', left=625, top=1081, right=931, bottom=1116, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP13000', left=947, top=1081, right=1253, bottom=1116, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP10SUM', left=1269, top=1081, right=1544, bottom=1116, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=1119 ,right=1881 ,bottom=1119 </L>
	<L> left=1259 ,top=456 ,right=1259 ,bottom=1119 </L>
	<L> left=1550 ,top=406 ,right=1550 ,bottom=1119 </L>
	<L> left=291 ,top=406 ,right=291 ,bottom=1119 </L>
	<L> left=616 ,top=456 ,right=616 ,bottom=1119 </L>
	<L> left=938 ,top=456 ,right=938 ,bottom=1119 </L>
	<T>id='종전근무' ,left=97 ,top=1081 ,right=288 ,bottom=1116 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13' ,left=13 ,top=1081 ,right=88 ,bottom=1116 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1175 ,right=1881 ,bottom=1175 </L>
	<T>id='기 타 비 과 세' ,left=1266 ,top=1181 ,right=1869 ,bottom=1222 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(16) 생산직근로자' ,left=950 ,top=1184 ,right=1253 ,bottom=1225 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국 외 근 로 소 득' ,left=97 ,top=1181 ,right=938 ,bottom=1222 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=91 ,top=1225 ,right=941 ,bottom=1225 </L>
	<T>id='(15)원  화' ,left=584 ,top=1231 ,right=938 ,bottom=1272 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(13)지급연월' ,left=97 ,top=1231 ,right=288 ,bottom=1272 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1259 ,top=1225 ,right=1878 ,bottom=1225 </L>
	<L> left=3 ,top=1756 ,right=1878 ,bottom=1756 </L>
	<L> left=3 ,top=1712 ,right=1878 ,bottom=1712 </L>
	<L> left=3 ,top=1669 ,right=1878 ,bottom=1669 </L>
	<L> left=3 ,top=1625 ,right=1878 ,bottom=1625 </L>
	<L> left=3 ,top=1581 ,right=1878 ,bottom=1581 </L>
	<L> left=3 ,top=1537 ,right=1878 ,bottom=1537 </L>
	<L> left=3 ,top=1494 ,right=1878 ,bottom=1494 </L>
	<L> left=3 ,top=1450 ,right=1878 ,bottom=1450 </L>
	<L> left=3 ,top=1406 ,right=1878 ,bottom=1406 </L>
	<L> left=3 ,top=1362 ,right=1878 ,bottom=1362 </L>
	<L> left=3 ,top=1319 ,right=1878 ,bottom=1319 </L>
	<L> left=3 ,top=1275 ,right=1878 ,bottom=1275 </L>
	<C>id='FRE01003', left=947, top=1281, right=1253, bottom=1316, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02003', left=947, top=1325, right=1253, bottom=1359, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03003', left=947, top=1369, right=1253, bottom=1403, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04003', left=947, top=1412, right=1253, bottom=1447, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05003', left=947, top=1456, right=1253, bottom=1491, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06003', left=947, top=1500, right=1253, bottom=1534, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07003', left=947, top=1544, right=1253, bottom=1578, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08003', left=947, top=1587, right=1253, bottom=1622, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09003', left=947, top=1631, right=1253, bottom=1666, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10003', left=947, top=1675, right=1253, bottom=1709, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11003', left=947, top=1719, right=1253, bottom=1753, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12003', left=947, top=1762, right=1253, bottom=1797, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='야간근로수당등' ,left=950 ,top=1231 ,right=1253 ,bottom=1272 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12' ,left=13 ,top=1762 ,right=88 ,bottom=1797 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11' ,left=13 ,top=1719 ,right=88 ,bottom=1753 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10' ,left=13 ,top=1675 ,right=88 ,bottom=1709 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9' ,left=13 ,top=1631 ,right=88 ,bottom=1666 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=13 ,top=1587 ,right=88 ,bottom=1622 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=13 ,top=1544 ,right=88 ,bottom=1578 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=13 ,top=1500 ,right=88 ,bottom=1534 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=13 ,top=1456 ,right=88 ,bottom=1491 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=13 ,top=1412 ,right=88 ,bottom=1447 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=13 ,top=1369 ,right=88 ,bottom=1403 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=13 ,top=1325 ,right=88 ,bottom=1359 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=13 ,top=1281 ,right=88 ,bottom=1316 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월별' ,left=13 ,top=1181 ,right=88 ,bottom=1272 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE02001', left=300, top=1325, right=575, bottom=1359, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03001', left=300, top=1369, right=575, bottom=1403, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04001', left=300, top=1412, right=575, bottom=1447, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05001', left=300, top=1456, right=575, bottom=1491, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06001', left=300, top=1500, right=575, bottom=1534, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07001', left=300, top=1544, right=575, bottom=1578, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08001', left=300, top=1587, right=575, bottom=1622, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09001', left=300, top=1631, right=575, bottom=1666, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10001', left=300, top=1675, right=575, bottom=1709, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11001', left=300, top=1719, right=575, bottom=1753, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12001', left=300, top=1762, right=575, bottom=1797, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(14)외   화' ,left=300 ,top=1231 ,right=575 ,bottom=1272 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE01001', left=300, top=1281, right=575, bottom=1316, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE01002', left=584, top=1281, right=934, bottom=1316, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02002', left=584, top=1325, right=934, bottom=1359, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03002', left=584, top=1369, right=934, bottom=1403, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04002', left=584, top=1412, right=934, bottom=1447, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05002', left=584, top=1456, right=934, bottom=1491, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06002', left=584, top=1500, right=934, bottom=1534, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07002', left=584, top=1544, right=934, bottom=1578, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08002', left=584, top=1587, right=934, bottom=1622, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09002', left=584, top=1631, right=934, bottom=1666, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10002', left=584, top=1675, right=934, bottom=1709, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11002', left=584, top=1719, right=934, bottom=1753, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12002', left=584, top=1762, right=934, bottom=1797, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(17)내  용' ,left=1266 ,top=1231 ,right=1544 ,bottom=1272 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE01004', left=1266, top=1281, right=1544, bottom=1316, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02004', left=1266, top=1325, right=1544, bottom=1359, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03004', left=1266, top=1369, right=1544, bottom=1403, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04004', left=1266, top=1412, right=1544, bottom=1447, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05004', left=1266, top=1456, right=1544, bottom=1491, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06004', left=1266, top=1500, right=1544, bottom=1534, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07004', left=1266, top=1544, right=1544, bottom=1578, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08004', left=1266, top=1587, right=1544, bottom=1622, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09004', left=1266, top=1631, right=1544, bottom=1666, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10004', left=1266, top=1675, right=1544, bottom=1709, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11004', left=1266, top=1719, right=1544, bottom=1753, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE12004', left=1266, top=1762, right=1544, bottom=1797, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(18)금  액' ,left=1556 ,top=1231 ,right=1869 ,bottom=1272 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FRE12005', left=1556, top=1762, right=1869, bottom=1797, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE11005', left=1556, top=1719, right=1869, bottom=1753, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE10005', left=1556, top=1675, right=1869, bottom=1709, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE09005', left=1556, top=1631, right=1869, bottom=1666, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE08005', left=1556, top=1587, right=1869, bottom=1622, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE07005', left=1556, top=1544, right=1869, bottom=1578, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE06005', left=1556, top=1500, right=1869, bottom=1534, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE05005', left=1556, top=1456, right=1869, bottom=1491, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE04005', left=1556, top=1412, right=1869, bottom=1447, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE03005', left=1556, top=1369, right=1869, bottom=1403, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE02005', left=1556, top=1325, right=1869, bottom=1359, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRE01005', left=1556, top=1281, right=1869, bottom=1316, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='비      과      세      소      득' ,left=13 ,top=1125 ,right=1872 ,bottom=1172 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1800 ,right=1878 ,bottom=1800 </L>
	<C>id='SFRE005', left=1556, top=1806, right=1869, bottom=1841, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE003', left=947, top=1806, right=1253, bottom=1841, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE002', left=584, top=1806, right=934, bottom=1841, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SFRE001', left=300, top=1806, right=575, bottom=1841, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP21000', left=584, top=1850, right=934, bottom=1884, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP22000', left=947, top=1850, right=1253, bottom=1884, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP23000', left=1556, top=1850, right=1869, bottom=1884, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=1844 ,right=1878 ,bottom=1844 </L>
	<T>id='종전근무' ,left=97 ,top=1850 ,right=288 ,bottom=1884 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13' ,left=13 ,top=1850 ,right=88 ,bottom=1884 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1891 ,right=1875 ,bottom=1891 </L>
	<L> left=291 ,top=1228 ,right=291 ,bottom=1891 </L>
	<L> left=578 ,top=1228 ,right=578 ,bottom=1891 </L>
	<L> left=941 ,top=1175 ,right=941 ,bottom=1891 </L>
	<L> left=1259 ,top=1175 ,right=1259 ,bottom=1891 </L>
	<L> left=1550 ,top=1225 ,right=1550 ,bottom=1891 </L>
	<C>id='SCOL004', left=672, top=2575, right=916, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02004', left=672, top=2094, right=916, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03004', left=672, top=2137, right=916, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04004', left=672, top=2181, right=916, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05004', left=672, top=2225, right=916, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06004', left=672, top=2269, right=916, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07004', left=672, top=2312, right=916, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08004', left=672, top=2356, right=916, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09004', left=672, top=2400, right=916, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10004', left=672, top=2444, right=916, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11004', left=672, top=2487, right=916, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12004', left=672, top=2531, right=916, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01004', left=672, top=2050, right=916, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2050, right=1869, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2094, right=1869, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2137, right=1869, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2181, right=1869, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2225, right=1869, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2269, right=1869, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2312, right=1869, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2356, right=1869, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2400, right=1869, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2444, right=1869, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2487, right=1869, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2531, right=1869, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2575, right=1869, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12008', left=1556, top=2531, right=1734, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11008', left=1556, top=2487, right=1734, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10008', left=1556, top=2444, right=1734, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09008', left=1556, top=2400, right=1734, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08008', left=1556, top=2356, right=1734, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07008', left=1556, top=2312, right=1734, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06008', left=1556, top=2269, right=1734, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05008', left=1556, top=2225, right=1734, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04008', left=1556, top=2181, right=1734, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03008', left=1556, top=2137, right=1734, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02008', left=1556, top=2094, right=1734, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01008', left=1556, top=2050, right=1734, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL008', left=1556, top=2575, right=1734, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02007', left=1347, top=2094, right=1544, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03007', left=1347, top=2137, right=1544, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04007', left=1347, top=2181, right=1544, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05007', left=1347, top=2225, right=1544, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06007', left=1347, top=2269, right=1544, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07007', left=1347, top=2312, right=1544, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08007', left=1347, top=2356, right=1544, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09007', left=1347, top=2400, right=1544, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10007', left=1347, top=2444, right=1544, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11007', left=1347, top=2487, right=1544, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12007', left=1347, top=2531, right=1544, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01007', left=1347, top=2050, right=1544, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL007', left=1347, top=2575, right=1544, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02006', left=1125, top=2094, right=1334, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03006', left=1125, top=2137, right=1334, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04006', left=1125, top=2181, right=1334, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05006', left=1125, top=2225, right=1334, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06006', left=1125, top=2269, right=1334, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07006', left=1125, top=2312, right=1334, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08006', left=1125, top=2356, right=1334, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09006', left=1125, top=2400, right=1334, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10006', left=1125, top=2444, right=1334, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11006', left=1125, top=2487, right=1334, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12006', left=1125, top=2531, right=1334, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01006', left=1125, top=2050, right=1334, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL006', left=1125, top=2575, right=1334, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01005', left=928, top=2050, right=1113, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12005', left=928, top=2531, right=1113, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11005', left=928, top=2487, right=1113, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10005', left=928, top=2444, right=1113, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09005', left=928, top=2400, right=1113, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08005', left=928, top=2356, right=1113, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07005', left=928, top=2312, right=1113, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06005', left=928, top=2269, right=1113, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05005', left=928, top=2225, right=1113, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04005', left=928, top=2181, right=1113, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03005', left=928, top=2137, right=1113, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02005', left=928, top=2094, right=1113, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL005', left=928, top=2575, right=1113, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01003', left=484, top=2050, right=663, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12003', left=484, top=2531, right=663, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11003', left=484, top=2487, right=663, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10003', left=484, top=2444, right=663, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09003', left=484, top=2400, right=663, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08003', left=484, top=2356, right=663, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07003', left=484, top=2312, right=663, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06003', left=484, top=2269, right=663, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05003', left=484, top=2225, right=663, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04003', left=484, top=2181, right=663, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03003', left=484, top=2137, right=663, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02003', left=484, top=2094, right=663, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCOL003', left=484, top=2575, right=663, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(21)주민세' ,left=484 ,top=2000 ,right=663 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SCOL002', left=297, top=2575, right=475, bottom=2609, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01002', left=297, top=2050, right=475, bottom=2084, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02002', left=297, top=2094, right=475, bottom=2128, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03002', left=297, top=2137, right=475, bottom=2172, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04002', left=297, top=2181, right=475, bottom=2216, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05002', left=297, top=2225, right=475, bottom=2259, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06002', left=297, top=2269, right=475, bottom=2303, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07002', left=297, top=2312, right=475, bottom=2347, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08002', left=297, top=2356, right=475, bottom=2391, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09002', left=297, top=2400, right=475, bottom=2434, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10002', left=297, top=2444, right=475, bottom=2478, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11002', left=297, top=2487, right=475, bottom=2522, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12002', left=297, top=2531, right=475, bottom=2566, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL12001', left=97, top=2531, right=288, bottom=2566 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL11001', left=97, top=2487, right=288, bottom=2522 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL10001', left=97, top=2444, right=288, bottom=2478 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL09001', left=97, top=2400, right=288, bottom=2434 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL08001', left=97, top=2356, right=288, bottom=2391 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL07001', left=97, top=2312, right=288, bottom=2347 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL06001', left=97, top=2269, right=288, bottom=2303 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL05001', left=97, top=2225, right=288, bottom=2259 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL04001', left=97, top=2181, right=288, bottom=2216 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL03001', left=97, top=2137, right=288, bottom=2172 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL02001', left=97, top=2094, right=288, bottom=2128 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COL01001', left=97, top=2050, right=288, bottom=2084 ,mask='XXXX년 XX월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(19)감면세액' ,left=97 ,top=1950 ,right=288 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월별' ,left=13 ,top=1950 ,right=88 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12' ,left=13 ,top=2531 ,right=88 ,bottom=2566 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11' ,left=13 ,top=2487 ,right=88 ,bottom=2522 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10' ,left=13 ,top=2444 ,right=88 ,bottom=2478 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9' ,left=13 ,top=2400 ,right=88 ,bottom=2434 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=13 ,top=2356 ,right=88 ,bottom=2391 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=13 ,top=2312 ,right=88 ,bottom=2347 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=13 ,top=2269 ,right=88 ,bottom=2303 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5' ,left=13 ,top=2225 ,right=88 ,bottom=2259 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4' ,left=13 ,top=2181 ,right=88 ,bottom=2216 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=13 ,top=2137 ,right=88 ,bottom=2172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=13 ,top=2094 ,right=88 ,bottom=2128 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=13 ,top=2050 ,right=88 ,bottom=2084 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=2525 ,right=1878 ,bottom=2525 </L>
	<L> left=3 ,top=2481 ,right=1878 ,bottom=2481 </L>
	<L> left=3 ,top=2437 ,right=1878 ,bottom=2437 </L>
	<L> left=3 ,top=2394 ,right=1878 ,bottom=2394 </L>
	<L> left=3 ,top=2350 ,right=1878 ,bottom=2350 </L>
	<L> left=3 ,top=2306 ,right=1878 ,bottom=2306 </L>
	<L> left=3 ,top=2262 ,right=1878 ,bottom=2262 </L>
	<L> left=3 ,top=2219 ,right=1878 ,bottom=2219 </L>
	<L> left=3 ,top=2175 ,right=1878 ,bottom=2175 </L>
	<L> left=3 ,top=2131 ,right=1878 ,bottom=2131 </L>
	<L> left=3 ,top=2087 ,right=1878 ,bottom=2087 </L>
	<L> left=3 ,top=2612 ,right=1878 ,bottom=2612 </L>
	<L> left=3 ,top=2044 ,right=1878 ,bottom=2044 </L>
	<L> left=3 ,top=2569 ,right=1878 ,bottom=2569 </L>
	<T>id='(20)소득세' ,left=297 ,top=2000 ,right=475 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(22)농어촌특별세' ,left=672 ,top=2000 ,right=916 ,bottom=2041 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(23)연금보험' ,left=928 ,top=2000 ,right=1113 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(24)건강보험' ,left=1125 ,top=2000 ,right=1334 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(25)고용보험' ,left=1347 ,top=2000 ,right=1544 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(26)기부금' ,left=1556 ,top=2000 ,right=1734 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1747 ,top=2000 ,right=1869 ,bottom=2041 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=291 ,top=1994 ,right=1878 ,bottom=1994 </L>
	<T>id='차   감   원   천   징   수   액' ,left=297 ,top=1950 ,right=919 ,bottom=1991 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=1944 ,right=1875 ,bottom=1944 </L>
	<T>id='징수의무자 자체 증빙 지출액(소득공제)' ,left=928 ,top=1950 ,right=1872 ,bottom=1991 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210mm x 297mm(신문용지 54g/㎡)' ,left=888 ,top=2737 ,right=1878 ,bottom=2778 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13' ,left=13 ,top=2619 ,right=88 ,bottom=2653 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종전근무' ,left=97 ,top=2619 ,right=288 ,bottom=2653 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BP41000', left=297, top=2619, right=475, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP42000', left=484, top=2619, right=663, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP43000', left=672, top=2619, right=916, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP31000', left=928, top=2619, right=1113, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP32000', left=1125, top=2619, right=1334, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP33000', left=1347, top=2619, right=1544, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1747, top=2619, right=1869, bottom=2653, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=2656 ,right=1878 ,bottom=2656 </L>
	<L> left=3 ,top=2731 ,right=1875 ,bottom=2731 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1878 ,top=50 ,right=1878 ,bottom=2731 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3 ,top=50 ,right=3 ,bottom=2731 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=291 ,top=1944 ,right=291 ,bottom=2653 </L>
	<L> left=478 ,top=1994 ,right=478 ,bottom=2656 </L>
	<L> left=666 ,top=1994 ,right=666 ,bottom=2656 </L>
	<L> left=922 ,top=1944 ,right=922 ,bottom=2653 </L>
	<L> left=1119 ,top=1994 ,right=1119 ,bottom=2656 </L>
	<L> left=1341 ,top=1994 ,right=1341 ,bottom=2656 </L>
	<L> left=1550 ,top=1994 ,right=1550 ,bottom=2656 </L>
	<L> left=1741 ,top=1994 ,right=1741 ,bottom=2656 </L>
	<T>id='(서명 또는 인)' ,left=1544 ,top=2669 ,right=1825 ,bottom=2716 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=1144 ,top=2669 ,right=1488 ,bottom=2716 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수의무자 : ' ,left=728 ,top=2669 ,right=1072 ,bottom=2716 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=350, top=2669, right=631, bottom=2716, align='left' ,mask='XXXX년 XX월 XX일', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성일자 :' ,left=147 ,top=2669 ,right=344 ,bottom=2716 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BP40SUM', left=1556, top=1081, right=1869, bottom=1116, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=91 ,top=1944 ,right=91 ,bottom=2569 </L>
	<L> left=91 ,top=2612 ,right=91 ,bottom=2656 </L>
	<L> left=91 ,top=1175 ,right=91 ,bottom=1800 </L>
	<L> left=91 ,top=406 ,right=91 ,bottom=1031 </L>
	<L> left=91 ,top=1075 ,right=91 ,bottom=1119 </L>
	<L> left=91 ,top=1844 ,right=91 ,bottom=1891 </L>
	<T>id='현대아산(주)' ,left=656 ,top=153 ,right=909 ,bottom=194 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='101-85-10695' ,left=656 ,top=203 ,right=941 ,bottom=241 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근  로  소  득  원  천  징  수  액' ,left=13 ,top=1894 ,right=1872 ,bottom=1941 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=13 ,top=1037 ,right=288 ,bottom=1072 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='계' ,left=13 ,top=1806 ,right=288 ,bottom=1841 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=13 ,top=2575 ,right=288 ,bottom=2609 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='YYYY', left=97, top=512, right=288, bottom=547 ,mask='XXXX년 01월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1281, right=288, bottom=1316 ,mask='XXXX년 01월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1325, right=288, bottom=1359 ,mask='XXXX년 02월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1369, right=288, bottom=1403 ,mask='XXXX년 03월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1412, right=288, bottom=1447 ,mask='XXXX년 04월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1456, right=288, bottom=1491 ,mask='XXXX년 05월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1500, right=288, bottom=1534 ,mask='XXXX년 06월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1544, right=288, bottom=1578 ,mask='XXXX년 07월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1587, right=288, bottom=1622 ,mask='XXXX년 08월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1631, right=288, bottom=1666 ,mask='XXXX년 09월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1675, right=288, bottom=1709 ,mask='XXXX년 10월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1719, right=288, bottom=1753 ,mask='XXXX년 11월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YYYY', left=97, top=1762, right=288, bottom=1797 ,mask='XXXX년 12월', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
">
	
</object></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	