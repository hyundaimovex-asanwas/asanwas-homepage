<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>����>�������>�۾�����>�۾� ���
 * ���α׷�ID 	 : PMS/SI110I
 * J  S  P		 : si110i.jsp
 * �� �� ��		 : Si110I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2014-03-27
 * [ �������� ][������] ����
 * [2014-04-10][�ɵ���] �ű� ���� 
 *						������2 �ֿ� ��� : ���ſ�û���� ������?

 *****************************************************************************/
%>
<%@ page import="pms.common.HDConstant"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <title>�ֿ� ��� ��ȸ</title>
        <jsp:include page="/Pms/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
				var strParam = new Array();
				strParam=window.dialogArguments;
				s_site_sid.value = strParam[0];
				s_site_nm.value = strParam[1];
				
				fnSelect();
            }
            
            function fnSelect() {
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Si110H_02?proType=S&dsType=1&v_site_sid=" + s_site_sid.value ;
                ds1.Reset();
            }
            
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "item_sid") + ";" +
                                     ds1.namevalue(row, "item_nm") + ";" +
                                     ds1.namevalue(row, "item_size") + ";" +
                                     ds1.namevalue(row, "item_nm_s");
                fnClose();
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

	<%// Description  :  �׸��� ����Ŭ�� �̺�Ʈ �߻�%>          
    <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
        fnAdd();
    </script>
	<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
           if (keycode == 13) {
           	fnAdd();
           }
	</script>
       

	<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="false">
	</object>

	</head> 
    
	<!--  BODY START -->
	<body cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:5px;">
	  <tr height="30px">
		<td align="right" colspan="2">
			<img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;top:0px;cursor:pointer;" onClick="fnAdd()">                            
			<img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;top:0px;cursor:pointer;" onClick="fnClose()">                          
		</td>
	  </tr>
	  <tr>
		<td class="text" width="100px" height="30" style="border:1 solid #708090">�����</td>
		<td width="378px" style="border:1 solid #708090;border-left-width:0px">
			<input type="hidden" name="s_site_sid" >
			<input type="text" class="hidden" name="s_site_nm" style="width:95%;" readonly="readonly">        
	    </td>
	  </tr>
	</table>

    <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
      <tr>
      	<td>
			<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='679px' height='248px' border='1'>
				<param name="DataID"        value="ds1">
				<param name="BorderStyle"   value="0"> 
				<param name="ColSizing"     value="true">
				<param name="Fillarea"      value="true">
				<param name="AutoResizing"  value=true> 
				<param name="Editable"      value="false">
				<param name="ViewSummary"	value="1">
				<param name="Format"        value="
					<C> name='ǰ��'     ID='ITEM_SID'      width=50 align=right decao=0  edit=none</C>
					<C> name='LV2'     ID='nm2'     	 width=65 align=left edit=none suppress=1</C>
					<C> name='LV3'     ID='nm3'      	width=125 align=left edit=none suppress=2 SumText='��' </C>
					<C> name='ǰ��'     ID='ITEM_NM'       width=200 align=left SumText=@count SumTextAlign=center</C>
					<C> name='�����'   ID='ITEM_NM_S'     width=70  align=left SumText='��'</C>
					<C> name='�԰�'  	ID='ITEM_SIZE'     width=80 align=left		</C>
					
				">
			</object>
                </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>