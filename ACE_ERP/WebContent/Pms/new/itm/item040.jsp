<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ǰ���ڵ� �̷���ȸ
 * ���α׷�ID 	 : PMS/Itm
 * J  S  P		 : Itm040.jsp
 * �� �� ��		 : Itm040
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-12
 * �������		 : ǰ���ڵ� �̷���ȸ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("gr_default"), "comn");

		fnInit();
		
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";

		fnSelect();
        
    }
    
    <%//���� ��ȸ  %>
    function fnSelect() {

		    v_job="S";


	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  		+ ",v_item=" + v_item.value						//ǰ���ڵ��;
	    	
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm040",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        

    }    
    




</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>




<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">


</script>


<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
    
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
        
    </script>
 
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
	
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";

	</script>
	

	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>

</head>


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="1000px"> 
    
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='1000px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
                    			<tr>
			                        <td align=left class="text"  width="100">ǰ���ڵ�</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
                                       <input type="text" name='v_item' id="v_item" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                               
			                        </td>
			                        
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="1000px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
									 <C> name='No'			ID='{CurRow}'		 	width=50 	align=CENTER	edit=none   </C>
                                     <C> name='Code'		ID='CD_ITEM'    		width=150 	align=CENTER	Edit=None 	suppress='1'</C>
                                     <C> name='�ڵ��' 		ID='DS_KSITEM'    		width=300 	align=CENTER	Edit=None 	suppress='2'</C>                                                              
                                     <C> name='��������'	ID='DT_APPLY' 			width=150 	align=CENTER	Edit=None	mask = 'XXXX-XX-XX'</C>
                                     <C> name='�������ܰ�'	ID='AMT_ITEM_BEFORE'    width=150 	align=CENTER	Edit=None 	DECAO=0</C>
                                     <C> name='�����Ĵܰ�'	ID='AMT_ITEM_AFTER'    	width=150 	align=CENTER	Edit=None 	DECAO=0</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
    </table>

	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		