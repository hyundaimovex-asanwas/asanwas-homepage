<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 - �ý��۸� 	 : Ȩ>PMS>����ī��>��ǥ ����>���� ��Ȳ
 * ���α׷�ID 	 : PMS/CC130S
 * J  S  P		 : cc130s.jsp, GAUCE5.x
 * �� �� ��		 : Cc120I, Cc130S
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-09-05
 * [ �������� ][������] ����
 * [2015-09-05][�ɵ���] ��ǥ ���� �� ���� ����
 * [2015-12-01][�ɵ���] ������(������)�� ��� ó���� ��ȸ �߰�
 * [2015-12-03][�ɵ���] ī�庰 ��� ���� �߰� 
 * [2015-12-15][�ɵ���] ����Ʈ �ٵ�� : ������ ó�� ȭ�鿡�� 
 * [2015-12-22][�ɵ���] ������(ȸ����)�� ��� ó���� ��ȸ �߰� 
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
	
	   java.util.Calendar date = java.util.Calendar.getInstance();
	   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	   String lastday = m_today.format(date.getTime());//����
	   //date.set(java.util.Calendar.HOUR_OF_DAY, -24);//����
	   String firstday = m_today.format(date.getTime());
	   firstday = DateUtil.getCurrentDate(8).substring(0,6)+"01";
	   lastday = DateUtil.getCurrentDate(8);
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
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
    var acc_dirpath="<%=dirPath%>/Account/jsp";
    var g_arrParam	= new Array();

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");  //grid ����
		cfStyleGrid(getObjectFirst("gr_culd"), "comn");  //grid ����
		cfStyleGrid(getObjectFirst("gr_culd1"), "comn");  //grid ����		
		fnInit();	
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";   
	    
        vt_fr_inout_dt.Text = "<%=firstday%>";
        vt_to_inout_dt.Text = "<%=lastday%>";
		v_empnmk.value=gusrnm;
		v_empno.value=gusrid;
		//v_empno.value='2130021' //gusrid;
		
    }
	
    <%//���� ��ȸ  %>
    function fnSelect() {
		if (ds_cul.IsUpdated ) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";

		    var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	        if(fr_date.length!=8) {
	            alert("�ŷ�����(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("�ŷ�����(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    	if( fr_date.substring(0,6)!= to_date.substring(0,6) ){
	       		alert("��ȸ�� �ŷ������ �����ؾ� �մϴ�. ");
	       		return false;
	        }
		    
			v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
            		+ ",dsType=1"
		            + ",v_frdt=" + fr_date
		            + ",v_todt=" + to_date
		            + ",v_empno =" + v_empno.value	;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc130S",	 
	            "JSP(O:DS_CUL=ds_cul)",
	            v_param);
	        tr_post(tr1);
		}
    }    
    <%// ������1 ������ ����ī�� �ŷ����� %>
    function fnSelectDetail(row) {
    	if(row>ds_cul.countrow){	//�տ��� ���� row�� ds_cul���� ũ��, �� ���ο� �������� ds_cul�� ��ȸ�� ��
    		row = 1;	//���� ������ ó��
    	}
        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_fsdat="+ ds_cul.namevalue(row,"FSDAT")
                    + ",v_fsnbr="+ ds_cul.namevalue(row,"FSNBR")
                    ;
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc130S",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
        tr_post(tr2);
    }

    <%// ������2 ī�庰 �ŷ����� %>
    function fnSelectDetail2(row) {
    	if(row>ds_cul.countrow){	//�տ��� ���� row�� ds_cul���� ũ��, �� ���ο� �������� ds_cul�� ��ȸ�� ��
    		row = 1;	//���� ������ ó��
    	}
        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_fsdat="+ ds_cul.namevalue(row,"FSDAT")
                    + ",v_fsnbr="+ ds_cul.namevalue(row,"FSNBR")
                    ;
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc130S",
            "JSP(O:DS_CULD1=ds_culd1)",
            v_param);
        tr_post(tr2);
    }
    
    
	<%// ��ǥ : ��%>
    function fnFsPopup(Row){
		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		sendParam[0] = ds_cul.namevalue(Row, "FDCODE")
		sendParam[1] = ds_cul.namevalue(Row, "FSDAT").substring(0,1);
		sendParam[2] = ds_cul.namevalue(Row, "FSDAT").substring(1,9);
		sendParam[3] = ds_cul.namevalue(Row, "FSNBR")
	//	alert(sendParam);
		strURL = "<%=dirPath%>/Account/jsp/a020009_popup.jsp";   
		strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);
	}

	 
	<% //  ����Ʈ %>
	function fnPrint() {
		//�ٽ� ��ȸ�ؿ� �ʿ䰡 ���ٸ�?!
		pr1.PreView();
    }
	function fnPrint2() {
		//�ٽ� ��ȸ�ؿ� �ʿ䰡 ���ٸ�?!
		pr2.PreView();
    }

	
    <%//���� ��- �˻����� ó���� : �����ڸ� �����ϰ�%>
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
    		v_empno.value = arrParam[1];
    		v_empnmk.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }

    function fnEmpNoCleanup(){
		v_empno.value = "";
		v_empnmk.value = "";
    }
	
	
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<script language=JavaScript for=vt_fr_inout_dt event=OnKillFocus()>
	        if( vt_fr_inout_dt.Modified == true ){
	        	vt_to_inout_dt.text = vt_fr_inout_dt.text.substring(0,6)+"31";
	        }
	        	
	</script>    
     	
	<%//OnDblClick : ��ǥ ������ȣ  ��%>
	<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">
		if(Colid=="FSDN"){
			fnFsPopup(Row);			
		}
	</script>

	<%//������ �׸��� OnClick : ����|�ͼ����� ��ȸ %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectDetail(Row);
			fnSelectDetail2(Row);
	    }
	</script>


