<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ���ް�� ���
 * ���α׷�ID 	: CT010 (�ڵ�� �빮��)
 * J  S  P		: ct010 (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Ct010
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-07-04
 * �������	: ���ް�� ���/��ȸ/����
 * ��������	: �ű�
 * [ �������� ][������] ����
 * [2014-07-07][�ɵ���] �׸��� ������ ����, ���� ���ິ | ��ȭ | �ѽ� | ���������ڵ�(XXXX) �߰�
 * [2014-07-07][�ɵ���] ���ݾ��� ���� �� ����?
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	
	<script language="javascript">
	
	var gs_userid = gusrid;
	var gs_fdcode = gfdcode;
	var v_default_row = 1;
	
   	/*
 	 * ������ �ε�
 	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		fnInit();
		cfStyleGrid(getObjectFirst("gr1"), "comn1");	//���ް�� ����
		cfStyleGrid(getObjectFirst("gr2"), "comn");	//��������
		cfStyleGrid(getObjectFirst("gr3"), "comn1");	//���ް�� ����
	}

	<% // �ʱ�ȭ �۾� %>
	function fnInit(){ 
		ds_site_joint.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT009&s_item1=Y";
        ds_site_joint.Reset(); //��������
        ds_site_main.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT010&s_item1=Y";
        ds_site_main.Reset();	//�ְ�����
		ds_site_attr1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT011&s_item1=Y";
        ds_site_attr1.Reset(); //�Ӽ�1
        ds_site_attr2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT012&s_item1=Y";
        ds_site_attr2.Reset();	//�Ӽ�2
        ds_use_yn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_use_yn.Reset();	//�������
        
        codeDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT013&s_item1=Y";
        codeDs1.Reset();	//�������
		codeDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT014&s_item1=Y";
        codeDs2.Reset();	//��������
        codeDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT015&s_item1=Y";
        codeDs3.Reset();	//������
                
        lc_site_joint.index = 0;
		lc_site_main.index = 0;
		lc_site_attr1.index = 0;
		lc_site_attr2.index = 0;
		//lc_use_yn.index = 0;
		
		
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

		/*
		 * �����ͼ� ��� ���� (����)
		 */	
		
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+
				"site_sid:INT,site_cd:STRING,site_nm:STRING,site_joint_nm:STRING,site_main_nm:STRING,site_attr1_nm:STRING,site_attr2_nm:STRING,site_joint:STRING,site_main:STRING,site_attr1:STRING,site_attr2:STRING,orderer_sid:INT,vend_cd:STRING,orderer_nm:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
		/*
		 * �����ͼ� ��� ���� (��������)
		 */
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp = ""
				+
				"{CURROW}:INT,coop_sid:INT,coop_nm:STRING,site_rate:INT,site_sid:INT";
				ds2.SetDataHeader(s_temp);
			}
		}
		/*
		 * �����ͼ� ��� ���� (������)
		 */
		function fnSetHeaderDs3(){
			if (ds3.countrow<1){
				var s_temp = ""
				+
				"site_seq_ct:STRING,site_seq_ch:STRING,site_status:STRING,date_made:STRING,date_ct:STRING,date_begin:STRING,date_end:STRING,amt_ct_tot:DECIMAL(15.0),amt_ct:DECIMAL(15.0),amt_ct_vat:DECIMAL(15.0),remarks:STRING,site_eno:STRING,rate_ac:INT,u_empno:STRING,site_sid:INT";
				ds3.SetDataHeader(s_temp);
			}
		}
		
		
		/*
		 * ���ް�� ������ȸ
		 */
		function fnSelect(){   
		
			if(getObjectFirst("v_site_nm").value.trim()=="" & getObjectFirst("v_orderer_nm").value.trim()==""){
                alert("����� �Ǵ� ����ó<%=HDConstant.A_MSG_MUST_INPUT%>");
                //getObjectFirst("v_site_nm").Focus();
                return;
            }
            
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated) {
				alert("�������� ���� �ֽ��ϴ�.");
			} else {
			    //gr1.ReDraw = "False";
		        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                    + ",dsType=1"  
		                    + ",v_site_sid="+ v_site_sid.value
							+ ",v_orderer_sid=" + v_orderer_sid.value
							; 
				//alert(v_param);
		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
		            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
		            v_param);
		        tr_post(tr1);
			}
		} 
		/*
		 * ���ް�� ��������ȸ
		 */
		function fnSelect2(row){   
					    //gr1.ReDraw = "False";
					    v_default_row = row;
					    
				        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							        + ",dsType=1"  
				                    + ",v_site_sid="+getObjectFirst("ds1").NameValue(row, "site_sid")
									+ ",v_orderer_sid="+getObjectFirst("ds1").NameValue(row, "orderer_sid");
						//alert(v_param);
				        ln_TRSetting(tr2, 
				            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
  				           "JSP(O:DS2=ds2,O:DS3=ds3)",
				            v_param);
				        tr_post(tr2);
		}
		
		/*
		 * ���ް�� ���� �ű� 
		 */
		function fnAddRowDs1(){
			if(ds2.IsUpdated || ds3.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else {
				//fnSetHeaderDs1();
				ds1.addrow();
				//site_nm.readOnly = false;
				//orderer_nm.readOnly = false;
				row.value = ds1.RowPosition;
				gr1.setcolumn("site_nm");
		        lc_site_joint.index = 0;
				lc_site_main.index = 0;
				lc_site_attr1.index = 0;
				lc_site_attr2.index = 0;
				lc_use_yn.index = 0;				
				ds2.clearall();
				ds3.clearall();
				//fnSetHeaderDs2();
				//fnSetHeaderDs3();
				return;
			}
		}
				
		/*
		 * �������� ���߰� 
		 */
		function fnAddRowDs2() {
			if (ds1.namevalue(ds1.rowposition,"site_nm") == undefined || ds1.namevalue(ds1.rowposition,"site_nm") == "" ) {
					alert('�߰��� ������� ���õ��� �ʾҽ��ϴ�.');
					gr2.setcolumn("coop_nm");
			} else {
				fnSetHeaderDs2();
				ds2.addrow();
				ds2.namevalue(ds2.rowposition, "site_sid") = ds1.namevalue(ds1.rowposition, "site_sid");
				//coop_nm.readOnly = false;
				//site_rate.readOnly = false;
				row.value = ds2.RowPosition;
				//gr2.setcolumn("coop_nm");
				
				return;
			}
		}
		
		/*
		 * ���޺����� ���߰� 
		 */
		function fnAddRowDs3() {
			
			if (ds1.namevalue(ds1.rowposition,"site_nm") == undefined || ds1.namevalue(ds1.rowposition,"site_nm") == "" ) {
					alert('�߰��� ������� ���õ��� �ʾҽ��ϴ�.');
					gr3.setcolumn("site_seq_ct");
			} else {
				fnSetHeaderDs3();
				ds3.addrow();
				ds3.namevalue(ds3.rowposition, "site_sid") = ds1.namevalue(ds1.rowposition, "site_sid");
				gr3.setcolumn("site_seq_ct");
				
				return;
			}
		}
		

		/*
		 * ������ ���� 
		 * ���� �׼ǽ� �ٷ� ����
		 */
		function fnDeleteRowDs1() {			
			if(ds2.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else if(ds3.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else{
				if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
					
					ds1.deleterow(ds1.rowposition);
					ds2.deleteall();
					ds3.deleteall();
					
					fnApply();
					
					msgTxt.innerHTML="���ް�� �������� �����Ǿ����ϴ�.";
				
					return;
				}
			}
		}

		/*
		 * �������� ����� 
		 */
		function fnDeleteRowDs2(){
			//alert("ds2����");
			ds2.deleterow(ds2.rowposition);
			msgTxt.innerHTML="�������� ���� �����Ǿ����ϴ�.";
		}

		/*
		 * ���ް�ຯ�� ����� 
		 */
		function fnDeleteRowDs3(){
			//alert("ds3����");
			ds3.deleterow(ds3.rowposition);
			msgTxt.innerHTML="���ް��_���� ���� �����Ǿ����ϴ�.";
		}

		/*
		 * ����
		 * ���ް�� ����� �߰�, �������� ���߰�, ���ް�� ���� ���߰�,���� �� ���� 
		 */
		function fnApply(){
		
			if (ds1.namevalue(ds1.rowposition,"site_joint") == undefined || ds1.namevalue(ds1.rowposition,"site_joint") == "" || ds1.namevalue(ds1.rowposition,"site_joint") == 0 ) {
				alert("�������θ� ������ �ּ���");
				return;
			}else if (ds1.namevalue(ds1.rowposition,"site_main") == undefined || ds1.namevalue(ds1.rowposition,"site_main") == "" || ds1.namevalue(ds1.rowposition,"site_main") == 0 ) {
				alert("�ְ����θ� ������ �ּ���");
				//alert(ds1.namevalue(ds1.rowposition,"site_joint"));
				//alert(ds1.namevalue(ds1.rowposition,"site_main"));
				//alert(ds1.namevalue(ds1.rowposition,"site_attr1"));
				//alert(ds1.namevalue(ds1.rowposition,"site_attr2"));
				return;
			}else if (ds1.namevalue(ds1.rowposition,"site_attr1") == undefined || ds1.namevalue(ds1.rowposition,"site_attr1") == "" || ds1.namevalue(ds1.rowposition,"site_attr1") == 0 ) {
				alert("�Ӽ�1�� ������ �ּ���");
				return;
			}else if (ds1.namevalue(ds1.rowposition,"site_attr2") == undefined || ds1.namevalue(ds1.rowposition,"site_attr2") == "" || ds1.namevalue(ds1.rowposition,"site_attr2") == 0 ) {
				alert("�Ӽ�2�� ������ �ּ���");
				return;
			}
			
			
			
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
	                "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
	                //prompt('ds1',ds1.text);
	                //prompt('ds2',ds2.text);
	                //prompt('ds3',ds3.text);
            		tr_post(tr1);
            	}
			}else {
         		alert("������Ʈ�� ���� �����ϴ�.");
		 	}
		}

		/*
		 * ��� 
		 * ���ް��, ��������, ���ް�ຯ��
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated) {
				ds1.undoall();
				ds2.undoall();
				ds3.undoall();
			}
			msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
			return;
		}

		/*
		 * ���� 
		 */
		/*
		function fnExcelGr1(){
			gr2.runexcel("�����ڵ����");
		}
		*/
		
		<%//���� ��%>
	    function fnSelSitePopup(dirPath) {
	        v_cust_row = 0;
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
	    
		<%//����ó ��%>
	    function fnCtOrdererPopup(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtOrdererPop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            v_orderer_nm.value = arrParam[1];	//NM
	            v_orderer_sid.value = arrParam[2];	//SID
	        } else {
				fnCtOrdererCleanup();
	        }               
	    }
	    <%//����ó ��2%>
	    function fnCtOrdererPopup2(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtOrdererPop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            orderer_nm.value = arrParam[1];	//NM
	            orderer_sid.value = arrParam[2];	//SID
	        } else {
				fnCtOrdererCleanup2();
	        }               
	    }
	    
	    
		<%//���»� ��%>
	    function fnSelCoopPopup(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtCoopPop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            ds2.namevalue(ds2.rowposition,"coop_nm")  = arrParam[1];	//NM
	           	ds2.namevalue(ds2.rowposition,"coop_sid")  = arrParam[2];	//SID
	        } else {
				fnSelCoopCleanup();
	        }               
	    }

	    function fnSelCoopCleanup(){
	        coop_nm.value = "";
	        coop_sid.value  = "";
	    }

	     function fnSelSiteCleanup(){
		        v_site_nm.value = "";
		        v_site_sid.value  = "";
  		 }
   
   		function fnCtOrdererCleanup(){
		        v_orderer_nm.value = "";
		        v_orderer_sid.value  = "";
  		 }
  		 
  		function fnCtOrdererCleanup2(){
		        orderer_nm.value = "";
		        orderer_sid.value  = "";
  		 }
   
		/*
		 * �Է°� üũ 
		 */
		function ln_Chk() {
			
			var row1=ds1.countrow;
			var row2=ds2.countrow;
			var row3=ds3.countrow;
			/*
			if(row1==0 || row2==0 || row3==0){
				alert("���ް��/�������/������  ������ �Է��ϼ���.");
				site_nm.focus();
				return;
			}
			*/
			for(i=1;i<=row1;i++) {
				if(ds1.namevalue(i,"site_nm")=="") {
					alert("���ް�� ���� �Է��� �ֽʽÿ�");
					site_nm.focus();
					return;
				}else if (ds1.namevalue(i,"orderer_nm")=="") {			
					alert("����ó�� �Է��� �ֽʽÿ�");
					orderer_nm.focus();
					return;
				}
			}		
			for(i=1;i<=row3;i++) {
				if(ds3.namevalue(i,"site_seq_ct")=="") {
					alert("��� ������ �Է��� �ֽʽÿ�");
					return;
				} else if (ds3.namevalue(i,"site_seq_ch")=="") {			
					alert("���� ������ �Է��� �ֽʽÿ�");
					return;
				} else if (ds3.namevalue(i,"site_status")=="") {			
					alert("��� ���¸� �Է��� �ֽʽÿ�");
					return;
				}
			}			
			return true;
		}
	</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--���ް��-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
	<param name="SyncLoad" 	value="true">
