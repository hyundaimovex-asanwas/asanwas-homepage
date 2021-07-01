<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ���� ��û����(��ü �߽� ��)
 * ���α׷�ID   : RV274S
 * J  S  P      : rv274s
 * �� �� ��        : Rv274S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-08-31
 * �������     :
 * [��  ��   ��  ��][������] ����
 * [2010-08-25][�ڰ汹] ���� ��û����(��ü �߽� ��) �ű�ȭ�� ����.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>
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

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());
    date.add(Calendar.DATE, +1);
    String lastday = m_today.format(date.getTime());
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
         var div='';
        /*
         * �������ε�
         */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		}
        function fnInit() {
            // ����
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ�
        }
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            if(getObjectFirst("v_fr_date").Text.trim()==""
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("�������(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()==""
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("�������(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_saup.ValueOfIndex("saup_sid", v_saup.Index)
                      + ",v_group_cd="+ v_event_no.value
                      + ",v_cust_nm=" + v_cust_nm.value
                      + ",v_fr_date=" + v_fr_date.Text
                      + ",v_to_date=" + v_to_date.Text
                      + ",v_fr_use_date=" + v_fr_use_date.Text
                      + ",v_to_use_date=" + v_fr_use_date.Text
                      + ",v_manage_no=" + v_manage_no.value;
			//alert(param);
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv274S",
                "JSP(O:MASTER=ds1)",
                param);
            tr_post(tr1);
        }
        /*
         * ����
         */
        function fnExcel() {
            if(ds1.countrow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:���񽺿�û����ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("���񽺿�û����ȸ","���񽺿�û����ȸ.xls", 8);
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

            if (arrResult != null && arrResult!=undefined) {
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
        </script>
<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>
<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
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
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)" >
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>
<script language=JavaScript for=v_saup event=OnSelChange()>
    var v_param = "dsType=2"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                + "&s_UpjangType=99"
                + "&s_use_yn=Y";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //����
</script>
<script language=JavaScript  for=v_fr_date event="OnKillFocus()" >
    if(v_fr_date.Modified)
        v_to_date.Text = v_fr_date.Text
</script>
<script language=JavaScript  for=v_fr_use_date event="OnKillFocus()" >
    if(v_fr_use_date.Modified)
        v_to_use_date.Text = v_fr_use_date.Text
</script>
<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=true>
</object>
<object id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������-->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_menu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �޴���-->
    <param name="SyncLoad"  value="true">
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0' width='845'>
        <tr>
            <td width='845px'>
                <table  border='0' cellpadding='0' cellspacing='0' width='845'>
                    <tr>
                        <td align=right>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:hand" align=absmiddle onclick="fnSelect()">       <!-- ��ȸ -->
                            <img src="<%=dirPath%>/Sales/images/excel.gif"      style="cursor:hand" align=absmiddle onClick="fnExcel()">        <!-- ���� -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px">
            <td></td>
        </tr>
        <tr height="30px">
            <td width='845px'>
                <table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
                    <tr height='30px'>
                        <td align=left class="text" width="80">����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=80 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_saup>
                                <param name=SearchColumn        value="saup_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="saup_nm^0^80">
                                <param name=BindColumn          value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width="62" height="25" class="text" >��ü���</td>
                                <td width="142" bgcolor="#FFFFFF">&nbsp;<input name="v_event_no" id="v_event_no" type="text" style="width:30px;" class="input01" readOnly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand;display:" id="v_event_btn" onclick="fnGroupPopup('<%=dirPath%>');">
                                    <input type=hidden name="v_event_sid" id="v_event_sid"><input name="v_event_nm" type="text" style="width:60px;" class="input01" readOnly></td>
                        <td class="text">�μ���</td>
                        <td align=left bgcolor="#ffffff" colspan="3">&nbsp;<input type="text" name="v_cust_nm" size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 20);"></td>
                    </tr>
                    <tr height='25px'>
	                     <td align=left class="text" width="80">�������</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text                  value="<%=firstday%>">
                                <param name=Alignment             value=1>
                                <param name=Format                value="YYYY-MM-DD">
                                <param name=InputFormat           value="YYYYMMDD">
                                <param name=Cursor                value="iBeam">
                                <param name=Border                value="false">
                                <param name=InheritColor          value="true">
                                <param name=ReadOnly              value="false">
                                <param name=SelectAll             value="true">
                                <param name=SelectAllOnClick      value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>~
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text        value="<%=firstday%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
	                    <td align=left class="text" width="80">�̿�����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_use_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text                  value="">
                                <param name=Alignment             value=1>
                                <param name=Format                value="YYYY-MM-DD">
                                <param name=InputFormat           value="YYYYMMDD">
                                <param name=Cursor                value="iBeam">
                                <param name=Border                value="false">
                                <param name=InheritColor          value="true">
                                <param name=ReadOnly              value="false">
                                <param name=SelectAll             value="true">
                                <param name=SelectAllOnClick      value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>~
                            <object id=v_to_use_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                         </td>
                        <td class="text">�ֹ�/���ǹ�ȣ</td>
                        <td align=left bgcolor="#ffffff" colspan="3">&nbsp;<input type="text" name="v_manage_no" size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 20);"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr>
                        <td>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='400px' border='1'>
                                <param name="DataID"              value="ds1">
                                <param name="ColSizing"           value="true">
                                <param name="Fillarea"            value="false">
                                <param name="Editable"            value="false">
                                <param name="BorderStyle"         value="0">
                                <param name=SortView              value="Left">
                                <param name="SuppressOption"      value="1">
                                <param name="ViewSummary"         value="1">
                                <param name="Format"              value="
                                    <G> name='��ü����'
	                                    <C> name='��ü��'           ID='GROUP_NM'       width=80     align=left   	suppress=1   		</C>
	                                    <C> name='�������'        ID='DEPART_DATE'  width=100     align=center      	suppress=2  </C>
	                                    <C> name='��ǰ'            	ID='GOODS_NM'     width=80      align=left  			suppress=3	</C>
	                                    <C> name='��/��'           	ID='TEAMS'        	width=50     align=center   	suppress=4    </C>
 	                                    <C> name='�ο�'           	ID='MAN_CNT'        width=40     align=center        </C>
   	                                    <C> name='�μ���'           ID='VD_DIRECT'       width=50     align=center        </C>
   	                                    <C> name='�븮��'           ID='CLIENT_NM'      width=80     align=center        </C>
   	                                    <C> name='������'        ID='SAL_DAM_NM'   width=60     align=center        </C>   	                                    
	                                </G>  
	                               	<G>  name='�̿�����'
	                                    <C> name='�޴�����'       	ID='MENU_GUBN_NM'  	width=80     align=center     </C>
	                                    <C> name='������'           ID='UPJANG_NM'    	width=100   align=left         </C>
	                                    <C> name='�޴���'           ID='MENU_NM'      	width=120   align=left         </C>
	                                    <C> name='�̿�����'        ID='USE_DATE'  		width=100   align=center     </C>
	                                    <C> name='ȸ��'          	ID='USE_SEQ'      	width=40     align=left       </C>
	                                    <C> name='����'            	ID='SALE_QTY'     	width=40     align=right  	decao=0 		</C>
	                                    <C> name='�Ա�'           	ID='PAY_GUBN'     	width=80     align=left     						</C>
	                                    <C> name='���ó'         	ID='PLACE'     		width=80     align=left     						</C>
                                   </G>
                                        <C> name='��û������ȣ'  ID='REQ_NO'     	width=100     	align=left      </C>
	                                    <C> name='���'            	ID='REMARKS'    width=200     	align=left      </C>	                                    	                               
                                   ">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
                <br>
            </td>
        </tr>
    </table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		