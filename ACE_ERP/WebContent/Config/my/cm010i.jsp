<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>ȯ�漳��>����������>Ŀ�´�Ƽ>2015 ����QnA. ����
 * ���α׷�ID 	 : Config/my/cm010i
 * J  S  P		 : cm010i.jsp
 * �� �� ��		 : Cm010I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-02-11
 * [ �������� ][������] ����
 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="config.common.HDConstant"%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
	<title>2015�� WORKSHOP [������ ������ ���� Q&A] ����</title>
		
	<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">
	<link href="<%=dirPath%>/Sales/common/css/common.css" rel="stylesheet" type="text/css">
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	/*
	 * �������ε�
	 */
	function fnOnLoad(){
	    v_job ="I";
		//�����ͼ� ��� �ʱ�ȭ
		ds_wm.SetDataHeader("a1:STRING(200),a2:STRING(4000)");
		ds_wm.addrow();
		document.all.a1.focus();
    }
    

	<%//���� %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_wm.RowPosition;
		
		if (ds_wm.IsUpdated) {
			ln_TRSetting(tr1, 
               "<%=dirPath%><%=HDConstant.PATH_MY%>Cm010I",
               "JSP(I:DS_WM=ds_wm)",
               "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
               	);
       		tr_post(tr1);

		}else {
     		alert("�ۼ��� ������ �����ϴ�.");
	 	}
	}


	</script>

	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
	    
		if(document.form1.chkbox.checked) {
			var todayDate = new Date();
			todayDate.setDate( todayDate.getDate() + 1 );//3��
			document.cookie = "pop2015=done; path=/; expires=" + todayDate.toGMTString() + ";"
		}
		window.close();
	}
</script>

  
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_wm classid=<%=HDConstant.MxDataSetU_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTRU_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
</head>

<!-- //body_s.jsp -->
<body onLoad="fnOnLoad();">
<!-- //body_s.jsp -->

<table border='0' cellpadding='0' cellspacing='0' width="100%">
  <tr>
  	<td class="c" style="padding-top:10px">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width="470">
  <tr>
  	<td class="c">
    <table border='0' cellpadding='0' cellspacing='0' width="430"> 
        <tr height='56px'>
            <td class="c bold" style="font-size:14px;color:#0033ff">2015�� WORKSHOP [������ ������ ���� Q&A] ����</td>
        </tr>
        <tr height='36px'>
            <td class="l">1. ���� ���</td>
        </tr>
        <tr>
            <td class="c"><textarea name="a1" id="a1"  class=textbox cols=65 rows=5  tabindex="1"></textarea></td>
        </tr>
        <tr height='36px'>
            <td class="l">2. ���� ����</td>
        </tr>
        <tr>
            <td class="c"><textarea name="a2" id="a2"  class=textbox cols=65 rows=23  tabindex="2"></textarea></td>
        </tr>
        <tr>
            <td class="l" style="padding-left:10px;">
            * �͸� �����̿��� ���� �� ���ǻ��� �� �����Ӱ� �ۼ��Ͻñ� �ٶ��ϴ�.<br>
			* ���� ���� : 2�� 25��</td>
        </tr>
        <tr height='40px'>
            <td class="c"><form name="form1" style="display:inline;margin:0px;">
				<input type="checkbox" name="chkbox" id="chkbox" onfocus='this.blur()' />
				</form>�Ϸ絿�� �Ⱥ���
            <img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" onClick="fnApply();"></td>
        </tr>
    </table>

  	</td>
  </tr>
</table>
  	    

	</td>
  </tr>
</table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.MxBinderU_CLASSID%>>
	             <param name="DataId" value="ds_wm">
	             <param name=BindInfo    value="
					<C>Col=A_SID	Ctrl=a_sid		Param=Value </C>
					<C>Col=A1       Ctrl=a1        Param=Value </C>
					<C>Col=A2    	Ctrl=a2    	Param=Value </C>
	              ">
	      </object>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		