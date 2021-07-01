<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>����>����>������ī��>���� ��ȸ
 * ���α׷�ID 	 : SALES/RM/RM260S
 * J  S  P		 : rm260s.jsp
 * �� �� ��		 : Rm260s
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2017-09-04
 * [ �������� ][������] ����
 * [2017-09-04][�ɵ���] �ű� ���� 
 *						- ���� �ʿ��ϴٰ� ���ϰ�.. �ϴ� �Ѵ� .-_
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
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
		
		cfStyleGrid(getObjectFirst("gr_ccl"), "comn1");	//work master list
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    //v_date.Text = "201403";

        ds_gc_type.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RM028&s_item1=Y&s_item2=Y";
        ds_gc_type.Reset();	//������ Ÿ�� RM028

        ds_gc_country.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY005&s_item1=Y";
        ds_gc_country.Reset();	//�����ڵ� SY005

        ds_gc_city.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY018&s_item1=Y";
        ds_gc_city.Reset();	//�����ڵ� SY018 

        ds_gc_useyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY011&s_item1=Y";
        ds_gc_useyn.Reset();	// ��뿩�� sy011 
        ds_gc_licyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=RM029&s_item1=Y";
        ds_gc_licyn.Reset();	// ���۱� RM029 

        
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260S",
            "JSP(O:DS_CCL=ds_ccl)",
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
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260S",
            "JSP(O:DS_CCL=ds_ccl)",
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
        if(ds_ccl.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_ccl").SetExcelTitle(0, "");
        getObjectFirst("gr_ccl").SetExcelTitle(1, "value:�Ϻ� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_ccl").GridToExcel("�Ϻ� ��ȸ", v_date.text+"�Ϻ� ��ȸ.xls", 8);        
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
    
    <%
	//Description  : web ���� ȭ�� ����  
	%>
	function showRsv(Row) {
		if(ds_main.CountRow==0){
		alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
		return;
		}
		//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
		//http://www.hdasantour.com/web/sub/rsv_view.php?v_param2=99000170614001&v_param3=010-6239-7178
		var link ='http://www.hdasantour.com/web/sub/rsv_view.php?v_param2='+ getObjectFirst("ds_main").NameValue(Row, "RACCEPT_NO") +'&v_param3='+ getObjectFirst("ds_main").NameValue(Row, "RMOB") ;
		var features ='height=768, width=1024, status=no, scrollbars=yes, resizable=yes';
		window.open(link, 'watchwin', features); 
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
    <script language="JavaScript"  for="ds_ccl" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_ccl event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    </script>


	<script language=javascript for=gr_ccl event="OnDblClick(Row,Colid)">
	 	//alert(ds_ccl.NameValue(Row, "DWR_SID"));

	 	fnDraft(ds_ccl.NameValue(Row, "DWR_SID"),ds_ccl.NameValue(Row, "W_STS"));
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
<object id=ds_ccl classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_type	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_country	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_city	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_useyn	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_licyn	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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
    <table border='0' cellpadding='0' cellspacing='0'  width="100%"> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0'  width="100%" >
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
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666"  width="100%">
           			<tr>
						<td align="left" class="text" width="90">������ Ÿ��</td>           			
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_type classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_gc_type>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>              			
                        <td align="center" class="text" width="70">�̸�(�ѱ�)</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:120px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <input type="hidden"  name='v_site_sid' id='v_site_sid' value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="�� �����">
                        </td>
						<td align="left" class="text" width="90">��뿩��</td>           			
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=100 width=70 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
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
                <object id=gr_ccl classid=<%=HDConstant.MxGrid_CLSID_S%> style="width:98%; height:440px" border='1'>
                    <param name="DataID"            value="ds_ccl">
                    <param name="Editable"          value="true">
                    <param name="ColSizing"         value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
                         <C> name='������\\Ÿ��'		ID='CD_TYPE'   	width=60 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_type:detail:detail_nm' </C>
                         <C> name='����'	ID='CD_COUNTRY'   	width=70 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_country:detail:detail_nm'  </C>
                         <C> name='����'	ID='CD_CITY'		width=70 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_city:detail:detail_nm'</C>
                         <C> name='�̸�\\(�ѱ�)'	ID='NAME_KOR'   	width=100 	align=left	Edit=true  </C>
                         <C> name='�̸�\\(����)'	ID='NAME_ENG'   	width=70 	align=left	Edit=true  </C>
                         <C> name='�̸�\\(local)'	ID='NAME_LOCAL'   	width=70 	align=left	Edit=true  </C>
                         <C> name='����'    ID='GMAP_N'	width=70 	align=center	Edit=NONE	 </C>
                         <C> name='�浵'    ID='GMAP_E'	width=70 	align=center	Edit=none 	 </C>
                         <C> name='�⺻����'    ID='DESC_BASIC'	width=80 	align=left 	Edit=none/C>
                         <C> name='�̹�������'    ID='DESC_IMG'	width=80 	align=left	Edit=none/C>
                         <C> name='�߰�����'    ID='DESC_ADD'	width=80 	align=left 	Edit=none</C>
                         <C> name='���۱�'    ID='FROM_LIC'	width=70 	align=center	Edit=none editstyle=lookup Data='ds_gc_licyn:detail:detail_nm' </C>
                         <C> name='��ó(URL)'    ID='FROM_URL'	width=80 	align=left	Edit=none	</C>
                         <C> name='��ó'    ID='FROM_TXT'	width=80 	align=center	Edit=none	</C>
                         <C> name='���'    ID='CD_USEYN'	width=40 	align=center	Edit=none editstyle=lookup Data='ds_gc_useyn:detail:detail_nm' </C>  
                         <C> name='�ۼ���'    ID='I_EMPNO'	width=60 	align=center	Edit=none	</C>
                         <C> name='������'   ID='WEBVIEW'   Width=60   Edit=none align=CENTER</C>
				                              
					">
				</object><br />
				�� ������ �÷��� <b>[��ȭ��]�� ����Ŭ��</b>�ϸ�, �������� ��ȭ���� �� �� �ֽ��ϴ�.



            </td>
        </tr>
    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		