<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=vt_to_inout_dt event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>

	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_cul event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_cul" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
			if(row<2){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
				fnSelectDetail2(v_default_row);
			}
		}
	</script>
	
    	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<object id=ds_cul classid=<%=HDConstant.MxDataSet_CLSID_S%>>  <!--��ǥ ���೻��-->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_culd classid=<%=HDConstant.MxDataSet_CLSID_S%>>  <!--������ �ŷ�����-->
    <param name="SyncLoad"  value="False">
    <param name=SubSumExpr          value="total ,    1:ATCODENM">
</object>
<object id=ds_culd1 classid=<%=HDConstant.MxDataSet_CLSID_S%>>  <!--ī�庰 �ŷ�����-->
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>


</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0'> 
        <tr>
            <td align='right'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
            </td>
        </tr>
        <tr>
            <td>
                <table border='0' cellpadding="0" cellspacing="1" >
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1002px'>
                                <tr>
			                        <td align="center" class="text" width="90">ó����</td>
                                    <td bgcolor='#ffffff' >&nbsp;
			                            <input type="text"  name='v_empno'   id='v_empno'  style="width:70px;" class='input01'  readOnly="readonly">
									    <input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" readOnly="readonly">
			                        	<% if("CC20".equals((String)session.getAttribute("vdeptcd"))||"C110".equals((String)session.getAttribute("vdeptcd"))){%>
			                        	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
			                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
			                            <%}%>

									</td>
			                        <td align=left class="text"  width="90">�ŷ�����</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.MxMaskEdit_CLSID_S%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
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
			                            </object>&nbsp;~&nbsp;
			                            <object id=vt_to_inout_dt classid=<%=HDConstant.MxMaskEdit_CLSID_S%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">            
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
			                                                                                                         
			                        </td>   
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        
        <tr height='20px'>
            <td class="bold"><font size="2" color="blue">[��ǥ ���೻��]</font></td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top'>
							<object  classid=<%=HDConstant.MxGrid_CLSID_S%>  id=gr_cul width="1000px" height="160px" border="1">
						        <param name="DataID"            value="ds_cul">
						        <param name="BorderStyle"       value="0">
						        <param name="ColSizing"         value="true">
						       	<param name="IndWidth"  		value="20">
						        <param name="editable"          value="false">
						        <param name=SortView  			value="Left">
						        <param name="indwidth"			value="20">
						        <param name="SuppressOption"    value="1">
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
									<FC> name='ó�� �׷��'	ID='GROUP_NM'	width=140 	align=left suppress='1' edit=none </FC>
									<C> name='�ͼ�����'    	ID='PL_DEPT_NM' Width=170  align=left 	suppress='1' </C>
					                <C> name='�ͼ��ڵ�'    	ID='PL_DEPT'  	Width=100  align=center  show=false 	</C>
					                <C> name='��ǥ������ȣ'	ID='FSDN'	    Width=100  align=center 	suppress='2'	</C>
					                <C> name='������'	  	ID='ATCODENM'   Width=170  align=left  	show=true	</C>
					                <C> name='�����ڵ�'    	ID='ATCODE'    	Width=80  	align=left  show=false  </C>
					                <C> name='�̿�ݾ�'   	ID='TOT_TOTAL' 	Width=110  	align=RIGHT show=true	DEC=0</C>
					                <C> name='���ް���' 	ID='AMT_NET'   	Width=110	align=RIGHT show=true	DEC=0</C>
					                <C> name='����' 	 	ID='TOT_TAX'  	Width=90  	align=RIGHT show=true	DEC=0</C>
					                <C> name='�����'   	ID='TOT_SVC'   	Width=90	align=RIGHT show=true	DEC=0</C>
						        ">
							</object>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        <tr height="26">
            <td class="t" style="color:aa0000;padding-top:6px;">���� <b>��ǥ ������ȣ</b>�� ����Ŭ���ϸ� ��ǥâ�� �˾��˴ϴ�.</td>
        </tr>          
        <tr height='20px'>
            <td>
            	<table width="100%" border="0" cellpadding="0" cellspacing="0">
            	  <tr>
            	  	<td align=left  class="bold"><font size="2" color="blue">[������ ����ī�� �ŷ�����]</font></td>
            	  	<td align=right><img src="<%=dirPath%>/Sales/images/print.gif" style="cursor:pointer" onclick="fnPrint()"></td>
            	  </tr>
            	</table> 
            </td>
        </tr>
        <tr>
            <td valign="top">
				<object  classid=<%=HDConstant.MxGrid_CLSID_S%>  id=gr_culd width="1000px" height="200px" border="1">
			        <param name="DataID"            value="ds_culd">
			        <param name="BorderStyle"       value="0">
			        <param name="ColSizing"         value="true">
			       	<param name="IndWidth"  		value="20">
			        <param name="editable"          value="false">
			        <param name="indwidth"			value="20">
			        <param name="SuppressOption"    value="1">
			        <param name="ViewSummary"       value="0">
			        <param name="Format"            value="
				        <C> Name='LV'           ID=CurLevel		  HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''    sort=false   edit=none  Value={CurLevel} show=false</C>
                        <C> name='������'	 ID='ATCODENM'  	 width=120 	align=left	SUPPRESS='1'  Value={Decode(CurLevel,0,ATCODENM,1,'           �� ��',9999,'         ��     ��')}</C>
                        <C> name='ī���ȣ'	 ID='CARD_NUM'  	 width=120 	align=left	edit=none mask='XXXX-XXXX-XXXX-XXXX' </C>                        
                      <G> name='�̿�����'
                        <C> name='����'		ID='APPROVE_DATE'	 width=70 	align=CENTER edit=none mask='XXXX-XX-XX'</C>
                        <C> name='�ð�'		ID='APPROVE_TIME'	 width=40 	align=CENTER edit=none mask='XX:XX'</C>
                        <C> name='���ι�ȣ'	ID='APPROVE_NUM'	 width=60 	align=CENTER edit=none </C>
                        <C> name='�ݾ�'     ID='AMT_TOTAL'	width=70 	align=right		Edit=NONE	 decao=0  sumtext=@sum </C>
                      </G>
                        <C> name='���ް���'     ID='AMT_NET'	width=70 	align=right		decao=0   sumtext=@sum		</C>
                        <C> name='�ΰ���'    	ID='AMT_TAX'	width=60 	align=right		 decao=0   sumtext=@sum		</C>
                        <C> name='�����\\(�鼼��)'    	ID='AMT_SVC'	width=60 	align=right			 decao=0   sumtext=@sum	</C>
						<C> name='�ΰ���\\����'	ID='TAXYN'   	width=40 	align=CENTER	edit=none  </C>
					  <G> name='������ ���� (BC����)'
						<C> name='����ڹ�ȣ'	ID='VENDOR_TAX_NUM'  width=80 	align=left	edit=none mask='XXX-XX-XXXXX'</C>
						<C> name='��������'		ID='VENDOR_NAME'	 width=100 	align=left	edit=none </C>
						<C> name='��ǥ��' 		ID='VENDOR_PERSON'   width=45 	align=center edit=none </C>
						<C> name='��ȭ'			ID='VENDOR_TEL'   	width=80 	align=left	edit=none </C>
						<C> name='�ּ�'			ID='VENDOR_ADDRESS1'   	width=100 	align=left	edit=none </C>
					  </G>
     
			        ">
				</object>
			</td>
        </tr>
        <tr height="26">
            <td class="t" style="color:#aa0000;padding-top:6px;">���� �ΰ��� ���� ����<br>
            ���� <b>U</b> : �����(<b>U</b>ser)�� ������ �߰� ����
            ������������ <b>O</b> : ����(<b>O</b>rigin)���� ������ ���� ����� ���·� ����
            ������������ <b>S</b> : ������ �־�����, 0���� ���� (��: ����� <b>S</b>ervice)</td>
        </tr>


        <tr height='20px'>
            <td>
            	<table width="100%" border="0" cellpadding="0" cellspacing="0">
            	  <tr>
            	  	<td align=left  class="bold"><font size="2" color="blue">[ī�庰 �ŷ�����]</font></td>
            	  	<td align=right><img src="<%=dirPath%>/Sales/images/print.gif" style="cursor:pointer" onclick="fnPrint2()"></td>
            	  </tr>
            	</table> 
            </td>
        </tr>        
        <tr>
            <td valign="top">
				<object  classid=<%=HDConstant.MxGrid_CLSID_S%>  id=gr_culd1 width="1000px" height="140px" border="1">
			        <param name="DataID"            value="ds_culd1">
			        <param name="BorderStyle"       value="0">
			        <param name="ColSizing"         value="true">
			       	<param name="IndWidth"  		value="20">
			        <param name="editable"          value="false">
			        <param name="indwidth"			value="20">
			        <param name="SuppressOption"    value="1">
			        <param name="ViewSummary"       value="1">
			        <param name="Format"            value="
						<C> name='����'   	 ID='CAKINDNM'	 width=100 	align=CENTER </C>
                        <C> name='����'   	 ID='CADIVNM'	 width=110 	align=CENTER </C>
                        <C> name='�����μ�'	 ID='DPT_NM'	 width=200 	align=CENTER </C>
                        <C> name='������' 	 ID='EMP_NM'	 width=100 	align=CENTER </C>
                        <C> name='ī���ȣ'	 ID='CARD_NUM'	 width=180 	align=CENTER mask='XXXX-XXXX-XXXX-XXXX' </C>                        
                        <C> name='��� �Ǽ�' ID='CNT'	 	 width=100 	align=CENTER SumText=@SUM </C>
                        <C> name='��� �ݾ�' ID='AMT_TOTAL'	 width=180 	align=right	 decao=0  sumtext=@sum </C>
			        ">
				</object>
			</td>
        </tr>
        <!-- 
        <tr height="26">
            <td class="t" style="color:#aa0000;padding-top:6px;">�� �ΰ��� ���� ����<br>
            �� <b>U</b> : �����(<b>U</b>ser)�� ������ �߰� ����
            ������������ <b>O</b> : ����(<b>O</b>rigin)���� ������ ���� ����� ���·� ����
            ������������ <b>S</b> : ������ �־�����, 0���� ���� (��: ����� <b>S</b>ervice)</td>
        </tr> -->
    </table>

