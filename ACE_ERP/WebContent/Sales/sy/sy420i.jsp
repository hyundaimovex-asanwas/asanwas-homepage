<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 영업부서 등록
 * 프로그램ID 	 : SY420I
 * J  S  P		 : sy420i
 * 서 블 릿		 : Sy420I
 * 작 성 자		 : 남기표
 * 작 성 일		 : 2006-07-28
 * 기능정의		 : 영업부서 등록 (조회,등록,수정 ,삭제)
 * 수정내용		 :
 * 수 정 자		 : 
 * 최종수정일자        : 
 * TODO			 :
 * TODO			 :
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드

	// ContextPath
	String dirPath = request.getContextPath(); //HDASan

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
       
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩
// Parameter 	:
%>
		var v_job = "H";
   		var div='';
		
		function fnOnLoad(){
			fnInit();
			ds2.deleterow(1);
		}
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+ "DEPT_SID:INT,"
				+ "DEPT_CD:STRING,"
				+ "DEPT_NM:STRING,"
				+ "PRT_SEQ:STRING,"
				+ "PARENT_DEPT_SID:INT,"
				+ "PARENT_DEPT_CD:STRING,"
				ds1.SetDataHeader(s_temp);
			}
		}		

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 선조회
// Parameter 	:
%>
	function fnInit(){
	cfStyleGrid(getObjectFirst("gr1"), "comn");
         jobFlag = "INIT";
         	fnSetHeaderDs1();
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_SY%>Sy420I",
            	"JSP(O:USEYN=codeDs1,O:S_USEYN=ds2)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	:
%>
    function fnSelect() {
       window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
            + ",sDept_cd="  + sDept_cd.value+ ",sDept_nm=" + sDept_nm.value
            + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
            
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy420I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
    function fnAddRow1() {
    	ds1.addrow();
    }
    function fnApply() {
		if (ds1.IsUpdated ) {
	        v_job = "I";	
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	         document.all.LowerFrame.style.visibility="visible";
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_SY%>Sy420I",
	             "JSP(I:DS1=ds1)",
	             param);
	         tr_post(tr1);
         }
	}
    function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 (사용안함)
%>
    function fnExcel() {
        if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:방북교육 대상자명단; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("방북교육 대상자명단", "방북교육 대상자명단.xls", 8);
    }
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    

		</script>	    
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        document.all.LowerFrame.style.visibility="hidden";
        if(v_job=="I") {
            window.status = "생성이 완료 되었습니다.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "작업이 실패하였습니다.";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert(row + " 검색된 데이타가 없습니다."); 
    }
     var flag = false;
        if(colid='use_yn'){
            for(var i=1; i<=ds2.CountRow; i++){
                if(ds2.NameValue(i, "detail")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "use_yn") = ds2.NameValue(i, "detail_nm");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "use_yn") = "";
        }
        
</script>
		<script language=JavaScript for=ds1 event=OnColumnChanged(row,colid)>
       
	</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") { sEducPlanDt.value=ds1.namevalue(row,"educ_plan_dt"); return; }
    if( row < 1){
        alert(row + " 검색된 데이타가 없습니다."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds21 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>

<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->
<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="845" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="490">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td width="80px" height="30px" class="text">영업부서코드</td>
                               <td align="center" bgcolor="#ffffff">&nbsp;
									<input type="text" name="sDept_cd" size="10" maxlength="5" class="textbox" align=absmiddle></td>
            					<td width="70px" height="30px" class="text">영업부서명</td>
                                <td align="center" bgcolor="#ffffff">&nbsp;
									<input type="text" name="sDept_nm" size="15" maxlength="20" class="textbox"></td>
								<td width="60px" height="30px" align=left class="text">&nbsp;사용유무</td>                                                                                                                                                                                                                                                                                                                                         
                                <td align=center bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>                                                                                                                                                                                                   
		                            <object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=80 width=50 border="0" align=absmiddle>                                                                                                                                          
										<param name=ComboDataID		value=codeDs1>                                                                                                                                                                      
										<param name=BindColumn      value="head">                                                                                                                                                              
                                        <param name=BindColVal      value="head">                                                                                                                                                                                                                      
										<param name=EditExprFormat	value="%,%;head,detail_nm">                                                                                                                                         
										<param name=ListExprFormat  value="detail_nm^0^50"></object>                                                                                                                                                
									<%=HDConstant.COMMENT_END%>
								</td>	                                                        
            				</tr>
            			</table>
            		</td>
            		<td align="right" width="365" valign="bottom">
            			<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRow1()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs1()" >																						
						<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">																				
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
            		</td>
            	</tr>
            	<tr>
            		<td height="10"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:440px" border="1">
                            			<param name="DataID"			value="ds1">
										<param name="ColSizing"			value="true">
										<param name="Fillarea"			value="false">
										<param name="Editable"  		value="true">
										<param name="BorderStyle"       value="0">
										<param name=SortView  			value="Left">
										<param name="SuppressOption"    value="1">
										 <param name="Format"            value="
										
										         <C> name='DEPT_SID'     			ID='dept_sid'    			align=left editlimit=12 show=true</C>
										         <C> name='영업부서코드'      			ID='dept_cd'     			align=left editlimit=5 show=true</C>
										         <C> name='영업부서명'      			ID='dept_nm'     			align=left editlimit=20 show=true</C>
										         <C> name='출력순서'      			ID='prt_seq'     			align=left editlimit=5 show=true</C>
										         <C> name='PARENT_DEPT_SID'      	ID='parent_dept_sid'     	align=left editlimit=12 show=true</C>
										         <C> name='상위영업부코드'		       	ID='parent_dept_cd'      	align=left editlimit=5 show=true</C>
										         <C> name='상위영업부명'		       	ID='dept_nm'      			align=left editlimit=5 show=true</C>
										         <C> name='사용유무'		       		ID='use_yn'			      	align=left editlimit=5 show=true editstyle=lookup data='ds2:detail:detail_nm'</C>
										 
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
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->
<jsp:include page="/Sales/common/include/body_e.jsp"/>