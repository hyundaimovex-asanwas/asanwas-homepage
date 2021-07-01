<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : erp 사용자 계정 관리
 * 프로그램ID  	: SY010I
 * J  S  P   	: Sy010i
 * 서 블 릿     : Sy010I
 * 작 성 자     : 심동현
 * 작 성 일     : 2014-07-10
 * 기능정의     : 
 * [ 수정일자 ][수정자] 내용
 * [2014-07-10][심동현] erp 로긴 사용자관리
 *						√ 사용유무 수정 → COMMON.GD0083에 변경 이력이 남는다.
 *						√ 계정 삭제 → COMMON.GD0083에 변경 이력이 남는다.
 *			신규 계정 생성시
 * [2015-06-12][심동현] 비밀번호 초기화
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
<script language="javascript">

    var v_job = "H";

    var v_Main_row = 0;

    
   //페이지로딩
	function fnOnLoad(tree_idx){
	   
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		fnInit();
		
	}
	
   
   //선조회
   function fnInit(){
	   
        v_job = "H";
        
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        

 		//작업상태1 - SY011은 사용(Y)/중단(N) 2개만 있다. 
        ds_use.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY011&s_Item2=Y";
        ds_use.Reset();
 		
        
   }

   
   
   
   
	<%//메인조회%>
    function fnSelect() {
    	
		v_job = "S";
		
           msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           
           var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			           + ",sEmpno=" + v_empno.Text
			           + ",sStatus="+ lc_status1.ValueOfIndex("detail", lc_status1.Index);

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_SY%>Sy010I",
               "JSP(O:Main=ds1)",
               v_param);
           
           tr_post(tr1);
           
    }


	<%// 취소%>
	function fnCancel() {
		
        ds1.undoall();
        
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		
		return;		
		
	}

	
	
	<%// 그리드 행삭제%>
	function fnAddRow() {
		
		ds1.AddRow();
		
	}
	
	
	
	<%// 그리드 행삭제%>
	function fnDeleteRow() {
		
		ds1.DeleteRow(ds1.RowPosition);
		
	}
	
	
	
	<%//저장 (신규메뉴 권한 신청)- 관리자가 확인 후 실제로 저장해주는 것.. 엄청 피곤할지도.. ;; %>
	function fnApply() {
		
		if (ds1.IsUpdated) {
			
			v_job = "A";
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy010I",
			    "JSP(I:DS1=ds1)",
			    param);
			
			tr_post(tr1);  
			

		} else {
			alert("수정된 행이 없습니다.");

		};
	}

	
	
	<%// pw초기화%>	
	function fnReset(empid) {
		
		v_job = "R";
		
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
			+ ",sEmpno=" + empid;
		
		
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy010I",
		    "JSP(I:DS2=ds1)",
		    param);
		
		
		tr_post(tr1);  	
		
		
		
	}	

	
	
	
	
    <%//직원 팝- 검색조건 처리자 : 관리자만 가능하게%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		
    		v_empno.text = arrParam[1];
    		//v_eno_nm.value = arrParam[0];

    		
        } else {
        	
			//fnEmpNoCleanup();
			
        }               
    	
    }		
	
	
</script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		if(colid=="PW_RESET"){
			if(confirm( "사번 ["+ds1.NameValue(row, "EMPID")+ "] 를 초기화하시겠습니까?" )){
				fnReset(ds1.NameValue(row, "EMPID"));
			};
		}
	</script>
<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
	msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    if(v_job=="A"){
    	alert("저장되었습니다.");
	    //for(var i=1; i<=ds1.CountRow; i++){
	        //ds1.NameValue(i, "CHK") = "T";
	    //}    	
    }
    if(v_job=="R"){
    	alert("초기화되었습니다.");
    }
</script>

<script language="javascript" for="tr1" event="OnFail()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";

    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="")
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>


