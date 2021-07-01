<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	     : 전산자산현황
 * 프로그램ID 	 : AM300S
 * J  S  P		     : AM300S
 * 서 블 릿		 : AM300S
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2012-04-05
 * 기능정의		 : 전산자산현황
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var div='';
	// 페이지로딩
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
	//선조회
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
	}
	//메인조회
	function fnSelect() {
		    v_job = "S";
	         msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + " sEMPNO=" 		+ sEMPNO.value
	            + ",sEMPNMK=" 	+ sEMPNMK.value;
	           // alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am300S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
   }
	function fnExcel() {
		    getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("전산자산사용현황","전산자산사용현황.xls", 8);
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
<%
	// 작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
	</script>
<%
		// 작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";     
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
		<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer"  onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer"  onClick="fnExcel();">
											</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                        	<tr bgcolor="#6f7f8d">
		            						<td align="center" width="100px" class="text">사 번</td>
											<td align=center bgcolor="#ffffff" colspan="3">&nbsp;																		
												<input id="sEMPNO" type="text" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();" style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
											</td>
			            					<td align="center" width="100px" class="text">성 명</td>
			                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																		
												<input id="sEMPNMK" type="text" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();" style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
											</td>
			            				</tr>	
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="30px">
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption	value=1>								                                        
										<param name="Format" 		value="
										   <C> name='교체\\순위' 				ID='RANK'	   			width=30 		align=CENTER	edit=none show=TRUE	bgColor='pink'</C>
						                   <C> name='교체\\점수'       ID='SCORE'    Width=60 	align=right show=true sort=true bgColor=<%=HDConstant.GRID_ITEM%></C>
							               <C> name='취득일자\\(기기)'       ID='DATE_A'    Width=80 	align=center show=true sort=true</C>
							               <G> name='인사정보'
							                <C> name='부서'       ID='DEPTCD'    Width=150 	align=left show=true sort=true</C>
							                <C> name='직위'       ID='PAYGRD'    Width=60 	align=center show=true</C>
							                <C> name='사번'       ID='EMPNO'    Width=60 	align=center show=true sort=true</C>
							                <C> name='성명'       ID='EMPNMK'    Width=60 	align=center show=true sort=true	bgColor=<%=HDConstant.GRID_ITEM%></C>
							               </G>
						                   <G> name='하드웨어'
							                <C> name='품목'       ID='ITEM_NM'    Width=60 	align=left show=true sort=true bgColor=<%=HDConstant.GRID_ITEM%></C>
							                <C> name='제조사'       ID='MADE_CP'    Width=60 	align=center show=true </C>
							                <C> name='모델명'       ID='MODEL_NM'    Width=40 	align=center show=true</C>
							                <C> name='CPU'       ID='CPU'    Width=40 	align=center show=true </C>
							                <C> name='보드'       ID='MAINBD'    Width=40 	align=center show=true</C>
							                <C> name='메모리'       ID='MEMORY'    Width=40 	align=center show=true</C>
							                <C> name='HDD'       ID='HDD'    Width=40 	align=center show=true </C>
							                <C> name='그래픽'       ID='GRAPHIC'    Width=40 	align=center show=true </C>
							               </G>
							                <C> name='반납일자'       ID='DATE_B'    Width=80 	align=center show=false sort=true</C>
							                <C> name='폐기일자'       ID='DATE_C'    Width=80 	align=center show=false sort=true</C>
							                <C> name='지급일자\\(사용자)'       ID='DATE_D'    Width=80 	align=center show=false sort=true</C>
							                <C> name='상태구분'       ID='STATUS_CD'    Width=80 	align=center show=false sort=true</C>

							                <C> name='자산번호'       ID='ASSET_NO'    Width=80 	align=center show=false sort=true</C>
							                <C> name='비고'       ID='REMARKS'    Width=80 	align=left show=false</C>
							            ">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			**<b>교체점수 산정기준</b><br><br>
			&nbsp;&nbsp;&nbsp;1.교체기준시기: 4년<br><br>
			&nbsp;&nbsp;&nbsp;2.수식:[금일]-[취득일자]-4년<br><br>
			&nbsp;&nbsp;&nbsp;3.교체점수가 <b>클 수록 교체우선순위 높음.</b>
			
		</td>
	</tr>
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

