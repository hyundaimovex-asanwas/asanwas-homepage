<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 급여시스템
 * 프로그램ID 	: P030009_ofc
 * J  S  P		: P030009i
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2006-12-19
 * 기능정의	: 연말정산내역신고 - 종전 근무지 팝! : UNI 소스를 받았으나 폼만 활용하는게 우리 형편에
 *                   페이지 로드시 받아온 사번으로 개인 정보 표시
 *                   등록버튼 1회 누를때마다 폼 생성 & 2회까지 가능
 *                   숨겨놓은 DS로 저장..
 *                   
 *                   
 * 최종수정일자 	: 2006-12-19
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");			//귀속년도
    String eno = request.getParameter("eno");		//사번
%>

<html>
<head>
<title>2006년 근로소득공제 종(전)근무지 상세 입력</title>
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
	
		fnSelect(<%=eyy%>,  <%=eno%>);	//기본정보 조회
	}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //동현스 : 파라미터 받아서 기본 조회
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy=" + pYear
			          + ",eno="+  pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i_01",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	
/******************************************************************************
	Description : 추가, 삭제, 저장, 취소
******************************************************************************/
	function fnAddRow(){
		if(ds1.countrow > 1) {
			alert("종전 근무지는 2개까지만 입력할 수 있습니다.");
		} else {
			ds1.addrow();	
			getObjectFirst("dspImg").style.display="none";			

			getObjectFirst("f_YYYY").value = "<%=eyy%>";		//귀속년
			getObjectFirst("f_EMPNO").value = "<%=eno%>";		//사번
			getObjectFirst("f_EMPNMK").value = "홍길동";		//기본값 insert
			getObjectFirst("f_STRTDT").value = "20061228";	//기본값 insert
			getObjectFirst("f_ENDDT").value = "20061228";		//기본값 insert
		}
	}
	
	function fnDeleteRow() {//Row 삭제
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("마감된 자료입니다. 삭제할수 없습니다");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds1.DeleteRow(ds1.RowPosition);
	}
	

    function fnApply() {// 현재 데이터셋 반영
		v_job = "I";	
        if (ds1.IsUpdated) {
	    	for (i = 1; i <= ds1.countrow; i++) {
				if (!ds1.namevalue(i, "SEQ")) {
					ds1.namevalue(i, "SEQ") = i;
				};
	    	};
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i_01",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("근무지 정보의 변경 내역이 없습니다.");
        }
    }
    
	function fnCancel() {	//취소시 undo all. 
		ds1.undoall();
		
		if(ds1.countrow > 0) {
			getObjectFirst("dspImg").style.display="none";
		} else {
			getObjectFirst("dspImg").style.display="";
		}	
	} 


	function fnClose()	{	//창 닫을 때.
		window.close();
		opener.fnSelect2("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)

	};
		
//합계 계산
function calTotal(gbn) {
	if (gbn=='1')	{
		getObjectFirst("f_BP10SUM").value= parseInt(getObjectFirst("f_BP11000").text) + parseInt(getObjectFirst("f_BP12000").text) + parseInt(getObjectFirst("f_BP13000").text);
	} else if (gbn=='2') {
		getObjectFirst("f_BP20SUM").value= parseInt(getObjectFirst("f_BP21000").text) + parseInt(getObjectFirst("f_BP22000").text) + parseInt(getObjectFirst("f_BP23000").text);
	} else if (gbn=='3') {
		getObjectFirst("f_BP30SUM").value= parseInt(getObjectFirst("f_BP31000").text) + parseInt(getObjectFirst("f_BP32000").text) + parseInt(getObjectFirst("f_BP33000").text);
	} else if (gbn=='4') {
		getObjectFirst("f_BP40SUM").value= parseInt(getObjectFirst("f_BP41000").text) + parseInt(getObjectFirst("f_BP42000").text) + parseInt(getObjectFirst("f_BP43000").text);
	};

	
}	;
</script>


<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
		getObjectFirst("dspImg").style.display="none";
	} else {
		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//저장
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose();	
		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		calTotal('1');
		calTotal('2');
		calTotal('3');
		calTotal('4');
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
	<!-- 인적사항 및 공제항목 -->
	<table width="638" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">☞ 입력안내</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#FF6633"><b>① 당해년도 경력입사자 또는 2곳 이상의 근무처에서 소득이 발생하는 자일 경우에만 입력합니다.</b></font><br>
						&nbsp;&nbsp;&nbsp;&nbsp; 예) 현대택배 퇴직후 현대상선 입사자, 현대증권 및 현대상선 2곳에서 급여를 받는 자
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>② 전(종)근무지로부터 "<u>근로소득원천징수영수증 및 소득자별근로소득원천징수부</u>"를 발급 받아야 합니다.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">③ 소득자료 (전근무지 소득 + 현근무지 소득 = 합산소득 신고)</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- 과세소득은 급여와 상여로 구분 입력합니다. (비과세 소득은 별도 입력)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- 인정상여에 해당하는 과세소득 예 : 고용안정센터에서 지급받는 산전후 휴가급여
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">④ 증빙서류는 종(전)근무지 입력순서와 일치되도록 정리하여 주시기 바랍니다.</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- 근로소득원천징수영수증상에 『<u>연금보험료(국민연금), 보험료(건강보험+고용보험)</u>』 금액이<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;표시 되어 있지 않은 경우 "소득자별근로소득원천징수부"를 참고합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF6633">※ 영수증 및 징수부상에 관련 금액이 없는 경우 전근무지 연말정산 담당자에게 금액을<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;문의하셔야 합니다.</font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">⑤ 세액자료 (전근무지 결정 소득세/주민세 + 현근무지 결정 소득세/주민세 = 합산세액 신고)</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- 차감징수세액이 아닌 "<u>산출세액과 결정세액</u>"을 입력합니다.
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right"><br>
						<nobr>
							<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
							<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
							<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">
							<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						</nobr>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>


