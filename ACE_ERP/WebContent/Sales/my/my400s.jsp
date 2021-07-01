<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재상세 : 미결함-서비스 요청서 결재상세 조회
 * 프로그램ID 	: my400i
 * J  S  P		: my400i
 * 서 블 릿		: My400I
 * 작 성 자		: 심동현
 * 작 성 일		: 2010-08-20
 * [ 수정일자 ][수정자] 내용
 * [2010-08-30][심동현] 결재부분 + 상세부분(마스터+디테일)
 *						모듈화로 확 갈라버릴 것인지 아니면 적절히 합칠 것인지..
 * [2010-09-08][심동현] help/my400h 복사해서 조회페이지로 사용. 방향을 결정 못했음
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid = HDUtil.nullCheckNum(request.getParameter("ap_m_sid"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>전자결재 - 서비스 요청 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">
		
			// 페이지 로딩
			function fnOnLoad(tree_idx){
				fnInit_tree(tree_idx);	//트리초기화 호출
				
		        cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		        cfStyleGrid(getObjectFirst("gr_apline"), "comn");
				fnSelect();
				
/*				var strParam = new Array();
				strParam=window.dialogArguments;
			
				if(strParam[0]!=null) { //room 코드 조건
					txt_room_type_cd.value=strParam[0];
				}else {
				}
				if(strParam[1]!=null) { //room 이름 조건
					txt_room_type_nm.value=strParam[1];
				}else {
				}
				if(strParam[2]!=null) { //영업장 조건
					upjangsid.value=strParam[2];
				}else {
				}*/
			}

		// 메인 조회
		function fnSelect() {
				
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",dsType=1"
			          + ",s_ap_m_sid=<%=v_ap_m_sid%>"
			          + ",s_ap_gu=1"; //
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_HELP%>My400H",
	             "JSP(O:AP_MASTER_DS=ds_ap_master,O:AP_DETAIL_DS=ds_ap_detail,O:AP_LINE_DS=ds_ap_line)",
	             param);
	         tr_post(tr1);
		}
			
		function fnAdd() {
			var row = ds1.rowposition;
		
			window.returnValue = ds1.namevalue(row, "room_type_sid") + ";" +
							 	 ds1.namevalue(row, "room_type_cd") + ";" + 
							 	 ds1.namevalue(row, "room_type_nm") + ";" +
							 	 ds1.namevalue(row, "upjang_sid") + ";" +
							 	 ds1.namevalue(row, "upjang_nm") + ";" +
							 	 ds1.namevalue(row, "std_persons");								 	 
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			fnHideLoading();
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";

			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  그리드 더블클릭 이벤트 발생
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "room_type_sid") + ";" +
								 ds1.namevalue(row, "room_type_cd") + ";" + 
								 ds1.namevalue(row, "room_type_nm") + ";" +
							 	 ds1.namevalue(row, "upjang_sid") + ";" +
							 	 ds1.namevalue(row, "upjang_nm") + ";" +
							 	 ds1.namevalue(row, "std_persons");		
			window.close();
		</script>
		
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
            if (keycode == 13) {
            	fnAdd();
            }
		</script>	
<!-----------------------------------------------------------------------------
	DataSet Components 선언 
	# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%>
<object id="ds_ap_master" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>
<object id="ds_ap_detail" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>
<object id="ds_ap_line" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>
<object id="ds2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>	
<%=HDConstant.COMMENT_END%>



</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width='845'>	
	<tr>
		<td width='845px'>

			<table border="0" cellpadding="0" cellspacing="0" width=700 align=center>
			  <tr>
				<td><img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">
				    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
				</td>
			  </tr>
			</table>

			
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">기본사항</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700>

		<table width="700px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">관리번호</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="req_no" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업상태</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="status_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청일시</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="accept_datetime" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">대리점담당자</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="client_dam_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">연락처</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="mobile_no" type="text" class="textbox2"  style="height:19px" size="18" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">대리점명</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="client_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">출발일시</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="depart_datetime" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">신청서번호</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="accept_no" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">상품명</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="goods_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>

			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">성명</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="cust_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">주민/여권번호</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="manage_no" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">직장</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="company_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>

			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">요청의견</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;<input id="reason" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">접수의견</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;<input id="desc" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>

		</table>

	
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">세부항목</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='200px' border='1'>
		<param name="DataID"            value="ds_ap_detail">
		<param name="ColSizing"         value="true">
		<param name="Editable"          value="false">
		<param name="SuppressOption"    value="1">
		<param name="BorderStyle"       value="0">
		<param name=UsingOneClick       value="1">
		<Param Name="AllShowEdit"       value="True">
		<param name="ViewSummary"       value="1">
		<param name="Format"            value="
			<C> name='RSV_SID'		ID='RSV_SID'       	width=40 align=right Edit=None DEC=0 show=false</C>
			<C> name='이용일자'  	ID='USE_DATE'     	width=70 align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX suppress=1</C>
			<C> name='영업장'     	ID='UPJANG_NM'      width=70 align=left   suppress=2</C>
			<C> name='항목'       	ID='MENU_NM'   		width=120 align=left  suppress=3 SumText='총　계'</C>
			<C> name='회차' 		ID='USE_SEQ'      	width=40 align=center dec=0 suppress=4</C>
			<C> name='단가'     	ID='UNIT_AMT'       width=40 align=right dec=0</C>
			<C> name='통화'    		ID='CURRENCY_CD'  	width=40 align=center </C>
			<C> name='환율'	      	ID='EXCH_AMT'       width=40 align=center DEC=0</C>
			<C> name='수량'       	ID='SALE_QTY'       width=40 align=right DEC=0</C>
			<C> name='합계(￦)' 	ID='SUM_AMT'   		width=70 align=right decao=0 Sumtext=@sum</C>
			<C> name='기재사항'   	ID='REMARKS'        width=150 align=left </C>
		">
		</object>
		<%=HDConstant.COMMENT_END%>

	</td>
  </tr>
</table>


<!-- 결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">결재선</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='100px' border='1'>
			<param name="DataID"		value="ds_ap_line">
			<param name="ColSizing"		value="true">
			<param name="Fillarea"		value="false">
			<param name="Editable"		value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
              <C> name='결재SID'    ID='ap_m_sid'   	width=80	align=left editlimit=5 show=FALSE edit=none</C>
			  <C> name='구분'     	ID='ap_type_nm'		width=60	align=center editlimit=50 show=true edit=none</C>
              <C> name='결재자'    	ID='empnmk'		   	width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='직위'		ID='paygrd'   		width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='부서'    	ID='deptnm'		   	width=90 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID='ap_status_d_nm'	width=70 	align=center editlimit=30 show=true edit=none</C>
              <C> name='의견'	    ID='ap_desc'   		width=189	align=center editlimit=14 show=true edit=none</C>
              <C> name='결재일시'	ID='u_date'			width=120 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>




	</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
		<param name="DataId" value="ds_ap_master">           
		<param name=BindInfo	value="                                                
        <C>Col=req_no           		Ctrl=req_no             	Param=value </C>
        <C>Col=status_nm	       		Ctrl=status_nm          	Param=value </C>    
        <C>Col=accept_datetime     		Ctrl=accept_datetime       	Param=value </C>
        <C>Col=client_dam_nm       		Ctrl=client_dam_nm         	Param=value </C>
        <C>Col=mobile_no        		Ctrl=mobile_no          	Param=value </C>    
        <C>Col=client_nm        		Ctrl=client_nm          	Param=value </C>    
        <C>Col=depart_datetime     		Ctrl=depart_datetime       	Param=value </C>
        <C>Col=accept_no        		Ctrl=accept_no          	Param=value </C>
        <C>Col=goods_nm         		Ctrl=goods_nm           	Param=value </C>    
        <C>Col=cust_nm          		Ctrl=cust_nm            	Param=value </C>
        <C>Col=manage_no	    		Ctrl=manage_no          	Param=value </C>    
        <C>Col=company_nm       		Ctrl=company_nm         	Param=value </C>
        <C>Col=reason           		Ctrl=reason             	Param=value </C>
        <C>Col=desc             		Ctrl=desc               	Param=value </C>    
		">
	</object>
<%=HDConstant.COMMENT_END%>      
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

