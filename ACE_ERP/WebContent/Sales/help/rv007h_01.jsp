<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 보증금_가상계좌
 * 프로그램ID   : RV007H_01 (코드는 대문자)
 * J  S  P      : rv007h_01 (jsp파일명은 소문자로 한다 )
 * 서 블 릿     : Rv007H_01
 * 작 성 자     : 이병욱
 * 작 성 일     : 2006-07-22
 * 기능정의     : 입금종류에 따른 조회 계좌이체 
 * 수정내용     : 2006-07-22 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * 수 정 자     : 이병욱
 * 최종수정일자 : [20090304][박경국] 보증금 가상계좌 상세조회팝업 추가. 
 
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
     // ContextPath
    String dirPath = request.getContextPath();
    
    String pay_cd = request.getParameter("pay_cd");
    String pay_manage_no = request.getParameter("pay_manage_no");
    String block_no = request.getParameter("block_no");
    String block_sid = request.getParameter("block_sid");
    String pay_date = request.getParameter("pay_date");
    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<title>금강산관광&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
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
						+ ",block_no=<%=block_no%>"
						+ ",block_sid=<%=block_sid%>"
            	        + ",pay_manage_no=<%=pay_manage_no%>"
            	        + ",pay_cd=<%=pay_cd%>"
            	        + ",pay_date=<%=pay_date%>";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv007H_01",
	            "JSP(O:DS2=ds1)",
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
       <script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>

            if(rowcnt==0){
            	alert("조회된 항목이 없습니다!");
            	return;
            }
            
            pay_cd_nm.value = ds1.namevalue(1,"pay_cd_nm");
            depart_date.value = ds1.namevalue(1,"depart_date");
            goods_nm.value = ds1.namevalue(1,"goods_nm");
            pay_date.value = ds1.namevalue(1,"pay_date");
            pay_manage_no.value = ds1.namevalue(1,"pay_manage_no");
            bank_nm.value = ds1.namevalue(1,"bank_nm");
            bank_acct.value = ds1.namevalue(1,"bank_acct");
            order_nm.value = ds1.namevalue(1,"order_nm");
            pay_amt.value = ds1.namevalue(1,"pay_amt");
            
        </script>

        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnClose();
        </script>

<!-----------------------------------------------------------------------------
                                DataSet Components 선언 
# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
        <%=HDConstant.COMMENT_START%>
        <object id="ds1" classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="depart_date" value="" readonly style="border:0;text-align:right;background-color:#f7f7f7"><input type="text" name="goods_nm" value="" readonly style="border:0;background-color:#f7f7f7">
		</tr>

		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>결제일자</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>결제관리번호</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="pay_date" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="pay_manage_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>은행</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>가상계좌번호</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="bank_nm" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="bank_acct" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>주문자명</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>결제금액</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="order_nm" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="pay_amt" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		</table>

		<table cellspacing="0" cellpadding="0" border="0" width="442">
		<tr><td height="21"></td></tr>
		<tr>
			<td height="39" valign="top" align="center"><a  onclick="window.print();"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_print.gif" class="btn" style="cursor:pointer"></a><a onclick="window.close();"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_confirm2.gif" class="btn" style="cursor:pointer"></a></td>
		</tr>
		</table>

		
		<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0"><tr><td><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/pop_btm_accountinfo.gif"></td></tr></table>
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