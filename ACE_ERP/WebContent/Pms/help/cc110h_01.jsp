<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	 : ���� / �ͼ����� ��ȸ
 * ���α׷�ID 	 : PMS/Help/cc110h_01.jsp
 * J  S  P		 : cc110h_01.jsp
 * �� �� ��		 : help/Cc110H01
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-08-24
 * �������		 : ���»� �˻� / ����
 * [ �������� ][������] ����
 * [2015-08-24][�ɵ���] �ű�. ��� �ͼ� �˾�
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
    <title>�ͼ����� �˾�������������������������������������������������������������������������</title>
        <jsp:include page="/Pms/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                ds_gc_gubn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY203&s_item1=Y";
                ds_gc_gubn.Reset();
            	
                var strParam = new Array();
            	strParam=window.dialogArguments;
            	keyword.value=strParam[0];  //�ͼ��ڵ��
				fnSelect();
            }
            
            function fnSelect() {
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cc110H_01?proType=S&dsType=1&v_keyword=" + keyword.value ;
                ds1.Reset();
            }
            
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "pl_dept_div") + ";" +
                                     ds1.namevalue(row, "pl_dept") + ";" +
                                     ds1.namevalue(row, "pl_dept_nm");
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
            ft_cnt1.innerText="Cnt : " + row;
            document.all.LowerFrame.style.visibility="hidden";
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            document.all.LowerFrame.style.visibility="hidden";
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>          
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
<object  id=ds_gc_gubn classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>



    </head> 
    
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
                        <tr>
                            <td class="text" width="100px" height="30" style="border:1 solid #708090">�ڵ��</td>
                            <td width="110px" style="border:1 solid #708090;border-left-width:0px">
                                <input type="text" name="keyword" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:5px;width:247px">
                        <tr>
                            <td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�ڵ�/���� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
                                <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
            <tr>
                <td>
<%
/*---------------------------------------------------------------------------->
    Object ID   : �׸��� , gr1
    Data ID     : ds1
-----------------------------------------------------------------------------*/
%>
                    
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='479px' height='248px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name="Format"        value="
                            <F> name='��'		 ID={CurRow}		width=40	align=right	</F>
                            <c> Name='����'    	 ID='pl_dept_div'	Width=80	align=center editstyle=lookup Data='ds_gc_gubn:detail:detail_nm' </c> 
                            <c> Name='CCTR�ڵ�'  ID='pl_dept'		Width=90	align=center </c>
                            <c> Name='CCTR��'    ID='pl_dePt_nm'	Width=230	align=left</c>
                        ">
                    </object>
                     
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
                    &nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                <!--  ���¹� �÷���  -->
			<iframe id="LowerFrame" 
				name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;"
				 Frameborder="0" src="<%=dirPath%>/Common/include/loadingSales.jsp" 
				 width="400px" height="146px"></iframe>
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
    
</html>