</object>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<object id=ds_site_joint classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--��������-->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_site_main classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �ְ����� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_site_attr1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �Ӽ�1 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_site_attr2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �Ӽ�2 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_use_yn classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
    <param name="SyncLoad"  value="false">
</object>

<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�������-->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������ -->
	<param name="SyncLoad" 	value="false">
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<!-- 
		������ �׸��� OnClick
	-->
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
			fnSelect2(Row);
			row.value = ds1.RowPosition;
	</script>
	<script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
		if (colid=="coop_nm") {
			fnSelCoopPopup('<%=dirPath%>');
		}
	</script>
	<script language=JavaScript for=gr3 event=OnClick(row,colid)>
		if (colid=="site_seq_ct") {
			if (ds3.namevalue(ds3.rowposition, "site_seq_ct") != ""){
				alert("��� ������ ������ �� �����ϴ�.\n���߰��� 1ȸ �Է� �����մϴ�.");
			};
		}
		if (colid=="site_seq_ch") {
			if (ds3.namevalue(ds3.rowposition, "site_seq_ch") != ""){
				alert("���� ������ ������ �� �����ϴ�.\n���߰��� 1ȸ �Է� �����մϴ�.");
			};
		}		
	</script>
		
		        
	<!-- 
		������ ���߰� 
		����Ű �Ʒ��� ������� �߰���
	-->
	<script language=JavaScript for=gr2 event=onKeyPress(keycode)>
      	if (keycode == 40 && (ds2.CountRow == ds2.RowPosition) && ds2.namevalue(ds2.rowposition,"coop_sid") != "" && ds2.namevalue(ds2.rowposition,"site_rate") != "") {
				fnAddRowDs2();
    	}
      	if (keycode == 40 && (ds3.CountRow == ds3.RowPosition) && ds3.namevalue(ds3.rowposition,"site_seq_ct") != "" && ds3.namevalue(ds3.rowposition,"site_seq_ch") != "") {
				fnAddRowDs3();
    	}
    	
 	</script>
 	<script language=javascript for=gr3 event="OnExit(Row,Colid,OldData)">
	    if(Row==0) return;
	    if(Colid=="amt_ct_vat"){
		   	ds3.NameValue(Row, "amt_ct_tot") = 	ds3.NameValue(Row, "amt_ct") + ds3.NameValue(Row, "amt_ct_vat");
	   	}
	</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	<!-- 
		������ �۾� �Ϸ�
	-->
		<script language="javascript" for="tr1" event="onsuccess()">
			msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
	<!-- 
		������ �۾� ����
	-->
		<script language="javascript" for="tr1" event="onfail()">
			msgTxt.innerHTML="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
	<!-- 
		������1 �۾� �Ϸ�
	-->		
		<script language="javascript" for="tr2" event="onsuccess()">
			msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
	<!-- 
		������1 �۾� ����
	-->
		<script language="javascript" for="tr2" event="onfail()">
			msgTxt.innerHTML="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
	<!-- 
		������2 �۾� �Ϸ�
	-->		
		<script language="javascript" for="tr3" event="onsuccess()">
			msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
	<!-- 
		������2 �۾� ����
	-->
		<script language="javascript" for="tr3" event="onfail()">
			msgTxt.innerHTML="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' > 
  <tr>
	<td align='right'>
		<table border='0' cellpadding='0' cellspacing='0' width='845px'>
		  <tr>
			<td height='25px' align='right'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" 	onclick="fnSelect()">
				<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:pointer"   onClick="fnAddRowDs1()" >
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" 	onClick="fnApply();">
				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"   onclick="fnCancel()">
			</td>
		  </tr>
		</table>
	</td>
  </tr>
    <tr>
        <td >
            <table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
            	<tr>
                	<td align="center" class="text" width="70">�����</td>
                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="�� �����">
                    </td>
                    <td align="center" class="text" width="70">����ó</td>
                    <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_orderer_nm' id="v_orderer_nm" style="width:200px;" class='input01'  onkeydown="if(event.keyCode==113) fnCtOrdererPopup('<%=dirPath%>');" readOnly="readonly">
                        <input type="hidden"  name='v_orderer_sid' id='v_orderer_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererPopup('<%=dirPath%>');" alt="��ȸâ ��">
                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererCleanup();" alt="�� �����">
                    </td>
                </tr>					
			</table>
		</td>
	</tr>
	<tr height="12">
		<td></td>
  </tr>	
  <tr>
	<td>
		<table cellpadding="0" cellspacing="0">
		  <tr>
			<td class="l t" width="505px" >
				<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width:505px; height:312px" border="1">
					<param name="DataID"			value="ds1">
					<param name="BorderStyle"   	value="0">
					<param name="Fillarea"			value="true">
					<param name="ColSizing"     	value="true">
					<param name="IndWidth"     		value="0">
					<param name="editable"      		value="true">
					<param name="ViewSummary"       value="1">
					<param name="LineColor" 		value="#dddddd">
					<param name="Format"		value="  
						<C> name='����\\��ȣ' 	ID='site_sid'    width=50 	align=CENTER	 Edit=None show=true SumText='��' </C>
						<C> name='���������' 	ID='site_nm' 	 Width=182  align=left 	 Edit=None editlimit=100 SumText=@count</C>
						<C> name='����ó'  		ID='orderer_nm'  Width=115  align=center Edit=None editlimit=50	</C>			
						<C> name='�����' 	ID='site_nm_s'  width=80 	align=CENTER	Edit=None </C>
						<C> name='�����ڵ�' ID='pu_site_cd'  width=60 	align=CENTER	Edit=None </C>
						<C> name='��ȭ' 	ID='site_tel'  width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='�ѽ�' 	ID='site_fax'  width=60 	align=CENTER	Edit=None show=false</C>

						
						<C> name='��������' 	ID='site_joint'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='�ְ�����' 	ID='site_main'    	width=60 	align=CENTER	Edit=None show=false</C>											
						<C> name='�Ӽ�1' 		ID='site_attr1'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='�Ӽ�2' 		ID='site_attr2'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='��������_NM' 	ID='site_joint_nm'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='�ְ�����_NM' 	ID='site_main_nm'    	width=60 	align=CENTER	Edit=None show=false</C>											
						<C> name='�Ӽ�1_NM' 	ID='site_attr1_nm'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='�Ӽ�2_NM' 	ID='site_attr2_nm'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='����óSID' 	ID='orderer_sid'  width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='���ֻ��̸�' 	ID='orderer_nm'  width=60 	align=CENTER	Edit=None show=false</C>
					">
				</object>
			</td>

			<td class="r t " width="340px">
				<table border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td class="t">
						<table border='0' cellpadding='0' cellspacing='1' bgcolor="#666666">
						  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">�����</td>
							<td colspan="3"  bgcolor="#FFFFFF" align="left">&nbsp;
								<input id="site_nm" type="text" class="textbox"   size="30" value="" maxlength="100" onBlur="bytelength(this,this.value,100);">
							</td>
						  </tr>
		                  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">����ó</td>
							<td bgcolor="#FFFFFF"  colspan="3" align=left>&nbsp;&nbsp;<input type="text" name='orderer_nm'  id="orderer_nm" size="23" class='input01'  onkeydown="if(event.keyCode==113) fnCtOrdererPopup2('<%=dirPath%>');" readOnly="readonly">
								<input type="hidden"  name='orderer_sid' id='orderer_sid'>
			                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererPopup2('<%=dirPath%>');" alt="��ȸâ ��">
			                    <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererCleanup2();" alt="�� �����">
							</td>
						  </tr>	
						  <tr>
							<td height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">�����</td>
		                    <td width="100px" class="l" bgcolor="#ffffff">&nbsp;
		                    	<input id="site_nm_s" type="text" class="textbox"   size="13" maxlength="10" ></td>
                   			<td width="60px" bgcolor="#eeeeee" align="center" class="boardt02">�����ڵ�</td>
		                    <td width="100px" class="l" bgcolor="#ffffff">&nbsp;
		                    	<input id="pu_site_cd" type="text" class="textbox"   size="10" maxlength="4" ></td>   			                        
						  </tr>
						  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">��ȭ</td>
		                    <td align=left bgcolor="#ffffff">&nbsp;
		                    	<input id="site_tel" type="text" class="textbox"   size="13" maxlength="20" ></td>
                   			<td bgcolor="#eeeeee" align="center" class="boardt02">�ѽ�</td>
		                    <td class="l" bgcolor="#ffffff">&nbsp;
		                    	<input id="site_fax" type="text" class="textbox"   size="13" maxlength="20" ></td>   			                        
						  </tr>
						  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">��������</td>
		                    <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
		                    	<object id=lc_site_joint classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
		                        	<param name=ComboDataID     value=ds_site_joint>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                        </td>
							<td bgcolor="#eeeeee" align="center" class="boardt02">�ְ�����</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_site_main classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_site_main>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                        </td>   			                        
						  </tr>
						  <tr>
							<td  height="24px" bgcolor="#eeeeee" align="center" class="boardt02">�Ӽ�1</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_site_attr1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_site_attr1>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                            
	                        </td>
							<td bgcolor="#eeeeee" align="center" class="boardt02">�Ӽ�2</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_site_attr2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_site_attr2>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                            
	                        </td>  
		                  </tr>
						  <tr>
							<td  height="24px" bgcolor="#eeeeee" align="center" class="boardt02">���</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_use_yn>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                            
	                        </td>
							<td bgcolor="#eeeeee" align="center" class="boardt02"></td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            
	                        </td>  
		                  </tr>		                  
						</table>
					</td>
				  </tr>
				  <tr>
					<td class="r" style='padding-top:6px;padding-bottom:4px;'>
						<table border= "0" cellpadding=0 cellspacing=0 width="100%" >
							<tr>
								<td class="l">�� ��������</td>
								<td class="r">
									<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDs2()" >
									<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRowDs2()" >
								</td>
							</tr>
						</table>					
					</td>
				  </tr>

				  <tr>
					<td class="l t">
						<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr2  style="width:323px; height:100px" border="1">
							<param name="DataID"			value="ds2">
							<param name="BorderStyle"   	value="0">
							<param name="Fillarea"			value="true">
							<param name="ColSizing"     	value="true">
							<param name="IndWidth"     		value="0">
							<param name="editable"      	value="true">
							<param name="ViewSummary"       value="1">
							<param name="LineColor" 		value="#dddddd">
							<param name="Format"		value="  
								<C> name='��' 		ID='{CURROW}'   Width=50  align=center SumText='�Ѱ�' </C>
								<C> name='ȸ��sid' 	ID='coop_sid' 	 Width=125  align=left editlimit=50 show=false decao=0</C>
								<C> name='ȸ��' 	ID='coop_nm' 	 BgColor=#D7FFDA Width=183  align=left editlimit=50  SumText=@count editstyle=popup </C>
								<C> name='����(%)'  ID='site_rate'   Width=70 align=center editlimit=70 SumText=@sum	decao=0</C>				
								<C> name='Sitesid' 	ID='site_sid' 	 Width=125  align=left editlimit=50 show=false decao=0 </C>							
							">
						</object>
					</td>
				  </tr>
				</table>
			</td>

		  </tr>
		</table>
	</td>
  </tr>
	<tr>
		<td height="7"></td>
	</tr>
	<tr>
		<td height="10">
			<table border= "0" cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td class="l">�� �������</td>
					<td class="r">
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDs3()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRowDs3()" >
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		<td align="left" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
			<table border='0' cellpadding='0' cellspacing='0' width="845px"> 
				<tr>
					<td>
							<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gr3"  style="WIDTH:845px;HEIGHT:200px" border="1">
								<param name="DataID"		value="ds3">
								<param name="BorderStyle"   value="0">
								<param name="Fillarea"		value="true">
								<param name="ColSizing"		value="true">
								<param name="IndWidth"		value="0">
								<param name="ViewSummary"       value="1">
								<param name="Editable"      value="true">
								<param name=SortView  		value="RIGHT">
								<param name="Format"		value="  
								    <C> name='���\\����' 	 ID='site_seq_ct'    BgColor=#D7FFDA	Width=50 	align=left editlimit=5 show=true 	sort=true	SumText='��' editstyle=lookup data='codeDs1:detail:detail_nm'</C>
								    <C> name='����\\����' 	 ID='site_seq_ch'    BgColor=#D7FFDA	Width=50 	align=left editlimit=5 show=true  	sort=true	editstyle=lookup data='codeDs2:detail:detail_nm' SumText=@count</C>
								    <C> name='���\\����' 	 ID='site_status'    Width=50	align=left editlimit=10 show=true 	sort=true editstyle=lookup data='codeDs3:detail:detail_nm'</C>
								    <C> name='�ۼ�����'      ID='date_made'       Width=80 	align=left  show=false sort=true</C>
								    <C> name='�������'      ID='date_ct'     	Width=75 	align=center show=true 	sort=true mask='XXXX-XX-XX'</C>
								    <C> name='��������'      ID='date_begin'	Width=75 	align=center show=true sort=true mask='XXXX-XX-XX'</C>
								    <C> name='��������'		 ID='date_end'      Width=75 	align=center show=true sort=true mask='XXXX-XX-XX'</C>
								    <C> name='���ް���'      ID='amt_ct'      	Width=102 		align=right editlimit=15 show=true	SumText=@sum	decao=0</C>
								    <C> name='�ΰ���'        ID='amt_ct_vat'    Width=90 	align=right editlimit=15 show=true	SumText=@sum	decao=0</C>
								    <C> name='���ݾ�'      ID='amt_ct_tot'    Width=110 	edit=none align=right editlimit=15 show=true	SumText=@sum	decao=0</C>
								    <C> name='������\\(%)'   ID='rate_ac'       Width=50 	align=center show=true	decao=0</C>
								    <C> name='���'        	 ID='remarks'       Width=100 	align=left editlimit=50 show=true</C>
								    <C> name='���ڰ�༭\\��ȣ'        	ID='site_eno'       Width=80 	align=left  show=false </C>
								    
								    <C> name='U_EMPNO'    ID='u_empno'     Width=50 	align=left editlimit=7 show=false</C>
   									<C> name='Sitesid' 		ID='site_sid' 	Width=125  align=left editlimit=50 show=false decao=0 </C>							
								">
							</object>
						
					</td>
				</tr>
			</table>
			�� ���� �Է½� �������="��ü", ��������="-", ������="����"���� �Է��� �ּ���.<br>
			�� �� �� ������ ��������� ���������� �������� �ʽ��ϴ�. ������ �ּ���.
			  
			
		</td>																		
	</tr>
