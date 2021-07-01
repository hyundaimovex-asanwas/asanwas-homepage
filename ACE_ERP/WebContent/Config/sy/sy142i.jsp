<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 개인별 관광영업 메뉴 권한 조회
 * 프로그램ID  	: SY142I
 * J  S  P   	: Sy142i
 * 서 블 릿     : Sy142I
 * 작 성 자     : 박경국
 * 작 성 일     : 2008-09-28
 * 기능정의     : 개인별 관광영업 메뉴 권한 조회
 * [ 수정일자 ][수정자] 내용
 * [2015-06-11][심동현] config 쪽으로 import 수정, my142i와 동일한 쿼리, 파라미터만 오픈
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

 		//작업상태1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item2=Y";
        ds_status1.Reset();
 		
   }

   
   /*
    * 메인조회
    */
    function fnSelect() {
	   
		if(v_empno.Text==''&&v_cust_nm.value==''){
			
			alert("사번 또는 성명을 입력해 주십시오.");
			
			v_empno.focus();
			
		}else{
			
			v_job = "S";
			
			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			         + ",sEmpno=" + v_empno.Text
			         + ",sEMPNMK=" + v_cust_nm.value;
			
			ln_TRSetting(tr1,
			          "<%=dirPath%><%=HDConstant.PATH_MY%>My142I",
			    "JSP(O:Main=ds1)",
			    v_param);
			
			tr_post(tr1);
			
		}
		
    }

   

	// 엑셀
	function fnExcelDs1() {
		
		if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        } 
		
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:메뉴목록조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("메뉴목록조회","메뉴목록조회.xls", 8);
        
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
    		v_cust_nm.value = arrParam[0];

    		
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

<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

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
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>

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
					    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->					    
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
                  <td width="100px" class="text">신청자 사번
                  </td>
                  <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                    <object id=v_empno classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                        <param name=Format      value="0000000">
                        <param name=Alignment   value=1>
                        <param name=ClipMode    value=true>
                        <param name=Border      value=false>
                        <param name=SelectAll   value=true>
                        <param name=SelectAllOnClick      value=true>
                        <param name=SelectAllOnClickAny   value=false>
                    </object>
                    <%=HDConstant.COMMENT_END%>
	  				<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onclick="fnEmpNoPopup('<%=dirPath%>');" alt="직원 찾기" style="cursor:hand;">                    
                  </td>
				 	<td align=left class="text" width="70px">성명</td>
			        <td align=left bgcolor="#ffffff" >&nbsp;
			        	<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);">
			       	</td>
			      </tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>		  
		  <tr>
			<td width="1000px" valign="top"">
			    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width:1000px; height:600px" border="1">
			        <param name="DataID"            value="ds1">
			        <param name="BorderStyle"       value="0">
			        <param name="ColSizing"         value="true">
			        <param name="editable"          value="True">
			        <Param Name="UsingOneClick"     value="1">
			        <Param Name="AllShowEdit"       value="True">
			        <param name="SuppressOption"    value="1">
			        <param name="ViewSummary"   	value="1">
			        <param name="Format"            value="
			            <C> name='부서'      	ID='DEPTNM'   	Width=100  	align=center suppress=1 edit=none</C>
			            <C> name='성명'      	ID='EMPNMK'    	Width=100  	align=center suppress=2 edit=none</C>
			            <C> name='사번'      	ID='EMPNO'   	Width=100  	align=center suppress=2 edit=none</C>
			            <C> name='메뉴ID'       ID='TREE_ID'   	Width=100  	align=left  	edit=none </C>
			            <C> name='메뉴번호'     ID='TREE_IDX'  	Width=100  	align=center  	edit=none</C>
			            <C> name='메뉴명1'      ID='TREE_NM1'  	Width=100  	align=left suppress=3 edit=none</C>
			            <C> name='메뉴명2'      ID='TREE_NM2'  	Width=100  	align=left suppress=4 edit=none</C>
			            <C> name='메뉴명3'      ID='TREE_NM3'  	Width=100  	align=left suppress=5 edit=none</C>
			            <C> name='메뉴명4'      ID='TREE_NM4'  	Width=150  	align=left edit=none</C>
			        ">
			    </object>
			</td>
		  </tr>
		  <tr>
			<td>※ 퇴사자도 메뉴 권한 확인을 위해 조회됩니다.</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
	</tr>

</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

