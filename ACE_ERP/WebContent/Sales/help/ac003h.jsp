<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ���¹�ȣ
 * ���α׷�ID   : AC003H (�ڵ�� �빮��)
 * J  S  P      : ac003h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��        : Ac003H
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-08-17
 * �������     : ���¹�ȣ ��ȸ 
 * ��������     : 2006-08-17 : XXXXX ���� XXXXX ������û (�Ϸ�/�̿Ϸ�)
 * �� �� ��        : �迵��
 * ������������ :  
 * TODO         :
 * TODO         :
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>���¹�ȣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
        
        // ������ �ε�
        function fnOnLoad(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            fnSelect();
        }

        // ���� ��ȸ
        function fnSelect() {
            ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac003H?proType=S";
            ds1.Reset();
        }
        
        // ������� ��ȸ 
        function fnAdd() {
            var row = ds1.rowposition;
            if(row==0){
                return;
            }
            if(ds1.CountRow==0) {
                alert("���� ��ȸ�� �Ͻñ� �ٶ��ϴ�.");
                return false;
            }
            window.returnValue  = ds1.NameValue(row, "BNKNUM")+";"
                                + ds1.NameValue(row, "BANCOD")+";"
                                + ds1.NameValue(row, "BNKNAM")+";"
                                + ds1.NameValue(row, "ACCTNONM")+";";
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
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            document.all.LowerFrame.style.visibility="hidden";
            if(row==0){
                alert("���¹�ȣ�� �����ϴ�.");
                return;
            }
        </script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ��ȸ�� ���� 
%>      
        <script language=JavaScript  for=ds1 event="OnLoadError()">
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

    <%=HDConstant.COMMENT_START%>
    <object id="ds1" classid=<%=HDConstant.CT_DATASET_CLSID%>>
        <param name="SyncLoad" value="false">
    </object>
    <%=HDConstant.COMMENT_END%>

    </head> 
    
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td height=25>
                    <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center>���¹�ȣ��ȸ
                </td>
            </tr>
            <tr>
                <td valign=bottom align=right>
                    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="����Ÿ��/���� �˻��մϴ�" style="cursor:hand;" onclick="fnSelect();">
                    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">                            
                    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">&nbsp;
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
            <tr>
                <td>
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=479px; height:260px;border:1 solid #777777;">
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="AllShowEdit"   value="false"> <!-- Edit����  -->
                        <param name="ColSizing"     value="true">
                        <param name="Editable"      value="false">
                        <param name="FillArea"      value="True">
                        <param name="SortView"      value="Right">
                        <param name="Format"        value="
                            <c> Name='���¹�ȣ'      ID='BNKNUM'       Edit=None Width=130 align=center</c>
                            <c> Name='�����ڵ�'      ID='BANCOD'       Edit=None Width=100 align=center</c>
                            <c> Name='��������'      ID='BNKNAM'       Edit=None Width=130 align=center</c>
                            <c> Name='���¸�'        ID='ACCTNONM'     Edit=None Width=100 align=center</c>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                </td>
            </tr>
            <tr>
                <td>
                <!--  ���¹� �÷���  -->
            <iframe id="LowerFrame" 
                name="work" 
                style="visibility:hidden; position:absolute; left:100px; top:150px;" 
                Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
                width="320px" 
                height="42px">
            </iframe>   
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>