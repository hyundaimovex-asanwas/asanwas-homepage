<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : Ȩ>��������>�������>�����û>������ȸ (�����Ǹſ�)
 * ���α׷�ID   : RV200S
 * J  S  P      : rv200s
 * �� �� ��        : Rv200S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-14
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-02-12][�ڰ汹]	��û���ڿ� ���� �˻����� �߰� 
 * [2010-01-28][�ɵ���] ���� ������ ���� [��ġ��], [�Աݱ���] �÷� �˻����� �߰�..��_��;;
 * [2010-02-02][�ڰ汹] ���� ������ ���� ������ȸȭ��. ��� ��ȸ���� ����. ��ȸ�Ǵ� �÷� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/****************************************************************************
                ����� ��ũ��Ʈ
******************************************************************************/
%>      
        <script language="javascript">
            var div = "";
            var jobFlag = "";
        /*
         * �������ε�
         */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

            cfStyleGrid(getObjectFirst("gr_cust"), "comn");
            fnInit(); 
        } 
        
        /*
         * �ʱ��۾�
         * Header ���� 
         * ����
         */
        function fnInit() {
        }
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid=1";
                    
          ln_TRSetting(tr1, 
              "<%=dirPath%><%=HDConstant.PATH_RV%>Rv202S",
              "JSP(O:DS_CUST=ds_cust)",
              param);
          tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:����������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("����������Ȳ", "����������Ȳ.xls", 8);        
        }

              </script>

<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>

	
    <script language=JavaScript  for=ds_cust event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_cust event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
	<script language=JavaScript  for=initds1 event="OnLoadCompleted(row)">
		initds1.insertrow(1);
		initds1.namevalue(initds1.rowposition, "detail") = "";
		initds1.namevalue(initds1.rowposition, "detail_nm") = "��ü";
		lc_cust_gu.Index = 0;
    </script>
	<script language=JavaScript  for=initds2 event="OnLoadCompleted(row)">
		initds2.insertrow(1);
		initds2.namevalue(initds2.rowposition, "detail") = "";
		initds2.namevalue(initds2.rowposition, "detail_nm") = "��ü";
		
		lc_country_gu.Index = 0;

    </script>
	<script language=JavaScript  for=initds3 event="OnLoadCompleted(row)">
 		initds3.insertrow(1);
		initds3.namevalue(initds3.rowposition, "detail") = "";
		initds3.namevalue(initds3.rowposition, "detail_nm") = "��ü";     
		
		lc_saup_gu.Index = 0; 
    </script>        
     
    
    
    
    <script language="javascript" for="tr1" event="onsuccess()">
        msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
    </script>   
    
    
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
    </script>

<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
    <param name=SubsumExpr	value="TOTAL,1:CLIENT_NM">
	<param name=SortExpr	value="+CLIENT_NM+GOODS_NM+CUST_NM">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��� -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
     
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right' width=845>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDs1()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                            <table  border='0' cellpadding='0' cellspacing='0' width='845px' height='350px' >
                                <tr>
                                    <td valign=top>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_cust classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
                                            <param name="DataID"            value="ds_cust">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="
                                                 <C> name='�븮��'			ID='CLIENT_NM'		width=110	align=left 		Edit=None suppress=1</C>
                                                 <C> name='�������'    	ID='DEPART_DATE'    width=70 	align=CENTER	Edit=None  show=false</C>
												 <C> name='��û����'    	ID='ACCEPT_DATE'    width=70 	align=CENTER	Edit=None  show=false</C>
                                                 <C> name='��߽ð�'    	ID='DEPART_TIME'	width=60 	align=center	Edit=None  mask='XX:XX' show=false</C>
                                                 <C> name='��ǰ'        	ID='GOODS_NM'       width=90 	align=left 		Edit=None suppress=2 </C>
                                                 <C> name='��û����ȣ'  	ID='ACCEPT_NO'      width=110 	align=left 		Edit=None suppress=3 mask='XXXXX-XXXXXX-XXX'</C>
                                                 <C> name='����'        	ID='CUST_NM'        width=70 	align=left 		Edit=None			 SubSumText=�Ұ�</C>
                                                 <C> name='�ο�'  	     	ID='pplcnt'			width=40 	align=right		Edit=None show=true</C>
                                                 <C> name='��������'       	ID='regi_yn_t_name' width=60 	align=CENTER	Edit=None show=false</C>
                                                 <C> name='�������'    	ID='STATUS_CD'      width=60 	align=left 		Edit=None</C>
                                                 <C> name='����/����'   	ID='COMPANY_NM'     width=130 	align=left 		Edit=None show=false</C>
                                                 <C> name='�ֹε�Ϲ�ȣ'	ID='MANAGE_NO'      width=100 	align=CEMTER	Edit=None</C>
                                                 <C> name='��°�'      	ID='ADDRESS1'       width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='������'      	ID='M_CUST_NM'      width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='����'        	ID='JOIN_CD'        width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='��/��'       	ID='CLASS'       	width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='��û����'   		ID='A_ROOM_TYPE_CD' width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='Ȯ������'    	ID='ROOM_TYPE_CD'   width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='ROOM'        	ID='ROOM_NO'        width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='�Ǹűݾ�'    	ID='TOT_TOUR_AMT'   width=80 	align=right 	Edit=None dec=0</C>
                                                 <C> name='�Աݾ�'      	ID='TOT_PAY_AMT'    width=80 	align=right 	Edit=None dec=0</C>
                                                 <C> name='����ó(����)'	ID='TEL_NO'       	width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='����ó(�ڵ���)'	ID='MOBILE_NO'      width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='������'   		ID='CUST_GU'        width=60 	align=CENTER	Edit=None show=false</C>
                                                 <C> name='��������'   		ID='COUNTRY_GU'     width=60 	align=CENTER	Edit=None show=false</C>
                                                 <C> name='�������'   		ID='SAUP_GU'        width=100 	align=left		Edit=None show=false</C>
                                                 <C> name='��'   			ID='CLASS'       	width=70 	align=left		Edit=None show=false</C>
                                                 <C> name='��'   			ID='TEAMS'        	width=30 	align=CENTER 	Edit=None show=false</C>
                                                 <C> name='��������ȣ'  	ID='TOUR_NO'	    width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='���Ϻι�ȣ'  	ID='UNITY_NO'   	width=90 	align=CENTER 	Edit=None show=false</C>
                                                 <C> name='��ġ��'   		ID='EMPNM'        	width=70 	align=left 		Edit=None show=false</C>
                                                 <C> name='�Է���'   		ID='I_EMPNM'        width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='������'   		ID='U_EMPNM'        width=100 	align=left 		Edit=None show=false</C> 
												 <C> name='�湮Ƚ��'		ID='north_cnt'		width=60	align=right 	show=true dec=0 show=false</C>
		                                         <C> name='��������'       	ID='arrive_date' 	width=60 	align=CENTER	Edit=None show=false</C>
		                                         <C> name='���ͽð�'       	ID='arrive_time' 	width=60 	align=CENTER	Edit=None show=false</C>												
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

