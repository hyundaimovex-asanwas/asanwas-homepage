<!--*************************************************************************
* @source      : acqa010.jsp												*
* @description : Action Plan > ��ϰ��� > �󸶳� �� ������ �ΰ���!!!! 	*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/13            �̵���       �����ҿ� ���� �����Ծ ���м���		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���� ��ȹ ���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>



	<!-- ÷�� ������ ���� -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->



    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var obj = new String();
        
		obj.app_cmt = "";

        var dsTemp = window.dialogArguments;

        var status = "";//���� Ȯ�� ����

        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	var ENO_NO_SHR = gusrid; 

            trT_ACT_PLANLIST.KeyValue = "tr(O:dsT_ACT_PLANLIST=dsT_ACT_PLANLIST)";
            trT_ACT_PLANLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR;
            trT_ACT_PLANLIST.post();               

        }


        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {


        }


        /***********************************
         * 			03. ���� �Լ�  			*
         ***********************************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;
            
			trT_ACT_PLANLIST_SAV.KeyValue = "tr(I:dsT_ACT_PLANLIST=dsT_ACT_PLANLIST, I:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
			trT_ACT_PLANLIST_SAV.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SAV";
			trT_ACT_PLANLIST_SAV.post();

        }


        
        /***********************************
         * 			04. ���� �Լ�  			*
         ***********************************/
        function fnc_Delete() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        
        
        /***********************************
         * 			05. �μ� �Լ�  			*
         ***********************************/
        function fnc_Print() {


        }

        
        
        /***********************************
         * 			06. ���� ���� �Լ�  	*
         ***********************************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /***********************************
         * 			07. �ű� �Լ�  			*
         ***********************************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���.
			fnc_InputEnable();
			
			dsT_ACT_PLANLIST.InsertRow(1);
			

        }

        
        /***********************************
         * 			08. �߰� �Լ� 		 	*
         ***********************************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���
			
        }
		
		

        /***********************************
         * 			09. ���� �Լ�  			*
         ***********************************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if(dsT_ACT_APPROVAL.CountRow < 2){
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			dsT_ACT_APPROVAL.DeleteRow(1);
			
        }

        
        
        /***********************************
         * 			10. �ʱ�ȭ �Լ�  		*
         ***********************************/
        function fnc_Clear() {

        	dsT_ACT_PLANLIST.ClearData();
			dsT_ACT_APPROVAL.ClearData();

            fnc_InputEnable();

	        fnc_OnLoadProcess();

			document.getElementById("resultMessage").innerText = ' ';

        }

        
        
        /***********************************
         * 			11. ȭ�� ����(�ݱ�) 	*
         ***********************************/
        function fnc_Exit() {


        }
        
        
        

        /***********************************
         * 		12. �˻� ���� ��ȿ�� �˻�  *
         ***********************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        
        
        
        
        /***********************************
         * 		13. ���� ��ȿ�� üũ  		*
         ***********************************/
        function fnc_SaveItemCheck() {

			if (!dsT_ACT_PLANLIST.IsUpdated && !dsT_ACT_APPROVAL.IsUpdated) {
                alert("����� �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

           //if(dsT_ACT_APPROVAL.CountRow < 1){
           //    alert("Ȯ�μ��� 1���̻� �����ϼž� �մϴ�!");
           //     return false;
           // }

            if(document.getElementById("txtDOC_GB1").value == ""){
                alert("��з��� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtDOC_GB1").focus();
                return false;
            }
            
            if(document.getElementById("txtDOC_GB2").value == ""){
                alert("�ߺз��� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtDOC_GB2").focus();
                return false;
            }
            
            if(document.getElementById("txtDOC_GB3").value == ""){
                alert("���κз��� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtDOC_GB3").focus();
                return false;
            }
            
            if(document.getElementById("cmbDOC_STATUS").value == "" ){
                alert("�����Ȳ�� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("cmbDOC_STATUS").focus();
                return false;
            }            
            
            if(document.getElementById("txtDOC_TITLE").value == ""){
            	alert("���� ������ �Է��Ͻñ� �ٶ��ϴ�.");
            	document.getElementById("txtDOC_TITLE").focus();
            	return false;
            }

            if(dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition, "FILE_KEY") == ""){
            	alert("������ ÷���Ͻñ� �ٶ��ϴ�.");

            	return false;
            }
            
			return true;

        }

        
        /***********************************
         *    13. Ȯ�μ����� ��ȿ�� üũ   *
         ***********************************/
        function fnc_fnc_ApprovalCheck() {

            //���� Ȯ�� "�ű�" �����̸� Ȯ�μ� ���� �Ұ�
            if(dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition,"APP_STATUS_CD") == ""){
            	alert("������� �Ͻñ� �ٶ��ϴ�.");
            	return false;
            }

            
            
            //Ȯ�� ���� Ȯ�� : Ȯ�� �����߿��� Ȯ�μ� ������ �Ұ�
            if(dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition,"APP_STATUS_CD") == "G"){
            	alert("��� ���Ŀ��� Ȯ�μ� �������� �Ұ����մϴ�.");
            	return false;
            }            
            
            //Ȯ�� ���� Ȯ�� : Ȯ�� �����߿��� Ȯ�μ� ������ �Ұ�
            if(dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition,"APP_STATUS_CD") == "Y"){
            	alert("Ȯ�οϷ�� �����Դϴ�.");
            	return false;
            }                 
            
            if(document.getElementById("txtDOC_GB1").value == ""){
                alert("��з��� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtDOC_GB1").focus();
                return false;
            }
            
            if(document.getElementById("txtDOC_GB2").value == ""){
                alert("�ߺз��� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtDOC_GB2").focus();
                return false;
            }
            
            if(document.getElementById("txtDOC_GB3").value == ""){
                alert("���κз��� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtDOC_GB3").focus();
                return false;
            }
            
            if(document.getElementById("cmbDOC_STATUS").value == "" ){
                alert("�����Ȳ�� �����Ͻñ� �ٶ��ϴ�.");
                document.getElementById("cmbDOC_STATUS").focus();
                return false;
            }            
            
            if(document.getElementById("txtDOC_TITLE").value == ""){
            	alert("���� ������ �Է��Ͻñ� �ٶ��ϴ�.");
            	document.getElementById("txtDOC_TITLE").focus();
            	return false;
            }

            if(dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition, "FILE_KEY") == ""){
            	alert("������ ÷���Ͻñ� �ٶ��ϴ�.");
            	return false;
            }         
            
			return true;

        }
        
        
        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����
			cfStyleGrid_New(form1.grdT_ACT_PLANLIST,0,"false","true");      // Grid Style ����		
			
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;			
			
			fnc_SearchList();
			
            fnc_InputDisabled();//�Է¶� disabled			
			
            //document.form1.txtDOC_GB1.focus();
        }



        
        
        
        /***********************************
         *    		Ȯ�μ� ���� �Լ�  		*
         ***********************************/

        function fnc_Approval() {

        	//alert("Ȯ�μ��� ���Ӱ� �����մϴ�.");

        	if(!fnc_fnc_ApprovalCheck()) return;
        	
            var DPT_CD = document.getElementById("txtDPT_CD").value;
			var EMP_NO = document.getElementById("txtENO_NO").value;

            //ds�� ���Ϲ޴´�.
            dsT_ACT_APPROVAL.DeleteAll();
            
            fnc_GetApprover(dsT_ACT_APPROVAL);
 
            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_ACT_APPROVAL, dsT_ACT_APPROVAL_TEMP);
            
            dsT_ACT_APPROVAL.ClearData();
            
            for(var i=1; i<=dsT_ACT_APPROVAL_TEMP.countrow; i++){

            	dsT_ACT_APPROVAL.addrow();
            	dsT_ACT_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("txtREQ_NO").value;
            	dsT_ACT_APPROVAL.NameValue(i,"ENO_NO") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"ENO_NO");
            	dsT_ACT_APPROVAL.NameValue(i,"ENO_NM") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"ENO_NM");
            	dsT_ACT_APPROVAL.NameValue(i,"DPT_CD") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"DPT_CD");
            	dsT_ACT_APPROVAL.NameValue(i,"DPT_NM") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"DPT_NM");
            	dsT_ACT_APPROVAL.NameValue(i,"JOB_CD") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"JOB_CD");
            	dsT_ACT_APPROVAL.NameValue(i,"JOB_NM") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"JOB_NM");    
            	
            	dsT_ACT_APPROVAL.NameValue(i,"EM_PHN_NO") = dsT_ACT_APPROVAL_TEMP.NameValue(i,"EM_PHN_NO");              	
            	
            	dsT_ACT_APPROVAL.NameValue(i,"SEQ_NO") = i;
            	dsT_ACT_APPROVAL.NameValue(i,"RENO_NO") = EMP_NO;
            }
	        

			trT_ACT_APPROVAL_SAV.KeyValue = "tr(I:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
			trT_ACT_APPROVAL_SAV.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SAV_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
			trT_ACT_APPROVAL_SAV.post();

        }

	    function fnc_GetApprover(dataSet) {

            var DPT_CD = document.getElementById("txtDPT_CD").value;
			var EMP_NO = document.getElementById("txtENO_NO").value;

	        //�Ķ����
	        var paraVal = "&DPT_CD="  + document.getElementById("txtDPT_CD").value  + 
            			  "&ENO_NO="  + document.getElementById("txtENO_NO").value;

	        window.showModalDialog("../../common/popup/act_approver.jsp?"+paraVal, dataSet, "dialogWidth:500px; dialogHeight:625px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	        
	        return dataSet;
	        
	    }   
        
        

	    
        /***********************************
         *    			���ó��   			*
         ***********************************/
        function fnc_Conduct() {

        	
    	    if(dsT_ACT_APPROVAL.CountRow < 1){
    	    	alert("���õ� Ȯ���ڰ� �����ϴ�.\n\n�ٽ� �����Ͻñ� �ٶ��ϴ�.");
    	        return;
    	    }        	
        	
        	if(!fnc_fnc_ApprovalCheck()) return;

			dsT_ACT_APPROVAL.UseChangeInfo = "false";

			trT_ACT_APPROVAL_SUB.KeyValue = "tr(I:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
			trT_ACT_APPROVAL_SUB.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SAV_SUBMIT&DOC_NO="+document.getElementById("txtDOC_NO").value;
			trT_ACT_APPROVAL_SUB.post();

			fnc_SearchList();

        }

		
        /***********************************
         *    	�Է¶� Disabledó��  		*
         ***********************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDOC_GB1").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB1").readOnly = true;
            document.getElementById("txtDOC_GB2").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB2").readOnly = true;
            document.getElementById("txtDOC_GB3").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB3").readOnly = true;
            document.getElementById("txtDOC_TITLE").className = "input_ReadOnly";
            document.getElementById("txtDOC_TITLE").readOnly = true;
            document.getElementById("txtDOC_REMARK").className = "input_ReadOnly";
            document.getElementById("txtDOC_REMARK").readOnly = true;

            document.getElementById("ImgDOC_GB1").style.display = "none";            
            document.getElementById("ImgDOC_GB2").style.display = "none";            
            document.getElementById("ImgDOC_GB3").style.display = "none";

        }

        
        /***********************************
         *    	�Է¶� Enableó��    		*
         ***********************************/     
        function fnc_InputEnable() {
        	        	
            document.getElementById("txtDOC_GB1").className = "";
            document.getElementById("txtDOC_GB1").readOnly = false;
            document.getElementById("txtDOC_GB2").className = "";
            document.getElementById("txtDOC_GB2").readOnly = false;
            document.getElementById("txtDOC_GB3").className = "";
            document.getElementById("txtDOC_GB3").readOnly = false;
            document.getElementById("txtDOC_TITLE").className = "";
            document.getElementById("txtDOC_TITLE").readOnly = false;
            document.getElementById("txtDOC_REMARK").className = "";
            document.getElementById("txtDOC_REMARK").readOnly = false;

            document.getElementById("ImgDOC_GB1").style.display = "";            
            document.getElementById("ImgDOC_GB2").style.display = "";           
            document.getElementById("ImgDOC_GB3").style.display = "";
        	
        }

        
        /********************************************
         * 				÷������ ó��				*
         ********************************************/
		function fnc_FileUpload() {
        	
            if(dsFILE.CountRow == 1) {
            	
                alert("�� �̻� ÷�������� �߰��Ͻ� �� �����ϴ�.");
                
                return;
                
            }

            var key = dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition, "FILE_KEY");

            if(key == "") {
            	
                key = "acqa010"+(new Date().getTime());
                
                dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition, "FILE_KEY") = key;
                
            }

            if(!fnc_AddFileImg(key)) {
            	
                return;
                
            }
            
		}

        
		/********************************************
         * 				÷������ ����				*
         ********************************************/
		function fnc_FileDelete() {
			
            if(dsFILE.CountRow < 1) {
            	
                alert("������ ������ �������� �ʽ��ϴ�.");
                
                return;
                
            }

            
            //Ȯ�� ���� Ȯ�� : Ȯ�� �Ϸ� or Ȯ�� �������̸� ���� ���� �Ұ�,      "����", "�ݷ�", "�ű�" �����̸� ���� ���� ����
            if(dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition,"APP_STATUS_CD") == "S" || dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition,"APP_STATUS_CD") == "R" || dsT_ACT_PLANLIST.NameValue(dsT_ACT_PLANLIST.RowPosition,"APP_STATUS_CD") == ""){
            
	            if( confirm("÷�ε� ������ �����Ͻðڽ��ϱ�?") ){
	            	
	                dsFILE.DeleteRow(dsFILE.RowPosition);
	                
	                fnc_DelFile();
	                
	            }
            
            }else{
            	
            	alert("Ȯ��������, Ȯ�οϷ� ���¿�����\n\n������ �����Ͻ� �� �����ϴ�.");
            	
            }
            
		}

		
        /************************************************
         *        	���� ���� �˾�â ó��               *
         ************************************************/
        function fnc_DocNmPopup(gbn) {

            var obj = new String();

            if (gbn == 'GB1') {
            	
                obj.title = '����';
                obj.gbn   = 'DOC1';

                window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                if(obj.comm_cd != '' && obj.comm_nm != '') {
                	
                    document.getElementById('txtDOC_GB1').value  = obj.comm_cd;
                    document.getElementById('txtDOC_NM1').value  = obj.comm_nm;
                    document.getElementById('txtDOC_GB2').value = '';
                    document.getElementById('txtDOC_NM2').value = '';
                    document.getElementById('txtDOC_GB3').value = '';
                    document.getElementById('txtDOC_NM3').value = '';                    
                    
                }

            }else if (gbn == 'GB2') {
            	
                if (document.getElementById("txtDOC_GB1").value == "") {
                	
                    alert("�����ڵ带 ���� �Է��Ͻ� �� �˾�â�� �����Ͽ� �ֽʽÿ�.");
                    return;
                    
                }else {
                	
                    obj.title = '����';
                    obj.gbn   = 'DOC2';
                    obj.up_cd  = document.getElementById('txtDOC_GB1').value;
                    
                    window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                    
                    if(obj.comm_cd != '' && obj.comm_nm != '') {
                    	
                        document.getElementById('txtDOC_GB2').value  = obj.comm_cd;
                        document.getElementById('txtDOC_NM2').value  = obj.comm_nm;
                        document.getElementById('txtDOC_GB3').value = '';
                        document.getElementById('txtDOC_NM3').value = '';                    
                        
                    }                    
                    
                }
                
            }else if (gbn == 'GB3') {
            	
                if (document.getElementById("txtDOC_GB1").value == "" || document.getElementById("txtDOC_GB2").value == "") {

	                    alert("�����ڵ带 ���� �Է��Ͻ� �� �˾�â�� �����Ͽ� �ֽʽÿ�.");
	                    return;

                }else {
                	
                    obj.title = '����';
                    obj.gbn   = 'DOC3';
                    obj.up_cd  = document.getElementById('txtDOC_GB2').value;
                    
                    window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                    
                    if(obj.comm_cd != '' && obj.comm_nm != '') {
                    	
                        document.getElementById('txtDOC_GB3').value  = obj.comm_cd;
                        document.getElementById('txtDOC_NM3').value  = obj.comm_nm;
         
                    }       

                }
                
            }
            
        }        

    </script>

    </head>




    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <Object ID="dsT_ACT_PLANLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <Object ID="dsT_ACT_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <Object ID="dsT_ACT_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_ACT_SMS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_ACT_PLANLIST)	    |
    | 3. ���Ǵ� Table List(T_ACT_PLAN)	                |
    +------------------------------------------------------->
    <Object ID ="trT_ACT_PLANLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ACT_PLANLIST_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <Object ID ="trT_ACT_APPROVAL_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>    
    
    <Object ID ="trT_ACT_APPROVAL_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>    
    
    <Object ID ="trT_ACT_APPROVAL_SUB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>      
    
    <Object ID ="trT_ACT_SMS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>          

    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->

    <Script For=dsT_ACT_APPROVAL Event="OnLoadCompleted(iCount)">
    
    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>

    <Script For=dsT_ACT_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>
    

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>




    <!-----------------------------------------------------+
    | 			Transaction Successful ó��  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_PLANLIST event="OnSuccess()">

        trT_ACT_APPROVAL_SHR.KeyValue = "tr(O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
        trT_ACT_APPROVAL_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SHR_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
        trT_ACT_APPROVAL_SHR.post();      
        
    </script>    
    
    
    <script for=trT_ACT_PLANLIST_SAV event="OnSuccess()">

		alert("���������� ����Ǿ����ϴ�.");

    	fnc_SearchList();

    </script>

            
    <script for=trT_ACT_APPROVAL_SAV event="OnSuccess()">

	    if(dsT_ACT_APPROVAL.CountRow < 1){
	    	
	    	alert("���õ� Ȯ���ڰ� �����ϴ�.\n\n�ٽ� �����Ͻñ� �ٶ��ϴ�.");
	    	
	        return;
	        
	    }else{

			alert("Ȯ�ζ��� ������ �Ϸ�Ǿ����ϴ�.\n\n����Ͻñ� �ٶ��ϴ�.");
		
	    }
	    
        trT_ACT_APPROVAL_SHR.KeyValue = "tr(O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
        trT_ACT_APPROVAL_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SHR_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
        trT_ACT_APPROVAL_SHR.post();      
	    


    </script>

    <script for=trT_ACT_APPROVAL_SUB event="OnSuccess()">

		alert("����� �Ϸ�Ǿ����ϴ�.");
		
		if(confirm("SMS�� �����ðڽ��ϱ�?")){		
			
			if (dsT_ACT_SMS.CountColumn == 0) {
				
				dsT_ACT_SMS.setDataHeader("ENO_NO:STRING, PHONE_NO:STRING, DOC_TITLE:STRING");
				
			}

            for(var i=1; i<=dsT_ACT_APPROVAL.countrow; i++){

    			// �� �߰�
            	dsT_ACT_SMS.addrow();
            	
            	dsT_ACT_SMS.NameValue(i,"ENO_NO")    = dsT_ACT_APPROVAL.NameValue(i,"ENO_NO");   
            	dsT_ACT_SMS.NameValue(i,"PHONE_NO")  = dsT_ACT_APPROVAL.NameValue(i,"EM_PHN_NO");      
            	dsT_ACT_SMS.NameValue(i,"DOC_TITLE") = document.getElementById("txtDOC_TITLE").value;

            }			

			trT_ACT_SMS.KeyValue = "tr(I:dsT_ACT_SMS=dsT_ACT_SMS)";
			trT_ACT_SMS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SAV_SMS";
			trT_ACT_SMS.post();    			

		}		
		
    	fnc_SearchList();		

    </script>

    <!-----------------------------------------------------+
    | 			Transaction Failure ó��  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_PLANLIST event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>


    <!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó�� |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ACT_PLANLIST event=OnRowPosChanged(row)>
    
        //Ȯ�� ���� Ȯ�� : Ȯ�� �Ϸ� or Ȯ�� �������̸� ���� �Ұ�
        if(dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == "Y" || dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == "G" ){
        	
        	fnc_InputDisabled();     
            
        //���� or �ݷ� or �ű԰��̸� ���� ����
        }else if(dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == "S" || dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == "R" || dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == ""){

        	fnc_InputEnable();

            document.getElementById("imgSave").style.display 			= "";          
    	
        }        	
        	
        if(row > 0) {
        	
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_ACT_PLANLIST.NameValue(row, "FILE_KEY"));

            //Ȯ�μ� ���� ��ȸ
            trT_ACT_APPROVAL_SHR.KeyValue = "tr(O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
            trT_ACT_APPROVAL_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SHR_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
            trT_ACT_APPROVAL_SHR.post();                

        }

	</script>


	<!-----------------------------------------------------+
    | 		grdT_DI_APPROVAL OnClick ó�� - ���� ��ȸ      |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_ACT_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		
		obj =  dsT_ACT_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("./acqa015.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
		
	}

  </script>
  
	<!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
   <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
   
       if(row > 0) {
       	
           var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
           var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
          
           // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
           if (vFILE_NAME != "" && vFILE_URL != "") {
			cfDownload(vFILE_NAME,vFILE_URL);
           }
       }
       
   </script>  
  
 
 
 
 
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s22.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5" align="right" >

            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNew','','../../images/button/btn_AddnewOver.gif',1)">    
            	<img src="../../images/button/btn_AddnewOn.gif"   name="imgNew"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()">
            </a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    
            	<img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()">
            </a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<br>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- �������� ���̺� ���� -->
			<table width="320" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="25">
								<td align="center" class="blueBold">������ȣ</td>
								<td class="padding2423">
									<input id="txtDOC_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="25">
								<td align="center" class="blueBold">�Ҽ�</td>
								<td class="padding2423">
									<input id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="10" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="25">
								<td align="center" class="blueBold">����</td>
								<td class="padding2423">
                                    <input id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="10" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="25">
								<td align="center" class="blueBold">�ۼ���</td>
								<td class="padding2423">
									<input id="txtENO_NO" size="7" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="7" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="25">
								<td align="center" class="blueBold">Ȯ�ι�ȣ</td>
								<td class="padding2423">
                                    <input id="txtREQ_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- �������� ���̺� �� -->
        </td>
        
        <td width="30">&nbsp;&nbsp;</td>
        
        <td>
        	<!-- Ȯ�μ� ���� ���̺� ���� -->
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:660px;height:127px;">
							<param name="DataID"				value="dsT_ACT_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
                    			<C> id={currow}       	width=45   	name='No'	        align=center 	BgColor='#EEEEEE'</C>
								<C> id='ENO_NM'			width=120	name='Ȯ����'		align=center	</C>
								<C> id='JOB_NM'			width=120	name='����'			align=center	</C>
                                <C> id='DPT_NM'			width=150	name='�Ҽ�'			align=center	</C>
								<C> id='APP_STATUS'		width=200	name='Ȯ�λ���'		align=center    </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
   				<tr>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectLineOver.gif',1)"> 
                        <img src="../../images/button/btn_SelectLineOver.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()">
                        </a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)">
						<img src="../../images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();">
						</a>
		            </td>
		       </tr>
            </table>
        	<!-- Ȯ�μ� ���� ���̺� �� -->
        </td>
    </tr>
