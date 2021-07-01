<!--
***********************************************************************
* @source      : eist020.jsp
* @description : Ÿ�ӽ�Ʈ ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/01/04            �̵���            	ERP�̻�						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>Ÿ�ӽ�Ʈ ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >


        var today = gcurdate;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList(e) {

			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			var team_cd = document.getElementById('txtTEAM_CD_SHR').value;			
			var eno_no = document.getElementById('txtENO_NO_SHR').value;
			var sts_shr = document.getElementById("cmbTS_STS_SHR").value;
			//alert(ActiveIndex);
			
			if(e == "1" || ActiveIndex == "1"){

				dsT_TS_DAY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_DAY&PIS_YM="+pis_ym+"&TEAM_CD="+team_cd+"&ENO_NO="+eno_no+"&STS="+sts_shr;

				dsT_TS_DAY.reset();
   		
			}else if(e == "2" || ActiveIndex == "2"){
				
				dsT_TS_PROJECT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_PJT&PIS_YM="+pis_ym+"&TEAM_CD="+team_cd+"&ENO_NO="+eno_no+"&STS="+sts_shr;

				dsT_TS_PROJECT.reset();				
				
			}else if(e == "3" || ActiveIndex == "3"){
				
				dsT_TS_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_PER&PIS_YM="+pis_ym+"&TEAM_CD="+team_cd+"&ENO_NO="+eno_no+"&STS="+sts_shr;

				dsT_TS_PERSON.reset();				
				
			}

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {



        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {


        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			if(ActiveIndex == "1"){
				
				//�̰��� �ش� �ڵ��� �Է� �ϼ���
	            if (dsT_TS_DAY.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	
	            form1.grdT_TS_DAY.GridToExcel("���ں�", '', 225);
				
			}
			
			if(ActiveIndex == "2"){
				
				//�̰��� �ش� �ڵ��� �Է� �ϼ���
	            if (dsT_TS_PROJECT.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	
	            form1.grdT_TS_PROJECT.GridToExcel("������Ʈ��", '', 225);
				
			}			
			
			if(ActiveIndex == "3"){
				
				//�̰��� �ش� �ڵ��� �Է� �ϼ���
	            if (dsT_TS_PERSON.CountRow < 1) {
	                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
	                return;
	            }
	
	            form1.grdT_TS_PERSON.GridToExcel("������", '', 225);
				
			}			
			
			
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {



        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {


        	window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        	
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

            dsT_CM_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_CM_TEAM.reset();            
            
            document.getElementById("txtTEAM_CD_SHR").value = dsT_CM_TEAM.NameValue(1,"TEAM_CD");   
            document.getElementById("txtTEAM_NM_SHR").value = dsT_CM_TEAM.NameValue(1,"TEAM_NM");          
            
            //document.getElementById("txtENO_NO_SHR").value = gusrid;
            //document.getElementById("txtENO_NM_SHR").value = gusrnm;            
            
            //������, IT + ��ȿ��, ����ȣ
            if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2020009" && gusrid != "2080044"){ 

	         	fnc_ChangeStateElement(false, "txtTEAM_CD_SHR");
	         	fnc_ChangeStateElement(false, "txtTEAM_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgTeam");            	
            	
	         	//fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	//fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	//fnc_ChangeStateElement(false, "ImgEnoNo");

			  }            

			cfStyleGrid_New(form1.grdT_TS_DAY,15,"true","true");      		// Grid Style ����
			cfStyleGrid_New(form1.grdT_TS_PROJECT,15,"true","true");      	// Grid Style ����
			cfStyleGrid_New(form1.grdT_TS_PERSON,15,"true","true");      	// Grid Style ����			
        
			document.getElementById("divEIST020_01").style.display = "";
			document.getElementById("divEIST020_02").style.display = "none";
			document.getElementById("divEIST020_03").style.display = "none";        
        
        
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		
        /*************************
         * 16. �׸��� ���� ó��  *
         ************************/
		function fnc_ChangeGrid(kind) {

			if(kind == '1'){

					document.getElementById("divEIST020_01").style.display = "";
					document.getElementById("divEIST020_02").style.display = "none";
					document.getElementById("divEIST020_03").style.display = "none";

					fnc_SearchList('1');					
					
            }else if(kind == '2'){

					document.getElementById("divEIST020_01").style.display = "none";
					document.getElementById("divEIST020_02").style.display = "";
					document.getElementById("divEIST020_03").style.display = "none";

					fnc_SearchList('2');
					
            }else if(kind == '3'){
         	
					document.getElementById("divEIST020_01").style.display = "none";
					document.getElementById("divEIST020_02").style.display = "none";
					document.getElementById("divEIST020_03").style.display = "";

					fnc_SearchList('3');					
            }

		}		
		
        /********************************
         * 17. �ǹ�ư Ŭ���� ���� ó��  *
         *******************************/

        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {
        	
            ActiveIndex = idx+1;

            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=3; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "../../images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "../../images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "../../images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "../../images/common/tab25Right.gif";
            
            //fnc_TabOnClick(ActiveIndex);
            
            fnc_ChangeGrid(ActiveIndex);
        }        
		
		
		
        /********************************
         * 18. ����/�ݷ� ó��                 *
         *******************************/        

         function fnc_YES() {
				
             if (!confirm("�����Ͻðڽ��ϱ�?")){
 	            
             	return;
             	
             }else{

	 			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
				var team_cd = document.getElementById('txtTEAM_CD_SHR').value;		 			
	 			var eno_no = document.getElementById('txtENO_NO_SHR').value;			

 				if(document.getElementById("divEIST020_01").style.display == "") {

  		            for(var i=1; i<=dsT_TS_DAY.CountRow; i++) {
 					
  		            	if(dsT_TS_DAY.NameValue(i, "STATUS") != "���"){
 		            		
  		            		alert("��� ���°� �ƴ� ���� �����մϴ�.");
  		            		return false;
  		            	}

  						dsT_TS_DAY.UserStatus(i) = 1; //���� ������ ���� ����
					
  		            }

  		 			dsT_TS_DAY_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_DAY.CountRow; i++) {
 	 					
  		            	if(dsT_TS_DAY.NameValue(i, "ENO_NO") == dsT_TS_DAY.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("���� ���");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i,"ENO_NO");
 	            				
  		            		}

  		            	}else{

  	 		            	//�ٸ� ���
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_DAY.NameValue(i+1, "ENO_NO") == dsT_TS_DAY_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            }
           
  		            //prompt(this,dsT_TS_DAY_02.text);
  		            
  					trT_TS_DAY.KeyValue = "tr01(I:dsT_TS_DAY_02=dsT_TS_DAY_02)";
  					trT_TS_DAY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_DAY"
  																								            + "&PIS_YM="+pis_ym
  																								            + "&TEAM_CD="+team_cd
  																								            + "&ENO_NO="+eno_no
  																								            + "&STATUS=Y";																							            
  					trT_TS_DAY.post();	
	
 		 			fnc_SearchList('1');
					

 				}else if(document.getElementById("divEIST020_02").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PROJECT.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PROJECT.NameValue(i, "STATUS") != "���"){
 		            		
 		            		alert("��� ���°� �ƴ� ���� �����մϴ�.");
 		            		return false;
 		            	} 		            	
 		            	
 		            	dsT_TS_PROJECT.UserStatus(i) = 1; //���� ������ ���� ����		
					
 		            } 					
 					
 		            
 		            dsT_TS_PROJECT_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PROJECT.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PROJECT.NameValue(i, "ENO_NO") == dsT_TS_PROJECT.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("���� ���");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PROJECT_02.addrow();
  		            			dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//�ٸ� ���
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PROJECT.NameValue(i+1, "ENO_NO") == dsT_TS_PROJECT_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PROJECT_02.addrow();
 	            				dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		            
 		            
 		            
 		            
					trT_TS_PROJECT.KeyValue = "tr01(I:dsT_TS_PROJECT_02=dsT_TS_PROJECT_02)";

					trT_TS_PROJECT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PJT"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=Y";							

					trT_TS_PROJECT.post(); 					

		 			fnc_SearchList('2');
		 			
 				}else if(document.getElementById("divEIST020_03").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PERSON.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PERSON.NameValue(i, "STATUS") != "���"){
 		            		
 		            		alert("��� ���°� �ƴ� ���� �����մϴ�.");
 		            		return false;
 		            	} 	 		            	
 		            	
 		            	dsT_TS_PERSON.UserStatus(i) = 1; //���� ������ ���� ����		
					
 		            } 	 					

 		            
 		            
 		            dsT_TS_PERSON_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PERSON.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PERSON.NameValue(i, "ENO_NO") == dsT_TS_PERSON.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("���� ���");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PERSON_02.addrow();
  		            			dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            	}else{

  	 		            	//�ٸ� ���
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PERSON.NameValue(i+1, "ENO_NO") == dsT_TS_PERSON_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PERSON_02.addrow();
 	            				dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		 		            
 		            
					trT_TS_PERSON.KeyValue = "tr01(I:dsT_TS_PERSON_02=dsT_TS_PERSON_02)";

					trT_TS_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PER"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=Y";	
					trT_TS_PERSON.post(); 		 					

		 			fnc_SearchList('3');					
 				}

             }
             
         }        
        
        
         function fnc_NO() {
          	
             if (!confirm("�ݷ��Ͻðڽ��ϱ�?")){
  	            
              	return;
              	
              }else{
              	
	  			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
				var team_cd = document.getElementById('txtTEAM_CD_SHR').value;	  			
	  			var eno_no = document.getElementById('txtENO_NO_SHR').value;			
	  			

				if(document.getElementById("divEIST020_01").style.display == "") {

 		            for(var i=1; i<=dsT_TS_DAY.CountRow; i++) {
 					
 		            	if(dsT_TS_DAY.NameValue(i, "STATUS") != "���"){

 		            		alert("��� ���°� �ƴ� ���� �����մϴ�.");
 		            		return false;
 		            	}

 		            	dsT_TS_DAY.UserStatus(i) = 1; //���� ������ ���� ����	
 		            	
 		            }
 		            
 		            
  		 			dsT_TS_DAY_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_DAY.CountRow; i++) {
 	 					
  		            	if(dsT_TS_DAY.NameValue(i, "ENO_NO") == dsT_TS_DAY.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("���� ���");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//�ٸ� ���
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_DAY.NameValue(i+1, "ENO_NO") == dsT_TS_DAY_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		            
 		            
 		            
						trT_TS_DAY.KeyValue = "tr01(I:dsT_TS_DAY_02=dsT_TS_DAY_02)";

						trT_TS_DAY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_DAY"
																								            + "&PIS_YM="+pis_ym
																								            + "&TEAM_CD="+team_cd
																								            + "&ENO_NO="+eno_no
																								            + "&STATUS=S";																							            
						//prompt(this, dsT_TS_DAY.text);
						trT_TS_DAY.post();	
              
			 			fnc_SearchList('1'); 		            
 		            
				}else if(document.getElementById("divEIST020_02").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PROJECT.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PROJECT.NameValue(i, "STATUS") != "���"){
 		            		
 		            		alert("��� ���°� �ƴ� ���� �����մϴ�.");
 		            		return false;
 		            	} 		            	
 		            	
 		            	dsT_TS_PROJECT.UserStatus(i) = 1; //���� ������ ���� ����		
					
 		            } 					
 					
 		            
 		            dsT_TS_PROJECT_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PROJECT.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PROJECT.NameValue(i, "ENO_NO") == dsT_TS_PROJECT.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("���� ���");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PROJECT_02.addrow();
  		            			dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//�ٸ� ���
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PROJECT.NameValue(i+1, "ENO_NO") == dsT_TS_PROJECT_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PROJECT_02.addrow();
 	            				dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 	 		            
 		            
					trT_TS_PROJECT.KeyValue = "tr01(I:dsT_TS_PROJECT_02=dsT_TS_PROJECT_02)";

					trT_TS_PROJECT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PJT"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=S";							

					trT_TS_PROJECT.post(); 					

		 			fnc_SearchList('2');					
					
 				}else if(document.getElementById("divEIST020_03").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PERSON.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PERSON.NameValue(i, "STATUS") != "���"){
 		            		
 		            		alert("��� ���°� �ƴ� ���� �����մϴ�.");
 		            		return false;
 		            	} 	 		            	
 		            	
 		            	dsT_TS_PERSON.UserStatus(i) = 1; //���� ������ ���� ����		
					
 		            } 	 					

 		            
 		            dsT_TS_PERSON_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PERSON.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PERSON.NameValue(i, "ENO_NO") == dsT_TS_PERSON.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("���� ���");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PERSON_02.addrow();
  		            			dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//�ٸ� ���
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PERSON.NameValue(i+1, "ENO_NO") == dsT_TS_PERSON_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PERSON_02.addrow();
 	            				dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		 		            
 		            
 		            
					trT_TS_PERSON.KeyValue = "tr01(I:dsT_TS_PERSON_02=dsT_TS_PERSON_02)";

					trT_TS_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PER"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=S";	
					trT_TS_PERSON.post(); 		 					

		 			fnc_SearchList('3');					
					
 				}
			  			
			  			
            }

  			
         }  

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */

        function fnc_GetNm() {
        	 
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
        }		
		
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_TS_TIMESHEET)   |
    | 3. ���Ǵ� Table List()		     |
    +------------------------------------------------>
    <Object ID="dsT_TS_DAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_TS_DAY_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_TS_PROJECT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_TS_PROJECT_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_TS_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_TS_PERSON_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_CM_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_TS_TIMESHEET)	    |
    | 3. ���Ǵ� Table List()	            |
    +--------------------------------------------------->
    <Object ID ="trT_TS_TIMESHEET" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_TS_DAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <Object ID ="trT_TS_PROJECT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <Object ID ="trT_TS_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_TS_TIMESHEET Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_TS_TIMESHEET Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_TS_TIMESHEET Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_TS_DAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        alert("���������� ó���Ǿ����ϴ�.");
    </script>
    
    <script for=trT_TS_PROJECT event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        alert("���������� ó���Ǿ����ϴ�.");
    </script>    
    
    <script for=trT_TS_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        alert("���������� ó���Ǿ����ϴ�.");
    </script>    
    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_TS_TIMESHEET event="OnFail()">
        cfErrorMsg(this);
    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
		
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_ConsentOver.gif',1)"><img src="../../images/button/btn_ConsentOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_YES()"></a>
			&nbsp;
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SendbackOver.gif',1)"><img src="../../images/button/btn_SendbackOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_NO()"></a>
			&nbsp;
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('1')"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="60"></col>
									<col width="100"></col>
									<col width="60"></col>
									<col width="200"></col>
									<col width="60"></col>	
									<col width="200"></col>
									<col width="60"></col>																	
									<col width="*"></col>									
								</colgroup>
							<tr>
								<td align="right" class="searchState">�� ��&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								</td>
								<td align="right" class="searchState">��&nbsp;</td>
								<td class="padding2423">					
					                <input id="txtTEAM_CD_SHR" name="txtTEAM_CD_SHR" size="9"  maxlength= "8"   onChange="fnc_GetCommNm('A4','txtTEAM_CD_SHR','txtTEAM_NM_SHR');" style="ime-mode:disabled"   >
					                <input id="txtTEAM_NM_SHR" name="txtTEAM_NM_SHR" size="12" maxlength= "14"  >
					                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)">
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgTeam" name="ImgTeam" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtTEAM_CD_SHR','txtTEAM_NM_SHR','�Ҽ�','DEPT')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
					            </td>									
								
								<td align="right" class="searchState">�� ��&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"   >
					                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" >
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                    <input type="hidden" id="hidEMPL_DPT_CD">
					            </td>								
								
								<td class="searchState" align="right">��ȸ����</td>
								<td class="padding2423" align="left">
									<select id="cmbTS_STS_SHR" style="WIDTH: 60px" onChange="fnc_SearchList()">
										<option value="">���</option>
										<option value="S">����</option>
										<option value="R">���</option>
										<option value="Y">�Ϸ�</option>
									</select>
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

