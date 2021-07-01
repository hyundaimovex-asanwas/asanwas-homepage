<!--
***********************************************************************
* @source      : yaca023_15.jsp
* @description : �����ٹ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/11/6            �̵���             �����ۼ�       
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>

<%

 	request.setCharacterEncoding("euc-kr"); 

    String PIS_YY       = request.getParameter("PIS_YY");        
    String ENO_NO       = request.getParameter("ENO_NO");
    String ENO_NM       = request.getParameter("ENO_NM");
    String DPT_NM       = request.getParameter("DPT_NM");
    String JOB_NM       = request.getParameter("JOB_NM");


 	boolean itMaster = false;     
 	
	itMaster = true;     
	//���������� �ƴ��� ����
	//if(gusrid.equals("6060002") ) {
	//	itMaster = true;
	//}
	 
%>

<html>
<head>
	<title>�����ٹ��������Է�(yaca023_2015�⵵)</title>
	
    <jsp:include page="/Ehr/common/include/head.jsp"/>  	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

	<script language="javascript">

		var today = getToday();
		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTTTT';
		
        //�Ѿ�� ������ ó��       
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";        
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";   

        
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca023.cmd.YACA023CMD";
        var params = null;
        
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy  = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			//dsT_AC_DUTYPLACE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca023.cmd.YACA023CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			//dsT_AC_DUTYPLACE.reset();
			
            //�������� ��ȸ

            //params = "&S_MODE=SHR_14"
            params = "&S_MODE=SHR_15"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;			

            trT_AC_DUTYPLACE.KeyValue = "tr"
                + "(O:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";      
			trT_AC_DUTYPLACE.action = dataClassName+params;
			trT_AC_DUTYPLACE.post();			

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem(row) {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {
			
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

            //DataSet�� �Է»��·� ����
            //dsT_AC_DUTYPLACE.UseChangeInfo = false;			

            //params = "&S_MODE=SAV_14"
            params = "&S_MODE=SAV_15"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            
            trT_AC_DUTYPLACE_SAV.KeyValue = "tr"
                + "(I:dsT_AC_DUTYPLACE=dsT_AC_DUTYPLACE)";
            
            trT_AC_DUTYPLACE_SAV.action = dataClassName+params;
            trT_AC_DUTYPLACE_SAV.post();            

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {


        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {


        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

	    
			document.form1.txtENO_NO_SHR.value = ENO_NO;
		    document.form1.txtENO_NM_SHR.value = ENO_NM;
		    document.form1.txtDPT_NM_SHR.value = DPT_NM;
		    document.form1.txtJOB_NM_SHR.value = JOB_NM;

        	dsT_AC_DUTYPLACE.ClearData();
        	
            fnc_disableInput();

            document.getElementById("resultMessage").innerText = ' ';

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_DUTYPLACE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
         function fnc_SearchItemCheck() {
			
             return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
             
         }

         var chkList = new Array( "chkPLA1"
                                 ,"chkPLA2"
                                 ,"chkPLA3");

         var itemList = new Array("txtJAS_NM"
                                 ,"txtJAO_NO"
                                 ,"txtHIR_YMD"
                                 ,"txtRET_YMD"
                                 ,"txtJAA_AMT"
                                 ,"txtJAC_AMT"
                                 ,"txtJAI_AMT"
                                 ,"txtJAG_AMT"
                                 ,"txtJAQ_AMT"
                                 ,"txtJAR_AMT"
                                 ,"txtJAH_AMT"
                                 ,"txtJAP_AMT"
                                 ,"txtJAL_AMT"
                                 ,"txtJAN_AMT");

         var itemMsgList = new Array("���θ�(ȸ���)"
                                 ,"����ڵ�Ϲ�ȣ"
                                 ,"���رٹ�������"
                                 ,"���رٹ�������"
                                 ,"�����޿��Ѿ�"
                                 ,"�������Ѿ�"
                                 ,"�������Ѿ�"
                                 ,"������ҵ�"
                                 ,"���ο��ݾ�"
                                 ,"���ο����̿��ǿ��ݺ����"
                                 ,"�ǰ������"
                                 ,"��뺸���"
                                 ,"�����ҵ漼"
                                 ,"�����ֹμ�"
                                 ,"���μ����ֿ���");


		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

	            for(var i=0; i<chkList.length; i++) {
	                oChkElement = document.getElementById(chkList[i]);

	                if(oChkElement.checked) {
	                    for(var j=0; j<itemList.length; j++) {
	                        chkVal = oChkElement.value;

	                        oElement = document.getElementById(itemList[j]+chkVal);

	                        if(oElement.text == "" || oElement.value == "") {
	                            alert(itemMsgList[j]+"��(��) �Է��ϼ���");
	                            oElement.Enable = true;
	                            oElement.focus();
	                            return false;
	                        }

	                        // ������ CHECK
				            if (!fnc_CheckDate(document.getElementById("txtHIR_YMD"+chkVal), '���رٹ��Ⱓ ������') &&
				            	 document.getElementById("txtHIR_YMD"+chkVal).value != "") {
				                document.getElementById("txtHIR_YMD"+chkVal).focus();
				                return false;
				            }

				            // ������ CHECK
				            if (!fnc_CheckDate(document.getElementById("txtRET_YMD"+chkVal), '���رٹ��Ⱓ ������') &&
				            	 document.getElementById("txtRET_YMD"+chkVal).value != "") {
				                document.getElementById("txtRET_YMD"+chkVal).focus();
				                return false;
				            }

				            // ������ CHECK
				            if (document.getElementById("txtHIR_YMD"+chkVal).value.length != 10){
				                document.getElementById("txtHIR_YMD"+chkVal).focus();
				                alert("���رٹ��Ⱓ �������� ���Է��� �ֽʽÿ�.");
				                return false;
				            }

				            // ������ CHECK
				            if (document.getElementById("txtRET_YMD"+chkVal).value.length != 10){
				                document.getElementById("txtRET_YMD"+chkVal).focus();
				                alert("���رٹ��Ⱓ �������� ���Է��� �ֽʽÿ�.");
				                return false;
				            }

				            
				            //alert(document.getElementById("txtJAG_AMT"+chkVal).text);
				            // ������ҵ�
				            if (document.getElementById("txtJAG_AMT"+chkVal).text != '0'){
				            	
					            if (document.getElementById("cmbJAG_CD"+chkVal).value == ''){
					                alert("������ҵ� �ڵ带 �Է��� �ֽʽÿ�.");
					                return false;
					            }	
					            
				            }
				            
	                    }
	                }
	            }			  
			  	  
			return true;

        }

		
		/********************************************
         * ���� ��ȿ�� üũ  					*
         ********************************************/       
        function  fnc_JAOConfirm1(){        
			
       	var JAO_NO1 =  document.form1.txtJAO_NO1.value.replace("-", "").replace("-", ""); 
      	
		    if(JAO_NO1.replace("-", "").replace("-", "").length != 10) {
               alert("�����ٹ���1 ����ڹ�ȣ�� �߸��Ǿ����ϴ�.");
               document.getElementById("txtJAO_NO1").value = "";
               form1.txtJAO_NO1.focus();
               return false;
			}    
		    
			 if(bizNo_validate(JAO_NO1) == false){
			            	alert("��ȿ���� ���� ����ڹ�ȣ�Դϴ�.");
			                document.getElementById("txtJAO_NO1").value = "";			            	
			                 form1.txtJAO_NO1.focus();
			            	return false;
			 }			

		}
		
        function  fnc_JAOConfirm2(){        

        	
        	var JAO_NO2 =  document.form1.txtJAO_NO2.value.replace("-", "").replace("-", ""); 

 		    if(JAO_NO2.replace("-", "").replace("-", "").length != 10) {
                alert("�����ٹ���2 ����ڹ�ȣ�� �߸��Ǿ����ϴ�.");
                document.getElementById("txtJAO_NO2").value = "";
                form1.txtJAO_NO2.focus();
                return false;
			}    
 		    
			 if(bizNo_validate(JAO_NO2) == false){
			            	alert("��ȿ���� ���� ����ڹ�ȣ�Դϴ�.");
			                document.getElementById("txtJAO_NO2").value = "";
			                 form1.txtJAO_NO2.focus();
			            	return false;
			 }			

		}
		
        function  fnc_JAOConfirm3(){        

        	var JAO_NO3 =  document.form1.txtJAO_NO3.value.replace("-", "").replace("-", ""); 
        	
 		    if(JAO_NO3.replace("-", "").replace("-", "").length != 10) {
                alert("�����ٹ���3 ����ڹ�ȣ�� �߸��Ǿ����ϴ�.");
                document.getElementById("txtJAO_NO3").value = "";
                form1.txtJAO_NO3.focus();
                return false;
			}    
 		    
			 if(bizNo_validate(JAO_NO3) == false){
			            	alert("��ȿ���� ���� ����ڹ�ȣ�Դϴ�.");
			                document.getElementById("txtJAO_NO3").value = "";
			                 form1.txtJAO_NO3.focus(); 			            	
			            	return false;
			 }			

		}		
				
        /* ����ڹ�ȣ ��ȿ�� üũ */
        function bizNo_validate(value){
        	var sumMod = 0;
        	sumMod += parseInt(value.substring(0,1));
        	sumMod += parseInt(value.substring(1,2)) * 3 % 10;
        	sumMod += parseInt(value.substring(2,3)) * 7 % 10;
        	sumMod += parseInt(value.substring(3,4)) * 1 % 10;
        	sumMod += parseInt(value.substring(4,5)) * 3 % 10;
        	sumMod += parseInt(value.substring(5,6)) * 7 % 10;
        	sumMod += parseInt(value.substring(6,7)) * 1 % 10;
        	sumMod += parseInt(value.substring(7,8)) * 3 % 10;
        	sumMod += Math.floor(parseInt(value.substring(8,9)) * 5/10);
        	sumMod += parseInt(value.substring(8,9)) * 5 % 10;
	        sumMod += parseInt(value.substring(9,10));

	        if(sumMod % 10 != 0){
	        	return false;
        	}

        	return true;
        }


        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

<%
    //�����ڰ� �ƴ� ��� Ÿ���� ��ȸ�� ���� �ʰ�
    if(!itMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";

<%
    }
%>

		   
			document.form1.txtPIS_YY_SHR.value = PIS_YY;		    
			document.form1.txtENO_NO_SHR.value = ENO_NO;
		    document.form1.txtENO_NM_SHR.value = ENO_NM;
		    document.form1.txtDPT_NM_SHR.value = DPT_NM;
		    document.form1.txtJOB_NM_SHR.value = JOB_NM;

            //fnc_disableInput();

            fnc_SearchList();

            /*
		    if(submit=='Y' )
            {
        		fnc_disableInput();
                return;
            }
			*/
            
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


         
         /********************************************
          * �Է��ʵ� ��� �Ұ����ϰ�(Disable)    								*
          ********************************************/
   		function fnc_disableInput(param){

 			alert("���������� �����Դϴ�.\n������ �Ұ����մϴ�.");

 			submit_chk = "Y";

 			document.getElementById("chkPLA1").disabled = true;
 			document.getElementById("chkPLA1").className = "input_ReadOnly";
 			document.getElementById("chkPLA2").disabled = true;
 			document.getElementById("chkPLA2").className = "input_ReadOnly";
 			document.getElementById("chkPLA3").disabled = true;
 			document.getElementById("chkPLA3").className = "input_ReadOnly";
	

         }

         /********************************************
          * �Է��ʵ� ��� �����ϰ�(Enable)       								*
          ********************************************/
   		function fnc_enableInput(){

 			document.getElementById("chkPLA1").disabled = false;
 			document.getElementById("chkPLA1").className = "";
 			document.getElementById("chkPLA2").disabled = false;
 			document.getElementById("chkPLA2").className = "";
 			document.getElementById("chkPLA3").disabled = false;
 			document.getElementById("chkPLA3").className = "";

   		}         


        //�����ٹ����� ���õ� Element List
        var plaList = new Array( "txtJAO_NO"
                                ,"txtJAS_NM"
                                ,"txtHIR_YMD"
                                ,"txtRET_YMD");

        /**
         * �����ٹ��� ���� ���� ó�� ���� ����
         */
        function checkPlace(oPLA) {
            var seq_no  = oPLA.value;
            var chk_place = oPLA.checked;

            dsT_AC_DUTYPLACE.NameValue(1, "TYPE"+seq_no) = "X";

            //�Է�â Ȱ��, ��Ȱ���� ó��
            if(!chk_place) {
                if(!confirm("üũ�� �����Ͻø� �����ٹ���"+seq_no+" �ڷᰡ �����˴ϴ�.")) {
                    oPLA.checked = true
                    return;
                }
                dsT_AC_DUTYPLACE.NameValue(1, "TYPE"+seq_no) = "";
            }

            changePlace(seq_no, chk_place);
        }
        
        /**
         * �����ٹ��� ���� ��ȸ ���� ����
         */
        function changePlace(seq_no, checked) {

            document.getElementById("chkPLA"+seq_no).checked = checked;

            for(var i=0; i<plaList.length; i++) {
                fnc_ChangeStateElement(checked, plaList[i]+seq_no);
            }
			eval("form1.txtHIR_YMD"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtRET_YMD"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAA_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAC_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAG_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAI_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAQ_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAR_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAH_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAP_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAL_AMT"+seq_no+".Enable = '"+checked+"'");
            eval("form1.txtJAN_AMT"+seq_no+".Enable = '"+checked+"'");


            //����� �������Ƿ� �ּ�ó��

            if(checked == false){
	            for(var i=0; i<plaList.length; i++) {
	                document.getElementById(plaList[i]+seq_no).value = "";
	            }

	            eval("form1.txtJAA_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAC_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAG_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAI_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAQ_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAR_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAH_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAP_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAL_AMT"+seq_no+".text = '0'");
	            eval("form1.txtJAN_AMT"+seq_no+".text = '0'");
            }

        }         
         
         
         
        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
        }

        function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

       }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_DUTYPLACE)		   |
    | 3. ���Ǵ� Table List(T_AC_DUTYPLACE) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_DUTYPLACE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_DUTYPLACE)		   |
    | 3. ���Ǵ� Table List(T_AC_DUTYPLACE)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_DUTYPLACE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<Object ID="trT_AC_DUTYPLACE_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_DUTYPLACE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}else{
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount-1);
        }
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_AC_DUTYPLACE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_DUTYPLACE Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
	    if (this.ErrorCode == 50018) {
	        //alert("�ش� �ʼ��Է��׸�[����ڵ�Ϲ�ȣ/������]\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_AC_DUTYPLACE_SAV event="OnSuccess()">
       alert("�����ٹ����� ���������� �����Ͽ����ϴ�.");
       fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_DUTYPLACE_SAV event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onload="fnc_OnLoadProcess();">

	<!-- form ���� -->
	<form name="form1">
<br>
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�����ٹ���</td>
					<td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">�����ٹ���</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>		
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->


	<!-- power Search���̺� ���� -->
	<table width="800px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="70"></col>
							<col width="50"></col>
                            <col width="150"></col>
                            <col width="50"></col>
                            <col width="80"></col>
                            <col width="50"></col>
							<col width=""></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
							<td class="padding2423">

                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="6" class="input_ReadOnly" readonly>



							</td>
                            <td align="right" class="searchState">���&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
                                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                <input type="hidden" id="hidEMPL_DPT_CD">
                            </td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">����&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="15" class="input_ReadOnly" readonly>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->




	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="tabTitle"><img src="../../images/common/arrowGreen.gif" width="8" height="15" align="absmiddle"> �����ٹ����ڷ�</td>
						<td>
						-2014�� ��� �ٹ��Ͻ� ���� �ش���� �ʽ��ϴ�. �ߵ��Ի��ڸ� �ش�˴ϴ�.<br>
						-2014�� �����Ⱓ �߿� �ٹ������ �ִ� �����ٹ����� ���� �ڷ� �Է�</td>
					</tr>
				</table>

				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					style="border-collapse: collapse" bordercolor="#999999"
					class="table_cream">
					<colgroup>
						<col width="100"></col>
						<col width="235"></col>
						<col width="235"></col>
						<col width="*"></col>
					</colgroup>
					<tr>
						<td class="blueBold" align="center"></td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA1" id="chkPLA1" value="1" style="border:0" onclick="checkPlace(this)">
						&nbsp;�����ٹ���1
						</td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA2" id="chkPLA2" value="2" style="border:0" onclick="checkPlace(this)">
						&nbsp;�����ٹ���2
						</td>
						<td class="padding2423">
						<input type="checkbox" name="chkPLA3" id="chkPLA3" value="3" style="border:0" onclick="checkPlace(this)">
						&nbsp;�����ٹ���3
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">���θ�(ȸ���)</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM1"
							id="txtJAS_NM1" size="20" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM2"
							id="txtJAS_NM2" size="20" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAS_NM3"
							id="txtJAS_NM3" size="20" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">����ڵ�Ϲ�ȣ</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO1"
							id="txtJAO_NO1" size="15" maxlength="12" 
							style="text-align:right;" style="ime-mode:disabled"  onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" onChange="fnc_JAOConfirm1();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO2"
							id="txtJAO_NO2" size="15" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" onChange="fnc_JAOConfirm2();" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtJAO_NO3"
							id="txtJAO_NO3" size="15" maxlength="12"
							style="text-align:right;" style="ime-mode:disabled" onkeyup="cfComNoHyphen(this);"
							onkeypress="cfCheckNumber();" onChange="fnc_JAOConfirm3();" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">���رٹ��Ⱓ</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD1"
							id="txtHIR_YMD1" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD1"
							id="txtRET_YMD1" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD2"
							id="txtHIR_YMD2" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD2"
							id="txtRET_YMD2" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
						<td class="padding2423"><input type="text" name="txtHIR_YMD3"
							id="txtHIR_YMD3" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>&nbsp;~
							<input type="text" name="txtRET_YMD3"
							id="txtRET_YMD3" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13);cfDateHyphen(this);cfCheckNumber();"
							style="text-align:right;" style="ime-mode:disabled" class="input_ReadOnly" readonly>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">�����޿��Ѿ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAA_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">�������Ѿ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAC_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">�������Ѿ�<br>(�츮�����⿬��)</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAI_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">������ҵ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td>
									<select id="cmbJAG_CD1" name="cmbJAG_CD1" style="position:relative;top:-3px;width:90px;">
		                                        <option value=""></option>
		                                        <option value="1">���ܱٷ�</option>
		                                        <option value="2">�߰��ٷμ���</option>
		                                        <option value="3">���/��������</option>
		                                        <option value="4">����������</option>		                                        
	                                </select>								
								<comment id="__NSID__"> <object
									id="txtJAG_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td>
									<select id="cmbJAG_CD2" name="cmbJAG_CD2" style="position:relative;top:-3px;width:90px;">
		                                        <option value=""></option>
		                                        <option value="1">���ܱٷ�</option>
		                                        <option value="2">�߰��ٷμ���</option>
		                                        <option value="3">���/��������</option>
		                                        <option value="4">����������</option>		                                        
	                                </select>									
								<comment id="__NSID__"> <object
									id="txtJAG_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td>
									<select id="cmbJAG_CD3" name="cmbJAG_CD3" style="position:relative;top:-3px;width:90px;">
		                                        <option value=""></option>
		                                        <option value="1">���ܱٷ�</option>
		                                        <option value="2">�߰��ٷμ���</option>
		                                        <option value="3">���/��������</option>
		                                        <option value="4">����������</option>		                                        
	                                </select>									
								<comment id="__NSID__"> <object
									id="txtJAG_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					 </tr>
					<tr>
						<td class="blueBold" align="center">���ο��ݺ����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAQ_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">���ο����̿���<br>
						���ݺ����</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAR_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">�ǰ������</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAH_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">��뺸���</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAP_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">�����ҵ漼</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=9>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAL_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="blueBold" align="center">�����ֹμ�</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT1"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT2"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
						<td class="padding2423">
						<table>
							<tr>
								<td><comment id="__NSID__"> <object
									id="txtJAN_AMT3"
									classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
									style="width:80px">
									<param name=Alignment value=2>
									<param name=Border value=true>
									<param name=ClipMode value=true>
									<param name=DisabledBackColor value="#EEEEEE">
									<param name=Enable value=false>
									<param name=IsComma value=true>
									<param name=Language value=0>
									<param name=MaxLength value=8>
									<param name=Numeric value=true>
									<param name=NumericRange value=-~+:0>
									<param name=ShowLiteral value=false>
									<param name=Visible value=true>
									<param name=SelectAll value="true">
								</object> </comment> <script> __ShowEmbedObject(__NSID__); </script></td>
								<td>��</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->
	</form>
	<!-- form �� -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_DUTYPLACE ���� ���̺� -->
