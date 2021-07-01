<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>PMS>����ī��>ī�� ����>��� ��Ȳ
 * ���α׷�ID 	 : PMS/CC110S
 * J  S  P		 : cc110s.jsp, GAUCE5.x
 * �� �� ��		 : Cc110s
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-07-30
 * [ �������� ][������] ����
 * [2015-07-30][�ɵ���] �ű� ���� 
 *						- �繫�� �����ڿ�, ��ü ī�� �����Ȳ ��ȸ
 *							�����Ȳ : �ۼ��� �� ������������� �� �������Ϸ�
 * [2015-08-04][�ɵ���] html5 �� ��������? �ٵ� ���� ��Ŭ������ ������.. �Ŀ�;(__);
 * [2015-08-25][�ɵ���] ������ ��ȸ���� ������ȸ ���� ������ ��~ [ó���ںκ�]
 * [2015-11-19][�ɵ���] ������ ��ȸ java �߰�
 *						GRID�� �������� �÷� üũ�ڽ��� ����
 *						������ȸ ���� ���� : ī���ȣ, ó���� (���� �����ϰ� ��ϻ�TCC110.U_EMPNO=ó���ڷ� �˻�
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


<!-- HTML ���� : doctype�� html5�� �غ���? ��;;-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
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
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list
		cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail

		fnInit();
		
	}
	
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
    	
	    v_job ="I";
	    v_todt.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    

        ds_gc_ccstat.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC010&s_item1=Y";
        ds_gc_ccstat.Reset();	//ī�� ó������ CC010 (��ü+ : dsType=4) ����:dsType=3

        ds_gc_ddyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_gc_ddyn.Reset();	//�������� YN (SY010)

		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110S",
            "JSP(O:DS_CUL=ds_cul)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        //tr_post(tr1);
        
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var v_frdate = v_frdt.Text.trim();
        var v_todate = v_todt.Text.trim();
        
        if(v_frdate.length!=8||v_todate.length!=8) {
            alert("����� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_site_sid=1"
			+ ",v_frdt=" + v_frdate	//��ȸ�Ⱓ
			+ ",v_todt=" + v_todate	//��ȸ�Ⱓ
			+ ",v_ccstat=" + lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)	//ó������
			+ ",v_card_num=" + v_card_num.value	//ī���ȣ
			+ ",v_mgr_no=" + v_mgr_no.value	//ó���� ���
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110S",
            "JSP(O:DS_CUL=ds_cul)",
            param);
        tr_post(tr1);
    }

    <%// ������ �������� %>
    function fnSelectDetail(row) {
        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_acquire_sid="+ ds_cul.namevalue(row,"ACQUIRE_SID");
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
		tr_post(tr2);
    }
    
    
    <%//���� ��- �˻����� ó����%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }

    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }

    function fnCardNoCleanup(){
    	v_card_num.value = "";
    }
    
	<%//�׼� �ٿ��ϱ�%>
    function fnExcelDsDefault() {
        if(ds_cul.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_cul").SetExcelTitle(0, "");
        getObjectFirst("gr_cul").SetExcelTitle(1, "value:����ī�� �����Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_cul").GridToExcel("����ī�� �����Ȳ", "����ī�� �����Ȳ.xls", 8);        
    }

    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=v_todt event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>

	<%//������ �׸��� OnClick %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectDetail(Row);
	    }
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
    <script language="JavaScript"  for="ds_cul" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_cul event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
			if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
			}
		}
	</script>
    	
    


	<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">
	 	//alert(ds_cul.NameValue(Row, "DWR_SID"));

	 	fnDraft(ds_cul.NameValue(Row, "DWR_SID"),ds_cul.NameValue(Row, "W_STS"));
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
<object id=ds_cul classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_culd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_gc_ccstat	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_ddyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
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
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="1002px">
           			<tr>
                        <td align="center" class="text" width="90">ó����</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>

                        <td align="center" class="text" width="90">��ȸ�Ⱓ</td>
                        <td bgcolor="#FFFFFF" >&nbsp;
                            <object id=v_frdt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            &nbsp;~&nbsp;
                            <object id=v_todt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>                            
                            
                        </td>
                        <td align="left" class="text" width="90">ó�� ����</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_ccstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_ccstat>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                                                        
                        </td>                                
					</tr>

           			<tr>
                        <td align="center" class="text" width="90">ī���ȣ</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="�� �����">                            
                        </td>
                        <td align="left" class="text" width="90"></td>
                        
                        <td align="left" bgcolor="#ffffff"><!-- &nbsp;
							<object id=gcem_fs02 classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox"  style="width:15px;height:17px;position:relative;left:0px;top:2px">				
								<param name=Text		value="">
								<param name=Alignment   value=1>
								<param name=VAlign	    value=1>
								<param name=Border      value="false">
								<param name=Format        value="#">
								<param name=PromptChar    value="_">
								<param name=UpperFlag     value=1>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							<object id=gcem_fsdat02 classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="width:70px;height:17px;position:relative;left:0px;top:2px">		
								<param name=Text		value="">
								<param name=Alignment   value=1>
								<param name=VAlign	    value=1>
								<param name=Border      value="false">
								<param name=Format        value="YYYY/MM/DD">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							&nbsp;-&nbsp;
							<object id=gcem_fsnbr02 classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="width:50px;height:17px;position:relative;left:0px;top:2px">				
								<param name=Text		value="">
								<param name=Alignment   value=1>
								<param name=VAlign	    value=1>
								<param name=Border      value="false">
								<param name=Format        value="######">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object> -->
							   
                        </td>
                        <td colspan=2 bgcolor="#ffffff">&nbsp;</td>
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='400px' border='1'>
                    <param name="DataID"            value="ds_cul">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<param name=ColSelect    value="True">
					<param name="ViewSummary"       value="1">
					<param name="ColSizing"         value="true">																								                                        
					<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
					">
                    <param name="Format"            value="
						<FC> name='No'			ID='{CurRow}'		 width=40 	align=right edit=none SumText=@cnt</FC>
                        <FC> name='ó����'		ID='MGR_NM'   		 width=50 	align=CENTER  edit=none show=true</FC>
                        <FC> name='����SId'		ID='ACquiRE_SID'	 width=50 	align=left show=false</FC>
					  <FG> name='ī������'
                        <FC> name='�����μ�'	 ID='DPT_NM'   		 width=80 	align=left  edit=none SumText='��' </FC>
                        <FC> name='������'	ID='EMP_NM'  	 width=50 	align=CENTER edit=none bgColor={IF(EMP_NM='�̵��','#ffcccc','#FFFFFF') } </FC>
                        <FC> name='��ȣ'	ID='CARD_NUM'  		 width=120 	align=right	edit=none mask='XXXX-XXXX-XXXX-XXXX' </FC>
                      </FG>
					  <G> name='�ŷ�ó ���� (ERP)'
                        <C> name='��ȣ'			ID='VEND_NM'   	width=70 	align=left	edit=none </C>
                        <C> name='�ּ�'			ID='ADDR1'   	width=90 	align=left	edit=none bgColor={IF(ADDR1='�̵�� �ŷ�ó','#ffff00','#FFFFFF') } </C>
                        <C> name='����'			ID='COCOMYN_NM'   	width=40 	align=CENTER	edit=none </C>
                      </G>
                      <G> name='�̿�����'
                        <C> name='����'		ID='APPROVE_DATE'	 width=70 	align=CENTER edit=none mask='XXXX-XX-XX'</C>
                        <C> name='�ð�'		ID='APPROVE_TIME'	 width=40 	align=CENTER edit=none mask='XX:XX'</C>
                        <C> name='�ݾ�'     ID='AMT_TOTAL'	width=70 	align=right		Edit=NONE	 decao=0  </C>
                      </G>
                        <C> name='���ް���'     ID='AMT_NET'	width=70 	align=right		Edit=NONE	 decao=0  </C>
                        <C> name='�ΰ���'    	ID='AMT_TAX'	width=60 	align=right		Edit=NONE	 decao=0  </C>
                        <C> name='�����\\(�鼼��)'    	ID='AMT_SVC'	width=50 	align=right		Edit=NONE	 decao=0  </C>
						<C> name='ó��\\����'   ID='STAT'   	width=50 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_ccstat:detail:detail_nm' </C>
						<C> name='����\\����'	ID='DDYN'   	width=30 	align=CENTER	edit=true editstyle=CheckBox  bgColor={IF(DDYN='T','#CCFFCC','#FFFF00') } </C>
						<C> name='��ȭ'			ID='CURRENCY'   	 width=40 	align=CENTER  edit=none</C>
					  <G> name='������ ���� (BC����)'
						<C> name='����ڹ�ȣ'	ID='VENDOR_TAX_NUM'  width=80 	align=left	edit=none mask='XXX-XX-XXXXX'</C>
						<C> name='��������'		ID='VENDOR_NAME'	 width=100 	align=left	edit=none </C>
						<C> name='��ǥ��' 		ID='VENDOR_PERSON'   width=50 	align=center edit=none </C>
						<C> name='��ȭ'			ID='VENDOR_TEL'   	width=80 	align=left	edit=none </C>
						<C> name='�ּ�'			ID='VENDOR_ADDRESS1'   	width=100 	align=left	edit=none </C>
					  </G>
                 ">                             
                </object>                        

            </td>
        </tr>
        <tr>
            <td valign="top" style="padding-top:4px"><b>��������</b>
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='100px' border='1'>
                    <param name="DataID"            value="ds_culd">
                    <param name="Editable"          value="false">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
                        <C> name='������'	ID='ATCODENM'	width=200 	align=left EditStyle=popup </C>
                        <C> name='�����ڵ�'	ID='ATCODE'		width=70 	align=center edit=none </C>
                        <C> name='����'		ID='REMARK'   	width=320 	align=left </C>
                        <C> name='���ް���' ID='FSAMT'		width=70 	align=right		decao=0  </C>
                        <C> name='�ͼ�����'	ID='PL_DEPT_NM' width=200 	align=left EditStyle=popup </C>
                        <C> name='�ͼ��ڵ�'	ID='PL_DEPT' 	width=70 	align=center  edit=none show=true  </C>
                        <C> name='�ͼӱ���'	ID='PL_DEPT_DIV'	width=60 	align=CENTER show=false	</C>
                        <C> name='����SID'	ID='acquire_sid'	width=60 	align=CENTER	edit=none show=false</C>
                        
                 ">                             
                </object>
            </td>
        </tr>
        <tr> 
        	<td>�� Zace(�Ǽ�ERP)���� ó���� ������ �ϴ� [��������]�� ǥ�õ��� �ʽ��ϴ�.</td>       
		</tr>

        
    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		