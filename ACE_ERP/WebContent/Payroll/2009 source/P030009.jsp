<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 급여시스템
 * 프로그램ID 	: P03000
 * J  S  P		: P030009i
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의		:	ds1) 기본정보 + 기타공제 일부
 					ds2) 종전근무지 
					ds3) 인적공제
					ds4) 기부
 *                   
 * 최종수정일자 	: 2007-01-11
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//귀속년도
    String eno 		 = request.getParameter("eno");				//사번
    
    eyy="2006";
%>


<HTML>
<HEAD>
<TITLE>2006년 근로소득공제 신고서 입력</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">
<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>

<!-- 기존 가우스 시작-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>
<script language="javascript" src="js/embedControl.js"></script>
<script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_gauce.js"></script>
<script language="javascript" src="js/common_pop.js"></script>      
<script language="javascript" src="js/common.js"></script>       
<SCRIPT language=JavaScript src="imgs/web.js"></SCRIPT>
<SCRIPT language=JavaScript src="imgs/06YearEntry.js"></SCRIPT>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //등록
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	
	//var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
	function ln_Start(){
		//그리드 스타일 넣기
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn");		
		cfStyleGrid(getObjectFirst("gr3"), "comn");				

		//데이터셋 헤더 설정
		ln_SetDataHeader();
			
		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
		fnSelect2("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (종전근무)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
		fnSelect4("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (기부금)		
	}
	
	function ln_SetDataHeader(){
//		var s_temp = "VD_FAXNO:DECIMAL,POST_NO1:STRING,POST_NO2:STRING,ADDRESS1:STRING,VEND_ID:STRING";
		var s_temp = "REFc1:DECIMAL,REFc2:DECIMAL";
		ds3.SetDataHeader(s_temp);
	}	

/******************************************************************************
	Description : 기본조회
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //기본 조회
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);
			tr_post(tr1);
	}

	function fnSelect2(pYear, pEmpno) {	 //종전근무지
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
	}	
	
	function fnSelect3(pYear, pEmpno) {	 //인적공제
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
	}	

	function fnSelect4(pYear, pEmpno) {	 //기부금
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS4=ds4)",
			    param);
			tr_post(tr1);
	}	
	
	
/******************************************************************************
	Description : 추가, 삭제, 저장, 취소
******************************************************************************/
    function fnApply() {// 현재 데이터셋 반영
		v_job = "I";	
        if (ds1.IsUpdated) {
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("기본공제 정보의 변경 내역이 없습니다.");
        }
    }
    
	function fnCancel() {	//취소시 undo all. 
		ds1.undoall();
	} 

	function fnAddRow3(){
		ds3.addrow();	
		ds3.namevalue(ds3.rowposition, "APPDT")="<%=eyy%>12";
		ds3.namevalue(ds3.rowposition, "EMPNO")="<%=eno%>";		

	};
	function fnDeleteRow3() {//Row 삭제
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("마감된 자료입니다. 삭제할수 없습니다");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds3.DeleteRow(ds3.RowPosition);
	}

    function fnApply3() {// 현재 데이터셋 반영
		v_job = "I";	
        if (ds3.IsUpdated) {
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i",
                "JSP(I:DS3=ds3,O:RESULT=ds_result)",	//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("인적공제 정보의 변경 내역이 없습니다.");
        }
    };

	function fnCancel3() {	//취소시 undo all. 
		ds3.undoall();
	};



/******************************************************************************
	Description : 각 팝업창 띄우기
******************************************************************************/
function openOfc(){
	dest = "P030009_ofc1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"ofc", "left=0,top=0,width=704,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openInsu(juno){
	dest = "P030009_insu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=800,height=540,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openMedi(juno){
	dest = "P030009_medi1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=1000,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openEdu(juno){
	dest = "P030009_edu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=900,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openCard(juno){
	dest = "P030009_card1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=840,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openGibu(){
	dest = "P030009_gibu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"gibu", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

</script>

<script language=javascript for="gr3" event="OnClick(Row, Colid)">
//인적공제 클릭할 때 팝업 띄우기

    if(Row<1){
     return;
    }

    if ( (Colid =="REF11") || (Colid =="REF21") || (Colid =="REF12") || (Colid == "REF22")||(Colid =="REF13") || (Colid == "REF23")||(Colid =="REF14")||(Colid == "REF24") ) {
	    if (ds3.namevalue(ds3.rowposition, "RESINO1").length < 13) {
	    	alert("인적공제 대상자정보를 먼저 입력/저장 후 상세입력창을 띄워주세요.");
	    	return;
	    };
    };
    
    
    if ((Colid =="REF11") || (Colid =="REF21")) {
//    	alert("보험료");
    	openInsu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF12") || (Colid == "REF22")) {
//    	alert("의료비");    
		openMedi(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF13") || (Colid == "REF23")) {	
//    	alert("교육비");    
		openEdu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF14") || (Colid == "REF24")) {
//    	alert("카드/현");    
		openCard(ds3.namevalue(ds3.rowposition, "RESINO1"));
	}

//    alert(ds3.namevalue(ds3.rowposition, "REF11"));
//REF11,21,12,22,13,23,14,24
	
	    
</script>

<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//저장
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
//		fnSelect2("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (종전근무)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
//		fnSelect4("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (기부금)		

		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    };	
	// 여기까지 테스트 완료 : ds_result에 대한 선언도 다 해주어야 오류가 안난다.~
</script>



<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
// 결과 메세지 확인...
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
if(Row==0) return;
</script>
<%=HDConstant.COMMENT_START%>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>




<BODY text=#000000 bgColor=#ffffff style='padding:0px' OnLoad="ln_Start()"> 
<FORM name=entry action="" method=post>
	<INPUT type=hidden value=2006 name=eyy> 
	<INPUT type=hidden value=200089 name=eno> <!-- 사번 -->

<%=HDConstant.COMMENT_START%>
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='년월'				ID=APPDT   		Width=63	</C>    
	<C> Name='사번'				ID=EMPNO  		Width=60	</C>    
	<C> Name='소속부서'			ID=DEPTCD  		Width=60	</C>    
	<C> Name='직위'				ID=PAYGRD  		Width=60	</C>    
	<C> Name='그룹입사일'			ID=JOINDATE  	Width=60	</C>    
	<C> Name='성명'				ID=EMPNMK  		Width=40	</C>    
	<C> Name='주민번호'			ID=EMPJUNO  	Width=60	</C> 	
	<C> Name='전화번호'			ID=TELNUM	  	Width=60	</C>
	<C> Name='주소'				ID=ADDRESS  	Width=60	</C>
	<C> Name='과세급여'			ID=TAX_PAY  	Width=60	</C>
	<C> Name='과세상여'			ID=TAX_BNS  	Width=60	</C>
	<C> Name='과세소득계'			ID=TAX_SUM  	Width=60	</C>
	<C> Name='비과세소득계'		ID=NTAX_SUM  	Width=60	</C>
	<C> Name='갑근세'  			ID=DEDUCT1 		Width=60	</C>	
	<C> Name='주민세'  			ID=DEDUCT2 		Width=60	</C>	
	<C> Name='국민연금'			ID=DEDUCT3 		Width=60	</C>                                                             
	<C> Name='건강보험'			ID=DEDUCT4 		Width=60	</C>
	<C> Name='고용보험'			ID=DEDUCT5  	Width=60	</C>
	
	<C> Name='주택마련저축액'		ID=HOUAMT01 		Width=63	</C>    
	<C> Name='주택차입금상환'		ID=HOUAMT02 		Width=60	</C>    
	<C> Name='주택저당차임6'		ID=HOUAMT03 		Width=60	</C>    
	<C> Name='주택저당차임10'		ID=HOUAMT04 		Width=60	</C>    
	<C> Name='주택자금계'			ID=HOUSUM 	     	Width=60	</C>    
	<C> Name='기부금계'			ID=CONSUM	 		Width=60	</C>
	<C> Name='개인연금'			ID=ETCAMT011    	Width=40	</C>    
	<C> Name='연금저축'			ID=ETCAMT01 		Width=60	</C>
	<C> Name='주택차입금(세액'		ID=DEDAMT03 		Width=60	</C>
	<C> Name='정치기부금(세액'		ID=DEDAMT04		Width=60	</C>	
	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	</C>		
	">
</OBJECT>	

<OBJECT id=gr2  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds2">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='근무처명'			ID=BF_WKNM     			Width=60	</C>    
	<C> Name='사업자등'			ID=BF_RESINO			Width=60	</C> 
	<C> Name='과세급여'			ID=BF_TAX_PAY			Width=60	</C>    
	<C> Name='과세상여'			ID=BF_TAX_BNS			Width=60	</C> 
	<C> Name='과세소득'			ID=BF_TAX_SUM 			Width=60	</C>    
	<C> Name='비과세소'			ID=BF_NTAX_SUM 			Width=60	</C> 
	<C> Name='결정소득'			ID=BF_DEDUCT1   		Width=60	</C>    
	<C> Name='결정주민'			ID=BF_DEDUCT2			Width=60	</C> 
	<C> Name='국민연금'			ID=BF_DEDUCT3			Width=60	</C>    
	<C> Name='건강보험'			ID=BF_DEDUCT4			Width=60	</C> 
	<C> Name='건강보험'			ID=BF_DEDUCT5			Width=60	</C>
	">
</OBJECT>	

<OBJECT id=gr4  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds4">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='법정 국세청'		ID=GIVAMT_10A 	Width=60	</C>    
	<C> Name='법정 그밖'		ID=GIVAMT_10B	Width=60	</C>    
	<C> Name='정치 국세청'		ID=GIVAMT_20A	Width=60	</C>    
	<C> Name='정치 그밖'		ID=GIVAMT_20B	Width=60	</C>    
	<C> Name='지정 국세청'		ID=GIVAMT_40A	Width=60	</C>    
	<C> Name='지정 그밖'		ID=GIVAMT_40B 	Width=60	</C>    
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>



<TABLE cellSpacing=0 cellPadding=0 width=854 border=0>
  <TR>
    <TD vAlign=top width=1003 bgColor=#ffffff height=62>

	  <TABLE cellSpacing=0 cellPadding=0 width=1003 align=center border=0>
        <TR>
          <TD><IMG src="imgs/tit_01_14.gif"></TD>
		</TR>
	  </TABLE>
	  
	  
	  <BR>
	  <!--인적사항 -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=30 bgColor=#aad2ff rowSpan=4>인적<BR>사항 
          <TD width=82>사원번호</TD>
          <TD width=160>소속</TD>
          <TD width=140>직위</TD>
          <TD width=106>그룹입사일</TD>
          <TD width=140>성명</TD>
          <TD width=150>주민등록번호</TD>
          <TD>전화번호</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNO" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="DEPTCD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="PAYGRD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="JOINDATE" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNMK" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="000000-0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="TELNUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="00000000000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
        </TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD colSpan=4>주 소</TD>
          <TD colSpan=3>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
          <TD colSpan=4><%=HDConstant.COMMENT_START%>
				<object id="ADDRESS" style= "position:relative;left:0px;top:2px;width:465px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD colSpan=3>&nbsp;</TD>
		</TR>
	  </TABLE>
		  
	
	<!-- 근로소득 -->
	  <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER>
          <TD width=30 bgColor=#aad2ff rowSpan=2>구분</TD>
          <TD bgColor=#aad2ff colSpan=4>2006년 근로소득</TD>
          <TD bgColor=#aad2ff colSpan=5>2006년 원천징수</TD>
          <TD bgColor=#aad2ff>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=79>과세급여</TD>
          <TD width=79>과세상여</TD>
          <TD width=79>과세소득 계</TD>
          <TD width=79>비과세소득 계</TD>
          <TD width=79>갑근세</TD>
          <TD width=79>주민세</TD>
          <TD width=79>국민연금</TD>
          <TD width=79>건강보험</TD>
          <TD width=79>고용보험</TD>
          <TD>&nbsp;</TD>
		</TR>
        <TR align=CENTER>
          <TD bgColor=#e8f3ff>금액</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_PAY" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff>&nbsp;</TD>
		</TR>
        <TR bgColor=#ffffff>
          <TD colSpan=14><!--
						&nbsp;&nbsp;☞ 참고사항 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;① 주 식 소 득 : 2004년 연말정산시 우리사주조합 소득공제를 받았던 사람이
						2006년 ESOP주식 인출하여 발생한 소득은 &quot;근로소득&quot;에 합산됩니다. <br>
						&nbsp;&nbsp;&nbsp;&nbsp;② 비과세소득 : 육원 - 해외근무자 월 100만원, 자녀보육수당 10만원 / 해원 - 외국항해 선원 월 150만원,
						황열접종비 등 기타 비과세소득 <br>-->
			&nbsp;&nbsp;<FONT color=#ff6633>☞ 위 금액은 12월 급여 지급 전 조회자료이므로 2006년 최종 확정 금액이 아닙니다.</FONT> </TD>
		  </TR>
	  </TABLE><BR><BR>

	  <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD colSpan=6><B>I. 당해년도 "경력입사자 및 근무처가 2곳 이상인 경우" 전(종)근무지 소득 및 원천징수 현황을 입력바랍니다.</B></TD></TR>
        <TR bgColor=#ffffff>
          <TD></TD>
          <TD width=25></TD>
          <TD></TD>
          <TD width=40></TD>
          <TD></TD>
          <TD width=470>&nbsp;</TD></TR></TABLE><!-- 전근무지 원천징수 현황 -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR align=CENTER>
          <TD width=30 bgColor=#ffedd2 rowSpan=2>구분</TD>
          <TD bgColor=#ffedd2 colSpan=2  onclick="openOfc();" style="cursor:hand"><b>회사명</b></TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_WKNM" style= "position:relative;left:0px;top:2px;width:265px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2 colSpan=2>사업자등록번호</TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_RESINO" style= "position:relative;left:0px;top:2px;width:165px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffedd2>
          <TD align=CENTER>과세급여</TD>
          <TD align=CENTER>과세상여</TD>
          <TD align=CENTER>과세소득 계</TD>
          <TD align=CENTER>비과세소득 계</TD>
          <TD align=CENTER>결정갑근세</TD>
          <TD align=CENTER>결정주민세</TD>
          <TD align=CENTER>국민연금</TD>
          <TD align=CENTER>건강보험</TD>
          <TD align=CENTER>고용보험</TD></TR>
        <TR align=left>
          <TD align=CENTER bgColor=#ffedd2>금액</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_PAY" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

		</TR>
	  </TABLE>


	  <BR>
	  <BR>

	  <!-- 인적사항 및 공제항목 -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=800><B>Ⅱ. 다음 본인과 부양가족의 인적사항 및 공제 항목을 선택(√) 또는 입력바랍니다.</B> 
          </TD>
          <TD vAlign=bottom align=right></TD>
          <TD vAlign=bottom align=right></TD></TR>
        <TR>
          <TD width=800><FONT color=#3366ff>&nbsp;&nbsp;☞ 주의사항 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;① "정산절차안내"를 반드시 숙지하신 후 입력바랍니다. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;② 입력 및 수정후에는 반드시 "저장" 버튼을 눌러주시기 바랍니다. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff6633><B>※&nbsp;국세청 자료란 : 
            국세청 홈페이지에서 제공하는 증빙서류상의 금액 
            입력</B></FONT><BR>&nbsp;&nbsp;&nbsp;&nbsp;<B>※&nbsp;그밖의 자료란 : 국세청에서 
            제공하는 증빙서류 이외의 것 입력</B> </FONT></TD>
          <TD vAlign=bottom align=right colSpan=2><!-- <A 
            href="javascript:showDiv('write_guide',%20'../../images/Self/btn_guideclose.gif',%20'../../images/Self/btn_guideopen.gif');"><IMG 
            id=imgsrc src="imgs/btn_guideopen.gif" border=0></A> -->
        </TD></TR></TABLE>

      <DIV id=write_guide style="DISPLAY: none">
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=12 bgColor=#ffedd2 
            rowSpan=30>인<BR><BR>적<BR><BR>공<BR><BR>제<BR><BR>작<BR><BR>성<BR><BR>요<BR><BR>령</TD>
          <TD vAlign=top>
            <TABLE cellSpacing=0 cellPadding=2 width="100%" border=0>
              
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>1. 기본공제</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) 관 계 : 생계를 같이하는(주민등록등본상 동거가족) 근로자(배우자 포함)의 
                  직계존속(외조부모 포함), 자녀, 형제자매</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) 세대주 : 근로자 본인이 주민등록등본상 세대주임을 반드시 체크하여야 
                  <U><B>"주택자금 공제"</B></U>를 신청할 수 있음. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) 내·외국인 : 배우자 및 부양가족이 외국인일 경우 "외국인 □"란에 체크한 후 
                  <U><B>"외국인등록번호 또는 여권번호"</B></U>를 기재함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) 주민등록번호 : 입력한 출생년도로 부양가족 기본공제 적용 연령과 
                  추가공제(자녀양육비, 경로우대) 가능 여부를 자동체크함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>① 배 우 자 : 
                  연령제한 없음. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>② 부양가족 : 
                  만60세 이상 남성 직계존속·형제 - 1946.12.31 이전 
                  生&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;만55세 이상 여성 
                  직계존속·자매 - 1951.12.31 이전生 
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  만20세 이하 직계비속·형제자매 - 1986.01.01 이후生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>③ 자녀양육 : 
                  만6세 이하 직계비속 - 2000.01.01 이후生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>④ 경로우대 : 
                  만65세~69세 - 1941.12.31 
                  이전生&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;만70세 이상 - 
                  1936.12.31 이전生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#ff6633>5) 연간 소득금액 : <U><B>"부양가족 
                  연령조건"</B></U>에 충족되는 자의 연간 총소득금액(급/상여 + 퇴직금 + 이자소득 + 사업소득 등 
                  합계액)이 
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  "100만원이하(소득공제 차감 후 금액)"인 경우 반드시 체크하여야 배우자 및 부양가족의 기본공제를 받을 수 
                  있음. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">※ 연간 총소득금액 = 실제 과세소득 - 
                  소득공제(필요경비적 공제) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">&nbsp;&nbsp;&nbsp;&nbsp;예) 
                  근로소득(급/상여)만 있는 경우 실제소득이 <U><B>약 700만원 이하</B></U>인 경우는 공제 가능하나, 
                  100만원 이상의 퇴직금이 포함된 경우는 공제 불가능함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>2. 추가공제</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) 부녀자 여부 : 근로자 본인이 여성인 경우에만 체크할 수 있음. (남성 근로자는 
                  선택란이 비활성화 되어 체크 불가능함.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">① 미혼여성인 경우 : 주민등록등본상 기본공제를 적용받는 
                  부양가족이 있는 세대주이면 공제 가능함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">② 기혼여성인 경우 : 혼인신고를 한 부녀자이면 공제 
                  가능함. (남편의 소득유무 상관없음.) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) 자녀양육비 : 직계비속이 만6세 이하인 경우에만 체크할 수 있음. (만7세 
                  초과자는 선택란이 비활성화 되어 체크 불가능함.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">※ 맞벌이 부부인 경우 - 부모中 1인만 선택 공제 받음 
                </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 200px">- 한 자녀에 대해 본인이 기본공제를 받고 배우자가 
                  추가로 자녀양육비공제를 받을 수 있음. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) 장애인 여부 : 연령제한은 없으나, 연간 총소득금액이 100만원 이하인 장애인인 
                  경우에만 해당란에 체크할 수 있음.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">(연간 소득금액 100만원 이하 □ 란에 체크 안 한 
                  경우 선택란이 비활성화되어 체크 불가능함)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>3. 특별공제</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>※ 국세청 자료 : 국세청 홈페이지에서 제공하는 
                  자료 (대표적 예 - 현금영수증)</FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>&nbsp;&nbsp;&nbsp;&nbsp;그밖의 
                  자료 : 국세청에서 제공하는 증빙서류 이외의 것 (기존처럼 각 해당 금융기관 등에서 제공하는 자료) 
                </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) 보험료 : 본인 및 생계를 같이하는 가족을 "피보험자"로 하여 당해 근로자가 직접 
                  불입한 "소득공제 가능한 보장성 보험료 연간 합계액 " 기재 </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px"><FONT color=#ff6633>※ 배우자 및 
                  부양가족이 기본공제 적용자(연령·소득요건 충족자)여야 해당란이 활성화되어 입력 가능함. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">※ 장애인전용보험은 피보험자가 연간 소득금액 100만원 
                  이하인 장애인이어야 하며 증명서류상에 "장애인 전용 보장성 보험료"라고 기재되어 있어야 함.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) 의료비 : 본인 및 생계를 같이하는 가족을 위하여 당해 근로자가 직접 지출한 치료 
                  및 요양목적의 의료비 기재 <U><B>(수납금액 = 소득공제 대상액)</B></U> </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">※ 안경 및 콘택트렌즈 구입비용은 1인당 50만원 
                  한도내에서 의료비 지출액에 포함됨. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) 교육비 : 본인 및 생계를 같이하는 가족을 위하여 지출한 수업료, 입학금, 
                  보육비용, 취학전 아동의 학원수강료 등 기재 </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) 신용카드·학원비 지로납부·현금영수증 : 본인 및 생계를 같이하는 가족(형제자매 
                  제외)이 지출한 신용카드·현금영수증 공제 대상액 및 학원의 설립운영 및 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  과외교습에 관한 법률에 의한 학원의 수강료 등을 반드시 <U><B>"지로(ZERO)용지"</B></U>를 
                  이용하여 결제한 금액 기재</TD></TR></TABLE></TD></TR></TABLE></DIV>


