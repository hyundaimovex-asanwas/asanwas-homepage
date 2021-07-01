<!--
***********************************************************************
* @source      : di_approver.jsp
* @description : ������������ȸ PAGE(���°���)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/16     ������        �����ۼ�.
*----------------------------------------------------------------------
* 2016/05/17  |  ������   | �ҽ�����                          * 
* 2016/06/23  |  �̵���   | �ҽ�����                          * 
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%
    String gbn_cd     = request.getParameter("GBN_CD");
    String ret_cd     = request.getParameter("RET_CD");
    String str_ymd    = request.getParameter("STR_YMD");
    String end_ymd    = request.getParameter("END_YMD");
    String dpt_cd     = request.getParameter("DPT_CD");
    String eno_no     = request.getParameter("ENO_NO");
    String edu_cst    = request.getParameter("EDU_CST");
    String app_num    = JSPUtil.rns(request.getParameter("APP_NUM"));
    String gun_gbn    = JSPUtil.rns(request.getParameter("GUN_GBN"));
    
    
	if("".equals(app_num)){
		app_num = "10";
	}

%>

<html>

    <head>
    <title>������������ȸ(di_approver)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/result.js"></script>	    
    <script language=javascript src="../../common/common.js"></script>
    <script language="javascript" src="../../common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var paramDataSet  = window.dialogArguments;
        
        var paramDataSet1 = window.dialogArguments;


        var dutyYN_05_YN = 0;	//�μ��� ���� Check
        var dutyYN_41_YN = 0;	//���� ���� Check
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR01"
											                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            
            //prompt(this, dsT_CM_PERSON.DataID);
            
            dsT_CM_PERSON.reset();
            
            	//���� ���� Check
            	
				for(i=1; i <= dsT_CM_PERSON.countRow; i++){
					
						var dutyCdTemp = dsT_CM_PERSON.NameValue(i,"DUTY_CD");
						
						if(dutyCdTemp == '41'){
							
							dutyYN_41_YN += 1;
							
						}
						
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�

            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)

            // ���� �� �ش� �׸���� Focus �̵�

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
        	
            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style ����

            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����
 
            //�����ͼ� ����
            dsT_CM_DEPT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR_DPT"
						                                 										+ "&ENO_NO="+"<%=eno_no%>";
            //prompt(this,dsT_CM_DEPT.DataID);
			dsT_CM_DEPT.reset();            

			
            var eno_no  = dsT_CM_DEPT.NameValue(1,"ENO_NO");
            var dpt_cd  = dsT_CM_DEPT.NameValue(1,"DPT_CD");
	        var gbn_cd  = "<%=gbn_cd%>";
	        var ret_cd  = "<%=ret_cd%>";
	        var str_ymd = "<%=str_ymd%>";
	        var end_ymd = "<%=end_ymd%>";
	        
