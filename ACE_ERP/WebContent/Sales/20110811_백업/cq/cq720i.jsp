<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ���԰��� �Է�
 * ���α׷�ID   : CQ720I
 * J  S  P      : cq720i
 * �� �� ��     : Cq720I
 * �������     : �԰� ó�� / ���԰��� �Է�
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-08-24][�ɵ���] ü����Ȳ, ü������ ������Ʈ�� �� ���� ��
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
	//date.set(java.util.Calendar.HOUR_OF_DAY, 120);
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
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit(); 
	}
    
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        v_arrive_date.Text='<%=firstday%>';
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //�����ڵ�
        ds_status1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_Item1=Y&s_Item3=Y";
        ds_status1.Reset();	//�������-�԰汸�п�
        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_Item1=Y&s_Item3=Y";
        ds_status.Reset();	//�������

    }


	//�԰�ð� ��ȸ     
    function fnSelectLcArTime() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                    + ",sArriveDate=" + v_arrive_date.Text;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_ARRIVE_TIME_DS=ds_ar_time)",
            param);
        tr_post(tr1);
    }   


	//��ǰ��ȸ
	function fnSelectLcGoods() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
				+ ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				+ ",sDepartDate=";	//�԰����� �����̶� �н�
		ln_TRSetting(tr3, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		    "JSP(O:S_GOODS_DS=ds_goods)",
		    param);
		tr_post(tr3);
	};    
    
    

    function fnSelect() {
        if(v_arrive_date.Text.trim()=="" || v_arrive_date.Text.trim().length!=8){
            alert("�԰����� <%=HDConstant.A_MSG_MUST_INPUT%>");
            return;
        }
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ", v_saup_sid="+ ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ", v_arrive_date="+ v_arrive_date.Text
                    + ", v_arrive_time="+ lc_ar_time.ValueOfIndex("detail", lc_ar_time.Index)
                    + ", v_goods_sid="	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
                    + ", v_cust_nm="	+ v_cust_nm.value
                    + ", v_manage_no="	+ v_manage_no.Text
                    + ", v_out_gubn="	+ v_out_gubn.value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq720I",
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
    }

    function fnApply() {
        if (ds1.IsUpdated) {
            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq720I",
                "JSP(I:DEFAULT=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
        }
    }
</script>

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
	    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>	
	<script language="javascript" for="tr1" event="onfail()">
	    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
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

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectLcGoods();
		fnSelectLcArTime();
	</script>	

	<script language=JavaScript for=v_arrive_date event=OnKillFocus()>
		if ( v_arrive_date.Modified ) {
			fnSelectLcArTime();			
		}
	</script>

	<script language=JavaScript for=ds_status1 event="OnLoadCompleted(row)">
		ds_status1.DeleteRow(4);
		ds_status1.DeleteRow(2);
		ds_status1.DeleteRow(1);	//���, �԰� ���� �� �����.
	</script>





<script language=JavaScript for=gr1 event=OnClick(Row,Colid)> <!-- Grid Event -->
    if(ds1.CountRow==0)
        return;
        
    if(Row==0 && Colid=="JOB_SEL"){
        for(var i=1; i<=ds1.CountRow; i++){
            ds1.NameValue(i, "JOB_SEL") = ds1.NameValue(1, "JOB_SEL");
        }
    }
</script>

<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �԰�ð� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ(��) -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//�������-��汸�п�%>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//�������-��汸�п�%>
    <param name="SyncLoad"  value="False">
</object>



<object id=ds_ban classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��   -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_jo classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��   -->
    <param name="SyncLoad"  value="False">
