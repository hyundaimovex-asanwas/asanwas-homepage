<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		:
 * ���α׷�ID 	:
 * J  S  P		:
 * �� �� ��		:
 * �� �� ��		:
 * �� �� ��		:
 * �������		:
 * ��������		: 
 * �� �� ��		:
 * ������������ :
 *****************************************************************************/
%>


<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD ���� -->
	<jsp:include page="/Sales/common/include/head.jsp"/>

<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		
		/*
		 * �������ε�
		 */
		function fnOnLoad(){
			//fnInit(); 
		}

		/*
		 * ����Ÿ�� ��� ����
		 */
		function fnSetHeaderDsInit(){
			
			if (initds1.countrow < 1){
				var s_temp1 = "head:STRING,detail:STRING,detail_nm:STRING";
				ds1.SetDataHeader(s_temp1);
			}
							
		}	
			
		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
		    ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I?proType=INIT&dsType=1";
			ds1.Reset();	
		}

			
		/*
		 * ���� ��Ⱥ
		 */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/*
		 * �����ͼ� ù��° ��ȸ
		 */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I?proType=S&dsType=1&sClientSid="+sClientSid.value
																					+"&sCustGu=" + searchds1.namevalue(searchds2.rowposition, "detail")
																					+"&sCountryGu=" + searchds2.namevalue(searchds2.rowposition, "detail")
																					+"&sCustNm=" + sCustNm.value
																					+"&sManegeNo=" + sManegeNo.value;
																				
			ds1.Reset();			
		}
			
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {
			ds1.addrow();
		}
			
		/*
		 * �����, ����
		 */
		function fnDeleteRow() {
			ds1.deleterow(ds1.rowposition);
		}
			
		/*
		 * ����
		 */
		function fnApply() {
			var row1=ds1.countrow;
				
			if (ds1.IsUpdated) {
				tr1.KeyValue = "Cu010I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Cu010I?proType=A&dsNum=1";
																	
				tr1.post();
				fnSelect(); // �Է��� ��ȸ 
			}		
		}
			
		/*
		 * ��� 
		 */
		function fnCancelDs1() {
			ds1.undoall();
			window. status="������ ������ ��ҵǾ����ϴ�.";
			return;		
		}
			
			
		/*
		 * ����Ʈ
		 */
		function fnPrintDs1() {
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {
			gr1.runexcel("���� �޴� ���");
		}
			
		/*
		 * �˾�
		 */
		function fnPopup() {
			
		}
			
		/*
		 * �Է� üũ
		 */
		function fnCheck() {
		}
		
			
		
		
	
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>

	

		
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>
	</head>
	

<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											 - 
										</td>
									</tr>
								</table>						
<!--------------------------------- �ڵ� �κ� �� -------------------------------->								
<%
/*******************************************************************************
			Bind ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                     <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
                     
              ">
      </object>
<%=HDConstant.COMMENT_END%>      

<jsp:include page="/Sales/common/include/body_e.jsp"/>