</table>

<br>

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>					
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="blueBold">��з�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB1" style="width:10%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM1" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB1','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB1" name="ImgDOC_GB1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB1');"></a>
                    </td>
                    <td align="center" class="blueBold">�ߺз�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB2" style="width:10%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM2" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB2','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB2" name="ImgDOC_GB2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB2');"></a>
                    </td>
                    <td align="center" class="blueBold">���κз�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB3" style="width:15%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM3" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB3','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB3" name="ImgDOC_GB3" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB3');"></a>
                    </td>
                    <td align="center" class="blueBold">�����Ȳ</td>
                    <td class="padding2423">
						<select id="cmbDOC_STATUS" style="width:90%">
		                   <option value="" ></option>
		                   <option value="G">�Ϸ�</option>
		                   <option value="Y">������</option>	
		                   <option value="R">HELP</option>	               
						</select>	
                    </td>                    
                </tr>
				<tr>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423" colspan="7">
						<input id="txtDOC_TITLE" style="width:80%;ime-mode:inactive" size = "100" maxlength="200">
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423" colspan="7">
						<input id="txtDOC_REMARK" style="width:80%;ime-mode:inactive" size = "100" maxlength="200">
					</td>
				</tr>				
				<tr>
					<td align="center" class="blueBold">����÷��</td>
					<td class="padding2423" colspan="7">
		                <comment id="__NSID__">
		                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:25px;">
		                    <param name="DataID" 			value="dsFILE">
		                    <param name="Editable" 			value="false">
		                    <param name="DragDropEnable" 	value="true">
		                    <param name="SortView" 			value="Left">
		                    <param name=ViewHeader  		value="false">
		                    <param name="Format" 			value='
		                        <C> id="{CUROW}"    width="30"      name="NO"         	align="center"  value={String(Currow)}</C>
		                        <C> id=FILE_NAME    width="500"     name="���ϸ�"      	align="left"    leftmargin="10"</C>
		                    '>
		                </object>
		                </comment><script> __ShowEmbedObject(__NSID__); </script>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)">
							<img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()">
						</a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)">
							<img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()">
						</a>
		
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>

				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<font color="blue" size="2"><b>[Document List]</b></font>

