<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>ȯ�漳��>����������>Ŀ�´�Ƽ>2015 ����QnA
 * ���α׷�ID 	 : Config/my/cm010s
 * J  S  P		 : cm010s.jsp
 * �� �� ��		 : Cm010S
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-02-10
 * [ �������� ][������] ����
 * [2015-02-10][�ɵ���] �ű� ���� 
 *****************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="config.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Config/common/include/head.jsp"/>
    
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
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		fnInit();
		fnSelect();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    gr_default.RowHeight = "50";	//�׸��� �ο�����Ʈ ����
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_MY%>Cm010S",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
        tr_post(tr1);
    }    

    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:�ֿ� �۾� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("�ֿ� �۾� ��Ȳ", v_date.text+"�ֿ� �۾� ��Ȳ.xls", 8);        
    }
    
 

    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<%// ���� Ŭ���� �۾��Ϻ� ��ȸ �� %>
	<script language=javascript for="gr_default" event="OnDblClick(Row, Colid)">
	    if(Row==0) return;
	 	fnDraft(ds_default.NameValue(Row, "DWR_SID"),ds_default.NameValue(Row, "W_STS"));
	</script>

	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=v_date event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_default" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}
		}
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.MxDataSetU_CLSID_S%>> 
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
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->






<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                         
                        <object id=gr_default classid=<%=HDConstant.MxGridU_CLSID_S%> width='890px' height='450px' border='1'>
                            <param name="DataID"            value="ds_default">
                            <param name="ColSizing"         value="true">
                            <param name="Editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="BorderStyle"       value="0">
                            <param name="ViewSummary"       value="0">
                            <param name="Format"            value="
                                 <C> name='�� ȣ'			ID='A_SID'	width=60 	align=center	Edit=None </C>
                                 <C> name='1.���� ���'		ID='A1'   	width=180 	align=left	multiline=true</C>
                                 <C> name='2.���� ����'  	ID='A2'		width=520 	align=left	multiline=true</C>
                                 <C> name='�ۼ�����'		ID='I_DATE' width=100 	align=center	Edit=None  </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top"><br>

			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		