<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>

	<object id=pr1 classid=<%=HDConstant.MxReport_CLSID_S%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds_culd">
		<PARAM NAME="DetailDataID"			VALUE="ds_culd">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
 		<param name="SuppressColumns"		value="1:atcodenm">
		<PARAM NAME="Format"                value="

<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=270 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��ǥ ������ȣ :' ,left=2228 ,top=201 ,right=2484 ,bottom=262 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='-' ,left=2686 ,top=214 ,right=2720 ,bottom=262 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,valign=top</T>
	<I>id='http://ace.hdasan.com/images/approval/2015slg.jpg' ,left=29 ,top=8 ,right=513 ,bottom=164</I>
	<T>id='����ī�� �ŷ�����' ,left=1080 ,top=64 ,right=1879 ,bottom=204 ,face='������� ExtraBold' ,size=28 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true ,valign=top ,CRFlag=true</T>
	<C>id='fsnbr', left=2720, top=204, right=2863, bottom=262, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fsdat', left=2484, top=204, right=2686, bottom=262, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=76 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �� ��' ,left=119 ,top=13 ,right=336 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=794 ,top=0 ,right=794 ,bottom=77 </L>
	<L> left=1299 ,top=0 ,right=1299 ,bottom=77 </L>
	<L> left=1701 ,top=0 ,right=1701 ,bottom=77 </L>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=77 </L>
	<L> left=2037 ,top=3 ,right=2037 ,bottom=77 </L>
	<L> left=1894 ,top=0 ,right=1894 ,bottom=77 </L>
	<L> left=2143 ,top=0 ,right=2143 ,bottom=77 </L>
	<T>id='�ΰ���' ,left=1715 ,top=13 ,right=1881 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ͻ�' ,left=889 ,top=13 ,right=1037 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=0 ,right=2844 ,bottom=0 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='ī���ȣ' ,left=564 ,top=13 ,right=728 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ι�ȣ' ,left=1135 ,top=13 ,right=1283 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����������' ,left=2318 ,top=13 ,right=2638 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ΰ�������' ,left=2040 ,top=3 ,right=2143 ,bottom=77 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true ,CRFlag=true</T>
	<T>id='��Ÿ�ݾ�' ,left=1900 ,top=13 ,right=2037 ,bottom=69 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1114 ,top=0 ,right=1114 ,bottom=77 </L>
	<T>id='���ް���' ,left=1511 ,top=13 ,right=1693 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���αݾ�' ,left=1310 ,top=13 ,right=1495 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=487 ,top=0 ,right=487 ,bottom=77 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=106 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=487 ,top=0 ,right=487 ,bottom=106 </L>
	<L> left=1894 ,top=0 ,right=1894 ,bottom=106 </L>
	<L> left=794 ,top=0 ,right=794 ,bottom=106 </L>
	<L> left=1299 ,top=0 ,right=1299 ,bottom=106 </L>
	<L> left=1701 ,top=0 ,right=1701 ,bottom=106 </L>
	<C>id={Decode(CurLevel,0,ATCODENM,1,'�Ұ�',9999,'�հ�')}, left=42, top=26, right=476, bottom=82, align='left', supplevel=1, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
	<L> left=2037 ,top=0 ,right=2037 ,bottom=106 </L>
	<L> left=2143 ,top=0 ,right=2143 ,bottom=106 </L>
	<C>id='vendor_tax_num', left=2627, top=5, right=2823, bottom=56, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0 ,CRFlag=true</C>
	<C>id='vendor_person', left=2521, top=5, right=2630, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
	<C>id='vendor_name', left=2172, top=5, right=2516, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0 ,CRFlag=true</C>
	<C>id='vendor_tel', left=2521, top=53, right=2823, bottom=101, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='vendor_address1', left=2172, top=53, right=2516, bottom=101, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='taxyn', left=2056, top=26, right=2133, bottom=82, face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=106 </L>
	<C>id='amt_svc', left=1905, top=26, right=2035, bottom=82, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='amt_tax', left=1709, top=26, right=1889, bottom=82, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='amt_net', left=1511, top=26, right=1693, bottom=82, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='amt_total', left=1310, top=26, right=1492, bottom=82, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='card_num', left=492, top=26, right=791, bottom=82, mask='XXXX-XXXX-XXXX-XXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=10, Decao=10 ,CRFlag=true</C>
	<C>id='approve_num', left=1132, top=26, right=1283, bottom=82, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<L> left=1114 ,top=0 ,right=1114 ,bottom=106 </L>
	<C>id='approve_date', left=802, top=5, right=1106, bottom=53 ,mask='XXXX.XX.XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
	<C>id='approve_time', left=802, top=53, right=1103, bottom=101, mask='XX:XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0 ,CRFlag=true</C>
	<L> left=26 ,top=0 ,right=489 ,bottom=0 ,supplevel=1 </L>
	<L> left=487 ,top=0 ,right=794 ,bottom=0 </L>
	<L> left=794 ,top=0 ,right=2844 ,bottom=0 </L>
	<L> left=794 ,top=106 ,right=2844 ,bottom=106 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=75 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=2844 ,bottom=0 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1836 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�� �ΰ��� ���� ����' ,left=34 ,top=5 ,right=495 ,bottom=42 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3 ,CRFlag=true</T>
	<T>id='U : �����(User)�� ������ �߰� ����' ,left=79 ,top=45 ,right=696 ,bottom=82 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3 ,CRFlag=true</T>
	<T>id='O : ����(Origin)���� ������ ���� ����� ���·� ����' ,left=79 ,top=85 ,right=540 ,bottom=122 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3 ,CRFlag=true</T>
	<T>id='S : ������ �־�����, 0���� ���� (��: ����� Service)' ,left=79 ,top=127 ,right=841 ,bottom=164 ,align='left' ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3 ,CRFlag=true</T>
	<T>id='- #p -' ,left=1373 ,top=122 ,right=1588 ,bottom=164, Multiline=true ,CRFlag=true</T>
	<I>id='http://ace.hdasan.com/images/approval/2014ci.gif' ,left=2434 ,top=82 ,right=2860 ,bottom=153</I>
