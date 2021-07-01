<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 계좌이체 
 * 프로그램ID   : RV007H (코드는 대문자)
 * J  S  P      : rv007h (jsp파일명은 소문자로 한다 )
 * 서 블 릿        : Rv007H
 * 작 성 자        : 이병욱
 * 작 성 일        : 2006-07-22
 * 기능정의     : 입금종류에 따른 조회 계좌이체 
 * 수정내용     : 2006-07-22 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * 수 정 자        : 이병욱
 * 최종수정일자 :  
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    String pay_cd = request.getParameter("pay_sid");
    String pay_manage_no = request.getParameter("pay_manage_no");
    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<title>무통장입금 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
        // 페이지 로딩
        function fnOnLoad(){
            fnSelect();
        }

        // 메인 조회
        function fnSelect() {
			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
            	        + ",pay_cd=<%=pay_cd%>"
                	    + ",pay_manage_no=<%=pay_manage_no%>";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv007H",
	            "JSP(O:DS7=ds7)",
	            v_param);
	        tr_post(tr1);
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
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
       <script language=JavaScript for=ds7 event=OnLoadCompleted(rowcnt)>

            if(rowcnt==0){
            	alert("조회된 항목이 없습니다!");
            	return;
            }
            
            pay_manage_no.value = ds7.namevalue(1,"pay_manage_no");
            bank_acct.value = ds7.namevalue(1,"bank_acct");
            bank_name.value = ds7.namevalue(1,"bank_name");
            bank_nm.value = ds7.namevalue(1,"bank_nm");
            order_nm.value = ds7.namevalue(1,"order_nm");
            pay_date.value = ds7.namevalue(1,"pay_date");
            pay_amt.value = ds7.namevalue(1,"pay_amt");
            
            
            
            
            
        </script>

        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnClose();
        </script>

<!-----------------------------------------------------------------------------
                                DataSet Components 선언 
# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
        <%=HDConstant.COMMENT_START%>
        <object id="ds7" classid=<%=HDConstant.CT_DATASET_CLSID%>>
            <param name="SyncLoad" value="false">
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
    
<!--  BODY START -->
    <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		       
       <table width="100%" height="320" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
        	<tr>
				<td height="3" bgcolor="#35ace8"></td>
			</tr>
			<tr>
	            <td height=25>
	                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align='absmiddle'><font style="position:relative;top:1px;width:60;height:15;left:5px;">무통장입금</font>
	            </td>
	        </tr>
			<tr>
				<td height="3" bgcolor="#35ace8"></td>
			</tr>
            <tr>
                <td align="center" background="<%=dirPath%>/Sales/images/c_bg.gif" valign="top">
					<table width="90%" cellpadding="0" cellspacing="0" border="0">
						<tr height="10">
							<td></td>
						</tr>
						<tr>
							<td width="12"><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">결제관리번호</td>
							<td><input type="text" name="pay_manage_no" value="" readonly class="input"></td>
						</tr>
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">계좌번호</td>
							<td><input type="text" name="bank_acct" value="" readonly class="input"></td>
						</tr>
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">은행명</td>
							<td><input type="text" name="bank_name" value="" readonly class="input" size=8>
								<input type="text" name="bank_nm" value="" readonly class="input" size=9></td>
						</tr>
						<tr>
							<td width="12"><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">입금자</td>
							<td><input type="text" name="order_nm" value="" readonly class="input"></td>
						</tr>
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">입금일자</td>
							<td><input type="text" name="pay_date" value="" readonly class="input"></td>
						</tr>					
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">입금액</td>
							<td><input type="text" name="pay_amt" value="" readonly class="input"></td>
						</tr>	
					</table>
            	</td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>