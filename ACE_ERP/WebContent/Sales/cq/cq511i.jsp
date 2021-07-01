<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: Ȩ>����>����>����� ����>��������� �Է�
 * ���α׷�ID 	: CQ511I
 * J  S  P		: cq511i
 * �� �� ��		: Cq511I
 * �� �� ��		: �ɵ���
 * [��  ��   ��  ��][������] ����
 * [2015-10-05][�ɵ���] ������ ����� ����ϰ� Ȥ�� �ٸ���
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
   //date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());        
   
%>

<%// HTML ����%>
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
        
        v_depart_date.Text='<%=firstday%>';
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //�����ڵ�
        
        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y";
        ds_status.Reset();	//�������

        ds_status1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y&s_item3=Y";
        ds_status1.Reset();	//�������-��汸�п�

        ds_dp_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_item1=Y";
        ds_dp_time.Reset();	//���ð�
        //ds_ar_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
        //ds_ar_time.Reset();	//�԰�ð�

	}

    /*
     * �ð�, ��ǰ���� ��ȸ
     */     
    function fnSelectDs3() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ",sDepartDate=" + v_depart_date.Text;

        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
            v_param);
        tr_post(tr2);
    }   

	function fnSelect() {
        if(v_depart_date.Text.trim()=="" || v_depart_date.Text.trim().length!=8){
            alert("������� <%=HDConstant.A_MSG_MUST_INPUT%>");
            return;
        }
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ", v_saup_sid="+ ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ", v_depart_date="+ v_depart_date.Text
                    + ", v_depart_time="+ lc_time.ValueOfIndex("DEPART_TIME", lc_time.Index)
                    + ", v_goods_sid="+ lc_goods.ValueOfIndex("GOODS_SID", lc_goods.Index)
                    + ", v_car_no="+ v_car_no.value
                    + ", v_out_gubn="+ v_out_gubn.value;

        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq511I",
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
	}

	function fnApply() {
		if (ds1.IsUpdated) {
			for ( i=1; i<= ds1.CountRow; i++ )  {
				if(ds1.namevalue(i,"job_sel")=="" ) {
					alert(ds1.namevalue(i,"car_nm")+" ������ [����]���� ������ �� �����ϴ�.");
					return;
				}
				if(ds1.namevalue(i,"status_cd")=="RC" && ds1.namevalue(i,"job_sel")=="NS" ) {
					alert(ds1.namevalue(i,"car_nm")+" ������ [���] �� [���]�� ������ �� �����ϴ�.");
					return;
				}
				if(ds1.namevalue(i,"status_cd")=="RC" && ds1.namevalue(i,"job_sel")=="DP" ) {
					alert(ds1.namevalue(i,"car_nm")+" ������ [���] �� [���]���� �����մϴ�.");
				}
			};	

            msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq511I",
                "JSP(I:DEFAULT=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
		}
	}
	
	function fnBarcoding() {
		if (barcoding.value.length == 12) {
			for (i = 1 ; i <= ds1.countrow; i++) {
				if (barcoding.value == ds1.namevalue(i, "UNITY_NO")) {
					ds1.namevalue(i, "BAR_SEL") = "T";
					barcoding.value ="";
					barcoding.focus();
					return;
				}
			}
		} else {
			return;
		}
	}

</script>



<script language=JavaScript for=ds_status1 event="OnLoadCompleted(row)">
	ds_status1.DeleteRow(3);
</script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
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

<script language="javascript" for="tr2" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr2" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>



<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
	msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	document.all.LowerFrame.style.visibility="visible";	
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)"> <%// Main %>
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>

<script language=JavaScript for=v_depart_date event=OnKillFocus()> <%// ���ð� ���� %>
    if ( v_depart_date.Modified ) {
        fnSelectDs3();          
    }
</script>

<script language=JavaScript for=lc_saup event=OnSelChange()> <%// ���� ü���� %>
    fnSelectDs3();
</script>
<script language=JavaScript for=lc_time event=OnSelChange()> <%// ���� ü���� %>
    
</script>



<script language=JavaScript for=gr1 event=OnClick(Row,Colid)> <%// Grid Event: �� �÷� Ŭ���� �� %>
    if(ds1.CountRow==0)
        return;

    if(Row==0 && Colid=="JOB_SEL"){
        for(var i=1; i<=ds1.CountRow; i++){
			if(ds1.NameValue(i, "status_cd")!="RC"){
            	ds1.NameValue(i, "JOB_SEL") = ds1.NameValue(1, "JOB_SEL");
            }
        }
    } else if(Row==0 && Colid=="BAR_SEL"){
        for(var i=1; i<=ds1.CountRow; i++){
            ds1.NameValue(i, "BAR_SEL") = ds1.NameValue(1, "BAR_SEL");
        }
    }
</script>