<table width=1003>
	<tr>
		<td>&nbsp;</td>
		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">
			<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply3();">
			<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel3()">
		</nobr>&nbsp;</td>
	</tr>					
</table>

<!-- CheckBox형태로 표시할 Column은 Interger인 경우  Check Data는 1, 0을 사용하며, String인 경우 Check Data는 ‘T’, ‘F’를 사용한다-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gr3  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 1003px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds3">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<Param Name="UsingOneClick"   value="1">	
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<G> name='근로소득자'	
		<C> Name='관계'		ID=RELAT1	HeadAlign=Center align=center   Width=63  EditStyle=Combo
	 		Data='0:본인,1:소득직계,2:배우직계,3:배우자,4:직계비속,5:형제자매,6:기타'</C>
		<C> Name='성명'		ID=FAMNM1	HeadAlign=Center align=center   		Width=63	</C>
		<C> Name='외국인'		ID=REF1	    HeadAlign=Center align=center   Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='기본공제'
		<C> Name='주민번호'	ID=RESINO1   HeadAlign=Center align=center  Width=100 mask='XXXXXX-XXXXXXX'	</C>
		<C> Name='100만'	ID=REF2	 HeadAlign=Center align=center      	Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='추가공제'		
		<C> Name='장애인'		ID=REF3	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='자녀'		ID=REF4	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='경로'		ID=REF5	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='부녀자'		ID=REF6	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<X> name='특별공제'
		<G> name='보험료'
			<C> Name='국세청'		ID=REF11	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REF21	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='의료비'		
			<C> Name='국세청'		ID=REF12	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REF22	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='교육비'
			<C> Name='국세청'		ID=REF13	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REF23	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='카드/현금'		
			<C> Name='국세청'		ID=REFc1	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REFc2	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
	</X>			
	</G>		
	<C> Name='년월'				ID=APPDT   		Width=63	show=false</C> 
	<C> Name='사번'				ID=EMPNO  		Width=60	show=false</C> 
	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>



