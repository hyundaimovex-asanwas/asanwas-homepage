<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : ���α׷� ����
 * ���α׷�ID 	 : CM030I
 * J  S  P		 : cm030I
 * �� �� ��		 : CM030I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2007-07-20
 * �������		 : ERP�ý��� �޴� ����
 *				      ������ ��ȸ, ����, ����, �߰�
 * [��  ��   ��  ��][������] ����
 * [2007-09-07][�ɵ���] ���ø������� ���� ����  �ּ� ó�� �� �ҽ� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>


<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			fnInit(); //�ʱ�ȭ �Լ�
		}

	/*	 * ����Ÿ�� ��� ����	 */
	function fnSetHeader(){


	}

	/*
	 * ����ȸ
	 */
	function fnInit(){
		//*****  ������ �ʱ�ȭ �Լ��� ���⿡..  ********
        cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.
//        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
//        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
//        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
//        window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {


    }
    </script>
<%
/*=============================================================================
				Developer Java Script ��
=============================================================================*/
%>
    
    
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/


/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">

		</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/



/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>


</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border=0 cellpadding="0" cellspacing="0" width="100%" bordercolor=orange>
  <tr>
	<td>
		<table border=0 width=845 cellpadding=0 cellspacing=0>
		  <tr height="50px">
			<td align="left" ><!-- ��ư ����-->
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
			<td align="left" ><!-- �˻����� ����-->
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td  width="845px">
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	                            <tr bgcolor="#6f7f8d">
	            					<td align=left class="text" width=70>&nbsp;�޴�����</td>
	                                <td align=left bgcolor="#ffffff">&nbsp;																										
										<SELECT NAME=menu_level style="width:120px;align:center;">
											<OPTION value=1>����1 ����</OPTION>
											<OPTION value=2>����2 ����</OPTION>
											<OPTION value=3>����3 ����</OPTION>
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
			<td width="845px"><!-- �׸��� ����-->
				
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
									<C> name='�޴�����'      	ID='LEVEL'     	width=60	align=center editlimit=5 show=TRUE edit=none </C>
									<C> name='�����޴���'		ID='PARENT_IDX'	width=120  	align=LEFT show=true editstyle=lookup data='ds_menu:menu_idx:scdnm' show=true </C>
									<C> name='�޴���'   	 	ID='SCDNM'     	width=140	align=left editlimit=5 show=true </C>
									<C> name='����'      	ID='SEQ'   		width=60	align=center editlimit=5 show=true</C>
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

<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
