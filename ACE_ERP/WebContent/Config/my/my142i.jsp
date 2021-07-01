<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 개인별 erp 메뉴 권한 조회
 * 프로그램ID  	: SY142I
 * J  S  P   	: Sy142i
 * 서 블 릿     : Sy142I
 * 작 성 자     : 박경국
 * 작 성 일     : 2008-09-28
 * 기능정의     : 개인별 erp 메뉴 권한 조회
 * [ 수정일자 ][수정자] 내용
 * [2013-10-23][심동현] 재구성-실행 이전
 * [2013-11-13][심동현] config는 공통코드 sales를 불러온다. 
 * [2013-11-13][심동현] 사번, 성명에 로그인 사용자 고정값 처리, 로딩시 조회
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
        fnSelect();
   }

   
   /*
    * 메인조회
    */
    function fnSelect() {
	   
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

	
	
	/* 적용 */
	function fnApply() {
		
		if (ds1.IsUpdated ) {
			
	        v_job = "I";	
	        
	         msgTxt.innerHTML="저장 중입니다. 잠시만 기다려 주십시오.";
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";

	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_MY%>My142I",
	            "JSP(I:DS1=ds1)",
	            param);
	        
	         tr_post(tr1);
	         
         }
	}
	
	/* 취소	 */
	function fnCancel() {
		
		if (ds1.IsUpdated ) {
			
			ds1.undoall();
			
			msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";	
	
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
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">

    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
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
					    <img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" onClick="fnApply();">
						<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer"	onClick="fnExcelDs1()">		<!-- 엑셀 -->
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"  onclick="fnCancel()">					    
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
                  <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
                    <object id=v_empno classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                        <param name=Format      			value="0000000">
                        <param name=Alignment   			value=1>
                        <param name=ClipMode    			value=true>
                        <param name=Border      			value=false>
                        <param name=SelectAll   			value=true>
                        <param name=SelectAllOnClick      	value=true>
                        <param name=SelectAllOnClickAny   	value=false>
                        <param name=Text        			value="<%=(String)session.getAttribute("vusrid")%>">
                        <param name=ReadOnly				value=true>
                    </object>
                    
                  </td>
				 	<td align=left class="text" width="70px">성명</td>
			        <td align=left bgcolor="#ffffff" >&nbsp;
			        	<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox" value="<%=(String)session.getAttribute("vusrnm")%>" readonly="readonly">
			       	</td>
			      </tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>		  
		  <tr>
			<td width="1000px">
				<table  border="0" cellpadding="0" cellspacing="0" >
				  <tr valign="top"">
					<td width=1000>
					    <%=HDConstant.COMMENT_START%>
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
					            <C> name='부서'      	ID='DEPTNM'    	Width=100  align=center suppress=1 edit=none SumText='총'</C>
					            <C> name='성명'      	ID='EMPNMK'    	Width=100  align=center suppress=2 edit=none SumText=@count</C>
					            <C> name='사번'      	ID='EMPNO'   	Width=60  align=center suppress=2 edit=none SumText='개'</C>
					            <C> name='메뉴ID'       ID='TREE_ID'   	Width=80  align=left  edit=none </C>
					            <C> name='메뉴번호'     ID='TREE_IDX'  	Width=80  align=center  edit=none</C>
					            <C> name='메뉴명1'      ID='TREE_NM1'  	Width=80  align=center suppress=3 edit=none</C>
					            <C> name='메뉴명2'      ID='TREE_NM2'  	Width=80  align=left suppress=4 edit=none</C>
					            <C> name='메뉴명3'      ID='TREE_NM3'  	Width=100  align=left suppress=5 edit=none</C>
					            <C> name='메뉴명4'      ID='TREE_NM4'  	Width=200  align=left edit=none</C>
								<C> name='즐겨찾기'    	ID='FAV_YN'     width=60  align=center editstyle=checkbox editlimit=1 show=true Sort=True</C>					            
					        ">
					    </object>
					    <%=HDConstant.COMMENT_END%>
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
	</tr>

</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

