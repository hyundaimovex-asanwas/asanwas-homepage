<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		:
 * 프로그램ID 	:
 * J  S  P		:
 * 서 블 릿		:
 * 작 성 자		:
 * 작 성 일		:
 * 기능정의		:
 * 수정내용		: 
 * 수 정 자		:
 * 최종수정일자 :
 *****************************************************************************/
%>


<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD 정보 -->
	<jsp:include page="/Sales/common/include/head.jsp"/>

<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
		
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(){
			//fnInit(); 
		}

		/*
		 * 데이타셋 헤더 설정
		 */
		function fnSetHeaderDsInit(){
			
			if (initds1.countrow < 1){
				var s_temp1 = "head:STRING,detail:STRING,detail_nm:STRING";
				ds1.SetDataHeader(s_temp1);
			}
							
		}	
			
		/*
		 * 초기작업
		 */
		function fnInit(){
		    ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I?proType=INIT&dsType=1";
			ds1.Reset();	
		}

			
		/*
		 * 메인 조횐
		 */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/*
		 * 데이터셋 첫번째 조회
		 */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I?proType=S&dsType=1&sClientSid="+sClientSid.value
																					+"&sCustGu=" + searchds1.namevalue(searchds2.rowposition, "detail")
																					+"&sCountryGu=" + searchds2.namevalue(searchds2.rowposition, "detail")
																					+"&sCustNm=" + sCustNm.value
																					+"&sManegeNo=" + sManegeNo.value;
																				
			ds1.Reset();			
		}
			
		/*
		 * 행추가 , 신규 
		 */
		function fnAddRowDs1() {
			ds1.addrow();
		}
			
		/*
		 * 행삭제, 삭제
		 */
		function fnDeleteRow() {
			ds1.deleterow(ds1.rowposition);
		}
			
		/*
		 * 저장
		 */
		function fnApply() {
			var row1=ds1.countrow;
				
			if (ds1.IsUpdated) {
				tr1.KeyValue = "Cu010I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Cu010I?proType=A&dsNum=1";
																	
				tr1.post();
				fnSelect(); // 입력후 조회 
			}		
		}
			
		/*
		 * 취소 
		 */
		function fnCancelDs1() {
			ds1.undoall();
			window. status="데이터 변경이 취소되었습니다.";
			return;		
		}
			
			
		/*
		 * 프린트
		 */
		function fnPrintDs1() {
		}
			
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			gr1.runexcel("메인 메뉴 등록");
		}
			
		/*
		 * 팝업
		 */
		function fnPopup() {
			
		}
			
		/*
		 * 입력 체크
		 */
		function fnCheck() {
		}
		
			
		
		
	
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>

	

		
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>
	</head>
	

<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											 - 
										</td>
									</tr>
								</table>						
<!--------------------------------- 코딩 부분 끝 -------------------------------->								
<%
/*******************************************************************************
			Bind 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                     <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
                     
              ">
      </object>
<%=HDConstant.COMMENT_END%>      

<jsp:include page="/Sales/common/include/body_e.jsp"/>