<BR>

<!-- �� ��� ���۳�Ʈ ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>

        <td align="left">

            <!-- �ǹ�ư���̺� ���� -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="120">
                        <!-- �ǿ��� -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">���ں�</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>                            
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">������Ʈ��</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">���κ�</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>




<!-- ���ں� ���� ��ȸ �׸��� ���̺� ����-->
<div id="divEIST020_01" style="position:absolute; left:20; top:200; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_DAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_DAY">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>	
								<C> id='REG_YMD'	    width=200	name='����'	        	align=center suppress=1 MASK='XXXX-XX-XX'</C>															
								<C> id='ENO_NM'	    	width=150	name='����'	        	align=center suppress=2</C>							
								<C> id='PJT_NM'	    	width=250	name='������Ʈ��'	        align=left </C>								
								<C> id='WTIME'	    	width=80	name='�ð�'	        	align=center </C>	
								<C> id='TEAM_NM'	    width=120	name='����'	        	align=center </C>	
								<C> id='STATUS'	    	width=100	name='����'	        	align=center </C>																															
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- �ȳ� ���� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            ��  1. "���ں�", "������Ʈ��", "���κ�" ���� Ŭ���Ͽ� ��ȸ�� �� �ֽ��ϴ�.<br>  
		     &nbsp;&nbsp;&nbsp;2. ���°� <font color="red"><b>����</b></font>�� ��� ���� �� �ݼ��� �ȵ˴ϴ�. <font color="red"><b>���</b></font>������ ��쿡�� �����մϴ�.<br> 
			 &nbsp;&nbsp;&nbsp;3. �ð��� �����ؾ��� ��� ����Բ����� �ݼ� ó���� �� ������ ���� �� �����ϸ� �˴ϴ�.<br> 
            </td>
        </tr>
