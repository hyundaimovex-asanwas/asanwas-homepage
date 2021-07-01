<!--
***********************************************************************
* @source      : yaca060_14.jsp
* @description : ����.����� �ҵ���������Է� PAGE
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
    String gusrid 		= request.getParameter("gusrid");
    
 	boolean itMaster = false;     
     
	//���������� �ƴ��� ����
	if(gusrid.equals("6060002") ) {
		itMaster = true;
	}
	 
%>

<html>
<head>
	<title>���������ҵ���������Է�(yaca060_2014�⵵)</title>
	
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
		
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";        
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";          
        var HOL_YN = "<%=request.getParameter("HOL_YN") %>";
 
        
        //�Ѿ�� ������ ó��
        var submit = "<%=request.getParameter("END_YN") %>";
        var CET_NO = "<%=request.getParameter("CET_NO") %>";        
        var REL_CD = "<%=request.getParameter("REL_CD") %>";     
        var gusrid = "<%=request.getParameter("gusrid") %>";          
		var chk = 1;
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;
			
			dsT_AC_PENSION.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=SHR_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_PENSION.reset();

			//�ٽ� reset
            dsT_AC_PENSION.UseChangeInfo = "true";			

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

			//��ü�� �Ѿ�� �ؾ���
            dsT_AC_PENSION.UseChangeInfo = "false";
			
			// save
			trT_AC_PENSION.KeyValue = "tr01(I:dsT_AC_PENSION=dsT_AC_PENSION)";
			trT_AC_PENSION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=SAV_14";
			trT_AC_PENSION.post();

			fnc_UpdateAcc();

        }

        function fnc_UpdateAcc(){

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_PENSION2.UseChangeInfo = false;

			dsT_AC_PENSION2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=ACC_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_PENSION2.reset();
        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	if (dsT_AC_PENSION.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

           	var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            tmpMSG += "����ȸ�� = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "ABA_NM")+"\n";
            tmpMSG += "���¹�ȣ = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "ACC_NO")+"\n";
            tmpMSG += "�������� = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "PEN_TYPE_NM")+"\n";
            tmpMSG += "���౸�� = "+dsT_AC_PENSION.nameValue(dsT_AC_PENSION.RowPosition, "PEN_GUBUN_NM")+"\n";

	        if( confirm(tmpMSG) ){
		        
			    var status = dsT_AC_PENSION.RowStatus(dsT_AC_PENSION.RowPosition);
			    
				dsT_AC_PENSION.DeleteRow(dsT_AC_PENSION.RowPosition);
			    		    		
			    if(status != 1){
                    trT_AC_PENSION.KeyValue = "tr01(I:dsT_AC_PENSION=dsT_AC_PENSION)";
                    trT_AC_PENSION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca060.cmd.YACA060CMD&S_MODE=DEL_14";
                    trT_AC_PENSION.post();
                }
			}
			//fnc_UpdateAcc();
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

            dsT_AC_PENSION.AddRow();
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"SEQ_NO") = "9";

            fnc_enableInput();
            fnc_GetPenGubunList();

        }

		/********************************************
         * 07. �ű� �Լ�2222 							*
         ********************************************/		
        function fnc_Add() {


            var cmbPEN_GUBUN_CD = document.getElementById("cmbPEN_GUBUN_CD"); 
            
       	 	for (i = cmbPEN_GUBUN_CD.length - 1; i>=0; i--) {
       		 cmbPEN_GUBUN_CD.remove(i); 
       		   }        			

        	dsT_AC_PENSION.AddRow();

        	dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_PENSION.NameValue(dsT_AC_PENSION.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;        	

            fnc_enableInput();
            
            document.getElementById("cmbPEN_GUBUN_CD").value      = "";	
			document.form1.medAMOUNT.value = 0;	  	
		
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
			
			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';

			document.form1.medAMOUNT.value = 0;

        	dsT_AC_PENSION.ClearData();

            document.getElementById("resultMessage").innerText = ' ';
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_PENSION.IsUpdated)  {
				if (!fnc_ExitQuestion2())  return;
			}
			window.close();
        }
		
		
    	// ȭ�� ����� �ڷ� ���� ���� ��ȸ
    	function fnc_ExitQuestion2() {

    		if (confirm("����(����)�� �ڷᰡ �ֽ��ϴ�. \n\nȮ���� �����ø� ����� �ڷ�� ������� �ʰ� ���� �˴ϴ�.")) {
    			return true;
    		} else {
    			return false;
    		}
    	}

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_AC_PENSION.isUpdated ) {

			}

			//�ֹι�ȣ ����ڹ�ȣ üũ
			for(i=0;i<dsT_AC_PENSION.CountRow;i++){

			    if(dsT_AC_PENSION.RowLevel(i+1) !="9999"){
			    	
	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '2') {
		                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '31' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '32' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '34' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '51' ) {
		                	alert("���������� ���������� ���\n���ο�������� �������ุ ���尡���մϴ�.");
	                    	return false;
		                }
	                }			    	

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '3') {
		                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '21' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '22' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '51' ) {
		                	alert("���������� ���ø��������� ���\nû������� ����û����������,\n�ٷ������ø������ุ ���尡���մϴ�.");
	                    	return false;
		                }
	                }		          
	                
	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '5') {
		                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '21' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '22' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '31' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '32' || dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '34') {
		                	alert("���������� ��������������������� ���\n ������������������ุ ���尡���մϴ�.");
	                    	return false;
		                }
	                }		                
	                
			    	
	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '') {
	                    alert("����������  �ʼ� �Է� �׸��Դϴ�.");
	                    form1.cmbPEN_TYPE_CD.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '') {
	                    alert("���౸���׸��� �ʼ� �Է� �׸��Դϴ�.");
	                    form1.cmbPEN_GUBUN_CD.focus();
	                    return false;
	                }

					if(dsT_AC_PENSION.NameValue(i+1,"ABA_CD") == '') {
	                    alert("����ȸ����� �ʼ� �Է� �׸��Դϴ�.");
	                    form1.txtABA_NM.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"ABA_NM") == '') {
	                    alert("����ȸ����� �ʼ� �Է� �׸��Դϴ�.");
	                    form1.txtABA_NM.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"ACC_NO") == '') {
	                    alert("���¹�ȣ�� �ʼ��׸��Դϴ�.");
	                    form1.txtACC_NO.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"NTS_YN") == '') {
	                    alert("�ڷ���ó�� �ʼ��׸��Դϴ�.");
	                    form1.cmbNTS_YN.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_TYPE_CD") == '2' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 12000000) {
	                	alert("����������� ���Աݾ��� 1200������ �ʰ��� �� �����ϴ�.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '31' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 1200000) {
	                	alert("û������ ���Աݾ��� 120������ �ʰ��� �� �����ϴ�.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '32' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 1200000) {
	                	alert("����û���������� ���Աݾ��� 120������ �ʰ��� �� �����ϴ�.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }

	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '34' && dsT_AC_PENSION.NameValue(i+1,"AMOUNT") > 1800000) {
	                	alert("�ٷ������ø������� ���Աݾ��� 180������ �ʰ��� �� �����ϴ�.");
	                    form1.medAMOUNT.focus();
	                    return false;
	                }
	                
	                if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '21') {
	                	dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_NM") = "���ο�������"
	                }else if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '22'){
	                	dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_NM") = "��������"	
	                }else if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '31'){
	                	dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_NM") = "û������"	
	                }else if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '32'){
	                	dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_NM") = "����û����������"	
	                }else if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '34'){
	                	dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_NM") = "�ٷ������ø�������"		  
	                }else if(dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_CD") == '51'){
	                	dsT_AC_PENSION.NameValue(i+1,"PEN_GUBUN_NM") = "�������������������"		                	
	                }	                

                }
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
            fnc_ChangeStateElement(false, "imgEnoNo");
            document.getElementById("imgEnoNo").style.display = "none";