</B>
	">
</object> 


	<object id=pr2 classid=<%=HDConstant.MxReport_CLSID_S%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds_culd1">
		<PARAM NAME="DetailDataID"			VALUE="ds_culd1">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
 		<param name="SuppressColumns"		value="1:atcodenm,card_num">
		<PARAM NAME="Format"                value="

<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=270 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��ǥ ������ȣ :' ,left=2228 ,top=201 ,right=2484 ,bottom=262 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='-' ,left=2686 ,top=214 ,right=2720 ,bottom=262 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,valign=top</T>
	<I>id='http://ace.hdasan.com/images/approval/2015slg.jpg' ,left=29 ,top=8 ,right=513 ,bottom=164</I>
	<C>id='fsnbr', left=2720, top=204, right=2863, bottom=262, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fsdat', left=2484, top=204, right=2686, bottom=262, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����ī�� �ŷ�����' ,left=1080 ,top=64 ,right=1879 ,bottom=204 ,face='������� ExtraBold' ,size=28 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true ,valign=top ,CRFlag=true</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=76 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��  ��' ,left=66 ,top=13 ,right=283 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=688 ,top=0 ,right=688 ,bottom=77 </L>
	<L> left=1193 ,top=0 ,right=1193 ,bottom=77 </L>
	<L> left=1490 ,top=0 ,right=1490 ,bottom=77 </L>
	<L> left=2064 ,top=3 ,right=2064 ,bottom=77 </L>
	<L> left=2275 ,top=0 ,right=2275 ,bottom=77 </L>
	<T>id='�� �� �� ��' ,left=2085 ,top=13 ,right=2252 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=0 ,right=2844 ,bottom=0 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�� ��' ,left=445 ,top=13 ,right=582 ,bottom=69 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1246 ,top=13 ,right=1429 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=355 ,top=0 ,right=355 ,bottom=77 </L>
	<T>id='�� �� �� ��' ,left=2432 ,top=13 ,right=2709 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����μ�' ,left=815 ,top=13 ,right=1077 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ī �� �� ȣ' ,left=1630 ,top=13 ,right=1926 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=106 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=355 ,top=0 ,right=355 ,bottom=106 </L>
	<L> left=688 ,top=0 ,right=688 ,bottom=106 </L>
	<L> left=1193 ,top=0 ,right=1193 ,bottom=106 </L>
	<L> left=1490 ,top=0 ,right=1490 ,bottom=106 </L>
	<L> left=2064 ,top=0 ,right=2064 ,bottom=106 </L>
	<L> left=2275 ,top=0 ,right=2275 ,bottom=106 </L>
	<C>id='emp_nm', left=1246, top=26, right=1429, bottom=82, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<L> left=26 ,top=0 ,right=489 ,bottom=0 ,supplevel=1 </L>
	<L> left=487 ,top=0 ,right=794 ,bottom=0 ,supplevel=1 </L>
	<L> left=794 ,top=0 ,right=2844 ,bottom=0 </L>
	<C>id='cakindnm', left=42, top=26, right=310, bottom=82, supplevel=1, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
	<L> left=29 ,top=106 ,right=2844 ,bottom=106 </L>
	<C>id='amt_total', left=2373, top=26, right=2656, bottom=82, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='cadivnm', left=392, top=26, right=643, bottom=82, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='dpt_nm', left=741, top=26, right=1151, bottom=82, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<C>id='card_num', left=1527, top=26, right=2027, bottom=82, supplevel=1 ,mask='XXXX-XXXX-XXXX-XXXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=10, Decao=10 ,CRFlag=true</C>
	<C>id='cnt', left=2093, top=26, right=2207, bottom=82, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=106 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=2844 ,bottom=0 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='{SUM(amt_total)}', left=2334, top=34, right=2659, bottom=90, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<L> left=26 ,top=106 ,right=2844 ,bottom=106 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='��' ,left=2651 ,top=34 ,right=2717 ,bottom=90 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2201 ,top=34 ,right=2267 ,bottom=90 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{SUM(cnt)}', left=2082, top=34, right=2204, bottom=90, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
</B>
<B>id=Footer ,left=0 ,top=1835 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='- #p -' ,left=1373 ,top=122 ,right=1588 ,bottom=164, Multiline=true ,CRFlag=true</T>
	<I>id='http://ace.hdasan.com/images/approval/2014ci.gif' ,left=2434 ,top=82 ,right=2860 ,bottom=153</I>
</B>


	">
</object>
</body>
</html>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		