<%
/*=============================================================================
         DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=javascript for=ds2 event="OnLoadCompleted(Row)">
    if(Row==0) return;
</script>


<%
/*=============================================================================
         DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table border="0" width="1000px"  cellpadding="0" cellspacing="0">
		  <tr>
			<td align="right">
				<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				  <tr>
					<td align="right" height="30px">
					    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRow()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRow()" >
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer" onclick="fnCancel()">
						<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:pointer" onclick="fnApply()">
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>
		  <tr>
			<td>
			  <table width=1000 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
				<tr height="25px">
                  <td width="100px" class="text">사번
                  </td>
                  <td align="left" bgcolor="#ffffff">&nbsp;
                    <object id=v_empno classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                        <param name=Format      value="0000000">
                        <param name=Alignment   value=1>
                        <param name=ClipMode    value=true>
                        <param name=Border      value=false>
                        <param name=SelectAll   value=true>
                        <param name=SelectAllOnClick      value=true>
                        <param name=SelectAllOnClickAny   value=false>
                    </object>
	  				<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onclick="fnEmpNoPopup('<%=dirPath%>');" alt="직원 찾기" style="cursor:hand;">
                  </td>
				  <td align="center" width="70px"  class="text">사용 유무</td>
				  <td align="center" bgcolor=#ffffff>
                    <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=80 width=80 border="0" align=absmiddle>
						<param name=ComboDataID		value=ds_use>
						<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^80">
					</object>	
				  </td>
				</tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>		  
		  <tr>
			<td width="845px">
				<table  border="0" cellpadding="0" cellspacing="0" >
				  <tr valign="top"">
					<td width=845>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=1000px; height:530px" border="1">
					        <param name="DataID"            value="ds1">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="True">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="SuppressOption"    value="1">
					        <param name="ViewSummary"   	value="1">
					        <param name="SortView"			value="Right">
					        <param name="Format"            value="
					            <C> name='체크'      	ID='CHK'   	 	Width=50  	align=center 	EditStyle=CheckBox edit=True </C>
					            <C> name='사번'     	ID='EMPID'   	Width=80  	align=center 	Sort=True</C>
					            <C> name='아이디'      	ID='AED'     	Width=100  	align=center 	Sumtext=@cnt bgColor={IF(AED='aed','#FFFF00','#FFFFFF')}</C>
					            <C> name='이름'      	ID='EMPNM'   	Width=80  	align=center  </C>
					            <C> name='생성일시'    	ID='I_TIME'   	Width=140  	align=center  	edit=none</C>
					            <C> name='사용' 	    ID='YN_USE'    	Width=70  	align=center 	editstyle=lookup data='ds_use:detail:detail_nm' bgColor={IF(YN_USE='N','#FFFF00','#FFFFFF')} </C>
					            <C> name='부서'      	ID='DPT_NM'   	Width=120  	align=center  	edit=none Sort=True</C>
					            <C> name='직위'      	ID='JOB_NM'   	Width=110  	align=center  	edit=none</C>
					            <C> name='퇴사일'      	ID='RET_YMD'   	Width=90  	align=center  	edit=none</C>
					            <C> name='재직'      	ID='USE_YN'  	Width=50  	align=center  	edit=none bgColor={IF(USE_YN='N','#FFFF00','#FFFFFF')}</C>
					            <C> name='PW초기화'    	ID='PW_RESET' 	Width=80  	align=center 	edit=none </C>
					        ">
					    </object>
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
	<td style="padding-top:6px">※ 사용 컬럼을 수정하면 → COMMON.GD0083에 변경 이력이 남음<br>
	※ 계정을 삭제하면 → COMMON.GD0083에 변경 이력이 남음<br>
	　아이디 = "aed" 는 계정 생성 후 해당 직원이 아이디를 만들지 않은 경우입니다.<br>
	※ 계정을 생성할 때 : 사용=중단으로 조회 후 사번, 아이디, 이름만 입력 후 저장<br>
	　→ COMMON.GD0083에 변경 이력이 남음<br>
	※ PW초기화 컬럼을 더블클릭하면 → hda사번! 로 초기화됩니다. 한 번에 한 명만 가능합니다.^^<br>
	　
	　

	</td>
  </tr>

</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

