<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사>현장관리>작업관리>작업 등록
 * 프로그램ID 	 : PMS/SI110I
 * J  S  P		 : si110i.jsp
 * 서 블 릿		 : Si110I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2014-03-27
 * [ 수정일자 ][수정자] 내용
 * [2014-04-10][심동현] 신규 개발 
 *						디테일1 외주 낙찰 회사 불러오기 (향후 계약회사 불러오기로 바꿔야겠지?)

 *****************************************************************************/
%>
<%@ page import="pms.common.HDConstant"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <title>외주 협력사 조회</title>
        <jsp:include page="/Pms/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                ds_gc_bpjob.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI006&s_item1=Y";
                ds_gc_bpjob.Reset();	//투입인원 직종 SI006 

                
                var strParam = new Array();
				strParam=window.dialogArguments;
				s_site_sid.value = strParam[0];
				s_site_nm.value = strParam[1];
				
				fnSelect();
            }
            
            function fnSelect() {
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Si110H_01?proType=S&dsType=1&v_site_sid=" + s_site_sid.value ;
                ds1.Reset();
            }
            
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "bp_sid") + ";" +
                                     ds1.namevalue(row, "bp_nm") + ";" +
                                     ds1.namevalue(row, "bid_site_kind") + ";" +
                                     ds1.namevalue(row, "bid_sid") + ";" +
                                     ds1.namevalue(row, "bp_job");
                fnClose();
            }
            
            function fnClose() {
                window.close();
            }
        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>

	<%// Description  :  그리드 더블클릭 이벤트 발생%>          
    <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
        fnAdd();
    </script>
	<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
           if (keycode == 13) {
           	fnAdd();
           }
	</script>
       

	<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="false">
	</object>
	<object id=ds_gc_bpjob	classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- general code-->
	    <param name="SyncLoad"  value="false"/>
	</object>	

	</head> 
    
	<!--  BODY START -->
	<body cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:5px;">
	  <tr height="30px">
		<td align="right" colspan="2">
			<img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;top:0px;cursor:pointer;" onClick="fnAdd()">                            
			<img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;top:0px;cursor:pointer;" onClick="fnClose()">                          
		</td>
	  </tr>
	  <tr>
		<td class="text" width="100px" height="30" style="border:1 solid #708090">현장명</td>
		<td width="458px" style="border:1 solid #708090;border-left-width:0px">&nbsp;&nbsp;
			<input type="hidden" name="s_site_sid" >
			<input type="text" class="hidden" name="s_site_nm" style="width:95%;" readonly="readonly">        
	    </td>
	  </tr>
	</table>

    <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
      <tr>
      	<td>
			<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='559px' height='248px' border='1'>
				<param name="DataID"        value="ds1">
				<param name="BorderStyle"   value="0"> 
				<param name="ColSizing"     value="true">
				<param name="AutoResizing"  value=true> 
				<param name="Editable"      value="true">
				<param name="ViewSummary"	value="1">
				<param name="Format"        value="
					<c> Name='입찰일자'   ID='BID_DAY'     	Width=100  	align=center sumtext=@count SumTextAlign=right edit=none </c>
					<c> Name='협력사명'   ID='BP_NM'		Width=200   align=left sumtext='건' SumTextAlign=left edit=none</c>
					<c> Name='입찰공종'   ID='BID_KIND'		Width=150   align=left edit=none </c>
					<C> name='직종'		ID='BP_JOB'  		width=80 	align=CENTER editstyle=lookup Data='ds_gc_bpjob:detail:detail_nm'</C>
				">
			</object>
                </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>