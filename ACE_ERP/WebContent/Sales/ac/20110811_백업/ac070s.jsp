<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 입금형태별 입금현황
 * 프로그램ID 	: AC070S
 * J  S  P		: ac070s
 * 서 블 릿		: Ac070S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-03
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
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
		 var div='';
         var v_default_row = 1;
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			sSDate.Text = '<%=firstday%>';	
			sEDate.Text = '<%=firstday%>';	
			fnInit();
		} 
		 
		function fnInit() {
			// 지역
			div = 'init';
	       
		}
		
				
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
                      + ",sJobSel=" + sJobSel.value;
                      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac070S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		/*
		 * 서브 조회
		 */
		function fnSubSelect() {
            ds2.ClearAll();
            
            v_default_row = ds1.rowposition;
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sPayManageNo="+ ds1.namevalue(ds1.rowposition, "pay_manage_no");
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac070S",
			    "JSP(O:DS2=ds2)",
			    param);
			   
			tr_post(tr2);
		}		
			
		/*
		 * 엑셀
		 */
		function fnExcel() {
			if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
            getObjectFirst("gr2").SetExcelTitle(0, "");
            getObjectFirst("gr2").SetExcelTitle(1, "value:가상계좌입금조회(상세); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr2").GridToExcel("가상계좌입금조회(상세)","가상계좌입금조회.xls", 32);
            
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:가상계좌입금조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("가상계좌입금조회","가상계좌입금조회.xls", 32);
		}
    	
		/**
	     * 검색조건 대리점  팝업 
	     */
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
	    }   
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="onsuccess()">
        window.status="작업이 성공적으로 완료되었습니다.";
    </script>   

    <script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
    </script>

    <script language="javascript" for="tr2" event="onsuccess()">
        window.status="작업이 성공적으로 완료되었습니다.";
    </script>   

    <script language="javascript" for="tr2" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
        var error_cnt = tr2.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
    </script>

    <script language=javascript for=ds1 event="OnLoadCompleted(Row)">
        if(Row==0){
            ds2.ClearAll();
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
            return;
        }
        
        fnSubSelect();
    </script>

    <script language=javascript for=gr1 event="OnClick(Row,Colid)">
        if(Row==0) return;
        if(v_default_row==Row) return;
        
        fnSubSelect();
    </script>
    
    <script language=javascript for=gr1 event="OnKeyPress(kcode)">
        if(ds1.CountRow==0) return;
        if(kcode==38 || kcode==40)
            fnSubSelect();
    </script>
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 상세  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px' align=right>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
				<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- 엑셀 -->
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
                    <tr height=25>
						<td class="text"  width="60">입금일자</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
							</object>~
	                       	<object id=sEDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">	
								<param name=SelectAllOnClickAny   value="false">
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						
						 <td align=left class="text" width='100'>차액발생</td>
                         <td align=left bgcolor="#ffffff" valign="middle" colspan=5>&nbsp;
                                <select name="sJobSel" id="v_out_gubn" class="textbox">
                                    <option value="N">전체</option>
                                    <option value="Y">차액발생건만 적용</option>
                                </select>&nbsp;
								
                        </td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='435px' height='380px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name=ViewSummary     value=1>								 
								<param name="Format" 			value="
									<C> name='입금일'   		ID='pay_date'  		width=80 	align=center editlimit=61 show=true   suppress=1 sumtext='합계'</C>
                                    <C> name='입금은행'     	ID='bank_nm'        width=115   align=left editlimit=61 show=true suppress=2 sumtext=@cnt</C>
                                    <C> name='계좌번호'     	ID='bank_acct'      width=100   align=center editlimit=61 show=true suppress=3 sumtext='건'</C>
									<C> name='입금자'   		ID='u_empno'  		width=60 	align=center editlimit=61 show=true suppress=4 </C>
									<C> name='입금예정액'   	ID='pay_amt'  		width=80 	align=right editlimit=61 show=true  decao=0 sumtext=@sum</C>
									<C> name='입금액'   		ID='agree_amt'  		width=80 	align=right editlimit=61 show=true  decao=0 sumtext=@sum</C>
									<C> name='차액'   		ID='c_pay_amt'  	width=80 	align=right editlimit=61 show=true  decao=0 sumtext=@sum</C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
						<td width="15px">
						</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='387px' height='380px' border='1'>
								<param name="DataID"		value="ds2">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name=ViewSummary     value=1>
								<param name="Format" 			value="
									<C> name='출발일자'   	ID='depart_date'  			width=80 	align=center suppress=1 mask='XXXX-XX-XX' SumText='합계'</C>
									<C> name='상품'   		ID='goods_nm'  			width=100 	align=left suppress=2</C>
									<C> name='신청서번호'   		ID='accept_no'  		width=100 	align=left suppress=3</C>
									<C> name='성명'   		ID='cust_nm'  			width=80 	align=right </C>
                                    <C> name='입금액'          ID='pay_amt'          width=80   align=right	SumText=@sum SumTextAlign=right dec=0</C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