<!-- ���� ��Ȳ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_PLANLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:305px;">
				<param name="DataID"				value="dsT_ACT_PLANLIST">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
                    <C> id={currow}       	 	width=45   	name='No'	         	align=center 	BgColor='#EEEEEE'</C>
					<C> id='FILE_KEY'			width=80	name='FILE_KEY'			align=center	show=false</C>	
					<C> id='DOC_STATUS'			width=50	name='��Ȳ'				align=center 	value={decode(DOC_STATUS,'G','�Ϸ�','Y','������','R','HELP','')} BgColor={decode(DOC_STATUS,'R','#FF0000','Y','#FFF000','G','#1DDB16','')}</C>	                    
					<C> id='DOC_NO'				width=80	name='������ȣ'			align=center	</C>					
					<C> id='DOC_NM1'			width=100	name='��з�'			align=center	suppress=1</C>
					<C> id='DOC_NM2'			width=100	name='�ߺз�'			align=center	suppress=2</C>
                    <C> id='DOC_NM3'			width=130	name='���κз�'			align=left		</C>
					<C> id='DOC_TITLE'			width=150	name='����'				align=left	    </C>
					<C> id='DOC_REMARK'			width=150	name='����'				align=left 		</C>
					<C> id='APP_STATUS'			width=90	name='Ȯ�λ���'			align=center	show=false value={decode(APP_STATUS_CD,'S','����','G','Ȯ��������','R','�ݷ�','Y','Ȯ�οϷ�','')}</C>
					<C> id='APP_STATUS'			width=90	name='Ȯ�λ���'			align=center	</C>
					<C> id='IPT_YMD'			width=80	name='�Է�����'			align=center	mask='XXXX-XX-XX'</C>
				
				">
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
    </tr>