</table>
<!-- �ȳ� ���� ��-->

</div>
<!-- ���� ��ȸ �׸��� ���̺� ��-->




<!-- ������Ʈ�� ���� ��ȸ �׸��� ���̺� ����-->
<div id="divEIST020_02" style="position:absolute; left:20; top:200; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_PROJECT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_PROJECT">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>								
								<C> id='PJT_NM'	    	width=250	name='������Ʈ��'	        align=left   suppress=1</C>									
								<C> id='REG_YMD'	    width=200	name='����'	        	align=center suppress=2 MASK='XXXX-XX-XX'</C>															
								<C> id='ENO_NM'	    	width=150	name='����'	        	align=center </C>							
								<C> id='WTIME'	    	width=80	name='�ð�'	        	align=center </C>	
								<C> id='TEAM_NM'	    width=120	name='����'	        	align=center </C>
								<C> id='STATUS'	    	width=100	name='����'	        	align=center </C>																																
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- �ȳ� ���� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            ��  1. "���ں�", "������Ʈ��", "���κ�" ���� Ŭ���Ͽ� ��ȸ�� �� �ֽ��ϴ�.<br>  
		     &nbsp;&nbsp;&nbsp;2. ���°� <font color="red"><b>����</b></font>�� ��� ���� �� �ݼ��� �ȵ˴ϴ�. <font color="red"><b>���</b></font>������ ��쿡�� �����մϴ�.<br> 
			 &nbsp;&nbsp;&nbsp;3. �ð��� �����ؾ��� ��� ����Բ����� �ݼ� ó���� �� ������ ���� �� �����ϸ� �˴ϴ�.<br> 
            </td>
        </tr>
