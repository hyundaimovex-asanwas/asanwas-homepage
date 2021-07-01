<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재기안 :발주의뢰서
 * 프로그램ID 	: pr010h
 * J  S  P	    : pr010h.jsp
 * 서 블 릿		: pr010h
 * 작 성 자		: 이동훈
 * 작 성 일		: 2015-09-12
 * [ 수정일자 ][수정자] 내용
 * [2015-09-12][이동훈]
 *****************************************************************************/
%>
<%@ page import="pms.common.*" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid =0;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>전자결재 - 발주의뢰서결재</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">

		var retObj = window.dialogArguments;

        /********************************************
         * 1. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			document.form1.txtAP_DESC.focus();          //검색 1조건에 Focus

        }

        /*************************
         * 2. 반송버튼 Click    *
         *************************/
        function fnApply_Back() {

            var ap_desc = document.getElementById("txtAP_DESC");

            if(ap_desc.value.trim().length < 1){
            	
                alert("의견을 입력하시기 바랍니다.");
                
                ap_desc.focus();
                
                return;
                
            }
            
			window.returnValue = "Y"+ ";" + document.getElementById("txtAP_DESC").value + ";" 
            window.close();

        }

        /*************************
         * 3. 취소버튼 Click    *
         *************************/
        function fnCancel() {

            window.close();

        }        

    </script>

    </head>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnc_OnLoadProcess()">


<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25  width=800 align ="right">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_Back();">
	    	<img src="<%=dirPath%>/Sales/images/b_cancel.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnCancel();">	    	
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>&nbsp;&nbsp;
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:100;height:15;">&nbsp;의견입력</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=800>
		<table width="790px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">의견</td>
				<td height="25px"  width="660px" bgcolor="#eeeeee" align=left class="text">
                       <input name="txtAP_DESC" id="txtAP_DESC" size="100" maxlength="100" >
				</td>
			</tr>	
		</table>
	</td>
  </tr>
</table>
 <br>
 &nbsp;&nbsp;* 의견를 입력하시고 '반송' 버튼을 누르시면 반송처리가 완료됩니다.
 <br>
 &nbsp;&nbsp;* '취소' 버튼을 누르시면 반송처리가 취소되고 창이 종료됩니다.
</body>
<!- BODY END -->
</html>