/*
	        alert("eno_no::"+eno_no);
	        alert("dpt_cd::"+dpt_cd);
	        alert("gbn_cd::"+gbn_cd);
	        alert("ret_cd::"+ret_cd);
	        alert("str_ymd::"+str_ymd);
	        alert("end_ymd::"+end_ymd);
*/

            //�Ѿ�� ����� ������ �����ϰ�
            document.getElementById("txtENO_NO").value      = eno_no;
            document.getElementById("hidGBN_CD").value      = gbn_cd;
            document.getElementById("hidRET_CD").value      = ret_cd;
            document.getElementById("hidSTR_YMD").value     = str_ymd;
            document.getElementById("hidEND_YMD").value     = end_ymd;

            //�Ѿ�� ������� ������� �˻�
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO");
            
            if(dsT_CM_DEPT.NameValue(1,"ENO_NO") == "") {
            	
                alert("��û�� ������ �����ϴ�.");
                
                window.close();
                
                return;
                
            }

            //�˻�����(�Ҽ�)����
            if(dpt_cd != "") {
            	
                document.getElementById("txtDPT_CD_SHR").value  = dpt_cd;

                fnc_GetCommNm('A4', "txtDPT_CD_SHR", "txtDPT_NM_SHR");
                
            } else {
            	
                document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
        
                document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
                
            }

            //��û�� ���� �߰�
            document.getElementById("lblJOB_NM_A2").innerText   = dsT_CM_DEPT.NameValue(1,"JOB_NM");
            document.getElementById("lblENO_NO_A2").innerText   = dsT_CM_DEPT.NameValue(1,"ENO_NO");
            document.getElementById("lblENO_NM_A2").innerText   = dsT_CM_DEPT.NameValue(1,"ENO_NM");

            //��û�� ���� ����
            document.getElementById("txtENO_NO").value      = enoObj.eno_no;
            document.getElementById("txtENO_NM").value      = enoObj.eno_nm;
            document.getElementById("txtDPT_CD").value      = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM").value      = enoObj.dpt_nm;
            document.getElementById("txtJOB_CD").value      = enoObj.job_cd;
            document.getElementById("txtJOB_NM").value      = enoObj.job_nm;
            document.getElementById("txtDUTY_CD").value      = enoObj.duty_cd;
            document.getElementById("txtDUTY_NM").value      = enoObj.duty_nm;

            document.getElementById("txtHEAD_TAG").value      = enoObj.head_tag;

            cfCopyDataSet(paramDataSet, dsT_DI_APPROVAL);
            
            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR"
						                                 + "&ENO_NO="+"<%=eno_no%>"
						                                 + "&DPT_CD="+dsT_CM_DEPT.NameValue(1,"DPT_CD")
						                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
						                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
						                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
						                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value;
            
            dsT_CM_PERSON.reset();
            
            // �μ��ڵ� �ڵ鸵�Ҽ��ְ�
			document.getElementById("txtDPT_CD_SHR").value = "";
			document.getElementById("txtDPT_NM_SHR").value = "";
			
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /**
         * �����ڸ� ������ �� Ȯ���� ������ ������������ �Ѿ
         * (�����ڰ� ������ ��û�ڰ� �����ڷ� �Ѿ)
         */
        function fnc_Confirm() {

        		// ���� ���� Check
				var dutyCd = document.getElementById("txtDUTY_CD").value;
				var dutyNm = document.getElementById("txtDUTY_NM").value;
				var dpt_Cd = document.getElementById("txtDPT_CD").value;
				var dutyYN = 0;
				var dutyYN_A4 = 0;  //���� -> �ӽ� ����
				var dutyYN_03 = 0;  //������
				var dutyYN_B6 = 0;  //�������
				var dutyYN_05 = 0;	//�μ���
				var dutyYN_41 = 0;	//����				
				var headTag = document.getElementById("txtHEAD_TAG").value;
				var Cost = 0;
				
				Cost = "<%=edu_cst%>";

				for(i=1; i <= dsT_DI_APPROVAL.countRow; i++){
						var dutyCdTemp = dsT_DI_APPROVAL.NameValue(i,"GUN_YMD");  //����
						var JobCdTemp  = dsT_DI_APPROVAL.NameValue(i,"JOB_CD");

						if(dutyCdTemp == '03'){
							dutyYN_03 += 1;
						}else if(dutyCdTemp == 'B6'){
							dutyYN_B6 += 1;
						}else if(dutyCdTemp == '05'){
							dutyYN_05 += 1;
						}else if(dutyCdTemp == '41'){
							dutyYN_41 += 1;							
						}else if(JobCdTemp  == '02'){
							dutyYN_A4 += 1;					
						}
					// �濵�������� ������ ���� ���� �������  -- �ӽ�
					//if((headTag == 'B4' || headTag == '03') && (dutyCdTemp == '05')){
					//	dutyYN_03 += 1;
					//}

				}

				
				
           if("<%=gun_gbn%>" == "D" ||  "<%=gun_gbn%>" == "J"){   //������ ���� Check "<%=gun_gbn%>" == "B" ||

					if(dutyCd != "03"){
						
					 if(dutyYN_03 == 0 ){
						 
					   if("<%=gun_gbn%>" == "D" || "<%=gun_gbn%>" == "B"){
						   
							alert("���� �Ǵ�  �İ߰����� ������ �����Դϴ�.");
							
					   }else{
						   
						   	alert("���ϱٹ������� ������ �����Դϴ�.");
						   	
					   }

						return;
					 }
					 
					}

			}else if("<%=gun_gbn%>" == "C" || "<%=gun_gbn%>" == "U" || "<%=gun_gbn%>" == "P"  || "<%=gun_gbn%>" == "A" || "<%=gun_gbn%>" == "M"  || "<%=gun_gbn%>" == "N"|| "<%=gun_gbn%>" == "Q"){

				if(dutyCd != '03' && dutyCd != '05' && dutyCd != '41'){
					
					
					//������ �����̿��� ���� �ö� �� �־��� ����δ� ���������� �ö󰬾���.
					
					if(dutyYN_05 == 0 && headTag != 'Q1' && headTag != 'Q2' && dutyYN_05_YN > 0 && dpt_Cd != 'I800' && dpt_Cd != 'I100' && dpt_Cd != 'I200'){
						

						alert("����/����/�������Ի����� ���� �����Դϴ�.");
						
						
						//////return;  �׽�Ʈ �� Ǯ��
					}

					// ������� ����
					//if(headTag == 'Q1' || headTag == 'Q2'){
					//
					//	if(dutyYN_B6 == 0){
					//		alert("���»����� ������� �����Դϴ�.");
					//		return;
					//	}
					//}

				}

			}else if("<%=gun_gbn%>" == "B"){				//������ ���

																			//2017.01.23 �μ��� -> ������ ��������Ƿ� �̵��� ����
				if(dutyCd != '03' && dutyCd != '05' && dutyCd != '41'){		//�� �ź��� �μ���(����)�� �ƴϰ� �����嵵 �ƴϸ� �� ��������

					if(dutyYN_03 > 0 ){						//��������߿� ������ �����ڰ� ������ Ȯ�� �޽���
						
						if(confirm("������ ���� �����Դϴ�. ������ ���絵 �����ðڽ��ϱ�?")){

			            } else {
			            	
			                return;
			                
			            }

					}

				
				    //2014.07.22 ������ ���� ��û���� �̵��� ����
					if(dutyYN_A4 > 0) {
						
						alert("��ǥ�̻�� ����� �ش�μ�����\n�������� ����Ͽ� �����Ͽ� �ֽñ� �ٶ��ϴ�.");
						
						return;
						
					}
				    
				    
				/*
				if(dutyCd != '04'){

					if(dutyYN_05 == 0 && dpt_Cd != 'C841' && dpt_Cd != 'E211' && dpt_Cd != 'C130' && dpt_Cd != 'B500' && dpt_Cd != 'I500' && dpt_Cd != 'I100' && dpt_Cd != 'I130'  && dpt_Cd != 'I143' && dpt_Cd != 'I800'){	//�μ��� ��������� ������ ���´��
						
						alert("������ �μ��� �����Դϴ�. Ȯ�ιٶ��ϴ�.");
					
						return;
					}

				}
				*/

				}


			}else if("<%=gun_gbn%>" == "R" || "<%=gun_gbn%>" == "H" ){

					if(dutyYN_03 == 0){
						alert("���ϱٹ������� ������ �����Դϴ�.");
						return;
					}
					if(dutyYN_05 == 0 ){
						alert("���ϱٹ� ������ ���� ���� �ʼ����� �Դϴ�.");
						return;
					}

					// ������� ����
					//if(headTag == 'Q1' || headTag == 'Q2'){
					//
					//	if(dutyYN_B6 == 0){
					//		alert("���ϱٹ� ������ ������� ���� �ʼ����� �Դϴ�.");
					//		return;
					//	}
					//}

			}
            cfCopyDataSet(dsT_DI_APPROVAL, paramDataSet1);
            window.close();

        }

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��()      |
    | 3. ���Ǵ� Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var i = 0;

		var dutyCd = document.getElementById("txtDUTY_CD").value;
		var dutyNm = document.getElementById("txtDUTY_NM").value;

		//if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == "<%=eno_no%>"){
		//	alert("����� ������ �����ڰ� �ɼ� �����ϴ�");
		//	return false;
		//}




		if(dsT_DI_APPROVAL.CountRow >= <%=app_num%>){
			alert("���缱�� <%=app_num%>  ������ �����Ҽ��ֽ��ϴ�.");
			return false;
		}
		// �μ��常 �����忡�� ��û�Ҽ� �ִ�


		var headTag =  document.getElementById("txtHEAD_TAG").value;

		if("<%=gun_gbn%>" == "C" || "<%=gun_gbn%>" == "U" || "<%=gun_gbn%>" == "P"  || "<%=gun_gbn%>" == "A" || "<%=gun_gbn%>" == "M"  || "<%=gun_gbn%>" == "N"){
			if(dutyCd != '03' && dutyCd != '05'){

				if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"DUTY_CD")  == "03"  && dutyYN_05_YN > 0){
					alert("����/���»����� �μ��� �����Դϴ�.");
					return false;
				}
			//	if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"HEAD_TAG")  != headTag){
			//		alert("�������缱�� �ƴմϴ�");
			//		return false;
			//	}
			}
		}
        //�ߺ����üũ
        for(i=1; i<=dsT_DI_APPROVAL.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_DI_APPROVAL.NameValue(i,'ENO_NO')){
                alert("�ش� �����ڴ� �̹� ���缱�� ���ԵǾ� �ֽ��ϴ�.");
                return false;
            }
        }
        dsT_DI_APPROVAL.InsertRow(1);//���������� �ֱ� ���� insert
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = dsT_CM_PERSON.NameValue(row,'DUTY_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = dsT_DI_APPROVAL.CountRow;
    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var i = 0;

		//if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == "<%=eno_no%>"){
		//	alert("����� ������ �����ڰ� �ɼ� �����ϴ�");
		//	return false;
		//}


		if(dsT_DI_APPROVAL.CountRow > <%=app_num%>){
			alert("���缱�� <%=app_num%>  ������ �����Ҽ��ֽ��ϴ�.");
			return false;
		}
		// �μ��常 �����忡�� ��ó�˼� �ִ�
		var dutyCd = document.getElementById("txtDUTY_CD").value;
		var dutyNm = document.getElementById("txtDUTY_NM").value;

		var headTag =  document.getElementById("txtHEAD_TAG").value;

		//alert(dutyCd);
		if("<%=gun_gbn%>" == "D"){

		}else if("<%=gun_gbn%>" == "C" || "<%=gun_gbn%>" == "U" || "<%=gun_gbn%>" == "P"  || "<%=gun_gbn%>" == "A" || "<%=gun_gbn%>" == "M" || "<%=gun_gbn%>" == "N"){
			if(dutyCd != 'B6' && dutyCd != '05'){
				//alert(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"DUTY_CD"));
				if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"DUTY_CD")  == "03"){
					alert("����/���»����� �μ��� �����Դϴ�.");
					return false;
				}
				if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"HEAD_TAG")  != headTag){
					alert("�������缱�� �ƴմϴ�");
					return false;
				}
			}
		}
        //�ߺ����üũ
        for(i=1; i<=dsT_DI_APPROVAL.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_DI_APPROVAL.NameValue(i,'ENO_NO')){
                alert("�ش� �����ڴ� �̹� ���缱�� ���ԵǾ� �ֽ��ϴ�.");
                return false;
            }
        }

        dsT_DI_APPROVAL.InsertRow(1);//���������� �ֱ� ���� insert

        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = dsT_CM_PERSON.NameValue(row,'DUTY_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = dsT_DI_APPROVAL.CountRow;
    </script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event=OnDblClick(row,colid)>

        var j = 0;
        var i = 0;

        // ����ڴ� ���� ���Ѵ�.
		/*
        if(dsT_DI_APPROVAL.CountRow == row){
            alert("��û�ڴ� ���缱���� ������ �� �����ϴ�.");
            return;
        }
		*/
        dsT_DI_APPROVAL.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_DI_APPROVAL.CountRow-1; i>=1; i--){
            j++;
            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = j;
        }

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event=OnReturn(row,colid)>

        var j = 0;
        var i = 0;

        // ����ڴ� ���� ���Ѵ�.
        if(dsT_DI_APPROVAL.CountRow == row){
            alert("��û�ڴ� ���缱���� ������ �� �����ϴ�.");
            return;
        }

        dsT_DI_APPROVAL.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_DI_APPROVAL.CountRow-1; i>=1; i--){
            j++;
            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = j;
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������������ȸ</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">��� ��ȣ/����&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">

                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">

                                        <input type="hidden" id="txtENO_NO">
                                        <input type="hidden" id="txtENO_NM">
                                        <input type="hidden" id="txtDPT_CD">
                                        <input type="hidden" id="txtDPT_NM">
                                        <input type="hidden" id="txtJOB_CD">
                                        <input type="hidden" id="txtJOB_NM">

                                        <input type="hidden" id="txtDUTY_CD">
                                        <input type="hidden" id="txtDUTY_NM">
                                        <input type="hidden" id="txtHEAD_TAG">

                                    </td>

                                    <td align="center" class="searchState">�Ҽ�&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="../../images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:157px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           	width=100  	name=����   align=left   </C>
                                    <C> id=DPT_NM            	width=110   name=�Ҽ�   align=left   </C>
                                    <C> id=JOB_NM            	width=60   	name=����   align=left   </C>
                                    <C> id=ENO_NM            	width=70   	name=����   align=center </C>
                                    <C> id=DUTY_NM            width=80   	name=��å   align=center </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><font color = "blue">�� �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>���缱</strong>
	        </td>
	    </tr>
	    <tr>
	        <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:157px;">
                                <param name="DataID"            value="dsT_DI_APPROVAL">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=SEQ_NO          		width=39    	name=NO     align=center   </C>
                                    <C> id=DPT_NM            	width=110   	name=�Ҽ�   align=left     </C>
                                    <C> id=JOB_NM            	width=110    name=����   align=center   </C>
                                    <C> id=ENO_NM           	width=120   	name=����   align=center   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><font color = "blue">�� �ش��׸��� ����Ŭ�� �Ͻø� �����˴ϴ�.</font></span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="blueBold">��û��</td>
                        <td align="center" class="blueBold">����</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="blueBold">���</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="blueBold">����</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','../../images/button/btn_ConfirmOver.gif',1)"><img src="../../images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    </form>
    <!-- form �� -->

</body>
</html>