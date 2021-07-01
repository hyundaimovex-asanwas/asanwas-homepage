<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 급여시스템
 * 프로그램ID 	: P030009_card1
 * J  S  P		: P030009i
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의	: 
 *                   
 * 최종수정일자 	: 2011-01-04
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");				//귀속년도
    String eno 		 = request.getParameter("eno");				//사번
    String eJuno 		 = request.getParameter("eJuno");			//공제대상 주민번호
%>

<html>
<head>
<title><%=eyy%> 년 근로소득공제 신용카드/직불카드/현금영수증 공제 상세 입력</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //등록
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
	function ln_Start(){
		//그리드 스타일 넣기
		cfStyleGrid(getObjectFirst("gr1"), "comn");
	
		fnSelect("<%=eyy%>", "<%=eno%>", "<%=eJuno%>");	//기본정보 조회
	}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
	function fnSelect(pYear, pEmpno, pJuno) {	 //동현스 : 파라미터 받아서 기본 조회

			v_job = "S";	//select 일듯..

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno 
			          + ",eJuno="     + pJuno ;

			//alert("힘내자!");

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i_05",			//경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);
	
			tr_post(tr1);
					

	}
	

	
/******************************************************************************
	Description : 삭제
******************************************************************************/
	function fnDeleteRow() {//Row 삭제
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("마감된 자료입니다. 삭제할수 없습니다");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds1.DeleteRow(ds1.RowPosition);
	}
	
