<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 가수금 사용내역
 * 프로그램ID 	: AC061S
 * J  S  P		: ac061s
 * 서 블 릿		: Ac061S
 * 작 성 자		: 심동현
 * 작 성 일		: 2008-11-29
 * [ 수정일자 ][수정자] 내용
 * [2008-11-29][심동현] 새 메뉴 제작
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
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
		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		} 
		 
		function fnInit() {
			// 지역
			div = 'init';
            codeDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC001&s_item1=Y";
            codeDs3.Reset();
            

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS=codeDs1,O:S_GOODS_DS=codeDs2)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		
				
		// 메인 조회
		function fnSelect() {
			
			if(sPAY_MANAGE_NO.Text==""){
				alert('결제관리번호를 입력해주세요');
				return;
			}
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sPAY_MANAGE_NO="+ sPAY_MANAGE_NO.Text;
                      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac061S",
			    "JSP(O:DS1=ds1)",
			    param);
			tr_post(tr1);
		}
			
		/*
		 * 엑셀
		 */
		function fnExcel() {
			if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
            
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:가수금 사용내역; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("가수금 사용내역","가수금 사용내역.xls", 32);
		}
    	
		// 검색조건 대리점  팝업 
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

   

   
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>	<%//메인 %>
	<param name="SyncLoad" 	value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
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
					<tr height='25'>
						<td class="text" width="100">결제관리번호</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=sPAY_MANAGE_NO classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;">
	                            <param name=Format      value="000000-0000">
	                            <param name=Alignment   value=1>
	                            <param name=ClipMode    value=true>
	                            <param name=Border      value=false>
	                            <param name=Enable      value=true>
	                            <param name=SelectAll   value=true>
	                            <param name=SelectAllOnClick      value=true>
	                            <param name=SelectAllOnClickAny   value=false>								
							</object>
							<%=HDConstant.COMMENT_END%>																				
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
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >

	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name="SuppressOption"    value="1">
										<param name="ViewSummary"    value="1">
										<param name="Format" 			value="
											<C> name='결제관리번호'		ID='PAY_MANAGE_NO'  width=80   	align=center editlimit=50 show=true  mask='XXXXXX-XXXX' sumtext='총' Suppress='1'</C>
											<C> name='출발일자'			ID='DEPART_DATE'  	width=80   	align=center editlimit=50 show=true  mask='XXXX-XX-XX' sumtext=@cnt Suppress='2'</C>
											<C> name='상품명'			ID='GOODS_NM' 		width=100   align=center editlimit=50 show=true sumtext='건' Suppress='3'</C>
											<C> name='신청서번호'		ID='ACCEPT_NO'  	width=110   align=center editlimit=50 show=true mask='XXXXX-XXXXXX-XXX'</C>
											<C> name='고객명'			ID='CUST_NM'  		width=80   	align=center editlimit=50 show=true</C>		
											<C> name='생년월일'			ID='BIRTHDAY'  		width=60  	align=center editlimit=50 show=true </C>		
											<C> name='금액'				ID='PAY_AMT'  		width=70  	align=right editlimit=50 show=true decao=0 sumtext=@sum</C>
											<C> name='회계구분'			ID='ACCT_GUBN_NM'	width=60  	align=center editlimit=50 show=true</C>
											<C> name='결제코드'			ID='PAY_CD_NM'  	width=60  	align=center editlimit=50 show=true</C>
											<C> name='일시'				ID='U_DATE'  		width=115  	align=left editlimit=50 show=true dec=0</C>
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
			<td><br>　※ 1개 결제건에 대한 가수금 사용내역이며, 일시 > 신청서번호 > 고객명 순서입니다.<br>
				　※ 정상적인 가수금은 <font color=red>금액의 합계 = 0</font> 이 되어야 합니다.<br>
			</td>
		</tr>
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

