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
//    String eGivcod	 = request.getParameter("eGIVCOD");		//공제대상 이름
    String eGivtype  = "";
    
    

%>

<html>
<head>
<title>2006년 근로소득공제 기부금 상세 입력</title>
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
	
		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회
	}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
	function fnSelect(pYear, pEmpno, pGivcod) {	 //동현스 : 파라미터 받아서 기본 조회
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;
//			          + ",eGIVCOD="     + pGivcod;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i_06",	//		경로 주의할 것!
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
		ds1.namevalue(ds1.RowPosition, "GIVCOD") = ds1.namevalue(1, "GIVCOD");		
		ds1.namevalue(ds1.RowPosition, "GIVYEAR") = ds1.namevalue(1, "GIVYEAR");
		ds1.namevalue(ds1.RowPosition, "GIVMONTH") = ds1.namevalue(1, "GIVMONTH");		
		ds1.namevalue(ds1.RowPosition, "EMPNO") = ds1.namevalue(1, "EMPNO");
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
                "../services/servlet/Payroll.p030009i_06",
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
		opener.fnSelect4("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
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
//		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회
		fnClose();		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
//		ds1.namevalue(1, "REF1")="";
		

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
	<table width="975" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="3">☞ 입력안내</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#000000">1. 모든 항목란에 정확한 내용을 입력하셔야 합니다.</font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">2. 기부처의 사업자등록번호(고유번호), 대표자 주민등록번호(예- 개인이 운영하는 절의 경우 주지스님) 중 해당번호를 입력하시면 됩니다.</font></b>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;※ 정치자금기부금은 기부처 내역을 입력하지 않습니다.</font></b>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">3. <b><u>근로자 본인이 동일 기부처에 여러 건 기부한 경우 "연간 총액"을 입력하시면 됩니다.</u></font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;※ 정치자금 기부금 총액 입력 후 10만원 이하금액은 세액공제란으로 자동 입력(이동)됩니다.</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">4. 근로자 본인명의로 기부한 금액만을 입력하셔야 합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(가족명의의 기부금은 소득공제 불가)</font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#000000">5. 증빙서류는 기부처 내역 입력순서와 일치되도록 정리하여 주시기 바랍니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(A4크기보다 작은 증빙서류는 A4 이면지에 부착 후 제출요망)</font>
						</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td><font color="red"><br><b>★ 기부금 유형, 지급 월, 사업자등록번호는 최초 입력 후 수정되지 않습니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;수정하시려면 삭제 후 새로 입력하시기 바랍니다.</b></font>
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
	<FC> Name='귀속년월'		ID=APPDT   		Width=60	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1</FC>
	<G> name='근로소득자'
		<FC> Name='성명'		ID=EMPNMK  		Width=60	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='주민번호'	ID=EMPJUNO  	Width=90	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2</FC>
	</G>
	<G> name='구 분'
		<FC> Name='유형'		ID=GIVCOD		Width=60	HeadAlign=Center align=center EditStyle=Combo 
			 Data='10:법정,20:정치,40:지정'</FC>
	</G>

	<G> name='지급'
		<C> Name='년'		ID=GIVYEAR 		Width=45	HeadAlign=Center align=center EDIT=FALSE </C>	
		<C> Name='월'		ID=GIVMONTH		Width=45	HeadAlign=Center align=center EditStyle=Combo
			Data='01:1월,02:2월,03:3월,04:4월,05:5월,06:6월,07:7월,08:8월,09:9월,10:10월,11:11월,12:12월'</C>
		
	</G>
	<C> Name='적요'			ID=GIVJYO  		Width=150	HeadAlign=Center align=LEFT show=TRUE	SUPPRESS=2</C> 		
	<G> name='기부처'
		<C> Name='상호(법인명,단체명)'		ID=GIVCOMP		Width=120	HeadAlign=Center align=center </C>	
		<C> Name='사업자등록번호'			ID=GIVSAUP		Width=100	HeadAlign=Center align=center  EDIT=NUMERIC mask='XXX-XX-XXXXX'</C>	
	</G>		
	<G> name='국세청 자료'
		<C> Name='건수'		ID=GIVCNT1		Width=40	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='금액'		ID=GIVAMT1		Width=70	HeadAlign=Center align=RIGHT  EDIT=NUMERIC</C>	
	</G>

	<G> name='그밖의 자료'
		<C> Name='건수'		ID=GIVCNT2		Width=40	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='금액'		ID=GIVAMT2		Width=70	HeadAlign=Center align=RIGHT  EDIT=NUMERIC</C>	
	</G>

	<C> Name='사번'				ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	show=false</C>	
	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>


</body>
</html>