<br><br><br>
      
      
      
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD><B>Ⅲ. 다음 기타 공제 항목에는 <FONT color=#ff6633>"근로자 본인 명의" </FONT>로 지출한 금액만 입력바랍니다.</B> </TD>
		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<!-- <img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">-->
			<!-- <img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">-->
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
			<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
		</nobr>&nbsp;</td>

        </TR>
      </TABLE>
            
            
      <TABLE cellSpacing=1 cellPadding=3 width=1003 align=center bgColor=#666666 
      border=0>
        
        <TR bgColor=#ffedd2>
          <TD align=CENTER rowSpan=19>기<BR>타<BR><BR>특<BR>별<BR><BR>공<BR>제</TD>
          <TD align=CENTER width=50>항 목</TD>
          <TD align=CENTER colSpan=2>지 출 내 역</TD>
          <TD align=CENTER width=130>지 출 구 분</TD>
          <TD align=CENTER width=90>지 출 금 액</TD>
          <TD align=CENTER>참 고 사 항</TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=7>주택자금</TD>
          <TD align=left width=110 bgColor=#ffffff rowSpan=3>&nbsp;주택마련저축</TD>
          <TD align=left width=140 bgColor=#ffffff>&nbsp;① 청약저축</TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>근로자 본인 명의의 <BR>총 불입액 
            <BR>(40% 공제 미적용 금액)</TD>
          <TD align=CENTER bgColor=#ffffff ROWSPAN=3><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff rowSpan=3>&nbsp;* 근로자 본인이 세대주이며, 무주택자 또는 1주택 
            소유자(국민주택규모)인 <BR>&nbsp;&nbsp;&nbsp;&nbsp;경우 총 불입액 기재 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2006년 신규 장기주택마련저축 
            가입자<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 가입당시 국민주택으로서 
            기준시가가 3억원 이하인 주택소유자여야 함.<BR></FONT></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;② 근로자주택마련저축</TD>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;③ 장기주택마련저축</TD>
        <TR>
          <TD align=left bgColor=#ffffff colSpan=2>&nbsp;주택임차차입금 (위 ①②③ 연계 
          차입금)</TD>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 원리금상환액<BR>(40%공제 
            미적용금액)</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 위 주택마련저축에 가입한 자가 국민주택규모 
            이하의 주택을 임차하기<BR>&nbsp;&nbsp;&nbsp;&nbsp;위해 1996.1.1 이후 <U><B>"저축과 
            연계"</U></B>하여 차입한 경우 총 원리금상환<BR>&nbsp;&nbsp;&nbsp;&nbsp;기재 </TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;장기주택<BR>&nbsp;저당차입금 
          </TD>
          <TD align=left bgColor=#ffffff>&nbsp;① 상환기간 14년 미만 </TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>근로자 본인명의의<BR>&nbsp;총 
          이자상환액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=3>&nbsp;* 근로자 본인이 세대주이며, 
            국민주택규모의 주택(분양권·입주권 3억원<BR>&nbsp;&nbsp;&nbsp;&nbsp;이하)을 취득하기 위하여 주택에 
            저당권을 설정하고 차입한 경우<BR>&nbsp;&nbsp;&nbsp;&nbsp;총 이자상환액 기재 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2006년 신규 
            장기주택저당차입자<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 차입 당시 
            분양권/입주권 평가액이 3억원 이하여야 함.</FONT> </TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;② 상환기간 15년 이상 </TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>주택자금 계</TD>
          <TD align=CENTER bgColor=#fff8ee>
			<%=HDConstant.COMMENT_START%>
			<object id="HOUSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=7  onclick="openGibu();" style="cursor:hand"><b>기부금</b></TD>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;전액공제기부금</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>근로자 본인명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=7>&nbsp;* 
            국방헌금·수재의연금·국가/사립학교의 시설비 등에 기부한 경우<BR>&nbsp;&nbsp;&nbsp;&nbsp;총 기부액 
            기재 <BR><BR>&nbsp;* 정당(후원회 및 선거관리위원회 포함)에 기부한 총 정치자금 기재 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 10만원 이하 금액은 세액공제 + 10만원 초과 금액은 소득공제 </FONT><BR><BR>&nbsp;* 종교·문화·예술·교육·사회·복지·자선단체 등 
            공익성단체에 기부한 경우 <BR>&nbsp;&nbsp;&nbsp;&nbsp;총 기부액 기재 <BR><BR></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;정치자금 기부금</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>근로자 본인명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_20A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_20A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff 
            rowSpan=2>&nbsp;근로소득<BR>&nbsp;10%한도기부금<BR>&nbsp;(종교단체 기부 등) </TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>근로자 본인명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>기부금 계</TD>
          <TD align=CENTER bgColor=#fff8ee><%=HDConstant.COMMENT_START%>
			<object id="CONSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>개인연금</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2000년 이전 가입한 저축</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사 단체 가입 저축<BR>(2000년 이전 입사자)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사일괄처리</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#3366ff>&nbsp;* 회사에서 단체 가입한 대한생명 개인연금 불입액은 본인이 직접 입력하지 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;않음. <BR>&nbsp;&nbsp;&nbsp;&nbsp;→ 단체 가입 상품명 : 노후적립55(60)세 개시, 하이드림 10년납, 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 직장인으뜸55세</FONT> </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 불입액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT011" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>연금저축</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2001년 이후 가입한 저축</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사 단체 가입 저축<BR>(2001년 이후 입사자)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사일괄처리</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#3366ff>&nbsp;* 회사에서 단체 가입한 농협 연금저축불입액은 본인이 직접 입력하지 않음. <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;→ 단체 가입 상품명 : 트리플에이, 큰사랑연금 </FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 불입액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#ffedd2 rowSpan=2>세<BR>액<BR>공<BR>제</TD>
          <TD align=CENTER bgColor=#fff8ee >정치자금</TD>
          <TD align=left bgColor=#ffffff COLSPAN=2>&nbsp;정치자금 기부금</TD>
          <TD align=CENTER bgColor=#ffffff >근로자 본인 명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff><FONT 
            color=#3366ff>&nbsp;* 정당(후원회 및 선거관리위원회 포함) 기부액이 10만원이하인 
            경우<BR>&nbsp;&nbsp;&nbsp;&nbsp;이하액 기재 (자동입력)</FONT> </TD></TR>

        <TR>
          <TD align=CENTER bgColor=#fff8ee>주택자금</TD>
          <TD align=left bgColor=#ffffff colSpan=2>&nbsp;미분양주택취득차입금 상환이자</TD>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 이자상환액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 세대주인 근로자 본인 명의로 "1995.11.1~1997.12.31" 중 서울시 이외의 <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;지역에 국민주택규모 이하의 미분양 주택을 취득하기 위해 국민주택기금 <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;또는 주택은행으로부터 1995.11.1 이후 차입한 차입금에 대한 총 이자 <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;상환액 기재</TD>
		  </TR>
	  </TABLE>
	  <BR>
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=800>&nbsp;</TD>
          <TD vAlign=bottom align=right></TD>
          <TD vAlign=bottom align=right></TD>
		</TR>
	  </TABLE>

	  <!--연금보험료-->
	  <INPUT type=hidden value=1,486,800 name=pybsgm>
	  <INPUT type=hidden value=0 name=pybsto> 
	  
	  <!--보험료-->
	  <INPUT type=hidden value=802,130 name=pybsbh> 
	  <INPUT type=hidden value=173,047 name=pybsgy> 
	  <INPUT type=hidden value=0 name=pybins> 
	  <INPUT type=hidden value=0 name=pybin2> 
	  <INPUT type=hidden value=0 name=pybito> 
	  
	  <!--의료비-->
	  <INPUT type=hidden value=0 name=pybmsd> 
	  <INPUT type=hidden value=0 name=pybmgd> 
	  <INPUT type=hidden value=0 name=pybmtc> 
	  <INPUT type=hidden value=0 name=pybmto> 
	  <INPUT type=hidden value=0 name=pybmtm> 
	  
	  <!--교육비-->
	  <INPUT type=hidden value=0 name=pybsed> 
	  <INPUT type=hidden value=0 name=pybebc> 
	  <INPUT type=hidden value=0 name=pybebt> 
	  <INPUT type=hidden value=0 name=pybecc> 
	  <INPUT type=hidden value=0 name=pybect> 
      <INPUT type=hidden value=0 name=pybedc> 
	  <INPUT type=hidden value=0 name=pybedt> 
	  <INPUT type=hidden value=0 name=pybetc> 
	  <INPUT type=hidden value=0 name=pybets> 
	  <INPUT type=hidden value=0 name=pybeto> 

      <!--카드비-->
	  <INPUT type=hidden value=0 name=pybcad> 
	  <INPUT type=hidden value=0 name=pybhnd> 
	  <INPUT type=hidden value=0 name=pybsgd> 
	  <!--<input type="hidden" name="pybmex" value="0">-->
	  <INPUT type=hidden value=0 name=pybcto> 

      <DIV id=tipbox style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BACKGROUND: infobackground; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 0px"></DIV>
	</TD>
  </TR>
