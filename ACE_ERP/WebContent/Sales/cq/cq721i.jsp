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
 * [2015-10-06][�ɵ���] ���԰� �ð� ����
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
        ds_status1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y&s_item3=Y";
        ds_status1.Reset();	//�������-�԰汸�п�
        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y&s_item3=Y";
        ds_status.Reset();	//�������

        ds_dp_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_item1=Y";
        ds_dp_time.Reset();	//���ð�
        //ds_ar_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
        //ds_ar_time.Reset();	//�԰�ð�

    }


	//�԰�ð� ��ȸ     
    function fnSelectLcArTime() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
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
		msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ", v_saup_sid="+ ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ", v_arrive_date="+ v_arrive_date.Text
                    + ", v_arrive_time="+ lc_ar_time.ValueOfIndex("detail", lc_ar_time.Index)
                    + ", v_goods_sid="	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
                    + ", v_car_no="	+ v_car_no.value
                    + ", v_out_gubn="	+ v_out_gubn.value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq721I",
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
    }

    function fnApply() {
        if (ds1.IsUpdated) {
            msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq721I",
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
	    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>	
	<script language="javascript" for="tr1" event="onfail()">
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
<object id=ds_dp_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���ð� -->
    <param name="SyncLoad"  value="True">
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


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td>
                <table border='0' cellpadding="0" cellspacing="0" width="1002"> 
                    <tr>
                        <td align=right>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:pointer" align=absmiddle onclick="fnSelect()">       <!-- ��ȸ -->
                            <img src="<%=dirPath%>/Sales/images/save.gif"       style="cursor:pointer" align=absmiddle onClick="fnApply()">        <!-- ���� -->
                        </td>
                    </tr>
                    <tr height="10px">
                        <td></td>
                    </tr>
                    <tr height="30px">
                        <td >
                            <table border='0' cellpadding="0" cellspacing="1" width="1002" bgcolor="#666666">
                                <tr height='30px'>
                                    <td align=left class="text">����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                                     
                                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=BindColumn      value="saup_sid">
                                            <param name=BindColVal      value="saup_sid">
                                            <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                            <param name=ListExprFormat  value="saup_nm^0^80">
                                        </object>
                                    </td>   
                                    <td align=left class="text">�԰�����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
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
                                                                                                                     
                                    </td>                                                                                           
                                    <td align=left class="text">��ǰ(���)</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;                                                                                         
                                        
                                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_goods>
                                            <param name=BindColumn      value="goods_sid">
                                            <param name=BindColVal      value="goods_sid">
                                            <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                            <param name=ListExprFormat  value="goods_nm^0^130">
                                        </object>
                                        &nbsp;   
                                    </td>
                                </tr>
                                <tr>
                                    <td align=left class="text"></td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;</td>
                                    <td align=left class="text">������Ϲ�ȣ</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">
										&nbsp;<input type="text" name="v_car_no" id=v_car_no value="" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();" >
                                    </td>
                                    <td align=left class="text">�԰汸��</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">
                                    	&nbsp;<select name="v_out_gubn" id="v_out_gubn"  style="width:130px">
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
            <td >
                 <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='380px' border='1'>
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
                        <C> name='�԰汸�С�'         ID='JOB_SEL'    width=70 align=Center EditStyle=lookup data='ds_status1:detail:detail_nm' SumText='�ѰǼ�'</C>
                        <C> name='�������'          ID='STATUS_CD'  width=60 align=Center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' EditStyle=lookup data='ds_status:detail:detail_nm' SumText=@count </C>
						<C> name='��û����ȣ'   	ID='ACCEPT_NO'  width=100 align=center Edit=None  Mask='XXXXX-XXXXXXXXX' SumText='��'</C>
						<C> name='�������'			ID='DEPART_DATE'	width=60 align=center Edit=None Show=true</C>
						<C> name='���ð�'			ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm'  sort=true</C>
						<C> name='������'			ID='AR_DRIVER'		width=60 align=center Edit=None show=true</C>
						<C> name='�Ҽ�'       		ID='tt_client_nm'   align=left	width=100 	show=true   sort=true </C>
						<C> name='����'       		ID='car_nm'      	align=center width=100 	show=true  	sort=true </C>
						<C> name='������Ϲ�ȣ'		ID='CAR_NO'	  		align=center Width=100   Edit=None 	sort=true </C>
						<C> name='����' 			ID='CAR_TYPE' 	  	align=left Width=80   	Edit=None</C>
						<C> name='���԰� ������'	ID='REMARKS'    width=160 align=left Edit=Any EditLimit='24'</C>
                        ">
                 </object>
                      
            </td>
        </tr>
    </table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

