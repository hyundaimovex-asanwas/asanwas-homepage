<!--
*****************************************************
* @source       : vlui090.jsp
* @description  : ��������� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
	String eno_nm = box.getString("SESSION_ENONM");         //ǰ���ڻ��
	String dep_cd = box.getString("SESSION_DPTCD");         //ǰ���ڻ��

%>
<html>
<head>
<title>��������Է�(����)(vlui090)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";
		var cntchk = "N";
		var j=0;
		var GSTR_YYYYMM, GSTR_EMPNO, GSTR_EMPNMK, GSTR_GRPCD, GSTR_JOBGRPH, GSTR_EVASEQ,GSTR_ROWPOSITION,GSTR_PAYGRD;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

          //�˻����� 4����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //�����
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//�����
          }

	      //���� ���� ��ȸ
	      dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
	      dsT_EV_ABLRST.reset();
		  fnc_Reset('q');

	      //����� ���� ��ȸ
	      dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
	      dsT_EV_ABLRST2.reset();
		  fnc_Reset('q');


	      dsT_EV_SUBMIT.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR_STS&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
	      dsT_EV_SUBMIT.Reset();

		  if(dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"SUBMITST")=="C"){
      		document.form1.txt_SubmitSt.value="�Է¿Ϸ�";
		  }else{
			document.form1.txt_SubmitSt.value="�̿Ϸ�";
		  }

        }


        function fnc_SearchList2() {

          //�˻����� 4����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//�ش�⵵
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        							//�����

	      //���� ��ȸ
	      dsT_EV_ABLRST3.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SHR_SCR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&EMPNO="+GSTR_EMPNO+"&EVASEQ="+GSTR_EVASEQ+"&PAYGRD="+GSTR_PAYGRD;
	      dsT_EV_ABLRST3.reset();

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

          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//�ش�⵵
		  var GUBUN;
		  var TOTAL_SCR = 0;

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//�����
          }

			if (dsT_EV_ABLRST3.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {

				if(fnc_Chk()){

					if (confirm("�����Ͻðڽ��ϱ�?")) {

							for ( i=1;i<=dsT_EV_ABLRST3.countrow;i++){

								if ((dsT_EV_ABLRST3.SysStatus(i)==2)||(dsT_EV_ABLRST3.SysStatus(i)==3)){
											dsT_EV_ABLRST3.namevalue(i,"EMPNOH")=	document.form1.txtENOH_NO_SHR.value;
											dsT_EV_ABLRST3.namevalue(i,"EMPNO")	=	GSTR_EMPNO;
											dsT_EV_ABLRST3.namevalue(i,"EVASEQ")=	GSTR_EVASEQ;
										}
								TOTAL_SCR = TOTAL_SCR + dsT_EV_ABLRST3.namevalue(i,"SCR");
							}


						trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST3=dsT_EV_ABLRST3)";
            			trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SAV&REG_YM_SHR="+REG_YM_SHR+"&EMPNO="+GSTR_EMPNO+"&GUBUN="+GUBUN+"&TOTAL_SCR="+TOTAL_SCR;
						trT_EV_ABLRST.post();

						fnc_Reset('r');

						fnc_SearchList();

						fnc_SearchList2();

					}
				}
			}

		}

		/******************************************************************************
			Description : ����� ���� Grid �ʱ�ȭ
			parameter - q : query��   r -reset �ʱ�ȭ
		******************************************************************************/
		function fnc_Reset(p){

			if(p=="r"){
				if (dsT_EV_ABLRST3.countrow>=1){
					dsT_EV_ABLRST3.ClearData();
				}else{
					alert("�ʱ�ȭ �� �����Ͱ� �������� �ʽ��ϴ�.");
				}
			}else if(p=="q"){
				if (dsT_EV_ABLRST3.countrow>=1)
					dsT_EV_ABLRST3.ClearData();
			}
		}

		/******************************************************************************
			Description : Check
		******************************************************************************/
        function fnc_Chk() {

        	for (i=1;i<=dsT_EV_ABLRST3.countrow;i++){

				if (dsT_EV_ABLRST3.namevalue(i,"CHK01") == "F" && dsT_EV_ABLRST3.namevalue(i,"CHK02") == "F"
				 && dsT_EV_ABLRST3.namevalue(i,"CHK03") == "F" && dsT_EV_ABLRST3.namevalue(i,"CHK04") == "F"
				 && dsT_EV_ABLRST3.namevalue(i,"CHK05") == "F"){
							alert("��� �򰡿�Ҹ� üũ�Ͻʽÿ�");

				    dsT_EV_ABLRST3.rowposition = i;

				  	return false;

					break;

					}
				}

			return true;

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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("��������Է�(����)", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            var f = document.form1;
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';

            dsT_EV_ABLRST.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_ABLRST.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

		document.getElementById("loctitle").innerText = "HOME/�λ���/�����/";

		document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);
		document.getElementById("txtENOH_NO_SHR").value="<%=eno_no%>";
		document.getElementById("txtENOH_NM_SHR").value="<%=eno_nm%>";



        cfStyleGrid(form1.grdT_EV_ABLRST,0,"true","false");      // Grid Style ����
        cfStyleGrid(form1.grdT_EV_ABLRST2,0,"true","false");      // Grid Style ����
        cfStyleGrid(form1.grdT_EV_ABLRST3,0,"false","false");      // Grid Style ����

		<%
		    //�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
		    if(!(box.getString("SESSION_ENONO").equals("6060002") || box.getString("SESSION_ENONO").equals("1990071") || box.getString("SESSION_ENONO").equals("2020008")) ) {
		%>
		            fnc_ChangeStateElement(false, "txtENOH_NO_SHR");
		            fnc_ChangeStateElement(false, "txtENOH_NM_SHR");
		            fnc_ChangeStateElement(false, "ImgEnoNo");
		<%
		    }
		%>

        }


        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /******************************
         * 16. �ʱ�ȭ                  *
         ******************************/
        function fnc_Init() {

			 dsT_EV_ABLRST3.ClearData();

        }



		/******************************************************************************
			Description : ���� ����
			              ����� ����� ��� 9999999 �� update
										������� ���� ���� ��.
		******************************************************************************/
		function fnc_Submit(){


	        var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          	var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //�����
	      	var txt_SubmitSt = document.form1.txt_SubmitSt.value;

			if(REG_YM_SHR<'201011'){
					alert("�ش� ����� ������ �� �����ϴ�.");
					return;
			}

			 //������ �Է¿Ϸ� �� ���� ���̻� �Է¿Ϸ� ���ϰ���.
			 if(txt_SubmitSt.value=="�Է¿Ϸ�"){
					alert("�̹� �Է¿Ϸ� �Ǿ����ϴ�.");
					return;
			 }


			 if(dsT_EV_ABLRST.countrow==0 && dsT_EV_ABLRST2.countrow==0){
				  	alert("�ǰ���ڰ� �������� �ʽ��ϴ�.");
					return;
			 }

			//�ǰ���ڸ� �ϳ��� �Է����� ���� ��� �Է¿Ϸ� ���ϰ� üũ��.
			for(i=1;i<=dsT_EV_ABLRST.countrow;i++){
				if(dsT_EV_ABLRST.namevalue(i,"SCR")==0){
						alert("����Ҽ� ������� �Է��� �Ϸ� ���� �ʾҽ��ϴ�.");
						return;
				}
			}

			for(j=1;j<=dsT_EV_ABLRST2.countrow;j++){
				if(dsT_EV_ABLRST2.namevalue(j,"SCR")==0){
						alert("����ܼҼ� ������� �Է��� �Ϸ� ���� �ʾҽ��ϴ�.");
						return;
				}
			}

			//�޼����� �� �� �� üũ  �� �� �����ϸ� �� �̻� ���� �Ұ� ��.
			if(confirm("�Է¿Ϸ� �� ������ �Ұ��մϴ�. �Է¿Ϸ� �Ͻðڽ��ϱ�?")){

				    fnc_SetDataHeader();

			     	dsT_EV_SUBMIT.Addrow();

					dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"EVAYM") = REG_YM_SHR.replace("-","");
			     	dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"EMPNOH")= EMPNOH;
					dsT_EV_SUBMIT.namevalue(dsT_EV_SUBMIT.rowposition,"EMPNO") = '<%=box.get("SESSION_ENONO")%>';


					trT_EV_SUTMIT.KeyValue = "tr01(I:dsT_EV_SUBMIT=dsT_EV_SUBMIT)";
            		trT_EV_SUTMIT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui090.cmd.VLUI090CMD&S_MODE=SUBMIT";
					trT_EV_SUTMIT.post();

			}else{
					return;
			}

		//���� update (�ѱ�� ������ - ������, �ǰ���ڸ��� Ű�� �ؼ� ��� ����ڸ� 9999999, ������ ���Ƿ� ����)

		}



		/******************************************************************************
			Description : ���� ����
			              ����� ����� ��� 9999999 �� update
										������� ���� ���� ��.
		******************************************************************************/
		function fnc_SetDataHeader(){

		  dsT_EV_SUBMIT.clearAll();

			if (dsT_EV_SUBMIT.countrow<1){

				var s_temp = " EVAYM:STRING(6),EMPNOH:STRING(7),EMPNO:STRING(7)";   //������, �����, �α��� ����� ( �ǰ���� �ƴ�)

			  	dsT_EV_SUBMIT.SetDataHeader(s_temp);

			}
		}


		function fnc_ASSES(){

			for (i=1;i<=dsT_EV_ABLRST.countrow;i++){

				if(dsT_EV_ABLRST.NameValue(i,"SCR")>=85){
				  	dsT_EV_ABLRST.NameValue(i,"ASSES")="��";
				}else if(dsT_EV_ABLRST.namevalue(i,"SCR")>=75&&dsT_EV_ABLRST.namevalue(i,"SCR")<85){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="�߻�";
				}else if(dsT_EV_ABLRST.namevalue(i,"SCR")>=65&&dsT_EV_ABLRST.namevalue(i,"SCR")<75){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="��";
				}else if(dsT_EV_ABLRST.namevalue(i,"SCR")>=55&&dsT_EV_ABLRST.namevalue(i,"SCR")<65){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="����";
				}else if (dsT_EV_ABLRST.namevalue(i,"SCR")>=0&&dsT_EV_ABLRST.namevalue(i,"SCR")<55){
					dsT_EV_ABLRST.namevalue(i,"ASSES")="��";
				}
			}

		}


		/******************************************************************************
			Description : ���������ȸ
		******************************************************************************/
		function fnc_Grid_Onclick(gubun,row){

		    GSTR_YYYYMM ="";
			GSTR_EMPNO = "";
			GSTR_GRPCD = "";
			GSTR_JOBGRPH = "";
			GSTR_EVASEQ = "";
			GSTR_PAYGRD = "";

			if(gubun=="1"){
				GSTR_YYYYMM		 = dsT_EV_ABLRST.namevalue(row,"EVAYM");
				GSTR_EMPNO		 = dsT_EV_ABLRST.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST.namevalue(row,"EMPNMK");
				GSTR_GRPCD		 = dsT_EV_ABLRST.namevalue(row,"GRPCD");
				GSTR_JOBGRPH	 = dsT_EV_ABLRST.namevalue(row,"JOBGRPH");
				GSTR_EVASEQ		 = dsT_EV_ABLRST.namevalue(row,"EVASEQ");
				GSTR_PAYGRD		 = dsT_EV_ABLRST.namevalue(row,"PAYGRD");
				GSTR_ROWPOSITION = dsT_EV_ABLRST.rowposition;
			}else if(gubun=="5"){
				GSTR_YYYYMM		 = dsT_EV_ABLRST2.namevalue(row,"EVAYM");
				GSTR_EMPNO		 = dsT_EV_ABLRST2.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST2.namevalue(row,"EMPNMK");
				GSTR_GRPCD		 = dsT_EV_ABLRST2.namevalue(row,"GRPCD");
				GSTR_JOBGRPH	 = dsT_EV_ABLRST2.namevalue(row,"JOBGRPH");
				GSTR_EVASEQ		 = dsT_EV_ABLRST2.namevalue(row,"EVASEQ");
				GSTR_PAYGRD		 = dsT_EV_ABLRST2.namevalue(row,"PAYGRD");
				GSTR_ROWPOSITION = dsT_EV_ABLRST2.rowposition;
			}

			fnc_SearchList2();

		}

       /***********************
       * �����ȸ�� �˾� *
       **********************/
        function fnc_EmplPopp() {
			var obj = new String();
            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";
            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->
    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)                       |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_SUBMIT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ABLRST)        |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_EV_SUTMIT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �׸��带 Ŭ�������� ó�� �� ����                 |
    +-------------------------------------------------->
    <Script For=grdT_EV_ABLRST Event="OnClick(row,col)">
    	fnc_Grid_Onclick('1',row);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnClick(row,col)">
    	fnc_Grid_Onclick('5',row);
    </Script>


    <Script For=grdT_EV_ABLRST3 Event="OnClick(row,col)">
	if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {

		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK01") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK02") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK03") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK04") = "F";
		dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK05") = "F";

		if ("CHK01" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK01") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "1";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"ESCR");
		}else if ("CHK02" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK02") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "2";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"GSCR");
		}else if ("CHK03" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK03") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "3";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"MSCR");
		}else if ("CHK04" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK04") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "4";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"LSCR");
		}else if ("CHK05" == col) {
			dsT_EV_ABLRST3.namevalue(dsT_EV_ABLRST3.rowposition,"CHK05") = "T";
			dsT_EV_ABLRST3.namevalue(row,"SCRGBN") = "5";
			dsT_EV_ABLRST3.namevalue(row,"SCR") = dsT_EV_ABLRST3.namevalue(row,"PSCR");
		}
	}
    </Script>



	<script language=JavaScript  for=dsT_EV_ABLRST event=OnLoadCompleted(rowcount)>
	  	fnc_ASSES(); //��
	</script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <script for=trT_EV_SUBMIT event="OnSuccess()">
            alert("�Է¿Ϸ� �Ͽ����ϴ�.");
            fnc_Submit_St();
    </script>
    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
            cfErrorMsg(this);
    </script>

    <script for=trT_EV_SUBMIT event="OnFail()">
            alert("�Է¿Ϸ� ���� ���߽��ϴ�.");
    </script>