</TABLE>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNO  	  	Ctrl=EMPNO  	   	Param=text</C>
		<C>Col=DEPTCD  	  	Ctrl=DEPTCD  	   	Param=text</C>
		<C>Col=PAYGRD  	  	Ctrl=PAYGRD  	   	Param=text</C>
		<C>Col=JOINDATE   	Ctrl=JOINDATE      	Param=text</C>
		<C>Col=EMPNMK  	  	Ctrl=EMPNMK  	   	Param=text</C>
		<C>Col=EMPJUNO    	Ctrl=EMPJUNO       	Param=text</C>
		<C>Col=TELNUM    	Ctrl=TELNUM       	Param=text</C>
		<C>Col=ADDRESS    	Ctrl=ADDRESS       	Param=text</C>
		<C>Col=TAX_PAY    	Ctrl=TAX_PAY       	Param=text</C>
		<C>Col=TAX_BNS    	Ctrl=TAX_BNS       	Param=text</C>
		<C>Col=TAX_SUM    	Ctrl=TAX_SUM       	Param=text</C>
		<C>Col=NTAX_SUM   	Ctrl=NTAX_SUM      	Param=text</C>
		<C>Col=DEDUCT1 	  	Ctrl=DEDUCT1 	   	Param=text</C>
		<C>Col=DEDUCT2 	  	Ctrl=DEDUCT2 	   	Param=text</C>
		<C>Col=DEDUCT3 	  	Ctrl=DEDUCT3 	   	Param=text</C>
		<C>Col=DEDUCT4 	  	Ctrl=DEDUCT4 	   	Param=text</C>
		<C>Col=DEDUCT5    	Ctrl=DEDUCT5       	Param=text</C>

		<C>Col=HOUAMT01   	Ctrl=HOUAMT01         	Param=text</C>	
		<C>Col=HOUAMT02   	Ctrl=HOUAMT02         	Param=text</C>
		<C>Col=HOUAMT03   	Ctrl=HOUAMT03         	Param=text</C>
		<C>Col=HOUAMT04   	Ctrl=HOUAMT04         	Param=text</C>
		<C>Col=HOUSUM 	  	Ctrl=HOUSUM 	      	Param=text</C>
		<C>Col=ETCAMT011  	Ctrl=ETCAMT011        	Param=text</C>
		<C>Col=ETCAMT01   	Ctrl=ETCAMT01         	Param=text</C>
		<C>Col=CONSUM   	Ctrl=CONSUM         	Param=text</C>
		<C>Col=DEDAMT03   	Ctrl=DEDAMT03         	Param=text</C>
		<C>Col=DEDAMT04   	Ctrl=DEDAMT04         	Param=text</C>		
	'>
