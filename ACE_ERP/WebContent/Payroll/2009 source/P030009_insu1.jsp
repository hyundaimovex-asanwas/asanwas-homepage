      <%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 급여시스템
 * 프로그램ID 	: P030009_insu1
 * J  S  P		: P030009i
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-04
 * 기능정의	: 
 *                   
 * 최종수정일자 	: 2007-01-04
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//귀속년도
    String eno 		 = request.getParameter("eno");				//사번
    String eJuno 	 = request.getParameter("eJuno");		//공제대상 주민번호
%>

<html>
<head>
<title>2006년 근로소득공제 보험료 공제 상세 입력</title>
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

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i_02",	//		경로 주의할 것!
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
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i_02",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("보험료 상세 정보의 변경 내역이 없습니다.");
        }
    }
    
	function fnCancel() {	//취소시 undo all. 
		ds1.undoall();
	} 
	
	function fnClose()	{
		window.close();
		opener.fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
//		opener.ds3.reset();
	};
	
	
	
//보험료계 계산
function calTotal(gbn) {
	if (gbn=='1')	{
		getObjectFirst("f_REFTOT1").text= parseInt(getObjectFirst("f_REFB11").text) + parseInt(getObjectFirst("f_REFB13").text);
	} else if (gbn=='2') {
		getObjectFirst("f_REFTOT2").text= parseInt(getObjectFirst("f_REFB12").text) + parseInt(getObjectFirst("f_REFB14").text);
	}
}	;
</script>


