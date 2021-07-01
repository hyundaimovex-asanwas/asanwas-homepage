<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 신용카드 
 * 프로그램ID   : RV009H (코드는 대문자)
 * J  S  P      : rv009h (jsp파일명은 소문자로 한다 )
 * 서 블 릿        : Rv009H
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
    
    String pay_cd = request.getParameter("pay_cd");
    String pay_manage_no = request.getParameter("pay_manage_no");
    String accept_no = request.getParameter("accept_no");
    String rsv_sid = request.getParameter("rsv_sid");
    String pay_date = request.getParameter("pay_date");
    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<title>금강산관광&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
        <link rel="STYLESHEET" type="text/css" href="http://www.mtkumgang.com/asanway/img/tour_common/common.css">
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
						+ ",accept_no=<%=accept_no%>"
						+ ",rsv_sid=<%=rsv_sid%>"
            	        + ",pay_manage_no=<%=pay_manage_no%>"
            	        + ",pay_cd=<%=pay_cd%>"
            	        + ",pay_date=<%=pay_date%>";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv007H",
	            "JSP(O:DS4=ds4)",
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
       <script language=JavaScript for=ds4 event=OnLoadCompleted(rowcnt)>

            if(rowcnt==0){
            	alert("조회된 항목이 없습니다!");
            	return;
            }
            pay_cd_nm.value = ds4.namevalue(1,"pay_cd_nm");
            goods_info.value = ds4.namevalue(1,"goods_info");
            card_company_nm.value = ds4.namevalue(1,"card_company_nm");
            pay_manage_no.value = ds4.namevalue(1,"pay_manage_no");
            valid_terms.value = ds4.namevalue(1,"valid_terms");
            agree_time.value = ds4.namevalue(1,"agree_time");
            agree_no.value = ds4.namevalue(1,"agree_no");
            card_no.value = ds4.namevalue(1,"card_no");
            hdasan_nm.value = ds4.namevalue(1,"hdasan_nm");
            pay_amt.value = ds4.namevalue(1,"pay_amt");
            
        </script>

        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnClose();
        </script>

<!-----------------------------------------------------------------------------
                                DataSet Components 선언 
# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
        <%=HDConstant.COMMENT_START%>
        <object id="ds4" classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
  <body style="margin:0px" onload="fnOnLoad()">

<!-- 팝업사이즈 : 500 * 585 -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/pop_tit_accountinfo.gif"><!-- 타이틀 --></td></tr>
		<tr><td height="15"></td></tr>
		<tr><td height="48" valign="top"><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/txt_accountinfo.gif" hspace="13"></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<table cellspacing="1" cellpadding="0" border="0" width="442" bgcolor="#FFFFFF">
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>거래종류</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>상품정보</B></td>
		</tr>
		<tr align="center" height="22">
			<td bgcolor="#f7f7f7" style="color:#39657b" align="center"><input type="text" name="pay_cd_nm" value="" readonly  style="border:0;text-align:center;background-color:#f7f7f7" ></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="goods_info" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>

		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>카드사</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>결제관리번호</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="card_company_nm" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="pay_manage_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>유효기간(YYMM)</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>거래일시</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="valid_terms" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="agree_time" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>승인번호</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>카드번호</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="agree_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="card_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>가맹점명</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>결제금액</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="hdasan_nm" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="pay_amt" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>

		</table>

		<table cellspacing="0" cellpadding="0" border="0" width="442">
		<tr><td height="21"></td></tr>
		<tr>
			<td height="39" valign="top" align="center"><a  onclick="window.print();"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_print.gif" class="btn" style="cursor:hand"></a><a onclick="window.close();"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_confirm2.gif" class="btn" style="cursor:hand"></a></td>
		</tr>
		</table>

		
		<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0"><tr><td><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/pop_btm_accountinfo.gif" ></td></tr></table>
	</td>
</tr>
<tr>
	<td style="padding:4px">※ 출발예정일 9일전부터 당일까지 계약 취소시 판매가의 50%만 환급합니다.<BR>
	※ 본 영수증은 소득공제용 및 지출 증빙으로 효력이 없습니다.
	</td>
</tr>
</table>

</body>
</html>