</object>

<object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds2>
	<param name=BindInfo  value='
		<C>Col=BF_WKNM     	  	Ctrl=BF_WKNM     	   	Param=text</C>
		<C>Col=BF_RESINO	  	Ctrl=BF_RESINO	       	Param=text</C>
		<C>Col=BF_TAX_PAY	  	Ctrl=BF_TAX_PAY	       	Param=text</C>
		<C>Col=BF_TAX_BNS	  	Ctrl=BF_TAX_BNS	       	Param=text</C>
		<C>Col=BF_TAX_SUM 	  	Ctrl=BF_TAX_SUM 	   	Param=text</C>
		<C>Col=BF_NTAX_SUM 	  	Ctrl=BF_NTAX_SUM 	   	Param=text</C>
		<C>Col=BF_DEDUCT1     	Ctrl=BF_DEDUCT1        	Param=text</C>
		<C>Col=BF_DEDUCT2	  	Ctrl=BF_DEDUCT2	       	Param=text</C>
		<C>Col=BF_DEDUCT3	  	Ctrl=BF_DEDUCT3	       	Param=text</C>
		<C>Col=BF_DEDUCT4	  	Ctrl=BF_DEDUCT4	       	Param=text</C>
		<C>Col=BF_DEDUCT5	  	Ctrl=BF_DEDUCT5	       	Param=text</C>
	'>
</object>

<object id=gcbn_data4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds4>
	<param name=BindInfo  value='
		<C>Col=GIVAMT_10A  	Ctrl=GIVAMT_10A 	   	Param=text</C>
		<C>Col=GIVAMT_10B  	Ctrl=GIVAMT_10B       	Param=text</C>
		<C>Col=GIVAMT_20A  	Ctrl=GIVAMT_20A       	Param=text</C>
		<C>Col=GIVAMT_20B  	Ctrl=GIVAMT_20B       	Param=text</C>
		<C>Col=GIVAMT_40A  	Ctrl=GIVAMT_40A	  		Param=text</C>
		<C>Col=GIVAMT_40B  	Ctrl=GIVAMT_40B 	   	Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>




</FORM>
</BODY>
</HTML>