<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
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
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������Է�(����)</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">��������Է�(����)</font></td>
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
        	<FONT SIZE="2" COLOR="#3300FF" style="position:relative;top:0px">������� �Է� �� ���� [�Է¿Ϸ�]�ϼž� �մϴ�.</FONT>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_InputcompleteOver.gif',1)"><img src="/images/button/btn_InputcompleteOn.gif" name="Image1" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
	                            <col width="60"></col>
	                            <col width="50"></col>
	                            <col width="50"></col>
	                            <col width="140"></col>
	                            <col width="60"></col>
	                            <col width="140"></col>
	                            <col width="100"></col>
	                            <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">�����</td>
                                <td class="padding2423">
                                    <input id=txtENOH_NO_SHR name=txtENOH_NO_SHR size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR');">
                                    <input id=txtENOH_NM_SHR name=txtENOH_NM_SHR size="6" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENOH_NM_SHR', 'txtENOH_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENOH_NM_SHR', 'txtENOH_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENOH_NO_SHR','txtENOH_NM_SHR')"></a>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423" >
                                    <fieldset style="width:150px">
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" value="0">������
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="1">�����
                                    </fieldset>
                                </td>
                                <td align="right" class="searchState">�������</td>
                                <td class="padding2423">
                                    <input id=txt_SubmitSt name=id=txt_SubmitSt type="text" size="7"  maxlength="7" disabled>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
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
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:200px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="false">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=1>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='DEPTNM'    	width=110  	name='����:�Ҽ�'    align=left      edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PAYGRDNM'   	width=70  	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText='�� ��'</FC>
                                    <FC> id='EMPNMK'   		width=70  	name='�ǰ����'   	align=center    edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='SCR'    		width=60   	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(SCR),2)}</FC>
                                    <FC> id='ASSES'    		width=60   	name='��'      	align=center    edit=none sumbgcolor=#89add6</FC>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:200px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST2">
                                <param name="EdiTABLE"               value="false">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=1>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='DEPTNM'    	width=110  	name='�����:�Ҽ�'  align=left      edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PAYGRDNM'   	width=70  	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText='�� ��'</FC>
                                    <FC> id='EMPNMK'   		width=70  	name='�ǰ����'   	align=center    edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='SCR'    		width=60   	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(SCR),2)}</FC>
                                    <FC> id='ASSES'    		width=60   	name='��'      	align=center    edit=none sumbgcolor=#89add6</FC>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>

            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align=right><nobr>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_Clear.gif',1)"><img src="/images/button/btn_Clear.gif" name="Image4"  border="0" align="absmiddle" onClick="fnc_Init()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
					</tr>
                    <tr align="center">
                        <td colspan=4>
                            <comment id="__NSID__">
                            <object id="grdT_EV_ABLRST3" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:385px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST3">
                                <param name="EdiTABLE"               value="false">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=1>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='DIVNM'     		width=50   	name='����'    		align=center    sumbgcolor=#89add6</FC>
	                                <FC> id='PRTSEQ'    		width=30   	name='����'   		align=center    sumbgcolor=#89add6</FC>
	                                <FC> id='ASKITEM'   		width=100  	name='�򰡿��'  	align=left      sumbgcolor=#89add6 SumText='�� ��'</FC>
		                            <FG>name='���'    	HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <C>id='CHK01'    		width=30  	name='Ź��'     	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK02'   		width=30  	name='���'      	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK03'   		width=30  	name='����'   		align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK04'    		width=30   	name='����'      	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
	                                    <C>id='CHK05'    		width=30   	name='����'      	align=center    EditStyle=CheckBox sumbgcolor=#89add6 dec=2</C>
                                    </FG>
	                                <FC> id='SCR'   			width=40  	name='����'  		align=center    sumbgcolor=#89add6 SumText=@sum</FC>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
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


