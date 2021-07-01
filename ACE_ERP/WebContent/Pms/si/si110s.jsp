<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>����>����>�۾� ����>�Ϻ� ��ȸ/���
 * ���α׷�ID 	 : PMS/SI110S
 * J  S  P		 : si110s.jsp
 * �� �� ��		 : Si110s
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2014-06-24
 * [ �������� ][������] ����
 * [2014-06-24][�ɵ���] �ű� ���� 
 *						- ���� ����� �� ���� ��ȸ : �����Ȳ ����
 *							�����Ȳ : �ۼ��� �� ������������� �� �������Ϸ�
 *						- Ȯ 365�� �⺻ ���� �ϰ� �������ٱ�?
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	var menuWin;	//��â �����.
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_wml"), "comn");	//work master list
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    //v_date.Text = "201403";

        //ds_gc_weather.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY017&s_item1=Y";
        //ds_gc_weather.Reset();	//���� �ڵ� SY017 (����+)

        //ds_gc_wdcode.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI004&s_item1=Y";
        //ds_gc_wdcode.Reset();	//�۾� ����(������) SI004

        //ds_gc_bskind.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT001&s_item1=Y";
        //ds_gc_bskind.Reset();	//���� ���� CT001 

        ds_gc_wsts.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI007&s_item1=Y";
        ds_gc_wsts.Reset();	// �Ϻ� �۾����� 	SI007 

        
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WML=ds_wml)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
		//����ں� ��� ���� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct013I",
            "JSP(O:DS_SITE_EMP=ds_site_emp)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);        
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var v_wdate = v_date.Text.trim();

        if(v_wdate.length!=6) {
            alert("����� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_site_sid="+ v_site_sid.value
			+ ",v_date=" + v_wdate
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110S",
            "JSP(O:DS_WML=ds_wml)",
            param);
        tr_post(tr1);
    }

 
	<%//���� ��- ��ȸ%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }

    function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    
	<%//�׼� �ٿ��ϱ�%>
    function fnExcelDsDefault() {
        if(ds_wml.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_wml").SetExcelTitle(0, "");
        getObjectFirst("gr_wml").SetExcelTitle(1, "value:�Ϻ� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_wml").GridToExcel("�Ϻ� ��ȸ", v_date.text+"�Ϻ� ��ȸ.xls", 8);        
    }

    <%// �˾� = �۾��Ϻ� Daily Work Report %>
    function fnDraft(sid,sts) {
    	if(sts=="013"){
    		alert("�ݷ��� ������ ���缱�� �ǰ��� ���հ�����/����� �������� Ȯ���Ͻ� �� �ֽ��ϴ�.\n\n��� ���� �̵��մϴ�.");
    	}
        var link ="si110i_h1.jsp?v_dwr_sid="+ sid +"&v_status="+ sts;
        
        var dialogWidth = 930; 
        var features ="top=0,left="+ ((screen.availWidth - dialogWidth) / 2)+",height="+(screen.availHeight-52)+", width="+dialogWidth+",toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes";
        var pop_ap_dwr1 = window.open(link, 'pop_ap_dwr1', features); 

    
    }
    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=v_date event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_wml" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_wml event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    </script>


	<script language=javascript for=gr_wml event="OnDblClick(Row,Colid)">
	 	//alert(ds_wml.NameValue(Row, "DWR_SID"));

	 	fnDraft(ds_wml.NameValue(Row, "DWR_SID"),ds_wml.NameValue(Row, "W_STS"));
	</script>	

    <script language="JavaScript"  for="ds_site_emp" event="OnLoadCompleted(row)" >
	    if(row==0){
	        alert("���� ����� ������ �Ǿ� ���� �ʽ��ϴ�.\n\n������ �˻����ּ���.\n\n���� ����� ���� ��û �� ���������� ���� ������");
	    }else{
	    	getObjectFirst("v_site_nm").value = ds_site_emp.NameValue(row,"SITE_NM");
	    	getObjectFirst("v_site_sid").value = ds_site_emp.NameValue(row,"SITE_SID");
	    }
    </script>
    	
    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_wml classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_wsts	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_site_emp classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
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
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:pointer" onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='890px'>
           			<tr>
                        <td align="center" class="text" width="70">�����</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <input type="hidden"  name='v_site_sid' id='v_site_sid' value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="�� �����">
                        </td>
                        <td align="left" class="text" width="70">���</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:2px;width:59px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        </td>                                
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_wml classid=<%=HDConstant.MxGrid_CLSID_S%> width='888px' height='440px' border='1'>
                    <param name="DataID"            value="ds_wml">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
                         <C> name='�����'	ID='SITE_NM'   	width=300 	align=left	Edit=true  suppress='1' </C>
                         <C> name='�ۼ�����'	ID='W_DATE'	width=100 	align=CENTER	edit=none mask='XXXX-XX-XX'</C>
                         <C> name='����'	ID='W_STS'   	width=100 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_wsts:detail:detail_nm' suppress='2' </C>
                         <C> name='��ȹ(%)'    ID='RATE_PLAN'	width=70 	align=center	Edit=NONE	 decao=2  </C>
                         <C> name='����(%)'    ID='RATE_RESULT'	width=70 	align=center	Edit=none 	 decao=2 </C>
                         <C> name='���(%)'    ID='PROG_RATE'	width=80 	align=center	Edit=none	 decao=2 </C>
                         <C> name='�ۼ���'    ID='I_EMPNM'	width=80 	align=center	Edit=none	suppress='3' </C>
                 ">                             
                </object>                        

            </td>
        </tr>
    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		