      <%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 급여시스템
 * 프로그램ID 	: P030009_medi1
 * J  S  P		: P030009_03i,P030009_03s
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의	: 
 *                   
 * 최종수정일자 	: 2007-01-11
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
<title>2006년 근로소득공제 의료비 상세 입력</title>
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
			    "../services/servlet/Payroll.p030009i_03",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	
/******************************************************************************
	Description : 추가, 삭제, 저장, 취소
******************************************************************************/
	function fnAddRow(){
		ds1.AddRow();		//데이터셋 헤더 설정이 안되서 그냥하면 안되었당..
							// 처음 조회할때 헤더설정을 받아온다. 관광은 빈조회를 한다..
	
		ds1.namevalue(ds1.RowPosition, "APPDT") = ds1.namevalue(1, "APPDT");
		ds1.namevalue(ds1.RowPosition, "EMPNMK") = ds1.namevalue(1, "EMPNMK");
		ds1.namevalue(ds1.RowPosition, "EMPJUNO") = ds1.namevalue(1, "EMPJUNO");
		ds1.namevalue(ds1.RowPosition, "FAMNMK") = ds1.namevalue(1, "FAMNMK");
		ds1.namevalue(ds1.RowPosition, "FAMRELA_NM") = ds1.namevalue(1, "FAMRELA_NM");
		ds1.namevalue(ds1.RowPosition, "FAMJUNO") = ds1.namevalue(1, "FAMJUNO");
		ds1.namevalue(ds1.RowPosition, "EMPNO") = ds1.namevalue(1, "EMPNO");
		ds1.namevalue(ds1.RowPosition, "FAMRELA_CD") = ds1.namevalue(1, "FAMRELA_CD");
		ds1.namevalue(ds1.RowPosition, "REF1")= ds1.namevalue(1, "REF1");
		ds1.namevalue(ds1.RowPosition, "REF2")= ds1.namevalue(1, "REF2");
		ds1.namevalue(ds1.RowPosition, "REF3")= ds1.namevalue(1, "REF3");
		ds1.namevalue(ds1.RowPosition, "REF4")= ds1.namevalue(1, "REF4");
		ds1.namevalue(ds1.RowPosition, "REF5")= ds1.namevalue(1, "REF5");
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
                "../services/servlet/Payroll.p030009i_03",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("의료비 상세 정보의 변경 내역이 없습니다.");
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
<table width="970" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">☞ 입력안내</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td>1. 모든 항목란에 정확한 내용을 입력하셔야 합니다.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">2. <b><u>사용인이 동일 지급처에 여러 건 지급한 경우 "연간 총액"을 입력하시면 됩니다.</b></u></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">3. 금액(총액 - 공단·보험자부담금 = 환자부담금)을 지급한 "수단"을 구별하여 입력하셔야 합니다.</font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>4. 증빙서류는 의료비 지급내역 입력순서와 일치되도록 정리하여 주시기 바랍니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(A4 크기보다 작은 증빙서류는 A4 이면지에 부착 후 제출요망)
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font style="font-size:12pt;color:#3366FF;"><b>※ <u>1인당 시력보정용 안경(렌즈) 구입비가 연 50만원을 초과하는 경우 50만원까지만 입력바랍니다.</u><br>
						&nbsp;&nbsp;&nbsp;&nbsp;<u>(연 50만원 한도임)</u></b></font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right"><br><font color="#FF6633">※ 신용카드(현금영수증)사용 의료비의 이중공제 배제규정이 2007년으로 연기됨에 따라
						"결재수단"에 상관없이 활성화된 금액란에 입력하시면 됩니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
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
							　<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">							
						</nobr>&nbsp;</td>
					</tr>					
				</table>
			</td>
		</tr>
	</table>

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 970px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
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
	<FC> Name='년월'				ID=APPDT   		Width=50	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1</FC>
	<G> name='근로소득자'
		<FC> Name='성명'				ID=EMPNMK  		Width=60	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='주민번호'			ID=EMPJUNO  	Width=90	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2</FC>
	</G>
	<G> name='공 제 대 상 자'
		<FC> Name='성명'				ID=FAMNMK		Width=60	HeadAlign=Center align=center  EDIT=NONE  SUPPRESS=3</FC>
		<FC> Name='관계'		ID=FAMRELA_NM	Width=50	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=3</FC>
		<FC> Name='가족주민번호'		ID=FAMJUNO		Width=90	HeadAlign=Center align=center	 mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=3</FC>
	</G>

	<G> name='지급처'
		<C> Name='사업자번호'		ID=INDNO 		Width=90	HeadAlign=Center align=center  mask='XXX-XX-XXXXX' EDIT=NUMERIC</C>	
		<C> Name='상   호'			ID=INDNAME		Width=160	HeadAlign=Center align=center </C>
	</G>
	<G> name='국세청자료'
		<C> Name='건수'			ID=CARDCNTA		Width=50	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='금 액'			ID=CARDAMTA		Width=100	HeadAlign=Center align=RIGHT  EDIT=NUMERIC</C>	
	</G>		
	<G> name='그밖의 자료'
		<C> Name='건수'			ID=CARDCNTB		Width=50	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='금 액'			ID=CARDAMTB		Width=100	HeadAlign=Center align=RIGHT  EDIT=NUMERIC</C>	
	</G>

	<C> Name='사번'				ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	show=false</C>	
	<C> Name='관계코드'			ID=FAMRELA_CD	Width=35	HeadAlign=Center align=center show=false SUPPRESS=3</C>		
	<C> Name='외국인YN'			ID=REF1   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='100만원이하YN'		ID=REF2   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='장애인YN'			ID=REF3   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='자녀YN'			ID=REF4   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='경로YN'			ID=REF5   		Width=40	HeadAlign=Center align=center show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>


</body>
</html>
