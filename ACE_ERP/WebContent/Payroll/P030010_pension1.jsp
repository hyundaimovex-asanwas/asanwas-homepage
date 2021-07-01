<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 주택마련저축공제
 * 프로그램ID 	: P030010_house1
 * J  S  P		: P030010_house1,P030010_08s
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의	: 
 *                   
 * 최종수정일자 	: 2011-01-12
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//귀속년도
    String eno 		 = request.getParameter("eno");				//사번
%>

<html>
<head>
<title><%=eyy%> 년 근로소득공제 개인연금, 연금저축, 장기주식형저축등 상세 입력</title>
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

		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회

	}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //동현스 : 파라미터 받아서 기본 조회

			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i_08",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);

			//prompt(this, ds1.text);
			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')="none"; //입력불가능
	}
	
/******************************************************************************
	Description : 추가
******************************************************************************/
	function fnAddRow(){

		ds1.AddRow();		//데이터셋 헤더 설정이 안되서 그냥하면 안되었당..
							// 처음 조회할때 헤더설정을 받아온다. 관광은 빈조회를 한다..

		ds1.namevalue(ds1.RowPosition, "APPYY") = ds1.namevalue(1, "APPYY");
		ds1.namevalue(ds1.RowPosition, "EMPNMK") = ds1.namevalue(1, "EMPNMK");
		ds1.namevalue(ds1.RowPosition, "EMPJUNO") = ds1.namevalue(1, "EMPJUNO");
		ds1.namevalue(ds1.RowPosition, "DUDGB") = ds1.namevalue(1, "DUDGB");		
		ds1.namevalue(ds1.RowPosition, "EMPNO") = ds1.namevalue(1, "EMPNO");

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

		//prompt(this,(ds1.namevalue(ds1.rowposition,"STATDT")));

	    if(!Pension_Apply_Chk()) return;

        if (ds1.IsUpdated) {

			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			}

			v_job = "I";	

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"        
				
            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_08",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);

        } else {
            alert("상세 정보의 변경 내역이 없습니다.");
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
	Description : 확인작업
******************************************************************************/
    function Pension_Apply_Chk() {




			//if((ds1.namevalue(ds1.rowposition,"STATDT")).length != 8){
			//		alert("가입일의 자리수가 맞지 않습니다.");
			//		return false;
			//}

		if(ds1.namevalue(ds1.rowposition,"DUDGB") != '41' ){	
		if(ds1.namevalue(ds1.rowposition,"STATDT") >= '20110101' ){
		alert("가입일의 경우 2011년 이전 자료만 입력바랍니다.");
		return false;
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20101231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20100101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "1";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20091231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20090101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "2";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20081231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20080101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "3";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20071231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20070101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "4";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20061231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20060101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "5";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20051231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20050101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "6";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20041231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20040101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "7";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20031231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20030101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "8";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20021231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20020101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "9";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20011231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20010101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "10";
		}else{
		ds1.namevalue(ds1.rowposition,"YEARLY") = "11";		
		}
		}


	if(ds1.namevalue(ds1.rowposition,"DUDGB") == '21' ){
		if(ds1.namevalue(ds1.rowposition,"STATDT") > '20010101'){
		alert("개인연금저축은 2000년 12월 31일 이전 가입한 저축만 입력할 수 있습니다.");		
		ds1.namevalue(ds1.rowposition,"STATDT")="";
		return false;
		}
	}

	if(ds1.namevalue(ds1.rowposition,"DUDGB") == '22' ){
		if(ds1.namevalue(ds1.rowposition,"STATDT") < '20010101'){
		alert("연금저축은 2001년 1월 1일 이후 가입한 저축만 입력할 수 있습니다.");		
		ds1.namevalue(ds1.rowposition,"STATDT")="";
		return false;
		}
	}

		if(ds1.namevalue(ds1.rowposition,"ACCNO") == ""){
		alert("계좌번호는 필수입력 사항입니다.");		
		return false;
		}

		if(ds1.namevalue(ds1.rowposition,"STATDT") == ""){
		alert("가입일은 필수입력 사항입니다.");		
		return false;
		}

            return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/

	function fnCancel() {	//취소시 undo all. 
		ds1.undoall();
	} 

	function fnClose()	{
		window.close();
		opener.fnSelect11("<%=eyy%>", "<%=eno%>");		//주택
	}
	

function openFinance(){

	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	strURL = "P030010_financeselect.jsp"
	strPos = "dialogWidth:380px;dialogHeight:400px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no"; 

	arrResult = showModalDialog(strURL,arrSend,strPos);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.RowPosition, "FINACD") = arrParam[0]; 
			ds1.namevalue(ds1.RowPosition, "FINANM") = arrParam[1]; 
		} 
}