/******************************************************************************
	Description : 저장
******************************************************************************/
    function fnApply() {// 현재 데이터셋 반영

	   // if(!Card_Apply_Chk("ds1")) return;
		
        if (ds1.IsUpdated) {
			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			}
            
            v_job = "I";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_05",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("신용카드 / 현금영수증 상세 정보의 변경 내역이 없습니다.");
        }
    }
    
	function fnSaveChk(){ //저장전 전산제출구분체크
		v_job = "S";	  //select 일듯..
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				  + ",eyy="       + <%=eyy%>
				  + ",eno="       + <%=eno%> ;
        
		ln_TRSetting(tr1, 
			"/services/servlet/Payroll.p030010i",	//		경로 주의할 것!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}
	
/******************************************************************************
	Description : 취소
******************************************************************************/
	function fnCancel() {	//취소시 undo all. 
		ds1.undoall();
	} 
	
	function fnClose()	{
		window.close();
		opener.fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
//		opener.ds3.reset();
	};

/******************************************************************************
	Description :합계 계산
******************************************************************************/
function calTotal(gbn) {
	if (gbn=='1')	{
		getObjectFirst("f_CARDTOT1").text= parseInt(getObjectFirst("f_CARD11").text) + parseInt(getObjectFirst("f_CARD21").text);
	} else if (gbn=='2') {
		getObjectFirst("f_CARDTOT2").text= parseInt(getObjectFirst("f_CARD12").text) + parseInt(getObjectFirst("f_CARD22").text);
	} else if (gbn=='3') {
		getObjectFirst("f_CARDTOT3").text= parseInt(getObjectFirst("f_CARD13").text) ;
	} else if (gbn=='4') {
		getObjectFirst("f_CARDTOT4").text= parseInt(getObjectFirst("f_CARD14").text) + parseInt(getObjectFirst("f_CARD24").text);
	};
	
}	;
</script>




<script language="javascript" for="tr1" event="onsuccess()">

    if(v_job=="I") {	//저장
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose();
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		calTotal('1');
		calTotal('2');
		calTotal('3');		
		calTotal('4');		
    }

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


<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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






<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<form name="entry" method="post" action="">
   <br>
   <b><font face="굴림">&nbsp;※ 신용카드 등 사용액 소득공제</a></font></b>
   <br><font color="#7800BF" size="2" face="굴림"> 
      &nbsp;☞ 근로소득자 또는 연소득 100만원 이하인 배우자, 부양가족이 당해연도 1월 ~ 12월까지 사용한 금액에 대해 공제하는 것입니다.</font>
	<!-- 인적사항 및 공제항목 -->
	<table width="820" border="0" cellspacing="0" cellpadding="0">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
			 <table width="820" border="0" cellspacing="1" cellpadding="3" height="181" bgcolor="#666666" align="center">
			  <tr bgcolor="#FFF8EE">
				<td bgcolor="#FFF8EE" width="80">
				  <div align="center"><font face="굴림">구 분</font></div>
				 </td>
				<td width="520">
				  <div align="center"><font face="굴림">내 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;역</font></div>
				  </td>
				</tr>
				<tr bgcolor="#FFFFFF">
				  <td bgcolor="#FFF8EE">
					  <div align="center"><font face="굴림">사용기간</font></div>
					</td>
				  <td><font face="굴림">당해년도 1월 ~ 12월 사용분 </font></td>
				</tr>
				<tr bgcolor="#FFFFFF">
				  <td bgcolor="#FFF8EE">
				    <div align="center"><font face="굴림">소득공제액<br> 계산 </font></div>
				  </td>
				  <td bgcolor="#FFFFFF">
                  ① A+B<br>
				  A : (신용카드등 사용금액 - 총급여액X25%) X 직불카드등 사용액/신용카드등 사용금액 X 25%<br>
				  B : (신용카드등 사용금액 - 총급여액X25%) X 직불카드등 외의 사용액/신용카드등 사용금액 X 20%<br>
				  ②총급여의 20% <br>
				  ③300만원 </td>
				   </td>
				</tr>
				<tr bgcolor="#FFFFFF">

				<td bgcolor="#FFF8EE">
				  <div align="center"><font face="굴림">공제한도</font></div>
				  </td>
				  <td><font face="굴림">Min(①, ②, ③ )</font>

				</tr>
				<tr bgcolor="#FFFFFF">

				<td bgcolor="#FFF8EE">
				  <div align="center"><font face="굴림">공제대상금액 </font></div>
				  </td>
				  <td>본인,배우자,부양가족이 사용한 금액(국내) <br>
					- 신용카드, 직불카드, 기명식선불카드, 직불전자지급수단, 백화점카드 등<br>
					- 지로납부 학원 수강료<br>
					- 현금영수증 사용금액
				  </td>
				</tr>
				<tr bgcolor="#FFFFFF">

				<td bgcolor="#FFF8EE">
				  <div align="center"><font face="굴림">공제제외액 </font></div>
				  </td>
				  <td>
					- 접대비 등 회사 업무경비<br>
					- 각종보험료(연금보험료,의료보험료), 각종교육비(수업료,입학금,보육비용)<br>
					- 국세,지방세,전기료,수도료 등 / 국외 사용 금액 /형제자매의 사용금액<br>
                    - 맞벌이부부의 상대방 배우자가 사용한 금액
					<!-- - 주소지가 다른 20세 초과 자녀의 사용금액 등 -->
				  </td>
				</tr>
				<tr bgcolor="#FFFFFF">
				  <td bgcolor="#FFF8EE">
					<div align="center"><font face="굴림">제출서류 </font></div>
				  </td>
				  <td ><font face="굴림">신용카드소득공제신청서,신용카드사용금액확인서, 현금영수증 사용금액 확인서 </font></td>
				</tr>
			  </table>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
	       <td  height="20">
            <font color="#7800BF" face="굴림">※ 현금영수증 사용금액 확인서는 국세청 현금영수증 홈페이지(<a href="http://www.taxsave.go.kr" target="_blank">www.taxsave.go.kr</a>)에서 회원가입 후 본인이 직접 발급 받음.</font>
		</tr>
		<tr>
			<td align="right"><br>
			<nobr>
				<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
				<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
				&nbsp;&nbsp;<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">						
			</nobr>&nbsp;</td>
		</tr>
	</table>	

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 100px;border:1 solid #777777;display:none;" viewastext>
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

	<C> Name='사번'						ID=EMPNO  			Width=60	</C> 
	<C> Name='성명'						ID=EMPNMK  		Width=40	</C> 
	<C> Name='주민번호'				ID=EMPJUNO  		Width=60	</C> 	
	<C> Name='부양가족성명1'		ID=FAMNMK			Width=64	</C>
	<C> Name='부양가족관계1'		ID=FAMRELA_NM	Width=65	</C>
	<C> Name='관계코드'				ID=FAMRELA_CD	Width=35	</C>	
	<C> Name='가족주민번호1'		ID=FAMJUNO		Width=55	</C>

	<C> Name='외국인YN'				ID=REF1   			Width=40	</C>
	<C> Name='100만원이하YN'		ID=REF2   			Width=40	</C>
	<C> Name='장애인YN'				ID=REF3   			Width=40	</C>
	<C> Name='자녀YN'					ID=REF4   			Width=40	</C>
	<C> Name='경로YN'					ID=REF5   			Width=40	</C>

	<C> Name='국세청카드' 			ID=CARD11			Width=50	</C>
	<C> Name='국세청직불' 			ID=CARD12			Width=50	</C>
	<C> Name='국세청현금' 			ID=CARD13			Width=50	</C>
	<C> Name='국세청학원' 			ID=CARD14			Width=50	</C>
	<C> Name='국세청외카드' 			ID=CARD21			Width=50	</C>
	<C> Name='국세청외직불' 			ID=CARD22			Width=50	</C>
	<C> Name='국세청외학원' 			ID=CARD24			Width=50	</C>
	<C> Name='년월'						ID=APPDT   			Width=63	</C> 
	
	<C> Name='Flag'	    				ID=FLAGCOL			Width=20	</C>	

	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

	<table width="820" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#FFFFFF">
			<td colspan="2" bgcolor="#ffedd2">근 로 소 득 자</td>
			<td colspan="3" bgcolor="#ffedd2">공 제 신 청 자 (= 사 용 자)</td>
			<td colspan="5" bgcolor="#ffedd2">금 액</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee" width="55" >이 름</td>
			<td bgcolor="#fff8ee" width="90" >주민등록번호</td>
			<td bgcolor="#fff8ee" width="55" >이 름</td>
			<td bgcolor="#fff8ee" width="70" >관 계</td>
			<td bgcolor="#fff8ee" width="90" >주민등록번호</td>
			<td bgcolor="#fff8ee" width="65" >자료 구분</td>
			<td bgcolor="#fff8ee" width="75" >신용카드</td>
			<td bgcolor="#fff8ee" width="75" >직불카드 등</td>
			<td bgcolor="#fff8ee" width="75" >현금영수증</td>
			<td bgcolor="#fff8ee" width="75" >학원비<BR>지로납부</td>
		</tr>

	    <tr align="center" bgcolor="#FFFFFF">
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPNMK" style= "position:relative;left:0px;top:2px;width:55px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">										
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>			
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=FORMAT 			value="000000-0000000">
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">	
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>	
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMNMK" style= "position:relative;left:0px;top:2px;width:55px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>	
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMRELA_CD" style= "DISPLAY:NONE;position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">				
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<object id="f_FAMRELA_NM" style= "position:relative;left:0px;top:2px;width:55px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">			
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>			
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">		
					<param name=FORMAT 			value="000000-0000000">
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
				<input type="hidden" name="f_REF1" id="f_REF1" value="">
				<input type="hidden" name="f_REF2" id="f_REF2" value="">
				<input type="hidden" name="f_REF3" id="f_REF3" value="">
				<input type="hidden" name="f_REF4" id="f_REF4" value="">
				<input type="hidden" name="f_REF5" id="f_REF5" value="">
			</td>
			<td bgcolor="#fff8ee"><font color="#FF6633">국세청자료</font></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD11" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">		
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD12" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">		
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD13" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD14" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee">그밖의자료</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD21" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD22" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>

			<td>
				-
			</td>

			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD24" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td colspan="6">합 계	</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT1" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT2" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT3" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT4" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
	</table>
</form>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNMK 		Ctrl=f_EMPNMK  			Param=text</C>
		<C>Col=EMPNO  			Ctrl=f_EMPNO   			Param=text</C>		
		<C>Col=EMPJUNO		Ctrl=f_EMPJUNO 			Param=text</C>
		<C>Col=APPDT  			Ctrl=f_APPDT   				Param=text</C>

		<C>Col=FAMRELA_NM	Ctrl=f_FAMRELA_NM 	Param=text</C>
		<C>Col=FAMRELA_CD	Ctrl=f_FAMRELA_CD	 	Param=text</C>		
		<C>Col=FAMNMK 		Ctrl=f_FAMNMK  			Param=text</C>
		<C>Col=FAMJUNO		Ctrl=f_FAMJUNO 			Param=text</C>

		<C>Col=REF1   			Ctrl=f_REF1    				Param=value</C>
		<C>Col=REF2   			Ctrl=f_REF2    				Param=value</C>
		<C>Col=REF3   			Ctrl=f_REF3    				Param=value</C>
		<C>Col=REF4   			Ctrl=f_REF4    				Param=value</C>
		<C>Col=REF5   			Ctrl=f_REF5    				Param=value</C>

		<C>Col=CARD11 			Ctrl=f_CARD11  			Param=text</C>
		<C>Col=CARD12 			Ctrl=f_CARD12  			Param=text</C>
		<C>Col=CARD13 			Ctrl=f_CARD13  			Param=text</C>
		<C>Col=CARD14 			Ctrl=f_CARD14  			Param=text</C>
		<C>Col=CARD21 			Ctrl=f_CARD21  			Param=text</C>
		<C>Col=CARD22 			Ctrl=f_CARD22  			Param=text</C>
		<C>Col=CARD24 			Ctrl=f_CARD24  			Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>


</body>
</html>