</table>											
<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>	

        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=site_sid 	 	    	Ctrl=site_sid	 	       Param=value </C>
                    <C>Col=site_cd         		Ctrl=site_cd 	           Param=value </C>
                    <C>Col=site_nm  	       	Ctrl=site_nm 	           Param=value </C>
                    <C>Col=site_nm_s  	       	Ctrl=site_nm_s 	           Param=value </C>
                    <C>Col=pu_site_cd 	       	Ctrl=pu_site_cd	           Param=value </C>
                    <C>Col=site_tel  	       	Ctrl=site_tel	           Param=value </C>
                    <C>Col=site_fax 	       	Ctrl=site_fax 	           Param=value </C>
                    
                    <C>Col=site_joint 	        Ctrl=lc_site_joint             Param=BindColVal </C>
                    <C>Col=site_main 	        Ctrl=lc_site_main             Param=BindColVal </C>
                    <C>Col=site_attr1 	        Ctrl=lc_site_attr1             Param=BindColVal </C>
                    <C>Col=site_attr2 	        Ctrl=lc_site_attr2             Param=BindColVal </C>
                    <C>Col=use_yn	 	        Ctrl=lc_use_yn             Param=BindColVal </C>
                    <C>Col=orderer_sid   	  	Ctrl=orderer_sid	       Param=value </C>
                    <C>Col=orderer_nm   	  	Ctrl=orderer_nm	       Param=value </C>                    
                    <C>Col=coop_sid      	    Ctrl=coop_sid             Param=valuel </C>
                    <C>Col=site_rate 		    Ctrl=site_rate   		   Param=value </C>
                    <C>Col=site_seq_ct         Ctrl=site_seq_ct          Param=value </C>
                    <C>Col=site_seq_ch        Ctrl=site_seq_ch          Param=value </C>
                    <C>Col=site_status    	 	Ctrl=site_status    	   Param=value </C>
                    <C>Col=date_ct 			    Ctrl=date_ct	           Param=value </C>
                    <C>Col=date_begin    	    Ctrl=date_begin 	       Param=value </C>
                    <C>Col=date_end		    Ctrl=date_end		       Param=value </C>
                    <C>Col=amt_ct_tot          Ctrl=amt_ct_tot            Param=value </C>
                    <C>Col=amt_ct        		Ctrl=amt_ct 		       Param=value </C>
                    <C>Col=amt_ct_vat          Ctrl=amt_ct_vat           Param=value </C>
                    <C>Col=date_made          Ctrl=date_made           Param=value </C>
                    <C>Col=site_eno     	    Ctrl=site_eno 	           Param=value </C>
                    <C>Col=rate_ac         		Ctrl=rate_ac	           Param=value </C>
            ">
        </object>
         
		<input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		