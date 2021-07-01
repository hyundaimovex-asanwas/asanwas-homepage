<!--
***********************************************************************
* @source      : buta021.jsp
* @description : �����꼭 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      �̵���        ERP �̻�
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
	String status = request.getParameter("STATUS");        		//ǰ�ǹ�ȣ
	//String role_cd = box.getString("SESSION_ROLE_CD");         //�ѱ���
%>

<html>
<head>
<title>�����꼭</title>
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

	<script language="javascript">


        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

            //�����꼭 ��ȸ
            dsT_DI_BUSINESSTRIP_BASIS.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR&ORD_NO="+dsTemp.NameValue(1,"ORD_NO");
            dsT_DI_BUSINESSTRIP_BASIS.reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�������ޱ��� ��ȸ
            dsT_DI_BUSINESSTRIP_BASIS2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR_01";
            dsT_DI_BUSINESSTRIP_BASIS2.reset();

            //���޿� ���� �ܰ��� ��ȸ
            dsT_DI_BUSINESSTRIP_BASIS3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR_02&JOB_CD="+dsTemp.NameValue(1,"JOB_CD")+"&COM_CD1="+dsTemp.NameValue(1,"COM_CD1")+"&COM_CD2="+dsTemp.NameValue(1,"COM_CD2")+"&COM_CD3="+dsTemp.NameValue(1,"COM_CD3")+"&COM_CD4="+dsTemp.NameValue(1,"COM_CD4")+"&COM_CD5="+dsTemp.NameValue(1,"COM_CD5");
            dsT_DI_BUSINESSTRIP_BASIS3.reset();

            //������ȸ
            dsT_DI_HOLIDAY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR_03&BUT_FR_YMD="+dsTemp.NameValue(1,"BUT_FR_YMD")+"&BUT_TO_YMD="+dsTemp.NameValue(1,"BUT_TO_YMD");
            dsT_DI_HOLIDAY.reset()


        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

            if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV") return;

            dsT_DI_BUSINESSTRIP_BASIS.AddRow();
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

            if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV") return;

        	dsT_DI_BUSINESSTRIP_BASIS.DeleteRow(dsT_DI_BUSINESSTRIP_BASIS.RowPosition);

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

            if (dsT_DI_BUSINESSTRIP_BASIS.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

			dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING(20)");


 			if (gusrid == '6060002' || gusrid == '6180001'|| gusrid == '2180001'){
 				
				//�Ӻ��̾��� �̵���, ������ �븮�� �����������
			    cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,0,"true","false");      // Grid	 Style ����
			    
			    document.getElementById("helpMessage").innerText = ' �� �����꼭 ������ ó����ư�� Ŭ���ϼž� �ݿ��� �˴ϴ�. ����� �ܰ� �� ��� ������ �����մϴ�.';
			    
			    
            }else if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV"){
            	
            	cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,0,"false","false");      // Grid Style ����
                
				document.getElementById("ImgConduct").style.display = "none";//ó����ư �ʺ��̰�
				
                document.getElementById("helpMessage").innerText = '';

            }else{
            	
            	cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,0,"true","false");      // Grid Style ����
			    
			    document.getElementById("helpMessage").innerText = ' �� �����꼭 ������ ó����ư�� Ŭ���ϼž� �ݿ��� �˴ϴ�. ����� �ܰ� �� ��� ������ �����մϴ�.';
			    
            }

			fnc_SearchItem();//�׸� �ڵ常 �����°� ����

            fnc_SearchList();//�����꼭 ��ȸ

            fnc_TotAccount();//�հ�ݾ� ���



        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. �����ͼ� ����(fnc_compareDS�� ���� �����ؾ� ��)*
         ********************************************/
		function fnc_SettingDS() {



			// �ܺ����� �ݾ׿��� ������
			//dsTemp�� dsT_DI_BUSINESSTRIP_STATE_CP�� ����
			cfCopyDataSet(dsTemp, dsT_DI_BUSINESSTRIP_CP, "copyHeader=yes,rowFrom=1,rowCnt=1");


            var seq1 = 0;
            var seq2 = 0;
            var seq3 = 0;
            var seq4 = 0;
            var seq5 = 0;
            var seq6 = 0;
            var g2_cnt = 0;     //���� �� �Ļ� ȸ��

            //�����
            for(i=1;i<=8;i++){

                if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C1" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C2" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C3" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C4" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C5" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C6"){

                    dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"CITY_DPT") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_DPT"+i);
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"CITY_AVR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_ARV"+i);
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;

                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C1"){
                        seq1 = seq1 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C1";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq1;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C2"){
                        seq2 = seq2 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C2";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq2;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C3"){
                        seq3 = seq3 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C3";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq3;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C4"){
                        seq4 = seq4 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C4";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq4;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C5"){
                        seq5 = seq5 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C5";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq5;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C6"){
                        seq6 = seq6 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C6";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq6;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                }
            }

			//������������ ����
            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP.NameValue(1,"START_GBN") == "1"){
				//������� : ��������� ��� ���� 1 / �ĺ� 3 (���Ͽ��ο� ���� �ĺ����)
                //           ��������� ��� ���� 1 / �ĺ� 2

	            //���ں�
                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = "1";
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;

	            //�ĺ�
	            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "A"){        //������� ����
	                g2_cnt = 3;
	            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "P"){  //������� ����
	                g2_cnt = 2;
	            }
	            

	            
	            
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = g2_cnt;
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

                //�Ϻ�(�������������� ������ 2��)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
                    dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY");
                    //������
                    if(i > 1){
                        //������ ������ ����, ���� Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP.NameValue(1,"START_GBN") == "2"){
				//������� : ���ں�,�ĺ� ������ �ڵ������� ����

                //�Ϻ�(�������������� ������ 2��)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
                    dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") =  dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY");
                    //������
                    if(i > 1){
                        //������ ������ ����, ���� Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else{



        if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"SLEEP_DAY") > 0){           	
	            //���ں�
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"SLEEP_DAY"));
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }
        }

        		//prompt(this,dsT_DI_BUSINESSTRIP_CP.text);
        		//alert(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_TO_GBN"));        
	            //�ĺ�
	            //g2_cnt = (dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") - 2) * 3;
				//alert(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY"));   
	            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") == 1){    

	            	g2_cnt = 1;
	            	//alert("g2_cnt1===="+g2_cnt);
	            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") == 2){
	            	
	            	g2_cnt = 5;
	            	//alert("g2_cnt2===="+g2_cnt);
	            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") > 2){
	            	
	            	g2_cnt = 2 + (dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") - 1) * 3;
	            	//alert("g2_cnt3===="+g2_cnt);
	            }
	            	
	            //alert("g2_cnt===="+g2_cnt);
	            /*
		            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "A"){        //������� ����
		            	
		                //g2_cnt = g2_cnt + 2;
		            	g2_cnt = g2_cnt + 1;
		            	alert(g2_cnt); 
		            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "P"){  //������� ����
		                g2_cnt = g2_cnt + 1;
		            }
		            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_TO_GBN") == "A"){        //�������� ����
		                g2_cnt = g2_cnt + 1;
		            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_TO_GBN") == "P"){  //�������� ����
		                g2_cnt = g2_cnt + 3;
		                alert(g2_cnt); 
		            }
				*/

	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = g2_cnt;
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

	            //���
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G3";
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY");
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

            }//������������ ���� ��

            //�ܰ� �� �ĺ����, �հ�ݾ� Setting
            var sqn_no;
            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS.CountRow;i++){

                sqn_no = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"SQN_NO");//�Ϸù�ȣ

                for(j=1;j<=dsT_DI_BUSINESSTRIP_BASIS2.CountRow;j++){
                    if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD") == dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,"GBN_CD")){


                        if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD").substring(0,1) == "G"){
                            dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(sqn_no,"EXT_02"));
                        }else{
                            dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(1,"EXT_02"));
                        }
                    }

                }//�ܰ�

                dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"COST_AMT") = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT")*dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"BAS_CNT");//�հ�޾�

            }

            //sort���ش�.(�űԿ� ���嵥���� �񱳸� ���� �ʿ�)
            dsT_DI_BUSINESSTRIP_BASIS.SortExpr = "+GBN_CD+SQN_NO";
            dsT_DI_BUSINESSTRIP_BASIS.Sort();

		}

        /********************************************
         * 16. �����ͼ� ��(fnc_SettingDS�� ���� �����ؾ� ��)*
         ********************************************/
		function fnc_compareDS() {

			//dsTemp�� dsT_DI_BUSINESSTRIP_STATE_CP�� ����
			cfCopyDataSet(dsTemp, dsT_DI_BUSINESSTRIP_CP_TMP, "copyHeader=yes,rowFrom=1,rowCnt=1");

            var seq1 = 0;
            var seq2 = 0;
            var seq3 = 0;
            var seq4 = 0;
            var seq5 = 0;
            var seq6 = 0;
            var g2_cnt = 0;     //���� �� �Ļ� ȸ��

			if (dsT_DI_BUSINESSTRIP_BASIS_TMP.CountColumn == 0) {
			    dsT_DI_BUSINESSTRIP_BASIS_TMP.setDataHeader("ORD_NO:STRING:KEYVALUETYPE, GBN_CD:STRING:KEYVALUETYPE, SQN_NO:STRING:KEYVALUETYPE, " +
                                             				"ENO_NO:STRING, NAM_KOR:STRING, DPT_CD:STRING, JOB_CD:STRING, CITY_DPT:STRING,CITY_AVR:STRING, PRICE_AMT:DECIMAL, BAS_CNT:DECIMAL, COST_AMT:DECIMAL, REMARK:STRING, DESC_AMT:DECIMAL");
			}

            //�����
            for(i=1;i<=8;i++){

                if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C1" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C2" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C3" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C4" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C5" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C6"){

                    dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"CITY_DPT") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_DPT"+i);
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"CITY_AVR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_ARV"+i);
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;

                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C1"){
                        seq1 = seq1 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C1";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq1;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C2"){
                        seq2 = seq2 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C2";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq2;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C3"){
                        seq3 = seq3 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C3";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq3;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C4"){
                        seq4 = seq4 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C4";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq4;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C5"){
                        seq5 = seq5 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C5";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq5;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C6"){
                        seq6 = seq6 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C6";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq6;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                }
            }

			//������������ ����
            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"START_GBN") == "1"){
				//������� : ��������� ��� ���� 1 / �ĺ� 3 (���Ͽ��ο� ���� �ĺ����)
                //           ��������� ��� ���� 1 / �ĺ� 2

	            //���ں�
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

	            //�ĺ�
	            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "A"){        //������� ����
	                g2_cnt = 3;
	            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "P"){  //������� ����
	                g2_cnt = 2;
	            }

	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){


	                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = g2_cnt;
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

                //�Ϻ�(�������������� ������ 2��)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){


                    dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = "2";
                    //������
                    if(i > 1){
                        //������ ������ ����, ���� Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"START_GBN") == "2"){
				//������� : ���ں�,�ĺ� ������ �ڵ������� ����
                //�Ϻ�(�������������� ������ 2��)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = "2";
                    //������
                    if(i > 1){
                        //������ ������ ����, ���� Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else{


           if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"SLEEP_DAY") > 0){ 
	            //���ں�
                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;


                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"SLEEP_DAY"));

            }
                
	            //�ĺ�
                g2_cnt = (dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_DAY") - 2) * 3;

		            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "A"){        //������� ����
		                g2_cnt = g2_cnt + 2;
		            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "P"){  //������� ����
		                g2_cnt = g2_cnt + 1;
		            }
		            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_TO_GBN") == "A"){        //�������� ����
		                g2_cnt = g2_cnt + 1;
		            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_TO_GBN") == "P"){  //�������� ����
		                g2_cnt = g2_cnt + 3;
		            }


	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = g2_cnt;
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

	            //�Ϻ�
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G3";
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_DAY");
	                //������
	                if(i > 1){
	                    //������ ������ ����, ���� Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

            }//������������ ���� ��




            //�ܰ� �� �ĺ����, �հ�ݾ� Setting
            var sqn_no;
            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS_TMP.CountRow;i++){

                sqn_no = dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"SQN_NO");//�Ϸù�ȣ
                for(j=1;j<=dsT_DI_BUSINESSTRIP_BASIS2.CountRow;j++){
                    if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD") == dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,"GBN_CD")){


                        if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD").substring(0,1) == "G"){
                            dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(sqn_no,"EXT_02"));
                        }else{
                            dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(1,"EXT_02"));
                        }
                    }

                }//�ܰ�


                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"COST_AMT") = dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT")*dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"BAS_CNT");//�հ�޾�

            }

            //sort���ش�.(�űԿ� ���嵥���� �񱳸� ���� �ʿ�)
            dsT_DI_BUSINESSTRIP_BASIS_TMP.SortExpr = "+GBN_CD+SQN_NO";
            dsT_DI_BUSINESSTRIP_BASIS_TMP.Sort();


			if(dsT_DI_BUSINESSTRIP_BASIS_TMP.countrow != dsT_DI_BUSINESSTRIP_BASIS.countrow){
				return false;
			}else{
				for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS_TMP.CountRow;i++){
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"ORD_NO") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"ORD_NO")){
						return false;
					}

					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"SQN_NO") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"SQN_NO")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"ENO_NO") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"ENO_NO")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"NAM_KOR") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"NAM_KOR")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"DPT_CD") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"DPT_CD")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"JOB_CD") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"JOB_CD")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"CITY_DPT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"CITY_DPT")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"CITY_AVR") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"CITY_AVR")){
						return false;
					}


					//������ ���� ������ �����ϹǷ� �񱳺Ұ�

					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD").substring(0,1) != "C"){



						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT")){
							return false;
						}
						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"BAS_CNT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"BAS_CNT")){
							return false;
						}
						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"COST_AMT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"COST_AMT")){
							return false;
						}
						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"DESC_AMT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"DESC_AMT")){
							return false;
						}

					}


				}
			}

			return true;

		}

        /********************************************
         * 17. �հ�ݾ� ���						*
         ********************************************/
		function fnc_TotAccount() {

            var tot_sum = 0;//�հ� �ݾ�

            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS.CountRow;i++){
                tot_sum = tot_sum + dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"COST_AMT");
            }

            form1.medTOT_AMT.Text = tot_sum;

		}

        /********************************************
         * 18. 'ó��'��ư ó��  					*
         ********************************************/
		function fnc_Reflect() {

            //if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV") return;

            if (!dsT_DI_BUSINESSTRIP_BASIS.IsUpdated ) {
				//alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return;
			}

            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS.CountRow;i++){
				dsT_DI_BUSINESSTRIP_BASIS.UserStatus(i) = 1;
            }

            trT_DI_BUSINESSTRIP_BASIS.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_BASIS=dsT_DI_BUSINESSTRIP_BASIS)";
			trT_DI_BUSINESSTRIP_BASIS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SAV";
			trT_DI_BUSINESSTRIP_BASIS.post();

            dsTemp.NameValue(1,"BASIS_YN") = "SA";//�����꼭 ���� ����

            alert("ó���Ǿ����ϴ�. ����� �����մϴ�.");

			window.close();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_BUSINESSTRIP_BASIS)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_BASIS) 		|
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_BUSINESSTRIP_BASIS)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_BASIS) 		|
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS_TMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!---------------------------------------------------------+
    | 1. ��ȸ�� DataSet							               |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_BASIS2)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_BASIS) 		   |
    +---------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!---------------------------------------------------------+
    | 1. ��ȸ�� DataSet							               |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_BASIS3)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_BASIS) 		   |
    +---------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!---------------------------------------------+
    | 1. ��ȸ�� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_HOLIDAY)|
    | 3. ���Ǵ� Table List(T_DI_HOLIDAY) 		   |
    +---------------------------------------------->
	<Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP)    |
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP)    |
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_CP_TMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_STATE)    |
    | 3. ���Ǵ� Table List(dsT_DI_BUSINESSTRIP_STATE) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


    <!--------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_BASIS)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_BASIS)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
	</Object>

    <!--------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadCompleted(iCount)">

		if (iCount < 1)    {
            //fnc_SearchItem();//��ȸ �Լ�_Item ������ ��ȸ
			fnc_SettingDS();//�����ͼ� ����
			//alert("�ű�");

		}


		else {
			//�����ͼ� ��
			if(fnc_compareDS()){

				// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
				fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
			}else{

			}

            dsTemp.NameValue(1,"BASIS_YN") = "SA";//�����꼭 ���� ����
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�׸�/NO] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[�׸�/NO]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS2 Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS2 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS3 Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS3 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAY Event="OnLoadError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">
        cfErrorMsg(this);
		window.close();
    </script>
    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
        cfErrorMsg(this);
		window.close();

    </script>


    <!---------------------------------------------------------------------------------------------------------+
    | Grid�󿡼� Editable���¿��� �ϳ��� Cell�� �Է��� �Ϸ��� ��, ���� Cell�� ��Ŀ���� �ű� �� �߻��ϴ� Event  |
    +---------------------------------------------------------------------------------------------------------->
    <script language=JavaScript for=grdT_DI_BUSINESSTRIP_BASIS event=OnExit(row,colid,olddata)>


		if(colid == "PRICE_AMT" || colid == "BAS_CNT"){
		    dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"COST_AMT") = dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT")*dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"BAS_CNT");
		    fnc_TotAccount();
		}


    </script>

	<script language=JavaScript for=dsT_DI_BUSINESSTRIP_BASIS event=OnRowPosChanged(row)>

	    var Column = grdT_DI_BUSINESSTRIP_BASIS.GetColumn();

	    //header�� ���� ������ �� �� �ִ�.
	    if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD") == undefined){
	       return false;
	    }



        //�����ܰ��� ������ ����(��, �ڰ����� �˾����� �����ϹǷ� �����Ұ�)
        if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD") == "C5" || (dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD").substring(0,1) != "C" && dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD").substring(0,1) != "G")){
            grdT_DI_BUSINESSTRIP_BASIS.Format = "<C> id='{CUROW}'    width=39    name='NO'         align=center    value={String(Currow)}      </C>" +
                                                "<C> id='GBN_CD'     width=100   name='�׸�'       align=left      Edit=none EditStyle=Lookup  Data='dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME' </C>" +
                                                "<C> id='SQN_NO'     width=40    name='SEQ'        align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_DPT'   width=90    name='�����'     align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_AVR'   width=90    name='������'     align=center    Edit=none                   </C>" +
                                                "<C> id='PRICE_AMT'  width=70    name='�ܰ�'       align=right     Edit=none                   </C>" +
                                                "<C> id='BAS_CNT'    width=50    name='����'       align=right     Edit=none                   </C>" +
                                                "<C> id='COST_AMT'   width=70    name='�ݾ�'       align=right     Edit=none                   </C>" +
                                                "<C> id='REMARK'     width=160   name='���'       align=left                                  </C>";

        }else if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD").substring(0,1) == "G"){
            grdT_DI_BUSINESSTRIP_BASIS.Format = "<C> id='{CUROW}'    width=39    name='NO'         align=center    value={String(Currow)}      </C>" +
                                                "<C> id='GBN_CD'     width=100   name='�׸�'       align=left      Edit=none EditStyle=Lookup  Data='dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME' </C>" +
                                                "<C> id='SQN_NO'     width=40    name='SEQ'        align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_DPT'   width=90    name='�����'     align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_AVR'   width=90    name='������'     align=center    Edit=none                   </C>" +
                                                "<C> id='PRICE_AMT'  width=70    name='�ܰ�'       align=right                                 </C>" +
                                                "<C> id='BAS_CNT'    width=50    name='����'       align=right                        		   </C>" +
                                                "<C> id='COST_AMT'   width=70    name='�ݾ�'       align=right     Edit=none                   </C>" +
                                                "<C> id='REMARK'     width=160   name='���'       align=left                                  </C>";


        }else{
            grdT_DI_BUSINESSTRIP_BASIS.Format = "<C> id='{CUROW}'    width=39    name='NO'         align=center    value={String(Currow)}      </C>" +
                                                "<C> id='GBN_CD'     width=100   name='�׸�'       align=left      Edit=none EditStyle=Lookup  Data='dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME' </C>" +
                                                "<C> id='SQN_NO'     width=40    name='SEQ'        align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_DPT'   width=90    name='�����'     align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_AVR'   width=90    name='������'     align=center    Edit=none                   </C>" +
                                                "<C> id='PRICE_AMT'  width=70    name='�ܰ�'       align=right                                 </C>" +
                                                "<C> id='BAS_CNT'    width=50    name='����'       align=right     			                   </C>" +
                                                "<C> id='COST_AMT'   width=70    name='�ݾ�'       align=right     Edit=none                   </C>" +
                                                "<C> id='REMARK'     width=160   name='���'       align=left                                  </C>";
        }




	    for(var i=0; i < grdT_DI_BUSINESSTRIP_BASIS.CountColumn; i++) {
	    	
	        grdT_DI_BUSINESSTRIP_BASIS.ColumnProp(grdT_DI_BUSINESSTRIP_BASIS.GetColumnID(i),'HeadColor')   = "#000000";   // Header ForeColor
	        grdT_DI_BUSINESSTRIP_BASIS.ColumnProp(grdT_DI_BUSINESSTRIP_BASIS.GetColumnID(i),'HeadBgColor') = "#dae0ee";   // Header BackColor
	        grdT_DI_BUSINESSTRIP_BASIS.ColumnProp(grdT_DI_BUSINESSTRIP_BASIS.GetColumnID(i), 'Sort')       = true;        //Sort ����
	    }


	    grdT_DI_BUSINESSTRIP_BASIS.SetColumn(Column);

	</script>

    <script language=JavaScript for=grdT_DI_BUSINESSTRIP_BASIS event="OnClick(row,colid)">
        //�ܰ� Ŭ���ÿ� �˾�(��� �Է°����ϱ⶧���� �ο���ü�� �ɸ� �ʵȴ�.
        if(colid == "PRICE_AMT"){
	        var flag = "";//���尡�ɿ���
	        //ó�����ɿ���
	        if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV"){
	            flag = "N";
	        }else{
	            flag = "Y";
	        }

	        //����� �˾�
	        if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD") == "C5"){

				window.showModalDialog("../../../Ehr/hr/but/buta024.jsp?row="+row+"&flag="+flag, dsT_DI_BUSINESSTRIP_BASIS, "dialogWidth:635px; dialogHeight:330px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

	            if(isNaN( Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_DISTANCE")) / Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_EFFICIENCY"))) || !isFinite(Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_DISTANCE")) / Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_EFFICIENCY")))){
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT") = Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_TOLL")) + 0;
	            }else{
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT") = Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_TOLL")) + (Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_OIL")) * (Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_DISTANCE")) / Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_EFFICIENCY"))));
	            }

                if(Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT")) != 0){
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"COST_AMT")  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT") * dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"BAS_CNT") + dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"DESC_AMT");//�հ�޾�
                }

	            dsT_DI_BUSINESSTRIP_BASIS.RowPosition = row;

	        }
        }

    </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�����꼭</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" width="650">
			    <span id="helpMessage">&nbsp;</span>

			</td>
			<td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConduct','','../../images/button/btn_ConductOver.gif',1)"> <img src="../../images/button/btn_ConductOn.gif" name="ImgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_BUSINESSTRIP_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:315px;">
						<param name="DataID" value="dsT_DI_BUSINESSTRIP_BASIS">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}		</C>
							<C> id="GBN_CD"	    width=100	name="�׸�"		align=left	    Edit=none EditStyle=Lookup  Data="dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME" </C>
							<C> id="SQN_NO"		width=40	name="SEQ"		align=center	Edit=none </C>
                            <C> id="CITY_DPT"	width=90	name="�����"	align=center	Edit=none </C>
							<C> id="CITY_AVR"	width=90	name="������"	align=center    Edit=none </C>
                            <C> id="PRICE_AMT"	width=70	name="�ܰ�"		align=right     </C>
                            <C> id="BAS_CNT"	width=50	name="����"		align=right     Edit=none </C>
                            <C> id="DESC_AMT" 	width=70	name="�ĺ����"	align=right     Edit=none </C>
                            <C> id="COST_AMT"	width=70	name="�ݾ�"		align=right     Edit=none </C>
                            <C> id="REMARK"	    width=160	name="���"		align=left      </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <tr>
			<td  width="50%" align="left" class="paddingTop5">
				<!-- ��ȸ ���� ���̺� ���� -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- ��ȸ ���� ���̺� �� -->
			</td>
			<td  width="" align="right" class="paddingTop5">
				<!-- ��ȸ ���� ���̺� ���� -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState" width="100">����� �� :&nbsp;&nbsp;</td>
	                                <td valign="bottom" class="searchState">
										<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100;">
											<param name=Alignment						value=2>
											<param name=Border							value=true>
											<param name=ClipMode						value=true>
											<param name=DisabledBackColor			value="#D1B2FF">
											<param name=InheritColor   				value=true>
											<param name=Enable							value=false>
											<param name=IsComma						value=true>
											<param name=Language						value=0>
											<param name=MaxLength					value=14>
											<param name=Numeric						value=true>
											<param name=ShowLiteral					value="false">
											<param name=Visible							value="true">
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
	                                </td>
	                                <td width="20"> </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- ��ȸ ���� ���̺� �� -->
			</td>
		</tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->

	</form>
	<!-- form �� -->

</body>
</html>