<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  ���� %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  ���ð� %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  ��ǰ %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_ban classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  ��   %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_jo classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  ��   %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//�������%>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//�������-��汸�п�%>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_dp_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �԰�ð� -->
    <param name="SyncLoad"  value="True">
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


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

    <table border='0' cellpadding='0' cellspacing='0'>  
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
                    <tr>
                        <td>
                            <table border='0' cellpadding="0" cellspacing="1" width="1002" bgcolor="#666666">
                                <tr height='30px'>
                                    <td width=70 align=left class="text">����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                                     
                                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=BindColumn      value="saup_sid">
                                            <param name=BindColVal      value="saup_sid">
                                            <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                            <param name=ListExprFormat  value="saup_nm^0^80">
                                        </object>
                                    </td>   
                                    <td align=left class="text">�������</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                                        <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Text                value="">
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="YYYY-MM-DD">
                                            <param name=InputFormat         value="YYYYMMDD">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=ReadOnly            value="false">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>&nbsp;
                                        <object id=lc_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_time>
                                            <param name=BindColumn      value="depart_time">
                                            <param name=BindColVal      value="depart_time">
                                            <param name=EditExprFormat  value="%,%;depart_time,depart_time_nm">
                                            <param name=ListExprFormat  value="depart_time_nm^0^60">
                                        </object>
                                                                                                                     
                                    </td>                                                                                           
                                    <td align=left class="text">��ǰ����</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;                                                                                         
                                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_goods>
                                            <param name=BindColumn      value="goods_sid">
                                            <param name=BindColVal      value="goods_sid">
                                            <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                            <param name=ListExprFormat  value="goods_nm^0^130">
                                        </object>
                                    </td>
                                </tr>
                                <tr height='30px'>
                                    <td align=left class="text">��汸��</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">
                                        &nbsp;<select name="v_out_gubn" id="v_out_gubn" class="textbox">
                                            <option value="">��ü
                                            <option value="Y">���
                                            <option value="N">�����
                                        </select>
                                    </td>
                                    <td align=left class="text">������Ϲ�ȣ</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">
                                    	&nbsp;<input type="text" name="v_car_no" id=v_car_no value="" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();" >
                                    </td>
                                    <td align=left class="text">���ڵ�</td>
                                    <td align=left bgcolor="#ffffff" valign="middle" colspan=5>
                                    	&nbsp;<input type="text" name="barcoding" id=barcoding value="" class="textbox" maxlength="12"  onkeyup="fnBarcoding();">
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
            <td valign=top>

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
					<param name="ViewSummary"       value="1">
					<param name="Format"            value="
				        <C> name='��汸�С�'    	ID='JOB_SEL'    width=80 align=Center EditStyle=lookup data='ds_status1:detail:detail_nm'   SumText='�ѰǼ�'</C>
						<C> name='�����'     	ID='CONFIRM_YN'	width=55 align=center Edit=None show=False SumText=@CNT </C>
						<C> name='�������'     	ID='STATUS_CD'  width=60 align=center Edit=None BgColor={IF(STATUS_CD='RC','#fefec0','' )} editstyle=lookup data='ds_status:detail:detail_nm' SumText=@CNT </C>
				        <C> name='��û����ȣ'   	ID='ACCEPT_NO'  width=120 align=center Edit=None  Mask='XXXXX-XXXXXXXXX' SumText='��'</C>
						<C> name='����'				ID='DEPART_DATE'	width=60 align=center Edit=None Show=False</C>
						<C> name='���ð�'			ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm'  sort=true</C>
						<C> name='������'			ID='DP_DRIVER'		width=60 align=center Edit=None </C>
							<C> name='����'				ID='ARRIVE_DATE'	width=60 align=center Edit=None show=false</C>
							<C> name='�ð�'				ID='ARRIVE_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_ar_time:detail:detail_nm'  sort=true show=false</C>
							<C> name='������'			ID='AR_DRIVER'		width=60 align=center Edit=None show=false</C>
					    <C> name='�Ҽ�'       		ID='tt_client_nm'   align=left	width=100 	show=true   sort=true </C>
						<C> name='����'       		ID='car_nm'      	align=center width=100 	show=true  	</C>
						<C> name='������Ϲ�ȣ'		ID='CAR_NO'	  		align=center Width=100   Edit=None 	sort=true </C>
						<C> name='����' 			ID='CAR_TYPE' 	  	align=left Width=60   	Edit=None</C>
				        <C> name='���԰� ������'	ID='REMARKS'    width=200 align=left Edit=Any EditLimit='24'</C>
						<C> name='�������' 		ID='car_desc'       align=left width=110 	editlimit=100 	show=false  </C>
		                <C> name='����SID'      	ID='car_sid'    	align=left width=100 	show=false</C>
				        
				    ">
				</object>
            </td>
        </tr>
        <tr>
            <td><BR>
            �� ��ȸ�� ��� ������ �Ѳ����� ��汸���� ������Ʈ�ؾ� �մϴ�..<BR>
            �� �������=<B>"���" �� "���"</B> <FONT COLOR="RED">���� �Ұ�</FONT><BR>
            �� �������=<B>"���" �� "���"</B> <FONT COLOR="BLUE">���� ����</FONT>
            </td>
        </tr>
    </table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