<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//저장
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//		fnSelect("<%=eyy%>", "<%=eno%>", "<%=eJuno%>");	//기본정보 조회
		fnClose();
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		calTotal('1');
		calTotal('2');
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
	<table width="748" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2"><b>※ 일반보장성보험료</b></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#FF6633">1. 본인이 부담하는 보험료의 피보험자가 부양가족일 경우 아래 2가지 요건에 해당되어야만 신청 가능합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;즉, "배우자공제 및 부양가족공제(인적공제)" 해당자만이 보험료 공제도 받을 수 있음.
						</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;① 연령조건 : 남(직계존속, 형제) - 만60세 이상(1946.12.31 이전 生)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;여(직계존속, 자매) - 만55세 이상(1951.12.31 이전 生)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자녀, 형제자매&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - 만20세 이하(1986.01.01 이후 生)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;배우자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - 연령제한 없음
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;② 소득조건 : 배우자 및 위 연령조건에 해당되는 부양가족의 연간 소득금액이 100만원 이하여야 함.<br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><b><font color="#3366FF">2. 본인 또는 위 공제조건에 해당되는 한 가족의 연간 보험료 합계액이 100만원이 넘는 경우 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;다른 가족의 보험료 합계액을 입력 할 필요가 없습니다. (공제한도 100만원이기 때문)</font></b></td>
					</tr>
					<tr>
						<td colspan="2"><br><b>※ 장애인전용 보장성보험료</b></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#FF6633">1. 본인이 부담하는 보험료의 피보험자가 장애인이며, 일반보장성보험이 아닌 <u>장애인전용보험</u>에 가입한 경우<br>
						&nbsp;&nbsp;&nbsp;&nbsp;아래 3가지 요건에 해당되어야만 신청 가능합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;즉, "배우자공제 및 부양가족공제(인적공제) + 장애인공제" 해당자만이 보험료 공제도 받을 수 있음.
						</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;① 연령조건 : 배우자 또는 부양가족이 장애인일 경우 연령제한 없음.
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;② 소득조건 : 장애인인 배우자 및 부양가족의 연간 소득금액이 100만원 이하여야 함.<br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;③ 보험료 납입증명서상 <u>"장애인전용"</u>이라는 표시가 되어 있어야 함.<br><br>
						</td>
					</tr>


					<tr>
						<td>&nbsp;</td>
						<td align="right"><br>
						<nobr>
							<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
							<!-- <img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()"> -->
							<!-- <img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()"> -->
							<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
							　<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">
						</nobr>&nbsp;</td>
					</tr>
				</table>
			</td>
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
	<C> Name='년월'				ID=APPDT   		Width=63	</C> 
	<C> Name='사번'				ID=EMPNO  		Width=60	</C> 
	<C> Name='성명'				ID=EMPNMK  		Width=40	</C> 
	<C> Name='주민번호'			ID=EMPJUNO  	Width=60	</C> 	
	<C> Name='부양가족성명1'		ID=FAMNMK		Width=64	</C>
	<C> Name='부양가족관계1'		ID=FAMRELA_NM	Width=65	</C>
	<C> Name='관계코드'			ID=FAMRELA_CD	Width=35	</C>	
	<C> Name='가족주민번호1'		ID=FAMJUNO		Width=55	</C>
	<C> Name='외국인YN'			ID=REF1   		Width=80	</C>
	<C> Name='100만원이하YN'		ID=REF2   		Width=80	</C>
	<C> Name='장애인YN'			ID=REF3   		Width=80	</C>
	<C> Name='자녀YN'			ID=REF4   		Width=80	</C>
	<C> Name='경로YN'			ID=REF5   		Width=80	</C>
	<C> Name='국세보험' 			ID=REFB11  		Width=50	</C>
	<C> Name='국세장애'			ID=REFB12  		Width=50	</C>
	<C> Name='일반보험'	        ID=REFB13  		Width=50	</C>
	<C> Name='일반장애보험'	    ID=REFB14  		Width=50	</C>
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	</C>	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

	<table width="748" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#FFFFFF">
			<td colspan="2" bgcolor="#ffedd2">근 로 소 득 자</td>
			<td colspan="3" bgcolor="#ffedd2">공 제 신 청 자 (= 피 보 험 자)</td>
			<td colspan="3" bgcolor="#ffedd2">금 액</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee" width="65">이 름</td>
			<td bgcolor="#fff8ee" width="90">주민등록번호</td>
			<td bgcolor="#fff8ee" width="65">이 름</td>
			<td bgcolor="#fff8ee" width="90">관 계</td>
			<td bgcolor="#fff8ee" width="110">주민등록번호</td>
			<td bgcolor="#fff8ee" width="65">자료 구분</td>
			<td bgcolor="#fff8ee" width="100">일반보장성보험료</td>
			<td bgcolor="#fff8ee" width="100">장애인전용보험료</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPNMK" style= "position:relative;left:0px;top:2px;width:65px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
				<object id="f_FAMNMK" style= "position:relative;left:0px;top:2px;width:65px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
				<object id="f_FAMRELA_NM" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
				<object id="f_FAMJUNO" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
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
				<object id="f_REFB11" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
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
				<object id="f_REFB12" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
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
				<object id="f_REFB13" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
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
				<object id="f_REFB14" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
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
				<object id="f_REFTOT1" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
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
				<object id="f_REFTOT2" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
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
		<C>Col=EMPNMK 	Ctrl=f_EMPNMK  	Param=text</C>
		<C>Col=EMPNO  	Ctrl=f_EMPNO   	Param=text</C>		
		<C>Col=EMPJUNO	Ctrl=f_EMPJUNO 	Param=text</C>
		<C>Col=APPDT  	Ctrl=f_APPDT   	Param=text</C>
		<C>Col=FAMRELA_NM	Ctrl=f_FAMRELA_NM 	Param=text</C>
		<C>Col=FAMRELA_CD	Ctrl=f_FAMRELA_CD 	Param=text</C>		
		<C>Col=FAMNMK 	Ctrl=f_FAMNMK  	Param=text</C>
		<C>Col=FAMJUNO	Ctrl=f_FAMJUNO 	Param=text</C>
		<C>Col=REF1   	Ctrl=f_REF1    	Param=value</C>
		<C>Col=REF2   	Ctrl=f_REF2    	Param=value</C>
		<C>Col=REF3   	Ctrl=f_REF3    	Param=value</C>
		<C>Col=REF4   	Ctrl=f_REF4    	Param=value</C>
		<C>Col=REF5   	Ctrl=f_REF5    	Param=value</C>
		<C>Col=REFB11 	Ctrl=f_REFB11  	Param=text</C>
		<C>Col=REFB12 	Ctrl=f_REFB12  	Param=text</C>
		<C>Col=REFB13 	Ctrl=f_REFB13  	Param=text</C>
		<C>Col=REFB14 	Ctrl=f_REFB14  	Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>


</body>
</html>
