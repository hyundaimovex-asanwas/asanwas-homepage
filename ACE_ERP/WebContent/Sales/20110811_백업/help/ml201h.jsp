<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ���θ�_�ſ�ī�� ��������
 * ���α׷�ID   : ML201H (�ڵ�� �빮��)
 * J  S  P      : ml201h
 * �� �� ��     : Ml201H
 * �������		: EDI �ſ�ī�� ��������
 * [ �������� ][������] ����
 * [2011-01-27][�ɵ���] �ű� �ۼ�
 * 
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();

    String pay_cd = request.getParameter("pay_cd");
    String pay_manage_no = request.getParameter("pay_manage_no");
    String order_no = request.getParameter("order_no");
    String order_sid = request.getParameter("order_sid");
    String pay_date = request.getParameter("pay_date");
    String pay_sid = request.getParameter("pay_sid");    
    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<title>�������� EDI�ſ�ī��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
        <link rel="STYLESHEET" type="text/css" href="http://www.mtkumgang.com/asanway/img/tour_common/common.css">
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
        // ������ �ε�
        function fnOnLoad(){
	            fnSelect();
        }

        // ���� ��ȸ
        function fnSelect() {
			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
						+ ",order_no=<%=order_no%>"
						+ ",order_sid=<%=order_sid%>"
            	        + ",pay_manage_no=<%=pay_manage_no%>"
            	        + ",pay_cd=<%=pay_cd%>"
            	        + ",pay_sid=<%=pay_sid%>"
            	        + ",pay_date=<%=pay_date%>";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Ml201H",
	            "JSP(O:DS4=ds1)",
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
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
       <script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>

            if(rowcnt==0){
            	alert("��ȸ�� �׸��� �����ϴ�!");
            	return;
            }
            pay_cd_nm.value = ds1.namevalue(1,"pay_cd_nm");
            goods_info.value = ds1.namevalue(1,"goods_info");
            card_company_nm.value = ds1.namevalue(1,"card_company_nm");
            pay_manage_no.value = ds1.namevalue(1,"pay_manage_no");
            valid_terms.value = ds1.namevalue(1,"valid_terms");
            agree_time.value = ds1.namevalue(1,"agree_time");
            agree_no.value = ds1.namevalue(1,"agree_no");
            card_no.value = ds1.namevalue(1,"card_no");
            hdasan_nm.value = ds1.namevalue(1,"hdasan_nm");
            pay_amt.value = ds1.namevalue(1,"pay_amt");
            
        </script>

        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnClose();
        </script>

<!-----------------------------------------------------------------------------
                                DataSet Components ���� 
# ��ȸ�� �� ��� ����Ѵ�. 
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

<!-- �˾������� : 500 * 585 -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/pop_tit_accountinfo.gif"><!-- Ÿ��Ʋ --></td></tr>
		<tr><td height="15"></td></tr>
		<tr><td height="48" valign="top"><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/txt_accountinfo.gif" hspace="13"></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<table cellspacing="1" cellpadding="0" border="0" width="442" bgcolor="#FFFFFF">
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>�ŷ�����</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>��ǰ����</B></td>
		</tr>
		<tr align="center" height="22">
			<td bgcolor="#f7f7f7" style="color:#39657b" align="center"><input type="text" name="pay_cd_nm" value="" readonly  style="border:0;text-align:center;background-color:#f7f7f7" ></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="goods_info" value="" readonly style="border:0;width:280;text-align:center;background-color:#f7f7f7"></td>
		</tr>

		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>ī���</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>����������ȣ</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="card_company_nm" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="pay_manage_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>��ȿ�Ⱓ(YYMM)</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>�ŷ��Ͻ�</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="valid_terms" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="agree_time" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>���ι�ȣ</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>ī���ȣ</B></td>
		</tr>
		<tr align="center" height="22">
			<td  bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="agree_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
			<td colspan="2" bgcolor="#f7f7f7" style="color:#39657b"><input type="text" name="card_no" value="" readonly style="border:0;text-align:center;background-color:#f7f7f7"></td>
		</tr>
		<tr align="center" height="22">
			<td width="158" bgcolor="#D6DBDE"><B>��������</B></td>
			<td width="284" colspan="2" bgcolor="#D6DBDE"><B>�����ݾ�</B></td>
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

		
		<!-- �ϴܹ�  --><table cellspacing="0" cellpadding="0" border="0"><tr><td><img src="http://www.mtkumgang.com/asanway/img/tour_img/mypage/pop_btm_accountinfo.gif" ></td></tr></table>
	</td>
</tr>
<tr>
	<td style="padding:4px">�� �� ���������� �ҵ������ �� ���� �������� ȿ���� �����ϴ�.
	</td>
</tr>
</table>

</body>
</html>
