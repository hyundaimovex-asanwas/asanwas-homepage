<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ����� ����� ü������ �� �԰��� ü������
 * ���α׷�ID   : CQ003H
 * J  S  P      : cq003h
 * �� �� ��     : Cq003H
 * �� �� ��     : �迵��
 * �� �� ��     : 2006-07-25
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
    <title></title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            var v_trn_gu = "";      //������� ����
            var v_saup_sid = "";    //��� sid
            var v_depart_date = ""; //�������
            var v_goods_sid = "";   //��ǰ sid
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                
                var strParam = new Array();
                strParam=window.dialogArguments;
                
                if(strParam.length==0){
                    alert("�Ķ���� ������ �Ѿ���� �ʾҽ��ϴ�.");
                    window.close();
                    return;
                }
                
                v_trn_gu = strParam[0];
                v_saup_sid = strParam[1];
                v_depart_date = strParam[2];
                v_goods_sid = strParam[3];
            }
            
            function fnSelect() {
				if(keyword.value==""){
					alert("������ȣ / �̸��� �ݵ�� �Է��� �ּ���.");
				}else{
	                var v_param = "proType=S"
		                            + "&dsType=1"
		                            + "&v_keyword=" + keyword.value 
		                            + "&v_trn_gu=" + v_trn_gu
		                            + "&v_saup_sid=" + v_saup_sid
		                            + "&v_depart_date=" + v_depart_date
		                            + "&v_goods_sid=" + v_goods_sid;
	                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cq003H?"+v_param;
	                ds1.Reset();
				};
            }
            
            function fnAdd() {
                var row = ds1.RowPosition;
            
                window.returnValue = ds1.namevalue(row, "CLASS") + ";" +
                                     ds1.namevalue(row, "TEAMS") + ";" +
                                     ds1.namevalue(row, "CUST_NM") + ";" +
                                     ds1.namevalue(row, "CUST_GU") + ";" +
                                     ds1.namevalue(row, "ARRIVE_DATE") + ";" +
                                     ds1.namevalue(row, "ARRIVE_TIME") + ";" +
                                     ds1.namevalue(row, "DEPART_DATE") + ";" +
                                     ds1.namevalue(row, "DEPART_TIME") + ";" +
                                     ds1.namevalue(row, "GOODS_SID") + ";" +
                                     ds1.namevalue(row, "GOODS_NM") + ";" +
                                     ds1.namevalue(row, "MANAGE_NO") + ";" +
                                     ds1.namevalue(row, "RSV_SID") + ";" +
                                     ds1.namevalue(row, "INOUT_SID");
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
			fnShowLoading(410,180);            
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
            ft_cnt1.innerText="Cnt : " + row;
			fnHideLoading();
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();
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
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>


    </head> 
    
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()"><A></A>

	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	
	
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:100;height:15;left:5px;">������� ��ȸ</font>
                            </td>
                        </tr>
                        <tr>
                            <td class="text" width="100px" height="30" style="border:1 solid #708090">������ȣ / �̸�</td>
                            <td width="110px" style="border:1 solid #708090;border-left-width:0px">
                                <input type="text" name="keyword" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
                        <tr>
                            <td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�ڵ�/���� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:pointer;" onclick="fnSelect();">
                                <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnAdd()">                            
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnClose()">                          
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
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='479px' height='248px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name=SortView        value="Right">
                        <param name="SuppressOption"      value="1">
                        <param name="Format"        value="
                            <c> Name='��'           ID='CLASS'          Width=60 align=center suppress=1</c>
                            <c> Name='��'           ID='TEAMS'          Width=40 align=center suppress=2</c>
                            <c> Name='�������'	  	ID='DEPART_DATE'     Width=74 align=center suppress=3 Sort=True</c>
                            <c> Name='�԰�����'	  	ID='ARRIVE_DATE'     Width=74 align=center suppress=4 Sort=True</c>
                            <c> Name='�԰�ð�'     ID='ARRIVE_TIME'     Width=60 align=center suppress=5</c>
                            <c> Name='����'			ID='CUST_NM'        Width=50</c>
                            <c> Name='�ֹο��ǹ�ȣ' ID='MANAGE_NO'        Width=100</c>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%> 
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
				<td>�� "��"���� ��ȸ�ϸ� �达 ���� ��� ��ȸ�˴ϴ�.</td>
			</tr>			
        </table>
    </body>
    <!-- BODY END -->
</html>