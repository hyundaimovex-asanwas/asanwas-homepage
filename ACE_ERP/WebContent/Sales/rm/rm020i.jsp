<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ���������
 * ���α׷�ID 	: RM020I
 * J  S  P		: rm020i
 * �� �� ��		: Rm020I
 * �� �� ��		: ������
 * �� �� ��		: 2006-06-08
 * �������		: ���������(��ȸ ��� ���� ����)
 * 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windwos������ ASP�� �Ǿ� ����.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ 
// Parameter 	: 
%>
	function fnInit(){
	        cfStyleGrid(getObjectFirst("gr1"), "comn");
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
	function fnSelectDs1() {
		var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" 
			+ ",s_DongCd=" + txt_dong_cd.value.toUpperCase()
			+ ",s_DongNm=" + txt_dong_nm.value;

		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_RM%>Rm020I", 
		    "JSP(O:DEFAULT=ds1)",
		    v_param);
		tr_post(tr1);
		
        /*var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" 
					+ ",s_DongCd=" + txt_dong_cd.value.toUpperCase()
					+ ",s_DongNm=" + txt_dong_nm.value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm020I", 
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);*/
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>
		function fnAddRowDs1() {
			ds1.addrow();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	: 
%>
		function fnDeleteRowDs1() {
			if (confirm("<%=HDConstant.C_MSG_ASK_DELETE%>")) {
				ds1.deleterow(ds1.rowposition);
			}
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
		function fnApply() {
				if (ds1.IsUpdated) {
					if (fnChk()) {
						var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsNum=1";
						
					ln_TRSetting(tr1, 
					    "<%=dirPath%><%=HDConstant.PATH_RM%>Rm020I",
					    "JSP(I:INPUT_DATA=ds1)",
					    param);
					   
					tr_post(tr1);
					}
				}
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
		function fnCancelDs1() {
			ds1.undoall();
			msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �˻����Ƕ� �˾�
%>
		function fnPopup() {

		}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
		function fnChk() {
			var row=ds1.countrow;
			for(i=1;i<=row;i++) {
				if(ds1.namevalue(i,"upjang_sid")=="") {
					alert("����<%=HDConstant.A_MSG_MUST_INPUT%>");
					return false;
				}
			}
			return true;
		}
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%> 
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
			if(colid=="upjang_cd") {
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy004h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrParam[0] = ""; //�ڵ�
				arrParam[1] = ""; //�ڵ��̸�
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != null) {
					arrParam = arrResult.split(";");
					ds1.namevalue(row,"upjang_sid") = arrParam[0];
					ds1.namevalue(row,"upjang_cd") = arrParam[1];
			    	ds1.namevalue(row,"upjang_nm") = arrParam[2];
				} else {
				
				}
			}
		</script>
		
		<script language=JavaScript for=gr1 event=OnLastDown()>
			if(ds1.RowStatus(ds1.RowPosition)=='0'||ds1.RowStatus(ds1.RowPosition)=='3') {
				fnAddRowDs1();
			}
		</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			//document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			//document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				msgTxt.innerHTML="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("<%=HDConstant.AS_MSG_SEARCH_ERR%>");
			msgTxt.innerHTML="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			//document.all.LowerFrame.style.visibility="hidden";
		</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onsuccess()">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onfail()">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
		<%=HDConstant.COMMENT_START%>
		<object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
			<param name="SyncLoad" 	value="false">
		</object>
		<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
		<%=HDConstant.COMMENT_START%>
		<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
			<param name="KeyName"  value="toinb_dataid4">
		</object>
		<%=HDConstant.COMMENT_END%>

</head>                                                                                 
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>                              
                                                                                        
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
							
<table border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor=orange> 
  <tr>
  	<td>
		<table width="400px" cellpadding="0" cellspacing="0" border="0">
		  <tr> 
			<td style="width:70px;height:30px;border:1 solid #708090;" bgcolor="#eeeeee" align=center class="txtbox">���ڵ�</td>
			<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
				<input id="txt_dong_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="5">
			</td>
			<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">���̸�</td>
			<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
				<input id="txt_dong_nm" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="30">
			</td>
		  </tr>
		</table>
  	</td>
  	<td align=right style="padding-right:10px">
		<nobr>
		<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
		<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:pointer;position:relative;left:3px;top:3px"  onClick="fnAddRowDs1()" >
		<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnDeleteRowDs1()" >
		<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply()">
		<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnCancelDs1()">
		</nobr>
  	</td>  	
  </tr>
  <tr>
	<td height=3  border="0"></td>
  </tr>
  <tr> 
	<td valign=top colspan=2> 
		<%
		/*---------------------------------------------------------------------------->
			HTML Desc	: xxxxxxxx 
						: �˻� ���� - �з��ڵ�, �з���
			Object ID 	: �׸��� , gr1
			Data ID		: ds1
		-----------------------------------------------------------------------------*/
		%>
		<%=HDConstant.COMMENT_START%>											
		<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
			<param name="DataID"		VALUE="ds1">
			<param name="BorderStyle"   VALUE="0">
			<param name="Fillarea"		VALUE="true">
			<param name=ColSizing       value="false">
			<param name="IndWidth"      value="0">
			<param name="editable"      value="true">
			<param name=UsingOneClick  	value="1">
			<param name="Format"		VALUE="  
				<C> name='���ڵ�' 	 ID='dong_cd' 	     HeadAlign=Center Width=75 align=center</C>		
				<C> name='���̸�'    ID='dong_nm'        HeadAlign=Center Width=250 align=left</C>
				<C> name='������'    ID='dong_eng_nm'    HeadAlign=Center Width=150 align=left</C>
				<C> name='�����'    ID='dong_short_nm'  HeadAlign=Center Width=100 align=center</C>
				<C> name='�����ڵ�'  ID='upjang_cd'      HeadAlign=Center Width=100 align=center editstyle=popup</C>
				<C> name='�����'    ID='upjang_nm'      HeadAlign=Center Width=150 align=left BgColor=#fefec0 edit=none</C>
			">
		</object> 
		<%=HDConstant.COMMENT_END%>
	</td>
  </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
                                                                                    
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		                    
                                                                                    