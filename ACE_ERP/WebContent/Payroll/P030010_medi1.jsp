      <%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 의료비공제
 * 프로그램ID 	: P030010_medi1
 * J  S  P		: P030010_03i,P030010_03s
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의	: 
 *                   
 * 최종수정일자 	: 2011-01-5
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
<title><%=eyy%> 년 근로소득공제 의료비 상세 입력</title>
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

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i_03",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	
/******************************************************************************
	Description : 추가, 삭제, 저장, 취소
******************************************************************************/
	function fnAddRow(){

		//prompt(this, ds1.namevalue(1, "APPDT"));

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
	

/******************************************************************************
	Description : 행삭제
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

		//prompt(this, ds1.text);
		
		if(!Medi_Apply_Chk("ds1")) return;
		
        if (ds1.IsUpdated) {        
			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			}

			v_job = "I";	

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_03",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);

        } else {
            alert("의료비 상세 정보의 변경 내역이 없습니다.");
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
	}



/******************************************************************************
	Description :  증빙코드가 1이면 사업자번호,상호,건수, 그 외의 것들 입력 방지 
******************************************************************************/
	function ln_Grid_Prfcdlock(row){

		if(ds1.namevalue(row,"PRFCD")=="1"){
			getObjectFirst("gr1").ColumnProp('INDNO','Edit')="none"; //입력불가
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="none";
			getObjectFirst("gr1").ColumnProp('CASHCNTB','Edit')="none";
			getObjectFirst("gr1").ColumnProp('CASHAMTB','Edit')="none";
			alert("증빙코드가 1:국세청장이 제공하는 의료비자료일 경우 공제대상자 별로 의료비 지출합계액만 입력하세요");
		} else{
            getObjectFirst("gr1").ColumnProp('INDNO','Edit')=""; //입력가능
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="";
			getObjectFirst("gr1").ColumnProp('CASHCNTB','Edit')="";
			getObjectFirst("gr1").ColumnProp('CASHAMTB','Edit')="";
	    }
    }
</script>


<script language=javascript for="gr1" event="OnClick(row, Colid)">
	if(ds1.namevalue(row,"PRFCD")=="1"){
			getObjectFirst("gr1").ColumnProp('INDNO','Edit')="none"; //입력불가
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="none";
		} else{
			getObjectFirst("gr1").ColumnProp('INDNO','Edit')=""; //입력가능
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="";
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

<script language=JavaScript for=gr1 event=OnCloseUp(row,colid)>
    if(colid=="PRFCD"){ //증빙코드가 1이면 사업자번호,상호,건수 입력 방지 
		ln_Grid_Prfcdlock(row);
    }
</script>

<script language=JavaScript for=ds1 event="OnLoadCompleted(Row)">
	if(Row>0){
		for(i=1;i<=Row;i++){
		}
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


<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<form name="entry" method="post" action="">
	<!-- 인적사항 및 공제항목 -->
   <br>
   <b><font face="굴림">&nbsp;※ 의료비공제</a></font></b> 
   <b><font color="EA5200" size="2" face="굴림"> &nbsp;(공제 대상자 연령, 소득 제한 없음)</font></b><br>
   <table width="970" border="0" cellspacing="0" cellpadding="0">
      <tr bgcolor="#FFFFFF">
	    <td height="85">
		   <table width="100%" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
		   <tr bgcolor="#FFF8EE">
				<td width="115">
					<div align="center"><font face="굴림">구 분</font></div>
				</td>
				<td width="600">
					<div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
				</td>
				<td width="250">
					<div align="center"><font face="굴림">공 제 금 액</font></div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="115" bgcolor="#FFF8EE">
					<div align="center"><font face="굴림">기본공제 </font></div>
				</td>
				<td width="600"><font face="굴림">기본공제대상자(연령,소득불문) 중 본인,65세 이상자, 장애인을 위하여 지출한 의료비</font>
				</td>

				<td width="250">
					<div align="center"><font face="굴림">당해 의료비전액(단, 아래의 추가공제가 “－”이면 기본공제에서 차감) </font></div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="115" bgcolor="#FFF8EE">
					<div align="center"><font face="굴림">추가공제 </font></div>
				</td>
				<td width="600"><font face="굴림">기본공제대상자(연령,소득불문) 중 본인, 65세 이상자, 장애인 이외의 자를 위하여 지출한 의료비</font>
				</td>
				<td width="250">
					<div align="center"><font face="굴림">Min(당해 의료비-총급여액×3%, 700만원) </font></div>
				</td>
			</tr>
		 </table>
		</td>
	</tr>

	<tr bgcolor="#FFFFFF">
	       <td  height="50">
			<font color="#7800BF" size="2" face="굴림">&nbsp;※ 참고 </font> <br><b>
			&nbsp;소득공제대상의료비에 미용ㆍ성형수술을 위한 비용 및 건강증진을 위한 의약품 구입비용을 불포함</b><br>
            &nbsp;- 미용ㆍ성형수술비(유방확대, 지방흡입, 보톡스, 스케일링, 모발이식, 비만치료 등)<br>
            &nbsp;- 보약, 기타의 건강증진 의약품<br>
			</td>
	</tr>
    <tr bgcolor="#FFFFFF">
		<td colspan="12" height="30">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="2">&nbsp;☞ 입력안내</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><font color="#FF6633">1. 금액(총액 - 공단·보험자부담금 = 환자부담금)을  입력하셔야 합니다. <br>
					2. 1인당 시력보정용 안경(렌즈) 구입비가 연 50만원을 초과하는 경우 50만원까지만 입력바랍니다.<br>

					</font></td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
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

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 970px; HEIGHT: 290px;border:1 solid #777777;display:;" viewastext>
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
	<FC> Name='년월'			 ID=APPDT   		Width=50	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1 show=false</FC>
	<G> name='근로자'
		<FC> Name='성명'		 ID=EMPNMK  	Width=45	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='주민번호'	 ID=EMPJUNO  	Width=90	HeadAlign=Center align=left mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2 </FC>
	</G>
	<G> name='공 제 대 상 자'
		<FC> Name='성명'		 ID=FAMNMK		Width=45	HeadAlign=Center align=center  EDIT=NONE  SUPPRESS=3</FC>
		<FC> Name='관계'		 ID=FAMRELA_NM	Width=88	HeadAlign=Center align=center  SUPPRESS=3</FC>
		<FC> Name='가족주민번호' ID=FAMJUNO		Width=89	HeadAlign=Center align=center	 mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=3</FC>
	</G>
	<G> name='지급처'
		<C> Name='증빙코드'		ID=PRFCD		Width=208  HeadAlign=Center align=center EditStyle=Combo Data='1:국세청장이 제공하는 의료비 자료,2:국민건강보험공단의료비부담명세서,3:진료비계산서/약제비계산서,4:장기요양급여비용,5:기타의료비영수증'</C>
		<C> Name='사업자번호'	ID=INDNO 		Width=82	HeadAlign=Center align=center  mask='XXX-XX-XXXXX' EDIT=NUMERIC</C>	
		<C> Name='상   호'		ID=INDNAME		Width=130	HeadAlign=Center align=center </C>
	</G>

	<G> name='국세청자료'
		<C> Name='건수'			ID=CASHCNTA		Width=26	HeadAlign=Center align=center  EDIT=NUMERIC </C>
		<C> Name='현금' 		ID=CASHAMTA		Width=70	HeadAlign=Center align=RIGHT   EDIT=NUMERIC dec=0 </C>	
	</G>		
	<G> name='그밖의 자료'
		<C> Name='건수'			ID=CASHCNTB		Width=26	HeadAlign=Center align=center  EDIT=NUMERIC </C>	
		<C> Name='현금' 		ID=CASHAMTB		Width=70	HeadAlign=Center align=RIGHT  EDIT=NUMERIC dec=0 </C>	
	</G>
	<C> Name='사번'				ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	show=false</C>	
	<C> Name='관계코드'			ID=FAMRELA_CD	Width=35	HeadAlign=Center align=center show=false SUPPRESS=3</C>		
	<C> Name='외국인YN'			ID=REF1   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='100만원이하YN'	ID=REF2   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='장애인YN'			ID=REF3   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='자녀YN'			ID=REF4   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='경로YN'			ID=REF5   		Width=40	HeadAlign=Center align=center show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>


</body>
</html>