<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:block;" viewastext>
	<PARAM NAME="DataID"			VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='No.'		ID='{STRING(CURROW)}' 		HeadAlign=Center Width=33		align=center  </C> 

	<C> Name='귀속년도'		ID=YYYY 	HeadAlign=Center Width=90	align=center  mask='XXXX'</C> 
	<C> Name='사번'			ID=EMPNO  	HeadAlign=Center Width=103	align=center  </C> 
	<C> Name='회사명'		    ID=WKNM		HeadAlign=Center Width=205	align=reft	</C>
	<C> Name='사업자등록번호'	ID=WKRESINO	HeadAlign=Center Width=204	align=center  mask='XXX-XX-XXXXX' EDIT=NUMERIC</C>

	<C> Name='성명'			ID=EMPNMK  	HeadAlign=Center Width=55	align=reft	  			show=false</C>
	<C> Name='종전입사일자'	ID=STRTDT	HeadAlign=Center Width=80	align=center  mask='XXXX/XX/XX' show=false</C>
	<C> Name='종전퇴사일자'	ID=ENDDT 	HeadAlign=Center Width=80	align=center  mask='XXXX/XX/XX' show=false</C>
		
	<C> Name='급여총액'				ID=BP11000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='상여'						ID=BP12000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='인정상여'				ID=BP13000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='총급여계'				ID=BP10SUM	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='국외근로비과세'	ID=BP21000	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='야간근로비과세'	ID=BP22000	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='기타비과세'			ID=BP23000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='국민연금'				ID=BP31000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='건강보험'				ID=BP32000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='고용보험'				ID=BP33000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='소득세'					ID=BP41000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='주민세'					ID=BP42000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='농특세'					ID=BP43000	HeadAlign=Center Width=80	align=right		show=false</C>
    <C> Name='세액계'					ID=BP40SUM	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='순번'		ID='SEQ' 	HeadAlign=Center Width=33		align=center  show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>