<object id="bndT_AC_DUTYPLACE"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_DUTYPLACE">
	<Param Name="BindInfo"
		, Value='
        <C>Col=JAO_NO1          Ctrl=txtJAO_NO1             Param=value     </C>
        <C>Col=JAS_NM1          Ctrl=txtJAS_NM1             Param=value     </C>
        <C>Col=HIR_YMD1         Ctrl=txtHIR_YMD1            Param=value     </C>
        <C>Col=RET_YMD1         Ctrl=txtRET_YMD1            Param=value     </C>
        <C>Col=JAA_AMT1         Ctrl=txtJAA_AMT1            Param=text      </C>
        <C>Col=JAC_AMT1         Ctrl=txtJAC_AMT1            Param=text      </C>
        <C>Col=JAG_AMT1         Ctrl=txtJAG_AMT1            Param=text      </C>
        <C>Col=JAG_CD1         Ctrl=cmbJAG_CD1            Param=value      </C>        
        <C>Col=JAI_AMT1         Ctrl=txtJAI_AMT1            Param=text      </C>
        <C>Col=JAQ_AMT1         Ctrl=txtJAQ_AMT1            Param=text      </C>
        <C>Col=JAR_AMT1         Ctrl=txtJAR_AMT1            Param=text      </C>
        <C>Col=JAH_AMT1         Ctrl=txtJAH_AMT1            Param=text      </C>
        <C>Col=JAP_AMT1         Ctrl=txtJAP_AMT1            Param=text      </C>
        <C>Col=JAL_AMT1         Ctrl=txtJAL_AMT1            Param=text      </C>
        <C>Col=JAN_AMT1         Ctrl=txtJAN_AMT1            Param=text      </C>

        <C>Col=JAO_NO2          Ctrl=txtJAO_NO2             Param=value     </C>
        <C>Col=JAS_NM2          Ctrl=txtJAS_NM2             Param=value     </C>
        <C>Col=HIR_YMD2         Ctrl=txtHIR_YMD2            Param=value     </C>
        <C>Col=RET_YMD2         Ctrl=txtRET_YMD2            Param=value     </C>
        <C>Col=JAA_AMT2         Ctrl=txtJAA_AMT2            Param=text      </C>
        <C>Col=JAC_AMT2         Ctrl=txtJAC_AMT2            Param=text      </C>
        <C>Col=JAG_AMT2         Ctrl=txtJAG_AMT2            Param=text      </C>
        <C>Col=JAG_CD2         Ctrl=cmbJAG_CD2           Param=value      </C>           
        <C>Col=JAI_AMT2         Ctrl=txtJAI_AMT2            Param=text      </C>
        <C>Col=JAQ_AMT2         Ctrl=txtJAQ_AMT2            Param=text      </C>
        <C>Col=JAR_AMT2         Ctrl=txtJAR_AMT2            Param=text      </C>
        <C>Col=JAH_AMT2         Ctrl=txtJAH_AMT2            Param=text      </C>
        <C>Col=JAP_AMT2         Ctrl=txtJAP_AMT2            Param=text      </C>
        <C>Col=JAL_AMT2         Ctrl=txtJAL_AMT2            Param=text      </C>
        <C>Col=JAN_AMT2         Ctrl=txtJAN_AMT2            Param=text      </C>

        <C>Col=JAO_NO3          Ctrl=txtJAO_NO3             Param=value     </C>
        <C>Col=JAS_NM3          Ctrl=txtJAS_NM3             Param=value     </C>
        <C>Col=HIR_YMD3         Ctrl=txtHIR_YMD3            Param=value     </C>
        <C>Col=RET_YMD3         Ctrl=txtRET_YMD3            Param=value     </C>
        <C>Col=JAA_AMT3         Ctrl=txtJAA_AMT3            Param=text      </C>
        <C>Col=JAC_AMT3         Ctrl=txtJAC_AMT3            Param=text      </C>
        <C>Col=JAG_AMT3         Ctrl=txtJAG_AMT3            Param=text      </C>
        <C>Col=JAG_CD3         Ctrl=cmbJAG_CD3           Param=value      </C>           
        <C>Col=JAI_AMT3         Ctrl=txtJAI_AMT3            Param=text      </C>
        <C>Col=JAQ_AMT3         Ctrl=txtJAQ_AMT3            Param=text      </C>
        <C>Col=JAR_AMT3         Ctrl=txtJAR_AMT3            Param=text      </C>
        <C>Col=JAH_AMT3         Ctrl=txtJAH_AMT3            Param=text      </C>
        <C>Col=JAP_AMT3         Ctrl=txtJAP_AMT3            Param=text      </C>
        <C>Col=JAL_AMT3         Ctrl=txtJAL_AMT3            Param=text      </C>
        <C>Col=JAN_AMT3         Ctrl=txtJAN_AMT3            Param=text      </C>
    '>
</object>
