<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - �ý��۸� 	     : �Ա� ���
 - ���α׷�ID 	 : PMS/SI010I
 - J  S  P		     : si015i.jsp
 - �� �� ��		 : Si010I
 - �� �� ��		 : ������
 - �� �� ��		 : 2012-07-12
 - �������		 : 
 - [ �������� ][������] ����
 - [2012-05-21][������] �ű�
 =============================================================================*/
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid ���� 
		fnInit();	
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {

	    v_job ="I";
        ds_ingb_cd_0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SI001&s_item1=Y";
        ds_ingb_cd_0.Reset();  //�Է±��� 
        
        ds_ingb_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd.Reset();  //�Է±��� 
        
        ds_adpaygb.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI003&s_item1=Y";
        ds_adpaygb.Reset();  //�����ݱ��� 
        

    
	    //ds_tax_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	    //ds_tax_knd.Reset();  //��������[����]
	    
	    //ds_tax_div.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	    //ds_tax_div.Reset();   //�ͼӱ���[����]
	    
	    //ds_gubun.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2200"; 
	    //ds_gubun.Reset();   //���౸��
	    
        //ds_inout_gb.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI002&s_item1=Y";
        //ds_inout_gb.Reset();	//�ⳳ����
        
		//ds_card_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1134";
	    //ds_card_knd.Reset();   //ī������
	    
	    //ds_non_pay.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1011";
	    //ds_non_pay.Reset();   //�̺ұ���
	    
	    
        vt_fr_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        vt_fr_inout_dt.Text = vt_fr_inout_dt.Text .substring(0,6)+"01";
        vt_to_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        vt_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        v_chk_cost.checked = true;
        v_chk_ingb.checked = true;

        //vt_fr_inout_dt.Text = "20120401";
        //vt_to_inout_dt.Text = "20120430";
        
        v_empnmk.value=gusrnm;
        v_empno.value=gusrid;
            
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si010I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);              
    }
    
    
    
    <%//���� ��ȸ  %>
    function fnSelect() {
		if (ds_default.IsUpdated ) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";
		    
	        var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	        
	        
	       if(v_cost_cd_0.value==""){
	       		alert("������ �ʼ��׸��Դϴ�.");
	       		return false;
	       }
	
	        if(fr_date.length!=8) {
	            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        
	        if(to_date.length!=8) {
	            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                         + ",v_cost_cd=" + v_cost_cd_0.value
	                         + ",v_ingb_cd=" + lc_ingb_cd_0.bindcolval
	                         + ",v_fr_inout_dt =" + fr_date
	                         + ",v_to_inout_dt =" + to_date
	                         + ",v_empno =" + v_empno.value
	                         + ",v_inout_gb =2" ;  // 2:�Ա� 
	                        
	                 
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si010I1",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	            //prompt('',param);
	        tr_post(tr1);
		}
    }    

	<%//���� %>
	function fnApply(){
		v_job = "A";
		var row=ds_default.countRow;
		
		if (ds_default.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si010I1",
                "JSP(I:DS_DEFAULT=ds_default)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
                
               // prompt('',ds_default.text );
               
                + ",v_userid =" + gusrid;
            
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%//�Է°� üũ %>
	function ln_Chk() {
	
	   //�ۼ��� üũ : ������ ���θ� ������. 

		for(i=1;i<=ds_default.countrow;i++) {
		   //�ʼ��׸� üũ 
		   
		   if(ds_default.RowStatus(i)==1||ds_default.RowStatus(i)==2||ds_default.RowStatus(i)==3) {
		   
		       if(ds_default.RowStatus(i)==2 ||ds_default.RowStatus(i)==3){ //����  ������ �ۼ��ڿ� ��
		           
		            //alert("EMPNO::"+ds_default.namevalue(i,"I_EMPNO")+"::gusrid::"+gusrid);
		       		if(gusrid != "3150005" && gusrid != "6060002" && gusrid != "2020013"){		       
		       
			       		if(ds_default.namevalue(i,"I_EMPNO")!=gusrid){
			       			alert("���� �� ���� ������ �������� �ʽ��ϴ�.");
			       			return false;
			       		}
		       		}
		       		
		       }
		       
		       //��꼭 �ۼ��� �����Ұ�
		       if(ds_default.namevalue(i,"TAXNBR")!=""){
		       		alert("��꼭�� �ۼ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
		       		return false;
		       }
		       
		       //��ǥ �ۼ��� �����Ұ� 
		       if(ds_default.namevalue(i,"FSDAT")!=""){
		       		alert("��ǥ�� �ۼ��Ǿ����ϴ�. ������ �� �����ϴ�.");
		       		return false;
		       }
		    
			   //���� 
			   if(ds_default.namevalue(i,"COST_CD")=="") {
			   		alert("�����ڵ带 �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //������
			   if(ds_default.namevalue(i,"COST_NM")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //�Է±��� 
			   if(ds_default.namevalue(i,"INGB_CD")=="") {
			   		alert("�Է±�����  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			   //������ ���� 
			   if(ds_default.namevalue(i,"ADPAYGB")=="") {
			   		alert("�����ݱ�����  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			  
			   
			    //���������ڵ�
			   if(ds_default.namevalue(i,"ATCODE")=="") {
			   		alert("�����ڵ带  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //���������
			   if(ds_default.namevalue(i,"ATKORNAM")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			   /*********************************************
			    //2012.06.20 JYS ������ �ӽ÷� �ʼ��׸񿡼� ���� 
			    //�����ڵ�
			   if(ds_default.namevalue(i,"BID_SITE_KIND")=="") {
			   		alert("�����ڵ带  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //������
			   if(ds_default.namevalue(i,"BID_SITE_KIND_NM")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   ************************************************/
			   
			    //�������� --�ʼ��׸��� �ƴ�.
			  
			   if(ds_default.namevalue(i,"SUPAMT")=="") {
			   		alert("���ް��� �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			      
			   if(ds_default.namevalue(i,"SUMAMT")=="") {
			   		alert("�հ踦 �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			    
			   //���ް�+�ΰ��� = �հ�  
			   if(Number(ds_default.namevalue(i,"SUMAMT"))!=Number(ds_default.namevalue(i,"SUPAMT"))+Number(ds_default.namevalue(i,"VATAMT"))) {
			   		alert("���ް�+�ΰ���=�հ谡 ���� �Ƚ��ϴ�. ");
			   		return false;
			   } 
			   
			     //�Ա���������
			   if(ds_default.namevalue(i,"INOUT_DT")=="") {
			   		alert("�Ա��������ڸ�  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   			   
			   if(ds_default.namevalue(i,"INOUT_DT").length!=8) {
			   		alert("�Ա����ڸ�  Ȯ���� �ֽʽÿ�");
			   		return false;
			   }
			   
			    
			    
			    //�ŷ�ó�� 
			   if(ds_default.namevalue(i,"VEND_NM")=="") {
			   		alert("�ŷ�ó���� �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			    
			    //����
			   if(ds_default.namevalue(i,"REMARK")=="") {
			   		alert("���並 �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			   
				    
				//�ⳳ����
				if(ds_default.namevalue(i,"INOUT_GB")=="") {
			   		alert("�ⳳ������  �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			   
			  		
			   
			}//RowStatus
		} //for		
		return true;
	}

    
      <%//��-üũ %>
    function fnSelPopChk() {
         return true;
    	 if(ds_default.CountRow==0){
            alert("�ű� ��ư���� �� ���� �߰��Ͻñ� �ٶ��ϴ�.");
            return false;
        }
        return true;
    }
    
    
    <%//���� ��- ��ȸ%>
    function fnSelCostPop_0(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }
    
    <%//�ۼ��� ��- ��ȸ%>
    function fnSelEmpPopup(dirPath){
    	var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiEmpPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_empno.value = arrParam[0];	//
            v_empnmk.value = arrParam[1];	//
        } else {
			fnSelEmpCleanup();
        }               
    }
    
    <%//���� ��- �Է�%>
    function fnSelCostPop(dirPath) {
        if(!fnSelPopChk()) return;
            
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm.value = arrParam[1];	//
            v_cost_cd.value = arrParam[0];	//
        } else {
			fnSelCostCleanup();
        }               
    }

	<%//�����ڵ�%>
    function fnSelAccPopup(dirPath) {
        if(!fnSelPopChk()) return;
          
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnSiAccPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_atkornam.value = arrParam[1]; //NM
            v_atcode.value = arrParam[0];	//cd
        } else {
			fnSelAccCleanup();
        }               
    }
    

	<%//�ŷ�ó ��- �Է�%>
    function fnSelVendPopup(dirPath) {
        if(!fnSelPopChk()) return;
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCustPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_vend_cd.value  = arrParam[0];
			v_vend_nm.value = arrParam[1]; 
        } else {
			fnSelVendCleanup();
        }               
    }
    
  
   
    function fnSelCostCleanup_0(){
        v_cost_nm_0.value = "";
        v_cost_cd_0.value  = "";
    } 
    
    function fnSelCostCleanup(){
        v_cost_nm.value = "";
        v_cost_cd.value  = "";
    }
    
    function fnSelAccCleanup(){
        v_atkornam.value = "";
        v_atcode.value  = "";
    }
   
    
    function fnSelVendCleanup(){
        v_vend_cd.value = "";
        v_vend_nm.value  = "";
    }
    
    function fnSelEmpCleanup(){
    	 v_empno.value = "";
         v_empnmk.value = "";
    }
   
	<%// ������ �ű� %>
	function fnAddRowDsDefault(){
		v_job="N";
		var str_cost_nm=v_cost_nm.value;
		var str_cost_cd =v_cost_cd.value;
		ds_default.addrow();	
		fnAddSetting();
		var str_ingb_cd=lc_ingb_cd.bindcolval;
		
		//alert("v_chk_cost.checked::"+v_chk_cost.checked);
		if(v_chk_cost.checked==true){
			v_cost_nm.value = str_cost_nm;
			v_cost_cd.value = str_cost_cd;
		}
		
		if(v_chk_ingb.checked==true){
			lc_ingb_cd.bindcolval = str_ingb_cd;
		}
		
		
		//ds_ingb_cd.namevalue(ds_ingb_cd.rowposition,"INGB_CD")=3;
	}
	
	<%//�ű� �߰��� ���� %>
	function fnAddSetting(){
		vt_inout_dt.text = "<%=DateUtil.getCurrentDate(8)%>";
		ds_default.namevalue(ds_default.rowposition,"INOUT_GB")=2; //�Ա� 
		ds_default.namevalue(ds_default.rowposition,"ATCODE")="1112500"; //�Ա� 
		ds_default.namevalue(ds_default.rowposition,"ATKORNAM")="������"; //�Ա� 
		lc_ingb_cd.bindcolval=3;   //������ 
						
	}

	<%// ������ ���� %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("�������� �۾��� �־� ������ �� �����ϴ�.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
		msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�հ�ݾ� �ڵ���� %>	
	<script language=JavaScript for=ds_default  event=onColumnChanged(row,colid)>
	
		if(colid=="SUPAMT"||colid=="VATAMT"){
			ds_default.namevalue(row,"SUMAMT") = ds_default.namevalue(row,"SUPAMT") + ds_default.namevalue(row,"VATAMT") ;
		}
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
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
		}
	</script>
	
	<script language=javascript for="ds_ingb_cd_0" event="OnLoadCompleted(row)">
		for(var i =1 ;i<=row ;i++){
      		if(ds_ingb_cd_0.namevalue(i,"DETAIL")!=3){
      			ds_ingb_cd_0.RowMark(i)=1;
      		}
      	}
		ds_ingb_cd_0.DeleteMarked();
	</script>
	
	<script language=javascript for="ds_ingb_cd" event="OnLoadCompleted(row)">
		for(var i =1 ;i<=row ;i++){
      		if(ds_ingb_cd.namevalue(i,"DETAIL")!=3){
      			ds_ingb_cd.RowMark(i)=1;
      		}
      	}
		ds_ingb_cd.DeleteMarked();
		ds_ingb_cd.namevalue(ds_ingb_cd.rowposition,"DETAIL")=3;
	</script>
	
	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ȸ-->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_ingb_cd_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ingb_cd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_adpaygb classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �����ݱ���-->
    <param name="SyncLoad"  value="True">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDsDefault()" >
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td align="center" class="text" width="70">����</td>                                                                     
                                    <td bgcolor="#FFFFFF" >&nbsp;
                                        <input type="text" name='v_cost_nm_0' id="v_cost_nm_0" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_0('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_cost_cd_0' id='v_cost_cd_0'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif"  align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="�� �����">
                                    </td>
                                    <td align="center" class="text" width="70">�Է±���</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
			                            <object id=lc_ingb_cd_0 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150  width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_ingb_cd_0>
                                            <param name=BindColumn       value="detail">
                                            <param name=BindColVal         value="detail">
                                            <param name=EditExprFormat   value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat   value="detail_nm^0^100">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">�ⳳ����</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp<%=HDConstant.COMMENT_START%>
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="YYYY-MM-DD">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=vt_to_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="YYYY-MM-DD">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>   
			                        <td align="center" class="text" width="70">�ۼ���</td>
                                   <td bgcolor='#ffffff' >&nbsp;
									    <input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" readOnly="readonly">
			                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelEmpPopup('<%=dirPath%>');" alt="��ȸâ ��">
			                            <input type="text"  name='v_empno'   id='v_empno'  style="width:70px;" class='input01'  readOnly="readonly">
									</td>
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='233px' border='1'>
                                <param name="DataID"                  value="ds_default">
                                <param name="ColSizing"              value="true">
                                <param name="Editable"                value="false">
                                <param name="BorderStyle"          value="0">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                 value="
                                     <C> name='�Է±���'	   ID='INGB_CD'    	         width=90 	align=CENTER	 editstyle=lookup Data='ds_ingb_cd:detail:detail_nm'</C>
                                     <C> name='����'	   	       ID='INOUT_DT' 		         width=69 	align=CENTER	 mask='XXXX/XX/XX'   sumtext='��'   sumtextalign='center'</C>
                                     <C> name='����'            ID='ATKORNAM'       	     width=140 	align=left 		     sumtext='@cnt' sumtextalign='center'</C>
									 <C> name='����' 		   ID='BID_SITE_KIND_NM'  width=60 	align=left       	 sumtext='��'</C>
									 <C> name='���ް�' 		   ID='SUPAMT'    	         width=80 	align=right    	 sumtext='@sum'  </C>
                                     <C> name='�ΰ���'  	   ID='VATAMT'                   width=60 	align=right 		 sumtext='@sum'  </C>
                                     <C> name='��'    	       ID='SUMAMT'   	              width=80 	align=right 	     sumtext='@sum'  </C>
                                     <C> name='���԰��ް�'   ID='XSUPAMT'   	          width=80 	align=right 	     sumtext='@sum'   show=false</C>
                                     <C> name='����'   	       ID='REMARK'   	              width=120 	align=left   	     </C>
                                     <C> name='�ŷ�ó'    	   ID='VEND_NM'      	          width=120 	align=left  	    </C>
                                     <C> name='�ŷ�ó�ڵ�'   ID='VEND_CD'      	          width=70 	align=left  	    </C>
                                     <C> name='��������'      ID='TAX_KND'	              width=60 	align=left  	     editstyle=lookup Data='ds_tax_knd:CDCODE:CDNAM' show=false</C>
                                     <C> name='�ͼӱ���'	   ID='TAX_DIV'    	              width=80 	align=left 	         editstyle=lookup Data='ds_tax_div:CDCODE:CDNAM'  show=false</C>
                                     <C> name='�ⳳ'	           ID='INOUT_GB'    	          width=80 	align=left 	         editstyle=lookup Data='ds_inout_gb:detail:detail_nm' show =false</C>
                                     <C> name='������'	       ID='OWNER_NM'              width=60 	align=center 	 show=false </C>
                                     <C> name='ī���ȣ'	   ID='CARD_NUM'              width=125 	align=center 	 mask='XXXX-XXXX-XXXX-XXXX'  show=false</C>
                                     <C> name='�ڻ��ȣ'	   ID='H_ASTNBR'    	          width=80 	align=center 	 show=false </C>
                                     <C> name='�����ڵ�'	   ID='COST_CD'    	          width=50 	align=center 	 </C>
                                     <C> name='������'	       ID='COST_NM'    	          width=80 	align=left 	 </C>
                                     <C> name='��꼭��ȣ'  ID='TAXNBR'       	          width=80 	align=center 	mask='XXXXXXX-XXXX'  show=false</C>
                                     <C> name='��������'      ID='FSDAT'       	          width=60 	align=center 	show=false</C>
                                     <C> name='������ȣ'      ID='FSNBR'       	          width=60 	align=center     show=false</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
        	<td>
        		<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
        			<tr height="21px">
        				<td width="80px"  class="boardt02">
        					<input type="checkbox"  name='v_chk_cost'   id='v_chk_cost'  style="width:20px;" >����
        				</td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_cost_nm' id="v_cost_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_cost_cd' id='v_cost_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick=" fnSelCostPop('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
	
						<td width="80px" class="boardt02">
							<input type="checkbox"  name='v_chk_ingb'   id='v_chk_ingb'  style="width:20px;" >�Է±���
						</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_ingb_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
								<param name=ComboDataID    value=ds_ingb_cd>
								<param name=BindColumn      value="detail">
								<param name=BindColVal        value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">�����ݱ���</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_adpaygb classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
								<param name=ComboDataID    value=ds_adpaygb>
								<param name=BindColumn      value="detail">
								<param name=BindColVal        value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>	
					<tr>	
						<td width="70px" class="boardt02">�������� </td>
        				<td bgcolor='#ffffff' colspan="7">&nbsp;
						    <input type="text" name='v_atkornam' id="v_atkornam" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelAccPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_atcode' id='v_atcode'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelAccPopup('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
        			</tr>
        			
        			<tr>	
						<td width="70px" class="boardt02">���ް� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_supamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text            value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">�ΰ��� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_vatamt   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">�հ� </td>
        				<td bgcolor='#ffffff'  >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_sumamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
						<td width="70px" class="boardt02">�Ա�����</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=vt_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly     value="false">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object><%=HDConstant.COMMENT_END%>  
						</td>
        			</tr>
        			<tr>	
						<td width="70px" class="boardt02">�ŷ�ó </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_vend_nm' id="v_vend_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelVendPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_vend_cd' id='v_vend_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelVendPopup('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
						
						<td width="70px" class="boardt02">���� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark' id="v_remark" style="width:250px;" class='input02' >
						</td>
        			</tr>
        		
        		</table>
        	</td>	
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
    </table>

<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=COST_CD                Ctrl=v_cost_cd          Param=Value </C>
					<C>Col=COST_NM                Ctrl=v_cost_nm         Param=Value </C>
					<C>Col=INGB_CD                  Ctrl=lc_ingb_cd         Param=BindColVal </C>
					<C>Col=INOUT_DT                 Ctrl=vt_inout_dt         Param=Text </C>
					<C>Col=ATCODE                    Ctrl=v_atcode           Param=Value </C>
					<C>Col=ATKORNAM               Ctrl=v_atkornam        Param=Value </C>
					<C>Col=SUPAMT                    Ctrl=vt_supamt         Param=Text </C>
					<C>Col=VATAMT                     Ctrl=vt_vatamt           Param=Text </C>
					<C>Col=SUMAMT                    Ctrl=vt_sumamt        Param=Text </C>
					<C>Col=REMARK                    Ctrl=v_remark            Param=Value </C>
					<C>Col=VEND_CD                  Ctrl=v_vend_cd         Param=Value </C>
					<C>Col=VEND_NM                 Ctrl=v_vend_nm         Param=Value </C>
					<C>Col=ADPAYGB                 Ctrl=lc_adpaygb        Param=BindColVal </C
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		