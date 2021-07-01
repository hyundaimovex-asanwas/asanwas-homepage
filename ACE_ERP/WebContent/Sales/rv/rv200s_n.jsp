<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ����������Ȳ(plz)
 * ���α׷�ID   : RV200S_N
 * J  S  P      : rv200s_N
 * �� �� ��        : Rv200S_N
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-14
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-04-15][�ڰ汹] PLZ ����������Ȳ.
 * [2009-11-17][�ɵ���] �丮������ ���� ���ǹ�ȣ, ���Ǹ�����,����(����)
 * [2009-12-24][�ɵ���] �Ǹűݾ� �� ������� | �ɼǿ�� �и� ^^
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
    
    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
    <script language=javascript src="<%=dirPath%>/Sales/common/js/rv200i.js"></script>
    
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
	        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=S&s_UseYn=Y";
	        ds_saup.Reset(); //�����ڵ�	        
	        
            ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y";
            ds_status.Reset();	//�������
        
            v_fr_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
            v_to_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
            
           
            fnInit2();
           
        }
     
         
        <%// ��/ ����/ ��� ��ȸ%>
        function fnInit2() {
        	  ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
            "JSP(O:NATION=initds2,O:CUST=initds1,O:SAUP=initds3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=2");
       		 tr_post(tr2);
       	}
        
         
    
        
    
        <%//���� ��ȸ pr_rv200s_01_plz ȣ�� %>
        function fnSelect() {
            var fr_date = v_fr_depart_date.Text.trim();
            var to_date = v_to_depart_date.Text.trim();
            if(fr_date.length!=8) {
                alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }
            if(to_date.length!=8) {
                alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }
        
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
                      + ",v_client_sid=" + v_client_sid.value
                      + ",v_event_sid=" + v_event_sid.value
                      + ",v_fr_depart_date=" + v_fr_depart_date.Text
                      + ",v_to_depart_date=" + v_to_depart_date.Text
                      + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index)
                      + ",v_accept_no=" + v_accept_no.Text
                      + ",v_cust_nm=" + v_cust_nm.value
                      + ",v_manage_no=" + v_manage_no.value
                      + ",v_cust_gu=" + lc_cust_gu.ValueOfIndex("detail", lc_cust_gu.Index)
                      + ",v_country_gu=" + lc_country_gu.ValueOfIndex("detail", lc_country_gu.Index)
                      + ",v_saup_gu=" + lc_saup_gu.ValueOfIndex("detail", lc_saup_gu.Index)
					  + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index);
            //alert(param);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv200S_N",
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

        /**
         * �˻����� �븮��  �˾� 
         */
        function fnSelClientPopup(dirPath, servletPath) {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            arrResult = fnClientPop(dirPath,'1');
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                v_client_sid.value = arrParam[0];
                v_client_nm.value = arrParam[1];
                v_client_cd.value = arrParam[2];
            } else {
                v_client_sid.value = "";
                v_client_nm.value  = "";
                v_client_cd.value = "";
            }               
        }

        // ��û�� ��ȣ ��ȸ
        function fnAcceptNoPopup(dirPath, servletPath){
            v_cust_row = 0;
            var arrResult   = new Array();
            arrResult = fnAcceptNoPop(dirPath);
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                getObjectFirst("v_accept_sid").value = arrParam[0];
                getObjectFirst("v_accept_no").Text   = arrParam[1];
                
                fnSelectBound();
            }
        }

		//��ǰ����
		function fnSelectBound(){
		
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                      + ",v_accept_no=" + v_accept_no.Text;
        	//alert(param);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv200S_N",
                "JSP(O:DS_BOUND=ds_bound)",
                param);
               
            tr_post(tr1);
        }
	      
	    		
		//��ǰ��ȸ
		function fnSelectGoodsLC() {
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
	            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				+ ",sDepartDate=";
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_GOODS_DS=ds_goods)",
	            param);
	        tr_post(tr2);
		};
        </script>
        
       
        
        

