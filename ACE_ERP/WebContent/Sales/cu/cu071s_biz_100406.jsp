<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ������
 * ���α׷�ID 	 : CU072S
 * J  S  P		 : cu072s
 * �� �� ��		 : Cu072S
 * �� �� ��		 : ����ǥ
 * �� �� ��		 : 2006-06-16
 * �������		 : ��ϱ��� ����� ��� (��ȸ,����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-05-15][�ɵ���] �˻� ���� �߰� (��������, �۾�����)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
	String firstday = m_today.format(date.getTime()).substring(0,8);
	
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
       
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε�
// Parameter 	:
%>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit();
		}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ
// Parameter 	:
%>
	function fnInit(){
           v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //�����ڵ�
 		ds3.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU016";
		ds3.Reset(); //��ϸ���		
		ds4.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU015";
		ds4.Reset(); //����۾�����
   
   
/*        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071S",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);*/
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	:
%>
    function fnSelect() {
    	if(sEducPlanDt.text=="        "){
    		alert("������û���ڸ� �Է����ּ���.")
    		sEducPlanDt.focus();
    		return;
    	};
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
            	  + ",sSaupSid="  + drp_saup.ValueOfIndex("saup_sid", drp_saup.Index)
           	   	  + ",sEducPlanDt=" + sEducPlanDt.text
				  + ",sVisitObjCd=" + drp_visit_object.ValueOfIndex("detail", drp_visit_object.Index)	// ��ϸ����ڵ�
				  + ",sNJobGu=" + drp_n_job_gu.ValueOfIndex("detail", drp_n_job_gu.Index)	// ��ϸ����ڵ�				  
           	   	  ;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071S",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description : ����
%>
    function fnExcel() {
        if(ds1.RowCount==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�湮���߱޽�û��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�湮���߱޽�û��", "�湮���߱޽�û��.xls", 8);
    }
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    

		</script>	    
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        document.all.LowerFrame.style.visibility="hidden";
        if(v_job=="I") {
            window.status = "������ �Ϸ� �Ǿ����ϴ�.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "������ �����Ͽ����ϴ�.";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert(row + " �˻��� ����Ÿ�� �����ϴ�."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") { sEducPlanDt.value=ds1.namevalue(row,"educ_plan_dt"); return; }
    if( row < 1){
        alert(row + " �˻��� ����Ÿ�� �����ϴ�."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds21 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- ��ϸ������� -->
	<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- �۾����� -->		
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="845" border=0 cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width=700 border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td height="30px" class="text">������û����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;																						
							     <%=HDConstant.COMMENT_START%><object id=sEducPlanDt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align='absmiddle' class="textbox">			
									<param name=Text 		value="<%=firstday%>">
									<param name=Alignment 	value=1>
									<param name=Format 		value="0000-00-00">
									<param name=Cursor	 	value="iBeam">
									<param name=Border	 	value="0">		
									<param name=InheritColor      value="true">																																																				
									<param name=ReadOnly  	value="false">
								</object><%=HDConstant.COMMENT_END%>
							    </td>
            					<td height="30px" class="text">����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;																										
									<%=HDConstant.COMMENT_START%>
            						<object id=drp_saup classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 valign='absmiddle' style="position:relative;left:1px;top:2px" class="txtbox" >
            							<param name=ComboDataID			value=ds2>
            							<param name=SearchColumn		value="saup_nm">
            							<param name=Sort				value="false">
            							<param name=ListExprFormat		value="saup_nm^0^100">
            							<param name=BindColumn			value="saup_sid">
            						</object>
                                    <%=HDConstant.COMMENT_END%>
								</td>
								<td align="center" class="text">��������</td>
								<td bgcolor="#ffffff">&nbsp;
								   <%=HDConstant.COMMENT_START%>
				                    <object id=drp_visit_object classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
									<param name=ComboDataID     value=ds3>
									<param name=SearchColumn    value="detail_nm">
									<param name=ListExprFormat  value="detail_nm^0^140">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>					
								<td align="center" class="text" >�۾�����</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
								   <%=HDConstant.COMMENT_START%>
				                    <object id=drp_n_job_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
				                        <param name=ComboDataID     value=ds4>
				                        <param name=SearchColumn    value="detail_nm">
				                        <param name=ListExprFormat  value="detail_nm^0^100">
				                    </object>
				                    <%=HDConstant.COMMENT_END%>
								</td>
            				</tr>
            			</table>
            		</td>
            		<td width=200 align="right" valign="bottom">
            			<img src="<%=dirPath%>/Sales/images/refer.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnSelect()">
            			<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnExcel()">
            		</td>
            	</tr>
            	<tr>
            		<td height="10"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:440px" border="1">
						<param name="DataID"			value="ds1">
						<param name="ColSizing"			value="true">
						<param name="Fillarea"			value="false">
						<param name="Editable"  		value="false">
						<param name="BorderStyle"       value="0">
						<param name="ViewSummary"       value="1">
						<param name="Format" 			value="
							<C> name='ȸ���'  	  ID='company_nm'       HeadAlign=Center Width=150  align=center sumtext=��</C>
							<C> name='��å'		  ID='positions'  		HeadAlign=Center Width=100  align=center sumtext=@cnt</C>
							<C> name='����'     	  ID='cust_nm'          HeadAlign=Center Width=100  leftmargin=10 sumtext=��</C>
							<C> name='�ֹε�Ϲ�ȣ'	  ID='manage_no'        HeadAlign=Center Width=150  align=center mask='XXXXXX-XXXXXXX'</C>
							<C> name='��ϸ���'  	  ID='visit_object'     HeadAlign=Center Width=200  align=center</C>
						  <G> name='��ϱⰣ'
							<C> name='������'	  ID='visit_fr_dt'      HeadAlign=Center Width=50 	align=center mask='XXXX-XX-XX'</C>
							<C> name='������'	  ID='visit_to_dt'      HeadAlign=Center Width=50 	align=center mask='XXXX-XX-XX'</C>
						  </G>
							<C> name='�������'	  ID='saup_sid'         HeadAlign=Center Width=100 	align=center</C>
							<C> name='�ּ�'	      ID='address1'         HeadAlign=Center Width=150 	leftmargin=10</C>	
							<C> name='�����̼�'	  ID='educ_yn_name'     HeadAlign=Center Width=100 	align=center</C>
							<C> name='����ȭ'	  ID='tel_no'     		HeadAlign=Center Width=100 	align=left</C>
							<C> name='�ڵ���'	  ID='mobile_no'     	HeadAlign=Center Width=100 	align=left</C>
							<C> name='�ѽ�'		  ID='fax_no'     		HeadAlign=Center Width=100 	align=left</C>
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