</table>
<!-- �ȳ� ���� ��-->

</div>
<!-- ���� ��ȸ �׸��� ���̺� ��-->



<!-- ���κ� ���� ��ȸ �׸��� ���̺� ����-->
<div id="divEIST020_03" style="position:absolute; left:20; top:200; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_PERSON">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>	
								<C> id='ENO_NM'	    	width=150	name='����'	        	align=center suppress=1</C>																
								<C> id='REG_YMD'	    width=200	name='����'	        	align=center suppress=2 MASK='XXXX-XX-XX'</C>															
								<C> id='PJT_NM'	    	width=250	name='������Ʈ��'	        align=left   </C>
								<C> id='WTIME'	    	width=80	name='�ð�'	        	align=center </C>	
								<C> id='TEAM_NM'	    width=120	name='����'	        	align=center </C>
								<C> id='STATUS'	    	width=100	name='����'	        	align=center </C>																															
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- �ȳ� ���� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            ��  1. "���ں�", "������Ʈ��", "���κ�" ���� Ŭ���Ͽ� ��ȸ�� �� �ֽ��ϴ�.<br>  
		     &nbsp;&nbsp;&nbsp;2. ���°� <font color="red"><b>����</b></font>�� ��� ���� �� �ݼ��� �ȵ˴ϴ�. <font color="red"><b>���</b></font>������ ��쿡�� �����մϴ�.<br> 
			 &nbsp;&nbsp;&nbsp;3. �ð��� �����ؾ��� ��� ����Բ����� �ݼ� ó���� �� ������ ���� �� �����ϸ� �˴ϴ�.<br> 
            </td>
        </tr>
</table>
<!-- �ȳ� ���� ��-->

</div>
<!-- ���� ��ȸ �׸��� ���̺� ��-->




</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




