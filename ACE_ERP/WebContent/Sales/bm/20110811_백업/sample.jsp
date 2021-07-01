<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	     : 프로그램 정보
 * 프로그램ID 	 : CM030I
 * J  S  P		 : cm030I
 * 서 블 릿		 : CM030I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2007-07-20
 * 기능정의		 : ERP시스템 메뉴 정보
 *				      레벨별 조회, 수정, 삭제, 추가
 * [수  정   일  자][수정자] 내용
 * [2007-09-07][심동현] 템플릿용으로 쓰기 위한  주석 처리 및 소스 정리
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>


<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>
	<script language="javascript">
	/*
	 * 페이지로딩
	 */
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			fnInit(); //초기화 함수
		}

	/*	 * 데이타셋 헤더 설정	 */
	function fnSetHeader(){


	}

	/*
	 * 선조회
	 */
	function fnInit(){
		//*****  페이지 초기화 함수는 여기에..  ********
        cfStyleGrid(getObjectFirst("gr1"), "comn");	//그리드에 스타일 적용하는 부분. 1줄="comn";2줄="comn1"
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //브라우저 상태창 수정.
//        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
//        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
//        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
//        window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {


    }
    </script>
<%
/*=============================================================================
				Developer Java Script 끝
=============================================================================*/
%>
    
    
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/


/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공-TR1
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">

		</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/



/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>


</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border=0 cellpadding="0" cellspacing="0" width="100%" bordercolor=orange>
  <tr>
	<td>
		<table border=0 width=845 cellpadding=0 cellspacing=0>
		  <tr height="50px">
			<td align="left" ><!-- 버튼 영역-->
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td align="right">
							<table border="0"  cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="right" height="30px">		
										<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRow1()" >
										<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRow1()" >																																										
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
						 			</td>
							</tr>																		
							</table>
						</td>
					</tr>															
				</table>	
			</td>											
		  </tr>
		
		  <tr height="30px">
			<td align="left" ><!-- 검색조건 영역-->
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td  width="845px">
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	                            <tr bgcolor="#6f7f8d">
	            					<td align=left class="text" width=70>&nbsp;메뉴레벨</td>
	                                <td align=left bgcolor="#ffffff">&nbsp;																										
										<SELECT NAME=menu_level style="width:120px;align:center;">
											<OPTION value=1>　　1 레벨</OPTION>
											<OPTION value=2>　　2 레벨</OPTION>
											<OPTION value=3>　　3 레벨</OPTION>
										</SELECT>
									</td>
	            				</tr>
	            			</table>
						</td>
					</tr>															
				</table>	
			</td>											
		  </tr>
		  <tr height="10">
			<td></td>
		  </tr>		
		  <tr>
			<td width="845px"><!-- 그리드 영역-->
				
				<table  border="0" cellpadding="0" cellspacing="0">
					<tr valign="top"">
						<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                    			<param name="DataID"		VALUE="ds1">
                    			<param name="BorderStyle"   VALUE="0">
                    			<param name=ColSizing       value="true">
                    			<param name="editable"      value="true">
                    			<param name=UsingOneClick  	value="1">
                                <Param Name="AllShowEdit"   value="True">
                                <param name="SortView"      value="Right">
                                <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								 	<C> name='No.'        	ID='{STRING(CURROW)}'   Width=30    align=center</C>
								 	<C> name='IDX'	    	ID='MENU_IDX'	width=60  	align=center editlimit=5 show=true edit=none </C>
									<C> name='메뉴레벨'      	ID='LEVEL'     	width=60	align=center editlimit=5 show=TRUE edit=none </C>
									<C> name='상위메뉴명'		ID='PARENT_IDX'	width=120  	align=LEFT show=true editstyle=lookup data='ds_menu:menu_idx:scdnm' show=true </C>
									<C> name='메뉴명'   	 	ID='SCDNM'     	width=140	align=left editlimit=5 show=true </C>
									<C> name='순서'      	ID='SEQ'   		width=60	align=center editlimit=5 show=true</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
