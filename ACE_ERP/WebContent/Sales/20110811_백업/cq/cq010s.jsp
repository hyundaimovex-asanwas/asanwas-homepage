<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : �̸����
 * ���α׷�ID 	 : CQ010S
 * J  S  P		 : cq010s
 * �� �� ��		 : Cq010S
 * �� �� ��		 : ������
 * �� �� ��		 : 2006-07-06
 * �������		 : �̸���� ��ȸ,����
 * ��������		 : �˻����� ����
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.add(java.util.Calendar.DATE, +10);         
   String firstday = m_today.format(date.getTime());		   
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
        var v_job = "H";
        var div='';
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		txt_depart_date.text='<%=firstday%>';
		fnInit();
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>"; 

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //�����ڵ�

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( txt_depart_date.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";
	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
        	            + "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
        	            + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
        	            + "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
        				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
        	            + "sDepartDate=" + txt_depart_date.text;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq010S",
	            "JSP(O:DS1=ds1)",
	            v_param);
	        tr_post(tr1);
	    }
    }
	/*
	 * ���ð�, ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
		            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
		  			+ "sDepartDate=" + txt_depart_date.text;
	
		ln_TRSetting(tr2, 
		      "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		      "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
		      v_param);
		tr_post(tr2);
	}	
	/*
	 * ����ȸ
	 */		
	function fnSelectDs6() {
		
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
                    + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
        			+ "sDepartDate=" + txt_depart_date.text + ","	            
        			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
                    + "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index);
	                    		
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds6)",
            v_param);
        tr_post(tr3);
	}	  

	/*
	 * �� ��ȸ
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
        			  + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
                    + "sDepartDate=" + txt_depart_date.text + ","	
                    + "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index) + ","    
                    + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","    
                    + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds7)",
            v_param);
        tr_post(tr4);
	}		
		
	/*
	 * ����
	 */
	function fnApply() {

	}
	/*
	 * ���
	 */
	function fnCancel() {

	}
	/*
	 * ��������
	 */
	function fnEraser() {

	}
	
	/*
	 * ����Ʈ
	 */
	function fnPrint() {
        v_job = "S";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
        			+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
        			+ "sDepartDate=" + txt_depart_date.text + ","
        			+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
        			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
        			+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
        			+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index);
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq010S",
            "JSP(O:DEFAULT=ds9)",
            v_param);
        tr_post(tr1);
    }


	function fnExcel() {
		if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:�̸����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("�̸����","�̸����.xls", 8);
	}
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=txt_depart_date event=OnKillFocus()>
		if ( div != 'init' ) {	//�������
			if ( txt_depart_date.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>
	<script language=JavaScript for=drp_saup_sid event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	<script language=JavaScript for=drp_goods_sid event=OnSelChange()>
		if ( div != 'init' ) {	//��ǰ 
			div = 'init';
			fnSelectDs6();		
		}
	</script>	
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
		if ( div != 'init' ) {	//��
			div = 'init';				
			fnSelectDs7();		
		}
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
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        document.all.LowerFrame.style.visibility="hidden";	                	
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
//	fnSelectDs6();
</script>


<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)"> 
	fnSelectDs6();
</script>



<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
</script>

<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	pr1.PreView();
</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <table border="0" width="840px"  cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right" colspan="2">
                        <table border="0"  cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="right" height="30px">        
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand" align=absmiddle onclick="fnPrint()">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onClick="fnExcel();">
                                </td>
                            </tr>   
                        </table>
                    </td>                                           
                </tr>
                <tr>
                    <td align="left"  colspan='2' width="845px">
                        <table width="840px" border="0"  cellspacing="0" cellpadding="0" >
                            <tr> 
                                <td  width="840px">
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                        <tr bgcolor="#6f7f8d">
                                            <td align="center" width="80px" class="text">����</td>
                                            <td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds2>
                                                    <param name=SearchColumn    value="saup_nm">
                                                    <param name=ListExprFormat  value="saup_nm^0^200">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                                &nbsp;</nobr>
                                            </td>
                                            <td align="center" width="80px" class="text">�������</td>
                                            <td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=txt_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>            
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                    <param name=SelectAll   value=true>
                                                    <param name=SelectAllOnClick      value=true>
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>&nbsp;
                                                <object id=drp_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds3>
                                                    <param name=SearchColumn    value="depart_time_nm">
                                                    <param name=ListExprFormat  value="depart_time_nm^0^200">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                                &nbsp;</nobr>
                                            </td>
                                            <td align="center" width="80px" class="text" >��ǰ����</td>
                                            <td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=drp_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds4>
                                                    <param name=SearchColumn    value="goods_nm">
                                                    <param name=ListExprFormat  value="goods_nm^0^200">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                                &nbsp;</nobr>
                                            </td>
                                            <td align="center" width="80px" class="text">��/��</td>
                                            <td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds6>
                                                    <param name=SearchColumn    value="class_nm">
                                                    <param name=ListExprFormat  value="class_nm^0^200">
                                                </object>
                                                <object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds7>
                                                    <param name=SearchColumn    value="teams_nm">
                                                    <param name=ListExprFormat  value="teams_nm^0^200">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                                &nbsp;</nobr>
                                            </td>                                                                               
                                        </tr>
                                    </table>
                                </td>
                            </tr>                                                           
                        </table>    
                    </td>                                           
                </tr>
                <tr> 
                    <td height='5px'></td>
                </tr>                                               
                <tr>
                    <td width="840px" colspan='2'>
                        <table  border="0" cellpadding="0" cellspacing="0">
                            <tr valign="top"">
                                <td align="left" width="840px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=840px; height:450px" border="1">
                                        <param name="DataID"            value="ds1">
                                        <param name="BorderStyle"       value="0">
                                        <!-- param name="Fillarea"          value="true"-->
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                         <param name=ViewSummary     value=1>
                                        <param name="Format"            value=" 
                                         <C> name='������'         ID='TOUR_NO'            Width=40  align=center edit=none SumText='�Ѱ�'</C>
                                            <C> name='��'           ID='CLASS'              Width=60  align=center edit=none		</C>
                                            <C> name='��'           ID='TEAMS'           Width=60  align=center edit=none SumText=@count</C>
                                            
                                            <C> name='����'         ID='CUST_NM'          Width=100  align=center edit=none</C>
                                            <C> name='����'       ID='SEX'                Width=60  align=center edit=none</C>
                                            <C> name='�������'     ID='BIRTHDAY'           Width=75  align=center edit=none mask=XXXX.XX.XX</C>
                                            <C> name='����/����'    ID='COMP_NM'            Width=100  align=left edit=none</C>
                                            <C> name='��°�'       ID='ADDRESS1'           Width=145  align=Left edit=none</C>
                                            <C> name='����'    ID='COUNTRY_CD'         Width=50  align=left edit=none</C>
                                              <C> name='����'    ID='NATION_CD'         Width=50  align=left edit=none</C>
                                            <C> name='���ǹ�ȣ'     ID='PASS_NO'            Width=100  align=center edit=none</C>
                                            <C> name='�������' 	ID='STATUS_CD'			   Width=100  align=center edit=none</C>
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

<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds9">
		<PARAM NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
 		<param NAME="SuppressColumns" 	    VALUE="1:pageskip,page_skip">
		<PARAM NAME="Format"                value="
<B>id=Header ,left=0,top=0 ,right=2001 ,bottom=306 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�Ⱓ :' ,left=1398 ,top=235 ,right=1506 ,bottom=295 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='depart_date', left=1503, top=235, right=1717, bottom=295 ,mask='XXXX.XX.XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='~' ,left=1714 ,top=235 ,right=1743 ,bottom=295 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='goods_nm', left=158, top=237, right=513, bottom=295, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��ǰ�� :' ,left=26 ,top=237 ,right=161 ,bottom=295 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='doc_title', left=687, top=79, right=1322, bottom=161, face='����', size=16, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1740, top=235, right=1943, bottom=295 ,mask='XXXX.XX.XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=79 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1951 ,top=0 ,right=24 ,bottom=0 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=79 </L>
	<L> left=79 ,top=0 ,right=79 ,bottom=79 </L>
	<L> left=171 ,top=0 ,right=171 ,bottom=79 </L>
	<T>id='��' ,left=90 ,top=13 ,right=161 ,bottom=69 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=224 ,top=0 ,right=224 ,bottom=79 </L>
	<T>id='��' ,left=37 ,top=13 ,right=71 ,bottom=69 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=303 ,top=13 ,right=519 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=182 ,top=13 ,right=216 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=658 ,top=0 ,right=658 ,bottom=79 </L>
	<T>id='�������' ,left=674 ,top=13 ,right=821 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=829 ,top=0 ,right=829 ,bottom=79 </L>
	<L> left=1951 ,top=0 ,right=1951 ,bottom=79 </L>
	<L> left=1793 ,top=0 ,right=1793 ,bottom=79 </L>
	<T>id='����/����' ,left=1619 ,top=13 ,right=1785 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ǹ�ȣ' ,left=1806 ,top=13 ,right=1940 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1609 ,top=0 ,right=1609 ,bottom=79 </L>
	<T>id='��°�' ,left=1356 ,top=13 ,right=1601 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1345 ,top=0 ,right=1345 ,bottom=79 </L>
	<T>id='���� / ����' ,left=845 ,top=13 ,right=1335 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1951 ,top=79 ,right=24 ,bottom=79 </L>
	<L> left=579 ,top=0 ,right=579 ,bottom=79 </L>
	<T>id='����' ,left=579 ,top=13 ,right=661 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=108 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=26 ,bottom=105 </L>
	<L> left=79 ,top=0 ,right=79 ,bottom=105 </L>
	<L> left=171 ,top=0 ,right=171 ,bottom=105 </L>
	<L> left=224 ,top=0 ,right=224 ,bottom=108 </L>
	<L> left=579 ,top=0 ,right=579 ,bottom=108 </L>
	<L> left=658 ,top=0 ,right=658 ,bottom=108 </L>
	<L> left=829 ,top=0 ,right=829 ,bottom=108 </L>
	<L> left=1345 ,top=0 ,right=1345 ,bottom=108 </L>
	<L> left=1609 ,top=0 ,right=1609 ,bottom=108 </L>
	<L> left=1793 ,top=0 ,right=1793 ,bottom=108 </L>
	<L> left=1951 ,top=0 ,right=1951 ,bottom=105 </L>
	<C>id='tour_no', left=26, top=26, right=82, bottom=82, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class', left=79, top=26, right=174, bottom=82, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='teams', left=171, top=26, right=226, bottom=82, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm2', left=237, top=8, right=571, bottom=55, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='sex', left=579, top=26, right=661, bottom=82, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=658, top=26, right=835, bottom=82 ,mask='XXXX.XX.XX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=1356, top=26, right=1601, bottom=82, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_nm2', left=845, top=5, right=1335, bottom=55, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=237, top=53, right=669, bottom=100, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_nm1', left=845, top=26, right=1335, bottom=82, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm1', left=237, top=26, right=669, bottom=82, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='pass_type', left=1793, top=5, right=1956, bottom=55, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='country_cd', left=1619, top=5, right=1785, bottom=53, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nation_cd', left=1619, top=50, right=1785, bottom=100, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_enm', left=845, top=53, right=1753, bottom=100, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1951 ,top=105 ,right=24 ,bottom=105 </L>
	<C>id='pass_no', left=1793, top=53, right=1993, bottom=100, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2815 ,right=2001 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='- #p -' ,left=871 ,top=13 ,right=1085 ,bottom=55</T>
</B>

	">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