</object>
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
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td>
                <table border='0' cellpadding="0" cellspacing="0" width="845"> 
                    <tr>
                        <td align=right>
                            <table width='845'>
                                <tr>
                                    <td align=right>
                                        <img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:hand" align=absmiddle onclick="fnSelect()">       <!-- ��ȸ -->
                                        <img src="<%=dirPath%>/Sales/images/save.gif"       style="cursor:hand" align=absmiddle onClick="fnApply()">        <!-- ���� -->
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr height="10px">
                        <td></td>
                    </tr>
                    <tr height="30px">
                        <td width=845>
                            <table border='0' cellpadding="0" cellspacing="1" width="845" bgcolor="#666666">
                                <tr height='30px'>
                                    <td align=left class="text">����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                                     
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=BindColumn      value="saup_sid">
                                            <param name=BindColVal      value="saup_sid">
                                            <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                            <param name=ListExprFormat  value="saup_nm^0^80">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>   
                                    <td align=left class="text">�԰�����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=v_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Text                value="">
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="0000-00-00">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=ReadOnly            value="false">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>&nbsp;

				                        <object id=lc_ar_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle >
											<param name=ComboDataID		value=ds_ar_time>
											<param name=BindColumn      value="detail">
				                            <param name=BindColVal      value="detail">
											<param name=EditExprFormat	value="%,%;detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^40">
										</object>                                        
                                        <%=HDConstant.COMMENT_END%>                                                                             
                                    </td>                                                                                           
                                    <td align=left class="text">��ǰ(���)</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;                                                                                         
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_goods>
                                            <param name=BindColumn      value="goods_sid">
                                            <param name=BindColVal      value="goods_sid">
                                            <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                            <param name=ListExprFormat  value="goods_nm^0^130">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>&nbsp;   
                                    </td>
                                </tr>
                                <tr>
                                    <td align=left class="text">�̸�</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <input type=text name="v_cust_nm" id="v_cust_nm" size=13 MaxLength="18" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                                    </td>
                                    <td align=left class="text">�ֹ�/���ǹ�ȣ</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=v_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                            <param name=Format      value="0000000000000">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                            <param name=MaxLength   value="13">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td align=left class="text">�԰汸��</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <select name="v_out_gubn" id="v_out_gubn" class="textbox">
                                            <option value="">��ü
                                            <option value="Y">�԰�
                                            <option value="N">���
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="10px"><td></td></tr>
        <tr>
            <td colspan=2>
                <table border='0' cellpadding="0" cellspacing="0" width="845"> 
                    <tr>
                        <td width='845'>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='380px' border='1'>
                                <param name="DataID"        value="ds1">
                                <param name="ColSizing"     value="true">
                                <param name="Fillarea"      value="false">
                                <param name="Editable"      value="true">
                                <param name="BorderStyle"   value="0">
                                <param name=SortView        value="Right">
                                <param name="SuppressOption"    value="1">
                                <Param Name="AllShowEdit"   value="True">
                                <Param Name="UsingOneClick"   value="1">
                                <Param Name="ViewSummary"   value="1">
                                <param name="Format"            value="
                                    <C> name='�԰汸�С�'         ID='JOB_SEL'    width=80 align=Center EditStyle=lookup data='ds_status1:detail:detail_nm' SumText='�ѰǼ�'</C>
                                    <C> name='�������'          ID='STATUS_CD'  width=60 align=Center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' EditStyle=lookup data='ds_status:detail:detail_nm' SumText=@count </C>
                                    <C> name='�������' 		 ID='DEPART_DATE' width=60 align=CENTER Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' </C>
                                    <C> name='���ð�'          ID='DEPART_TIME' width=60 align=CENTER eft Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' </C>
                                    <C> name='��'                ID='CLASS'      width=60 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'  </C>
                                    <C> name='��'                ID='TEAMS'      width=60 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                    <C> name='��û����ȣ'        ID='ACCEPT_NO'  width=100 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' Mask='XXXXX-XXXXXXXXX'</C>
                                    <C> name='����'              ID='CUST_NM'    width=100 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' Sort='True'</C>
                                    <C> name='���԰� ������'   ID='REMARKS'    width=200 align=left Edit=Any EditLimit='24'</C>
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