</table>

</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_ACT_PLANLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ACT_PLANLIST">
	<Param Name="BindInfo", Value='
        <C>Col=DOC_STATUS     	Ctrl=cmbDOC_STATUS     		Param=value 	</C>
		<C>Col=DOC_NO     		Ctrl=txtDOC_NO     			Param=value 	</C>  
		<C>Col=ENO_NO     		Ctrl=txtENO_NO     			Param=value 	</C> 
		<C>Col=ENO_NM     		Ctrl=txtENO_NM     			Param=value 	</C>  
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     			Param=value 	</C> 	
		<C>Col=DPT_NM     		Ctrl=txtDPT_NM     			Param=value 	</C>  
		<C>Col=JOB_CD     		Ctrl=txtJOB_CD     			Param=value 	</C> 
		<C>Col=JOB_NM     		Ctrl=txtJOB_NM     			Param=value 	</C>  
		<C>Col=REQ_NO     		Ctrl=txtREQ_NO     			Param=value 	</C>  
		<C>Col=DOC_GB1     		Ctrl=txtDOC_GB1     		Param=value 	</C>
		<C>Col=DOC_NM1     		Ctrl=txtDOC_NM1     		Param=value 	</C>
        <C>Col=DOC_GB2     		Ctrl=txtDOC_GB2     		Param=value 	</C>
		<C>Col=DOC_NM2     		Ctrl=txtDOC_NM2     		Param=value 	</C>        
		<C>Col=DOC_GB3			Ctrl=txtDOC_GB3	   			Param=value		</C>
		<C>Col=DOC_NM3     		Ctrl=txtDOC_NM3     		Param=value 	</C>		
        <C>Col=DOC_TITLE		Ctrl=txtDOC_TITLE	   		Param=value		</C>
		<C>Col=DOC_REMARK   	Ctrl=txtDOC_REMARK    		Param=value		</C>
    '>
</object>