<!-- 여기에 폼 가리는 걸 하나 넣어줄께...흑.. -->
<div id=dspImg style="display:;position:absolute;left:0;top:345;width:638;height:236;Z-INDEX: 8"><img src=imgs/back_base.gif width=638 height=236 id=dspImg2 style="filter:alpha(opacity=70)"></div>
	<table width="638" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#fff8ee">
			<td bgcolor="#ffedd2" width="30"  rowspan="9">종<br><br>전<br><br>근<br><br>무<br><br>지</td>
			<td width="110">회사명</td>
			<td colspan="2" bgcolor="#FFFFFF">
				<input type="text" id="f_WKNM" name="f_WKNM" value="" class="input01" size="28" style="text-align:center;" maxlength="13">
			</td>
			<td>사업자번호</td>
			<td colspan="2" bgcolor="#FFFFFF">
				<%=HDConstant.COMMENT_START%>
				<object id="f_WKRESINO" style= "position:relative;left:0px;top:2px;width:165px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=165 class="input01">
					<param name=Text 		value="">
					<param name=Alignment 	value=1>
					<param name=Format 		value="000-00-00000">
					<param name=Cursor	 	value="iBeam">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
					<param name=SelectAllOnClick  	value="true">		
					<param name=SelectAllOnClickAny   value="false">
				</object>
				<%=HDConstant.COMMENT_END%>				
			</td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">과세소득</td>
			<td width="100">과세급여</td>
			<td width="100">과세상여</td>
			<td width="100">인정상여</td>
			<td width="100">과세소득계</td>
			<td width="100"></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP11000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP12000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">					
				</object>
				<%=HDConstant.COMMENT_END%></td>				
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP13000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td>
				<input type="text" id="f_BP10SUM" name="f_BP10SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">비과세소득</td>
			<td width="100">국외비과세</td>
			<td width="100">야간근로</td>
			<td width="100">기타비과세</td>
			<td width="100">비과세소득계</td>
			<td width="100"></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP21000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP22000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP23000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td>
				<input type="text" id="f_BP20SUM" name="f_BP20SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">공제</td>
			<td>국민연금</td>
			<td>건강보험</td>
			<td>고용보험</td>
			<td>공제계</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP31000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP32000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP33000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>										
			<td>
				<input type="text" id="f_BP30SUM" name="f_BP30SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">세액</td>
			<td>결정소득세</td>
			<td>결정주민세</td>
			<td>결정농특세</td>
			<td>결정세액계</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP41000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP42000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP43000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>										
			<td>
				<input type="text" id="f_BP40SUM" name="f_BP40SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
	</table>
	<input type="hidden" id="f_EMPNMK" name="f_EMPNMK" value="">
	<input type="hidden" id="f_STRTDT" name="f_STRTDT" value="">
	<input type="hidden" id="f_ENDDT" name="f_ENDDT" value="">
	<input type="hidden" id="f_YYYY" name="f_YYYY" value="">
	<input type="hidden" id="f_EMPNO" name="f_EMPNO" value="">

</form>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=YYYY 		Ctrl=f_YYYY 			Param=value</C>
		<C>Col=EMPNO  		Ctrl=f_EMPNO  			Param=value</C>
		<C>Col=WKNM	    	Ctrl=f_WKNM	    		Param=value</C>
		<C>Col=WKRESINO 	Ctrl=f_WKRESINO 		Param=text</C>
		<C>Col=EMPNMK   	Ctrl=f_EMPNMK   		Param=value</C>
		<C>Col=STRTDT		Ctrl=f_STRTDT			Param=value</C>
		<C>Col=ENDDT 		Ctrl=f_ENDDT 			Param=value</C>
		<C>Col=BP11000		Ctrl=f_BP11000			Param=text</C>
		<C>Col=BP12000		Ctrl=f_BP12000			Param=text</C>
		<C>Col=BP13000		Ctrl=f_BP13000			Param=text</C>
		<C>Col=BP10SUM		Ctrl=f_BP10SUM			Param=text</C>
		<C>Col=BP21000		Ctrl=f_BP21000			Param=text</C>
		<C>Col=BP22000		Ctrl=f_BP22000			Param=text</C>
		<C>Col=BP23000		Ctrl=f_BP23000			Param=text</C>
		<C>Col=BP31000		Ctrl=f_BP31000			Param=text</C>
		<C>Col=BP32000		Ctrl=f_BP32000			Param=text</C>
		<C>Col=BP33000		Ctrl=f_BP33000			Param=text</C>
		<C>Col=BP41000		Ctrl=f_BP41000			Param=text</C>
		<C>Col=BP42000		Ctrl=f_BP42000			Param=text</C>
		<C>Col=BP43000		Ctrl=f_BP43000			Param=text</C>
		<C>Col=BP40SUM		Ctrl=f_BP40SUM			Param=text</C>
		<C>Col=SEQ	 		Ctrl=f_SEQ	 			Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>



</body>
</html>