<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>
	
	<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
		fnSelectBound();
	</script>
	
	<script language=JavaScript for=v_fr_depart_date event=OnKillFocus()>
	   if( v_fr_depart_date.Modified == true )
			v_to_depart_date.text = v_fr_depart_date.text;
	</script>	

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//��ǰ ��˻�
	</script>	
	
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
    
    <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
 		ds_bound.insertrow(1);
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SID") = "";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "��ü";     
		
		v_bound.Index = 0; 
    </script>
    

    <script language="javascript" for="tr1" event="onsuccess()">
        msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
    </script>   
    
    
    <script language="javascript" for="tr1" event="OnFail()">
        //document.all.LowerFrame.style.visibility="hidden";
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
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ�ڵ� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ���� -->
    <param name="SyncLoad"  value="True">
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
            <td align='right'>
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
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                            <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                                <tr>
                                    <td class="text" width="50">�븮��</td>
                                    <td bgcolor="#FFFFFF" WIDTH="180">&nbsp;<input type="text" value="<%=c_cd%>" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
                                        <input type="hidden" value="<%=c_sid%>" name='v_client_sid' id='v_client_sid'>
                                        <%if(v_ut.equals("")){%>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                                        <%}%>
                                        <input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:70px;" class='input01' readOnly>
                                    </td>
                                    <td class="text" width="70">��û����ȣ</td>
                                    <td bgcolor="#FFFFFF" WIDTH="140">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
											<param name=Format      value="00000-000000000">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                            <param name=Enable      value=true>
                                            <param name=SelectAll   value=true>
                                            <param name=SelectAllOnClick      value=true>
                                            <param name=SelectAllOnClickAny   value=false>
                                        </object>
                                        <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn">
                                    </td>
                                    <td align=left class="text" width="60">��ǰ����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_bound classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=70 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_bound>
                                            <param name=BindColumn      value="BOUND_SID">
                                            <param name=BindColVal      value="BOUND_SID">
                                            <param name=ListExprFormat  value="BOUND_SEQ^0^70">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td width="50" height="25" class="text" >��ü���</td>
                                	<td width="200" colspan="4" bgcolor="#FFFFFF">&nbsp;<input name="v_event_no" id="v_event_no" type="text" style="width:60px;" class="input01" readOnly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer;display:" id="v_event_btn" onclick="fnGroupPopup('<%=dirPath%>');">
                                    <input type=hidden name="v_event_sid" id="v_event_sid">
                                    <input name="v_event_nm" type="text" style="width:80px;" class="input01" readOnly>
                                    </td>  
                                </tr>
                            </table>
                    	</td>
                    </tr>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
			                        <td align=left class="text"  width="70">�������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object> ~ 
			                            <object id=v_to_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>                                                                                           
                    				<td align=left class="text" width="100">����</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_saup>
			                                <param name=BindColumn      value="saup_sid">
			                                <param name=BindColVal      value="saup_sid">
			                                <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
			                                <param name=ListExprFormat  value="saup_nm^0^120">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>   
			                        <td align=left class="text" width="100">��ǰ����</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_goods>
			                                <param name=ListExprFormat  value="goods_nm^0^150"></object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>
                    			</tr>
                    		</table>
                    	</td>
                    </tr>
                    <tr height=25>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                    				 <td align=left class="text" width="70">�������</td>
                                     <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=185 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_status>
                                            <param name=ListExprFormat  value="detail_nm^0^70">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td align=left class="text" width="100px">����/��/���</td>
                    				  <td bgcolor="#ffffff">&nbsp;
			                        	<%=HDConstant.COMMENT_START%>
											<object id=lc_country_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=initds2>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>	&nbsp;
                    				    <%=HDConstant.COMMENT_START%>
										<object id=lc_cust_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=initds1>
	                                        <param name=BindColumn      value="detail">
	                                        <param name=BindColVal      value="detail">
											<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>&nbsp;
										<%=HDConstant.COMMENT_START%>
                                        <object id=lc_saup_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=initds3>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
			                        </td>
			                	</tr>
                    		</table>
                    	<tr height=25>
                    <td>
                    	<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    		<tr>
                			<td align=left class="text" width="70">����</td>
	                        <td align=left bgcolor="#ffffff" >&nbsp;
		                       	<input type="text" name="v_cust_nm" size="15" maxlength="10" width=158 class="textbox" OnKeyUp="cfLengthCheck(this, 10);">
			              	</td>
				            <td align=left class="text" width="100px">�ֹ�/���ǹ�ȣ</td>
			             	<td align=left bgcolor="#ffffff" >&nbsp;<input type="text" name="v_manage_no" size="15" maxlength="13" class="textbox" OnKeyUp="cfLengthCheck(this, 15);">
			             	</td>
			     	</td>
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
                                                 <C> name='�븮��'		ID='CLIENT_NM'		width=90	align=left 		Edit=None suppress=1</C>
                                                 <C> name='�������'    	ID='DEPART_DATE'    width=70 	align=CENTER	Edit=None suppress=2</C>
                                                 <C> name='��߽ð�'    	ID='DEPART_TIME'	width=60 	align=center	Edit=None suppress=3 mask='XX:XX'</C>
                                                 <C> name='��ǰ'        	ID='GOODS_NM'       width=90 	align=left 		Edit=None suppress=4</C>
                                                 <C> name='��û����ȣ'  	ID='ACCEPT_NO'      width=100 	align=left 		Edit=None suppress=5 mask='XXXXX-XXXXXX-XXX'</C>
                                                 <C> name='����'        	ID='CUST_NM'        width=70 	align=left 		Edit=None			 SubSumText=�Ұ�</C>
                                                 <C> name='�ο�'  	     	ID='pplcnt'			width=40 	align=right		Edit=None</C>
                                                 <C> name='��������'       	ID='regi_yn_t_name' width=70 	align=CENTER	Edit=None</C>
                                                 <C> name='�������'    	ID='STATUS_CD'      width=60 	align=left 		Edit=None</C>
                                                 <C> name='����/����'   	ID='COMPANY_NM'     width=130 	align=left 		Edit=None</C>
                                                 <C> name='�ֹε�Ϲ�ȣ'	ID='MANAGE_NO'      width=100 	align=CEMTER	Edit=None</C>
                                                 <C> name='��°�'      	ID='ADDRESS1'       width=100 	align=left 		Edit=None</C>
                                                 <C> name='������'      	ID='M_CUST_NM'      width=60 	align=left 		Edit=None</C>
                                                 <C> name='����'        	ID='JOIN_CD'        width=60 	align=left 		Edit=None</C>
                                                 <C> name='��/��'       	ID='CLASSTEAMS'       	width=60 	align=left 		Edit=None</C>
                                                 <C> name='��û����'   	ID='A_ROOM_TYPE_CD' width=60 	align=left 		Edit=None</C>
                                                 <C> name='Ȯ������'    	ID='ROOM_TYPE_CD'   width=60 	align=left 		Edit=None</C>
                                                 <C> name='ROOM'        ID='ROOM_NO'        width=60 	align=left 		Edit=None</C>
                                                 <C> name='�������'    	ID='TOT_TOUR_AMT'   width=80 	align=right 	Edit=None decao=0</C>
                                                 <C> name='�ɼǿ��'    	ID='TOT_OPT_AMT'   width=80 	align=right 	Edit=None decao=0</C>
                                                 
                                                 <C> name='�����Ա�'      	ID='TOT_PAY_AMT'    width=80 	align=right 	Edit=None decao=0</C>
                                                 <C> name='�ɼ��Ա�'      	ID='OPT_PAY_AMT'    width=80 	align=right 	Edit=None decao=0</C>
                                                 <C> name='����ó(����)'	ID='TEL_NO'       	width=100 	align=left 		Edit=None</C>
                                                 <C> name='����ó(�ڵ���)'	ID='MOBILE_NO'      width=100 	align=left 		Edit=None</C>
                                                 <C> name='������'   	ID='CUST_GU'        width=60 	align=CENTER	Edit=None</C>
                                                 <C> name='��������'   	ID='COUNTRY_GU'     width=60 	align=CENTER	Edit=None</C>
                                                 <C> name='�������'   	ID='SAUP_GU'        width=100 	align=left		Edit=None</C>
                                                 <C> name='��'   		ID='CLASS'       	width=70 	align=left		Edit=None</C>
                                                 <C> name='��'   		ID='TEAMS'        	width=30 	align=CENTER 	Edit=None</C>
                                                 <C> name='��������ȣ'  	ID='TOUR_NO'	    width=100 	align=left 		Edit=None</C>
                                                 <C> name='���Ϻι�ȣ'  	ID='UNITY_NO'   	width=90 	align=CENTER 	Edit=None</C>
                                                 <C> name='��ġ��'   		ID='EMPNM'        	width=70 	align=left 		Edit=None</C>
                                                 <C> name='�Է���'   		ID='I_EMPNM'        width=100 align=left Edit=None</C>
                                                 <C> name='������'   		ID='U_EMPNM'        width=100 align=left Edit=None</C> 
												 <C> name='�湮Ƚ��'			ID='north_cnt'		width=60	align=right show=true dec=0</C>
		                                         <C> name='��������'       ID='arrive_date' 	width=60 	align=CENTER	Edit=None</C>
		                                         <C> name='���ͽð�'       ID='arrive_time' 	width=60 	align=CENTER	Edit=None</C>
		                                         <C> name='������'     	   ID='last_nm' 	width=60 	align=CENTER	Edit=None</C>
		                                         <C> name='�����̸�'       ID='first_nm' 	width=60 	align=CENTER	Edit=None</C>
		                                         <C> name='���ǹ�ȣ'       ID='pass_no' 	width=60 	align=CENTER	Edit=None</C>
		                                         <C> name='���Ǹ���'       ID='pass_expire_date' 	width=60 	align=CENTER	Edit=None</C>
                                         ">                             
                                        </object>   
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                �� <b>�� ���̶� �Է�</b>�Ǿ�� �ش� ��ǰ�� ��ǰ���� <b>�˻� ���ǿ� ��Ÿ���ϴ�</b>.
            </td>
        </tr>
    </table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