</script>




<script language=JavaScript for=gr1 event=OnCloseUp(row,colid)>


			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')="none"; //입력불가능

	if(ds1.namevalue(ds1.rowposition,"DUDGB") == '41' ){

	//alert("1");
		//YEARLY.enable = "false";
			//alert(ds1.namevalue(ds1.RowPosition, "YEARLY"));		
			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')=""; //입력가능

	}else{


			ds1.namevalue(ds1.RowPosition, "YEARLY") ="-";	
			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')="none"; //입력불가능
			//ds1.namevalue(ds1.RowPosition, "YEARLY").ReadOnly = "false";
	}




</script>
 





<script language="javascript" for="tr1" event="onsuccess()">   

    if(v_job=="I") {	//저장
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose();
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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



<script language=javascript for="gr1" event="OnClick(row, Colid)">
//클릭할 때 팝업 띄우기
    var strResino="";
	var strGb="";
	var strGb2="";



    if(row<1){
     return;
    }

    if (Colid =="FINANM") { 
    	//alert(ds1.namevalue(ds1.rowposition, "RESINO1"));
    	openFinance();
	}



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
	<!-- 인적사항 및 공제항목 -->
	<table width="975" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="10">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3">☞ 입력안내</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#000000">1. 모든 항목란에 정확한 내용을 입력하셔야 합니다.</font></td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">2. 저축불입계약기간 만료 후 연금의 형태로 지급받는 저축으로서 법정 요건을 갖춘 저축입니다.

						</font></b>
						</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">3. 금융기관의 경우 팝업창에서 검색을 통해서 선택합니다.<br></font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#000000">4. 증빙서류는 내역 입력순서와 일치되도록 정리하여 주시기 바랍니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(A4크기보다 작은 증빙서류는 A4 이면지에 부착 후 제출요망)</font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="red">5. 유형중 장기주식형저축의 경우에만 년차 선택하시기 바랍니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(그 밖의 유형은 년차 입력 필요없음)</font>
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
							&nbsp;&nbsp;<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">
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
	<Param Name="UsingOneClick" value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<FC> Name='귀속년월'		ID=APPYY   		Width=70	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1 show=false</FC>
	<G> name='근로소득자'
		<FC> Name='성명'		ID=EMPNMK  		Width=60	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='주민번호'	ID=EMPJUNO  	Width=120	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2</FC>
	</G>

	<G> name='구 분'
		<FC> Name='유형'		ID=DUDGB		Width=170	HeadAlign=Center align=center EditStyle=Combo 
			 Data='11:퇴직연금,12:과학기술인공제,21:개인연금저축,22:연금저축,41:장기주식형저축소득공제'</FC>
		<FC> Name='년차'	ID=YEARLY  	Width=70	HeadAlign=Center align=center EditStyle=Combo Data='1:1년차,2:2년차,3:3년차'</FC>
	</G>

	<C> Name='금융기관코드'		ID=FINACD     Width=240	HeadAlign=Center align=LEFT show=TRUE	EDIT=none show=false</C>
	<C> Name='금융기관'			ID=FINANM     Width=180	HeadAlign=Center align=center show=TRUE	</C>
	<C> Name='계좌번호'			ID=ACCNO     Width=140	HeadAlign=Center align=center show=TRUE	Edit=numeric editlimit=16</C> 	
	<C> Name='가입일'				ID=STATDT     Width=110	HeadAlign=Center align=center show=TRUE	mask='XXXX-XX-XX' editlimit=8</C> 	
	<C> Name='납입액'				ID=PAYAMT     Width=120	HeadAlign=Center align=right show=TRUE	 Dec=0 editlimit=8</C> 		
	<C> Name='공제액'				ID=DEDAMT     Width=100	HeadAlign=Center align=right show=false	 Dec=0</C> 	

	<C> Name='사번'	    	ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    	ID=FLAGCOL		Width=20	show=false</C>	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>



</body>
</html>