<%
    }
%>
            
 			document.form1.txtPIS_YY_SHR.value = PIS_YY;		    
			document.form1.txtENO_NO_SHR.value = ENO_NO;
            document.form1.txtENO_NM_SHR.value = ENO_NM;
            document.form1.txtDPT_NM_SHR.value = DPT_NM;
            document.form1.txtJOB_NM_SHR.value = JOB_NM;            
            
            cfStyleGrid_New(form1.grdT_AC_PENSION, 15, "false","false");      // Grid Style ����

			fnc_SearchList();
			
	  		//document.getElementById("cmbPEN_GUBUN_CD").className = "input_ReadOnly";
	  		//document.getElementById("cmbPEN_GUBUN_CD").disabled = true;
	  		
		    if(submit=='Y' )
            {
	            alert("���������ϼ̽��ϴ�.");	
	            
		  		document.getElementById("cmbNTS_YN").disabled = true; 	
	            fnc_HiddenElement("ImgAbaCd");		  		
        		fnc_disableInput();
                return;
                
            }else if(submit!='Y'  && dsT_AC_PENSION.countrow == '0'){
            	fnc_Add();
            }
			
        }


        
        function fnc_GetPenGubunList(){


				var oSelectT = document.getElementById("cmbPEN_TYPE_CD");
         		var oSelect = document.getElementById("cmbPEN_GUBUN_CD");

         		oSelect = "";

         		var CdList = null;
         		var NmList = null;
     		
         		// ���� �˻� �޺��ڽ� ����
	            oSelect = document.getElementById("cmbPEN_GUBUN_CD");

	            //ù��° ������ ������ ��� option ����
	            for(i=oSelect.options.length-1; i>=0; i--) {
	                oSelect.remove(i);
	            }
	            
                if(oSelectT.value == "1"){
               
                }else if(oSelectT.value == "2"){

                   CdList = new Array(  "21"
                                       ,"22");
                   NmList = new Array( "���ο�������"				//LF1_AMT
                                       ,"��������");				//ANN_AMT
                }else if(oSelectT.value == "3"){

	               CdList = new Array(  "31"
                                       ,"32"
                                       ,"34");
                   NmList = new Array(  "û������"                   //LHO_AMT(NTS)
                                       ,"����û����������"			 //LHP_AMT(NTS)
                                       ,"�ٷ������ø�������");		 //LHR_AMT(NTS)
                }else if(oSelectT.value == "5"){

                    CdList = new Array(  "51" );
                    NmList = new Array( "�������������������"	);				//                              
                }else{
                	return;
                }

                
                for(var i = 0; i < CdList.length; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = CdList[i];
	                oOption.text  = NmList[i];
	                oSelect.add(oOption);
				}
        }

        function fnc_SetPenType(){

         		// ���� ���� ���� �˻� �޺��ڽ� ����
	            oSelect = document.getElementById("cmbPEN_TYPE_CD");

                if(oSelect.value == "1"){
	                //document.form1.txtPEN_TYPE_NM.value = "��������";
	            }
	            else if(oSelect.value == "2"){
                   document.form1.txtPEN_TYPE_NM.value = "��������";
                   document.form1.cmbPEN_TYPE_CD.value = "2";                              
                }
                else if(oSelect.value == "3"){
                   document.form1.txtPEN_TYPE_NM.value = "���ø�������";
                   document.form1.cmbPEN_TYPE_CD.value = "3";        
                }                   
                else if(oSelect.value == "5"){
                    document.form1.txtPEN_TYPE_NM.value = "�������������������";
                    document.form1.cmbPEN_TYPE_CD.value = "5";                     
                }
                fnc_SetPenGubun();
         }
        

         function fnc_SetPenGubun(){

                // ���� ���� �˻� �޺��ڽ� ����
	            oSelectT = document.getElementById("cmbPEN_GUBUN_CD");

                if(oSelectT.value == "11"){
	                //document.form1.txtPEN_GUBUN_NM.value = "��������";
 	                //document.form1.cmbPEN_GUBUN_CD.value = "11";
                }
                else if(oSelectT.value == "21"){
                   document.form1.txtPEN_GUBUN_NM.value = "���ο�������";
                   document.form1.cmbPEN_GUBUN_CD.value = "21";  
                }
                else if(oSelectT.value == "22"){   
                   document.form1.txtPEN_GUBUN_NM.value = "��������";
                   document.form1.cmbPEN_GUBUN_CD.value = "22";  
                }
                else if(oSelectT.value == "31"){
                   document.form1.txtPEN_GUBUN_NM.value = "û������";
                   document.form1.cmbPEN_GUBUN_CD.value = "31";  
                }
                else if(oSelectT.value == "32"){
                   document.form1.txtPEN_GUBUN_NM.value = "����û����������";
                   document.form1.cmbPEN_GUBUN_CD.value = "32";    
                }
                else if(oSelectT.value == "34"){
                   document.form1.txtPEN_GUBUN_NM.value = "�ٷ������ø�������";
                   document.form1.cmbPEN_GUBUN_CD.value = "34";  
                }
                else if(oSelectT.value == "51"){
                   document.form1.txtPEN_GUBUN_NM.value = "�������������������";
                   document.form1.cmbPEN_GUBUN_CD.value = "51";                     
                }


        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. �Է��ʵ� ��� �����ϰ�(Enable)       *
         ********************************************/
  		function fnc_enableInput(){

            document.getElementById("cmbPEN_TYPE_CD").className = "";
	  		document.getElementById("cmbPEN_TYPE_CD").disabled = false;
	  		document.getElementById("cmbPEN_GUBUN_CD").className = "";
	  		document.getElementById("cmbPEN_GUBUN_CD").disabled = false;
	  		form1.medAMOUNT.Enable = "true";	
            document.getElementById("txtABA_CD").className = "";
	  		document.getElementById("txtABA_CD").readOnly = false;
	  		document.getElementById("txtABA_NM").className = "";
	  		document.getElementById("txtABA_NM").readOnly = false;
            document.getElementById("txtACC_NO").className = "";
	  		document.getElementById("txtACC_NO").readOnly = false;
	  		document.getElementById("cmbNTS_YN").className = "";
	  		document.getElementById("cmbNTS_YN").diabled = false;

  		}

        /********************************************
         * 17. �Է��ʵ� ��� �Ұ����ϰ�(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

            document.getElementById("cmbPEN_TYPE_CD").className = "input_ReadOnly";
	  		document.getElementById("cmbPEN_TYPE_CD").disabled = true;
	  		document.getElementById("cmbPEN_GUBUN_CD").className = "input_ReadOnly";
	  		document.getElementById("cmbPEN_GUBUN_CD").disabled = true;
	  		form1.medAMOUNT.Enable = "false";
            document.getElementById("txtABA_CD").className = "input_ReadOnly";
	  		document.getElementById("txtABA_CD").readOnly = true;
	  		document.getElementById("txtABA_NM").className = "input_ReadOnly";
	  		document.getElementById("txtABA_NM").readOnly = true;
            document.getElementById("txtACC_NO").className = "input_ReadOnly";
	  		document.getElementById("txtACC_NO").readOnly = true;
	  		document.getElementById("cmbNTS_YN").className = "input_ReadOnly";
	  		document.getElementById("cmbNTS_YN").diabled = true;

            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAddnew");
            fnc_HiddenElement("imgDelete");                        

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_PENSION)		   |
    | 3. ���Ǵ� Table List(T_AC_PENSION) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_PENSION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="false">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_PENSION)		   |
    | 3. ���Ǵ� Table List(T_AC_PENSION) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_PENSION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
        <Param Name="SubsumExpr" 	  		Value="total">
	</Object>


	<!-- ���� �޺��� ���� DataSet -->
    <!-- ���豸�� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U6"/>
       <jsp:param name="CODE_GUBUN"    value="U6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_PENSION)		   |
    | 3. ���Ǵ� Table List(T_AC_PENSION)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_PENSION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AC_PENSION=dsT_AC_PENSION,I:dsT_AC_PENSION=dsT_AC_PENSION)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_PENSION Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}else{
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_AC_PENSION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_PENSION Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
		cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_AC_PENSION event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");        
        fnc_UpdateAcc();
        fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_PENSION event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script language=JavaScript for=dsT_AC_PENSION event=OnRowPosChanged(row)>

    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�����������������Է�</td>
					<td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">�����������������Է�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>

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
							<col width="50"></col>
							<col width="60"></col>
                            <col width="180"></col>
                            <col width="80"></col>
                            <col width="90"></col>
                            <col width="90"></col>
							<col width=""></col>
                        </colgroup>
						<tr>
                            <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
							<td class="padding2423">
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>
							</td>
                            <td align="right" class="searchState">���&nbsp;</td>
                            <td class="padding2423">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
								<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">						
                            <!--  
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
                            -->
                                <img src="../../images/button/btn_HelpOn.gif" id="imgEnoNo" name="imgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                <input type="hidden" id="hidEMPL_DPT_CD">
                            </td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="20" class="input_ReadOnly" readonly>
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

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="100"></col>
                        <col width="250"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="blueBold">��������</td>
                        <td class="padding2423" align="left">
								<select id="cmbPEN_TYPE_CD" style="width:100%;" onChange="fnc_GetPenGubunList();fnc_SetPenType();">
									<option value="2">��������</option>
									<option value="3">���ø�������</option>
									<option value="5">�������������������</option>									
								</select>
								<input type="hidden" id="txtPEN_TYPE_NM">
						</td>
                        <td align="center" class="blueBold">���౸��</td>
                        <td class="padding2423">
                            <select id="cmbPEN_GUBUN_CD" style="width=100%">                                               
									<option value="21">���ο�������</option>
									<option value="22">��������</option>
									<option value="31">û������</option>                            
									<option value="32">����û����������</option>
									<option value="34">�ٷ������ø�������</option>     
									<option value="51">�������������������</option>   									
                            </select>
                            <input type="hidden" id="txtPEN_GUBUN_NM">
                        </td>
                       </tr>
                    </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                    <colgroup>
                        <col width="100"></col>
                        <col width="250"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
						<td align="center" class="blueBold">��ó</td>
						<td class="padding2423" align="left">
								<select id="cmbNTS_YN" style="width:100%;">
									<option value=""></option>
									<option value="1">����û�ڷ�</option>
									<option value="2">�׹����ڷ�</option>
								</select>
						</td>   
						                    
                        <td align="center" class="blueBold">����ȸ���</td>
	                    <td class="padding2423">
	                        <input id="txtABA_CD" style="width:18%" maxlength="3" onChange="fnc_GetCommNm('BK', 'txtABA_CD','txtABA_NM');"> 
	                        <input id="txtABA_NM" style="width:60%" class="input_ReadOnly"  readonly>
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAbaCd','','../../images/button/btn_HelpOver.gif',1)">
	                        <img src="../../images/button/btn_HelpOn.gif" id="ImgAbaCd" name="ImgAbaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','�������','U7')"></a>
	                    </td>

                    </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" >
                    <colgroup>
                        <col width="100"></col>
                        <col width="250"></col>
                        <col width="100"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                    
                        <td align="center" class="blueBold">���¹�ȣ</td>
          		        <td class="padding2423">
                	        <input id="txtACC_NO" maxlength="20" style="width:100%">
                    	</td>
                    	                    
                 
                        <td align="center" class="blueBold">���Աݾ�</td>
                        <td class="padding2423">
                            <comment id="__NSID__">
                            <object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
                                <param name=Alignment               value=2>
                                <param name=Border                  	value=true>
                                <param name=ClipMode                	value=true>
                                <param name=DisabledBackColor     value="#EEEEEE">
                                <param name=Enable                  	value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                                <param name=SelectAll               value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>                      
                        </td>
                    </tr>
                </table>
			</td>
		</tr>
	</table>
	</td>
</tr>
</table>
	<!-- ���� �Է� ���̺� �� -->
	
	
    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState" width="280"><span id="resultMessage">&nbsp;</span></td> 
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
					<comment id="__NSID__">
					<object id="grdT_AC_PENSION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" 						value="dsT_AC_PENSION">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"			value=1>						
						<param name="Format" 						value='
							<C> id={currow}					width=34    name="NO"		                		align=center  SumBgColor=#C3D0DB SumText="�հ�"  </C>
                            <C> id="PEN_TYPE_CD"			width=30	name="��������"		    			align=center  SumBgColor=#C3D0DB show=false</C>
                            <C> id="PEN_TYPE_NM"			width=130	name="����������"		    		align=center  SumBgColor=#C3D0DB </C>
                            <C> id="PEN_GUBUN_CD"		width=30	name="�ڵ�"		    				align=center  SumBgColor=#C3D0DB show=false</C>
                            <C> id="PEN_GUBUN_NM"		width=150	name="���౸�и�"		   	 		align=center  Value={decode(PEN_GUBUN_CD,21,"���ο�������",22,"��������",31,"û������",32,"����û����������",34,"�ٷ������ø�������",51,"�������������������")} SumBgColor=#C3D0DB </C>
							<C> id="NTS_YN"					width=80	name="�ڷ���ó"		    			align=center  Value={decode(NTS_YN, 1,"����û�ڷ�",2,"�׹��� �ڷ�")} SumBgColor=#C3D0DB</C>
                            <C> id="ABA_NM"					width=130	name="����ȸ���"		    		align=left	  SumBgColor=#C3D0DB </C>
                            <C> id="ACC_NO"					width=130	name="���¹�ȣ"		        		align=center  SumBgColor=#C3D0DB </C>
                          	<C> id="AMOUNT"				width=110	name="���Աݾ�"	            		align=right	  RightMargin="10" SumBgColor=#C3D0DB SumText=@sum</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

	<!-- form �� -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_PENSION ���� ���̺� -->
	<object id="bndT_AC_PENSION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_PENSION">
		<Param Name="BindInfo", Value="
			<C>Col=NTS_YN				Ctrl=cmbNTS_YN				Param=value </C>
			<C>Col=PEN_TYPE_CD		Ctrl=cmbPEN_TYPE_CD		Param=value </C>
			<C>Col=PEN_TYPE_NM		Ctrl=txtPEN_TYPE_NM		Param=value </C>
            <C>Col=PEN_GUBUN_CD		Ctrl=cmbPEN_GUBUN_CD	Param=value  </C>
            <C>Col=PEN_GUBUN_NM	Ctrl=txtPEN_GUBUN_NM		Param=value  </C>
            <C>Col=ABA_CD				Ctrl=txtABA_CD				Param=value </C>
            <C>Col=ABA_NM				Ctrl=txtABA_NM				Param=value </C>
            <C>Col=ACC_NO				Ctrl=txtACC_NO				Param=value </C>
            <C>Col=AMOUNT				Ctrl=medAMOUNT				Param=text </C>
       ">
	</object>
